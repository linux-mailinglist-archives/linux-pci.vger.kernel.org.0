Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 54E392BE6C
	for <lists+linux-pci@lfdr.de>; Tue, 28 May 2019 06:52:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726810AbfE1Ews (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 28 May 2019 00:52:48 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:50257 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726721AbfE1Ews (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 28 May 2019 00:52:48 -0400
Received: by mail-it1-f195.google.com with SMTP id a186so2199733itg.0;
        Mon, 27 May 2019 21:52:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wx8LK+FLca8yAW2nEFxWKA0g/8vW4SdgqbZC24puim4=;
        b=Num6bmFJNBol+Kw9ZWhsOFk3l1a6j5lmv9mdFK/gp1Q+kuAErZkGs6tqYGoAjiYdZA
         6MYKsXRWCItoQI/4bW5JoSCuqVREty/c1E5yE5Hagq2y6VX9t/EwxuXHVATT2SFb1c8l
         LvHVuuZindy/bG3VCwtjN9kTQyE8kVpYXEDKbZseeM+8M4MvPhEZJS9RACjMMtBeOJ2/
         NgCzY5BrWv1Uwm33KeWad5xUrwTg/D8+q49095U/M68UNY327ufVLmBSjKw3SWeFRbZL
         HimVw8yhPOVWio6YuUOnj/duE0HnWe3w0kCAKu4oP5BXAoRoFKhJ/1gaywlz7wtmf8b+
         iVTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wx8LK+FLca8yAW2nEFxWKA0g/8vW4SdgqbZC24puim4=;
        b=su5ulRT0clRmCZeozsKwz+G2NnOM9rnQWmvroTML0VwFwlSfIsocsqHq9Kgzd1O3g2
         6bKFW0DD55+a8ipUhO17Ahh5jSf1e7D+HESeCQMGUGs/eNgRDFfpfQqPfFq8XykuOiTA
         llj6CrQeZkympEJwJyzwKw0mKjQS+15LCNUclmjHagqp2q3+8xMkmO9vHFSjbjP0NLaZ
         TvP46HyJDJ/JtaRgVRzIyAxOFKRA27dsY/BhaLDjQUZQFBkB5520JIUBiX7RfxdIQeyo
         6WHHL36iYnLbIu1N9t3AE0+uXROH+72v+OUQbwAwCFE4jzweNkQkfoZsdX52JO7xM7RT
         yxOQ==
X-Gm-Message-State: APjAAAU9q+BXX3FwAKAfMze2yGijI1i+V+429HHvjJnTEPkKLjkt+rXk
        Ruak/m84GhZkIqkLm3j+lW1gJ/FMH0eFKiHdr+I=
X-Google-Smtp-Source: APXvYqyxyjnf3N3ZuvxwWhdhVBd1O4QLo5brN6e/Y+/Q3kvimE1dHdiSAECEYrRRH1DbQs8Xyg0nj2Nwt2AP+nSbWOg=
X-Received: by 2002:a24:d145:: with SMTP id w66mr1686745itg.71.1559019167176;
 Mon, 27 May 2019 21:52:47 -0700 (PDT)
MIME-Version: 1.0
References: <20190527225521.5884-1-shawn@anastas.io> <CAOSf1CFFyz0YNqdpd5r44MaBV449yoK3WOMBZ1mpgZ=judNfDQ@mail.gmail.com>
 <476555b7-b462-d844-57ea-7ca1c6113d9b@anastas.io>
In-Reply-To: <476555b7-b462-d844-57ea-7ca1c6113d9b@anastas.io>
From:   Oliver <oohall@gmail.com>
Date:   Tue, 28 May 2019 14:52:35 +1000
Message-ID: <CAOSf1CG9LcxPy9cOk0FeNq=pvMCPKVKYU7=tdrMSO+RiqTWr5A@mail.gmail.com>
Subject: Re: [RESEND PATCH 0/3] Allow custom PCI resource alignment on pseries
To:     Shawn Anastasio <shawn@anastas.io>
Cc:     linux-pci@vger.kernel.org,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sam Bobroff <sbobroff@linux.ibm.com>,
        xyjxie@linux.vnet.ibm.com, rppt@linux.ibm.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexey Kardashevskiy <aik@ozlabs.ru>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, May 28, 2019 at 2:09 PM Shawn Anastasio <shawn@anastas.io> wrote:
>
>
>
> On 5/27/19 11:01 PM, Oliver wrote:
> > On Tue, May 28, 2019 at 8:56 AM Shawn Anastasio <shawn@anastas.io> wrote:
> >>
> >> Hello all,
> >>
> >> This patch set implements support for user-specified PCI resource
> >> alignment on the pseries platform for hotplugged PCI devices.
> >> Currently on pseries, PCI resource alignments specified with the
> >> pci=resource_alignment commandline argument are ignored, since
> >> the firmware is in charge of managing the PCI resources. In the
> >> case of hotplugged devices, though, the kernel is in charge of
> >> configuring the resources and should obey alignment requirements.
> >
> > Are you using hotplug to work around SLOF (the OF we use under qemu)
> > not aligning BARs to 64K? It looks like there is a commit in SLOF to
> > fix that (https://git.qemu.org/?p=SLOF.git;a=commit;f=board-qemu/slof/pci-phb.fs;h=1903174472f8800caf50c959b304501b4c01153c).
> >
>
> No, my application actually requires PCI hotplug at run-time.
>
> >> The current behavior of ignoring the alignment for hotplugged devices
> >> results in sub-page BARs landing between page boundaries and
> >> becoming un-mappable from userspace via the VFIO framework.
> >> This issue was observed on a pseries KVM guest with hotplugged
> >> ivshmem devices.
> >
> >> With these changes, users can specify an appropriate
> >> pci=resource_alignment argument on boot for devices they wish to use
> >> with VFIO.
> >>
> >> In the future, this could be extended to provide page-aligned
> >> resources by default for hotplugged devices, similar to what is done
> >> on powernv by commit 382746376993 ("powerpc/powernv: Override
> >> pcibios_default_alignment() to force PCI devices to be page aligned").
> >
> > Can we make aligning the BARs to PAGE_SIZE the default behaviour? The
> > BAR assignment process is complex enough as-is so I'd rather we didn't
> > add another platform hack into the mix.
>
> Absolutely. This will still require the existing changes so that the
> custom alignment isn't flat-out ignored on pseries, but I can set
> it to default to PAGE_SIZE as well, similar to how it's done on PowerNV.
> I've just pushed a v3 to fix a typo and I'll incorporate this change
> in v4.

I was thinking we could get rid of the ppcmd callback and do it in
kernel/pci-common.c. PowerNV is the only platform that implements the
callback and the pseries implementation is going to be identical so I
don't think there's much of point in keeping the callback.

> >> Feedback is appreciated.
> >>
> >> Thanks,
> >> Shawn
> >>
> >> Shawn Anastasio (3):
> >>    PCI: Introduce pcibios_ignore_alignment_request
> >>    powerpc/64: Enable pcibios_after_init hook on ppc64
> >>    powerpc/pseries: Allow user-specified PCI resource alignment after
> >>      init
> >>
> >>   arch/powerpc/include/asm/machdep.h     |  6 ++++--
> >>   arch/powerpc/kernel/pci-common.c       |  9 +++++++++
> >>   arch/powerpc/kernel/pci_64.c           |  4 ++++
> >>   arch/powerpc/platforms/pseries/setup.c | 22 ++++++++++++++++++++++
> >>   drivers/pci/pci.c                      |  9 +++++++--
> >>   5 files changed, 46 insertions(+), 4 deletions(-)
> >>
> >> --
> >> 2.20.1
> >>
