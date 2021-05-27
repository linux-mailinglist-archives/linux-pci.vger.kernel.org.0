Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 230B9393423
	for <lists+linux-pci@lfdr.de>; Thu, 27 May 2021 18:39:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235803AbhE0Qkf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 27 May 2021 12:40:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:60516 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234278AbhE0Qke (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 27 May 2021 12:40:34 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 61DF1613AF;
        Thu, 27 May 2021 16:39:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622133540;
        bh=5DJuW/bnBtUHJd7Q3Q7OZvGhMJUl8t5p1TVaOTuL/hg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=HueSznr3Fu2IQEOByfQwL7tX83bW8Ryg5HdBSrz++Tm7FjPH2ctScG/Nq/RkVZ8D5
         izO8mIqcIQ3S2LskbH0lCj+XnyXDzyK93cCQ9qYXTP8shcACOUu/pu7Hhe4QeeUBB3
         80wews3XswhJMcUoKzBslppBq/q5nShlMtWl6FjODW26b0T2k6Ed1lHcIJm4r516Ex
         VfHUrt1LLnz6vmoZ5Khy2Q8jIoSMELpGLm1XnfkvDBp+kxyp2KWTYttvfRnUfdVThD
         LQRipXdRu+kqtOOAU1KrKb6QnvuHlpx1MwNn0C882gXjQVdHsfekWSoesWJzolbrrk
         rc+t2T80Ksovw==
Received: by mail-ej1-f42.google.com with SMTP id z12so1194444ejw.0;
        Thu, 27 May 2021 09:39:00 -0700 (PDT)
X-Gm-Message-State: AOAM532B52BVM57GUQrKsPIKunkLQ+SRw57DGVY0u1k0pPmWQ9TM9HWO
        TRkCRCPP+ZQMewhQc0cnlv29qzsLY3boeg1x2A==
X-Google-Smtp-Source: ABdhPJzgsTYwg11aYC8HyZsYl9T+SDJSXVaYrpuLFWrhDtEG2Ds1o4OjLE8O10QD1Y9g+T4o7fNzuzbsW094AbY1T8M=
X-Received: by 2002:a17:906:7b88:: with SMTP id s8mr365002ejo.525.1622133538969;
 Thu, 27 May 2021 09:38:58 -0700 (PDT)
MIME-Version: 1.0
References: <20210527150541.3130505-1-punitagrawal@gmail.com> <20210527150541.3130505-2-punitagrawal@gmail.com>
In-Reply-To: <20210527150541.3130505-2-punitagrawal@gmail.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Thu, 27 May 2021 11:38:46 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+Sp_Owe4V4WNh4jnuNJZ5jXxA+j4fW7564oPCy5Lu3ew@mail.gmail.com>
Message-ID: <CAL_Jsq+Sp_Owe4V4WNh4jnuNJZ5jXxA+j4fW7564oPCy5Lu3ew@mail.gmail.com>
Subject: Re: [PATCH 1/2] PCI: of: Override 64-bit flag for non-prefetchable
 memory below 4GB
To:     Punit Agrawal <punitagrawal@gmail.com>
Cc:     "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        PCI <linux-pci@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Alexandru Elisei <alexandru.elisei@arm.com>, wqu@suse.com,
        Robin Murphy <robin.murphy@arm.com>,
        Peter Geis <pgwipeout@gmail.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Brian Norris <briannorris@chromium.org>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, May 27, 2021 at 10:06 AM Punit Agrawal <punitagrawal@gmail.com> wrote:
>
> Some host bridges advertise non-prefetable memory windows that are
> entirely located below 4GB but are marked as 64-bit address memory.
>
> Since commit 9d57e61bf723 ("of/pci: Add IORESOURCE_MEM_64 to resource
> flags for 64-bit memory addresses"), the OF PCI range parser takes a
> stricter view and treats 64-bit address ranges as advertised while
> before such ranges were treated as 32-bit.
>
> A PCI-to-PCI bridges cannot forward 64-bit non-prefetchable memory
> ranges. As a result, the change in behaviour due to the commit causes
> allocation failure for devices that are connected behind PCI host
> bridges modelled as PCI-to-PCI bridge and require non-prefetchable bus
> addresses.
>
> In order to not break platforms, override the 64-bit flag for
> non-prefetchable memory ranges that lie entirely below 4GB.
>
> Suggested-by: Ard Biesheuvel <ardb@kernel.org>
> Link: https://lore.kernel.org/r/7a1e2ebc-f7d8-8431-d844-41a9c36a8911@arm.com
> Signed-off-by: Punit Agrawal <punitagrawal@gmail.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Rob Herring <robh+dt@kernel.org>
> ---
>  drivers/pci/of.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/pci/of.c b/drivers/pci/of.c
> index da5b414d585a..b9d0bee5a088 100644
> --- a/drivers/pci/of.c
> +++ b/drivers/pci/of.c
> @@ -565,10 +565,14 @@ static int pci_parse_request_of_pci_ranges(struct device *dev,
>                 case IORESOURCE_MEM:
>                         res_valid |= !(res->flags & IORESOURCE_PREFETCH);
>
> -                       if (!(res->flags & IORESOURCE_PREFETCH))
> +                       if (!(res->flags & IORESOURCE_PREFETCH)) {
>                                 if (upper_32_bits(resource_size(res)))
>                                         dev_warn(dev, "Memory resource size exceeds max for 32 bits\n");

Based on Ard's explanation, doesn't this need to also check for
!IORESOURCE_MEM_64?

> -
> +                               if ((res->flags & IORESOURCE_MEM_64) && !upper_32_bits(res->end)) {

res->end is the CPU address space. Isn't it the PCI address space we care about?

> +                                       dev_warn(dev, "Overriding 64-bit flag for non-prefetchable memory below 4GB\n");
> +                                       res->flags &= ~IORESOURCE_MEM_64;
> +                               }
> +                       }
>                         break;
>                 }
>         }
> --
> 2.30.2
>
