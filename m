Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FF51246D01
	for <lists+linux-pci@lfdr.de>; Mon, 17 Aug 2020 18:40:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388900AbgHQQkC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 17 Aug 2020 12:40:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:41254 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388898AbgHQQj4 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 17 Aug 2020 12:39:56 -0400
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6F75420674;
        Mon, 17 Aug 2020 16:39:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597682395;
        bh=ifO03cMzINSVsY3nIRWYJJWNorVOV7MEsCao05SISEI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=aiQBA39aUMY1Y44AGHoNsvI5heZEdPz3RASAMATyoNPfg904JKx/nEECcThKwh53D
         iAGQuuobZ6SKApaX7I8nmQJgAhAR++iNLnMiy3//k4p9B/jPqrcdE/93PT0plYeBN+
         TOHujonKP0VlLhiv7SR0cjSakloX2a506r41NXKg=
Received: by mail-oi1-f174.google.com with SMTP id a24so15333804oia.6;
        Mon, 17 Aug 2020 09:39:55 -0700 (PDT)
X-Gm-Message-State: AOAM5314nPBTEPUp2TvMpqX21ze2p15uSx+El0+UVZeY/wsSoFA8Wchm
        xtVdBVW5blUknlWj6GkPNT+jx/aF2ifj9XWBdw==
X-Google-Smtp-Source: ABdhPJxhRWY6PWbqPYwgGjUIxWQR66vhMnMb3Lx3z86cqv3Gg8rVBxYxbVIvfsh9MLzYqkLWtvNEjbqKehRsRJxzIa4=
X-Received: by 2002:aca:190c:: with SMTP id l12mr10376472oii.147.1597682394749;
 Mon, 17 Aug 2020 09:39:54 -0700 (PDT)
MIME-Version: 1.0
References: <1596795922-705-1-git-send-email-hayashi.kunihiko@socionext.com> <1596795922-705-7-git-send-email-hayashi.kunihiko@socionext.com>
In-Reply-To: <1596795922-705-7-git-send-email-hayashi.kunihiko@socionext.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Mon, 17 Aug 2020 10:39:43 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJhvpiAWfa7w4-85-GObkW+pq6PUpZUGg8Sc5p4+qsuQA@mail.gmail.com>
Message-ID: <CAL_JsqJhvpiAWfa7w4-85-GObkW+pq6PUpZUGg8Sc5p4+qsuQA@mail.gmail.com>
Subject: Re: [PATCH v6 6/6] PCI: uniphier: Add error message when failed to
 get phy
To:     Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Marc Zyngier <maz@kernel.org>, PCI <linux-pci@vger.kernel.org>,
        devicetree@vger.kernel.org,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Jassi Brar <jaswinder.singh@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Aug 7, 2020 at 4:25 AM Kunihiko Hayashi
<hayashi.kunihiko@socionext.com> wrote:
>
> Even if phy driver doesn't probe, the error message can't be distinguished
> from other errors. This displays error message caused by the phy driver
> explicitly.
>
> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> ---
>  drivers/pci/controller/dwc/pcie-uniphier.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/pci/controller/dwc/pcie-uniphier.c b/drivers/pci/controller/dwc/pcie-uniphier.c
> index 93ef608..7c8721e 100644
> --- a/drivers/pci/controller/dwc/pcie-uniphier.c
> +++ b/drivers/pci/controller/dwc/pcie-uniphier.c
> @@ -489,8 +489,12 @@ static int uniphier_pcie_probe(struct platform_device *pdev)
>                 return PTR_ERR(priv->rst);
>
>         priv->phy = devm_phy_optional_get(dev, "pcie-phy");

The point of the optional variant vs. devm_phy_get() is whether or not
you get an error message. So shouldn't you switch to devm_phy_get
instead?

> -       if (IS_ERR(priv->phy))
> -               return PTR_ERR(priv->phy);
> +       if (IS_ERR(priv->phy)) {
> +               ret = PTR_ERR(priv->phy);
> +               if (ret != -EPROBE_DEFER)
> +                       dev_err(dev, "Failed to get phy (%d)\n", ret);
> +               return ret;
> +       }
>
>         platform_set_drvdata(pdev, priv);
>
> --
> 2.7.4
>
