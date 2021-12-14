Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13630474E03
	for <lists+linux-pci@lfdr.de>; Tue, 14 Dec 2021 23:43:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234268AbhLNWnK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 14 Dec 2021 17:43:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234225AbhLNWnK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 14 Dec 2021 17:43:10 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94C14C061574;
        Tue, 14 Dec 2021 14:43:09 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C1E30B81D5B;
        Tue, 14 Dec 2021 22:43:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 935BAC34606;
        Tue, 14 Dec 2021 22:43:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639521786;
        bh=rhM5XuQgjU0FB5J77l3eetVj/6euawt62QZltfdep4M=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=D9pgqehZL3xhnR2EKCxcwA0XCCtDeCQ8+Yk0jCnEwUG9V+RNmZQymhBqiG1aGnaN8
         Kh/5d/kh0f7ItSvCUZXalJmx0b8wUPl2pSv/KCIPFnDlBnaXWPrboPsFRjmpcXTnPR
         MT+EvO2maua+zKHSPsClnruL0KLHWPpU82bhMgjPUSQM1GdTgKLvnG921WGoU4mwrU
         fO40nqOjJUd/v85SrD12SOgOYFyVHuZsLyb4jczeKgtwVg7XJCNkWLjnQLCzzhGMVD
         Mqc9fxn9OQi7qME9osvMsjgPS0kpgHLZ/05Eys7lUHDsOIlfnVfloatESJlSRMoq/O
         eLsWjkl0jL5tw==
Received: by mail-ed1-f46.google.com with SMTP id r11so67443720edd.9;
        Tue, 14 Dec 2021 14:43:06 -0800 (PST)
X-Gm-Message-State: AOAM530Y49gie4g7PVrT0oTf8DYlOdnP0rgfmABEmyM9YI9x0nP1w/CW
        TqRD35YrX2JiDTM0BSPpesd6K2FdJ3FfZ36CyA==
X-Google-Smtp-Source: ABdhPJyLBisQ8v76tCGHaz4gb1oLFNf6AtEmBHSgFdgVVTp+4GenpNAUoex9e1Nwoja/jxIU+cUU7wDryEL42sk8Ak0=
X-Received: by 2002:a17:906:3b18:: with SMTP id g24mr8501893ejf.27.1639521784863;
 Tue, 14 Dec 2021 14:43:04 -0800 (PST)
MIME-Version: 1.0
References: <20211214221450.589884-1-luca@lucaceresoli.net>
In-Reply-To: <20211214221450.589884-1-luca@lucaceresoli.net>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 14 Dec 2021 16:42:53 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+GQTcx1EGKHug2ZcDZufrKM-4k6PB0vQeTCTG42MHzvA@mail.gmail.com>
Message-ID: <CAL_Jsq+GQTcx1EGKHug2ZcDZufrKM-4k6PB0vQeTCTG42MHzvA@mail.gmail.com>
Subject: Re: [PATCH 1/2] PCI: dra7xx: Fix link removal on probe error
To:     Luca Ceresoli <luca@lucaceresoli.net>
Cc:     PCI <linux-pci@vger.kernel.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        linux-omap <linux-omap@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Sekhar Nori <nsekhar@ti.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Dec 14, 2021 at 4:15 PM Luca Ceresoli <luca@lucaceresoli.net> wrote:
>
> If a devm_phy_get() calls fails with phy_count==N (N > 0), then N links
> have already been added by device_link_add() and won't be deleted by
> device_link_del() because the code calls 'return' and not 'goto err_link'.
>
> Fix in a very simple way by doing all the devm_phy_get() calls before all
> the device_link_add() calls.
>
> Fixes: 7a4db656a635 ("PCI: dra7xx: Create functional dependency between PCIe and PHY")
> Signed-off-by: Luca Ceresoli <luca@lucaceresoli.net>
> ---
>  drivers/pci/controller/dwc/pci-dra7xx.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/pci/controller/dwc/pci-dra7xx.c b/drivers/pci/controller/dwc/pci-dra7xx.c
> index f7f1490e7beb..2ccc53869e13 100644
> --- a/drivers/pci/controller/dwc/pci-dra7xx.c
> +++ b/drivers/pci/controller/dwc/pci-dra7xx.c
> @@ -757,7 +757,9 @@ static int dra7xx_pcie_probe(struct platform_device *pdev)
>                 phy[i] = devm_phy_get(dev, name);
>                 if (IS_ERR(phy[i]))
>                         return PTR_ERR(phy[i]);
> +       }
>
> +       for (i = 0; i < phy_count; i++) {
>                 link[i] = device_link_add(dev, &phy[i]->dev, DL_FLAG_STATELESS);

I think this should happen automatically now with fw_devlink being
enabled by default. Can you try?

>                 if (!link[i]) {
>                         ret = -EINVAL;
> --
> 2.25.1
>
