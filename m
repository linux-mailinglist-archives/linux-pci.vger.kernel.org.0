Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 702F456A3EA
	for <lists+linux-pci@lfdr.de>; Thu,  7 Jul 2022 15:41:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235866AbiGGNlI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 7 Jul 2022 09:41:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235857AbiGGNlH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 7 Jul 2022 09:41:07 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C966C2AC50
        for <linux-pci@vger.kernel.org>; Thu,  7 Jul 2022 06:41:05 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id i17so17526017ljj.12
        for <linux-pci@vger.kernel.org>; Thu, 07 Jul 2022 06:41:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language
         :from:to:cc:references:in-reply-to:content-transfer-encoding;
        bh=jRAjZXY6+UUMfN9anTAWHy/uwmogMIm8H3PLiHy9OEI=;
        b=nNBRS+FZwsMAmv+unQDonMckzxWyz51mGvxoj5yAx5CBRCb1ZAlNEP4YGf0HIQB7Jj
         xzLlWnvMnTQ1LsabcoJH6BEzf6slgc8cjTwSn4KkCm5lOW03zo8juX8AwcwOee9RhnNk
         8KHlFFAjDimv0YupF2OA6QTJ/yN77Tvq7WkMyQ4J0BCduoT64mvaVfGlog1xQrLUtizz
         te475qDsuU8gJFcRQMiMsg/dtTOvhJw+7w1YHNyg1Jhn0LA5Wi8LqgxdNRCA5xk47Xqc
         zJDU7HtTYt9HT6oaIv0wukY83stC9PGpul9zEL08tkFJErE+t1GlpOS5tYIStKOwWzHk
         oK6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=jRAjZXY6+UUMfN9anTAWHy/uwmogMIm8H3PLiHy9OEI=;
        b=UQsEdY2SeKAFOgDjTW0KIk8u18Mc1N7i8QCK/Ym1WcQFec3xEb5Qttpirkw5doC4PY
         CUh0v/xGALl8qSkDzoR70J0XySxR2wkm28E6Ms9UlwIV3Vr3xiJ0Owl1+0XnFr2jtD+i
         d/AlS+Q6ME4qfKaM9V3oJvKqPeerthCHv0yxP7NrXE1RCITpNWeP011JPjNf/PezLuZl
         D9kfR9mQ2T6r8+fAPu4w+Mc0i6buXqtdRAFgFJMcfzXFBjstMaOjJYJs9+hlhIDJ9qIU
         URC5FLIcU1ccBsFZkZg5iqFPIF6WGKFuR/JYp7me6N0lutgQCmNu37e5yX2AY3UWpRty
         3+fg==
X-Gm-Message-State: AJIora+/FiRZYrIfCOyikvtwYe3nAnSBy2yBS9+F+YvXVTikTfjZmM8H
        SzleVIkXzpLGxSj8Vz6e9MxWFw==
X-Google-Smtp-Source: AGRyM1t4UqVaNKTbjrPlQkcNgoKuyx+oGPkBeDq++hP317Wk1kHIWC4XtoISid7vnJuGGeLqCFO/dQ==
X-Received: by 2002:a2e:92c6:0:b0:255:84cb:4eea with SMTP id k6-20020a2e92c6000000b0025584cb4eeamr25815297ljh.204.1657201264047;
        Thu, 07 Jul 2022 06:41:04 -0700 (PDT)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id e20-20020a05651c04d400b0025a64093a9esm6794026lji.117.2022.07.07.06.41.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Jul 2022 06:41:03 -0700 (PDT)
Message-ID: <2fbe9cf7-7ed8-ccc8-b0bc-26d358cec927@linaro.org>
Date:   Thu, 7 Jul 2022 16:41:02 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 02/10] dt-bindings: PCI: qcom: Fix msi-interrupt
 conditional
Content-Language: en-GB
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Johan Hovold <johan+linaro@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220629141000.18111-1-johan+linaro@kernel.org>
 <20220629141000.18111-3-johan+linaro@kernel.org>
 <cab173ce-9c7c-9985-277c-3498d82b8400@linaro.org>
In-Reply-To: <cab173ce-9c7c-9985-277c-3498d82b8400@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 07/07/2022 16:34, Dmitry Baryshkov wrote:
> On 29/06/2022 17:09, Johan Hovold wrote:
>> Fix the msi-interrupt conditional which always evaluated to false due to
>> a misspelled property name ("compatibles" in plural).
>>
>> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> 
> Fixes: 6700a9b00f0a ("dt-bindings: PCI: qcom: Do not require resets on 
> msm8996 platforms")

Ugh, I was thinking about a different chunk (which also has this issue), 
so please ignore the Fixes.

> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> 
> 
>> ---
>>   Documentation/devicetree/bindings/pci/qcom,pcie.yaml | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml 
>> b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
>> index ed9f9462a758..a1b4fc70e162 100644
>> --- a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
>> +++ b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
>> @@ -628,7 +628,7 @@ allOf:
>>       # On older chipsets it's always 1 msi interrupt
>>     - if:
>>         properties:
>> -        compatibles:
>> +        compatible:
>>             contains:
>>               enum:
>>                 - qcom,pcie-msm8996
> 
> 


-- 
With best wishes
Dmitry
