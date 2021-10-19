Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 828E7433366
	for <lists+linux-pci@lfdr.de>; Tue, 19 Oct 2021 12:20:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235166AbhJSKWL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 19 Oct 2021 06:22:11 -0400
Received: from mail-ua1-f48.google.com ([209.85.222.48]:43634 "EHLO
        mail-ua1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230117AbhJSKWL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 19 Oct 2021 06:22:11 -0400
Received: by mail-ua1-f48.google.com with SMTP id i22so2753367ual.10;
        Tue, 19 Oct 2021 03:19:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=p6OZFW3ezrlsvIWoQgzoCARmyBJqP61SO2gxRkAy/uo=;
        b=CMv4MSCjHqRUSlfvIzI1QNel+7CTWtK7AByjbxm29PMGppkQIcIA14ayL/rooAj8Ha
         m5EzkDAa5Ec1PjKqAihtn7DE4boAbVk+pCU3yDc7fAOP+VwmDCppjF1xoFz/2ELI1gI1
         le+0JJMILhETO/xw9m277ba0BjXj/6laCvuryXJI90ryw+bV0aUHXpx/zH/LVB+AHcXC
         KKOvBZ+xOO3yqogtmc589H5P6/CdOwGoVy7a/9JFD5c4qZeypO9016N5VJxCDcZ+OXJI
         AxyWyyEJAiK/mw2dm+VGmqDbPXxlxCL82XCXyHBQp5LX8Ejkhs8jZG8md6Jm+9NnykSk
         wDJQ==
X-Gm-Message-State: AOAM5331/NSAKzZ4bmFqfxtTRtGkZK3Qo3Vnq5pcye7STWOnWLjcAoEt
        WvDqODtsoeJgON1zrlRRr77JqtnJz1QWmA==
X-Google-Smtp-Source: ABdhPJwyTbDbYL9Be2J58hjWet64L1WtCHnEOSZSgVQPRRIyaTSHNtGKzzzrqCBUjtacWppBQeRecg==
X-Received: by 2002:a67:d51a:: with SMTP id l26mr33813660vsj.29.1634638797600;
        Tue, 19 Oct 2021 03:19:57 -0700 (PDT)
Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com. [209.85.222.44])
        by smtp.gmail.com with ESMTPSA id u75sm10778783vke.29.2021.10.19.03.19.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Oct 2021 03:19:57 -0700 (PDT)
Received: by mail-ua1-f44.google.com with SMTP id i22so2753205ual.10;
        Tue, 19 Oct 2021 03:19:56 -0700 (PDT)
X-Received: by 2002:a9f:29a5:: with SMTP id s34mr26300307uas.122.1634638796170;
 Tue, 19 Oct 2021 03:19:56 -0700 (PDT)
MIME-Version: 1.0
References: <20211019095858.21316-1-Meng.Li@windriver.com>
In-Reply-To: <20211019095858.21316-1-Meng.Li@windriver.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 19 Oct 2021 12:19:45 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUJ4nzz169=LG_q6rx7naKVdk-VUrxiQ9VzS=fxjCQ2WA@mail.gmail.com>
Message-ID: <CAMuHMdUJ4nzz169=LG_q6rx7naKVdk-VUrxiQ9VzS=fxjCQ2WA@mail.gmail.com>
Subject: Re: [PATCH] pci: pcie-rcar: add regulators support
To:     Meng Li <Meng.Li@windriver.com>
Cc:     Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Meng,

On Tue, Oct 19, 2021 at 11:59 AM Meng Li <Meng.Li@windriver.com> wrote:
> From: Andrey Gusakov <andrey.gusakov@cogentembedded.com>
>
> Add PCIe regulators for KingFisher board.
>
> Signed-off-by: Meng Li <Meng.Li@windriver.com>

Thanks for your patch!

>  arch/arm64/boot/dts/renesas/ulcb-kf.dtsi | 47 +++++++++++++++++
>  drivers/pci/controller/pcie-rcar-host.c  | 64 ++++++++++++++++++++++++

Please split patches touching both DT and driver sources.

> --- a/arch/arm64/boot/dts/renesas/ulcb-kf.dtsi
> +++ b/arch/arm64/boot/dts/renesas/ulcb-kf.dtsi

