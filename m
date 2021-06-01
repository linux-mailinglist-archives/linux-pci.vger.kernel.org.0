Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0462396CFB
	for <lists+linux-pci@lfdr.de>; Tue,  1 Jun 2021 07:49:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229521AbhFAFu6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 1 Jun 2021 01:50:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:56262 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229477AbhFAFu6 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 1 Jun 2021 01:50:58 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 42CC4613AB;
        Tue,  1 Jun 2021 05:49:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622526557;
        bh=OPxQYwkHb+c8kRPYIMeJZ1NAST5RTo/Lc2MbCJ31+VY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ZbBVaFHV/dOaGQ4wh+zmyN2lxHOP0Z/AjIO5zoJoUd2RuzjvOhtS9T96+JUNiNO/n
         +ojMNCmF2kpgkQgHWADV0M3+XGtH+Fn3yI/ANDSxmbIk4j5HUVS+Y7GpwW7hNVhAp9
         tCx7VzAoEL1REgTQRv9EqKWSX14UwMjNIMYljUWBZrfd/OY0a4O9gDx8mLEW6w8tUe
         6NDueNw7IEwmXcrKBoJMhBZVHTlKO5FHFu/cJtPXUTLKgXb6VJwegTxCp+cYDGlWTr
         WzqrpejvAEF1KyeM5LLrsdH8Ucc9Rs4ieM+b7LWUY6NooBUoNLtTco2zZylLbznxLj
         mw8MKPyuZJ06Q==
Received: by mail-oi1-f172.google.com with SMTP id a13so8985979oid.9;
        Mon, 31 May 2021 22:49:17 -0700 (PDT)
X-Gm-Message-State: AOAM530eJhDTlNRNDGDgw9OGQiXkSXK1hiRo1a6szNW3OogXAeZjjSgQ
        TKTMgjj/65WKFsVXzJOxVE9tsm6iXASG3jrWjeA=
X-Google-Smtp-Source: ABdhPJyIgc6c1QDmrjpCQOdUgQgVOvJONM1ji6QepPdsP8ZlBMN3ZjkhsZ26x+8EVFkB6zxjhv7Ejz8OqJ1I51L65QM=
X-Received: by 2002:a54:460a:: with SMTP id p10mr1817105oip.47.1622526556632;
 Mon, 31 May 2021 22:49:16 -0700 (PDT)
MIME-Version: 1.0
References: <20210531221057.3406958-1-punitagrawal@gmail.com> <20210531221057.3406958-2-punitagrawal@gmail.com>
In-Reply-To: <20210531221057.3406958-2-punitagrawal@gmail.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Tue, 1 Jun 2021 07:49:05 +0200
X-Gmail-Original-Message-ID: <CAMj1kXHkZhgp3y_1dvKjfiEbwWDooCY0X+0HZutn5ZrsRGk15w@mail.gmail.com>
Message-ID: <CAMj1kXHkZhgp3y_1dvKjfiEbwWDooCY0X+0HZutn5ZrsRGk15w@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] PCI: of: Override 64-bit flag for non-prefetchable
 memory below 4GB
To:     Punit Agrawal <punitagrawal@gmail.com>
Cc:     "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        PCI <linux-pci@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexandru Elisei <alexandru.elisei@arm.com>, wqu@suse.com,
        Robin Murphy <robin.murphy@arm.com>,
        Peter Geis <pgwipeout@gmail.com>, briannorris@chromium.org,
        shawn.lin@rock-chips.com, Bjorn Helgaas <helgaas@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Punit,

On Tue, 1 Jun 2021 at 00:11, Punit Agrawal <punitagrawal@gmail.com> wrote:
>
> Some host bridges advertise non-prefetable memory windows that are

typo ^

> entirely located below 4GB but are marked as 64-bit address memory.
>
> Since commit 9d57e61bf723 ("of/pci: Add IORESOURCE_MEM_64 to resource
> flags for 64-bit memory addresses"), the OF PCI range parser takes a
> stricter view and treats 64-bit address ranges as advertised while
> before such ranges were treated as 32-bit.
>
> A PCI host bridge that is modelled as PCI-to-PCI bridge cannot forward

It is the root port which is modeled as a P2P bridge. The root port(s)
together with the host bridge is what makes up the root complex.


> 64-bit non-prefetchable memory ranges. As a result, the change in
> behaviour due to the commit causes allocation failure for devices that
> require non-prefetchable bus addresses.
>

AIUI, the problem is not that the device requires a non-prefetchable
bus address, but that it fails to allocate a 32-bit BAR from a 64-bit
non-prefetchable window.

> In order to not break platforms, override the 64-bit flag for
> non-prefetchable memory ranges that lie entirely below 4GB.
>
> Suggested-by: Ard Biesheuvel <ardb@kernel.org>
> Link: https://lore.kernel.org/r/7a1e2ebc-f7d8-8431-d844-41a9c36a8911@arm.com
> Signed-off-by: Punit Agrawal <punitagrawal@gmail.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Rob Herring <robh+dt@kernel.org>
>
> Signed-off-by: Punit Agrawal <punitagrawal@gmail.com>
> ---
>  drivers/pci/of.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/drivers/pci/of.c b/drivers/pci/of.c
> index da5b414d585a..e2e64c5c55cb 100644
> --- a/drivers/pci/of.c
> +++ b/drivers/pci/of.c
> @@ -346,6 +346,14 @@ static int devm_of_pci_get_host_bridge_resources(struct device *dev,
>                                 dev_warn(dev, "More than one I/O resource converted for %pOF. CPU base address for old range lost!\n",
>                                          dev_node);
>                         *io_base = range.cpu_addr;
> +               } else if (resource_type(res) == IORESOURCE_MEM) {
> +                       if (!(res->flags & IORESOURCE_PREFETCH)) {
> +                               if (res->flags & IORESOURCE_MEM_64)
> +                                       if (!upper_32_bits(range.pci_addr + range.size - 1)) {
> +                                               dev_warn(dev, "Clearing 64-bit flag for non-prefetchable memory below 4GB\n");
> +                                               res->flags &= ~IORESOURCE_MEM_64;
> +                                       }
> +                       }
>                 }
>
>                 pci_add_resource_offset(resources, res, res->start - range.pci_addr);
> --
> 2.30.2
>
