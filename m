Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BB7A631953
	for <lists+linux-pci@lfdr.de>; Mon, 21 Nov 2022 06:08:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229657AbiKUFIy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 21 Nov 2022 00:08:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbiKUFIx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 21 Nov 2022 00:08:53 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC9762BB0E
        for <linux-pci@vger.kernel.org>; Sun, 20 Nov 2022 21:08:49 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id w3-20020a17090a460300b00218524e8877so11257701pjg.1
        for <linux-pci@vger.kernel.org>; Sun, 20 Nov 2022 21:08:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oM4t9dSTJRNYdl1z0tkjCktIi2YLG2NdBqaOTxJOnfw=;
        b=LWtOZYu4jsTpQIJaiOHNEV7J1U5Hekz/2o745TGAHoP4cneloLCtSQcf2+7QCorM2v
         /xUrXy8tc3AyizxEql9WLY1OdpX3pQbIVxJtcFYql5RA3M4NDSaLMbPVj5dbObnT+KSU
         mczGTwZmAOwUux/wZ8ifvi0F01VtKfJ2/n71J43DQXUfTPipabpUdKiLGhjOMu1er+fR
         qpGgEsviAEicpqjzPwJSF+kZar5OCuUon7HJXQSuacsEE6kvxwtPpgVtTm/A/sLEJVHN
         qxeu2eQb8ByOQLwRwijUs3sPFsoh7Q/NUQWZepaz/G6oM8gj5IAM41nqgSYfzxRnFHnj
         8Fkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oM4t9dSTJRNYdl1z0tkjCktIi2YLG2NdBqaOTxJOnfw=;
        b=Kk6BKOq8ZTKor3x7XVgVeJinfmWONKsuwK9T17TenugfwD64K8ip8REE9DgqghIkZh
         BKO6thzgeqCPUhuCT2Z/YUaHOCqBWO65rLW0tZyDIpZzpgukxchkUit5Kmuu9ROBPuiu
         R1GBqPj3GOrFPaW4bqEZiKWqFVwJwR9TFR4nzHHp4nmCEl3FeNUoOJ3ECjpKMFHz2cUo
         HiETROZ9lFTAJU5ly38ovfMleye7RRlblgkm4aZp+YNrONZWNVktnqe1c9lNrLGhQ1G7
         Vd89ue0BZLBZ3ouptsnPoCiJe/KQ9R1+Oy6emDZ0iHQfLStiN88VkhjqdSOThc5r5s2Z
         LXJg==
X-Gm-Message-State: ANoB5plsKEbzIZ39bTpZhjLaLJxmXMui2zPb78rs6O0cxSLtYiXdP5AX
        i+jauIaN++e0MFCVNT5uhbUDrw==
X-Google-Smtp-Source: AA0mqf7JM7TMYC6I8OTgp5yVOi9dOvfTXAD2akuhU7ByBbq+4L3OQY/x8/g9Bql+etELz/ggxI+lHw==
X-Received: by 2002:a17:90a:b706:b0:212:e75b:1602 with SMTP id l6-20020a17090ab70600b00212e75b1602mr18701960pjr.139.1669007329319;
        Sun, 20 Nov 2022 21:08:49 -0800 (PST)
Received: from localhost ([122.172.85.60])
        by smtp.gmail.com with ESMTPSA id z7-20020aa79f87000000b005625d5ae760sm7895356pfr.11.2022.11.20.21.08.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Nov 2022 21:08:48 -0800 (PST)
Date:   Mon, 21 Nov 2022 10:38:46 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Ilia Lin <ilia.lin@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Yangtao Li <tiny.windzz@gmail.com>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Sergio Paracuellos <sergio.paracuellos@gmail.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Jianjun Wang <jianjun.wang@mediatek.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Javier Martinez Canillas <javier@dowhile0.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Maxime Ripard <mripard@kernel.org>,
        Daniel Mack <zonque@gmail.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hwmon@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-pci@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        linux-renesas-soc@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-spi@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: Add missing start and/or end of line regex
 anchors
Message-ID: <20221121050846.m7w52iygltb5xivt@vireshk-i7>
References: <20221118223728.1721589-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221118223728.1721589-1-robh@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 18-11-22, 16:37, Rob Herring wrote:
> json-schema patterns by default will match anywhere in a string, so
> typically we want at least the start or end anchored. Fix the obvious
> cases where the anchors were forgotten.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  .../devicetree/bindings/cpufreq/qcom-cpufreq-nvmem.yaml       | 2 +-
>  Documentation/devicetree/bindings/hwmon/adt7475.yaml          | 4 ++--
>  .../bindings/opp/allwinner,sun50i-h6-operating-points.yaml    | 4 ++--
>  .../devicetree/bindings/pci/mediatek,mt7621-pcie.yaml         | 2 +-
>  .../devicetree/bindings/pci/renesas,pci-rcar-gen2.yaml        | 2 +-
>  Documentation/devicetree/bindings/regulator/max8660.yaml      | 2 +-
>  .../devicetree/bindings/regulator/maxim,max77802.yaml         | 2 +-
>  Documentation/devicetree/bindings/regulator/regulator.yaml    | 2 +-
>  .../devicetree/bindings/regulator/rohm,bd9576-regulator.yaml  | 2 +-
>  Documentation/devicetree/bindings/sound/renesas,rsnd.yaml     | 2 +-
>  .../devicetree/bindings/spi/nvidia,tegra210-quad.yaml         | 2 +-
>  11 files changed, 13 insertions(+), 13 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/cpufreq/qcom-cpufreq-nvmem.yaml b/Documentation/devicetree/bindings/cpufreq/qcom-cpufreq-nvmem.yaml
> index a11e1b867379..3c00ad09eeaa 100644
> --- a/Documentation/devicetree/bindings/cpufreq/qcom-cpufreq-nvmem.yaml
> +++ b/Documentation/devicetree/bindings/cpufreq/qcom-cpufreq-nvmem.yaml
> @@ -38,7 +38,7 @@ properties:
>      type: object
>  
>      patternProperties:
> -      'cpu@[0-9a-f]+':
> +      '^cpu@[0-9a-f]+$':
>          type: object
>  
>          properties:

> diff --git a/Documentation/devicetree/bindings/opp/allwinner,sun50i-h6-operating-points.yaml b/Documentation/devicetree/bindings/opp/allwinner,sun50i-h6-operating-points.yaml
> index 385b0692261c..51f62c3ae194 100644
> --- a/Documentation/devicetree/bindings/opp/allwinner,sun50i-h6-operating-points.yaml
> +++ b/Documentation/devicetree/bindings/opp/allwinner,sun50i-h6-operating-points.yaml
> @@ -41,7 +41,7 @@ required:
>    - nvmem-cells
>  
>  patternProperties:
> -  "opp-[0-9]+":
> +  "^opp-[0-9]+$":
>      type: object
>  
>      properties:
> @@ -49,7 +49,7 @@ patternProperties:
>        clock-latency-ns: true
>  
>      patternProperties:
> -      "opp-microvolt-.*": true
> +      "^opp-microvolt-speed[0-9]$": true
>  
>      required:
>        - opp-hz

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
