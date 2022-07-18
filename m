Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1D135787FF
	for <lists+linux-pci@lfdr.de>; Mon, 18 Jul 2022 19:00:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235276AbiGRRAd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 18 Jul 2022 13:00:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235283AbiGRRAd (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 18 Jul 2022 13:00:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D3982A409
        for <linux-pci@vger.kernel.org>; Mon, 18 Jul 2022 10:00:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D5AC06154C
        for <linux-pci@vger.kernel.org>; Mon, 18 Jul 2022 17:00:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCFD5C341C0;
        Mon, 18 Jul 2022 17:00:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658163631;
        bh=fRrwjZodGjqZQ1anIcJvkkCvHcmwwFf+FJRgR1krvjA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=GmWVtTJM8Qzk/GLiCIrmOFqBZMCSD4DCgG6WjdplGfSm+PMZhg2qg7wl1Gq8LvWtI
         FbjHuLYMKp9HqNMWBhAtRGs5kB1kPbtqIQvLtPVzecZekal60cODCCJiPw3nBEsUBx
         p0NwWewNd8NedkXwWZhwcJRVXbgrbDIJsiLWJuQMWtNsLKukRiy9+hHF44+6ekINrJ
         49sdIfjaowmDhSzrh/h3BHSyPy8abxta7iCDRYqbDukOodbedNjfKWRCDz7xkPNi3j
         hFAlGIIEW2AKqIar8s3qcyZL8oLkwhcBDS1eySNf+C8PzU1WiXJlKxCOJdkenvthaD
         m6TKWSWfASGhQ==
Date:   Mon, 18 Jul 2022 12:00:29 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Huacai Chen <chenhuacai@gmail.com>
Cc:     Jianmin Lv <lvjianmin@loongson.cn>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: Re: [PATCH V16 7/7] PCI: Add quirk for multifunction devices of LS7A
Message-ID: <20220718170029.GA1425737@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAhV-H6G=_k0tZeK2OT2AYet5ufgOTOPHsOFOfkB6V1H46OgzQ@mail.gmail.com>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, Jul 17, 2022 at 10:11:17PM +0800, Huacai Chen wrote:
> On Sun, Jul 17, 2022 at 9:41 AM Jianmin Lv <lvjianmin@loongson.cn> wrote:
> > On 2022/7/17 上午7:32, Bjorn Helgaas wrote:
> > > On Sat, Jul 16, 2022 at 04:37:41PM +0800, Huacai Chen wrote:
> > >> On Sat, Jul 16, 2022 at 2:12 PM Jianmin Lv <lvjianmin@loongson.cn> wrote:
> > >>> On 2022/7/16 上午11:23, Bjorn Helgaas wrote:
> > >>>> On Sat, Jul 16, 2022 at 10:27:00AM +0800, Jianmin Lv wrote:
> > >>>>> On 2022/7/16 上午12:37, Bjorn Helgaas wrote:
> > >>>>>> On Fri, Jul 15, 2022 at 04:05:12PM +0800, Jianmin Lv wrote:
> > >>>>>>> On 2022/7/15 上午11:44, Bjorn Helgaas wrote:
> > >>>>>>>> On Thu, Jul 14, 2022 at 08:42:16PM +0800, Huacai Chen wrote:
> > >>>>>>>>> From: Jianmin Lv <lvjianmin@loongson.cn>
> > >>>>>>>>>
> > >>>>>>>>> In LS7A, multifunction device use same PCI PIN (because the
> > >>>>>>>>> PIN register report the same INTx value to each function)
> > >>>>>>>>> but we need different IRQ for different functions, so add a
> > >>>>>>>>> quirk to fix it for standard PCI PIN usage.
> > >>>>>>>>>
> > >>>>>>>>> This patch only affect ACPI based systems (and only needed
> > >>>>>>>>> by ACPI based systems, too). For DT based systems, the irq
> > >>>>>>>>> mappings is defined in .dts files and be handled by
> > >>>>>>>>> of_irq_parse_pci().
> > >>>>>>>>
> > >>>>>>>> I'm sorry, I know you've explained this before, but I don't
> > >>>>>>>> understand yet, so let's try again.  I *think* you're saying
> > >>>>>>>> that:
> > >>>>>>>>
> > >>>>>>>>       - These devices integrated into LS7A all report 0 in their
> > >>>>>>>>       Interrupt Pin registers.  Per spec, this means they do not
> > >>>>>>>>       use INTx (PCIe r6.0, sec 7.5.1.1.13).
> > >>>>>>>>
> > >>>>>>>>       - However, these devices actually *do* use INTx.  Function
> > >>>>>>>>       0 uses INTA, function 1 uses INTB, ..., function 4 uses
> > >>>>>>>>       INTA, ...
> > >>>>>>>>
> > >>>>>>>>       - The quirk overrides the incorrect values read from the
> > >>>>>>>>       Interrupt Pin registers.
> > >>>>>>>
> > >>>>>>> Yes, right.
> > >>>>>
> > >>>>> Sorry, I didn't see the first item here carefully, so I have to
> > >>>>> correct it: all the integrated devices in 7A report 1 in PIN reg
> > >>>>> instead of 0.
> > >>>>
> > >>>>>>>> But I'm still confused about how loongson_map_irq() gets called.  The
> > >>>>>>>> only likely path I see is here:
> > >>>>>>>>
> > >>>>>>>>       pci_device_probe                            # pci_bus_type.probe
> > >>>>>>>>         pci_assign_irq
> > >>>>>>>>           pci_read_config_byte(dev, PCI_INTERRUPT_PIN, &pin)
> > >>>>>>>>           if (pin)
> > >>>>>>>>    bridge->swizzle_irq(dev, &pin)
> > >>>>>>>>    irq = bridge->map_irq(dev, slot, pin)
> > >>>>>>>>
> > >>>>>>>> where bridge->map_irq points to loongson_map_irq().  But
> > >>>>>>>> pci_assign_irq() should read 0 from PCI_INTERRUPT_PIN [1], so it
> > >>>>>>>> wouldn't call bridge->map_irq().  Obviously I'm missing something.
> > >>>>>
> > >>>>> Same thing, PCI_INTERRUPT_PIN reports 1, so bridge->map_irq() will be
> > >>>>> called.
> > >>>>
> > >>>> OK, that makes a lot more sense, thank you!
> > >>>>
> > >>>> But it does leave another question: the quirk applies to
> > >>>> DEV_PCIE_PORT_0 (0x7a09), DEV_PCIE_PORT_1 (0x7a19), and
> > >>>> DEV_PCIE_PORT_2 (0x7a29).
> > >>>>
> > >>>> According to the .dtsi [1], all those root ports are at function 0,
> > >>>> and if they report INTA, the quirk will also compute INTA.  So why do
> > >>>> you need to apply the quirk for them?
> > >>>
> > >>> Oh, yes, I don't think they are required either. The fix is only
> > >>> required for multi-func devices of 7A.
> > >>>
> > >>> Huacai, we should remove PCIE ports from the patch.
> > >>
> > >> I agree to remove PCIE ports here. But since Bjorn has already merged
> > >> this patch, and the redundant devices listed here have no
> > >> side-effects, I suggest keeping it as is (but Bjorn is free to modify
> > >> if necessary).
> > >
> > > I'd be happy to update the branch to remove the devices mentioned
> > > (DEV_PCIE_PORT_x, DEV_LS7A_OHCI, DEV_LS7A_GPU).
> > >
> > > But the original patch [2] *only* listed DEV_PCIE_PORT_x, so I'm
> > > really confused about what's going on with them.  I assume [2] fixed
> > > *something*, but now we're suggesting that we don't need it.
> > >
> > > [2] https://lore.kernel.org/all/20210514080025.1828197-5-chenhuacai@loongson.cn/
> >
> > My original patch(obviously just for simple, unwilling to list so much
> > devices in the patch) is following;
> >
> > +static void loongson_pci_pin_quirk(struct pci_dev *dev)
> > +{
> > +    u8 fun = dev->devfn & 7;
> > +
> > +    dev->pin = 1 + (fun & 3);
> > +}
> > +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_LOONGSON, PCI_ANY_ID,
> > loongson_pci_pin_quirk);
> > +
> >
> > Mybe Huacai think only PCIE ports need the fix, so he adds the PCIE
> > ports in the patch when submitting it.
>
> Yes, what Jianmin said is correct, the first version of my patch is
> wrong and the current version is correct.

Thanks for clearing that up.  I dropped DEV_PCIE_PORT_x,
DEV_LS7A_OHCI, DEV_LS7A_GPU from the quirk.
