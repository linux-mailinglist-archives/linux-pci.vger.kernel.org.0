Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37C1356A50A
	for <lists+linux-pci@lfdr.de>; Thu,  7 Jul 2022 16:05:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235231AbiGGOFf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 7 Jul 2022 10:05:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232177AbiGGOFc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 7 Jul 2022 10:05:32 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D71C15F88
        for <linux-pci@vger.kernel.org>; Thu,  7 Jul 2022 07:05:30 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id a39so22370147ljq.11
        for <linux-pci@vger.kernel.org>; Thu, 07 Jul 2022 07:05:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=UMTumh8CxFwqZxKzI+PlEahmJ//f7f0y3cCEJWFFXjk=;
        b=HTQ/gPtvNOkEkk1kdgACghbwxTfERicM9I6Hqc8E0KUKGqs0Z4L0MBMamQveOjIV85
         qs56LfMRhidcDLsF/KmBt8cW/cCrDIYTJK65EAbzo3YmFEv7zFmfiTbnKvn2o0vL93wb
         GhH4WUZExKdv4OwiK5Kz6P+BUzk/DXuFDpPoXEYSIqxGX9wB6Wk3xm77dCQ3J78bxnX1
         1tm9HHb8B1/TNaS1ts8AM8NeYE4ZMnM8yOuvZxhOPNknaG93F3fWcO5KwUnX2JEybq3u
         VTf5zLunogBxxqEe3kO7PNYFHvqRtSKdNal8nIwh7xSmDpYFzkGpB6sMcktHgc0Pg9Pw
         59gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=UMTumh8CxFwqZxKzI+PlEahmJ//f7f0y3cCEJWFFXjk=;
        b=E6CWTKaPNuMwECwBSG0ekGJiluLr5EvoZsgMNTyEUdNhHzs4/mEzo3QQ54S5XKfoAm
         gwdRt856/yKxZIs4srBQpdOK0q7jXDbBOu4adySJfdWTeajfj9veaFIA8hanmT821AV5
         kFubLjv1C6YjTBriwj3eBaguuVEOCqIRiRFaFZb4hS2oW7rHtzmW7b+NZ+zg1RuVCa/5
         GDe144apVl5I4OWqpfSG8RCdZlwALO8gA+YW0Tu+S6IAbJyGMTRvR+0UuQ1PC2uGHX+R
         KKPpU+1VN+Lgmic0D3Rkom8lAJ8tKMyRsPFjD6z6RZ+OkePHgeJr4OWYJKAcqVTIru9B
         51ZQ==
X-Gm-Message-State: AJIora/DP791AyL1CSDJ+5cycAADoLzj15Le72Ufj02mHJyrQ1ToT0Fv
        XbO6rT3EwjZy93I8xNFUt3xsJA==
X-Google-Smtp-Source: AGRyM1vnAc+SdUHoWj+L7Cr/OCwNEYl7c1TNvwcCRmNv6IZsiGR7O/aTOpxINfmKh14nEXgH/DLUNA==
X-Received: by 2002:a05:651c:150b:b0:25b:b3b8:a995 with SMTP id e11-20020a05651c150b00b0025bb3b8a995mr26728432ljf.224.1657202729232;
        Thu, 07 Jul 2022 07:05:29 -0700 (PDT)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id o23-20020a05651205d700b0047f62762100sm6835531lfo.138.2022.07.07.07.05.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Jul 2022 07:05:28 -0700 (PDT)
Message-ID: <37918de9-28c5-4e78-b953-5da00a3057a0@linaro.org>
Date:   Thu, 7 Jul 2022 17:05:27 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] dt-bindings: PCI: qcom: fix typo in condition guarding
 resets
Content-Language: en-GB
To:     Johan Hovold <johan@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Vinod Koul <vkoul@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org
References: <20220707134552.2436442-1-dmitry.baryshkov@linaro.org>
 <YsbmBExeCtehzrvC@hovoldconsulting.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <YsbmBExeCtehzrvC@hovoldconsulting.com>
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

On 07/07/2022 16:56, Johan Hovold wrote:
> On Thu, Jul 07, 2022 at 04:45:52PM +0300, Dmitry Baryshkov wrote:
>> Fix the typo (compatibles vs compatible) in the condition guarding the
>> resets being required everywhere except MSM8996.
>>
>> Fixes: 6700a9b00f0a ("dt-bindings: PCI: qcom: Do not require resets on msm8996 platforms")
>> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> 
> I already posted a fix for this a week ago as you probably noticed as I
> was the one pointing the issue out to you:
> 
> 	https://lore.kernel.org/lkml/20220629141000.18111-2-johan+linaro@kernel.org/

Please excuse me then for duplicating your work. I checked linux-next 
and missed the mentioned patch. Bjorn, Lorenzo, could you please pick it up?

>> ---
>>   Documentation/devicetree/bindings/pci/qcom,pcie.yaml | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
>> index 0b69b12b849e..9b3ebee938e8 100644
>> --- a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
>> +++ b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
>> @@ -614,7 +614,7 @@ allOf:
>>     - if:
>>         not:
>>           properties:
>> -          compatibles:
>> +          compatible:
>>               contains:
>>                 enum:
>>                   - qcom,pcie-msm8996
> 
> Johan


-- 
With best wishes
Dmitry
