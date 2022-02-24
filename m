Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F7964C3608
	for <lists+linux-pci@lfdr.de>; Thu, 24 Feb 2022 20:43:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232519AbiBXTnv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 24 Feb 2022 14:43:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233043AbiBXTnt (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 24 Feb 2022 14:43:49 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38DD01B8BD2
        for <linux-pci@vger.kernel.org>; Thu, 24 Feb 2022 11:43:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6A95A61756
        for <linux-pci@vger.kernel.org>; Thu, 24 Feb 2022 19:43:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D772C340E9;
        Thu, 24 Feb 2022 19:43:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645731796;
        bh=q8BGb7R1C+px4L+SV0/F/PoXumVpPWGqchxwyNTZCok=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=vJ6fmaMgA8lbvGsL2xbdFrUfMKvKJbyiJkq5TbqNgRuHKoAEYCt8ee0wSXa5UWgKP
         hCNojDN23anTJ7xwXQhRPrMMfDRjcgX2vcq+4uTHHOss7DQl1kBCX+QHVrmsN2mFAU
         kXf4hlzXgk0Ad+YFRx+Pk9kNmanxm3OGEIvRmHILVenRr6hJHFnL7IkZDtyPAJ2cgE
         uEfLuZvjq8i0npC7cCI50udWYYNvzu40ZPLi8+R3CIKOWF1f7oGfFcx8BMsNT1PkhG
         VOqvX1RQFLSw+F1+uqAYU4Qgzap70iActCfYnsxU+UwIZOZZv/71t63QJQzbY5+V+T
         wA+mFFVpQVaxw==
Date:   Thu, 24 Feb 2022 13:43:15 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>
Cc:     Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
        Marc Zyngier <maz@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v2 11/23] PCI: aardvark: Fix setting MSI address
Message-ID: <20220224194315.GA278999@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220224125901.bmfqrby3lrda36p3@pali>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Rob]

On Thu, Feb 24, 2022 at 01:59:01PM +0100, Pali Rohár wrote:
> On Wednesday 23 February 2022 12:13:12 Bjorn Helgaas wrote:
> > On Fri, Feb 18, 2022 at 03:43:29PM +0100, Marek Behún wrote:
> > > On Thu, 17 Feb 2022 11:14:52 -0600
> > > Bjorn Helgaas <helgaas@kernel.org> wrote:
> > > 
> > > > > +	phys_addr_t msi_addr;
> > > > >  	u32 reg;
> > > > >  	int i;
> > > > >  
> > > > > @@ -561,6 +561,11 @@ static void advk_pcie_setup_hw(struct advk_pcie *pcie)
> > > > >  	reg |= LANE_COUNT_1;
> > > > >  	advk_writel(pcie, reg, PCIE_CORE_CTRL0_REG);
> > > > >  
> > > > > +	/* Set MSI address */
> > > > > +	msi_addr = virt_to_phys(pcie);  
> > > > 
> > > > Strictly speaking, msi_addr should be a pci_bus_addr_t, not a
> > > > phys_addr_t, and virt_to_phys() doesn't return a bus address.

On second thought, probably a dma_addr_t, not a pci_bus_addr_t.

> > > the problem here is that as far as we know currently there is no
> > > function that converts a virtual address to pci_bus_addr_t like
> > > virt_to_phys() does to convert to phys_addr_t.
> > > 
> > > On Armada 3720 there are PCIe Controller Address Decoder Registers,
> > > which such a translating function would need to consult to do the
> > > translation. But the default settings of these registers is to map PCIe
> > > addresses 1 to 1 to physical addresses, and no driver changes these
> > > registers.
> > 
> > The poorly-named pcibios_resource_to_bus() (I think the name is my
> > fault) is the way to convert a CPU physical address to a PCI bus
> > address.
> 
> But here it is needed to do something different. It is needed to do
> inverse mapping of function which converts PCI bus address to CPU
> physical address of CPU memory. So to converting CPU physical address of
> CPU memory to PCI bus address from PCI bus point of view.
>
> I think that this information is stored in dma_ranges member of struct
> pci_host_bridge. But function pcibios_resource_to_bus() looks at the
> ->windows member which converts CPU physical address of PCI memory (not
> CPU memory) to PCI bus address, which is something different. So
> pcibios_resource_to_bus() would not work here and it may return
> incorrect values (as PCI memory may be different from CPU point of view
> and PCI bus point of view).

Oh, sorry, indeed you are correct and I was completely on the wrong
track.  pcibios_resource_to_bus() is what you need for doing MMIO --
CPU accesses to things on PCI.

MSI is the reverse.  From the device's point of view, an MSI is
basically a DMA as you allude to above, so I would expect the DMA API
to be involved somehow.

I do see a couple drivers using the DMA API for this:

  struct pcie_port {
    dma_addr_t msi_data;
  };

  dw_pcie_host_init
    pp->msi_data = dma_map_single_attrs(..., &pp->msi_msg, ...)
    dw_pcie_setup_rc
      dw_pcie_msi_init
        u64 msi_target = (u64)pp->msi_data;
	dw_pcie_writel_dbi(pci, PCIE_MSI_ADDR_LO, lower_32_bits(msi_target));

  dw_pci_setup_msi_msg
    u64 msi_target = (u64)pp->msi_data;
    msg->address_lo = lower_32_bits(msi_target);

  -----------------------------------------------------------

  struct tegra_msi {
    dma_addr_t phys;
  };

  tegra_pcie_probe
    tegra_pcie_msi_setup
      msi->virt = dma_alloc_attrs(..., &msi->phys, ...);

  tegra_pcie_enable_msi
    afi_writel(pcie, msi->phys, ...);

  tegra_compose_msi_msg
    msg->address_low = lower_32_bits(msi->phys);

Bjorn
