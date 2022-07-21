Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD47557C3A3
	for <lists+linux-pci@lfdr.de>; Thu, 21 Jul 2022 06:47:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229692AbiGUEre (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 21 Jul 2022 00:47:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230153AbiGUErd (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 21 Jul 2022 00:47:33 -0400
Received: from mail-vk1-xa35.google.com (mail-vk1-xa35.google.com [IPv6:2607:f8b0:4864:20::a35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEF6478DF1
        for <linux-pci@vger.kernel.org>; Wed, 20 Jul 2022 21:47:32 -0700 (PDT)
Received: by mail-vk1-xa35.google.com with SMTP id bj51so222016vkb.11
        for <linux-pci@vger.kernel.org>; Wed, 20 Jul 2022 21:47:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=+wDtSMvaGT9cozgx3BpgGVYilHQTZKkicONwxvtTdRE=;
        b=pzjO1KAITpvONOUI0bKGYIxFNdmBHJEPUwG+Rqqx98IkyDO8Y3Cr9ypzsKgEWHCjfj
         9attAkyiGO79EAI/R69nwkyIthRnU737DHLnanoCmvUfpw4Q/ZQIDZy4NtjKgZQho3gd
         7BNLn8VusNcxczRx+PB8mJMyMPHVC3JATbuDzPRZV9M1pwoW3SzAIujGz3c8hZLlQc/P
         7RNijr/g89hD2DsWhoLBbCHTPrbVPdF2qWqFgJVD/eBuEmMDeI85PCrd7OMJAM/szM6D
         MvdG1WeIzuF2t2G9Vkk8gv+52P8efMH5jGHZXQnBPzEwpZZhHnKkz2oZLdL/WntEZCjF
         x6Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=+wDtSMvaGT9cozgx3BpgGVYilHQTZKkicONwxvtTdRE=;
        b=cxexREOLkRz/+Ui4s8TEkJq7dOnQ63V/MukqyvyUWo2kQSZp3QXtnT7waIwXsUHoJQ
         +YIA69eXrEm+tcxtrg3gcUdR0WDR6WdVaWv+rFLAq59r6U+Ua9+yN46es0ngxWA12SUX
         Do6NP71nwGQr8910dvFQW4GIUf9h8ECKedD6k61OPotAzjm7gMpzQnAmQhDoZCDKB7wH
         XZtwoosrP8U2x98vuWvFqKBil30nxnqLjr2CPy0GRQu1oDc+EcqcsnfE4vYVBX4j2HjN
         mu645jvgs+KvwFjpov4PAc7qzljUPgz6ifqHwJDcTzcOetu6IM2oZ8I3bnx1AryQkYye
         65VA==
X-Gm-Message-State: AJIora//sH0esDKOAWh0+7p+AoGrHgxmCg2bzoCOjuzMZB53n9tU0YrT
        JIsvmEtyOIgvhoOOaWMpZ/dVg1vyPfuzeWBswkot5znH2dqsyQ==
X-Google-Smtp-Source: AGRyM1uZai4YfjJE6AC+jQVwTvSC1PZ4RBW7D+h5BxhB910iCqbNsdl2mX9c6mCKojxO7FKhfbbFEHqyQ8Yn16u0M6A=
X-Received: by 2002:a05:6122:1825:b0:376:78:5015 with SMTP id
 ay37-20020a056122182500b0037600785015mr198735vkb.18.1658378851641; Wed, 20
 Jul 2022 21:47:31 -0700 (PDT)
MIME-Version: 1.0
References: <CAAhV-H6G=_k0tZeK2OT2AYet5ufgOTOPHsOFOfkB6V1H46OgzQ@mail.gmail.com>
 <20220718170029.GA1425737@bhelgaas>
In-Reply-To: <20220718170029.GA1425737@bhelgaas>
From:   Huacai Chen <chenhuacai@gmail.com>
Date:   Thu, 21 Jul 2022 12:47:18 +0800
Message-ID: <CAAhV-H40_o+9KS1t67O98GusM38pDaiB4bssxd3KQZpAByfnLg@mail.gmail.com>
Subject: Re: [PATCH V16 7/7] PCI: Add quirk for multifunction devices of LS7A
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Jianmin Lv <lvjianmin@loongson.cn>,
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

On Tue, Jul 19, 2022 at 1:00 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> On Sun, Jul 17, 2022 at 10:11:17PM +0800, Huacai Chen wrote:
> > On Sun, Jul 17, 2022 at 9:41 AM Jianmin Lv <lvjianmin@loongson.cn> wrot=
e:
> > > On 2022/7/17 =E4=B8=8A=E5=8D=887:32, Bjorn Helgaas wrote:
> > > > On Sat, Jul 16, 2022 at 04:37:41PM +0800, Huacai Chen wrote:
> > > >> On Sat, Jul 16, 2022 at 2:12 PM Jianmin Lv <lvjianmin@loongson.cn>=
 wrote:
> > > >>> On 2022/7/16 =E4=B8=8A=E5=8D=8811:23, Bjorn Helgaas wrote:
> > > >>>> On Sat, Jul 16, 2022 at 10:27:00AM +0800, Jianmin Lv wrote:
> > > >>>>> On 2022/7/16 =E4=B8=8A=E5=8D=8812:37, Bjorn Helgaas wrote:
> > > >>>>>> On Fri, Jul 15, 2022 at 04:05:12PM +0800, Jianmin Lv wrote:
> > > >>>>>>> On 2022/7/15 =E4=B8=8A=E5=8D=8811:44, Bjorn Helgaas wrote:
> > > >>>>>>>> On Thu, Jul 14, 2022 at 08:42:16PM +0800, Huacai Chen wrote:
> > > >>>>>>>>> From: Jianmin Lv <lvjianmin@loongson.cn>
> > > >>>>>>>>>
> > > >>>>>>>>> In LS7A, multifunction device use same PCI PIN (because the
> > > >>>>>>>>> PIN register report the same INTx value to each function)
> > > >>>>>>>>> but we need different IRQ for different functions, so add a
> > > >>>>>>>>> quirk to fix it for standard PCI PIN usage.
> > > >>>>>>>>>
> > > >>>>>>>>> This patch only affect ACPI based systems (and only needed
> > > >>>>>>>>> by ACPI based systems, too). For DT based systems, the irq
> > > >>>>>>>>> mappings is defined in .dts files and be handled by
> > > >>>>>>>>> of_irq_parse_pci().
> > > >>>>>>>>
> > > >>>>>>>> I'm sorry, I know you've explained this before, but I don't
> > > >>>>>>>> understand yet, so let's try again.  I *think* you're saying
> > > >>>>>>>> that:
> > > >>>>>>>>
> > > >>>>>>>>       - These devices integrated into LS7A all report 0 in t=
heir
> > > >>>>>>>>       Interrupt Pin registers.  Per spec, this means they do=
 not
> > > >>>>>>>>       use INTx (PCIe r6.0, sec 7.5.1.1.13).
> > > >>>>>>>>
> > > >>>>>>>>       - However, these devices actually *do* use INTx.  Func=
tion
> > > >>>>>>>>       0 uses INTA, function 1 uses INTB, ..., function 4 use=
s
> > > >>>>>>>>       INTA, ...
> > > >>>>>>>>
> > > >>>>>>>>       - The quirk overrides the incorrect values read from t=
he
> > > >>>>>>>>       Interrupt Pin registers.
> > > >>>>>>>
> > > >>>>>>> Yes, right.
> > > >>>>>
> > > >>>>> Sorry, I didn't see the first item here carefully, so I have to
> > > >>>>> correct it: all the integrated devices in 7A report 1 in PIN re=
g
> > > >>>>> instead of 0.
> > > >>>>
> > > >>>>>>>> But I'm still confused about how loongson_map_irq() gets cal=
led.  The
> > > >>>>>>>> only likely path I see is here:
> > > >>>>>>>>
> > > >>>>>>>>       pci_device_probe                            # pci_bus_=
type.probe
> > > >>>>>>>>         pci_assign_irq
> > > >>>>>>>>           pci_read_config_byte(dev, PCI_INTERRUPT_PIN, &pin)
> > > >>>>>>>>           if (pin)
> > > >>>>>>>>    bridge->swizzle_irq(dev, &pin)
> > > >>>>>>>>    irq =3D bridge->map_irq(dev, slot, pin)
> > > >>>>>>>>
> > > >>>>>>>> where bridge->map_irq points to loongson_map_irq().  But
> > > >>>>>>>> pci_assign_irq() should read 0 from PCI_INTERRUPT_PIN [1], s=
o it
> > > >>>>>>>> wouldn't call bridge->map_irq().  Obviously I'm missing some=
thing.
> > > >>>>>
> > > >>>>> Same thing, PCI_INTERRUPT_PIN reports 1, so bridge->map_irq() w=
ill be
> > > >>>>> called.
> > > >>>>
> > > >>>> OK, that makes a lot more sense, thank you!
> > > >>>>
> > > >>>> But it does leave another question: the quirk applies to
> > > >>>> DEV_PCIE_PORT_0 (0x7a09), DEV_PCIE_PORT_1 (0x7a19), and
> > > >>>> DEV_PCIE_PORT_2 (0x7a29).
> > > >>>>
> > > >>>> According to the .dtsi [1], all those root ports are at function=
 0,
> > > >>>> and if they report INTA, the quirk will also compute INTA.  So w=
hy do
> > > >>>> you need to apply the quirk for them?
> > > >>>
> > > >>> Oh, yes, I don't think they are required either. The fix is only
> > > >>> required for multi-func devices of 7A.
> > > >>>
> > > >>> Huacai, we should remove PCIE ports from the patch.
> > > >>
> > > >> I agree to remove PCIE ports here. But since Bjorn has already mer=
ged
> > > >> this patch, and the redundant devices listed here have no
> > > >> side-effects, I suggest keeping it as is (but Bjorn is free to mod=
ify
> > > >> if necessary).
> > > >
> > > > I'd be happy to update the branch to remove the devices mentioned
> > > > (DEV_PCIE_PORT_x, DEV_LS7A_OHCI, DEV_LS7A_GPU).
> > > >
> > > > But the original patch [2] *only* listed DEV_PCIE_PORT_x, so I'm
> > > > really confused about what's going on with them.  I assume [2] fixe=
d
> > > > *something*, but now we're suggesting that we don't need it.
> > > >
> > > > [2] https://lore.kernel.org/all/20210514080025.1828197-5-chenhuacai=
@loongson.cn/
> > >
> > > My original patch(obviously just for simple, unwilling to list so muc=
h
> > > devices in the patch) is following;
> > >
> > > +static void loongson_pci_pin_quirk(struct pci_dev *dev)
> > > +{
> > > +    u8 fun =3D dev->devfn & 7;
> > > +
> > > +    dev->pin =3D 1 + (fun & 3);
> > > +}
> > > +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_LOONGSON, PCI_ANY_ID,
> > > loongson_pci_pin_quirk);
> > > +
> > >
> > > Mybe Huacai think only PCIE ports need the fix, so he adds the PCIE
> > > ports in the patch when submitting it.
> >
> > Yes, what Jianmin said is correct, the first version of my patch is
> > wrong and the current version is correct.
>
> Thanks for clearing that up.  I dropped DEV_PCIE_PORT_x,
> DEV_LS7A_OHCI, DEV_LS7A_GPU from the quirk.
Unfortunately, this patch only lists devices in LS7A1000, but some of
LS7A2000 (GNET and HDMI) also need to quirk, can they be squashed in
this patch? If not, we will add them in a new patch.

 #define DEV_LS7A_CONF  0x7a10
 #define DEV_LS7A_LPC   0x7a0c
 #define DEV_LS7A_GMAC  0x7a03
+#define DEV_LS7A_GNET  0x7a13
 #define DEV_LS7A_DC1   0x7a06
 #define DEV_LS7A_DC2   0x7a36
 #define DEV_LS7A_GPU   0x7a15
 #define DEV_LS7A_AHCI  0x7a08
 #define DEV_LS7A_EHCI  0x7a14
 #define DEV_LS7A_OHCI  0x7a24
+#define DEV_LS7A_HDMI  0x7a37

Huacai
