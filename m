Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD14B23160A
	for <lists+linux-pci@lfdr.de>; Wed, 29 Jul 2020 01:06:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730191AbgG1XGI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 28 Jul 2020 19:06:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:50550 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730323AbgG1XGG (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 28 Jul 2020 19:06:06 -0400
Received: from localhost (mobile-166-175-62-240.mycingular.net [166.175.62.240])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2A2FD207FC;
        Tue, 28 Jul 2020 23:06:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595977565;
        bh=B+2S5YhP4tk2MBOwTpLzH1FWv0DJxUuyH1vXMpqRmAE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=yZc7OgrKqign9LaIBGmAgropcpP8jWuRJsqn/dRYetPxrtP750S30CTfAIjXJ3ubk
         dZr37R2yv2gSUpF1EVS6ENca2qEcU3t1wVFRX2GYVjcIB1jUhSHNjw9eStZ3ypjd5j
         yXBy+Fu3j4kPPW+bV53R3O29MQ8EnsKlIljlI/C0=
Date:   Tue, 28 Jul 2020 18:06:03 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     James Ettle <james@ettle.org.uk>
Cc:     =?utf-8?B?5ZCz5piK5r6E?= Ricky <ricky_wu@realtek.com>,
        Rui Feng <rui_feng@realsil.com.cn>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Len Brown <lenb@kernel.org>,
        Puranjay Mohan <puranjay12@gmail.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jacopo De Simoi <wilderkde@gmail.com>
Subject: Re: rtsx_pci not restoring ASPM state after suspend/resume
Message-ID: <20200728230603.GA1870954@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e051ac790380f04be4eec6937032b7dcd411ec77.camel@ettle.org.uk>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jul 28, 2020 at 09:57:55PM +0100, James Ettle wrote:
> On Mon, 2020-07-27 at 16:47 -0500, Bjorn Helgaas wrote:
> > 
> > I don't see anything in rtsx that enables L0s.  Can you collect
> > the dmesg log when booting with "pci=earlydump"?  That will show
> > whether the BIOS left it this way.  The PCI core isn't supposed to
> > do this, so if it did, we need to fix that.
> 
> dmesg log attached to the bugzilla as:
> 
> https://bugzilla.kernel.org/attachment.cgi?id=290655

Thank you!  BIOS left the Root Port and both Endpoints with L1 enabled
but L0s disabled.

Next question is how L0s got enabled.  We don't see anything in the
driver that does that.  And lspci claims L0s was enabled on the
Endpoints even without any udev or other manual fiddling.

I tried to deduce the problem from the code in aspm.c, but I didn't
see the problem.  If you have the ability to build a kernel with a
debug patch, can you boot with the patch below and collect the dmesg
log?

FWIW, here's the analysis of the earlydump output that shows L0s
disabled:

  #define PCI_CAPABILITY_LIST     0x34
  #define  PCI_CAP_ID_MSI         0x05
  #define  PCI_CAP_ID_EXP         0x10    /* PCI Express */
  #define PCI_EXP_LNKCTL          16
  #define  PCI_EXP_LNKCTL_ASPM_L0S 0x0001
  #define  PCI_EXP_LNKCTL_ASPM_L1  0x0002
  #define  PCI_EXP_LNKCTL_CCC     0x0040
  #define  PCI_EXP_LNKCTL_CLKREQ_EN 0x0100

  00:1d.0:
    0034: 40        Offset of first capability
    0040: 8010      PCIe capability ID, next cap at 0x80
    0050: 0042      PCIe Link Control: CCC L1
  01:00.0:
    0034: 40        Offset of first capability
    0040: 7005      MSI capability ID (0x05), next cap at 0x70
    0070: b010      PCIe capability ID (0x10), next cap at 0xb0
    0080: 0142      PCIe Link Control: CLKREQ_EN CCC L1
  01:00.1:
    0034: 40        Offset of first capability
    0040: 7005      MSI capability ID (0x05), next cap at 0x70
    0070: b010      PCIe capability ID (0x10), next cap at 0xb0
    0080: 0142      PCIe Link Control: CLKREQ_EN CCC L1


commit 555db6d25963 ("debug")
Author: Bjorn Helgaas <bhelgaas@google.com>
Date:   Tue Jul 28 17:52:58 2020 -0500

    debug
    

diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index b17e5ffd31b1..262f35883a2a 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -577,6 +577,11 @@ static void pcie_aspm_cap_init(struct pcie_link_state *link, int blacklist)
 	pcie_get_aspm_reg(parent, &upreg);
 	pcie_get_aspm_reg(child, &dwreg);
 
+	pci_info(parent, "%s support %x enabled %x\n", __func__, upreg.support,
+		 upreg.enabled);
+	pci_info(child, "%s support %x enabled %x\n", __func__, dwreg.support,
+		 dwreg.enabled);
+
 	/*
 	 * Setup L0s state
 	 *
@@ -629,6 +634,10 @@ static void pcie_aspm_cap_init(struct pcie_link_state *link, int blacklist)
 	/* Setup initial capable state. Will be updated later */
 	link->aspm_capable = link->aspm_support;
 
+	pci_info(parent, "%s link support %x enabled %x capable %x default %x disable %x\n",
+		 __func__, link->aspm_support, link->aspm_enabled,
+		 link->aspm_capable, link->aspm_default, link->aspm_disable);
+
 	/* Get and check endpoint acceptable latencies */
 	list_for_each_entry(child, &linkbus->devices, bus_list) {
 		u32 reg32, encoding;
@@ -744,6 +753,7 @@ static void pcie_config_aspm_l1ss(struct pcie_link_state *link, u32 state)
 
 static void pcie_config_aspm_dev(struct pci_dev *pdev, u32 val)
 {
+	pci_info(pdev, "%s set state %x\n", __func__, val);
 	pcie_capability_clear_and_set_word(pdev, PCI_EXP_LNKCTL,
 					   PCI_EXP_LNKCTL_ASPMC, val);
 }
@@ -754,6 +764,9 @@ static void pcie_config_aspm_link(struct pcie_link_state *link, u32 state)
 	struct pci_dev *child = link->downstream, *parent = link->pdev;
 	struct pci_bus *linkbus = parent->subordinate;
 
+	pci_info(parent, "%s requesting state %x (%s)\n", __func__,
+		 state, policy_str[state]);
+
 	/* Enable only the states that were not explicitly disabled */
 	state &= (link->aspm_capable & ~link->aspm_disable);
 
@@ -767,6 +780,10 @@ static void pcie_config_aspm_link(struct pcie_link_state *link, u32 state)
 		state |= (link->aspm_enabled & ASPM_STATE_L1_SS_PCIPM);
 	}
 
+	pci_info(parent, "%s link support %x enabled %x capable %x default %x disable %x\n",
+		 __func__, link->aspm_support, link->aspm_enabled,
+		 link->aspm_capable, link->aspm_default, link->aspm_disable);
+
 	/* Nothing to do if the link is already in the requested state */
 	if (link->aspm_enabled == state)
 		return;
