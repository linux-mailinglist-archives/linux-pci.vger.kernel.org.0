Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69B87623F4B
	for <lists+linux-pci@lfdr.de>; Thu, 10 Nov 2022 11:02:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230048AbiKJKCh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 10 Nov 2022 05:02:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230015AbiKJKCc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 10 Nov 2022 05:02:32 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50B746B398
        for <linux-pci@vger.kernel.org>; Thu, 10 Nov 2022 02:02:30 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id g7so2218911lfv.5
        for <linux-pci@vger.kernel.org>; Thu, 10 Nov 2022 02:02:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=n/6SrizfTmUVEtJIffAUGFwzONi39uLHSNRwhX0sifc=;
        b=MorZi0LfuylaZSi8INxPDy4Q6asBHC9zP7jPOfm5P7jgT0tXI7S2vZdJih3EPrUTwO
         +cI3Gr1YY9qYHkss0jSWazs2Ab8eNw0uuKATKUpnPXE0WqTdokmbbH/tQvT+jn9wdt2n
         d75xioRlw65Ok6CSR7b6c/Y8xxq/Rw2qSNM/JyEzofu31cU0Bg7Eh1cAn79KMq2UpK/a
         DRtz36Bc3zy3K6TsZCQdszGp/DToTWLXhaIqdyuQjLIa+YetpSpL949aa6qr44yY9P+3
         3aspK5EafgXhAgjgnLrtTBNKHjVBKT3rkA6mmjdFtszg1618YSSiKU55DHnCW9nlkjNO
         cXxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=n/6SrizfTmUVEtJIffAUGFwzONi39uLHSNRwhX0sifc=;
        b=TQzwF/Dlegxec95Qhnl3pKyXvjVRvA7FOm0PxlyD7gMbwQBhbYVmWJW+tbPXqC00GJ
         kNkuf7PfshHVM3K36UIZFyro1Udw8UGoS8LQlINrjepwdxlPnIInFy9XazvbOob4qlWW
         ecQ5zhjVHT0L3rTI14GhPYasxbRXWEcywd2BOfFh4WzcNvfHEJYuf1J9UYRNubxyEeiV
         c7OHssCjzMzEzEZDVh8qLNWCs/hcULwZcg3oV4nUtn3N2N7SMB91YM8xrh1y14ixQsT8
         6k7VTu68kJ6NAMlWBWVOV8hz7DHneOAwfaANFfCAjbV8I9fHgQRcPcQh6SBrdGwNGh+A
         K1JQ==
X-Gm-Message-State: ACrzQf3QaxICOgV1yjQPkMIyREbCsmRpO/5u+oApOaUVI9uzWVLkZMJg
        JpjMHI6eJ0B/OHXxELwgOktktg==
X-Google-Smtp-Source: AMsMyM4obFX0u1CtxFRrJsqzbZXm9vc1VDTaOMa2c+zVOh/77kMGvTAQg1lneODWqpLf74et2+SAww==
X-Received: by 2002:a05:6512:3089:b0:4a2:586a:e77a with SMTP id z9-20020a056512308900b004a2586ae77amr20583426lfd.286.1668074548549;
        Thu, 10 Nov 2022 02:02:28 -0800 (PST)
Received: from [10.27.10.248] ([195.165.23.90])
        by smtp.gmail.com with ESMTPSA id x2-20020a2e9c82000000b00276ff51649csm2619295lji.43.2022.11.10.02.02.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Nov 2022 02:02:28 -0800 (PST)
Message-ID: <c7cc5afb-ec58-9c76-13c1-a1d519285898@linaro.org>
Date:   Thu, 10 Nov 2022 13:02:26 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH v1 1/7] dt-bindings: PCI: qcom: Add sm8350 to bindings
Content-Language: en-GB
To:     Rob Herring <robh@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Johan Hovold <johan@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org
References: <20221029211312.929862-1-dmitry.baryshkov@linaro.org>
 <20221029211312.929862-2-dmitry.baryshkov@linaro.org>
 <20221031214055.GA3613285-robh@kernel.org>
 <CAA8EJpqt+UvWHwd90Cdm3iCi2sbxbwbC3ADY6PW053Tw8r94VA@mail.gmail.com>
 <CAL_JsqLVzPawSFh9e6b3nVfn+dNDFooVgOa7B_iTGU13tzXTRQ@mail.gmail.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <CAL_JsqLVzPawSFh9e6b3nVfn+dNDFooVgOa7B_iTGU13tzXTRQ@mail.gmail.com>
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

