Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D4D13612A2
	for <lists+linux-pci@lfdr.de>; Thu, 15 Apr 2021 21:00:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234720AbhDOTAa (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 15 Apr 2021 15:00:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:49286 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234130AbhDOTAa (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 15 Apr 2021 15:00:30 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 89BB561152;
        Thu, 15 Apr 2021 19:00:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618513206;
        bh=3QkOpXY42hFCJcjT08WY79HuNgMbSCbucp8T7Lu/Gyw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=oJhLd5qeUZ2D01LaV+DBVA3WiwlJ49LzHkGhXbx20dOZyQvAonfzhKBX+7VUEkcaf
         qsAelHSFMsM6Bckn7IXf7lFQXvtaPEaQB9yID9YDYrWm+kxmyEp6eaq5rtDT5dtSCw
         Q4W6ud0pb9CAvqPXaXuohNDkORMTLNh7OYPyp3SBtn+xe39LtSI9xzgEzGeL6iBddS
         f68Ea5F7fZIGZLdZlGc+C914YKqHq/2R9l2NG3a4CpJAM60UErTZD92p9un1Ltg3Wc
         Nq8/gkaFZq/BoevmwacadhD/dtCXOeXtEflGrBV6tVbrL4dC4TOm7Osf4zOVwE/1Ig
         YbeMO3jsWZQ9A==
Received: by mail-ej1-f44.google.com with SMTP id mh2so16896051ejb.8;
        Thu, 15 Apr 2021 12:00:06 -0700 (PDT)
X-Gm-Message-State: AOAM530jX9UQRSj8cVZjNigjGqDKXAWwRXIKFlrqXx+yMnAtZ7d39BQf
        puuyjV5vxFvEA09WSC0qVfNF7lyzGapvOzoE0Q==
X-Google-Smtp-Source: ABdhPJynWSj+ZDcLUN0rDvn85g39jo1ldh5d1/4kMKUG6C+T3/POrItS5sj8VN8G5+i/NBs56pq5Zhn3RBh0Hrx6vLc=
X-Received: by 2002:a17:906:1984:: with SMTP id g4mr4827470ejd.525.1618513205152;
 Thu, 15 Apr 2021 12:00:05 -0700 (PDT)
MIME-Version: 1.0
References: <20210415180050.373791-1-leobras.c@gmail.com>
In-Reply-To: <20210415180050.373791-1-leobras.c@gmail.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Thu, 15 Apr 2021 13:59:52 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+WwAeziGN4EfPAWfA0fieAjfcxfi29=StOx0GeKjAe_g@mail.gmail.com>
Message-ID: <CAL_Jsq+WwAeziGN4EfPAWfA0fieAjfcxfi29=StOx0GeKjAe_g@mail.gmail.com>
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

+PPC and PCI lists

On Thu, Apr 15, 2021 at 1:01 PM Leonardo Bras <leobras.c@gmail.com> wrote:
>
> Many other resource flag parsers already add this flag when the input
> has bits 24 & 25 set, so update this one to do the same.

Many others? Looks like sparc and powerpc to me. Those would be the
ones I worry about breaking. Sparc doesn't use of/address.c so it's
fine. Powerpc version of the flags code was only fixed in 2019, so I
don't think powerpc will care either.

I noticed both sparc and powerpc set PCI_BASE_ADDRESS_MEM_TYPE_64 in
the flags. AFAICT, that's not set anywhere outside of arch code. So
never for riscv, arm and arm64 at least. That leads me to
pci_std_update_resource() which is where the PCI code sets BARs and
just copies the flags in PCI_BASE_ADDRESS_MEM_MASK ignoring
IORESOURCE_* flags. So it seems like 64-bit is still not handled and
neither is prefetch.

> Some devices (like virtio-net) have more than one memory resource
> (like MMIO32 and MMIO64) and without this flag it would be needed to
> verify the address range to know which one is which.
>
> Signed-off-by: Leonardo Bras <leobras.c@gmail.com>
> ---
>  drivers/of/address.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/of/address.c b/drivers/of/address.c
> index 73ddf2540f3f..dc7147843783 100644
> --- a/drivers/of/address.c
> +++ b/drivers/of/address.c
> @@ -116,9 +116,12 @@ static unsigned int of_bus_pci_get_flags(const __be32 *addr)
>                 flags |= IORESOURCE_IO;
>                 break;
>         case 0x02: /* 32 bits */
> -       case 0x03: /* 64 bits */
>                 flags |= IORESOURCE_MEM;
>                 break;
> +
> +       case 0x03: /* 64 bits */
> +               flags |= IORESOURCE_MEM | IORESOURCE_MEM_64;
> +               break;
>         }
>         if (w & 0x40000000)
>                 flags |= IORESOURCE_PREFETCH;
> --
> 2.30.2
>
