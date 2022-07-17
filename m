Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6709157769C
	for <lists+linux-pci@lfdr.de>; Sun, 17 Jul 2022 16:11:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233181AbiGQOL1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 17 Jul 2022 10:11:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233033AbiGQOL1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 17 Jul 2022 10:11:27 -0400
Received: from mail-ua1-x935.google.com (mail-ua1-x935.google.com [IPv6:2607:f8b0:4864:20::935])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1310C1402A
        for <linux-pci@vger.kernel.org>; Sun, 17 Jul 2022 07:11:26 -0700 (PDT)
Received: by mail-ua1-x935.google.com with SMTP id r25so4323828uap.7
        for <linux-pci@vger.kernel.org>; Sun, 17 Jul 2022 07:11:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=zXZ+c0SrBeP32v5XAviM554ozjHncSm1TMUr71kHL9w=;
        b=a636Pkgfj7pZxxlUWNSOV2CQe3333riT7B+bMl1WqPKk9IeKC+uhkUufGfSLtKsGad
         a4rdewo2QOVGLKvXDPT+Cem8YQ6dMVsf3mte8gGZrfRZdlhgWXJ0eeDomIcJNlz4ii1A
         gpNe4S7JvZaCGCRmP6AtJXbR6dvme259yJLcfSlk/429m1jccHcSgIt1BPVco0OJ3q22
         MMArRO89k6Y5Zbb1boM+fqf0CWEv7Euh7eDMqKN4TtVP7WJwnAOgqHqT/pB5OqPsNtrS
         TUua98Oh1O5u9bFaOhJaNtxLQznxZTf4qdJsIp1OwM8JNiNd+c3i2TWivJTy1+tdkODG
         zvTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=zXZ+c0SrBeP32v5XAviM554ozjHncSm1TMUr71kHL9w=;
        b=VMkukqODOJD9t3PoObRyLhPBl6lHOI9N8fzczl6old0xfeLp0wsVJ6NXAe64TWPagO
         okruljBdFwhbMt2R116qrgTCtiVfCYIu0lDvPodXUjbO6Al85jVY8cm61XTe0IGBkCoo
         HU24QQ1gcqd0XaatcEsqCtI+LBd7VIYYAvqYhiV2ntiMWLToonuCyZq9IN1dVKVST+D7
         +rE2dFZdr8KCURK6Yw2+jZ7RViKY3FQA0eWY0OVAPvgfGVHgtOwKXaYOwun9ve8Rs8Sx
         UWMWA8SrbOp4ZsM/WcnQBBMvJrKeP3plvzhrIY7DN+uiqqvYz/V7aNQWzAWitOP01kMM
         ubzg==
X-Gm-Message-State: AJIora/cRSzwYn3trkZEnQUXQw763iRh5MIZwXrkqjwfeHxJ1sqIjBcM
        4Eo6gPBPlFSnwepkGnQmqXesSE1MoUfM7KsPqZA=
X-Google-Smtp-Source: AGRyM1uae2kfGUlRLFfY8iKCqkmM49LvCOvnRCS/rqgcwszw9TuU7UtRrVaDsfgVh2C9b4qyF/tFTsbsHSSvmuZdcZY=
X-Received: by 2002:ab0:59e6:0:b0:383:6c3d:a6d5 with SMTP id
 k35-20020ab059e6000000b003836c3da6d5mr8530331uad.100.1658067085071; Sun, 17
 Jul 2022 07:11:25 -0700 (PDT)
MIME-Version: 1.0
References: <20220716233217.GA1282392@bhelgaas> <81abade2-902e-4768-8056-ac5dd0a264ce@loongson.cn>
In-Reply-To: <81abade2-902e-4768-8056-ac5dd0a264ce@loongson.cn>
From:   Huacai Chen <chenhuacai@gmail.com>
Date:   Sun, 17 Jul 2022 22:11:17 +0800
Message-ID: <CAAhV-H6G=_k0tZeK2OT2AYet5ufgOTOPHsOFOfkB6V1H46OgzQ@mail.gmail.com>
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

Hi, Bjorn,

