Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97BF74175B0
	for <lists+linux-pci@lfdr.de>; Fri, 24 Sep 2021 15:29:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346385AbhIXNao (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 24 Sep 2021 09:30:44 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:41313 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346336AbhIXN3v (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 24 Sep 2021 09:29:51 -0400
Received: from mail-wr1-f48.google.com ([209.85.221.48]) by
 mrelayeu.kundenserver.de (mreue011 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MAOa3-1mag3W2lER-00BpjM; Fri, 24 Sep 2021 15:28:09 +0200
Received: by mail-wr1-f48.google.com with SMTP id g16so27553301wrb.3;
        Fri, 24 Sep 2021 06:28:09 -0700 (PDT)
X-Gm-Message-State: AOAM531JzVzegRlpxGPH+wyu4hsB4T/Y0BeOINPthGOku+n4r/l3o70s
        AG8Mscyc1ZR2OVTeqEQYJ1E0pVDdhAXahOMyN3w=
X-Google-Smtp-Source: ABdhPJzM3QVWlDWl9O9PVMbkk54ItVxgQmlG7vgvUmkivSCUC8cK58oe7WVemGT0uxg3hhg7v6G/Qeb1GuFgaELom84=
X-Received: by 2002:a05:600c:3209:: with SMTP id r9mr2123128wmp.35.1632490089268;
 Fri, 24 Sep 2021 06:28:09 -0700 (PDT)
MIME-Version: 1.0
References: <20210922042041.16326-1-sergio.paracuellos@gmail.com>
 <CAK8P3a2WPOYS7ra_epyZ_bBBpPK8+AgEynK0pKOUZ6ajubcHew@mail.gmail.com>
 <CAMhs-H8EyBmahhLsx+a0aoy+znY=PCm4BT97UBg4xcAy3x2oXg@mail.gmail.com>
 <CAK8P3a0fQZvpNCKF7OUy_krC_YPyigtd5Ak_AMXXpx84HKMswA@mail.gmail.com>
 <CAMhs-H-OCm1p6mTTV6s=vPx7FV8+1UMzx0X00wvXkW=5OgFQBQ@mail.gmail.com>
 <CAK8P3a1iN76A5ahTTQ6rCS4LjKHz8grkNGHGehLJnd0xQSnHXA@mail.gmail.com>
 <CAMhs-H_hZk3hruCaWRjKjUSj6vhVE+JZfk9nT7v1=mcc-H9wnw@mail.gmail.com>
 <CAK8P3a3C0rG_JWWCU6T4B=+j2-+6S6Gq+aw_9e6XeVun9LoF0w@mail.gmail.com>
 <CAMhs-H8kH7CMXENqDW_6GLTjeMMyk+ynehMmyBr=kFZPFHpM0A@mail.gmail.com>
 <CAK8P3a2WmNsV9fhSEjqwHZAGkwGc9HOurhQsza7JOM2Scts2XQ@mail.gmail.com>
 <CAMhs-H8fRnLavLfdw7jZO0tb8rWqdF81cGHhYT6gGp4UY1gChg@mail.gmail.com>
 <CAK8P3a2MJO--xmAZ_71h1QQ5_b8WXgyo-=LaT7r7yMMBUHoPfQ@mail.gmail.com>
 <CAMhs-H_xdkpinyj-Y1u==ievpGWZ2Ze-_U7aCUcfu0=NKBq2xQ@mail.gmail.com>
 <CAK8P3a0OWyW9Wk0kHXsj_7qTd0fVXQnszzun+HacHeTKYETXhw@mail.gmail.com>
 <CAMhs-H9xrXgbuwYe2STzuq0aBwj0onJGc0Oka6+pzgoHb0j8rA@mail.gmail.com>
 <CAK8P3a1AwaSi_J9p4tKwNKxENHhwofDu=Ma=F29ajSmMXoC7RA@mail.gmail.com>
 <CAMhs-H_wxoJC7ZVnkhXNfAcP-P9BNN99ogszM_iJhErHLq8Rdg@mail.gmail.com>
 <CAK8P3a3dvhWT=Xq22xTNn_VbX29s3t9wrw1DbffPbWuHxtTTmg@mail.gmail.com> <CAMhs-H9OhXHA3_mq2PSoaPvYCstqqHL7TfL0zf=OFNeFmWVTRQ@mail.gmail.com>
In-Reply-To: <CAMhs-H9OhXHA3_mq2PSoaPvYCstqqHL7TfL0zf=OFNeFmWVTRQ@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 24 Sep 2021 15:27:53 +0200
X-Gmail-Original-Message-ID: <CAK8P3a36jiomsqSr0rP8_BL8HwceKvV78bT2Ym+iomSGyYuOGA@mail.gmail.com>
Message-ID: <CAK8P3a36jiomsqSr0rP8_BL8HwceKvV78bT2Ym+iomSGyYuOGA@mail.gmail.com>
Subject: Re: [PATCH v3] PCI: of: Avoid pci_remap_iospace() when PCI_IOBASE not defined
To:     Sergio Paracuellos <sergio.paracuellos@gmail.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        linux-pci <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-staging@lists.linux.dev, gregkh <gregkh@linuxfoundation.org>,
        Liviu Dudau <Liviu.Dudau@arm.com>,
        Rob Herring <robh@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:lafR+mO3UZb1YFf+DrI3x6jjpqg0gsuDBWVFOntUdysQu4jUaNT
 HUg/svMo25P89YNMWtnNiZMXQFJnn0JUy3wglGpIFqvxGELqhliEaLruxgEa3t7CqOD1k37
 GpAKsZsWCiylcfefuoC90ZxbE82hJ/gIneCakStAs+yk46Sl/s72kjuyldEF/mH4uiiD1IQ
 EArmwrdA/ILo1Pu5/Iw1A==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:0E6B8r4kG2k=:3c/e4aHr09h+pBC2sA5ipf
 Z3j/Wyj+hvUZyXq5AxVBrHZkHEJCKf+lHwQjsC++hCtxXNiOty0IFk21PAXsy/T5gE0jzw2eL
 73UfFZo6HdVFtBxpku8zh+O7OJ7obzgZjOPhe2xMSG5JO3d3kKQb5KOb4cdj75bNBCQh8P3eF
 Ir3uyEPYZk5XKadIK1Y2XTDTF21WGZo6t+5gpXvJrJcbo3UQA0U4QDI1UrKhtxThwog328YvK
 CZFZnrgpDhLp7GthjF2aaXbWrakMQcCO2EtlNj7vgSlNLRqxGavsBYZGx9PZcnJ9cxk36faZw
 oOkOgYg/W/divhpT10Mk3UH9hc/pW8rYzqoEJ9dEDIsLM/NbEd1JMMNgscwNBRc2kl5wcxxrI
 MtapDA5INo5cI6KDcT0l4RPWf6Dwqr9SLmEPlMNwfZ/vy4PkRGtb9sdkIX5QH3lIknVoXg7R5
 /r7RAch+9fsI9VSAhDkM9AeUkyRqmhGGMn7/JjG5D0SV+5iYtgMt1NDmXxUpDSCPlCodazMv0
 z3aY5Ag6CFj1mhTex4ycVYDIT7AdDCQjKd3BpjmUcWc6P8GuBbrGm1hPb9w0oB3Xs7fYw/Y9A
 wxMZ6vl0tlVTWkPteCh+bQrjXfu5Po9D5w1rE0ppz4pXnjjOScJvcjaHIPHkqYaN/LHT8u5R4
 eq5ZUBi2YBbvoE2PYHS7bHYlBNjuBE45GY7P1x9SHZlz9QasssgVu+frsM75IrmUe6OVp5K0v
 QmGw4XnQO0K+gGKeaxoeepVSen1RCKG1VBeR7g==
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Sep 24, 2021 at 2:46 PM Sergio Paracuellos
<sergio.paracuellos@gmail.com> wrote:
> On Fri, Sep 24, 2021 at 1:39 PM Arnd Bergmann <arnd@arndb.de> wrote:
> > On Fri, Sep 24, 2021 at 12:15 PM Sergio Paracuellos
>
> > I meant RALINK_PCI_IOBASE. We do need to write both, to clarify:
> >
> > RALINK_PCI_IOBASE must be set to match the *bus* address in DT,
> > so ideally '0', but any value should work as long as these two match.
> >
> > PCI_IOBASE/mips_io_port_base must be set to the *CPU* address
> > in DT, so that must be 0x1e160000, possibly converted from
> > physical to a virtual __iomem address (this is where my MIPS
> > knowledge ends).
>
> Understood. I have tried the following:
>
> I have added the following at the beggining of the pci host driver to
> match what you are describing above:
>
> unsigned long vaddr = (unsigned long)ioremap(PCI_IOBASE, 0x10000);
> set_io_port_base(vaddr);
>
> dev_info(dev, "Setting base to PCI_IOBASE: 0x%x -> mips_io_port_base
> 0x%lx", PCI_IOBASE, mips_io_port_base);
>
> PCI_IOBASE is the physical cpu address. Hence, 0x1e160000
> set_io_port_base sets 'mips_io_port_base' to the virtual address where
> 'PCI_IOBASE' has been mapped (vaddr).

Ok, sounds good. I would still suggest using
"#define PCI_IOBASE mips_io_port_base", so it has the same meaning
as on other architectures (the virtual address of port 0), and replace
the hardcoded base with the CPU address you read from DT to
make that code more portable. As a general rule, DT-enabled drivers
should contain no hardcoded addresses.

> However, nothing seems to change:
>
> mt7621-pci 1e140000.pcie: Setting base to PCI_IOBASE: 0x1e160000 ->
> mips_io_port_base 0xbe160000
>                                                 ^^^
>                                                  This seems aligned
> with what you are saying. mips_io_port_base have now a proper virtual
> addr for 0x1e160000

Ok.

            Arnd
