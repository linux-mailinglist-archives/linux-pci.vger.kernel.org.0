Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38C79651ED0
	for <lists+linux-pci@lfdr.de>; Tue, 20 Dec 2022 11:29:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229861AbiLTK3H (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 20 Dec 2022 05:29:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230238AbiLTK3F (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 20 Dec 2022 05:29:05 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FE3AD69
        for <linux-pci@vger.kernel.org>; Tue, 20 Dec 2022 02:29:04 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id g13so1218784lfv.7
        for <linux-pci@vger.kernel.org>; Tue, 20 Dec 2022 02:29:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7ydZyRIw+gbw3s3ZZRZA72xvAQO6P+Q4roI+F5gT9UA=;
        b=wYNN5qex0BsQtkbHRrHRAdPUbH4rl2x+fw3y4EZ0jrzWGueboTKWpyLFwU8LuNKlXP
         E+LW5AKrXKf3T5Rlja4zp+rda3keUg9MksjhSa5+G1a3+KsOdAvjGZ+XvZy8A6XZOCsk
         WOdg1040Disj86cuVGVMgk0sLjKw8wgxAbnWM4PTIjoCpm070kskfxe9FhvDAlp1hMru
         dTTgoXpAuOKKbrV2g8ewiYEBigg68FziITN08TbDhAa+M0KTZozgoHzkjg3ASrdUqy99
         Mhe8I77tlTpkWxd9YlVGur2Xrg6z5i8gm4hr8riO+IVkANOjj5ztcMEVgOb6oec5GWwp
         I9Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7ydZyRIw+gbw3s3ZZRZA72xvAQO6P+Q4roI+F5gT9UA=;
        b=g9nE1E4Yaz6hk1bQuDCqv7J/6rYDuuX9lehmJy1IJefHjHXcAMvCiYTjWv1KhRYU4H
         uiOuxGqf+zlucGYo636jAXlKA84uQVgkh9OX+rihVDiuz6fRtFcYTQvk4ZcKk2l4Axyp
         c7WcKCVbCTZ17FJ+QyBbFZjlln60M9y5HQE/1NffLYqfSoVqhzh2vr6LWNRESd8WnqJv
         DV8MYZE02PDbgmTYQnA2YWgJSWBRAhu+qitAd72cmJd1ziEjikDfjJPEkzmjhfU20WfL
         ScUHPvJfxTbJ35cyIgfFNya6YISKM5Izcdyiv6tjlarkwAL+HL7yl7eLFCDu8lUUwIRi
         nZJg==
X-Gm-Message-State: AFqh2krgZkug9jvPqD7y7y73vAMVz6PJszQrCGtO03JcmWw/KidlY67d
        EQ13dJE+pUosnspH1I5cfhN7YA==
X-Google-Smtp-Source: AMrXdXseYHTPE//qxrEh1Phx1J0z+h8J366WPR39QnMQvkCBso8AfZsQ67rNJksjHyDhd23aKIOB7Q==
X-Received: by 2002:a05:6512:2a90:b0:4ac:b7bf:697a with SMTP id dt16-20020a0565122a9000b004acb7bf697amr599270lfb.4.1671532142550;
        Tue, 20 Dec 2022 02:29:02 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id b15-20020a056512070f00b004c325f34043sm1118867lfs.100.2022.12.20.02.29.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Dec 2022 02:29:02 -0800 (PST)
Message-ID: <426723e7-bb5d-d409-2ad8-a8f4a286e9e1@linaro.org>
Date:   Tue, 20 Dec 2022 11:29:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH 2/3] dt-bindings: PCI: qcom: Document msi-map and
 msi-map-mask properties
Content-Language: en-US
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        andersson@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     bhelgaas@google.com, konrad.dybcio@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221219191427.480085-1-manivannan.sadhasivam@linaro.org>
 <20221219191427.480085-3-manivannan.sadhasivam@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221219191427.480085-3-manivannan.sadhasivam@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 19/12/2022 20:14, Manivannan Sadhasivam wrote:
> The Qcom PCIe controller is capable of using either internal MSI controller
> or the external GIC-ITS for receiving the MSIs from endpoint devices.
> Currently, the binding only documents the internal MSI implementation.
> 
> Let's document the GIC-ITS imeplementation by making use of msi-map and
> msi-map-mask properties.
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  .../devicetree/bindings/pci/qcom,pcie.yaml       | 16 +++++++++++++---
>  1 file changed, 13 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
> index 02450fb26bb9..24c3e7ef14eb 100644
> --- a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
> +++ b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
> @@ -100,18 +100,28 @@ properties:
>      description: GPIO controlled connection to WAKE# signal
>      maxItems: 1
>  
> +  msi-map: true
> +
> +  msi-map-mask: true

You should not need these. Just like interrup-map-mask, it is coming
from pci-bus.yaml.


Best regards,
Krzysztof

