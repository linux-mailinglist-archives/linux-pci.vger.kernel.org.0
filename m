Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94ED24C8B0E
	for <lists+linux-pci@lfdr.de>; Tue,  1 Mar 2022 12:43:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234627AbiCALoh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 1 Mar 2022 06:44:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234616AbiCALoh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 1 Mar 2022 06:44:37 -0500
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9853455BD1
        for <linux-pci@vger.kernel.org>; Tue,  1 Mar 2022 03:43:56 -0800 (PST)
Received: by mail-lj1-x236.google.com with SMTP id s25so21499414lji.5
        for <linux-pci@vger.kernel.org>; Tue, 01 Mar 2022 03:43:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=SEk3in6d11xvs8mwQBocWYXf/yhdK/EMkyVlgK9A4i8=;
        b=CswNEEJn4JADhLcX4CAe+MctkNkw32JX9FA1Ik86hWA1dPYwZ9UPTGZjDeXbWcI2y4
         t84RoTdIrvN8SQtmHUCUMW7FGCVyQrYeG7XJNHyVUaChUmtmSYsVxraD2GbESM2fxGWs
         PKaNXmLncNnprvELIXil4KzV9JS9W4dLniO3l8RmVVnVA7LDM1eBACs6JEH8jGEA2zJL
         bl6Bw/Xv56PdiIiK7p3JfQoKUDYgnlIOTFjmxvKeGavoMrauovu37hv0Vf1HsWcNlmxT
         5Is2TClhySG+Ruvd8WWxusQmWZGzY17UBq7/A2UihfoDDv79jwYIpiXC1s3i/hEaU6fw
         +v3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=SEk3in6d11xvs8mwQBocWYXf/yhdK/EMkyVlgK9A4i8=;
        b=Vp21Z7h2gEp6R3KVbt216ZxH4gp1RQhpMLO7axrKQCHdMKV/FTqQYw0AuaE2OIKIcc
         ehoqUbEpTvy1KFIvncarclt6qZkaIO77TwwOkD2rnSsJ9nf4vTlIi/KV8FSWg1+EBg/q
         306IuomxYnkktZUOu91cwQL5OpaZiYmsMOnXbqAwIoPIjHbedRAhFphVd/MuzgVHgc+H
         e4oLYlDossMNMhJW2P34QiLh4BD9KGK6UUIyKM/qqQPPb85Sw2+O5KvX6MY5VlHzvsFv
         B8vh9ub4gukS8NMyYLzjb+Pwjen0D6455ELkeIKl1/apHz6qhnALob6ec83WO2B6/DIO
         IMbQ==
X-Gm-Message-State: AOAM531TBYMprByxNgQvd1mev/KrF1AJAIOa3WK/I/Nv2Yvsxe3VAUpb
        LJEnk51lADvpu0ZMeGt/vEtEUQ==
X-Google-Smtp-Source: ABdhPJxS4NuiWgStxReQaqrCgjRgur8btsR+rcYdpUwTL+R6piVjHKBkqTSX3xRrZt2GL5n2A94dIQ==
X-Received: by 2002:a2e:891a:0:b0:246:293f:875e with SMTP id d26-20020a2e891a000000b00246293f875emr16364977lji.204.1646135034865;
        Tue, 01 Mar 2022 03:43:54 -0800 (PST)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id d11-20020ac25ecb000000b004433d2e6d22sm1443791lfq.132.2022.03.01.03.43.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Mar 2022 03:43:54 -0800 (PST)
Message-ID: <d51717a2-0a50-f2fb-0d2d-e233c6e75d4b@linaro.org>
Date:   Tue, 1 Mar 2022 14:43:50 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH v2 5/7] PCI: qcom: Add SM8150 SoC support
Content-Language: en-GB
To:     Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     bhupesh.linux@gmail.com, lorenzo.pieralisi@arm.com,
        agross@kernel.org, bjorn.andersson@linaro.org,
        svarbanov@mm-sol.com, bhelgaas@google.com,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org, sboyd@kernel.org,
        mturquette@baylibre.com, linux-clk@vger.kernel.org,
        Vinod Koul <vkoul@kernel.org>
References: <20220301072511.117818-1-bhupesh.sharma@linaro.org>
 <20220301072511.117818-6-bhupesh.sharma@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20220301072511.117818-6-bhupesh.sharma@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 01/03/2022 10:25, Bhupesh Sharma wrote:
> The PCIe IP (rev 1.5.0) on SM8150 SoC is similar to the one used on
> SM8250. Hence the support is added reusing the members of ops_2_7_0.
> 
> Cc: Vinod Koul <vkoul@kernel.org>
> Cc: Rob Herring <robh+dt@kernel.org>
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
> ---
>   drivers/pci/controller/dwc/pcie-qcom.c | 16 ++++++++++++++++
>   1 file changed, 16 insertions(+)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> index c19cd506ed3f..66fbc0234888 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> @@ -1487,6 +1487,17 @@ static const struct qcom_pcie_ops ops_1_9_0 = {
>   	.config_sid = qcom_pcie_config_sid_sm8250,
>   };
>   
> +/* Qcom IP rev.: 1.5.0 */
> +static const struct qcom_pcie_ops ops_1_5_0 = {
> +	.get_resources = qcom_pcie_get_resources_2_7_0,
> +	.init = qcom_pcie_init_2_7_0,
> +	.deinit = qcom_pcie_deinit_2_7_0,
> +	.ltssm_enable = qcom_pcie_2_3_2_ltssm_enable,
> +	.post_init = qcom_pcie_post_init_2_7_0,
> +	.post_deinit = qcom_pcie_post_deinit_2_7_0,
> +	.config_sid = qcom_pcie_config_sid_sm8250,
> +};
> +

This duplicates the ops_1_9_0, doesn't it?
I'd suggest to reuse 1.9.0 structure and add a comment that it's also 
used for 1.5.0.

>   static const struct qcom_pcie_cfg apq8084_cfg = {
>   	.ops = &ops_1_0_0,
>   };
> @@ -1511,6 +1522,10 @@ static const struct qcom_pcie_cfg sdm845_cfg = {
>   	.ops = &ops_2_7_0,
>   };
>   
> +static const struct qcom_pcie_cfg sm8150_cfg = {
> +	.ops = &ops_1_5_0,
> +};
> +
>   static const struct qcom_pcie_cfg sm8250_cfg = {
>   	.ops = &ops_1_9_0,
>   };
> @@ -1626,6 +1641,7 @@ static const struct of_device_id qcom_pcie_match[] = {
>   	{ .compatible = "qcom,pcie-ipq4019", .data = &ipq4019_cfg },
>   	{ .compatible = "qcom,pcie-qcs404", .data = &ipq4019_cfg },
>   	{ .compatible = "qcom,pcie-sdm845", .data = &sdm845_cfg },
> +	{ .compatible = "qcom,pcie-sm8150", .data = &sm8150_cfg },
>   	{ .compatible = "qcom,pcie-sm8250", .data = &sm8250_cfg },
>   	{ .compatible = "qcom,pcie-sc8180x", .data = &sm8250_cfg },
>   	{ .compatible = "qcom,pcie-sc7280", .data = &sc7280_cfg },


-- 
With best wishes
Dmitry
