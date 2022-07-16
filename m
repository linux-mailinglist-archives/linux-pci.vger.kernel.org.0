Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D7D4576B6D
	for <lists+linux-pci@lfdr.de>; Sat, 16 Jul 2022 05:23:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229497AbiGPDXo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 15 Jul 2022 23:23:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiGPDXn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 15 Jul 2022 23:23:43 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F05A7315
        for <linux-pci@vger.kernel.org>; Fri, 15 Jul 2022 20:23:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 783B9B82EB2
        for <linux-pci@vger.kernel.org>; Sat, 16 Jul 2022 03:23:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A926DC3411C;
        Sat, 16 Jul 2022 03:23:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657941817;
        bh=QBwtWchQkwncZHxZliC3oudM7f01AKV872REhvcVqUk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=nRgw9Urh06ACX60u8Z1M5mawXdHRfbRK9rDpDbSFVOzVrVVFvy+DZ3EkjDpkVSLvL
         uZ4Ji5jXkZSDdwL7ESFpcyGhnv/vQHflRG4W5u2qExdO2fg0dSo51RE9NJAJMzAsrN
         3/Z7xC4AXxQQDPtd4hi5F3X+pf2byFUL7Gg457gWt+qDTTowyQknTbZQatC+Qi67Qs
         g/flsPHQhJJRjFg3FIGRu2V7aYo3Q0Cwxu0icJZUb5+7oavx3dZpRP9SBEPl+wGMcS
         HOCDKbG7SQJXZYtIh2TjJKwxMbbWWTzyn0M8fzjPPF9ndBr2FJaMBhKpd17YHpLFlM
         TzxPymhxda2Uw==
Date:   Fri, 15 Jul 2022 22:23:34 -0500
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
Message-ID: <20220716032334.GA1228076@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3a49465c-cd70-927f-1fd9-9454fa9c44ab@loongson.cn>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, Jul 16, 2022 at 10:27:00AM +0800, Jianmin Lv wrote:
> On 2022/7/16 上午12:37, Bjorn Helgaas wrote:
> > On Fri, Jul 15, 2022 at 04:05:12PM +0800, Jianmin Lv wrote:
> > > On 2022/7/15 上午11:44, Bjorn Helgaas wrote:
> > > > On Thu, Jul 14, 2022 at 08:42:16PM +0800, Huacai Chen wrote:
> > > > > From: Jianmin Lv <lvjianmin@loongson.cn>
> > > > > 
> > > > > In LS7A, multifunction device use same PCI PIN (because the
> > > > > PIN register report the same INTx value to each function)
> > > > > but we need different IRQ for different functions, so add a
> > > > > quirk to fix it for standard PCI PIN usage.
> > > > > 
> > > > > This patch only affect ACPI based systems (and only needed
> > > > > by ACPI based systems, too). For DT based systems, the irq
> > > > > mappings is defined in .dts files and be handled by
> > > > > of_irq_parse_pci().
> > > > 
> > > > I'm sorry, I know you've explained this before, but I don't
> > > > understand yet, so let's try again.  I *think* you're saying
> > > > that:
> > > > 
> > > >     - These devices integrated into LS7A all report 0 in their
> > > >     Interrupt Pin registers.  Per spec, this means they do not
> > > >     use INTx (PCIe r6.0, sec 7.5.1.1.13).
> > > > 
> > > >     - However, these devices actually *do* use INTx.  Function
> > > >     0 uses INTA, function 1 uses INTB, ..., function 4 uses
> > > >     INTA, ...
> > > > 
> > > >     - The quirk overrides the incorrect values read from the
> > > >     Interrupt Pin registers.
> > > 
> > > Yes, right.
> 
> Sorry, I didn't see the first item here carefully, so I have to
> correct it: all the integrated devices in 7A report 1 in PIN reg
> instead of 0.

> > > > But I'm still confused about how loongson_map_irq() gets called.  The
> > > > only likely path I see is here:
> > > > 
> > > >     pci_device_probe                            # pci_bus_type.probe
> > > >       pci_assign_irq
> > > >         pci_read_config_byte(dev, PCI_INTERRUPT_PIN, &pin)
> > > >         if (pin)
> > > > 	bridge->swizzle_irq(dev, &pin)
> > > > 	irq = bridge->map_irq(dev, slot, pin)
> > > > 
> > > > where bridge->map_irq points to loongson_map_irq().  But
> > > > pci_assign_irq() should read 0 from PCI_INTERRUPT_PIN [1], so it
> > > > wouldn't call bridge->map_irq().  Obviously I'm missing something.
> > > > 
> 
> Same thing, PCI_INTERRUPT_PIN reports 1, so bridge->map_irq() will be
> called.

OK, that makes a lot more sense, thank you!

But it does leave another question: the quirk applies to
DEV_PCIE_PORT_0 (0x7a09), DEV_PCIE_PORT_1 (0x7a19), and
DEV_PCIE_PORT_2 (0x7a29).

According to the .dtsi [1], all those root ports are at function 0,
and if they report INTA, the quirk will also compute INTA.  So why do
you need to apply the quirk for them?

The same would apply to any Device ID that only appears at function 0,
which looks like it also includes DEV_LS7A_OHCI (0x7a24), and
DEV_LS7A_GPU (0x7a15).

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/mips/boot/dts/loongson/ls7a-pch.dtsi?id=v5.18#n231
