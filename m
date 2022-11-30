Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFA9063D902
	for <lists+linux-pci@lfdr.de>; Wed, 30 Nov 2022 16:16:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229604AbiK3PQH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 30 Nov 2022 10:16:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229569AbiK3PQG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 30 Nov 2022 10:16:06 -0500
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 420E930F69
        for <linux-pci@vger.kernel.org>; Wed, 30 Nov 2022 07:16:02 -0800 (PST)
Received: by mail-lj1-x232.google.com with SMTP id a19so5481233ljk.0
        for <linux-pci@vger.kernel.org>; Wed, 30 Nov 2022 07:16:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fBqKY5yXMXQuePyYKRrEKVvy6dgb6e3BQEBKFrS2SOk=;
        b=xaMwhi8t/77sRinO6CaduGrAoHZRRnvXT88bQ20GODkbSIJmlyjhXqUCTHJDozifaU
         bQO4Vdk/wve2AEpaXg5eri7mT4HYlCTwHF6goWC/PPi+AAhaDfA81cBIIb11vd77U2uW
         g8bS4oOq+Sv+WNBgfAFQvJ70LzadCjOd5kbSNBWYCYlhneHnQkDPEWDuKWMRqhNdJ7Bv
         5Z7Cc5KPLuwS+LBOnPAzgmuoLsOJNgax+o7F+3J08T7oMTd0CcLAfHQGHEKhJGrY5PUs
         jaN0MbfPEsXufBzYN3eHDIu2OCarSyD9FZqDknOoxSwZ3ij4+nQEx56Vk89D6XCcXf6l
         yFfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fBqKY5yXMXQuePyYKRrEKVvy6dgb6e3BQEBKFrS2SOk=;
        b=6D9k7b5YaGavtXIN0ROufDnjv2mhmMQttXMRVedSSXXd0AH3V9AaQlpKrzlPM1zYHZ
         qfk6Lo0WHnnNO0Me83nKT3CDFjH9xQ6eAPM0XZdbRwPz8dtb+D3j4CImHghEL8IVpClW
         94uVY2EqrcNzRuumSNs2nkqDbUbKgN6/w0GMJ/ilsuf0e8wsAixfLuJQba5rdklaqH0T
         uC1FipY8EE/88DGYznqu/og+A4on5RzMUJ7MLvdflD28NwS4/fSBodjA2zxhJ8JHbXxo
         SrNS2eSSsM9mMYdhcySPmnFGjfVLlTjmTa6EjBHJolec2964scuYKnZl/EZfRDtuLnkr
         ihmw==
X-Gm-Message-State: ANoB5pkLvzM8baG+gYacebFQkQrZWpd6feTgEkDxxOzNM71dCyzUZbi/
        7gE/KNsY3zevnvnId0C47aNMVQ==
X-Google-Smtp-Source: AA0mqf7wh2enQmEweeZZD/gaekmYNNgnB360r7ykWS1nE5Ed9UiwwqFkYWP5sq6UAoFj+fC06zjv7Q==
X-Received: by 2002:a2e:9b17:0:b0:279:bb68:f1bc with SMTP id u23-20020a2e9b17000000b00279bb68f1bcmr2209137lji.445.1669821360584;
        Wed, 30 Nov 2022 07:16:00 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id t15-20020a05651c204f00b0026bf43a4d72sm72447ljo.115.2022.11.30.07.15.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Nov 2022 07:15:59 -0800 (PST)
Message-ID: <7ce2fd0f-621d-dfbb-2ec0-53ccbb3308ae@linaro.org>
Date:   Wed, 30 Nov 2022 16:15:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH 1/3] dt-bindings: PHY: P2U: Add PCIe lane margining
 support
Content-Language: en-US
To:     Manikanta Maddireddy <mmaddireddy@nvidia.com>, vkoul@kernel.org,
        kishon@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        thierry.reding@gmail.com, jonathanh@nvidia.com, vidyas@nvidia.com
Cc:     linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, bhelgaas@google.com,
        lpieralisi@kernel.org, nkristam@nvidia.com
References: <20221124083510.3008139-1-mmaddireddy@nvidia.com>
 <20221124083510.3008139-2-mmaddireddy@nvidia.com>
 <0b203c11-851c-fd6c-faeb-e283b158f1c8@linaro.org>
 <b81c69e0-13a2-6a25-21c7-c0d8804f9c3b@nvidia.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <b81c69e0-13a2-6a25-21c7-c0d8804f9c3b@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 30/11/2022 16:11, Manikanta Maddireddy wrote:
