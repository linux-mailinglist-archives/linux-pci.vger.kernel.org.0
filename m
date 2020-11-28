Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 396BA2C72AE
	for <lists+linux-pci@lfdr.de>; Sat, 28 Nov 2020 23:09:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729309AbgK1VuP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 28 Nov 2020 16:50:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:47386 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730247AbgK1Sih (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 28 Nov 2020 13:38:37 -0500
Received: from localhost (129.sub-72-107-112.myvzw.com [72.107.112.129])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6F6C7246B3;
        Sat, 28 Nov 2020 18:35:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606588517;
        bh=krTdbHrGkcM5b4jd6jHl8Tj811g2BH+q5E0PPQ5iuP0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=1jrPlXwe9ILXjItuxz9/t8GxK/MQWxNWJOUaEYGpQxD/dpPAvMyX7cm238YUlf00x
         fHRZCbCx0lc5oMXtSJwlHxgRyLQ/pw3uzuTM/N5JKgpY4OaW4UK2qgOYpegf41sOes
         cUU2tZ7iHNR/qc/5tVYNCHGtRQlEtP0Dti16ubIY=
Date:   Sat, 28 Nov 2020 12:35:16 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, Rob Herring <robh@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Jonathan Chocron <jonnyc@amazon.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Zhou Wang <wangzhou1@hisilicon.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Will Deacon <will@kernel.org>,
        Robert Richter <rrichter@marvell.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Toan Le <toan@os.amperecomputing.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Jonathan Derrick <jonathan.derrick@intel.com>,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, linux-rockchip@lists.infradead.org,
        linux-rpi-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com
Subject: Re: [PATCH v5] PCI: Unify ECAM constants in native PCI Express
 drivers
Message-ID: <20201128183516.GA897329@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201127104626.3979165-1-kw@linux.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Nov 27, 2020 at 10:46:26AM +0000, Krzysztof Wilczyński wrote:
> Unify ECAM-related constants into a single set of standard constants
> defining memory address shift values for the byte-level address that can
> be used when accessing the PCI Express Configuration Space, and then
> move native PCI Express controller drivers to use newly introduced
> definitions retiring any driver-specific ones.
> 
> The ECAM ("Enhanced Configuration Access Mechanism") is defined by the
> PCI Express specification (see PCI Express Base Specification, Revision
> 5.0, Version 1.0, Section 7.2.2, p. 676), thus most hardware should
> implement it the same way.  Most of the native PCI Express controller
> drivers define their ECAM-related constants, many of these could be
> shared, or use open-coded values when setting the .bus_shift field of
> the struct pci_ecam_ops.
> 
> All of the newly added constants should remove ambiguity and reduce the
> number of open-coded values, and also correlate more strongly with the
> descriptions in the aforementioned specification (see Table 7-1
> "Enhanced Configuration Address Mapping", p. 677).
> 
> There is no change to functionality.
> 
> Suggested-by: Bjorn Helgaas <bhelgaas@google.com>
> Signed-off-by: Krzysztof Wilczyński <kw@linux.com>

Beautiful.  This should probably go via Lorenzo's tree, so he may have
comments, too.  Could apply this as-is; I had a few trivial notes
below.

It's ironic that we don't use PCIE_ECAM_OFFSET in drivers/pci/ecam.c.
We could do something like this, which would also let us drop
.bus_shift completely in all the conforming implementations.  It also
closes the hole that we didn't limit "where" to 4K for
pci_ecam_map_bus() users.

  if (per_bus_mapping) {
    base = cfg->winp[busn];
    busn = 0;
  } else {
    base = cfg->win;
  }

  if (cfg->ops->bus_shift) {
    u32 bus_offset = (busn & 0xff) << cfg->ops->bus_shift;
    u32 devfn_offset = (devfn & 0xff) << (cfg->ops->bus_shift - 8);

    where &= 0xfff;

    return base + (bus_offset | devfn_offset | where);
  }

  return base + PCIE_ECAM_OFFSET(busn, devfn, where);

Reviewed-by: Bjorn Helgaas <bhelgaas@google.com>

>  static void __iomem *ppc4xx_pciex_get_config_base(struct ppc4xx_pciex_port *port,
>  						  struct pci_bus *bus,
> -						  unsigned int devfn)
> +						  unsigned int devfn,
> +						  int offset)

The interface change (to add "offset") could be a preparatory patch by
itself.

But I'm actually not sure it's worth even touching this file.  This is
the only place outside drivers/pci that includes linux/pci-ecam.h.  I
think I might rather put PCIE_ECAM_OFFSET() and related things in
drivers/pci/pci.h and keep it all inside drivers/pci.

>  static const struct pci_ecam_ops pci_thunder_pem_ops = {
> -	.bus_shift	= 24,
> +	.bus_shift	= THUNDER_PCIE_ECAM_BUS_SHIFT,
>  	.init		= thunder_pem_platform_init,
>  	.pci_ops	= {
>  		.map_bus	= pci_ecam_map_bus,

This could be split to its own patch, no big deal either way.

>  const struct pci_ecam_ops xgene_v2_pcie_ecam_ops = {
> -	.bus_shift	= 16,
>  	.init		= xgene_v2_pcie_ecam_init,
>  	.pci_ops	= {
>  		.map_bus	= xgene_pcie_map_bus,

Thanks for mentioning this change in the cover letter.  It could also
be split off to a preparatory patch, since it's not related to
PCIE_ECAM_OFFSET(), which is the main point of this patch.

>  static void __iomem *iproc_pcie_map_ep_cfg_reg(struct iproc_pcie *pcie,
>  					       unsigned int busno,
> -					       unsigned int slot,
> -					       unsigned int fn,
> +					       unsigned int devfn,

This interface change *could* be a separate preparatory patch, too,
but I'm starting to feel even more OCD than usual :)

> @@ -94,7 +95,7 @@ struct vmd_dev {
>  	struct pci_dev		*dev;
>  
>  	spinlock_t		cfg_lock;
> -	char __iomem		*cfgbar;
> +	void __iomem		*cfgbar;

This type change might be worth pushing to a separate patch since the
casting issues are not completely trivial.
