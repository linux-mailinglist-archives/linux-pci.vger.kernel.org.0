Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8E8A518B2D
	for <lists+linux-pci@lfdr.de>; Tue,  3 May 2022 19:35:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240484AbiECRjM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 3 May 2022 13:39:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240545AbiECRjD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 3 May 2022 13:39:03 -0400
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0356205D6
        for <linux-pci@vger.kernel.org>; Tue,  3 May 2022 10:35:30 -0700 (PDT)
Received: by mail-ot1-x332.google.com with SMTP id 31-20020a9d0822000000b00605f1807664so9028394oty.3
        for <linux-pci@vger.kernel.org>; Tue, 03 May 2022 10:35:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kali.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=QfFh0JorF10YS8jRL4ot/BDPWmDj6EZaL7oZvjv3Y4g=;
        b=ZmPQGGxZ1xNN/3ZnxABfH+S4dxGHSOp4xV35ALw7zVi0fEbQqhjvdLL33LibysCLc6
         gndVhg10yKBFoPGn++Q1Bjr1fGYAHLH89H69AumHDYCEvZRTJkLZcFWHu1rS6kS4yt/H
         YNtgfRTi1E3KvA/oPx/GVRJbBIYkaRYcUNaf8iq16nd6zoyd3HL9LbytMd4ijZ/qh6Qb
         +JLlP7UrqDZMTfq7gBD/ige/UEfSJ2LGEGUUSGqjNmG2qNuwFB0M0hJO/mgp78zhmprQ
         E/RjYf8s4qXceb2u7XoFE4QwO1sKpOYyOUSz+epbIY/4EcjmqfjflN10M/9hu4sOOPSf
         euXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=QfFh0JorF10YS8jRL4ot/BDPWmDj6EZaL7oZvjv3Y4g=;
        b=WbnU8vu7FDrZGjxWZ5NAJEPy+efZkGxB24oQaA4w2XmTpoPYZ0kD1vtqIwlph+WqBy
         WWWzbOYBecJQ87kuY0FpgJ/Wjc25i5A9XaiuA1Nlz+GhQDBEEzJwVIcovCPlAWCu+Agj
         wxugKg3VVxbM/5AgvWWZqte0udTzsll/ctNt07LVvTfIjYnLKrSw9h5jrOkThHvUOYJg
         SjgqPUeutb3WM/t8SqzDOKIc0ouanVF3xKeT1C5y9F40eGaIR9LmXabV4QC+U4n4oqw5
         oAbs8dWwsmI0iua4wWjzBCRiy7jM2uj2yTLhQJvtQiaEUiJX8XnfuVA/H9tsMQAk8DIt
         DS1Q==
X-Gm-Message-State: AOAM533SqnBcj5mrdQHfHu2BEM9pGpYu4dqxTMvSh7z+z+sarnT4bs4m
        KHy9MYjkbYqBamyE1Yg4Hx1shw==
X-Google-Smtp-Source: ABdhPJxT1Ilrm5hn2NJmQeaKaOKr12fYEZTHVrzNifiz+9FWtgnvvqVNJXC95vLYjSotHlZFpe8Z6w==
X-Received: by 2002:a9d:480e:0:b0:606:59b:2b2 with SMTP id c14-20020a9d480e000000b00606059b02b2mr5490428otf.277.1651599329952;
        Tue, 03 May 2022 10:35:29 -0700 (PDT)
Received: from [192.168.11.16] (cpe-173-173-107-246.satx.res.rr.com. [173.173.107.246])
        by smtp.gmail.com with ESMTPSA id p203-20020acaf1d4000000b00325cda1ffacsm3507693oih.43.2022.05.03.10.35.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 May 2022 10:35:29 -0700 (PDT)
Message-ID: <c9da618b-8910-d878-cb78-6304c687f725@kali.org>
Date:   Tue, 3 May 2022 12:35:27 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.8.1
Subject: Re: [PATCH] PCI: qcom: Remove ddrss_sf_tbu clock from sc8180x
Content-Language: en-US
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220331013415.592748-1-bjorn.andersson@linaro.org>
From:   Steev Klimaszewski <steev@kali.org>
In-Reply-To: <20220331013415.592748-1-bjorn.andersson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On 3/30/22 8:34 PM, Bjorn Andersson wrote:
> The Qualcomm SC8180X platform was piggy backing on the SM8250
> qcom_pcie_cfg, but the platform doesn't have the ddrss_sf_tbu clock, so
> it now fails to probe due to the missing clock.
>
> Give SC8180X its own qcom_pcie_cfg, without the ddrss_sf_tbu flag set.
>
> Fixes: 0614f98bbb9f ("PCI: qcom: Add ddrss_sf_tbu flag")
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---
>   drivers/pci/controller/dwc/pcie-qcom.c | 7 ++++++-
>   1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> index 6ab90891801d..816028c0f6ed 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> @@ -1550,6 +1550,11 @@ static const struct qcom_pcie_cfg sc7280_cfg = {
>   	.pipe_clk_need_muxing = true,
>   };
>   
> +static const struct qcom_pcie_cfg sc8180x_cfg = {
> +	.ops = &ops_1_9_0,
> +	.has_tbu_clk = true,
> +};
> +
>   static const struct dw_pcie_ops dw_pcie_ops = {
>   	.link_up = qcom_pcie_link_up,
>   	.start_link = qcom_pcie_start_link,
> @@ -1656,7 +1661,7 @@ static const struct of_device_id qcom_pcie_match[] = {
>   	{ .compatible = "qcom,pcie-qcs404", .data = &ipq4019_cfg },
>   	{ .compatible = "qcom,pcie-sdm845", .data = &sdm845_cfg },
>   	{ .compatible = "qcom,pcie-sm8250", .data = &sm8250_cfg },
> -	{ .compatible = "qcom,pcie-sc8180x", .data = &sm8250_cfg },
> +	{ .compatible = "qcom,pcie-sc8180x", .data = &sc8180x_cfg },
>   	{ .compatible = "qcom,pcie-sm8450-pcie0", .data = &sm8450_pcie0_cfg },
>   	{ .compatible = "qcom,pcie-sm8450-pcie1", .data = &sm8450_pcie1_cfg },
>   	{ .compatible = "qcom,pcie-sc7280", .data = &sc7280_cfg },

Hi Bjorn,

Tested on the Lenovo Flex 5G and fixes the issue I saw.

Tested-by: Steev Klimaszewski <steev@kali.org>

