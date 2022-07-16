Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 040D9576D36
	for <lists+linux-pci@lfdr.de>; Sat, 16 Jul 2022 11:54:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231998AbiGPJyf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 16 Jul 2022 05:54:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbiGPJye (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 16 Jul 2022 05:54:34 -0400
Received: from mail-vk1-xa2f.google.com (mail-vk1-xa2f.google.com [IPv6:2607:f8b0:4864:20::a2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62C1EDFDA
        for <linux-pci@vger.kernel.org>; Sat, 16 Jul 2022 02:54:33 -0700 (PDT)
Received: by mail-vk1-xa2f.google.com with SMTP id bj51so2306781vkb.11
        for <linux-pci@vger.kernel.org>; Sat, 16 Jul 2022 02:54:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=C5SB/zwbik4i86HhQBfT3nalBoNUNUGeEa7w8npJ2X0=;
        b=g5ZRv4A9+TT3vOk95UvTlPqKLtYbCP/sUasIdil7WCB8Duxdai79T09lCo/pOAQxfx
         66JJA5SCPFohTDKryA2bvhw9UdKGsoog/+p70Q/jmkVTnT6LARIt9Mt7UsIjPs0ysbzx
         cXNolYNRJaDxs7TcztIl0/p8RGBfTitXAr+4ad4k1jIfxCTMUebXjHJsxYKgs8UbU8DX
         zbL7LZegW6Y6KCryD2cGoSqfZy5ZtJ3Qe2MVJtdn/6iDH1YBo6FU1f7mjNvphce7hF0o
         2uuR43arVMMT1SzcTlh2gXk0qbmur91dmdIDE8pgiXoHrHkxYYJL8HJpyD/6xr0Hf6w2
         nt+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=C5SB/zwbik4i86HhQBfT3nalBoNUNUGeEa7w8npJ2X0=;
        b=RChbHFGx2XzHfGLMACci9l2jr5vzMOPOHP0PJS1H/qFJcEf5uSjYDs0pI8eBIVsIpy
         MUxt3Eo6GX7sEHOdVqs5GkgvrwMJwjgu0ZBDw2YEMGfLhLfHqMPwL1WUCnssHL+Rbp2V
         vafGr2WB135TrybxDrRXksZFV1pS5iQo47hbuj/fF5Vv9SG7vkPaEkfTbkEkVZRQhUg9
         e7LERrBU5qQJUDhmkv3XUtcOirgSXEtLFuts2yuMqwBOINo2XwMvhDuxK99HCd+zQJtg
         zkYGvq/jYAyrhqzaGfU+1uHo1eQiPkdSTjgv+Oo+GR1dou4UJGxnIgTjiH4eFwpzAsaK
         SsNQ==
X-Gm-Message-State: AJIora8mu/Lp8zPzv48zOHKaGxzEaSJscS1piw5ZbJo2WIvT/tquF52m
        gGUZh5f35INul42nDk6clAnWxUBEvu7hMgQigSY=
X-Google-Smtp-Source: AGRyM1sgncPRElp2m6SKRpU3QJCUEUyuCgaX0vtEIQ/lL8oD3B7dUnjZfjdCuOH0Sxa3aevUAE17Kzx9E1FpD/I9ics=
X-Received: by 2002:a1f:a887:0:b0:36c:8458:b061 with SMTP id
 r129-20020a1fa887000000b0036c8458b061mr6737853vke.19.1657965272483; Sat, 16
 Jul 2022 02:54:32 -0700 (PDT)
MIME-Version: 1.0
References: <20220714124216.1489304-1-chenhuacai@loongson.cn> <20220715221816.GA1203890@bhelgaas>
In-Reply-To: <20220715221816.GA1203890@bhelgaas>
From:   Huacai Chen <chenhuacai@gmail.com>
Date:   Sat, 16 Jul 2022 17:54:19 +0800
Message-ID: <CAAhV-H5wQfGJFcR9DOACSPSTNDzoKVYcXNs7KNpQwCj2XZ65Hg@mail.gmail.com>
Subject: Re: [PATCH V16 0/7] PCI: Loongson pci improvements and quirks
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Huacai Chen <chenhuacai@loongson.cn>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        Jianmin Lv <lvjianmin@loongson.cn>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Tiezhu Yang <yangtiezhu@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
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

On Sat, Jul 16, 2022 at 6:18 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> On Thu, Jul 14, 2022 at 08:42:09PM +0800, Huacai Chen wrote:
> > This patchset improves Loongson PCI controller driver and resolves some
> > problems: LS2K/LS7A's PCI config space supports 1/2/4-bytes access, so
> > the first patch use pci_generic_config_read()/pci_generic_config_write()
> > for them; the second patch add ACPI init support which will be used by
> > LoongArch; the third patch improves the mrrs quirk for LS7A chipset; The
> > fourth patch add a new quirk for LS7A chipset to avoid poweroff/reboot
> > failure, and the fifth patch add a new quirk for LS7A chipset to fix the
> > multifunction devices' irq pin mappings.
> > ...
>
> > Huacai Chen, Tiezhu Yang and Jianmin Lv(6):
> >  PCI/ACPI: Guard ARM64-specific mcfg_quirks
> >  PCI: loongson: Use generic 8/16/32-bit config ops on LS2K/LS7A.
> >  PCI: loongson: Add ACPI init support.
> >  PCI: loongson: Don't access non-existant devices.
> >  PCI: Add quirk for multifunction devices of LS7A.
>
> I applied the above to pci/ctrl/loongson to get them out of the way.
Thank you very much!

>
> >  PCI: loongson: Improve the MRRS quirk for LS7A.
> >  PCI: Add quirk for LS7A to avoid reboot failure.
>
> These touch core code in some sort of ugly ways and I'm still thinking
> about them.
Yes, it is ugly, but I hope it can be solved in some way, at least the
MRRS problem is not only Loongson-specific and can be shared by
others.

Huacai