On Sun, Jul 17, 2022 at 9:41 AM Jianmin Lv <lvjianmin@loongson.cn> wrote:
>
>
>
> On 2022/7/17 =E4=B8=8A=E5=8D=887:32, Bjorn Helgaas wrote:
> > On Sat, Jul 16, 2022 at 04:37:41PM +0800, Huacai Chen wrote:
> >> On Sat, Jul 16, 2022 at 2:12 PM Jianmin Lv <lvjianmin@loongson.cn> wro=
te:
> >>> On 2022/7/16 =E4=B8=8A=E5=8D=8811:23, Bjorn Helgaas wrote:
> >>>> On Sat, Jul 16, 2022 at 10:27:00AM +0800, Jianmin Lv wrote:
> >>>>> On 2022/7/16 =E4=B8=8A=E5=8D=8812:37, Bjorn Helgaas wrote:
> >>>>>> On Fri, Jul 15, 2022 at 04:05:12PM +0800, Jianmin Lv wrote:
> >>>>>>> On 2022/7/15 =E4=B8=8A=E5=8D=8811:44, Bjorn Helgaas wrote:
> >>>>>>>> On Thu, Jul 14, 2022 at 08:42:16PM +0800, Huacai Chen wrote:
> >>>>>>>>> From: Jianmin Lv <lvjianmin@loongson.cn>
> >>>>>>>>>
> >>>>>>>>> In LS7A, multifunction device use same PCI PIN (because the
> >>>>>>>>> PIN register report the same INTx value to each function)
> >>>>>>>>> but we need different IRQ for different functions, so add a
> >>>>>>>>> quirk to fix it for standard PCI PIN usage.
> >>>>>>>>>
> >>>>>>>>> This patch only affect ACPI based systems (and only needed
> >>>>>>>>> by ACPI based systems, too). For DT based systems, the irq
> >>>>>>>>> mappings is defined in .dts files and be handled by
> >>>>>>>>> of_irq_parse_pci().
> >>>>>>>>
> >>>>>>>> I'm sorry, I know you've explained this before, but I don't
> >>>>>>>> understand yet, so let's try again.  I *think* you're saying
> >>>>>>>> that:
> >>>>>>>>
> >>>>>>>>       - These devices integrated into LS7A all report 0 in their
> >>>>>>>>       Interrupt Pin registers.  Per spec, this means they do not
> >>>>>>>>       use INTx (PCIe r6.0, sec 7.5.1.1.13).
> >>>>>>>>
> >>>>>>>>       - However, these devices actually *do* use INTx.  Function
> >>>>>>>>       0 uses INTA, function 1 uses INTB, ..., function 4 uses
> >>>>>>>>       INTA, ...
> >>>>>>>>
> >>>>>>>>       - The quirk overrides the incorrect values read from the
> >>>>>>>>       Interrupt Pin registers.
> >>>>>>>
> >>>>>>> Yes, right.
> >>>>>
> >>>>> Sorry, I didn't see the first item here carefully, so I have to
> >>>>> correct it: all the integrated devices in 7A report 1 in PIN reg
> >>>>> instead of 0.
> >>>>
> >>>>>>>> But I'm still confused about how loongson_map_irq() gets called.=
  The
> >>>>>>>> only likely path I see is here:
> >>>>>>>>
> >>>>>>>>       pci_device_probe                            # pci_bus_type=
.probe
> >>>>>>>>         pci_assign_irq
> >>>>>>>>           pci_read_config_byte(dev, PCI_INTERRUPT_PIN, &pin)
> >>>>>>>>           if (pin)
> >>>>>>>>    bridge->swizzle_irq(dev, &pin)
> >>>>>>>>    irq =3D bridge->map_irq(dev, slot, pin)
> >>>>>>>>
> >>>>>>>> where bridge->map_irq points to loongson_map_irq().  But
> >>>>>>>> pci_assign_irq() should read 0 from PCI_INTERRUPT_PIN [1], so it
> >>>>>>>> wouldn't call bridge->map_irq().  Obviously I'm missing somethin=
g.
> >>>>>
> >>>>> Same thing, PCI_INTERRUPT_PIN reports 1, so bridge->map_irq() will =
be
> >>>>> called.
> >>>>
> >>>> OK, that makes a lot more sense, thank you!
> >>>>
> >>>> But it does leave another question: the quirk applies to
> >>>> DEV_PCIE_PORT_0 (0x7a09), DEV_PCIE_PORT_1 (0x7a19), and
> >>>> DEV_PCIE_PORT_2 (0x7a29).
> >>>>
> >>>> According to the .dtsi [1], all those root ports are at function 0,
> >>>> and if they report INTA, the quirk will also compute INTA.  So why d=
o
> >>>> you need to apply the quirk for them?
> >>>
> >>> Oh, yes, I don't think they are required either. The fix is only
> >>> required for multi-func devices of 7A.
> >>>
> >>> Huacai, we should remove PCIE ports from the patch.
> >>
> >> I agree to remove PCIE ports here. But since Bjorn has already merged
> >> this patch, and the redundant devices listed here have no
> >> side-effects, I suggest keeping it as is (but Bjorn is free to modify
> >> if necessary).
> >
> > I'd be happy to update the branch to remove the devices mentioned
> > (DEV_PCIE_PORT_x, DEV_LS7A_OHCI, DEV_LS7A_GPU).
> >
> > But the original patch [2] *only* listed DEV_PCIE_PORT_x, so I'm
> > really confused about what's going on with them.  I assume [2] fixed
> > *something*, but now we're suggesting that we don't need it.
> >
> > [2] https://lore.kernel.org/all/20210514080025.1828197-5-chenhuacai@loo=
ngson.cn/
> >
>
> Hi, Bjorn
>
> My original patch(obviously just for simple, unwilling to list so much
> devices in the patch) is following;
>
> +static void loongson_pci_pin_quirk(struct pci_dev *dev)
> +{
> +    u8 fun =3D dev->devfn & 7;
> +
> +    dev->pin =3D 1 + (fun & 3);
> +}
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_LOONGSON, PCI_ANY_ID,
> loongson_pci_pin_quirk);
> +
>
> Mybe Huacai think only PCIE ports need the fix, so he adds the PCIE
> ports in the patch when submitting it.
Yes, what Jianmin said is correct, the first version of my patch is
wrong and the current version is correct.

Huacai
>
> The things has been explained above, only multi-func devices are
> required to fix.
>
> Thanks.
>
