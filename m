Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C6D3B85C53
	for <lists+linux-pci@lfdr.de>; Thu,  8 Aug 2019 10:02:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731719AbfHHICy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 8 Aug 2019 04:02:54 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:43716 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731548AbfHHICy (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 8 Aug 2019 04:02:54 -0400
Received: by mail-ot1-f66.google.com with SMTP id j11so14714566otp.10;
        Thu, 08 Aug 2019 01:02:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GOmXUqe6Ps1LYK7cNwZISmnpFncUMvpwFUibfCQ0KSw=;
        b=F0R+ffh3bmulBDd0ltZALk+IjVf6wqiSLjjNF2J9HXk3i46dbOVTNR1dkYC3QRB21Z
         aOH4DT8GIoDcVGE1B4zd04ZxVvSraP9ryF5Y9iQhAVVKn53HUqnZkbU+ftQdXV4A7vMc
         OawRameYLdb9xC3GTMudLbNtaE8ucd78EBiilIcftJxD1a/yliVrPn6xtknMjT1EiTWZ
         XnXlIk72sRduBEZnwgltQdEQulG66xTZ3ndaQwDkns3PSU78aQYUVjfrWk95Vz/KBNAn
         xPUlOFyO72qEIYUqGa2hPVYaFBQYZnhAltOojs94V654asnp9aC8VssgoEcMUwI+oMC8
         Y7BQ==
X-Gm-Message-State: APjAAAUWGeDEYJ2XAgWoFS690TAFJotjHdxL+aDjIuluh0vVHu0vNAgG
        C+HyPH0+0yg18KBihkL3dBW6rMwzm/mH4hGGlyk=
X-Google-Smtp-Source: APXvYqxrI4/yih9SmRMVfK7WxuoAEScyImMdek0dI8U65VI+Rmpd+ammpwIo/9Bxr4KcqRv+RaATEsVzOD+uItwzeQQ=
X-Received: by 2002:aca:338a:: with SMTP id z132mr1789689oiz.54.1565251373478;
 Thu, 08 Aug 2019 01:02:53 -0700 (PDT)
MIME-Version: 1.0
References: <20190730181557.90391-1-swboyd@chromium.org> <20190730181557.90391-32-swboyd@chromium.org>
In-Reply-To: <20190730181557.90391-32-swboyd@chromium.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 8 Aug 2019 10:02:42 +0200
Message-ID: <CAMuHMdXkcqNF1dXxKX3ztVmVGTX4W+hz9Zzc3w6LPn34Gwj7Nw@mail.gmail.com>
Subject: Re: [PATCH v6 31/57] pci: Remove dev_err() usage after platform_get_irq()
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Stephen,

On Tue, Jul 30, 2019 at 8:21 PM Stephen Boyd <swboyd@chromium.org> wrote:
> We don't need dev_err() messages when platform_get_irq() fails now that
> platform_get_irq() prints an error message itself when something goes
> wrong. Let's remove these prints with a simple semantic patch.
>
> // <smpl>
> @@
> expression ret;
> struct platform_device *E;
> @@
>
> ret =
> (
> platform_get_irq(E, ...)
> |
> platform_get_irq_byname(E, ...)
> );
>
> if ( \( ret < 0 \| ret <= 0 \) )
> {
> (
> -if (ret != -EPROBE_DEFER)
> -{ ...
> -dev_err(...);
> -... }
> |
> ...
> -dev_err(...);
> )
> ...
> }
> // </smpl>
>
> While we're here, remove braces on if statements that only have one
> statement (manually).
>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: linux-pci@vger.kernel.org
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> ---
>
> Please apply directly to subsystem trees
>
>  drivers/pci/controller/dwc/pci-dra7xx.c     |  8 ++------
>  drivers/pci/controller/dwc/pci-exynos.c     |  8 ++------
>  drivers/pci/controller/dwc/pci-imx6.c       |  4 +---
>  drivers/pci/controller/dwc/pci-keystone.c   |  4 +---
>  drivers/pci/controller/dwc/pci-meson.c      |  4 +---
>  drivers/pci/controller/dwc/pcie-armada8k.c  |  4 +---
>  drivers/pci/controller/dwc/pcie-artpec6.c   |  4 +---
>  drivers/pci/controller/dwc/pcie-histb.c     |  4 +---
>  drivers/pci/controller/dwc/pcie-kirin.c     |  5 +----
>  drivers/pci/controller/dwc/pcie-spear13xx.c |  4 +---
>  drivers/pci/controller/pci-tegra.c          |  8 ++------
>  drivers/pci/controller/pci-v3-semi.c        |  4 +---
>  drivers/pci/controller/pci-xgene-msi.c      |  2 --
>  drivers/pci/controller/pcie-altera-msi.c    |  1 -
>  drivers/pci/controller/pcie-altera.c        |  4 +---
>  drivers/pci/controller/pcie-mobiveil.c      |  4 +---
>  drivers/pci/controller/pcie-rockchip-host.c | 12 +++---------
>  drivers/pci/controller/pcie-tango.c         |  4 +---
>  drivers/pci/controller/pcie-xilinx-nwl.c    | 11 ++---------
>  19 files changed, 23 insertions(+), 76 deletions(-)

Failed to catch:

drivers/pci/controller/pci-rcar-gen2.c: priv->irq = platform_get_irq(pdev, 0);
drivers/pci/controller/pci-rcar-gen2.c- priv->reg = reg;
drivers/pci/controller/pci-rcar-gen2.c- priv->dev = dev;
drivers/pci/controller/pci-rcar-gen2.c-
drivers/pci/controller/pci-rcar-gen2.c- if (priv->irq < 0) {
drivers/pci/controller/pci-rcar-gen2.c-         dev_err(dev, "no valid
irq found\n");
drivers/pci/controller/pci-rcar-gen2.c-         return priv->irq;
drivers/pci/controller/pci-rcar-gen2.c- }

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