On 01/11/2022 20:22, Rob Herring wrote:
> On Mon, Oct 31, 2022 at 4:47 PM Dmitry Baryshkov
> <dmitry.baryshkov@linaro.org> wrote:
>>
>> On Tue, 1 Nov 2022 at 00:40, Rob Herring <robh@kernel.org> wrote:
>>>
>>> On Sun, Oct 30, 2022 at 12:13:06AM +0300, Dmitry Baryshkov wrote:
>>>> Add bindings for two PCIe hosts on SM8350 platform. The only difference
>>>> between them is in the aggre0 clock, which warrants the oneOf clause for
>>>> the clocks properties.
>>>>
>>>> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
>>>> ---
>>>>   .../devicetree/bindings/pci/qcom,pcie.yaml    | 54 +++++++++++++++++++
>>>>   1 file changed, 54 insertions(+)
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
>>>> index 54f07852d279..55bf5958ef79 100644
>>>> --- a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
>>>> +++ b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
>>>> @@ -32,6 +32,7 @@ properties:
>>>>         - qcom,pcie-sdm845
>>>>         - qcom,pcie-sm8150
>>>>         - qcom,pcie-sm8250
>>>> +      - qcom,pcie-sm8350
>>>>         - qcom,pcie-sm8450-pcie0
>>>>         - qcom,pcie-sm8450-pcie1
>>>>         - qcom,pcie-ipq6018
>>>> @@ -185,6 +186,7 @@ allOf:
>>>>                 - qcom,pcie-sc8180x
>>>>                 - qcom,pcie-sc8280xp
>>>>                 - qcom,pcie-sm8250
>>>> +              - qcom,pcie-sm8350
>>>>                 - qcom,pcie-sm8450-pcie0
>>>>                 - qcom,pcie-sm8450-pcie1
>>>>       then:
>>>> @@ -540,6 +542,57 @@ allOf:
>>>>             items:
>>>>               - const: pci # PCIe core reset
>>>>
>>>> +  - if:
>>>> +      properties:
>>>> +        compatible:
>>>> +          contains:
>>>> +            enum:
>>>> +              - qcom,pcie-sm8350
>>>> +    then:
>>>> +      oneOf:
>>>> +          # Unfortunately the "optional" ref clock is used in the middle of the list
>>>> +        - properties:
>>>> +            clocks:
>>>> +              maxItems: 13
>>>> +            clock-names:
>>>> +              items:
>>>> +                - const: pipe # PIPE clock
>>>> +                - const: pipe_mux # PIPE MUX
>>>> +                - const: phy_pipe # PIPE output clock
>>>> +                - const: ref # REFERENCE clock
>>>> +                - const: aux # Auxiliary clock
>>>> +                - const: cfg # Configuration clock
>>>> +                - const: bus_master # Master AXI clock
>>>> +                - const: bus_slave # Slave AXI clock
>>>> +                - const: slave_q2a # Slave Q2A clock
>>>> +                - const: tbu # PCIe TBU clock
>>>> +                - const: ddrss_sf_tbu # PCIe SF TBU clock
>>>> +                - const: aggre0 # Aggre NoC PCIe0 AXI clock
>>>
>>> 'enum: [ aggre0, aggre1 ]' and 'minItems: 12' would eliminate the 2nd
>>> case. There's a implicit requirement that string names are unique (by
>>> default).
>>
>> Wouldn't it also allow a single 'aggre0' string?
> 
> No, because it's only for the 12th entry in the list.

If I got your suggestion right, it would be:
clock-names:
   minItems: 12
   items:
     ..... 11 names
     - enum: [ aggre0, aggre1 ]
     - const: aggre1

Having 11 clocks + aggre0 would pass this schema (incorrectly) because 
there will be no duplicate to fail the check.

We have two cases here:
  - 11 common clocks + aggre0 + aggre1
  - 11 common clocks + aggre1

I think I'll keep the oneOf in v2. Please tell me if I got your 
suggestion incorrectly or if there is any other way to express my case.

-- 
With best wishes
Dmitry

