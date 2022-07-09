Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 805A756C802
	for <lists+linux-pci@lfdr.de>; Sat,  9 Jul 2022 10:25:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229496AbiGIIZT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 9 Jul 2022 04:25:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbiGIIZT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 9 Jul 2022 04:25:19 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D02C94A805
        for <linux-pci@vger.kernel.org>; Sat,  9 Jul 2022 01:25:17 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id z12-20020a17090a7b8c00b001ef84000b8bso3968045pjc.1
        for <linux-pci@vger.kernel.org>; Sat, 09 Jul 2022 01:25:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=/Sx0YWTOU70ldR3qqRLiimjlPwcJ9/ZDdFLcC6JdMgc=;
        b=GFukNcWocDEKQ8p1Vr7y9wt8wzLNjfnf3r0mCzRBEbpO+N4nhKVlsoBIlYgNke4OIE
         kcN6ptLfXPAuhhRQWeEmyLZMaXmJQEuPxHfh5V2uuBPE51gtC7yJOPm5/zFqTrKUiDiG
         J7BxP0bL80mby6CoXKv91M6+/96Ye4vJ/JI9oza8IWlK/+q3LXFfU8c6EYsY29imoStr
         XAGmZu19TYrQHd+p3RoyQ4FomGPbjMfLwAv8M8TKx207RxpRLRTdR21KbT/EnLmZ9nNT
         wKlGglJxQRWf7Gm3LnO/W1+KASmkj190IoIy/ztV1fVJdemmOZYwJ4ZVSs+gjJm/+bIn
         8bug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=/Sx0YWTOU70ldR3qqRLiimjlPwcJ9/ZDdFLcC6JdMgc=;
        b=FeF/R8fYZKbAIWrjw486f9hUZvh2HVKk5j8pIF84/7quk6BBBjntxg8Vt6lo/rYbWX
         b/883DK2FGPdWl/UQ5/aPGOWJva5Mx13YQYp0n6cu5zmaI4072xvuj5EO3JdSRBvhoXc
         eBsEIjZKAzYgbYLzVQ33FnEHMHjMjHaMaVczOgZIow/ByNKVEPd6/MZoRZ0pLoav7enK
         aTpvglXE2UwPRj4qEketHpj0z9unmnvvrzrryUgpgcf01N0sVvrbE4v7pYTcrDPxotTm
         Jn/DqpZKKOs5OWlHpwMMjYFUdWhy+TqPpVKsU53gw8BrG+8m2yq/qFmzxa05j1a/zOpL
         ENBw==
X-Gm-Message-State: AJIora+OXOaoi0wvpEWr6+1ejqRVXA5nN1oAAGfz/CEg5pQK+hxqfN64
        63UZcd/KsABLYNMktSi5LkqX
X-Google-Smtp-Source: AGRyM1ufOWTPz98QGa9I0QzB1DRe7WPSkiwMrjR3T/xAs6zT96KF64La56lHoPYR55s6Ev1/9xDfxA==
X-Received: by 2002:a17:90b:4ac1:b0:1ef:c1ba:e73e with SMTP id mh1-20020a17090b4ac100b001efc1bae73emr4717331pjb.47.1657355117339;
        Sat, 09 Jul 2022 01:25:17 -0700 (PDT)
Received: from thinkpad ([117.207.26.140])
        by smtp.gmail.com with ESMTPSA id u188-20020a6260c5000000b0050dc7628183sm939074pfb.93.2022.07.09.01.25.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Jul 2022 01:25:17 -0700 (PDT)
Date:   Sat, 9 Jul 2022 13:55:09 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Johan Hovold <johan+linaro@kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 09/10] PCI: qcom: Clean up IP configurations
Message-ID: <20220709082509.GP5063@thinkpad>
References: <20220629141000.18111-1-johan+linaro@kernel.org>
 <20220629141000.18111-10-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220629141000.18111-10-johan+linaro@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jun 29, 2022 at 04:09:59PM +0200, Johan Hovold wrote:
> The various IP versions have different configurations that are encoded
> in separate sets of operation callbacks. Currently, there is no need for
> also maintaining corresponding sets of data parameters, but it is
> conceivable that these may again be found useful (e.g. to implement
> minor variations of the operation callbacks).
> 
> Rename the default configuration structures after the IP version they
> apply to so that they can more easily be reused by different SoCs.
> 
> Note that SoC specific configurations can be added later if need arises
> (e.g. cfg_sc8280xp).
> 
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Thanks,
Mani

