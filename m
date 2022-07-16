Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA326577269
	for <lists+linux-pci@lfdr.de>; Sun, 17 Jul 2022 01:33:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233026AbiGPXcY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 16 Jul 2022 19:32:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229848AbiGPXcX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 16 Jul 2022 19:32:23 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E357514D1F
        for <linux-pci@vger.kernel.org>; Sat, 16 Jul 2022 16:32:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9E708B80D1D
        for <linux-pci@vger.kernel.org>; Sat, 16 Jul 2022 23:32:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20B67C34114;
        Sat, 16 Jul 2022 23:32:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658014340;
        bh=kXrqGQjETEHo4iuwQtATa6wrK1eJJ3cmRuDuPq5Qx4w=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=Q42oqgWQLdzSX8qMTbke//bHydchIgpDupuKWGGOT5MZRhIi4nipF3X8GCiGlCNPp
         i8tkBdRPOZZWMz4FKYPkSCMY9cl+ZaoB/0Yoa0kZKkrDsO7fQVWf/Zz9x2YkJb+HjR
         JsbECY0R+5MBabnYz6q33RJf2OLjI55d4/JoFxJP1BgMukcjNKPMRJ7JrAenlBLSPc
         +PRxYLFRTuWaTY1MfKHiFRo2O7du4+4823j4jf+BpD5UvtH1WIiGA6vRcDkZD2Uy4Y
         71ZWBlsY/vVBqUm23YWZZKg+0xOCqJ6UjTC8kPzSaJ5p31ySGf6cJxmeNMarJsUyHB
         8jZepKUKWmFhQ==
Date:   Sat, 16 Jul 2022 18:32:17 -0500
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
Message-ID: <20220716233217.GA1282392@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAhV-H78WxYegS7UzSj62cwDb1wZUKEfTPJuk-ZB8Utaj2GGdw@mail.gmail.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, Jul 16, 2022 at 04:37:41PM +0800, Huacai Chen wrote:
> On Sat, Jul 16, 2022 at 2:12 PM Jianmin Lv <lvjianmin@loongson.cn> wrote:
> > On 2022/7/16 上午11:23, Bjorn Helgaas wrote:
> > > On Sat, Jul 16, 2022 at 10:27:00AM +0800, Jianmin Lv wrote:
> > >> On 2022/7/16 上午12:37, Bjorn Helgaas wrote:
> > >>> On Fri, Jul 15, 2022 at 04:05:12PM +0800, Jianmin Lv wrote:
> > >>>> On 2022/7/15 上午11:44, Bjorn Helgaas wrote:
> > >>>>> On Thu, Jul 14, 2022 at 08:42:16PM +0800, Huacai Chen wrote:
> > >>>>>> From: Jianmin Lv <lvjianmin@loongson.cn>
> > >>>>>>
> > >>>>>> In LS7A, multifunction device use same PCI PIN (because the
> > >>>>>> PIN register report the same INTx value to each function)
> > >>>>>> but we need different IRQ for different functions, so add a
> > >>>>>> quirk to fix it for standard PCI PIN usage.
> > >>>>>>
> > >>>>>> This patch only affect ACPI based systems (and only needed
> > >>>>>> by ACPI based systems, too). For DT based systems, the irq
> > >>>>>> mappings is defined in .dts files and be handled by
> > >>>>>> of_irq_parse_pci().
> > >>>>>
> > >>>>> I'm sorry, I know you've explained this before, but I don't
> > >>>>> understand yet, so let's try again.  I *think* you're saying
> > >>>>> that:
> > >>>>>
> > >>>>>      - These devices integrated into LS7A all report 0 in their
> > >>>>>      Interrupt Pin registers.  Per spec, this means they do not
> > >>>>>      use INTx (PCIe r6.0, sec 7.5.1.1.13).
> > >>>>>
> > >>>>>      - However, these devices actually *do* use INTx.  Function
> > >>>>>      0 uses INTA, function 1 uses INTB, ..., function 4 uses
> > >>>>>      INTA, ...
> > >>>>>
> > >>>>>      - The quirk overrides the incorrect values read from the
> > >>>>>      Interrupt Pin registers.
> > >>>>
> > >>>> Yes, right.
> > >>
> > >> Sorry, I didn't see the first item here carefully, so I have to
> > >> correct it: all the integrated devices in 7A report 1 in PIN reg
> > >> instead of 0.
> > >
> > >>>>> But I'm still confused about how loongson_map_irq() gets called.  The
> > >>>>> only likely path I see is here:
> > >>>>>
> > >>>>>      pci_device_probe                            # pci_bus_type.probe
> > >>>>>        pci_assign_irq
> > >>>>>          pci_read_config_byte(dev, PCI_INTERRUPT_PIN, &pin)
> > >>>>>          if (pin)
> > >>>>>   bridge->swizzle_irq(dev, &pin)
> > >>>>>   irq = bridge->map_irq(dev, slot, pin)
> > >>>>>
> > >>>>> where bridge->map_irq points to loongson_map_irq().  But
> > >>>>> pci_assign_irq() should read 0 from PCI_INTERRUPT_PIN [1], so it
> > >>>>> wouldn't call bridge->map_irq().  Obviously I'm missing something.
> > >>
> > >> Same thing, PCI_INTERRUPT_PIN reports 1, so bridge->map_irq() will be
> > >> called.
> > >
> > > OK, that makes a lot more sense, thank you!
> > >
> > > But it does leave another question: the quirk applies to
> > > DEV_PCIE_PORT_0 (0x7a09), DEV_PCIE_PORT_1 (0x7a19), and
> > > DEV_PCIE_PORT_2 (0x7a29).
> > >
> > > According to the .dtsi [1], all those root ports are at function 0,
> > > and if they report INTA, the quirk will also compute INTA.  So why do
> > > you need to apply the quirk for them?
> >
> > Oh, yes, I don't think they are required either. The fix is only
> > required for multi-func devices of 7A.
> >
> > Huacai, we should remove PCIE ports from the patch.
>
> I agree to remove PCIE ports here. But since Bjorn has already merged
> this patch, and the redundant devices listed here have no
> side-effects, I suggest keeping it as is (but Bjorn is free to modify
> if necessary).

I'd be happy to update the branch to remove the devices mentioned
(DEV_PCIE_PORT_x, DEV_LS7A_OHCI, DEV_LS7A_GPU).

But the original patch [2] *only* listed DEV_PCIE_PORT_x, so I'm
really confused about what's going on with them.  I assume [2] fixed
*something*, but now we're suggesting that we don't need it.

[2] https://lore.kernel.org/all/20210514080025.1828197-5-chenhuacai@loongson.cn/
