Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08B7F576C9B
	for <lists+linux-pci@lfdr.de>; Sat, 16 Jul 2022 10:37:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229694AbiGPIh6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 16 Jul 2022 04:37:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229571AbiGPIh5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 16 Jul 2022 04:37:57 -0400
Received: from mail-vs1-xe2e.google.com (mail-vs1-xe2e.google.com [IPv6:2607:f8b0:4864:20::e2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7BEF1E3CA
        for <linux-pci@vger.kernel.org>; Sat, 16 Jul 2022 01:37:56 -0700 (PDT)
Received: by mail-vs1-xe2e.google.com with SMTP id q26so6135074vsp.11
        for <linux-pci@vger.kernel.org>; Sat, 16 Jul 2022 01:37:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=MGJqpq79aRzF5mOhw3yQyLkSBoUrfmxGSy+ju7pj/FU=;
        b=ldXjQcq0HuwHp434MaOXMZqH2/LUgSOw11wZzpe30GSgDk4eeeAoLSQcICBesOLG82
         rzUGkXXczfistqfhoKXJ0k6CXRTuLPpjarCsdC1eQKofa60gGV/tWtRrEZ+Ahd1mqKrK
         tYQu+Cz/cKA4QQ1hm2dEglXIYZgqnp6IWw/WKEh/3T0iLTHx+evvqkPzItD1IqYZrZkQ
         i+guHZY/kJ4SDV4Wzq3aMDOAWwyFviT42jVn0yyHT7vN0S/gR1bQWkxUb/k2ZDYMK8pI
         /vaGWihRrhRPwJKflspJS0Rl+E8rXTXjOFwj/VTytc7xyf7Im7OFUu2J+tfFYKNYSx9F
         xvwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=MGJqpq79aRzF5mOhw3yQyLkSBoUrfmxGSy+ju7pj/FU=;
        b=s2nLtqHr/M0hRL1Jl9q/fKXCm0GWauwsvKYDn6a1jql6LdQ1UnZgCScFhAiNEw3Svl
         iffX2gvOuu1Nq/YQoSE57r8j6gFyesQpPtFxfI500W7BSbpPHPVCWuVn7EAIXtGxv4tN
         T2SKYc95z3qm94JvK1JyR6INQsvigCqXJHyKTNwpcYRqOaSi/yKnYtgJAR04w8dWg2C4
         B154y/iAAUWsG7OSSqNeaapeL+JsoendPlEBAiPMRfrEZfde8mdcKca+nMF78ArE/tss
         +0RsRde9msVScMSJrzYlwLyIxSMlE3xE/EU0oT1YhU77Ge+WPiiP29OQLcreAICy8vqg
         u8vQ==
X-Gm-Message-State: AJIora9a16l5MoCXi6dEOp5yev7iJzXm0tyw8NoxjJTPTTLZU7G2S2CX
        cFjx9u4E446Lfxagkc9J/8CKjv8gZYLel/1ALaM=
X-Google-Smtp-Source: AGRyM1scPc+o910rDFvqggczrC9lwl7888Z84CuyAfSF3oDZ0Z/PkYjCJ+UcTMFOE4Fz5ipsk2baNMqqGeeKCjc3lO4=
X-Received: by 2002:a05:6102:3f06:b0:356:f57f:4f59 with SMTP id
 k6-20020a0561023f0600b00356f57f4f59mr6829691vsv.70.1657960675793; Sat, 16 Jul
 2022 01:37:55 -0700 (PDT)
MIME-Version: 1.0
References: <20220716032334.GA1228076@bhelgaas> <6e56ee68-4b87-4b04-9a43-c223dcd1b0fe@loongson.cn>
In-Reply-To: <6e56ee68-4b87-4b04-9a43-c223dcd1b0fe@loongson.cn>
From:   Huacai Chen <chenhuacai@gmail.com>
Date:   Sat, 16 Jul 2022 16:37:41 +0800
Message-ID: <CAAhV-H78WxYegS7UzSj62cwDb1wZUKEfTPJuk-ZB8Utaj2GGdw@mail.gmail.com>
Subject: Re: [PATCH V16 7/7] PCI: Add quirk for multifunction devices of LS7A
To:     Jianmin Lv <lvjianmin@loongson.cn>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi, Jianmin,

On Sat, Jul 16, 2022 at 2:12 PM Jianmin Lv <lvjianmin@loongson.cn> wrote:
>
>
>
> On 2022/7/16 =E4=B8=8A=E5=8D=8811:23, Bjorn Helgaas wrote:
> > On Sat, Jul 16, 2022 at 10:27:00AM +0800, Jianmin Lv wrote:
> >> On 2022/7/16 =E4=B8=8A=E5=8D=8812:37, Bjorn Helgaas wrote:
> >>> On Fri, Jul 15, 2022 at 04:05:12PM +0800, Jianmin Lv wrote:
> >>>> On 2022/7/15 =E4=B8=8A=E5=8D=8811:44, Bjorn Helgaas wrote:
> >>>>> On Thu, Jul 14, 2022 at 08:42:16PM +0800, Huacai Chen wrote:
> >>>>>> From: Jianmin Lv <lvjianmin@loongson.cn>
> >>>>>>
> >>>>>> In LS7A, multifunction device use same PCI PIN (because the
> >>>>>> PIN register report the same INTx value to each function)
> >>>>>> but we need different IRQ for different functions, so add a
> >>>>>> quirk to fix it for standard PCI PIN usage.
> >>>>>>
> >>>>>> This patch only affect ACPI based systems (and only needed
> >>>>>> by ACPI based systems, too). For DT based systems, the irq
> >>>>>> mappings is defined in .dts files and be handled by
> >>>>>> of_irq_parse_pci().
> >>>>>
> >>>>> I'm sorry, I know you've explained this before, but I don't
> >>>>> understand yet, so let's try again.  I *think* you're saying
> >>>>> that:
> >>>>>
> >>>>>      - These devices integrated into LS7A all report 0 in their
> >>>>>      Interrupt Pin registers.  Per spec, this means they do not
> >>>>>      use INTx (PCIe r6.0, sec 7.5.1.1.13).
> >>>>>
> >>>>>      - However, these devices actually *do* use INTx.  Function
> >>>>>      0 uses INTA, function 1 uses INTB, ..., function 4 uses
> >>>>>      INTA, ...
> >>>>>
> >>>>>      - The quirk overrides the incorrect values read from the
> >>>>>      Interrupt Pin registers.
> >>>>
> >>>> Yes, right.
> >>
> >> Sorry, I didn't see the first item here carefully, so I have to
> >> correct it: all the integrated devices in 7A report 1 in PIN reg
> >> instead of 0.
> >
> >>>>> But I'm still confused about how loongson_map_irq() gets called.  T=
he
> >>>>> only likely path I see is here:
> >>>>>
> >>>>>      pci_device_probe                            # pci_bus_type.pro=
be
> >>>>>        pci_assign_irq
> >>>>>          pci_read_config_byte(dev, PCI_INTERRUPT_PIN, &pin)
> >>>>>          if (pin)
> >>>>>   bridge->swizzle_irq(dev, &pin)
> >>>>>   irq =3D bridge->map_irq(dev, slot, pin)
> >>>>>
> >>>>> where bridge->map_irq points to loongson_map_irq().  But
> >>>>> pci_assign_irq() should read 0 from PCI_INTERRUPT_PIN [1], so it
> >>>>> wouldn't call bridge->map_irq().  Obviously I'm missing something.
> >>>>>
> >>
> >> Same thing, PCI_INTERRUPT_PIN reports 1, so bridge->map_irq() will be
> >> called.
> >
> > OK, that makes a lot more sense, thank you!
> >
> > But it does leave another question: the quirk applies to
> > DEV_PCIE_PORT_0 (0x7a09), DEV_PCIE_PORT_1 (0x7a19), and
> > DEV_PCIE_PORT_2 (0x7a29).
> >
> > According to the .dtsi [1], all those root ports are at function 0,
> > and if they report INTA, the quirk will also compute INTA.  So why do
> > you need to apply the quirk for them?
> >
>
> Oh, yes, I don't think they are required either. The fix is only
> required for multi-func devices of 7A.
>
> Huacai, we should remove PCIE ports from the patch.
I agree to remove PCIE ports here. But since Bjorn has already merged
this patch, and the redundant devices listed here have no
side-effects, I suggest keeping it as is (but Bjorn is free to modify
if necessary).

Huacai
>
> > The same would apply to any Device ID that only appears at function 0,
> > which looks like it also includes DEV_LS7A_OHCI (0x7a24), and
> > DEV_LS7A_GPU (0x7a15).
> >
> > [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/=
tree/arch/mips/boot/dts/loongson/ls7a-pch.dtsi?id=3Dv5.18#n231
> >
>
>