> ---
>  drivers/pci/controller/dwc/pcie-qcom.c | 85 ++++++++------------------
>  1 file changed, 27 insertions(+), 58 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> index 1a564f624bb1..567601679465 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> @@ -1433,65 +1433,34 @@ static const struct qcom_pcie_ops ops_1_9_0 = {
>  	.config_sid = qcom_pcie_config_sid_sm8250,
>  };
>  
> -static const struct qcom_pcie_cfg apq8084_cfg = {
> +static const struct qcom_pcie_cfg cfg_1_0_0 = {
>  	.ops = &ops_1_0_0,
>  };
>  
> -static const struct qcom_pcie_cfg ipq8064_cfg = {
> +static const struct qcom_pcie_cfg cfg_1_9_0 = {
> +	.ops = &ops_1_9_0,
> +};
> +
> +static const struct qcom_pcie_cfg cfg_2_1_0 = {
>  	.ops = &ops_2_1_0,
>  };
>  
> -static const struct qcom_pcie_cfg msm8996_cfg = {
> +static const struct qcom_pcie_cfg cfg_2_3_2 = {
>  	.ops = &ops_2_3_2,
>  };
>  
> -static const struct qcom_pcie_cfg ipq8074_cfg = {
> +static const struct qcom_pcie_cfg cfg_2_3_3 = {
>  	.ops = &ops_2_3_3,
>  };
>  
> -static const struct qcom_pcie_cfg ipq4019_cfg = {
> +static const struct qcom_pcie_cfg cfg_2_4_0 = {
>  	.ops = &ops_2_4_0,
>  };
>  
> -static const struct qcom_pcie_cfg sa8540p_cfg = {
> -	.ops = &ops_1_9_0,
> -};
> -
> -static const struct qcom_pcie_cfg sc8280xp_cfg = {
> -	.ops = &ops_1_9_0,
> -};
> -
> -static const struct qcom_pcie_cfg sdm845_cfg = {
> +static const struct qcom_pcie_cfg cfg_2_7_0 = {
>  	.ops = &ops_2_7_0,
>  };
>  
> -static const struct qcom_pcie_cfg sm8150_cfg = {
> -	/* sm8150 has qcom IP rev 1.5.0. However 1.5.0 ops are same as
> -	 * 1.9.0, so reuse the same.
> -	 */
> -	.ops = &ops_1_9_0,
> -};
> -
> -static const struct qcom_pcie_cfg sm8250_cfg = {
> -	.ops = &ops_1_9_0,
> -};
> -
> -static const struct qcom_pcie_cfg sm8450_pcie0_cfg = {
> -	.ops = &ops_1_9_0,
> -};
> -
> -static const struct qcom_pcie_cfg sm8450_pcie1_cfg = {
> -	.ops = &ops_1_9_0,
> -};
> -
> -static const struct qcom_pcie_cfg sc7280_cfg = {
> -	.ops = &ops_1_9_0,
> -};
> -
> -static const struct qcom_pcie_cfg sc8180x_cfg = {
> -	.ops = &ops_1_9_0,
> -};
> -
>  static const struct dw_pcie_ops dw_pcie_ops = {
>  	.link_up = qcom_pcie_link_up,
>  	.start_link = qcom_pcie_start_link,
> @@ -1603,23 +1572,23 @@ static int qcom_pcie_remove(struct platform_device *pdev)
>  }
>  
>  static const struct of_device_id qcom_pcie_match[] = {
> -	{ .compatible = "qcom,pcie-apq8084", .data = &apq8084_cfg },
> -	{ .compatible = "qcom,pcie-ipq8064", .data = &ipq8064_cfg },
> -	{ .compatible = "qcom,pcie-ipq8064-v2", .data = &ipq8064_cfg },
> -	{ .compatible = "qcom,pcie-apq8064", .data = &ipq8064_cfg },
> -	{ .compatible = "qcom,pcie-msm8996", .data = &msm8996_cfg },
> -	{ .compatible = "qcom,pcie-ipq8074", .data = &ipq8074_cfg },
> -	{ .compatible = "qcom,pcie-ipq4019", .data = &ipq4019_cfg },
> -	{ .compatible = "qcom,pcie-qcs404", .data = &ipq4019_cfg },
> -	{ .compatible = "qcom,pcie-sa8540p", .data = &sa8540p_cfg },
> -	{ .compatible = "qcom,pcie-sdm845", .data = &sdm845_cfg },
> -	{ .compatible = "qcom,pcie-sm8150", .data = &sm8150_cfg },
> -	{ .compatible = "qcom,pcie-sm8250", .data = &sm8250_cfg },
> -	{ .compatible = "qcom,pcie-sc8180x", .data = &sc8180x_cfg },
> -	{ .compatible = "qcom,pcie-sc8280xp", .data = &sc8280xp_cfg },
> -	{ .compatible = "qcom,pcie-sm8450-pcie0", .data = &sm8450_pcie0_cfg },
> -	{ .compatible = "qcom,pcie-sm8450-pcie1", .data = &sm8450_pcie1_cfg },
> -	{ .compatible = "qcom,pcie-sc7280", .data = &sc7280_cfg },
> +	{ .compatible = "qcom,pcie-apq8084", .data = &cfg_1_0_0 },
> +	{ .compatible = "qcom,pcie-ipq8064", .data = &cfg_2_1_0 },
> +	{ .compatible = "qcom,pcie-ipq8064-v2", .data = &cfg_2_1_0 },
> +	{ .compatible = "qcom,pcie-apq8064", .data = &cfg_2_1_0 },
> +	{ .compatible = "qcom,pcie-msm8996", .data = &cfg_2_3_2 },
> +	{ .compatible = "qcom,pcie-ipq8074", .data = &cfg_2_3_3 },
> +	{ .compatible = "qcom,pcie-ipq4019", .data = &cfg_2_4_0 },
> +	{ .compatible = "qcom,pcie-qcs404", .data = &cfg_2_4_0 },
> +	{ .compatible = "qcom,pcie-sa8540p", .data = &cfg_1_9_0 },
> +	{ .compatible = "qcom,pcie-sdm845", .data = &cfg_2_7_0 },
> +	{ .compatible = "qcom,pcie-sm8150", .data = &cfg_1_9_0 },
> +	{ .compatible = "qcom,pcie-sm8250", .data = &cfg_1_9_0 },
> +	{ .compatible = "qcom,pcie-sc8180x", .data = &cfg_1_9_0 },
> +	{ .compatible = "qcom,pcie-sc8280xp", .data = &cfg_1_9_0 },
> +	{ .compatible = "qcom,pcie-sm8450-pcie0", .data = &cfg_1_9_0 },
> +	{ .compatible = "qcom,pcie-sm8450-pcie1", .data = &cfg_1_9_0 },
> +	{ .compatible = "qcom,pcie-sc7280", .data = &cfg_1_9_0 },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(of, qcom_pcie_match);
> -- 
> 2.35.1
> 

-- 
மணிவண்ணன் சதாசிவம்
