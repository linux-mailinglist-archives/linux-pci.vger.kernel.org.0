Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FA136AD91A
	for <lists+linux-pci@lfdr.de>; Tue,  7 Mar 2023 09:20:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230015AbjCGIUH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 7 Mar 2023 03:20:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230295AbjCGITu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 7 Mar 2023 03:19:50 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E671350987
        for <linux-pci@vger.kernel.org>; Tue,  7 Mar 2023 00:19:32 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id j11so29486326edq.4
        for <linux-pci@vger.kernel.org>; Tue, 07 Mar 2023 00:19:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678177171;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=L29zoxdXB+9rG1fLUEgpKITaNSXX7YTpGeQMCFWsUlU=;
        b=cLhewAPwWGbiEgQD8BrRaTB9CISRVJiI1qsPS1xLwFqSeiJMaZHwItjU/fUVY4oBHk
         rKbUuu+ISdMGceZ2vKIYrJFcoDv3bYNP8sWXnDILI8QDuFpUwmGuIXNkz8WmHY948/It
         WAN/vk9WmheZlkSP8LaQP9G63+xCLRkmqbbreoabPHS3LqriMyNat2q8sYw0ra1q+XkC
         TAfIx/XHHdW0v3f8XGWwMN49AwcRCNxTnvvwzyKqpb1h5QjBR32mhsIT8iYkctgLhH6Z
         JfDZGCzEysm6VKU8eIgqMtlbUA4nh077de9pqbOxruTEcJ7q2hhPuPPNXYv/dQ1iSI7j
         q8uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678177171;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L29zoxdXB+9rG1fLUEgpKITaNSXX7YTpGeQMCFWsUlU=;
        b=XV8C3RcUDJIdszvFxTxXVkbQHNjY2A4f4qowt/3GBMkz9rGhuXMrtP2s2JXg68S3hE
         QdP8C3w6XoPxKKbAYiECBCk8BWAXzx4YA5CWmwW0qEfpbocjiMNmys/tvG4nz7TcWSy9
         p96/ZyKAB8cf2XvxXE5F4p4E5CVcqGLtI1ce6BQx+MJGGSGXqPc02Y22jvgQJ1imnhs3
         kfyDyv9a9Umow3WRYQmCU64m+xb9QLoYhBmpHS38L34CcI3wtqWa6e6/8LzQmwRb4G1V
         M/6ePDgqvpRm2q9PZ/M4eGgpl5hufNDab3RLX9PYa40DGk2rVBpoZ+f2E1sdro0dlFxW
         CDJA==
X-Gm-Message-State: AO0yUKVxYPp2gBRKZS43GKOgXiG6jE/KH02rQp5zOzvPYLzBGKtVnFnD
        e08o8oma/Y/j17TFRtx8Q+sXaA==
X-Google-Smtp-Source: AK7set9GIu+MHeoxgW3h+cvWIolDDHxYDsBBJR/WlR5sDK0s9E5NdGkl+9tcjjs/CRcV9o11YcaxIQ==
X-Received: by 2002:a17:907:d08:b0:878:4bc1:dd19 with SMTP id gn8-20020a1709070d0800b008784bc1dd19mr14627138ejc.52.1678177171461;
        Tue, 07 Mar 2023 00:19:31 -0800 (PST)
Received: from ?IPV6:2a02:810d:15c0:828:5310:35c7:6f9e:2cd3? ([2a02:810d:15c0:828:5310:35c7:6f9e:2cd3])
        by smtp.gmail.com with ESMTPSA id i24-20020a50d758000000b004ad15d5ef08sm6377165edj.58.2023.03.07.00.19.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Mar 2023 00:19:31 -0800 (PST)
Message-ID: <e1332d26-d686-be5a-952a-75af20c5cacb@linaro.org>
Date:   Tue, 7 Mar 2023 09:19:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 14/19] PCI: qcom-ep: Rename "mmio" region to "mhi"
Content-Language: en-US
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        andersson@kernel.org, lpieralisi@kernel.org, kw@linux.com,
        krzysztof.kozlowski+dt@linaro.org, robh@kernel.org
Cc:     konrad.dybcio@linaro.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_srichara@quicinc.com
References: <20230306153222.157667-1-manivannan.sadhasivam@linaro.org>
 <20230306153222.157667-15-manivannan.sadhasivam@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230306153222.157667-15-manivannan.sadhasivam@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 06/03/2023 16:32, Manivannan Sadhasivam wrote:
> As per Qualcomm's internal documentation, the name of the region is "mhi"
> and not "mmio". So let's rename it to follow the convention.
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---



>  
> @@ -477,16 +477,16 @@ static int qcom_pcie_ep_get_io_resources(struct platform_device *pdev,
>  	if (IS_ERR(pcie_ep->elbi))
>  		return PTR_ERR(pcie_ep->elbi);
>  
> -	pcie_ep->mmio_res = platform_get_resource_byname(pdev, IORESOURCE_MEM,
> -							 "mmio");
> -	if (!pcie_ep->mmio_res) {
> -		dev_err(dev, "Failed to get mmio resource\n");
> +	pcie_ep->mhi_res = platform_get_resource_byname(pdev, IORESOURCE_MEM,
> +							 "mhi");

That's an ABI break. Patchset is also non-bisectable.

Best regards,
Krzysztof

