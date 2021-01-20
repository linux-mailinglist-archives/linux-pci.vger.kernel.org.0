Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A35F2FD2A8
	for <lists+linux-pci@lfdr.de>; Wed, 20 Jan 2021 15:33:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388460AbhATO1X (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 20 Jan 2021 09:27:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:39318 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728897AbhATOYz (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 20 Jan 2021 09:24:55 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4E34523380;
        Wed, 20 Jan 2021 14:24:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611152653;
        bh=0Xtz3tkNSwsoY9gbgqE2qTK7eRaJcR+iJ9o+tD1IB+c=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=qkReOQiov9zXiYg96avLVaWfdyxpxanbJ1uYevLhphyxJQkpBe8s27GEbJCpbLClv
         Pmp53G/9+dTzLyTCKYMrBzb8Oeb0ty1Fn8tuBSP3TAltZjQLhY7enM0IaALUq7ljAb
         OvFYsUMQWyyYb3CafYK1WdyJvB69e9p2x6zbI07cLivlmcqDQ2fUutAbQjXxKJFdpM
         BdRDy0IV1M/fByAQVJdkREme6VBxXklgB99icNJAtj/fVEvRxXLZIeJdNZJoTBS1N9
         ylED35lcHlOWjzm8XRXYvWs39gy8h15E+45MTK0vsKgE0SRUa2IS+L1nwwvAYSM7vY
         kyuWhg6uFbW6A==
Received: by mail-ed1-f42.google.com with SMTP id b21so17132868edy.6;
        Wed, 20 Jan 2021 06:24:13 -0800 (PST)
X-Gm-Message-State: AOAM532xn2y+PkWUJSOlzhj9N3RKFfofxVFsjBT/MjQIK7GvMHyUCIq7
        8PDv83EOjBahZZkmOhlr9FUMs1jpJO0uVzoL4Q==
X-Google-Smtp-Source: ABdhPJxsjPL+nYG7BlFb3gzD3BUJUMJLtrEcPRLAGMIcR3Rwa6WblBDjUksihZpxjJd/Vr6d3NHetWaFA5kQ/EYByFs=
X-Received: by 2002:a50:fc04:: with SMTP id i4mr7590319edr.137.1611152651919;
 Wed, 20 Jan 2021 06:24:11 -0800 (PST)
MIME-Version: 1.0
References: <20210120105246.23218-1-michael@walle.cc>
In-Reply-To: <20210120105246.23218-1-michael@walle.cc>
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 20 Jan 2021 08:23:59 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLSJCLtgPyAdKSqsy=JoHSLYef_0s-stTbiJ+VCq2qaSA@mail.gmail.com>
Message-ID: <CAL_JsqLSJCLtgPyAdKSqsy=JoHSLYef_0s-stTbiJ+VCq2qaSA@mail.gmail.com>
Subject: Re: [PATCH] PCI: dwc: layerscape: convert to builtin_platform_driver()
To:     Michael Walle <michael@walle.cc>
Cc:     linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        PCI <linux-pci@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Minghuan Lian <minghuan.Lian@nxp.com>,
        Mingkai Hu <mingkai.hu@nxp.com>, Roy Zang <roy.zang@nxp.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Saravana Kannan <saravanak@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jan 20, 2021 at 4:53 AM Michael Walle <michael@walle.cc> wrote:
>
> fw_devlink will defer the probe until all suppliers are ready. We can't
> use builtin_platform_driver_probe() because it doesn't retry after probe
> deferral. Convert it to builtin_platform_driver().

If builtin_platform_driver_probe() doesn't work with fw_devlink, then
shouldn't it be fixed or removed? Then we're not fixing drivers later
when folks start caring about deferred probe and devlink.

I'd really prefer if we convert this to a module instead. (And all the
other PCI host drivers.)

> Fixes: e590474768f1 ("driver core: Set fw_devlink=on by default")

This happened!?

> Signed-off-by: Michael Walle <michael@walle.cc>
> ---
>  drivers/pci/controller/dwc/pci-layerscape.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/pci/controller/dwc/pci-layerscape.c b/drivers/pci/controller/dwc/pci-layerscape.c
> index 44ad34cdc3bc..5b9c625df7b8 100644
> --- a/drivers/pci/controller/dwc/pci-layerscape.c
> +++ b/drivers/pci/controller/dwc/pci-layerscape.c
> @@ -232,7 +232,7 @@ static const struct of_device_id ls_pcie_of_match[] = {
>         { },
>  };
>
> -static int __init ls_pcie_probe(struct platform_device *pdev)
> +static int ls_pcie_probe(struct platform_device *pdev)
>  {
>         struct device *dev = &pdev->dev;
>         struct dw_pcie *pci;
> @@ -271,10 +271,11 @@ static int __init ls_pcie_probe(struct platform_device *pdev)
>  }
>
>  static struct platform_driver ls_pcie_driver = {
> +       .probe = ls_pcie_probe,
>         .driver = {
>                 .name = "layerscape-pcie",
>                 .of_match_table = ls_pcie_of_match,
>                 .suppress_bind_attrs = true,
>         },
>  };
> -builtin_platform_driver_probe(ls_pcie_driver, ls_pcie_probe);
> +builtin_platform_driver(ls_pcie_driver);
> --
> 2.20.1
>
