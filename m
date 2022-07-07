Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CAFE56A475
	for <lists+linux-pci@lfdr.de>; Thu,  7 Jul 2022 15:50:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236149AbiGGNsn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 7 Jul 2022 09:48:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236150AbiGGNs3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 7 Jul 2022 09:48:29 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B39BC10C0
        for <linux-pci@vger.kernel.org>; Thu,  7 Jul 2022 06:48:27 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id t19so30592659lfl.5
        for <linux-pci@vger.kernel.org>; Thu, 07 Jul 2022 06:48:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=DBYE62t8pFdFoOUZZxtZsy/B6bdHmLteYihwWaIB1Kg=;
        b=tYzx4q4R0OlgoIthAymNpww128Z+VC/gBXUC9leEKTfoB4PrQQ9P3gk3HqCe0LWCfR
         HRAcL0LMGtr8ebG+nm9InXeOxTA4i/ka3XcnevSMA1ZnzperHRCU1pWjGtaCXuwEMbhg
         1MylyM1Q7A3qTj1AcPbNVr/RIZ4VZmoxrVMMf02t4QcZR4EMAgBta0u3oW/cBJBSBK8z
         qkEmdnrPT7U8N1pqMgGpzs9SuC2p4KDS87gVTFQtBv/XcKH1POHKqIw71XF+GavzxYG/
         ev3hYePs9fOqIqlH/76+NzGThT8zsUVw6yIWrVxr4JPqugs3KWcaXFUn9reYI1g0qqhA
         KIWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=DBYE62t8pFdFoOUZZxtZsy/B6bdHmLteYihwWaIB1Kg=;
        b=03eDYzmeCq5QyNlYUmQDB3X3ad6EJDNs6Y6htLvJD0xtOIaAbXD92icD0ob42h3wbC
         P1OhV2xiJuHnC8SDEWfd52rHU+X9Mmqs2fNva86C2/2YzTM2kN1nZYzMVuHwEQzw5LE9
         PtpcUE5VchweEL76Aw7poJbn4X/2jJobnD8h+oMQ/h1lOpAq7yTjvsUcoamYesSgRan4
         7Tlwc9+1ETzf4CGXwp5TztnUV2kh9D/NmPfry6gq26CG7EgF43U1IEeaN+J/ZTVo1Q9D
         zo5W61ikHXKT8nFE+T5vB6v/ivLymWhUJrqj5LvSf4ot/Fs2JvlsmIbIsYiQeqcZr090
         8Dpw==
X-Gm-Message-State: AJIora+asH06Ka+GL2mdjQYo8VcJPVfBfwit7APd7t6FzO4gCqSn08N2
        IA3B2+sLN5ijxY29xGhqk9e1iA==
X-Google-Smtp-Source: AGRyM1vJ0YPkGhxHH2SYhvGKGoaAkgxc+uDv0ISD57+3ZRYcYzs8S9E2RjaCl3HbeLcLjY4Q0ljJAw==
X-Received: by 2002:a05:6512:131a:b0:488:33a7:de95 with SMTP id x26-20020a056512131a00b0048833a7de95mr3091433lfu.278.1657201706108;
        Thu, 07 Jul 2022 06:48:26 -0700 (PDT)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id e8-20020a05651236c800b0047f7464f1bbsm6841223lfs.116.2022.07.07.06.48.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Jul 2022 06:48:25 -0700 (PDT)
Message-ID: <cd073ee3-5573-11d3-aa29-344974a94531@linaro.org>
Date:   Thu, 7 Jul 2022 16:48:24 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v16 5/6] dt-bindings: PCI: qcom: Support additional MSI
 interrupts
Content-Language: en-GB
To:     Johan Hovold <johan@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Vinod Koul <vkoul@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh@kernel.org>
References: <20220704152746.807550-1-dmitry.baryshkov@linaro.org>
 <20220704152746.807550-6-dmitry.baryshkov@linaro.org>
 <YsaT6fzySULqFt33@hovoldconsulting.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <YsaT6fzySULqFt33@hovoldconsulting.com>
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

On 07/07/2022 11:06, Johan Hovold wrote:
> On Mon, Jul 04, 2022 at 06:27:45PM +0300, Dmitry Baryshkov wrote:
>> On Qualcomm platforms each group of 32 MSI vectors is routed to the
>> separate GIC interrupt. Document mapping of additional interrupts.
>>
>> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> Reviewed-by: Rob Herring <robh@kernel.org>
>> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
>> ---
>>   .../devicetree/bindings/pci/qcom,pcie.yaml    | 51 +++++++++++++++++--
>>   1 file changed, 48 insertions(+), 3 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
>> index c40ba753707c..ee5414522e3c 100644
>> --- a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
>> +++ b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml

[...]

>> @@ -623,6 +624,50 @@ allOf:
>>           - resets
>>           - reset-names
>>   
>> +    # On newer chipsets support either 1 or 8 msi interrupts
>> +    # On older chipsets it's always 1 msi interrupt
>> +  - if:
>> +      properties:
>> +        compatibles:
> 
> This still has the misspelled property name here (plural s) so the
> conditional is always false.
> 
> I know I included a fix for this in my follow-on series, but if you are
> respinning the series anyway you should fix it up.

Done, thanks a lot pointing me to it.

> 
>> +          contains:
>> +            enum:
>> +              - qcom,pcie-msm8996

[...]

-- 
With best wishes
Dmitry
