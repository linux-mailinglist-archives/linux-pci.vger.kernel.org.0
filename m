Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A2BE4150D2
	for <lists+linux-pci@lfdr.de>; Wed, 22 Sep 2021 21:57:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237272AbhIVT7N (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 22 Sep 2021 15:59:13 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:40855 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230384AbhIVT7L (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 22 Sep 2021 15:59:11 -0400
Received: from mail-wr1-f45.google.com ([209.85.221.45]) by
 mrelayeu.kundenserver.de (mreue009 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MQeIA-1mGZb33T8A-00Ni6h; Wed, 22 Sep 2021 21:57:39 +0200
Received: by mail-wr1-f45.google.com with SMTP id q11so10280436wrr.9;
        Wed, 22 Sep 2021 12:57:39 -0700 (PDT)
X-Gm-Message-State: AOAM531Y9aCt+iljtF5koULIBOWD6fCTweUghWfw1tHxu19nfhUOPuuM
        rrDL5y5LigSlvYvy0XqXFmGhU6UCFS1p1T3UDew=
X-Google-Smtp-Source: ABdhPJwgGZ9USpTQcbjF1tGcTxsBwqBG1jppN6hfyIkZHEanRUZjCnfn1k1S8QsRU2t3uS2PlP2EINDKZA9arVayJqE=
X-Received: by 2002:adf:f481:: with SMTP id l1mr780247wro.411.1632340659471;
 Wed, 22 Sep 2021 12:57:39 -0700 (PDT)
MIME-Version: 1.0
References: <20210922042041.16326-1-sergio.paracuellos@gmail.com>
 <CAK8P3a2WPOYS7ra_epyZ_bBBpPK8+AgEynK0pKOUZ6ajubcHew@mail.gmail.com>
 <CAMhs-H8EyBmahhLsx+a0aoy+znY=PCm4BT97UBg4xcAy3x2oXg@mail.gmail.com>
 <CAK8P3a0fQZvpNCKF7OUy_krC_YPyigtd5Ak_AMXXpx84HKMswA@mail.gmail.com> <CAMhs-H-OCm1p6mTTV6s=vPx7FV8+1UMzx0X00wvXkW=5OgFQBQ@mail.gmail.com>
In-Reply-To: <CAMhs-H-OCm1p6mTTV6s=vPx7FV8+1UMzx0X00wvXkW=5OgFQBQ@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 22 Sep 2021 21:57:23 +0200
X-Gmail-Original-Message-ID: <CAK8P3a1iN76A5ahTTQ6rCS4LjKHz8grkNGHGehLJnd0xQSnHXA@mail.gmail.com>
Message-ID: <CAK8P3a1iN76A5ahTTQ6rCS4LjKHz8grkNGHGehLJnd0xQSnHXA@mail.gmail.com>
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
X-Provags-ID: V03:K1:Vmowgu0XWiJ4bAK8Io1z9vQonQ3WT9BpZHzLYActjCAmG7dhpOg
 5aLXJq2etKcO2+UOZ8HjCDfi5t9QBfK67S4KHeELZjM/vf/7UrNs8GUMA+ZCKShQhDeUNAC
 hhAHGLbE0Oa5nYJyXcuvpnxGHOQ/a3C7XSyDborNrwRwp0cQaImVLPxNzqKc888xNGXRTGp
 yKEsUaJtmw7gnaM36cb7Q==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:TfSwbDUQHuc=:2I1Fe8O0sZmCDYL90fPwe1
 QvBoE7xYGXVmj8KKCYB1FvgS0jY/WiVi9m1R+lBbZJ+lmLCHDlTFiMNwdQKEzSlxSGGMKcr5a
 F7wq3UsZNBFWSTSiBvAjbWwyp8rpffI3prhBSDv0Tjs1h5vtvZADmSuLpPJISYb+6p6gWjkex
 MVCPAMvvaOmXAD+gU1fvfICXSwa7FBxyG/XyRjUK7Wj9B198edOR/tPlRR/QDywsL9GEw1kv0
 pYApY1yA3MuElXMziS+XyAMw9iIXF/R69DC+0LYsTYVH/xkTw9Ce81TJuknrGCsvvwA9NcsPc
 JhH2Ao+XNoJErZGLrUasUwDFhc4fcvXthj/evWD06CiVCYWiI0yKzkTWydKX6oU4h4K46sfxA
 T360SgsAySzzO+aWj2Q8HBYByiHA6n/Kz63ey2a/+6EmdpyeJHO58kMVFxk70mbSPyP2WdLtF
 gea+6VP1Kw9ziBSMAVX/4xqqp9Fn5cPFCLm7bWIT43UfgUKv+HV8t0UJ6H3GZhEZT9jKrit8M
 T2EKMb6Xl20Xk0twV267MIUpcSnnmtlI1vMOCUUjFQhL2v267ksF4wbr1uKSMEVVxOe2m3V70
 hCLvSOcy3X/AzqJIaEbJ3lnwnFt5mFHQn002dy9t33qSPqKWPxYF21cGvSYQg+BsRkB9bDO68
 GblwCtdD7OedSwHNRcp7nS5rQvVEolgygOzw1Juh2Jm6YmU6+gW3yq0P0ceEok1FXVBxbeSOU
 iRH6CTBuz6aKphmEYp7kRw/IdisPjrrDEhU+Ag==
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Sep 22, 2021 at 8:40 PM Sergio Paracuellos
<sergio.paracuellos@gmail.com> wrote:
> On Wed, Sep 22, 2021 at 8:07 PM Arnd Bergmann <arnd@arndb.de> wrote:
> > On Wed, Sep 22, 2021 at 7:42 PM Sergio Paracuellos
> > Ok, thank you for the detailed explanation.
> >
> > I suppose you can use the generic infrastructure in asm-generic/io.h
> > if you "#define PCI_IOBASE mips_io_port_base". In this case, you
> > should have an architecture specific implementation of
> > pci_remap_iospace() that assigns mips_io_port_base.
>
> No, that is what I tried originally defining PCI_IOBASE as
> _AC(0xa0000000, UL) [0] which is the same as KSEG1 [1] that ends in
> 'mips_io_port_base'.

Defining it as KSEG1 would be problematic because that means that
the Linux-visible port numbers are offset from the bus-visible ones.

You really want PCI_IOBASE to point to the address of port 0.

> > pci_remap_iospace() was originally meant as an architecture
> > specific helper, but it moved into generic code after all architectures
> > had the same requirements. If MIPS has different requirements,
> > then it should not be shared.
>
> I see. So, if it can not be shared, would defining 'pci_remap_iospace'
> as 'weak' acceptable? Doing in this way I guess I can redefine the
> symbol for mips to have the same I currently have but without the
> ifdef in the core APIs...

I would hope to kill off the __weak functions, and prefer using an #ifdef
around the generic implementation. One way to do it is to define
a macro with the same name, such as

#define pci_remap_iospace pci_remap_iospace

and then use #ifdef around the C function to see if that's arleady defined.

> >
> > I don't yet understand how you deal with having multiple PCIe
> > host bridge devices if they have distinct I/O port ranges.
> > Without remapping to dynamic virtual addresses, does
> > that mean that every MMIO register between the first and
> > last PCIe bridge also shows up in /dev/ioport? Or do you
> > only support port I/O on the first PCIe host bridge?
>
> For example, this board is using all available three pci ports [2] and I get:
>
> root@gnubee:~# cat /proc/ioports
> 1e160000-1e16ffff : pcie@1e140000
>   1e160000-1e160fff : PCI Bus 0000:01
>     1e160000-1e16000f : 0000:01:00.0
>       1e160000-1e16000f : ahci
>     1e160010-1e160017 : 0000:01:00.0
>       1e160010-1e160017 : ahci
>     1e160018-1e16001f : 0000:01:00.0
>       1e160018-1e16001f : ahci
>     1e160020-1e160023 : 0000:01:00.0
>       1e160020-1e160023 : ahci
>     1e160024-1e160027 : 0000:01:00.0
>       1e160024-1e160027 : ahci
>   1e161000-1e161fff : PCI Bus 0000:02
>     1e161000-1e16100f : 0000:02:00.0
>       1e161000-1e16100f : ahci
>     1e161010-1e161017 : 0000:02:00.0
>       1e161010-1e161017 : ahci
>     1e161018-1e16101f : 0000:02:00.0
>       1e161018-1e16101f : ahci
>     1e161020-1e161023 : 0000:02:00.0
>       1e161020-1e161023 : ahci
>     1e161024-1e161027 : 0000:02:00.0
>       1e161024-1e161027 : ahci
>   1e162000-1e162fff : PCI Bus 0000:03
>     1e162000-1e16200f : 0000:03:00.0
>       1e162000-1e16200f : ahci
>     1e162010-1e162017 : 0000:03:00.0
>       1e162010-1e162017 : ahci
>     1e162018-1e16201f : 0000:03:00.0
>       1e162018-1e16201f : ahci
>     1e162020-1e162023 : 0000:03:00.0
>       1e162020-1e162023 : ahci
>     1e162024-1e162027 : 0000:03:00.0
>       1e162024-1e162027 : ahci

Ah ok, so there are I/O ports that are at least
visible (may or may not be accessed by the driver).

I only see one host bridge here though, and it has a single
I/O port range, so maybe all three ports are inside of
a single PCI domain?

Having high numbers for the I/O ports is definitely a
problem as I mentioned. Anything that tries to access
PC-style legacy devices on the low port numbers
will now directly go on the bus accessing MMIO
registers that it shouldn't, either causing a CPU exception
or (worse) undefined behavior from random register
accesses.

       Arnd
