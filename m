Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75F32414F94
	for <lists+linux-pci@lfdr.de>; Wed, 22 Sep 2021 20:07:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236945AbhIVSJU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 22 Sep 2021 14:09:20 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:43567 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236943AbhIVSJT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 22 Sep 2021 14:09:19 -0400
Received: from mail-wr1-f52.google.com ([209.85.221.52]) by
 mrelayeu.kundenserver.de (mreue109 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MO9r5-1mDM7h1MCX-00OVpH; Wed, 22 Sep 2021 20:07:48 +0200
Received: by mail-wr1-f52.google.com with SMTP id t8so9609785wri.1;
        Wed, 22 Sep 2021 11:07:48 -0700 (PDT)
X-Gm-Message-State: AOAM531EvrZsZ/MJwvsnNHroTDltQ1C5RFYgcWJV8Zm+xMTB55KASgPe
        POCO+huxo8wz/7di8HxSbCmSXilanw+3MIeGNqk=
X-Google-Smtp-Source: ABdhPJxefGoFSv5mbWEbjSxVO7l7TV7dRfGNx9j+Tk9BFQvOVsDSTR9Sbgfrbt8kzfTLzbvI3ZJIrLmP2e+7OX9g2CQ=
X-Received: by 2002:a5d:4b50:: with SMTP id w16mr351144wrs.71.1632334067884;
 Wed, 22 Sep 2021 11:07:47 -0700 (PDT)
MIME-Version: 1.0
References: <20210922042041.16326-1-sergio.paracuellos@gmail.com>
 <CAK8P3a2WPOYS7ra_epyZ_bBBpPK8+AgEynK0pKOUZ6ajubcHew@mail.gmail.com> <CAMhs-H8EyBmahhLsx+a0aoy+znY=PCm4BT97UBg4xcAy3x2oXg@mail.gmail.com>
In-Reply-To: <CAMhs-H8EyBmahhLsx+a0aoy+znY=PCm4BT97UBg4xcAy3x2oXg@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 22 Sep 2021 20:07:31 +0200
X-Gmail-Original-Message-ID: <CAK8P3a0fQZvpNCKF7OUy_krC_YPyigtd5Ak_AMXXpx84HKMswA@mail.gmail.com>
Message-ID: <CAK8P3a0fQZvpNCKF7OUy_krC_YPyigtd5Ak_AMXXpx84HKMswA@mail.gmail.com>
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
X-Provags-ID: V03:K1:3uUo8NMwM2S2a/uvloOvVOnQq0MPX/jY5hR7RsDtM5WPQzA/qo0
 NdxezEg4/W6nPzo37ydklPX1d2p5O3yhJOspvzEwNOea/Y9epQuF8pEo8HJA35jxkfWQr60
 BtwATr9trm4m4eyjtt+eld1bze0EK3tV6VI7XwEiBnTns+OAV8k44tY3JzEgjTMf04KZ8W9
 uS6nfahotLdp39xGumlYw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:LcwMq24g7nY=:/BLgL2kznKy7LZE5Q/uZj/
 HRC9D/pnW7ctRvDooRpFHPx/dTvCv549ng688FSwACOGeJjc6oAhmEKy4YlJC/T0Nz9ahI3Ce
 8QD4FGioJ4i6HtnL8Y5hm3PbYWFCrYsl0bZSQ5KYgA3/c1+7d9wVl48ERp5bYZeBa/dPxp5kC
 LzMhNUokxEW61Qb9fYm9pZjVz1jsX6gSzZChqN04F3A4sBEprjy3Axq2emTr8zGhUnpv8tcF3
 0QGIAc+I8Yt9jTyG20H2yu3NpOw/rL1EeavWdziVWGd47hnUPf1dKHOXXyIaJj5x75z3J6gL+
 /6GA7U2AaJEsK9QLbDaDWNAdqdnXMyYlMh1oINQ0NNXrujQK3ijMhKwiR7NbdJt/3cFd0pirg
 2t18kiKfqAX8hEDOYZZkm7gzpdPXuWz603MerSrEXmzEKzc3OUup5yXTkXB3P+Wz0jmh/ZH71
 EfKAMjEgYBgYzC4yQRJasfCPE9/sRZj3p8hM7PYWvc0/P9A7xDgWud6P1JV5vFViR+RkgH5Qc
 5v9hc1JeN9DFCJyiNiCbmCRCPtQRWumFZ6+4aPruSPHYJtR78Jff6z3sQ+a318hyMOhzALMYV
 muX0yU1LsK/JGFu4JkwOKK/yyvS8SSeyKAmTT/qE4Rp25+2XsgJKM5LYyf2SrEAIubXAOYwSf
 /OTR375d7pLBA/s+uY6/ofLUEAVePMWSfuDgTBRPbnbP/Cu96WPTspMIBinsGWRuCE1kAMuIV
 wsMaxZd8ZeQWb8Ydl/06nrHSbInCSh3Q7Bw2FZJG70jZW1lS0dqNGSgaS0SR7frqYay+tTqX6
 nazcbzLsDngs2It77K7jxSYmLPFUZuGL6KdYVWL0q2dS86LKW5POeie8cjpdTtOxivru5rcB5
 JRZx8e9kYw87ULdun+Iw==
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Sep 22, 2021 at 7:42 PM Sergio Paracuellos
<sergio.paracuellos@gmail.com> wrote:
> On Wed, Sep 22, 2021 at 5:47 PM Arnd Bergmann <arnd@arndb.de> wrote:
> >
> > I'm not completely sure where your platform fits in here, it sounds like you
> > address them using a machine specific physical address as the base in
> > inb() plus the port number as an offset, is that correct?
>
> I guess none of the above options? I will try to explain this as per
> my understanding.
>
> [+cc Thomas Bogendoerfer as mips maintainer and with better knowledge
> of mips platforms than me]
>
> On MIPS I/O ports are memory mapped, so we access them using normal
> load/store instructions.
> Mips 'plat_mem_setup()' function does a 'set_io_port_base(KSEG1)'.
> There, variable 'mips_io_port_base'
> is set then using this address which is a virtual address to which all
> ports are being mapped.
> KSEG1 addresses are uncached and are not translated by the MMU. This
> KSEG1 range is directly mapped in physical space starting with address
> 0x0.
> Because of this reason, defining PCI_IOBASE as KSEG1 won't work since,
> at the end 'pci_parse_request_of_pci_ranges' tries to remap to a fixed
> virtual address (PCI_IOBASE). This can't work for KSEG1 addresses.
> What happens if I try to do that is that I get bad addresses at pci
> enumeration for IO resources. Mips ralink mt7621 SoC (which is the one
> I am using and trying to mainline the driver from staging) have I/O at
> address 0x1e160000. So instead of getting this address for pcie IO
> BARS I get a range from 0x0000 to 0xffff since 'pci_adress_to_pio' in
> that case got that range 0x0-0xffff which is wrong. To have this
> working this way we would need to put PCI_IOBASE somewhere into KSEG2
> which will result in creating TLB entries for IO addresses, which most
> of the time isn't needed on MIPS because of access via KSEG1. Instead
> of that, what happens when I avoid defining PCI_IOBASE and set
> IO_SPACE_LIMIT  (See [0] and [1] commits already added to staging tree
> which was part of this patch series for context of what works with
> this patch together) all works properly. There have also been some
> patches accepted in the past which avoid this
> 'pci_parse_request_of_pci_ranges' call since it is not working for
> most pci legacy drivers of arch/mips for ralinks platform [2].
>
> So I am not sure what should be the correct approach to properly make
> this work (this one works for me and I cannot see others better) but I
> will be happy to try whatever you propose for me to do.

Ok, thank you for the detailed explanation.

I suppose you can use the generic infrastructure in asm-generic/io.h
if you "#define PCI_IOBASE mips_io_port_base". In this case, you
should have an architecture specific implementation of
pci_remap_iospace() that assigns mips_io_port_base.
pci_remap_iospace() was originally meant as an architecture
specific helper, but it moved into generic code after all architectures
had the same requirements. If MIPS has different requirements,
then it should not be shared.

I don't yet understand how you deal with having multiple PCIe
host bridge devices if they have distinct I/O port ranges.
Without remapping to dynamic virtual addresses, does
that mean that every MMIO register between the first and
last PCIe bridge also shows up in /dev/ioport? Or do you
only support port I/O on the first PCIe host bridge?

Note that you could also decide to completely sidestep the
problem by just defining port I/O to be unavailable on MIPS
when probing a generic host bridge driver. Most likely this
is never going to be used anyway, and it will be rather hard
to test if you don't already have the need ;-)

         Arnd
