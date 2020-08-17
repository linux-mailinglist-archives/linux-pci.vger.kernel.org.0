Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC524246D30
	for <lists+linux-pci@lfdr.de>; Mon, 17 Aug 2020 18:48:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388969AbgHQQso (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 17 Aug 2020 12:48:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:36282 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388953AbgHQQse (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 17 Aug 2020 12:48:34 -0400
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9113920729;
        Mon, 17 Aug 2020 16:48:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597682912;
        bh=cr4ed1+wAP4LE1t7Olx9PbLZFx5mHkvQNQCN7Bnf8T8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=znYZ5yvsLRpkEdePuy6tC3joBPK0xJHf9nDYgKlmoXss0jHQtChfpKdYQzlPeK8hk
         bMFX0uMubHOlONiKBZUp5AOnr9OE5khS40uNTCGY3DeRp9oeT6OGSkxKvtrkIoYaUd
         dlw77GXtToNLsZPnE86uwrBNwgJPOP/GCnEVpWnU=
Received: by mail-ot1-f41.google.com with SMTP id r21so13906281ota.10;
        Mon, 17 Aug 2020 09:48:32 -0700 (PDT)
X-Gm-Message-State: AOAM532rwmPD4ejIqcr+qjQpF2GuFvIy38LYsvpi//nEZqFBZ56YaicN
        Rmkd/SHeT4RkFLb1B/Ye/eExq+rEXiNflrDuzw==
X-Google-Smtp-Source: ABdhPJxaIJ/5yIBh3pYah1vkE3SudC65lsnoRMq8W4mfltRwx3uDQ1BoQvhIj5sBtTElnPyyUac/41RrgElt7gohyCw=
X-Received: by 2002:a05:6830:1b79:: with SMTP id d25mr11034659ote.107.1597682911876;
 Mon, 17 Aug 2020 09:48:31 -0700 (PDT)
MIME-Version: 1.0
References: <1596795922-705-1-git-send-email-hayashi.kunihiko@socionext.com> <1596795922-705-6-git-send-email-hayashi.kunihiko@socionext.com>
In-Reply-To: <1596795922-705-6-git-send-email-hayashi.kunihiko@socionext.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Mon, 17 Aug 2020 10:48:20 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+nGtrBpzNKU9+1cHYkuQ3KBHpgwZRQfDKKUMJVSx_b1A@mail.gmail.com>
Message-ID: <CAL_Jsq+nGtrBpzNKU9+1cHYkuQ3KBHpgwZRQfDKKUMJVSx_b1A@mail.gmail.com>
Subject: Re: [PATCH v6 5/6] PCI: uniphier: Add iATU register support
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
> This gets iATU register area from reg property. In Synopsys DWC version
> 4.80 or later, since iATU register area is separated from core register
> area, this area is necessary to get from DT independently.
>
> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> ---
>  drivers/pci/controller/dwc/pcie-uniphier.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/drivers/pci/controller/dwc/pcie-uniphier.c b/drivers/pci/controller/dwc/pcie-uniphier.c
> index 55a7166..93ef608 100644
> --- a/drivers/pci/controller/dwc/pcie-uniphier.c
> +++ b/drivers/pci/controller/dwc/pcie-uniphier.c
> @@ -471,6 +471,11 @@ static int uniphier_pcie_probe(struct platform_device *pdev)
>         if (IS_ERR(priv->pci.dbi_base))
>                 return PTR_ERR(priv->pci.dbi_base);
>
> +       priv->pci.atu_base =
> +               devm_platform_ioremap_resource_byname(pdev, "atu");
> +       if (IS_ERR(priv->pci.atu_base))
> +               priv->pci.atu_base = NULL;

Keystone has the same 'atu' resource setup. Please move its code to
the DW core and use that.

Rob
