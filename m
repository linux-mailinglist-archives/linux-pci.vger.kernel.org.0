Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 821D8562E8E
	for <lists+linux-pci@lfdr.de>; Fri,  1 Jul 2022 10:41:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234193AbiGAIk7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 1 Jul 2022 04:40:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234620AbiGAIk6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 1 Jul 2022 04:40:58 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A7EE71271
        for <linux-pci@vger.kernel.org>; Fri,  1 Jul 2022 01:40:55 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id e40so2071776eda.2
        for <linux-pci@vger.kernel.org>; Fri, 01 Jul 2022 01:40:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=DaoO2Oh5ICve9MWzzGSdzJJ+pAaFU/JIRH9tA7pG0Us=;
        b=uJ/Rp+gD/ScvGRaEW6Zn/ys6b0FJYEwfPNWm7Pubdu8PpcxqAh7lz8GwhzLal4zpey
         YYV1yrSPlOOK/pF2F9GbiquHtQidaQih7MsDEDretE+M+wsJaqr2QUVkCTgUCb2um6o1
         6Skz6yS6t+uSJyArGmQelUvAS8aCTYmMLdK7Q77jD6iQgXrabRGSPwSeLF0NCqv/t18D
         2g/J9op5toLoGpi0NJ2CflwRuto72p9ye1ynor6uwRjXcBUJsUpJgf4QYC6KzWcIQB2v
         YvHyMzSBRl+n2s633FBzjiUdaksuOwehgnG1YC3DrgqUX6Af3qiOfDb/Dr5FTcvo3/SV
         TIng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=DaoO2Oh5ICve9MWzzGSdzJJ+pAaFU/JIRH9tA7pG0Us=;
        b=BYBoWDtoGQa9kRB2Ufm+ZTVplDtrUwxUUVyMVifZ/Ml5JG0/K+thxtTbETngPg8peC
         J0q219o3MJJ+19I7+7lNNZfqf5PUqvGZDW3Pgb3qH3Vz9fjPlFt/S3Ec99uKM7aNLthW
         06PkMRQ7XoSqTH6yQek5o+8wrTnSaDx97DkCwGvo9+SPYRisRM7akQrWI9SY7Hv8wMc3
         frOE/FdrbCP/fHsE2SAXKVcwC+YRP7tJCcGdW1hPhElQB2o/dRkWwqceXnl/wOkeyS0s
         2HFqIoi4uz3Jjf6K2pxu5vWuRioF3w95OtP43PDV54ftsoTiuWOGk/PytK4UI3zJ+3/t
         qDkg==
X-Gm-Message-State: AJIora8mQ0SBASEjvLXZgCE1avXBRHj6aQXcBTXJwBGevcrkbay+Jme4
        Aast1VPr9Zusm50Am39DOTt5OQ==
X-Google-Smtp-Source: AGRyM1uqgTgoPDKzRWtjxYz7FE9icFv/fk15Z0KKZSkh0rHuRPUCgSplqxm/RktKxwv4wXZ2Za4P5w==
X-Received: by 2002:a05:6402:d0a:b0:437:66ca:c211 with SMTP id eb10-20020a0564020d0a00b0043766cac211mr17562227edb.29.1656664854135;
        Fri, 01 Jul 2022 01:40:54 -0700 (PDT)
Received: from [192.168.0.190] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id r1-20020a1709067fc100b0070e238ff66fsm10110519ejs.96.2022.07.01.01.40.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Jul 2022 01:40:53 -0700 (PDT)
Message-ID: <0cb92a07-b310-ddc8-a705-522842a6939f@linaro.org>
Date:   Fri, 1 Jul 2022 10:40:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 10/10] PCI: qcom: Sort device-id table
Content-Language: en-US
To:     Johan Hovold <johan+linaro@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220629141000.18111-1-johan+linaro@kernel.org>
 <20220629141000.18111-11-johan+linaro@kernel.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220629141000.18111-11-johan+linaro@kernel.org>
Content-Type: text/plain; charset=UTF-8
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

On 29/06/2022 16:10, Johan Hovold wrote:
> Sort the device-id table entries alphabetically by compatible string to
> make it easier to find entries and add new ones.
> 
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
>  drivers/pci/controller/dwc/pcie-qcom.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> index 567601679465..093f4d4bc15d 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> @@ -1572,23 +1572,23 @@ static int qcom_pcie_remove(struct platform_device *pdev)
>  }
>  
>  static const struct of_device_id qcom_pcie_match[] = {
> +	{ .compatible = "qcom,pcie-apq8064", .data = &cfg_2_1_0 },
>  	{ .compatible = "qcom,pcie-apq8084", .data = &cfg_1_0_0 },
>  	{ .compatible = "qcom,pcie-ipq8064", .data = &cfg_2_1_0 },
>  	{ .compatible = "qcom,pcie-ipq8064-v2", .data = &cfg_2_1_0 },
> -	{ .compatible = "qcom,pcie-apq8064", .data = &cfg_2_1_0 },
> -	{ .compatible = "qcom,pcie-msm8996", .data = &cfg_2_3_2 },
>  	{ .compatible = "qcom,pcie-ipq8074", .data = &cfg_2_3_3 },
>  	{ .compatible = "qcom,pcie-ipq4019", .data = &cfg_2_4_0 },
> -	{ .compatible = "qcom,pcie-qcs404", .data = &cfg_2_4_0 },
> +	{ .compatible = "qcom,pcie-msm8996", .data = &cfg_2_3_2 },
>  	{ .compatible = "qcom,pcie-sa8540p", .data = &cfg_1_9_0 },
> +	{ .compatible = "qcom,pcie-sc7280", .data = &cfg_1_9_0 },
> +	{ .compatible = "qcom,pcie-sc8180x", .data = &cfg_1_9_0 },
> +	{ .compatible = "qcom,pcie-sc8280xp", .data = &cfg_1_9_0 },
>  	{ .compatible = "qcom,pcie-sdm845", .data = &cfg_2_7_0 },
>  	{ .compatible = "qcom,pcie-sm8150", .data = &cfg_1_9_0 },
>  	{ .compatible = "qcom,pcie-sm8250", .data = &cfg_1_9_0 },
> -	{ .compatible = "qcom,pcie-sc8180x", .data = &cfg_1_9_0 },
> -	{ .compatible = "qcom,pcie-sc8280xp", .data = &cfg_1_9_0 },
>  	{ .compatible = "qcom,pcie-sm8450-pcie0", .data = &cfg_1_9_0 },
>  	{ .compatible = "qcom,pcie-sm8450-pcie1", .data = &cfg_1_9_0 },
> -	{ .compatible = "qcom,pcie-sc7280", .data = &cfg_1_9_0 },
> +	{ .compatible = "qcom,pcie-qcs404", .data = &cfg_2_4_0 },

Idea is good but it is not sorted alphabetically (not entirely). Q goes
before S.


Best regards,
Krzysztof
