Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1870658030D
	for <lists+linux-pci@lfdr.de>; Mon, 25 Jul 2022 18:44:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236254AbiGYQoq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 25 Jul 2022 12:44:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236232AbiGYQop (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 25 Jul 2022 12:44:45 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B5E01174
        for <linux-pci@vger.kernel.org>; Mon, 25 Jul 2022 09:44:43 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id p10so11411739lfd.9
        for <linux-pci@vger.kernel.org>; Mon, 25 Jul 2022 09:44:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=Dk3HqbuZgySWsjogix+I6+4yS7DuQZFSUmaJgXavR7o=;
        b=dkr7vBl2LIkN1kPKvtynIH4EuTYKNzb3fYG/hmBW4aolEJxeG0h8Yz9cIy/PzIPqgZ
         Uzhj7AQ/lLZbhdvqnGkwtMoT6IskiAQjkMM2slgqOpRSUjquobSEaPzZz8YuLLxQA2l6
         pte89G6aROftuvWh/aWbx9IqhFfBeTK6rDr9ppVfT21OuyblRoBCWyS9Ltq9G5lpgWRD
         W4LbKIriVqw4UXJHbID1cNVGkBqjbUOR0FC3xH8HKVVOz92d7NvnRQRDE0IvyDBD4mFD
         V5mM18JsXqHXKGx7b/5nFMjS4oialn5SFvyIrTnaVFWogMG2sRwC97vQ5lBzzYIt7gMs
         l7AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Dk3HqbuZgySWsjogix+I6+4yS7DuQZFSUmaJgXavR7o=;
        b=SuSbRRynaqmSGxZeQW/pA5xic0GYvq0bmLE7mnXg28QBkZaEIAQsXLBBq6J/LcSvgz
         fJb2u5VrrRRInPL4D1Udmp7cWPsRgwtr29P5fWHFjy1ujt6g6rfIHY+O+smdnSMpB8Tp
         C4517F8J8rJdX9wXG1guKMKTo/qI6RiRD1jlcGFJMmWQld5WFFMflPDYQjAilY5IFPFx
         1Yc2Le/3I6BujTinu3xMjW1t21ETifngrV5qFE3w2t6qlDAhm3nbx26QTOqYJVcWWATI
         tMi89mQKdywtVw6Ri9WFOrFbkWn/SL0YxM4KbLmTTiZXAhJ5NS49RTGA7wuwhZNbBQ5O
         gbRQ==
X-Gm-Message-State: AJIora+PeU94NfnIPmrActz9gbKp9LgnGvtwI4UGNwRzBF6ShEzRQr3y
        pVdcMh6cEA+PU6LFswmdRhPwQw==
X-Google-Smtp-Source: AGRyM1vlUreRo7YYpTyyAv/Za0PnMJtB7hsozufXhX6iFazVBRtv4qlB6VcNwkka4BHsXS4e7/59XQ==
X-Received: by 2002:a05:6512:b11:b0:48a:86f9:661b with SMTP id w17-20020a0565120b1100b0048a86f9661bmr2812319lfu.606.1658767481413;
        Mon, 25 Jul 2022 09:44:41 -0700 (PDT)
Received: from [192.168.3.197] (78-26-46-173.network.trollfjord.no. [78.26.46.173])
        by smtp.gmail.com with ESMTPSA id z20-20020a056512309400b0048a93325906sm410128lfd.171.2022.07.25.09.44.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Jul 2022 09:44:40 -0700 (PDT)
Message-ID: <7994d7c7-ae13-a136-f60c-40fd9918565d@linaro.org>
Date:   Mon, 25 Jul 2022 18:44:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [EXT] Re: [PATCH v3 3/4] dt-bindings: irqchip: imx mu work as msi
 controller
Content-Language: en-US
To:     Frank Li <frank.li@nxp.com>, "jdmason@kudzu.us" <jdmason@kudzu.us>,
        "maz@kernel.org" <maz@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kw@linux.com" <kw@linux.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>
Cc:     "kernel@vger.kernel.org" <kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Peng Fan <peng.fan@nxp.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "kishon@ti.com" <kishon@ti.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "ntb@lists.linux.dev" <ntb@lists.linux.dev>
References: <20220720213036.1738628-1-Frank.Li@nxp.com>
 <20220720213036.1738628-4-Frank.Li@nxp.com>
 <2c11d0b0-b012-ea24-5c3c-305bbdd231a0@linaro.org>
 <PAXPR04MB9186010F8F364CFB760064DF88959@PAXPR04MB9186.eurprd04.prod.outlook.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <PAXPR04MB9186010F8F364CFB760064DF88959@PAXPR04MB9186.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
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

On 25/07/2022 18:29, Frank Li wrote:
> 
> 
>> -----Original Message-----
>> From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> Sent: Saturday, July 23, 2022 1:50 PM
>> To: Frank Li <frank.li@nxp.com>; jdmason@kudzu.us; maz@kernel.org;
>> tglx@linutronix.de; robh+dt@kernel.org; krzysztof.kozlowski+dt@linaro.org;
>> shawnguo@kernel.org; s.hauer@pengutronix.de; kw@linux.com;
>> bhelgaas@google.com
>> Cc: kernel@vger.kernel.org; devicetree@vger.kernel.org; linux-arm-
>> kernel@lists.infradead.org; linux-pci@vger.kernel.org; Peng Fan
>> <peng.fan@nxp.com>; Aisheng Dong <aisheng.dong@nxp.com>;
>> kernel@pengutronix.de; festevam@gmail.com; dl-linux-imx <linux-
>> imx@nxp.com>; kishon@ti.com; lorenzo.pieralisi@arm.com;
>> ntb@lists.linux.dev
>> Subject: [EXT] Re: [PATCH v3 3/4] dt-bindings: irqchip: imx mu work as msi
>> controller
>>
>> Caution: EXT Email
>>
>> On 20/07/2022 23:30, Frank Li wrote:
>>> imx mu support generate irq by write a register.
>>> provide msi controller support so other driver
>>> can use it by standard msi interface.
>>
>> Please start sentences with capital letter. Unfortunately I don't
>> understand the sentences. Please describe shortly the hardware.
> 
> [Frank Li]  MU have 4 registers and both side A and B.  If write one of
> Register,  irq will be trigger at the other side. 
> 
> For example,  writle(a side reg1, 0).  Then b side irq will be trigged.



> 
>>
>>
>>>
>>> Signed-off-by: Frank Li <Frank.Li@nxp.com>
>>> ---
>>>  .../interrupt-controller/fsl,mu-msi.yaml      | 88 +++++++++++++++++++
>>>  1 file changed, 88 insertions(+)
>>>  create mode 100644 Documentation/devicetree/bindings/interrupt-
>> controller/fsl,mu-msi.yaml
>>>
>>> diff --git a/Documentation/devicetree/bindings/interrupt-controller/fsl,mu-
>> msi.yaml b/Documentation/devicetree/bindings/interrupt-controller/fsl,mu-
>> msi.yaml
>>> new file mode 100644
>>> index 0000000000000..e125294243af3
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/interrupt-controller/fsl,mu-
>> msi.yaml
>>> @@ -0,0 +1,88 @@
>>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>>> +%YAML 1.2
>>> +---
>>> +$id:
>> https://eur01.safelinks.protection.outlook.com/?url=http%3A%2F%2Fdevicet
>> ree.org%2Fschemas%2Finterrupt-controller%2Ffsl%2Cmu-
>> msi.yaml%23&amp;data=05%7C01%7CFrank.Li%40nxp.com%7Cfcec12a0731c
>> 454af5c308da6cdc2a0e%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0
>> %7C637941990101591376%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLj
>> AwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%
>> 7C%7C&amp;sdata=9h9nKyvsWaghry1hkpa5aaxVGYpx6xZRTxhN0S4uB50%3
>> D&amp;reserved=0
>>> +$schema:
>> https://eur01.safelinks.protection.outlook.com/?url=http%3A%2F%2Fdevicet
>> ree.org%2Fmeta-
>> schemas%2Fcore.yaml%23&amp;data=05%7C01%7CFrank.Li%40nxp.com%7
>> Cfcec12a0731c454af5c308da6cdc2a0e%7C686ea1d3bc2b4c6fa92cd99c5c3016
>> 35%7C0%7C0%7C637941990101591376%7CUnknown%7CTWFpbGZsb3d8eyJ
>> WIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%
>> 7C3000%7C%7C%7C&amp;sdata=wagM3hl8fpJSm%2Bibw6ENl5lNlQ9fVEHzS
>> OlT%2Bjoridg%3D&amp;reserved=0
>>> +
>>> +title: NXP i.MX Messaging Unit (MU) work as msi controller
>>> +
>>> +maintainers:
>>> +  - Frank Li <Frank.Li@nxp.com>
>>> +
>>> +description: |
>>> +  The Messaging Unit module enables two processors within the SoC to
>>> +  communicate and coordinate by passing messages (e.g. data, status
>>> +  and control) through the MU interface. The MU also provides the ability
>>> +  for one processor to signal the other processor using interrupts.
>>> +
>>> +  Because the MU manages the messaging between processors, the MU
>> uses
>>> +  different clocks (from each side of the different peripheral buses).
>>> +  Therefore, the MU must synchronize the accesses from one side to the
>>> +  other. The MU accomplishes synchronization using two sets of matching
>>> +  registers (Processor A-facing, Processor B-facing).
>>> +
>>> +  MU can work as msi interrupt controller to do doorbell
>>> +
>>> +allOf:
>>> +  - $ref: /schemas/interrupt-controller/msi-controller.yaml#
>>> +
>>> +properties:
>>> +  compatible:
>>> +    enum:
>>> +      - fsl,imx6sx-mu-msi
>>> +      - fsl,imx7ulp-mu-msi
>>> +      - fsl,imx8ulp-mu-msi
>>> +      - fsl,imx8ulp-mu-msi-s4
>>> +
>>> +  reg:
>>> +    minItems: 2
>>
>> Not minItems but maxItems in general, but anyway you need to actually
>> list and describe the items (and then skip min/max)
> [Frank Li] 
> 	I am not sure format.  Any example?
> 
> Reg:
>       Items:
>            - description:  a side register
>            - description: b side register

Yes, but then explain what is A and B in bindings description.

Why MU, which sits on A side needs to access other side (B) registers?

>>
>>> +
>>> +  reg-names:
>>> +    items:
>>> +      - const: a
>>> +      - const: b
>>> +
>>> +  interrupts:
>>> +    maxItems: 1
>>> +
>>> +  clocks:
>>> +    maxItems: 1
>>> +
>>> +  power-domains:
>>> +    maxItems: 2
>>
>> and here you correctly use maxItems, so why min in reg? Anyway, instead
>> you need to list and describe the items.
>  
> Does format is similar with reg?

Yes.

> 	
>>
>> Actually I asked you this last time about interrupts, so you ignored
>> that comment.
> 
> Sorry, which one. Is it below one?  
> 
> ---
>> +  interrupts:
>> +    minItems: 1
>> +    maxItems: 2
> 
> Instead describe the items.

Yes.


Best regards,
Krzysztof
