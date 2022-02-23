Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 536C04C0FC7
	for <lists+linux-pci@lfdr.de>; Wed, 23 Feb 2022 11:04:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237114AbiBWKE2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 23 Feb 2022 05:04:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233606AbiBWKE1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 23 Feb 2022 05:04:27 -0500
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E1168A329
        for <linux-pci@vger.kernel.org>; Wed, 23 Feb 2022 02:04:00 -0800 (PST)
Received: by mail-lj1-x22a.google.com with SMTP id u7so16268083ljk.13
        for <linux-pci@vger.kernel.org>; Wed, 23 Feb 2022 02:04:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=9g7NR8Bf2LTodprIFu3Y3R5c47jJwfGT/VKE7qfEfOU=;
        b=bPvs7dR/WY2xOa83Bltq/4jx1D4IkgJcnaWg8NK14qeTYQv4Q0qzsutllQyUbOoG8u
         X9951KUZuYSihI6Z6Nm9wQggh8/IWaSZa2gf8C9J6CjpLlcSwdm+drLY2x0f9hQMgDvd
         OJksym0tRHzczmuoJnrPchFiaXFxk1H/qMaJFAfY2hvYRhHxhgeC8jAbLpU6cyYe1TdS
         rAFicYXAMK9jFBDqVGKrgS31otLD/cHkYLHAafYIug2TFD5aVAVADE5GcPLRAYR5gyao
         2XmXQWFeucnNK8ei4aCtFAQzqFyEKwfwJ6O2vvZandxvop4iwMrk716kQlz15OTwAcDi
         0mFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=9g7NR8Bf2LTodprIFu3Y3R5c47jJwfGT/VKE7qfEfOU=;
        b=3lrjBbaQE9ocruMBKelVoeZCL7U93yvqEP2lVl/HP4b9irtMbja7yxrbXnwcrHiyOr
         QT35wN5Nx41OfMM68FOy2rSM3YGy6q4k/y/9IngRojD0TjYzxNrvJVnjTKyRSoJZejxD
         Za6MjEswU+mYegzqiDwhAVCs/3b+IqPTCPknI/r/DH1hwJKb7C+9gg2zmP553YNxDP1r
         +6GTCV+uG6eZ5W9TL68wXe5a/NVJftX9O8BYow5ih0PfZXkzaSKIS1tnaYK6fiGrSQbU
         IJ1LABu6W8gLzgf5XtSshByAQTMqyBYBGnIcy4fi6XE/jTWMcNcHaPfTKLD91x8COu9u
         mV1A==
X-Gm-Message-State: AOAM532WJr3PKuDvUnfjMBH2xIIWPG5ErmIxj7mFZYZr6aP3bQVFANUd
        lKseQGlCIchwgl5UVlsc8Yq/Zg==
X-Google-Smtp-Source: ABdhPJxB8TjcBO/FaZT1B0aMYF/OG4uBXijSS5Vg2R9wh4HlsoechFEJLx9iSxJ4vfPhLfBMIz6CVg==
X-Received: by 2002:a05:651c:170d:b0:244:df25:db27 with SMTP id be13-20020a05651c170d00b00244df25db27mr20196656ljb.310.1645610638760;
        Wed, 23 Feb 2022 02:03:58 -0800 (PST)
Received: from [192.168.43.7] ([94.25.228.217])
        by smtp.gmail.com with ESMTPSA id v7sm2059543ljd.120.2022.02.23.02.03.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Feb 2022 02:03:58 -0800 (PST)
Message-ID: <9ff67710-362e-d0d4-2603-0c0ea6d1cce4@linaro.org>
Date:   Wed, 23 Feb 2022 13:03:56 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH] PCI: qcom: Add support for handling MSIs from 8 endpoints
Content-Language: en-GB
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        lorenzo.pieralisi@arm.com, bhelgaas@google.com
Cc:     svarbanov@mm-sol.com, bjorn.andersson@linaro.org, robh@kernel.org,
        linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20211214101319.25258-1-manivannan.sadhasivam@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20211214101319.25258-1-manivannan.sadhasivam@linaro.org>
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

On 14/12/2021 13:13, Manivannan Sadhasivam wrote:
> The DWC controller used in the Qcom Platforms are capable of addressing the
> MSIs generated from 8 different endpoints each with 32 vectors (256 in
> total). Currently the driver is using the default value of addressing the
> MSIs from 1 endpoint only. Extend it by passing the MAX_MSI_IRQS to the
> num_vectors field of pcie_port structure.
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Tested-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

> ---
>   drivers/pci/controller/dwc/pcie-qcom.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> index 1c3d1116bb60..8a4c08d815a5 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> @@ -1550,6 +1550,7 @@ static int qcom_pcie_probe(struct platform_device *pdev)
>   	pci->dev = dev;
>   	pci->ops = &dw_pcie_ops;
>   	pp = &pci->pp;
> +	pp->num_vectors = MAX_MSI_IRQS;
>   
>   	pcie->pci = pci;
>   


-- 
With best wishes
Dmitry
