Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0A3F609744
	for <lists+linux-pci@lfdr.de>; Mon, 24 Oct 2022 01:27:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229648AbiJWX10 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 23 Oct 2022 19:27:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbiJWX1Z (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 23 Oct 2022 19:27:25 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DE8961713;
        Sun, 23 Oct 2022 16:27:20 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id a13so25481245edj.0;
        Sun, 23 Oct 2022 16:27:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=r7iyv6pLHUBbgESpB7JB72bYJbis0tyU09CNwJiXEDM=;
        b=CoFo213eBE00ntw45QBY1gNGx5qi3iC2DSNkjPXd3LI7XAgYBRV/Ko2ip5kF4x74pq
         SQEFw0CJfk8JpUg24Q0cUGqUQxVEIkwelYK/h6tUdpaJC08UmxARrbMGjF9iQohV9thG
         Rr5YKSkrgfJ+CAN6SQv4kQLOkd1So000EWUQNi5h7w/dgQg2J5AbEEKkh9z22NLBWDss
         bb877kfyTTmNmWNNElrv1A+aRXJuIPP4HY7LVEAT0Nc9eXXCoO3PXYoq+J6CsaRAR2uC
         1wUAeHt9EvixTb4cg2rNT6qaYiA486XYZv7wr13//uQ5yXF+qzpYs9CZ8/b1gEBdeEQ0
         YIew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=r7iyv6pLHUBbgESpB7JB72bYJbis0tyU09CNwJiXEDM=;
        b=my9JtlJhbQLJ/n8SCXXyTiwNVXsAwVnek5IeSHFc8USGF0TMYy9J5hyHcGMcxtLuDN
         0FdQ8MC/vwlymAUK9orR3BAklADXHmHJFWSoOSsm6HoTcIaX2jl0lseMK1AINW7nymXq
         9qmkPpQGyy7xPd7/MA3znuNf+8VnnVHZsreES/T+Oo4lDZ99YB7GzYpX9hzLoFlsOk20
         ApEKwGU4ylL+iIPUSACGkk9sx+IaeRcYZD38N1FmDV7rNGhI2rifWrECdnSgd5MrZucl
         TpEnUGPIOTFFqImWEXxzS6oJA9OYGKfqrSGG7Qom0IffdkwuTLqx9/BNbN4dZZwiCH3V
         ZEow==
X-Gm-Message-State: ACrzQf0V1yZpv7ECuZo4SitHEgoQ62rnu42gTdliiJ2jV8Kk3P9x+mjP
        1bffiH7lyqQCaHHl+Is/jQi9YLPDXRtnwWweC6U=
X-Google-Smtp-Source: AMsMyM7XeZUFA2THcAbqqTH0GuKnXsqwRj2Ff97GJP5fJ5EYSZwPC8nc4rLfVdhgst/1bRna3ZqCeK5oJyfxIgFuOrI=
X-Received: by 2002:a17:907:2c4a:b0:78d:f5c2:70d1 with SMTP id
 hf10-20020a1709072c4a00b0078df5c270d1mr25514305ejc.198.1666567638547; Sun, 23
 Oct 2022 16:27:18 -0700 (PDT)
MIME-Version: 1.0
References: <20221020103120.1541862-1-dmitry.baryshkov@linaro.org> <20221020103120.1541862-4-dmitry.baryshkov@linaro.org>
In-Reply-To: <20221020103120.1541862-4-dmitry.baryshkov@linaro.org>
From:   Han Jingoo <jingoohan1@gmail.com>
Date:   Sun, 23 Oct 2022 16:27:07 -0700
Message-ID: <CAPOBaE5Zg+r0F35MvKWAozFa9x4xvym1LbA_UHvUSmnLbTpqzA@mail.gmail.com>
Subject: Re: [PATCH 3/4] PCI: qcom: Use clk_bulk_ API for 2.3.2 clocks handling
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        Johan Hovold <johan@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Oct 20, 2022 Dmitry Baryshkov <dmitry.baryshkov@linaro.org> wrote:
>
> Change hand-coded implementation of bulk clocks to use the existing
> clk_bulk_* API.
>
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
>  drivers/pci/controller/dwc/pcie-qcom.c | 68 ++++++--------------------
>  1 file changed, 15 insertions(+), 53 deletions(-)
>
> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> index 74588438db07..eee4d2179e90 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> @@ -139,11 +139,9 @@ struct qcom_pcie_resources_1_0_0 {
>  };
>
>  #define QCOM_PCIE_2_3_2_MAX_SUPPLY     2
> +#define QCOM_PCIE_2_3_2_MAX_CLOCKS     4
>  struct qcom_pcie_resources_2_3_2 {
> -       struct clk *aux_clk;
> -       struct clk *master_clk;
> -       struct clk *slave_clk;
> -       struct clk *cfg_clk;
> +       struct clk_bulk_data clks[QCOM_PCIE_2_3_2_MAX_CLOCKS];
>         struct regulator_bulk_data supplies[QCOM_PCIE_2_3_2_MAX_SUPPLY];
>  };
>
> @@ -571,21 +569,14 @@ static int qcom_pcie_get_resources_2_3_2(struct qcom_pcie *pcie)
>         if (ret)
>                 return ret;
>
> -       res->aux_clk = devm_clk_get(dev, "aux");
> -       if (IS_ERR(res->aux_clk))
> -               return PTR_ERR(res->aux_clk);
> -
> -       res->cfg_clk = devm_clk_get(dev, "cfg");
> -       if (IS_ERR(res->cfg_clk))
> -               return PTR_ERR(res->cfg_clk);
> -
> -       res->master_clk = devm_clk_get(dev, "bus_master");
> -       if (IS_ERR(res->master_clk))
> -               return PTR_ERR(res->master_clk);
> +       res->clks[0].id = "aux";
> +       res->clks[1].id = "cfg";
> +       res->clks[2].id = "master";

Hi Dmitry,

I just have a simple question on clock names. The original clock name
is 'bus_master', while your patch uses just 'master' as the clock name.
As far as I know, the clock names are defined by clock side, not device
driver side. Is it intentional? If so, would you please explain why it is ok?

> +       res->clks[3].id = "slave";

Ditto.

Thank you.

Best regards,
Jingoo Han

>
> -       res->slave_clk = devm_clk_get(dev, "bus_slave");
> -       if (IS_ERR(res->slave_clk))
> -               return PTR_ERR(res->slave_clk);
> +       ret = devm_clk_bulk_get(dev, ARRAY_SIZE(res->clks), res->clks);
> +       if (ret < 0)
> +               return ret;
>
>         return 0;
>  }
> @@ -594,11 +585,7 @@ static void qcom_pcie_deinit_2_3_2(struct qcom_pcie *pcie)
>  {
>         struct qcom_pcie_resources_2_3_2 *res = &pcie->res.v2_3_2;
>
> -       clk_disable_unprepare(res->slave_clk);
> -       clk_disable_unprepare(res->master_clk);
> -       clk_disable_unprepare(res->cfg_clk);
> -       clk_disable_unprepare(res->aux_clk);
> -
> +       clk_bulk_disable_unprepare(ARRAY_SIZE(res->clks), res->clks);
>         regulator_bulk_disable(ARRAY_SIZE(res->supplies), res->supplies);
>  }
>
> @@ -615,40 +602,15 @@ static int qcom_pcie_init_2_3_2(struct qcom_pcie *pcie)
>                 return ret;
>         }
>
> -       ret = clk_prepare_enable(res->aux_clk);
> -       if (ret) {
> -               dev_err(dev, "cannot prepare/enable aux clock\n");
> -               goto err_aux_clk;
> -       }
> -
> -       ret = clk_prepare_enable(res->cfg_clk);
> -       if (ret) {
> -               dev_err(dev, "cannot prepare/enable cfg clock\n");
> -               goto err_cfg_clk;
> -       }
> -
> -       ret = clk_prepare_enable(res->master_clk);
> -       if (ret) {
> -               dev_err(dev, "cannot prepare/enable master clock\n");
> -               goto err_master_clk;
> -       }
> -
> -       ret = clk_prepare_enable(res->slave_clk);
> -       if (ret) {
> -               dev_err(dev, "cannot prepare/enable slave clock\n");
> -               goto err_slave_clk;
> +       ret = clk_bulk_prepare_enable(ARRAY_SIZE(res->clks), res->clks);
> +       if (ret < 0) {
> +               dev_err(dev, "cannot prepare/enable clocks\n");
> +               goto err_clks;
>         }
>
>         return 0;
>
> -err_slave_clk:
> -       clk_disable_unprepare(res->master_clk);
> -err_master_clk:
> -       clk_disable_unprepare(res->cfg_clk);
> -err_cfg_clk:
> -       clk_disable_unprepare(res->aux_clk);
> -
> -err_aux_clk:
> +err_clks:
>         regulator_bulk_disable(ARRAY_SIZE(res->supplies), res->supplies);
>
>         return ret;
> --
> 2.35.1
>