> Thank you for quick review. I will wait for other reviewers to review 
> patch 2 & 3.
> I will address all review comments and sendnew revision.
> 
> On 11/24/2022 2:15 PM, Krzysztof Kozlowski wrote:
>> External email: Use caution opening links or attachments
>>
>>
>> On 24/11/2022 09:35, Manikanta Maddireddy wrote:
>>> Tegra234 supports PCIe lane margining. P2U HW acts as a relay to exchange
>> typo: merging?
> It is not typo, it is PCIe feature lane margining.
> https://pcisig.com/pushing-limits-understanding-lane-margining-pcie%C2%AE
>>
>>> margin control data and margin status between PCIe controller and UPHY.
>> Please use scripts/get_maintainers.pl to get a list of necessary people
>> and lists to CC.  It might happen, that command when run on an older
>> kernel, gives you outdated entries.  Therefore please be sure you base
>> your patches on recent Linux kernel.
> I verified these patches on 6.0.0-rc6 kernel and executed get_maintainers.pl
> script on it. Did I miss anyone here?

Yes. At least Rob, maybe more. You need to CC all
maintainers/reviewers/supporters and all mailing lists.

It's not my task to verify each of these addresses to check whether you
really missed someone or not. I spotted at least one missing address so
just run get_maintainers.pl and use all entries from there.


>>
>>
>>> Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
>>> ---
>>>   .../bindings/phy/phy-tegra194-p2u.yaml        | 50 +++++++++++++++++++
>>>   1 file changed, 50 insertions(+)
>>>
>>> diff --git a/Documentation/devicetree/bindings/phy/phy-tegra194-p2u.yaml b/Documentation/devicetree/bindings/phy/phy-tegra194-p2u.yaml
>>> index 4dc5205d893b..0ba3f6a0b474 100644
>>> --- a/Documentation/devicetree/bindings/phy/phy-tegra194-p2u.yaml
>>> +++ b/Documentation/devicetree/bindings/phy/phy-tegra194-p2u.yaml
>>> @@ -40,6 +40,51 @@ properties:
>>>     '#phy-cells':
>>>       const: 0
>>>
>>> +  interrupts:
>>> +    items:
>>> +      description: P2U interrupt for Gen4 lane margining functionality.
>> typo: merging?
> It is not typo, it is PCIe feature lane margining.
> https://pcisig.com/pushing-limits-understanding-lane-margining-pcie%C2%AE
>>
>>> +
>>> +  interrupt-names:
>>> +    items:
>>> +      - const: intr
>> Drop entire property, not really useful.
> In driver, I am using platform_get_irq_byname(), I will change it to 
> platform_get_irq()
> and drop this property.
>>
>>> +
>>> +  nvidia,bpmp:
>>> +    $ref: /schemas/types.yaml#/definitions/phandle-array
>>> +    description: Must contain a pair of phandles to BPMP controller node followed by P2U ID.
>>> +    items:
>>> +      - items:
>>> +          - description: phandle to BPMP controller node
>>> +          - description: P2U instance ID
>>> +            maximum: 24
>>> +
>>> +allOf:
>>> +  - if:
>>> +      properties:
>>> +        compatible:
>>> +          contains:
>>> +            enum:
>>> +              - nvidia,tegra194-p2u
>>> +    then:
>>> +      required:
>>> +        - reg
>>> +        - reg-names
>>> +        - '#phy-cells'
>> That's not how it should be done. You have only two variants here, so
>> add a "required:" block with above and only one if:then: clause for
>> interrupts and nvidia,bpmp.
>>
>> Requiring reg/reg-names/phy-cells should be in separate patch with its
>> own reasoning.
> Ok, I will create two separate patches and add if:then clause only for 
> tegra234.
> As per understanding final change will look like below, right?
> 
> 
> required:
>    - reg
>    - reg-names
>    - '#phy-cells'
> 
> allOf:
>    - if:
>        properties:
>          compatible:
>            contains:
>              enum:
>                - nvidia,tegra234-p2u
>      then:
>        required:
>          - interrupts
>          - nvidia,bpmp

yes

Best regards,
Krzysztof

