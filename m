Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FF64364754
	for <lists+linux-pci@lfdr.de>; Mon, 19 Apr 2021 17:44:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241537AbhDSPpP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 19 Apr 2021 11:45:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:33942 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241127AbhDSPpO (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 19 Apr 2021 11:45:14 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0D9D7611F0;
        Mon, 19 Apr 2021 15:44:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618847085;
        bh=1hglvV4GjA2advCM06OW1Eit/4/3I8x0HflbVk4wpuY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=WNizhiRqZajO+MiOARISqtKtGpPmaO3wBUEXBYaZcF6e7reYd0/YMFWwxNeUTgfe5
         N0tLt+LESGZ0BdkDW3AuEDpdlHVeG7V2YZc2pw1QfKfGNHfgkp27nLA+HX2gYT/PlF
         jjwDuzd486c9+/Ek2R9WiHAh1F83drMgZjVy6M5HwtRkmYgbUgIZFHsKtDfO6a2rfA
         +4bBRNSkFbnMxtKkhdWLWX/zAHKy0j8hPIOlI2tARuJQBD9r8jCYQv7fwWP70ews22
         4xF7qVIGlwcnhnZhLcuSOudwPys6pA43cQdtZi4ARk833UdG1HnVntK56j4MBHe2Os
         Gkj2cUSl0uVVQ==
Received: by mail-ej1-f52.google.com with SMTP id sd23so44997192ejb.12;
        Mon, 19 Apr 2021 08:44:44 -0700 (PDT)
X-Gm-Message-State: AOAM531EDZPieClMq1AR16vC2Kr3e/9IcnBq58qRl2APCcTPrylkvjrY
        kVa9dZzh7lT60OtCy5yxf8wyW3rueNksBt9ooA==
X-Google-Smtp-Source: ABdhPJzBXwETiXa9YzZ6qf4GsLL82HMp0uZcY/aPM/9WWzio+BYfi1hv5Mfge2u58qRhymWTxr7qLgFRkOJydeQPCks=
X-Received: by 2002:a17:906:9ac5:: with SMTP id ah5mr22189976ejc.360.1618847083667;
 Mon, 19 Apr 2021 08:44:43 -0700 (PDT)
MIME-Version: 1.0
References: <20210415180050.373791-1-leobras.c@gmail.com> <CAL_Jsq+WwAeziGN4EfPAWfA0fieAjfcxfi29=StOx0GeKjAe_g@mail.gmail.com>
 <7b089cd48b90f2445c7cb80da1ce8638607c46fc.camel@gmail.com>
In-Reply-To: <7b089cd48b90f2445c7cb80da1ce8638607c46fc.camel@gmail.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Mon, 19 Apr 2021 10:44:31 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+m6CkGj_NYGvwxoKwoQ4PkEu6hfGdMTT3i4APoHSkNeg@mail.gmail.com>
Message-ID: <CAL_Jsq+m6CkGj_NYGvwxoKwoQ4PkEu6hfGdMTT3i4APoHSkNeg@mail.gmail.com>
Subject: Re: [PATCH 1/1] of/pci: Add IORESOURCE_MEM_64 to resource flags for
 64-bit memory addresses
To:     Leonardo Bras <leobras.c@gmail.com>
Cc:     Frank Rowand <frowand.list@gmail.com>,
        Alexey Kardashevskiy <aik@ozlabs.ru>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        PCI <linux-pci@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Apr 16, 2021 at 3:58 PM Leonardo Bras <leobras.c@gmail.com> wrote:
>
> Hello Rob, thanks for this feedback!
>
> On Thu, 2021-04-15 at 13:59 -0500, Rob Herring wrote:
> > +PPC and PCI lists
> >
> > On Thu, Apr 15, 2021 at 1:01 PM Leonardo Bras <leobras.c@gmail.com> wrote:
> > >
> > > Many other resource flag parsers already add this flag when the input
> > > has bits 24 & 25 set, so update this one to do the same.
> >
> > Many others? Looks like sparc and powerpc to me.
> >
>
> s390 also does that, but it look like it comes from a device-tree.

I'm only looking at DT based platforms, and s390 doesn't use DT.

> > Those would be the
> > ones I worry about breaking. Sparc doesn't use of/address.c so it's
> > fine. Powerpc version of the flags code was only fixed in 2019, so I
> > don't think powerpc will care either.
>
> In powerpc I reach this function with this stack, while configuring a
> virtio-net device for a qemu/KVM pseries guest:
>
> pci_process_bridge_OF_ranges+0xac/0x2d4
> pSeries_discover_phbs+0xc4/0x158
> discover_phbs+0x40/0x60
> do_one_initcall+0x60/0x2d0
> kernel_init_freeable+0x308/0x3a8
> kernel_init+0x2c/0x168
> ret_from_kernel_thread+0x5c/0x70
>
> For this, both MMIO32 and MMIO64 resources will have flags 0x200.

Oh good, powerpc has 2 possible flags parsing functions. So in the
above path, do we need to set PCI_BASE_ADDRESS_MEM_TYPE_64?

Does pci_parse_of_flags() get called in your case?

> > I noticed both sparc and powerpc set PCI_BASE_ADDRESS_MEM_TYPE_64 in
> > the flags. AFAICT, that's not set anywhere outside of arch code. So
> > never for riscv, arm and arm64 at least. That leads me to
> > pci_std_update_resource() which is where the PCI code sets BARs and
> > just copies the flags in PCI_BASE_ADDRESS_MEM_MASK ignoring
> > IORESOURCE_* flags. So it seems like 64-bit is still not handled and
> > neither is prefetch.
> >
>
> I am not sure if you mean here:
> a) it's ok to add IORESOURCE_MEM_64 here, because it does not affect
> anything else, or
> b) it should be using PCI_BASE_ADDRESS_MEM_TYPE_64
> (or IORESOURCE_MEM_64 | PCI_BASE_ADDRESS_MEM_TYPE_64) instead, since
> it's how it's added in powerpc/sparc, and else there is no point.

I'm wondering if a) is incomplete and PCI_BASE_ADDRESS_MEM_TYPE_64
also needs to be set. The question is ultimately are BARs getting set
correctly for 64-bit? It looks to me like they aren't.

Rob
