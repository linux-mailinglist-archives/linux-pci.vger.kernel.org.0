Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 960FA2D44EE
	for <lists+linux-pci@lfdr.de>; Wed,  9 Dec 2020 15:59:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732059AbgLIO56 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 9 Dec 2020 09:57:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:55090 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387425AbgLIO5t (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 9 Dec 2020 09:57:49 -0500
Date:   Wed, 9 Dec 2020 08:57:07 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607525828;
        bh=iTwvXXnNY8aakokY+O/GwFNWyTbTvNVpehJRfYDnYu4=;
        h=From:To:Cc:Subject:In-Reply-To:From;
        b=PgResuRHgX8BL6OvxTlRKixNbfNmOOYAaTcMCAPpD9hD27OwxS7EslC/oc4dmMzTG
         gNE2p3xDEu+n8J97Wt8jAmzVulOVYFkh8+0F2Ut1oGplaU4UaLH3eKduV+PkklUCGY
         anDk/8qDx93bCRI1MjMT+Vu/YD/jxhGCCgpYkxmU8f64r5+pPDa2zUCPRV/3MMTpbZ
         tmDQh7fvNMDLvXluAb697neJzRoW3BAsL1n7+PqjwQUtKvU6itjziytBDRTFsVdpAi
         LaGz42BaL1xELQ4w5m+65L0L7anLj/yeCVR+nNy8i9liOjHkqst9m7RdvbP56FQvzJ
         i9Z4RIUeg40aA==
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Michael Walle <michael@walle.cc>
Cc:     lorenzo.pieralisi@arm.com, kw@linux.com, heiko@sntech.de,
        benh@kernel.crashing.org, shawn.lin@rock-chips.com,
        paulus@samba.org, thomas.petazzoni@bootlin.com, jonnyc@amazon.com,
        toan@os.amperecomputing.com, will@kernel.org, robh@kernel.org,
        f.fainelli@gmail.com, mpe@ellerman.id.au, michal.simek@xilinx.com,
        linux-rockchip@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com, jonathan.derrick@intel.com,
        linux-pci@vger.kernel.org, rjui@broadcom.com,
        linux-rpi-kernel@lists.infradead.org, Jonathan.Cameron@huawei.com,
        bhelgaas@google.com, linux-arm-kernel@lists.infradead.org,
        sbranden@broadcom.com, wangzhou1@hisilicon.com,
        rrichter@marvell.com, linuxppc-dev@lists.ozlabs.org,
        nsaenzjulienne@suse.de, Vladimir Oltean <olteanv@gmail.com>,
        Alexandru Marginean <alexm.osslist@gmail.com>
Subject: Re: [PATCH v6 0/5] PCI: Unify ECAM constants in native PCI Express
 drivers
Message-ID: <20201209145707.GA2521966@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <595028ce6b04ea589f802ff61d8710f0@walle.cc>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Dec 09, 2020 at 02:08:00PM +0100, Michael Walle wrote:
> [+ Vladimir and Alex]
> 
> Am 2020-12-09 13:36, schrieb Bjorn Helgaas:
> > On Tue, Dec 08, 2020 at 04:41:50PM +0100, Michael Walle wrote:
> > > >On Sun, 29 Nov 2020 23:07:38 +0000, Krzysztof Wilczyński wrote:
> > > >> Unify ECAM-related constants into a single set of standard constants
> > > >> defining memory address shift values for the byte-level address that can
> > > >> be used when accessing the PCI Express Configuration Space, and then
> > > >> move native PCI Express controller drivers to use newly introduced
> > > >> definitions retiring any driver-specific ones.
> > > >>
> > > >> The ECAM ("Enhanced Configuration Access Mechanism") is defined by the
> > > >> PCI Express specification (see PCI Express Base Specification, Revision
> > > >> 5.0, Version 1.0, Section 7.2.2, p. 676), thus most hardware should
> > > >> implement it the same way.
> > > >>
> > > >> [...]
> > > >
> > > >Applied to pci/ecam, thanks!
> > > >
> > > >[1/5] PCI: Unify ECAM constants in native PCI Express drivers
> > > >      https://git.kernel.org/lpieralisi/pci/c/f3c07cf692
> > 
> > > Patch 1/5 breaks LS1028A boards:
> > > 
> > > [..]
> > > [    1.144426] pci-host-generic 1f0000000.pcie: host bridge
> > > /soc/pcie@1f0000000 ranges:
> > > [    1.152276] pci-host-generic 1f0000000.pcie:      MEM
> > > 0x01f8000000..0x01f815ffff -> 0x0000000000
> > > [    1.161161] pci-host-generic 1f0000000.pcie:      MEM
> > > 0x01f8160000..0x01f81cffff -> 0x0000000000
> > > [    1.170043] pci-host-generic 1f0000000.pcie:      MEM
> > > 0x01f81d0000..0x01f81effff -> 0x0000000000
> > > [    1.178924] pci-host-generic 1f0000000.pcie:      MEM
> > > 0x01f81f0000..0x01f820ffff -> 0x0000000000
> > > [    1.187805] pci-host-generic 1f0000000.pcie:      MEM
> > > 0x01f8210000..0x01f822ffff -> 0x0000000000
> > > [    1.196686] pci-host-generic 1f0000000.pcie:      MEM
> > > 0x01f8230000..0x01f824ffff -> 0x0000000000
> > > [    1.205562] pci-host-generic 1f0000000.pcie:      MEM
> > > 0x01fc000000..0x01fc3fffff -> 0x0000000000
> > 
> > Can you attach your DT?
> That would be the following:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28-var3-ads2.dts
> 
> You'll find the PCI devices/bridge in:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
> 
> > The fact that all these windows map to PCI
> > bus address 0 looks broken.  Prior to patch 1/5, do the devices below
> > this bridge actually work?
> 
> Yes, these should be the onboard network controller and ethernet
> switch.

Interesting.  I can't see how they could work with those address
mappings, but that's another question we can look at later.

> > Looks like you're using the pci-host-generic driver; which of the
> > .compatible strings (pci-host-cam-generic, pci-host-ecam-generic,
> > marvell,armada8k-pcie-ecam, etc) are you using?  (I think that's in
> > the DT as well.)
> 
> compatible = "pci-host-ecam-generic";
> -michael

Can you try the following just to get started?

diff --git a/drivers/pci/access.c b/drivers/pci/access.c
index 46935695cfb9..569a45727bc7 100644
--- a/drivers/pci/access.c
+++ b/drivers/pci/access.c
@@ -79,6 +79,7 @@ int pci_generic_config_read(struct pci_bus *bus, unsigned int devfn,
 {
 	void __iomem *addr;
 
+	pci_info(bus, "%s(%#x %#05x %d)\n", __func__, devfn, where, size);
 	addr = bus->ops->map_bus(bus, devfn, where);
 	if (!addr) {
 		*val = ~0;
@@ -101,6 +102,7 @@ int pci_generic_config_write(struct pci_bus *bus, unsigned int devfn,
 {
 	void __iomem *addr;
 
+	pci_info(bus, "%s(%#x %#05x %d)\n", __func__, devfn, where, size);
 	addr = bus->ops->map_bus(bus, devfn, where);
 	if (!addr)
 		return PCIBIOS_DEVICE_NOT_FOUND;
diff --git a/drivers/pci/ecam.c b/drivers/pci/ecam.c
index 59f91d434859..78f776e590be 100644
--- a/drivers/pci/ecam.c
+++ b/drivers/pci/ecam.c
@@ -33,6 +33,8 @@ struct pci_config_window *pci_ecam_create(struct device *dev,
 	struct resource *conflict;
 	int i, err;
 
+	dev_info(dev, "%s cfg %pR bus %pR\n", __func__, cfgres, busr);
+
 	if (busr->start > busr->end)
 		return ERR_PTR(-EINVAL);
 
@@ -85,6 +87,9 @@ struct pci_config_window *pci_ecam_create(struct device *dev,
 			goto err_exit_iomap;
 	}
 
+	dev_info(dev, "%s per_bus_mapping %d win %px\n", __func__,
+		 per_bus_mapping, cfg->win);
+
 	if (ops->init) {
 		err = ops->init(cfg);
 		if (err)
@@ -140,6 +145,8 @@ void __iomem *pci_ecam_map_bus(struct pci_bus *bus, unsigned int devfn,
 	if (busn < cfg->busr.start || busn > cfg->busr.end)
 		return NULL;
 
+	pci_info(bus, "%s(%#x %#05x): %pR\n", __func__, devfn, where,
+		 &cfg->busr);
 	busn -= cfg->busr.start;
 	if (per_bus_mapping) {
 		base = cfg->winp[busn];
@@ -147,6 +154,8 @@ void __iomem *pci_ecam_map_bus(struct pci_bus *bus, unsigned int devfn,
 	} else
 		base = cfg->win;
 
+	pci_info(bus, "%s base %px bus_shift %d\n", __func__, base,
+		 cfg->ops->bus_shift);
 	if (cfg->ops->bus_shift) {
 		bus_offset = (busn & PCIE_ECAM_BUS_MASK) << bus_shift;
 		devfn_offset = (devfn & PCIE_ECAM_DEVFN_MASK) << devfn_shift;
