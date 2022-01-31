Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA30A4A423E
	for <lists+linux-pci@lfdr.de>; Mon, 31 Jan 2022 12:11:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359386AbiAaLLM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 31 Jan 2022 06:11:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377208AbiAaLJs (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 31 Jan 2022 06:09:48 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 588CAC0604D0;
        Mon, 31 Jan 2022 03:06:34 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id u18so25814136edt.6;
        Mon, 31 Jan 2022 03:06:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MDHsNr9BVQwd4RB33QOSJmSn+RDo8Dtcj1lBoG/Wutk=;
        b=IZWW0rfXWwaRLlMauBlzn7cDK6kct+DozbmXbLUZUkSJbaTQsXaScwZAj9EQtYkFzD
         vdHDbqj11VqB9kU/HWiJg/1Oij6mPAY+dsq/AFldQQsZU4exYVu1IFiEjCtyH96QtPnN
         dl9VAYEa6eaepGH70BonVcLfCkJif6UmIWjanCiIwBOHfIXC+jEiLoiJ/Ggs7GpgpwyM
         w6M4PUmX/XO3iFyCPsX9qxRjJHiq1L6buBDrw1kucRJtRqYB6rY2vB3WCwj6nO/Vb7c9
         yova4bZFXkjXijzRmn9hOl8oKjhnY4787xwKTxPT6J3q/qj/9dgVhMTgEACnwh+J+9He
         qy4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MDHsNr9BVQwd4RB33QOSJmSn+RDo8Dtcj1lBoG/Wutk=;
        b=M1ii99c8c7t3c3eO9A+bK1ESj1sNBVF0Y8KPPvoo2Di7Ci8uh9HTF8MnMbny2BzqF0
         Fb6IaN0PR5pRCb55iJ2Q2tMrsQ5/gghnwWM9IinlSXbs+2jTvl+3L29DTc0+vC5AnO//
         0MJz4pCokVztanGhn9HO1epxbhMeLhHGJ80GfMZ8D2xgmsxkiZMiu+VLVY144KAcD+dR
         Ox47vnIfkl0tnitysrNuxCglKNJCAK3hg189fDhHpQb2KJWWW9w5btGn1kChBOKjkcsJ
         XWt8gT1fXFwVJQiYd3u/ZiuavSbzwAnrudjUihgfspJXGuNicdEXNYIDD0Hvn3Pk86HA
         P1Tw==
X-Gm-Message-State: AOAM533hahTfMez4DjS+OpVhpKeWWOLuEKskYPh7PvmoKje5EcFMewEG
        nvIIku8OW5e7nYi60W3o/h9KGBtV5SgrRb8uTNM=
X-Google-Smtp-Source: ABdhPJyYfE7IfFvjGHneKbH8VY1690N2VLmKMeLE7sNlsCLAFTolVy/c0Iy04JmRhmvARgLgA1JKcHwMX6HBc2PDkA0=
X-Received: by 2002:aa7:cd0e:: with SMTP id b14mr19859871edw.414.1643627192673;
 Mon, 31 Jan 2022 03:06:32 -0800 (PST)
MIME-Version: 1.0
References: <20220124122132.435743-1-christian.gmeiner@gmail.com> <20220127222951.GA144828@bhelgaas>
In-Reply-To: <20220127222951.GA144828@bhelgaas>
From:   Christian Gmeiner <christian.gmeiner@gmail.com>
Date:   Mon, 31 Jan 2022 12:06:21 +0100
Message-ID: <CAH9NwWeFm1UsBtGgHWhmhM2GgR5ciDXCi8H_p2KB01vfLPz6kQ@mail.gmail.com>
Subject: Re: [PATCH] Revert "PCI: j721e: Drop redundant struct device *"
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Tom Joseph <tjoseph@cadence.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-omap@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Am Do., 27. Jan. 2022 um 23:29 Uhr schrieb Bjorn Helgaas <helgaas@kernel.org>:
>
> On Mon, Jan 24, 2022 at 01:21:22PM +0100, Christian Gmeiner wrote:
> > This reverts commit 19e863828acf6d8ac8475ba1fd93c0fe17fdc4ef.
> >
> > Fixes the following oops:
> >  Unable to handle kernel NULL pointer dereference at virtual address 0000000000000010
>
> Hi Christian,
>
> Would you mind trying this patch?
>

Works - thanks. You can add my Tested-by.

> commit 9d36a93af8fe ("PCI: j721e: Initialize pcie->cdns_pcie before using it")
> Author: Bjorn Helgaas <bhelgaas@google.com>
> Date:   Thu Jan 27 15:49:49 2022 -0600
>
>     PCI: j721e: Initialize pcie->cdns_pcie before using it
>
>     Christian reported a NULL pointer dereference in j721e_pcie_probe() caused
>     by 19e863828acf ("PCI: j721e: Drop redundant struct device *"), which
>     removed struct j721e_pcie.dev since there's another copy in struct
>     cdns_pcie.dev reachable via j721e_pcie->cdns_pcie->dev.
>
>     The problem is that j721e_pcie->cdns_pcie was dereferenced before being
>     initialized:
>
>       j721e_pcie_probe
>         pcie = devm_kzalloc()             # struct j721e_pcie
>         j721e_pcie_ctrl_init(pcie)
>           dev = pcie->cdns_pcie->dev      <-- dereference cdns_pcie
>         switch (mode) {
>         case PCI_MODE_RC:
>           cdns_pcie = ...                 # alloc as part of pci_host_bridge
>           pcie->cdns_pcie = cdns_pcie     <-- initialize pcie->cdns_pcie
>
>     Initialize pcie->cdns_pcie before it is used.
>
>     Fixes: 19e863828acf ("PCI: j721e: Drop redundant struct device *")
>     Reported-by: Christian Gmeiner <christian.gmeiner@gmail.com>
>     Link: https://lore.kernel.org/r/20220124122132.435743-1-christian.gmeiner@gmail.com
>     Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
>
> diff --git a/drivers/pci/controller/cadence/pci-j721e.c b/drivers/pci/controller/cadence/pci-j721e.c
> index 489586a4cdc7..5d950c1d9fd0 100644
> --- a/drivers/pci/controller/cadence/pci-j721e.c
> +++ b/drivers/pci/controller/cadence/pci-j721e.c
> @@ -372,10 +372,48 @@ static int j721e_pcie_probe(struct platform_device *pdev)
>
>         mode = (u32)data->mode;
>
> +       switch (mode) {
> +       case PCI_MODE_RC:
> +               if (!IS_ENABLED(CONFIG_PCIE_CADENCE_HOST))
> +                       return -ENODEV;
> +
> +               bridge = devm_pci_alloc_host_bridge(dev, sizeof(*rc));
> +               if (!bridge)
> +                       return -ENOMEM;
> +
> +               if (!data->byte_access_allowed)
> +                       bridge->ops = &cdns_ti_pcie_host_ops;
> +               rc = pci_host_bridge_priv(bridge);
> +               rc->quirk_retrain_flag = data->quirk_retrain_flag;
> +               rc->quirk_detect_quiet_flag = data->quirk_detect_quiet_flag;
> +
> +               cdns_pcie = &rc->pcie;
> +               break;
> +       case PCI_MODE_EP:
> +               if (!IS_ENABLED(CONFIG_PCIE_CADENCE_EP))
> +                       return -ENODEV;
> +
> +               ep = devm_kzalloc(dev, sizeof(*ep), GFP_KERNEL);
> +               if (!ep)
> +                       return -ENOMEM;
> +
> +               ep->quirk_detect_quiet_flag = data->quirk_detect_quiet_flag;
> +
> +               cdns_pcie = &ep->pcie;
> +               break;
> +       default:
> +               dev_err(dev, "INVALID device type %d\n", mode);
> +               return 0;
> +       }
> +
> +       cdns_pcie->dev = dev;
> +       cdns_pcie->ops = &j721e_pcie_ops;
> +
>         pcie = devm_kzalloc(dev, sizeof(*pcie), GFP_KERNEL);
>         if (!pcie)
>                 return -ENOMEM;
>
> +       pcie->cdns_pcie = cdns_pcie;
>         pcie->mode = mode;
>         pcie->linkdown_irq_regfield = data->linkdown_irq_regfield;
>
> @@ -426,28 +464,6 @@ static int j721e_pcie_probe(struct platform_device *pdev)
>
>         switch (mode) {
>         case PCI_MODE_RC:
> -               if (!IS_ENABLED(CONFIG_PCIE_CADENCE_HOST)) {
> -                       ret = -ENODEV;
> -                       goto err_get_sync;
> -               }
> -
> -               bridge = devm_pci_alloc_host_bridge(dev, sizeof(*rc));
> -               if (!bridge) {
> -                       ret = -ENOMEM;
> -                       goto err_get_sync;
> -               }
> -
> -               if (!data->byte_access_allowed)
> -                       bridge->ops = &cdns_ti_pcie_host_ops;
> -               rc = pci_host_bridge_priv(bridge);
> -               rc->quirk_retrain_flag = data->quirk_retrain_flag;
> -               rc->quirk_detect_quiet_flag = data->quirk_detect_quiet_flag;
> -
> -               cdns_pcie = &rc->pcie;
> -               cdns_pcie->dev = dev;
> -               cdns_pcie->ops = &j721e_pcie_ops;
> -               pcie->cdns_pcie = cdns_pcie;
> -
>                 gpiod = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_LOW);
>                 if (IS_ERR(gpiod)) {
>                         ret = PTR_ERR(gpiod);
> @@ -497,23 +513,6 @@ static int j721e_pcie_probe(struct platform_device *pdev)
>
>                 break;
>         case PCI_MODE_EP:
> -               if (!IS_ENABLED(CONFIG_PCIE_CADENCE_EP)) {
> -                       ret = -ENODEV;
> -                       goto err_get_sync;
> -               }
> -
> -               ep = devm_kzalloc(dev, sizeof(*ep), GFP_KERNEL);
> -               if (!ep) {
> -                       ret = -ENOMEM;
> -                       goto err_get_sync;
> -               }
> -               ep->quirk_detect_quiet_flag = data->quirk_detect_quiet_flag;
> -
> -               cdns_pcie = &ep->pcie;
> -               cdns_pcie->dev = dev;
> -               cdns_pcie->ops = &j721e_pcie_ops;
> -               pcie->cdns_pcie = cdns_pcie;
> -
>                 ret = cdns_pcie_init_phy(dev, cdns_pcie);
>                 if (ret) {
>                         dev_err(dev, "Failed to init phy\n");
> @@ -525,8 +524,6 @@ static int j721e_pcie_probe(struct platform_device *pdev)
>                         goto err_pcie_setup;
>
>                 break;
> -       default:
> -               dev_err(dev, "INVALID device type %d\n", mode);
>         }
>
>         return 0;



-- 
greets
--
Christian Gmeiner, MSc

https://christian-gmeiner.info/privacypolicy
