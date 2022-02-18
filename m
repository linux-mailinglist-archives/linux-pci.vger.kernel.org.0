Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A93654BBAD6
	for <lists+linux-pci@lfdr.de>; Fri, 18 Feb 2022 15:43:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236138AbiBROnx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 18 Feb 2022 09:43:53 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:37666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232953AbiBROnw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 18 Feb 2022 09:43:52 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 719B536334
        for <linux-pci@vger.kernel.org>; Fri, 18 Feb 2022 06:43:36 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0CCF961B71
        for <linux-pci@vger.kernel.org>; Fri, 18 Feb 2022 14:43:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02384C340E9;
        Fri, 18 Feb 2022 14:43:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645195415;
        bh=IUw8i2LaeOVq2mpxg0Zhlnml8CCtMEiF/iYvSEHb0m0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=bvet9Tt2TOnNr5WGspHLlTu5KXFX7KUYWcKya9ZoXyBcf0ZxP6YkIyr4fIHpKjMmi
         Gk5quCbA8RxXVZd+fRLRyUQxtDM/WfOYvEcfiCxSkhxnb/j1dTWlro8pM5kFAUx55U
         9WrLdqavXzzxsStbJoZZetjumSl7lDnhiCvc3UwWO7IKqj1JQ8FKBtKLUAWDdpxRdC
         zPozqcQ7HcmiOYe0IRildBP8yipyyGuN+Q/Imqp+BV/n3+xl1iP0Z2oSLzd2expP6V
         5hdbflSZGX+BlkerQblzPi8LfTmg3hIJPLlNfkm2Y9JUT6e/UiHcWInjAeiXrcc94M
         MW6KrRfY9NjdA==
Date:   Fri, 18 Feb 2022 15:43:29 +0100
From:   Marek =?UTF-8?B?QmVow7pu?= <kabel@kernel.org>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Marc Zyngier <maz@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, pali@kernel.org,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 11/23] PCI: aardvark: Fix setting MSI address
Message-ID: <20220218154329.762831dd@thinkpad>
In-Reply-To: <20220217171452.GA286231@bhelgaas>
References: <20220110015018.26359-12-kabel@kernel.org>
        <20220217171452.GA286231@bhelgaas>
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, 17 Feb 2022 11:14:52 -0600
Bjorn Helgaas <helgaas@kernel.org> wrote:

> > +	phys_addr_t msi_addr;
> >  	u32 reg;
> >  	int i;
> >  
> > @@ -561,6 +561,11 @@ static void advk_pcie_setup_hw(struct advk_pcie *pcie)
> >  	reg |= LANE_COUNT_1;
> >  	advk_writel(pcie, reg, PCIE_CORE_CTRL0_REG);
> >  
> > +	/* Set MSI address */
> > +	msi_addr = virt_to_phys(pcie);  
> 
> Strictly speaking, msi_addr should be a pci_bus_addr_t, not a
> phys_addr_t, and virt_to_phys() doesn't return a bus address.

Dear Bjorn,

the problem here is that as far as we know currently there is no
function that converts a virtual address to pci_bus_addr_t like
virt_to_phys() does to convert to phys_addr_t.

On Armada 3720 there are PCIe Controller Address Decoder Registers,
which such a translating function would need to consult to do the
translation. But the default settings of these registers is to map PCIe
addresses 1 to 1 to physical addresses, and no driver changes these
registers.

Pali says that other drivers also use phys_addr_t, and most hardware
maps 1 to 1 by default.

So we think that until at least an API for such a function exists, we
shuld leave it as it is. I am not against converting the phys_addr_to
to a pci_bus_addr_t, but Pali thinks that for now we should leave even
that as it is, because the virt_to_phys() function returns phys_addr_t.

We can add a comment there explaining this, if you want.

What do you think?

Marek