> @@ -259,6 +303,9 @@
>
>  &pciec1 {
>         status = "okay";
> +
> +       pcie3v3-supply = <&mpcie_3v3>;
> +       pcie1v8-supply = <&mpcie_1v8>;

This needs an update to the R-Car PCIe DT bindings first.

> --- a/drivers/pci/controller/pcie-rcar-host.c
> +++ b/drivers/pci/controller/pcie-rcar-host.c

> @@ -893,6 +896,36 @@ static const struct of_device_id rcar_pcie_of_match[] = {
>         {},
>  };
>
> +static int rcar_pcie_set_vpcie(struct rcar_pcie_host *host)
> +{
> +       struct device *dev = host->pcie.dev;
> +       int err;
> +
> +       if (!IS_ERR(host->pcie3v3)) {
> +               err = regulator_enable(host->pcie3v3);

This will crash if host->pcie3v3 is NULL (optional regulator not
present).  Probably you just want to check for non-NULL (see below).

> +               if (err) {
> +                       dev_err(dev, "fail to enable vpcie3v3 regulator\n");
> +                       goto err_out;
> +               }
> +       }
> +
> +       if (!IS_ERR(host->pcie1v8)) {
> +               err = regulator_enable(host->pcie1v8);

Likewise.

> +               if (err) {
> +                       dev_err(dev, "fail to enable vpcie1v8 regulator\n");
> +                       goto err_disable_3v3;
> +               }
> +       }
> +
> +       return 0;
> +
> +err_disable_3v3:
> +       if (!IS_ERR(host->pcie3v3))

Likewise.

> +               regulator_disable(host->pcie3v3);
> +err_out:
> +       return err;
> +}
> +
>  static int rcar_pcie_probe(struct platform_device *pdev)
>  {
>         struct device *dev = &pdev->dev;
> @@ -911,6 +944,31 @@ static int rcar_pcie_probe(struct platform_device *pdev)
>         pcie->dev = dev;
>         platform_set_drvdata(pdev, host);
>
> +       host->pcie3v3 = devm_regulator_get_optional(dev, "pcie3v3");
> +       if (IS_ERR(host->pcie3v3)) {
> +               if (PTR_ERR(host->pcie3v3) == -EPROBE_DEFER) {
> +                       pci_free_host_bridge(bridge);

Please drop this.  As the bridge was allocated using
devm_pci_alloc_host_bridge(), freeing it manually will cause a
double free.

> +                       return -EPROBE_DEFER;
> +               }
> +               dev_info(dev, "no pcie3v3 regulator found\n");

devm_regulator_get_optional() returns NULL if the regulator was not
found.  Hence if IS_ERR() is true, this indicates a real error, which
you should handle:

    if (IS_ERR(host->pcie3v3))
            return PTR_ERR(host->pcie3v3);

> +       }
> +
> +       host->pcie1v8 = devm_regulator_get_optional(dev, "pcie1v8");
> +       if (IS_ERR(host->pcie1v8)) {
> +               if (PTR_ERR(host->pcie1v8) == -EPROBE_DEFER) {
> +                       pci_free_host_bridge(bridge);
> +                       return -EPROBE_DEFER;
> +               }
> +               dev_info(dev, "no pcie1v8 regulator found\n");

Likewise.

> +       }
> +
> +       err = rcar_pcie_set_vpcie(host);
> +       if (err) {
> +               dev_err(dev, "failed to set pcie regulators\n");
> +               pci_free_host_bridge(bridge);

Please drop this to avoid double free.

> +               return err;
> +       }
> +
>         pm_runtime_enable(pcie->dev);
>         err = pm_runtime_get_sync(pcie->dev);
>         if (err < 0) {
> @@ -985,6 +1043,12 @@ static int rcar_pcie_probe(struct platform_device *pdev)
>         irq_dispose_mapping(host->msi.irq1);
>
>  err_pm_put:
> +       if(!IS_ERR(host->pcie3v3))

if (host->pcie3v3)

> +               if (regulator_is_enabled(host->pcie3v3))

If you get here, the regulator should be enabled?

> +                       regulator_disable(host->pcie3v3);
> +       if(!IS_ERR(host->pcie1v8))

if (host->pcie1v8)

> +               if (regulator_is_enabled(host->pcie1v8))
> +                       regulator_disable(host->pcie1v8);

Please move this below the call to pm_runtime_disable(), to preserve
symmetry.

>         pm_runtime_put(dev);
>         pm_runtime_disable(dev);

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
