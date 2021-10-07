Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C7924255B0
	for <lists+linux-pci@lfdr.de>; Thu,  7 Oct 2021 16:42:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242110AbhJGOoD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 7 Oct 2021 10:44:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:49454 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242135AbhJGOoC (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 7 Oct 2021 10:44:02 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F13AD60F4C;
        Thu,  7 Oct 2021 14:42:08 +0000 (UTC)
Received: from sofa.misterjones.org ([185.219.108.64] helo=why.misterjones.org)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <maz@kernel.org>)
        id 1mYUb0-00FL4P-SG; Thu, 07 Oct 2021 15:42:06 +0100
Date:   Thu, 07 Oct 2021 15:42:06 +0100
Message-ID: <875yu8rj5t.wl-maz@kernel.org>
From:   Marc Zyngier <maz@kernel.org>
To:     Rui Salvaterra <rsalvaterra@gmail.com>
Cc:     tglx@linutronix.de, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [REGRESSION][BISECTED] 5.15-rc1: Broken AHCI on NVIDIA ION (MCP79)
In-Reply-To: <CALjTZvZZf25tqoQWM_HsBb84JgKpMKAxqfhUdpD_e5M-Bc_yzA@mail.gmail.com>
References: <CALjTZvbzYfBuLB+H=fj2J+9=DxjQ2Uqcy0if_PvmJ-nU-qEgkg@mail.gmail.com>
        <87ee8yquyi.wl-maz@kernel.org>
        <CALjTZvakX8Hz+ow3UeAuQiicVXtbkXEDFnHU-+n8Ts6i1LRyHQ@mail.gmail.com>
        <87bl41qkrh.wl-maz@kernel.org>
        <CALjTZvbsvsD6abpw0H5D4ngUXPrgM2mDV0DX5BQi0z8cd-yxzA@mail.gmail.com>
        <878rz5qbee.wl-maz@kernel.org>
        <CALjTZvZZf25tqoQWM_HsBb84JgKpMKAxqfhUdpD_e5M-Bc_yzA@mail.gmail.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) SEMI-EPG/1.14.7 (Harue)
 FLIM-LB/1.14.9 (=?UTF-8?B?R29qxY0=?=) APEL-LB/10.8 EasyPG/1.0.0 Emacs/27.1
 (x86_64-pc-linux-gnu) MULE/6.0 (HANACHIRUSATO)
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: rsalvaterra@gmail.com, tglx@linutronix.de, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, 07 Oct 2021 14:11:51 +0100,
Rui Salvaterra <rsalvaterra@gmail.com> wrote:
> 
> Hi again, Marc,
> 
> On Thu, 7 Oct 2021 at 13:15, Marc Zyngier <maz@kernel.org> wrote:
> >
> > 'Believe' is not a word I'd use. I know for a fact that all HW,
> > whether it is present, past or future is only a pile of hacks.
> >
> > Given that your report tends to indicate that we fail to enable the
> > interrupt for this device, this would be a possibility.
> 
> Heh. Guess what? The AHCI controller is lying throught its teeth. Your
> hack fixes boot for me. Everything seems to be working, even with such
> a big hammer.

Right. Let's see if we can be less brutal and only quirk the AHCI
device (patch below, completely untested). I'm a bit concerned that
all the devices in this system seem to report 'Maskable-'...

	M.

diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
index 0099a00af361..2f9ec7210991 100644
--- a/drivers/pci/msi.c
+++ b/drivers/pci/msi.c
@@ -479,6 +479,9 @@ msi_setup_entry(struct pci_dev *dev, int nvec, struct irq_affinity *affd)
 		goto out;
 
 	pci_read_config_word(dev, dev->msi_cap + PCI_MSI_FLAGS, &control);
+	/* Lies, damned lies, and MSIs */
+	if (dev->dev_flags & PCI_DEV_FLAGS_HAS_MSI_MASKING)
+		control |= PCI_MSI_FLAGS_MASKBIT;
 
 	entry->msi_attrib.is_msix	= 0;
 	entry->msi_attrib.is_64		= !!(control & PCI_MSI_FLAGS_64BIT);
diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 4537d1ea14fd..dc7741431bf3 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -5795,3 +5795,9 @@ static void apex_pci_fixup_class(struct pci_dev *pdev)
 }
 DECLARE_PCI_FIXUP_CLASS_HEADER(0x1ac1, 0x089a,
 			       PCI_CLASS_NOT_DEFINED, 8, apex_pci_fixup_class);
+
+static void nvidia_ion_ahci_fixup(struct pci_dev *pdev)
+{
+	pdev->dev_flags |= PCI_MSI_FLAGS_MASKBIT;
+}
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_NVIDIA, 0x0ab8, nvidia_ion_ahci_fixup);
diff --git a/include/linux/pci.h b/include/linux/pci.h
index cd8aa6fce204..152a4d74f87f 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -233,6 +233,8 @@ enum pci_dev_flags {
 	PCI_DEV_FLAGS_NO_FLR_RESET = (__force pci_dev_flags_t) (1 << 10),
 	/* Don't use Relaxed Ordering for TLPs directed at this device */
 	PCI_DEV_FLAGS_NO_RELAXED_ORDERING = (__force pci_dev_flags_t) (1 << 11),
+	/* Device does honor MSI masking despite saying otherwise */
+	PCI_DEV_FLAGS_HAS_MSI_MASKING = (__force pci_dev_flags_t) (1 << 12),
 };
 
 enum pci_irq_reroute_variant {


-- 
Without deviation from the norm, progress is not possible.
