Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EB534C1AB1
	for <lists+linux-pci@lfdr.de>; Wed, 23 Feb 2022 19:13:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241679AbiBWSNo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 23 Feb 2022 13:13:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243782AbiBWSNn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 23 Feb 2022 13:13:43 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3F0A4831E
        for <linux-pci@vger.kernel.org>; Wed, 23 Feb 2022 10:13:15 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3F1C2615C9
        for <linux-pci@vger.kernel.org>; Wed, 23 Feb 2022 18:13:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66D4BC340EC;
        Wed, 23 Feb 2022 18:13:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645639994;
        bh=iXqer8BSvDJXCD5ucM7OvDJNDGRMFIug8G31VTXFMlA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=KLCL5QjgWWU5lBGajrjoqzuYCyh+cgivmiwTOHJIgK17QHMw17yxmlMWjAy+tbOHs
         IWzc+bFr9KXWTc21BJTTud3R47d06oQPAmDQYYJ+Sn2kYtn/+TWhizcTNaNn9uhteq
         SB3MLv5puWD552J01hvFSuR9MtlXhnwkZhG8YbJQUMYQie9kbhJEOYr5A314VqV9l5
         dd8azdzLcqBLP4b+2nM2Z7M/1SF3QvMH/k4XFcXMP/JsaZTd7nvHlLq6si5eMIrWJf
         MbFWNq8ncsW9vi4SFWOdZosNvbAxnqUL0lzsUHLpFexBW8ZCtkHgfu8PLQ6cUpK6wB
         QSN/y1byJOcNw==
Date:   Wed, 23 Feb 2022 12:13:12 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>
Cc:     Marc Zyngier <maz@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, pali@kernel.org,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 11/23] PCI: aardvark: Fix setting MSI address
Message-ID: <20220223181312.GA141319@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220218154329.762831dd@thinkpad>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Feb 18, 2022 at 03:43:29PM +0100, Marek Behún wrote:
> On Thu, 17 Feb 2022 11:14:52 -0600
> Bjorn Helgaas <helgaas@kernel.org> wrote:
> 
> > > +	phys_addr_t msi_addr;
> > >  	u32 reg;
> > >  	int i;
> > >  
> > > @@ -561,6 +561,11 @@ static void advk_pcie_setup_hw(struct advk_pcie *pcie)
> > >  	reg |= LANE_COUNT_1;
> > >  	advk_writel(pcie, reg, PCIE_CORE_CTRL0_REG);
> > >  
> > > +	/* Set MSI address */
> > > +	msi_addr = virt_to_phys(pcie);  
> > 
> > Strictly speaking, msi_addr should be a pci_bus_addr_t, not a
> > phys_addr_t, and virt_to_phys() doesn't return a bus address.
> 
> the problem here is that as far as we know currently there is no
> function that converts a virtual address to pci_bus_addr_t like
> virt_to_phys() does to convert to phys_addr_t.
> 
> On Armada 3720 there are PCIe Controller Address Decoder Registers,
> which such a translating function would need to consult to do the
> translation. But the default settings of these registers is to map PCIe
> addresses 1 to 1 to physical addresses, and no driver changes these
> registers.

The poorly-named pcibios_resource_to_bus() (I think the name is my
fault) is the way to convert a CPU physical address to a PCI bus
address.

This is implemented in terms of the host bridge windows and the
translation offset in struct resource_entry, which should be set up
via the pci_add_resource_offset() called from
devm_of_pci_get_host_bridge_resources().

> Pali says that other drivers also use phys_addr_t, and most hardware
> maps 1 to 1 by default.

Yes.  I think they're all technically incorrect.  Most systems do map
CPU phys == PCI bus, but I point it out because it's a case where
copying that pattern to new drivers will eventually bite us.

> So we think that until at least an API for such a function exists, we
> shuld leave it as it is. I am not against converting the phys_addr_to
> to a pci_bus_addr_t, but Pali thinks that for now we should leave even
> that as it is, because the virt_to_phys() function returns phys_addr_t.
> 
> We can add a comment there explaining this, if you want.
> 
> What do you think?
> 
> Marek
