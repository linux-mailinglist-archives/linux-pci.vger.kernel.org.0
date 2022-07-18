Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 110E7577FDE
	for <lists+linux-pci@lfdr.de>; Mon, 18 Jul 2022 12:39:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234341AbiGRKjj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 18 Jul 2022 06:39:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234340AbiGRKji (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 18 Jul 2022 06:39:38 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3E4D765E
        for <linux-pci@vger.kernel.org>; Mon, 18 Jul 2022 03:39:35 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id a10so13074303ljj.5
        for <linux-pci@vger.kernel.org>; Mon, 18 Jul 2022 03:39:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=yPxqKB77kyU9V8lnhOsK1GQJLunCLPWKLPbPXEb7VqM=;
        b=YPdYfpqYPenGGrKjxRKOqtqEciMGsRjSAnOPoaWHAJ+bAtHCJWZlXk+oOXQSLDezmL
         hfYl+CHNsyIAeFJCeIRsk0El/9vEWqzUcdvSxrNQhHrZC/EYDydH8D6lXhp/iSzdD4TK
         d5uYCUMyXWyWN2haGevP2ienPhQR45g5T2K554CxHx6b7EsclFGVTbS9U68bjX9zrHpD
         MBqc4yDKfqtLrFdttrrnq/Q+h+ZZzD6G/JRyv/WRi0KH652Lm7SGjl2LmBkjhTwaLjXq
         zx8erGF9B6h7GkOfYd7tX0K89PmaGTVWCYT1IFViGeKLjhD5o5Hz4OrHUimdg7kM2blc
         b0WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=yPxqKB77kyU9V8lnhOsK1GQJLunCLPWKLPbPXEb7VqM=;
        b=SrPwaIUJmUsUoyHnInE0v+CZs0CiZuuBKNhuFg261uATaOIHkDIxRs4fXzq/hm0vYQ
         7onzPEgCkbZcwIRXgWvOGXqV789/vlHLkhA3ZIVlsov32Ved95stE/1M/sw2VE9Tt2s6
         H/fG+7Szi7Lxufv/lEm4vPyQal+E/XNISKP4800OdFGuNmtb+GoR6JHhz6MBjb3ja0VX
         V/dkBf7DxtOdRzkXgyFD5cYTdKIuxqbbohA/7gNphmj6WiCSOYn1SLfoPy+r89u4Rv3c
         2qdJeyIrJ4pT0k7PIrUBPDBInm4j6GHyp0nYdR8uiKgiyQPjKXZ0aPcKSjLwLTGF9gGY
         UnSw==
X-Gm-Message-State: AJIora9JyaQsiQLN1T//T6tMc5j0TsV6cQk2ZGLIYbrL/h/1UDmGbDlG
        P4+v+oMmmtospdAmOBW577akpw==
X-Google-Smtp-Source: AGRyM1scKmN6ALHiC5oMMyrUNbx2hAFThxeUdXKc4IHkHRgeKvoKCp7Mo8e40GEOC+sL4O6jpOt3zw==
X-Received: by 2002:a2e:9113:0:b0:25d:68a9:c39b with SMTP id m19-20020a2e9113000000b0025d68a9c39bmr11899226ljg.175.1658140773955;
        Mon, 18 Jul 2022 03:39:33 -0700 (PDT)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id b2-20020a196442000000b00478f2f2f043sm2542692lfj.147.2022.07.18.03.39.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Jul 2022 03:39:33 -0700 (PDT)
Message-ID: <91edff9a-53f2-647b-04a8-76d15f22a8f2@linaro.org>
Date:   Mon, 18 Jul 2022 13:39:32 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v2 7/8] PCI: qcom: Clean up IP configurations
Content-Language: en-GB
To:     Johan Hovold <johan+linaro@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh@kernel.org>
References: <20220714071348.6792-1-johan+linaro@kernel.org>
 <20220714071348.6792-8-johan+linaro@kernel.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20220714071348.6792-8-johan+linaro@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 14/07/2022 10:13, Johan Hovold wrote:
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
> Reviewed-by: Rob Herring <robh@kernel.org>
> Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>


If we have nothing left in the qcom_pcie_cfg other than the .ops, what 
about dropping the qcom_pcie_cfg completely and using the qcom_pcie_ops 
as match data?

This patch is nevertheless:

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


> ---
>   drivers/pci/controller/dwc/pcie-qcom.c | 89 +++++++++-----------------
>   1 file changed, 29 insertions(+), 60 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> index 1339f05bee65..8dddb72f8647 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> @@ -1606,66 +1606,35 @@ static const struct qcom_pcie_ops ops_2_9_0 = {
>   	.ltssm_enable = qcom_pcie_2_3_2_ltssm_enable,
>   };
>   
> -static const struct qcom_pcie_cfg apq8084_cfg = {
> +static const struct qcom_pcie_cfg cfg_1_0_0 = {
>   	.ops = &ops_1_0_0,
>   };
>   
> -static const struct qcom_pcie_cfg ipq8064_cfg = {
> +static const struct qcom_pcie_cfg cfg_1_9_0 = {
> +	.ops = &ops_1_9_0,
> +};
> +
> +static const struct qcom_pcie_cfg cfg_2_1_0 = {
>   	.ops = &ops_2_1_0,
>   };
>   
> -static const struct qcom_pcie_cfg msm8996_cfg = {
> +static const struct qcom_pcie_cfg cfg_2_3_2 = {
>   	.ops = &ops_2_3_2,
>   };
>   
> -static const struct qcom_pcie_cfg ipq8074_cfg = {
> +static const struct qcom_pcie_cfg cfg_2_3_3 = {
>   	.ops = &ops_2_3_3,
>   };
>   
> -static const struct qcom_pcie_cfg ipq4019_cfg = {
> +static const struct qcom_pcie_cfg cfg_2_4_0 = {
>   	.ops = &ops_2_4_0,
>   };
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
>   	.ops = &ops_2_7_0,
>   };
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
> -static const struct qcom_pcie_cfg ipq6018_cfg = {
> +static const struct qcom_pcie_cfg cfg_2_9_0 = {
>   	.ops = &ops_2_9_0,
>   };
>   
> @@ -1780,24 +1749,24 @@ static int qcom_pcie_remove(struct platform_device *pdev)
>   }
>   
>   static const struct of_device_id qcom_pcie_match[] = {
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
> -	{ .compatible = "qcom,pcie-ipq6018", .data = &ipq6018_cfg },
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
> +	{ .compatible = "qcom,pcie-ipq6018", .data = &cfg_2_9_0 },
>   	{ }
>   };
>   MODULE_DEVICE_TABLE(of, qcom_pcie_match);


-- 
With best wishes
Dmitry
