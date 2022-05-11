Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95D5D523629
	for <lists+linux-pci@lfdr.de>; Wed, 11 May 2022 16:50:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245121AbiEKOuh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 11 May 2022 10:50:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245100AbiEKOue (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 11 May 2022 10:50:34 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EB031B0929
        for <linux-pci@vger.kernel.org>; Wed, 11 May 2022 07:50:26 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id l19so2920971ljb.7
        for <linux-pci@vger.kernel.org>; Wed, 11 May 2022 07:50:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=ElWpfj0wGJL50TvRphg5kRjDcZaYvuq2GbVsqJVFYCc=;
        b=D89wtlNLbOs5yE8adcQ/A2ga2mHXKALISGT/gYSnpbat0i4NuirW4ZCbyUo2MTqHIM
         DybTUguFzP50B+QC5CPz2TzKjbooVf6vopYcNNMl7ZUovlVPA0oH8Br/q9KFIEAmXniz
         F0j2NDH2h9QX+6DPv05OnLKU/lCRS2VNa6DQznqwmQB3VBxMPm5cCJbbSmyddqzOtzgw
         MErApNu6AJbzoTmjvacV0Cjlufn2JPHd7IFrZPxtZuKzx5w77hCDKAFQUpVM50td0iZT
         WgQtdLpvHIwe6pWOO3tlZhkYS3rM9lzdvgLUrwrDhiGGSwVnAz5iQAYClQs/zR9hV3u3
         p17Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ElWpfj0wGJL50TvRphg5kRjDcZaYvuq2GbVsqJVFYCc=;
        b=wRXIUzLHQRt9ECtdl7AJ4dUR45WA0trQDaehocUcnJA8QNUiCe5u/s9NySSD9Faa8C
         w3OYq4LwDE0U5ys+YtPxjLoJiREP7yhu2Gky2tbZDQYe3KfFzdSa2+IYmKXavy01WyL2
         A6Vv/fYWdjxxohTsCkn+dvrDx1HLVOkE3uCMcevaAQUsIgmwOcUbg9znk6EPDibt8mr4
         9lPVf9wxHJqy+zaHznznUTlhlRqoJ8hh2XwLBXsWkgsLyVDqOxhhHNLEgoTt0tRGH9Z0
         /oduymI+PfN8tRb/v4mNW03+v7OXnfsauG6NeiGr0m9QqkqPi0Ng2uRB2XXqU5u99OVr
         5crw==
X-Gm-Message-State: AOAM532RdaWq3k8LKim1/glVNC/iH7psdmaqgB608swtH75CnpIoAduU
        MZboID36Kq+EIb3fClglLcwgDQ==
X-Google-Smtp-Source: ABdhPJywfHPoACVHlBO9DahbBv/k/o1jSWDDDk9EmMhQ1LcoWNLUQAhoA0UwVt6duF/93+DZe8i4Pw==
X-Received: by 2002:a2e:9e02:0:b0:249:7d50:bd8c with SMTP id e2-20020a2e9e02000000b002497d50bd8cmr17118916ljk.327.1652280624969;
        Wed, 11 May 2022 07:50:24 -0700 (PDT)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id d17-20020ac25ed1000000b0047255d2116bsm315476lfq.154.2022.05.11.07.50.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 May 2022 07:50:24 -0700 (PDT)
Message-ID: <3c126a06-f8fb-bc7a-860b-d4b1f2ef0133@linaro.org>
Date:   Wed, 11 May 2022 17:50:23 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v7 6/7] dt-bindings: PCI: qcom: Support additional MSI
 interrupts
Content-Language: en-GB
To:     Rob Herring <robh@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Vinod Koul <vkoul@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
References: <20220505135407.1352382-1-dmitry.baryshkov@linaro.org>
 <20220505135407.1352382-7-dmitry.baryshkov@linaro.org>
 <YnRB4UxBzFDmsls7@robh.at.kernel.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <YnRB4UxBzFDmsls7@robh.at.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 06/05/2022 00:30, Rob Herring wrote:
> On Thu, May 05, 2022 at 04:54:06PM +0300, Dmitry Baryshkov wrote:
>> On Qualcomm platforms each group of 32 MSI vectors is routed to the
>> separate GIC interrupt. Document mapping of additional interrupts.
>>
>> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
>> ---
>>   .../devicetree/bindings/pci/qcom,pcie.yaml    | 45 ++++++++++++++++++-
>>   1 file changed, 44 insertions(+), 1 deletion(-)
>>
>> diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
>> index 0b69b12b849e..fd3290e0e220 100644
>> --- a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
>> +++ b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
>> @@ -43,11 +43,20 @@ properties:
>>       maxItems: 5
>>   
>>     interrupts:
>> -    maxItems: 1
>> +    minItems: 1
>> +    maxItems: 8
>>   
>>     interrupt-names:
>> +    minItems: 1
>>       items:
>>         - const: msi
>> +      - const: msi2
> 
> Is 2 from some documentation or you made up. If the latter, software
> folks start numbering at 0, not 1. :) I wouldn't care, but I think this
> may become common.

It has been made up, so I will update this.

> 
>> +      - const: msi3
>> +      - const: msi4
>> +      - const: msi5
>> +      - const: msi6
>> +      - const: msi7
>> +      - const: msi8


-- 
With best wishes
Dmitry
