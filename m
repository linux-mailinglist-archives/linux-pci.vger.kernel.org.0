Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B0C64C2C4E
	for <lists+linux-pci@lfdr.de>; Thu, 24 Feb 2022 13:59:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234680AbiBXM7i (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 24 Feb 2022 07:59:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231754AbiBXM7h (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 24 Feb 2022 07:59:37 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21B3A28F947
        for <linux-pci@vger.kernel.org>; Thu, 24 Feb 2022 04:59:07 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CA19FB825AC
        for <linux-pci@vger.kernel.org>; Thu, 24 Feb 2022 12:59:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BD46C340EC;
        Thu, 24 Feb 2022 12:59:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645707544;
        bh=gaq2mWkDV0qIBJqUgGBkFqd/RJEF473+Ag3q8m+wL7U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mprAmf+yqhqgRFyosfFQ+Cgx/IoKMs+XTDlYvO10B7qtCb6+WTGORy7wMuqghILDB
         wVaSm2oCBzJJmBzw3dO38dM0GxnWmlKsE1xnPwQGDNw91xLEa+Qy9BiT6UPC+ycFqv
         IAU2m5EbtvkZqgjqj2MymqmcfaBQx7/E8RN+1GuDzHqzs/cJqvcmoVmj3EMFdNf7AE
         Ghau5FW3PACpv/uWYq8YCMY3iQK2S1ujnqDyBMnKaLdJVrjSvvk8Qkh5MnneyA54ui
         3ukDSiTPJiDnZQKqoeHCZgJ1/LNSUOmFyA7gB4Oyoiwb41HsjWDasEbHfofG2GgiPl
         eyIGvrzBFlo6A==
Received: by pali.im (Postfix)
        id 4B77CB6E; Thu, 24 Feb 2022 13:59:01 +0100 (CET)
Date:   Thu, 24 Feb 2022 13:59:01 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Marek =?utf-8?B?QmVow7pu?= <kabel@kernel.org>,
        Marc Zyngier <maz@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 11/23] PCI: aardvark: Fix setting MSI address
Message-ID: <20220224125901.bmfqrby3lrda36p3@pali>
References: <20220218154329.762831dd@thinkpad>
 <20220223181312.GA141319@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220223181312.GA141319@bhelgaas>
User-Agent: NeoMutt/20180716
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wednesday 23 February 2022 12:13:12 Bjorn Helgaas wrote:
> On Fri, Feb 18, 2022 at 03:43:29PM +0100, Marek Behún wrote:
> > On Thu, 17 Feb 2022 11:14:52 -0600
> > Bjorn Helgaas <helgaas@kernel.org> wrote:
> > 
> > > > +	phys_addr_t msi_addr;
> > > >  	u32 reg;
> > > >  	int i;
> > > >  
> > > > @@ -561,6 +561,11 @@ static void advk_pcie_setup_hw(struct advk_pcie *pcie)
> > > >  	reg |= LANE_COUNT_1;
> > > >  	advk_writel(pcie, reg, PCIE_CORE_CTRL0_REG);
> > > >  
> > > > +	/* Set MSI address */
> > > > +	msi_addr = virt_to_phys(pcie);  
> > > 
> > > Strictly speaking, msi_addr should be a pci_bus_addr_t, not a
> > > phys_addr_t, and virt_to_phys() doesn't return a bus address.
> > 
> > the problem here is that as far as we know currently there is no
> > function that converts a virtual address to pci_bus_addr_t like
> > virt_to_phys() does to convert to phys_addr_t.
> > 
> > On Armada 3720 there are PCIe Controller Address Decoder Registers,
> > which such a translating function would need to consult to do the
> > translation. But the default settings of these registers is to map PCIe
> > addresses 1 to 1 to physical addresses, and no driver changes these
> > registers.
> 
> The poorly-named pcibios_resource_to_bus() (I think the name is my
> fault) is the way to convert a CPU physical address to a PCI bus
> address.

But here it is needed to do something different. It is needed to do
inverse mapping of function which converts PCI bus address to CPU
physical address of CPU memory. So to converting CPU physical address of
CPU memory to PCI bus address from PCI bus point of view.

I think that this information is stored in dma_ranges member of struct
pci_host_bridge. But function pcibios_resource_to_bus() looks at the
->windows member which converts CPU physical address of PCI memory (not
CPU memory) to PCI bus address, which is something different. So
pcibios_resource_to_bus() would not work here and it may return
incorrect values (as PCI memory may be different from CPU point of view
and PCI bus point of view).

> This is implemented in terms of the host bridge windows and the
> translation offset in struct resource_entry, which should be set up
> via the pci_add_resource_offset() called from
> devm_of_pci_get_host_bridge_resources().
> 
> > Pali says that other drivers also use phys_addr_t, and most hardware
> > maps 1 to 1 by default.
> 
> Yes.  I think they're all technically incorrect.  Most systems do map
> CPU phys == PCI bus, but I point it out because it's a case where
> copying that pattern to new drivers will eventually bite us.

I agree, it is incorrect but I do not see a way how to do it correctly
because of missing function (which for pci-aardvark should return
identity).

> > So we think that until at least an API for such a function exists, we
> > shuld leave it as it is. I am not against converting the phys_addr_to
> > to a pci_bus_addr_t, but Pali thinks that for now we should leave even
> > that as it is, because the virt_to_phys() function returns phys_addr_t.
> > 
> > We can add a comment there explaining this, if you want.
> > 
> > What do you think?
> > 
> > Marek
