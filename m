Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FFF957655B
	for <lists+linux-pci@lfdr.de>; Fri, 15 Jul 2022 18:37:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229677AbiGOQhr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 15 Jul 2022 12:37:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbiGOQhq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 15 Jul 2022 12:37:46 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 248B93D59A
        for <linux-pci@vger.kernel.org>; Fri, 15 Jul 2022 09:37:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B6A2CB82D21
        for <linux-pci@vger.kernel.org>; Fri, 15 Jul 2022 16:37:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03FD3C34115;
        Fri, 15 Jul 2022 16:37:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657903062;
        bh=10Bc88Ns47+0AbyxR1d6IifaZUy4I71nHnL6T2VYXvU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=YlOQtDQFc0Fi0eAe1YdNfzAHWOr4KY8sz6JM8ZZx67Fdn+eB2YBmVCkfHcOwzJCif
         m03XRLmOQ2vJHhnO60u4H0OYJXLA9JWr+K8hXdLboaKNrZHZtlJO1ez1IBPC7hSgDq
         BzPCztUDyiRdtWO28vhJuX+wBMVIsMo9bmf2KAn0rD2agXGGIBcy6J0xuHSnPtg6LL
         wgYjq0CrFcePV4acPPexCmtWmnGWSeUFv6yIGSFAiQ5tMxe8RQlOTLbXYInGnLAUwF
         HBg5ImYcSVpOvqhn+rqJyX4lueGgIzDf5K0Nr2F7rQXHE9k/9eADAh9nnpQuzMWrIK
         XDYQTq5rxOzjA==
Date:   Fri, 15 Jul 2022 11:37:40 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Jianmin Lv <lvjianmin@loongson.cn>
Cc:     Huacai Chen <chenhuacai@loongson.cn>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        linux-pci@vger.kernel.org, Xuefeng Li <lixuefeng@loongson.cn>,
        Huacai Chen <chenhuacai@gmail.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: Re: [PATCH V16 7/7] PCI: Add quirk for multifunction devices of LS7A
Message-ID: <20220715163740.GA1137874@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8eed6209-aa73-83db-440a-469af6528aba@loongson.cn>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jul 15, 2022 at 04:05:12PM +0800, Jianmin Lv wrote:
> On 2022/7/15 上午11:44, Bjorn Helgaas wrote:
> > On Thu, Jul 14, 2022 at 08:42:16PM +0800, Huacai Chen wrote:
> > > From: Jianmin Lv <lvjianmin@loongson.cn>
> > > 
> > > In LS7A, multifunction device use same PCI PIN (because the PIN register
> > > report the same INTx value to each function) but we need different IRQ
> > > for different functions, so add a quirk to fix it for standard PCI PIN
> > > usage.
> > > 
> > > This patch only affect ACPI based systems (and only needed by ACPI based
> > > systems, too). For DT based systems, the irq mappings is defined in .dts
> > > files and be handled by of_irq_parse_pci().
> > 
> > I'm sorry, I know you've explained this before, but I don't understand
> > yet, so let's try again.  I *think* you're saying that:
> > 
> >    - These devices integrated into LS7A all report 0 in their Interrupt
> >      Pin registers.  Per spec, this means they do not use INTx (PCIe
> >      r6.0, sec 7.5.1.1.13).
> > 
> >    - However, these devices actually *do* use INTx.  Function 0 uses
> >      INTA, function 1 uses INTB, ..., function 4 uses INTA, ...
> > 
> >    - The quirk overrides the incorrect values read from the Interrupt
> >      Pin registers.
> 
> Yes, right.
> 
> > That much makes sense to me.
> > 
> > And I even see that in of_irq_parse_pci(), if there's a DT node for
> > the device, of_irq_parse_one() gets the interrupt info from DT and
> > returns the IRQ all the way back up to (I think) loongson_map_irq().
> 
> Agree, I think so for DT.
> 
> > But I'm still confused about how loongson_map_irq() gets called.  The
> > only likely path I see is here:
> > 
> >    pci_device_probe                            # pci_bus_type.probe
> >      pci_assign_irq
> >        pci_read_config_byte(dev, PCI_INTERRUPT_PIN, &pin)
> >        if (pin)
> > 	bridge->swizzle_irq(dev, &pin)
> > 	irq = bridge->map_irq(dev, slot, pin)
> > 
> > where bridge->map_irq points to loongson_map_irq().  But
> > pci_assign_irq() should read 0 from PCI_INTERRUPT_PIN [1], so it
> > wouldn't call bridge->map_irq().  Obviously I'm missing something.
> > 
> > [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/pci/setup-irq.c?id=v5.18#n37
> 
> For ACPI, bridge->map_irq is NULL, so in above path,
> the pci_assign_irq will return because of !(hbrg->map_irq) as following:
> 
>         if (!(hbrg->map_irq)) {
>                 pci_dbg(dev, "runtime IRQ mapping not provided by arch\n");
>                 return;
>         }
> 
> And again as I explained in previous version patch, dev->irq is set in
> acpi_pci_irq_enable() in the following path for ACPI:
> 
> pci_device_probe
>   ->pcibios_alloc_irq
>     ->acpi_pci_irq_enable
>       ->acpi_pci_irq_lookup
> 
> And the reason that we fixed the pin is to get an correct entry in prt
> table when calling acpi_pci_irq_lookup. With out the fix, we can't find
> out a entry.
> 
> After found an entry, we get gsi, and map irq as following:
> 
>         rc = acpi_register_gsi(&dev->dev, gsi, triggering, polarity);
>         if (rc < 0) {
>                 dev_warn(&dev->dev, "PCI INT %c: failed to register GSI\n",
>                          pin_name(pin));
>                 kfree(entry);
>                 return rc;
>         }
>         dev->irq = rc;
> 
> Here, dev->irq is set like in pci_assign_irq for DT.

Yes.  The above explains how things work for ACPI, but I'm not asking
about that.

I'm asking how this works in the *DT* case.  I see that
pci_assign_irq() is called for both ACPI and DT, and I see that it
does nothing in the ACPI path because bridge->map_irq hasn't been set.

What I *don't* see is how pci_assign_irq() works in the DT case
because it reads PCI_INTERRUPT_PIN, which should return 0 for these
broken devices, and if "pin == 0", it never calls ->map_irq().

Is ->map_irq() called via some other path?

Bjorn
