Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58BB2430163
	for <lists+linux-pci@lfdr.de>; Sat, 16 Oct 2021 11:06:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235043AbhJPJIs (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 16 Oct 2021 05:08:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234999AbhJPJIs (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 16 Oct 2021 05:08:48 -0400
Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [IPv6:2a01:4f8:150:2161:1:b009:f23e:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 475CDC061570
        for <linux-pci@vger.kernel.org>; Sat, 16 Oct 2021 02:06:40 -0700 (PDT)
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "RapidSSL TLS DV RSA Mixed SHA256 2020 CA-1" (verified OK))
        by bmailout3.hostsharing.net (Postfix) with ESMTPS id 4F7F8100AF7F4;
        Sat, 16 Oct 2021 11:06:36 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 24106276E19; Sat, 16 Oct 2021 11:06:36 +0200 (CEST)
Date:   Sat, 16 Oct 2021 11:06:36 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Sinan Kaya <okaya@kernel.org>, Ashok Raj <ashok.raj@intel.com>,
        Keith Busch <kbusch@kernel.org>,
        Yicong Yang <yangyicong@hisilicon.com>,
        linux-pci@vger.kernel.org, Russell Currey <ruscur@russell.cc>,
        Oliver OHalloran <oohall@gmail.com>,
        Stuart Hayes <stuart.w.hayes@gmail.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Oza Pawandeep <poza@codeaurora.org>
Subject: Re: [PATCH 0/4] pciehp error recovery fix + cleanups
Message-ID: <20211016090636.GA31246@wunner.de>
References: <cover.1627638184.git.lukas@wunner.de>
 <20211015192916.GA2150101@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211015192916.GA2150101@bhelgaas>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Oct 15, 2021 at 02:29:16PM -0500, Bjorn Helgaas wrote:
> On Sat, Jul 31, 2021 at 02:39:00PM +0200, Lukas Wunner wrote:
> > One fix for a pciehp error recovery issue spotted by Stuart
> > plus three cleanups.  Please review and test.  Thanks!
> > 
> > Lukas Wunner (4):
> >   PCI: pciehp: Ignore Link Down/Up caused by error-induced Hot Reset
> >   PCI/portdrv: Remove unused resume err_handler
> >   PCI/portdrv: Remove unused pcie_port_bus_{,un}register() declarations
> >   PCI/ERR: Reduce compile time for CONFIG_PCIEAER=n
> 
> Applied to pci/hotplug for v5.16, thanks!
> 
> I split off the pm_iter() to its own patch at the beginning.

Thanks a lot, I wouldn't have gotten around to respinning the series
until in a couple of days, so it's helpful that you took over.

The lkp robot reported a trivial build issue caused by a dangling
'#ifdef CONFIG_PCI_ERROR_RECOVERY'.  If you could squash the below
fix into the top-most commit on the branch I'd be grateful.  Thanks!

-- >8 --
diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
index 4d3f0e2..b0923bd 100644
--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -1542,7 +1542,7 @@ static int pci_uevent(struct device *dev, struct kobj_uevent_env *env)
 	return 0;
 }
 
-#ifdef CONFIG_PCI_ERROR_RECOVERY
+#if defined(CONFIG_PCIEAER) || defined(CONFIG_EEH)
 /**
  * pci_uevent_ers - emit a uevent during recovery path of PCI device
  * @pdev: PCI device undergoing error recovery
