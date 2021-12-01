Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DA3F4658E2
	for <lists+linux-pci@lfdr.de>; Wed,  1 Dec 2021 23:06:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343535AbhLAWKS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 1 Dec 2021 17:10:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240110AbhLAWKS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 1 Dec 2021 17:10:18 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 435D5C061574
        for <linux-pci@vger.kernel.org>; Wed,  1 Dec 2021 14:06:56 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id fv9-20020a17090b0e8900b001a6a5ab1392so2924969pjb.1
        for <linux-pci@vger.kernel.org>; Wed, 01 Dec 2021 14:06:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gateworks-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FYH0cQHUBYKj1N7VJLH/Jqp1Gh1NxCPdlsjxd1BzPQI=;
        b=UAMmlBepsZa1x9sZVT3jt7tTpsIAKj+3//7rgWEBNtelLrpI2bQ+JLE4Eg4PG1eoTk
         U9jYsWIEyy0j5e5WytI4Pg9ruLY8BghCHf4DvZwgrhTVBqvMUWWncOD8yDg4szkU1j5q
         wKuf0YIAmwnLxPfO1+ZdUJ+0WH93brzZtW7RudAcxKAwy7EZJo07IvfGnZCAHdB0oWj+
         UFhNEJT4qSa9KFOzljbfOaIEaplOaJTEe4brIlZyn6WQX7kCuS1BNF8eSgCgQEO8UoMf
         RUsB+Y2r8tiJJiiNf5p8Rc8Ep2uwIv15WIw+FI/8eDO0m6JeFOmmS6RkQ1l3gEDS2xXm
         qd/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FYH0cQHUBYKj1N7VJLH/Jqp1Gh1NxCPdlsjxd1BzPQI=;
        b=JiciUhMrvohP0msHXiiwiPod0kinT1ggYY511ndsyodjHSznyWO39ZOslkBxsEcsgH
         SufZmUK37DG4rexjkiZzFe/lGqVzbW6+1pF5q8zrIyuVFZhJwXFCX9dM6B+QXG/qlV8e
         Qer29wEgWghm/755x7mw4QrBml4xjg1Q9VE46yhJEabcaAN9v68RKOnjaGgIDvjnhLkw
         K37I/zs/tf/LXK449H3oKxBJB5ku412cEpupwgDUrOg3N3eKazFBHE38Ouhm2NSrxZrM
         hvrK1j2qMVp3beE6+zjSFctfD8mcQXYVmyonolMSsB5QS1fEWYifxqtdUG5aVYPTuOcF
         rYOg==
X-Gm-Message-State: AOAM5339EwCVZArWypLReF22Hnh4QKr/wDaQvQRiuiJiGn1zKV0RnFgd
        pAUduDbAGDMpOZPP8hKdyrNvEM6W2FypUsZtZuKCCw==
X-Google-Smtp-Source: ABdhPJxnodH/dwhX99BtM9rTIpTEvtmXLHSgJB+sp8bD8FSEPn8cozJRxYFi3df9F+TLbf/uX0X5IOnHOVH36WMWW0U=
X-Received: by 2002:a17:902:7c8a:b0:143:bb4a:7bb3 with SMTP id
 y10-20020a1709027c8a00b00143bb4a7bb3mr10863184pll.46.1638396415751; Wed, 01
 Dec 2021 14:06:55 -0800 (PST)
MIME-Version: 1.0
References: <20211101180243.23761-1-tharvey@gateworks.com>
In-Reply-To: <20211101180243.23761-1-tharvey@gateworks.com>
From:   Tim Harvey <tharvey@gateworks.com>
Date:   Wed, 1 Dec 2021 14:06:44 -0800
Message-ID: <CAJ+vNU2Pfwz5e0Jj6c5npceOwuNTB_dTVuL4NMD2qxr0CGyeGQ@mail.gmail.com>
Subject: Re: [PATCH] PCI: imx: do not remap invalid res
To:     Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Rob Herring <robh@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Cc:     open list <linux-kernel@vger.kernel.org>,
        Richard Zhu <hongxing.zhu@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Nov 1, 2021 at 11:03 AM Tim Harvey <tharvey@gateworks.com> wrote:
>
> On imx6 and perhaps others when pcie probes you get a:
> imx6q-pcie 33800000.pcie: invalid resource
>
> This occurs because the atu is not specified in the DT and as such it
> should not be remapped.
>
> Cc: Richard Zhu <hongxing.zhu@nxp.com>
> Signed-off-by: Tim Harvey <tharvey@gateworks.com>
> ---
>  drivers/pci/controller/dwc/pcie-designware.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
> index a945f0c0e73d..3254f60d1713 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.c
> +++ b/drivers/pci/controller/dwc/pcie-designware.c
> @@ -671,10 +671,11 @@ void dw_pcie_iatu_detect(struct dw_pcie *pci)
>                 if (!pci->atu_base) {
>                         struct resource *res =
>                                 platform_get_resource_byname(pdev, IORESOURCE_MEM, "atu");
> -                       if (res)
> +                       if (res) {
>                                 pci->atu_size = resource_size(res);
> -                       pci->atu_base = devm_ioremap_resource(dev, res);
> -                       if (IS_ERR(pci->atu_base))
> +                               pci->atu_base = devm_ioremap_resource(dev, res);
> +                       }
> +                       if (!pci->atu_base || IS_ERR(pci->atu_base))
>                                 pci->atu_base = pci->dbi_base + DEFAULT_DBI_ATU_OFFSET;
>                 }
>
> --
> 2.17.1
>

ping - any feedback on this?

Best regards,

Tim
