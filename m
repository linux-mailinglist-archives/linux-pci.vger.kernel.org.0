Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FB8A4302FC
	for <lists+linux-pci@lfdr.de>; Sat, 16 Oct 2021 16:23:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244397AbhJPOZO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 16 Oct 2021 10:25:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:32866 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235901AbhJPOZO (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 16 Oct 2021 10:25:14 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 17644611C1;
        Sat, 16 Oct 2021 14:23:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634394186;
        bh=5n2DJJMekEjV2RLZzQacMdubR9eP22+Ip7ff5a/EyXA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=fEzhuLooho9OxniMuV2R0f/oglv+5z/Zkdu8o72VrHax8iU1DSayVgzb92d6zT4Ko
         P+PpfUMmSXcQpnOW5AZADRZ+u3Pfr8v4ASo0nf/C7ZJp4a6fWzHCjK6a/CEeUZA48r
         DvVhE4aLcqdu17J1Mshna7Qp5a0IaNTw7FRguvydRvsF1P1omdqkeuK1ubJ3R+eneH
         W7PTsBgMa7p7nNr2iWiRXHJ/c8ZMzTMVIIrQGnDsoFitge/HKxtOwfkxwIO4RRKB8r
         FC3bAGttMrZFgANrtGZzuLwmGQuDtLs28ZbtQK5BDq3GCVrn0J6WoMGpwCx2UE6zUc
         KDRmuhMYpUcsA==
Date:   Sat, 16 Oct 2021 09:23:04 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Lukas Wunner <lukas@wunner.de>
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
Message-ID: <20211016142304.GA2178080@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211016090636.GA31246@wunner.de>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, Oct 16, 2021 at 11:06:36AM +0200, Lukas Wunner wrote:
> On Fri, Oct 15, 2021 at 02:29:16PM -0500, Bjorn Helgaas wrote:
> > On Sat, Jul 31, 2021 at 02:39:00PM +0200, Lukas Wunner wrote:
> > > One fix for a pciehp error recovery issue spotted by Stuart
> > > plus three cleanups.  Please review and test.  Thanks!
> > > 
> > > Lukas Wunner (4):
> > >   PCI: pciehp: Ignore Link Down/Up caused by error-induced Hot Reset
> > >   PCI/portdrv: Remove unused resume err_handler
> > >   PCI/portdrv: Remove unused pcie_port_bus_{,un}register() declarations
> > >   PCI/ERR: Reduce compile time for CONFIG_PCIEAER=n
> > 
> > Applied to pci/hotplug for v5.16, thanks!
> > 
> > I split off the pm_iter() to its own patch at the beginning.
> 
> Thanks a lot, I wouldn't have gotten around to respinning the series
> until in a couple of days, so it's helpful that you took over.
> 
> The lkp robot reported a trivial build issue caused by a dangling
> '#ifdef CONFIG_PCI_ERROR_RECOVERY'.  If you could squash the below
> fix into the top-most commit on the branch I'd be grateful.  Thanks!

Oops, sorry, my fault!  Thanks a lot, I squashed this in.  Updated
patch appended.

> -- >8 --
> diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
> index 4d3f0e2..b0923bd 100644
> --- a/drivers/pci/pci-driver.c
> +++ b/drivers/pci/pci-driver.c
> @@ -1542,7 +1542,7 @@ static int pci_uevent(struct device *dev, struct kobj_uevent_env *env)
>  	return 0;
>  }
>  
> -#ifdef CONFIG_PCI_ERROR_RECOVERY
> +#if defined(CONFIG_PCIEAER) || defined(CONFIG_EEH)
>  /**
>   * pci_uevent_ers - emit a uevent during recovery path of PCI device
>   * @pdev: PCI device undergoing error recovery

commit f9a6c8ad4922 ("PCI/ERR: Reduce compile time for CONFIG_PCIEAER=n")
Author: Lukas Wunner <lukas@wunner.de>
Date:   Sat Jul 31 14:39:04 2021 +0200

    PCI/ERR: Reduce compile time for CONFIG_PCIEAER=n
    
    The sole non-static function in err.c, pcie_do_recovery(), is only
    called from:
    
    * aer.c (if CONFIG_PCIEAER=y)
    * dpc.c (if CONFIG_PCIE_DPC=y, which depends on CONFIG_PCIEAER)
    * edr.c (if CONFIG_PCIE_EDR=y, which depends on CONFIG_PCIE_DPC)
    
    Thus, err.c need not be compiled if CONFIG_PCIEAER=n.
    
    Also, pci_uevent_ers() and pcie_clear_device_status(), which are called
    from err.c, can be #ifdef'ed away unless CONFIG_PCIEAER=y.
    
    Since x86_64_defconfig doesn't enable CONFIG_PCIEAER, this change may
    slightly reduce compile time for anyone doing a test build with that
    config.
    
    Link: https://lore.kernel.org/r/98f9041151268c1c035ab64cca320ad86803f64a.1627638184.git.lukas@wunner.de
    Signed-off-by: Lukas Wunner <lukas@wunner.de>
    Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
index 2761ab86490d..b0923bdcdb2e 100644
--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -1542,7 +1542,7 @@ static int pci_uevent(struct device *dev, struct kobj_uevent_env *env)
 	return 0;
 }
 
-#if defined(CONFIG_PCIEPORTBUS) || defined(CONFIG_EEH)
+#if defined(CONFIG_PCIEAER) || defined(CONFIG_EEH)
 /**
  * pci_uevent_ers - emit a uevent during recovery path of PCI device
  * @pdev: PCI device undergoing error recovery
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index ce2ab62b64cf..e9d95189c79b 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -2218,6 +2218,7 @@ int pci_set_pcie_reset_state(struct pci_dev *dev, enum pcie_reset_state state)
 }
 EXPORT_SYMBOL_GPL(pci_set_pcie_reset_state);
 
+#ifdef CONFIG_PCIEAER
 void pcie_clear_device_status(struct pci_dev *dev)
 {
 	u16 sta;
@@ -2225,6 +2226,7 @@ void pcie_clear_device_status(struct pci_dev *dev)
 	pcie_capability_read_word(dev, PCI_EXP_DEVSTA, &sta);
 	pcie_capability_write_word(dev, PCI_EXP_DEVSTA, sta);
 }
+#endif
 
 /**
  * pcie_clear_root_pme_status - Clear root port PME interrupt status.
diff --git a/drivers/pci/pcie/Makefile b/drivers/pci/pcie/Makefile
index b2980db88cc0..5783a2f79e6a 100644
--- a/drivers/pci/pcie/Makefile
+++ b/drivers/pci/pcie/Makefile
@@ -2,12 +2,12 @@
 #
 # Makefile for PCI Express features and port driver
 
-pcieportdrv-y			:= portdrv_core.o portdrv_pci.o err.o rcec.o
+pcieportdrv-y			:= portdrv_core.o portdrv_pci.o rcec.o
 
 obj-$(CONFIG_PCIEPORTBUS)	+= pcieportdrv.o
 
 obj-$(CONFIG_PCIEASPM)		+= aspm.o
-obj-$(CONFIG_PCIEAER)		+= aer.o
+obj-$(CONFIG_PCIEAER)		+= aer.o err.o
 obj-$(CONFIG_PCIEAER_INJECT)	+= aer_inject.o
 obj-$(CONFIG_PCIE_PME)		+= pme.o
 obj-$(CONFIG_PCIE_DPC)		+= dpc.o
