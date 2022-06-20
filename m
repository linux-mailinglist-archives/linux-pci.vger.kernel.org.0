Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D180655130C
	for <lists+linux-pci@lfdr.de>; Mon, 20 Jun 2022 10:42:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239932AbiFTImI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 20 Jun 2022 04:42:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239901AbiFTImH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 20 Jun 2022 04:42:07 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A9E112ADE
        for <linux-pci@vger.kernel.org>; Mon, 20 Jun 2022 01:42:04 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id v1so19603801ejg.13
        for <linux-pci@vger.kernel.org>; Mon, 20 Jun 2022 01:42:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=8KC5N4lUnVBP0Df00kRT+qvCIav5gTwuxKk6ayo4MC4=;
        b=WxDOUlBokPFTfxjK9SyIBgzl+m/56JmpoMLo4gjoMMm11i+yDw6DxkfLIPjpbbI0rI
         jPR2o3Vn9VzHe5y2jyiLzFX8tq1zXi5rTpxNgphO56EKsNysGeIt601hFD+ea4siKxpq
         nHCuHSPBd12uHDmi8sNOejZyWTjRTeRDE8cKMwAMbJa2+QeAu1Rdb5viwHInRBd8qchq
         b1jLaFvRUKC3iTSfQ66w/KWdGRxVcOSsk9iJxXOYbKnbNswB5uz9nmxZBimi/g2IOZG0
         vCcmIgwtsso73lcp3PBZes9i/+RixN7UCqiSlf0kefsN8VoPZep0sHp5N/yB3qWh2y+e
         JsNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=8KC5N4lUnVBP0Df00kRT+qvCIav5gTwuxKk6ayo4MC4=;
        b=RkLuS9SZkIQ2ARqFqSv/XhwFzVW7aGiNOtKSEnB3TEsvVXPf15DKwQ3qLFUwoe6UyV
         FDwwjyjFqckn3cvXrCSSR7QGgnucptTM+L/cdbKi1+4Y812FaRjjuEGUNHW2vMkuz+AF
         GbtzXz4g1FRD3KDVv7KRA2pAI7geb1Qv2bwMltjIXRGkJvZVnt0nOUWtp3fbqcKA8Ylg
         J2N/LbBJSeTUmCFkEkeQPm0lCJqiouPlVGtLt2vZcs+SbJ1P24kGQmzBuyh08ivz33kg
         SjgVeAQO3s348ll9H1J6dm9pm8xL2JINLUhoS0A0nIFPDMqVP9vAsbC/dVGUaz5j6A97
         1aKg==
X-Gm-Message-State: AJIora8eJRsHkM9WYzoI/bN4pRS3wN6hmcd1zCtvziTJ9v4nxYdEwuZY
        FIEFyGwlPgbQLQszx71iWn0BLw==
X-Google-Smtp-Source: AGRyM1un4To8Mddtqz1fB7rqVgLhty5KIRsJB7W3BZXo06Ui5+rDz/9sKgIqkOwn8eSD4ybl7BXAhw==
X-Received: by 2002:a17:906:d84:b0:715:7f3d:403f with SMTP id m4-20020a1709060d8400b007157f3d403fmr20367115eji.406.1655714523380;
        Mon, 20 Jun 2022 01:42:03 -0700 (PDT)
Received: from [192.168.0.207] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id 9-20020a170906310900b0071cbc7487e1sm4837429ejx.69.2022.06.20.01.42.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Jun 2022 01:42:02 -0700 (PDT)
Message-ID: <f9a877ce-1e18-90f9-67e5-b6e67b3b4156@linaro.org>
Date:   Mon, 20 Jun 2022 10:42:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v3 1/5] dt-bindings: pci: Add ARTPEC-8 PCIe controller
Content-Language: en-US
To:     wangseok.lee@samsung.com,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
        "kishon@ti.com" <kishon@ti.com>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jesper.nilsson@axis.com" <jesper.nilsson@axis.com>,
        "lars.persson@axis.com" <lars.persson@axis.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "kw@linux.com" <kw@linux.com>,
        "linux-arm-kernel@axis.com" <linux-arm-kernel@axis.com>,
        "kernel@axis.com" <kernel@axis.com>
Cc:     Moon-Ki Jun <moonki.jun@samsung.com>,
        Sang Min Kim <hypmean.kim@samsung.com>,
        Dongjin Yang <dj76.yang@samsung.com>,
        Yeeun Kim <yeeun119.kim@samsung.com>
References: <8d806fc9-0067-2c8d-ec41-13787c7644a2@linaro.org>
 <20220614011616epcms2p7dcaa67c53b7df5802dd7a697e2d472d7@epcms2p7>
 <20220614012713epcms2p810386a5137fbcf6aefc41fe086badc0b@epcms2p8>
 <CGME20220614011616epcms2p7dcaa67c53b7df5802dd7a697e2d472d7@epcms2p6>
 <20220620075548epcms2p61182d9d7f41fadb1eb139b349bf7486d@epcms2p6>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220620075548epcms2p61182d9d7f41fadb1eb139b349bf7486d@epcms2p6>
Content-Type: text/plain; charset=UTF-8
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

On 20/06/2022 09:55, Wangseok Lee wrote:
> On 17/06/2022 07:54, Krzysztof Kozlowski wrote:
>> On 13/06/2022 18:27, Wangseok Lee wrote:
>>>  Add description to support Axis, ARTPEC-8 SoC.
>>>  ARTPEC-8 is the SoC platform of Axis Communications
>>>  and PCIe controller is designed based on Design-Ware PCIe controller.
>>>  
>>>  Signed-off-by: Wangseok Lee <wangseok.lee@samsung.com>
>>>  ---
>>>  v2->v3 :
>>>  - modify version history to fit the linux commit rule
>>>  - remove 'Device Tree Bindings' on title
>>>  - remove the interrupt-names, phy-names entries
>>>  - remove '_clk' suffix
>>>  - add the compatible entries on required
>>>  - change node name to soc from artpec8 on examples
>>>  
>>>  v1->v2 :
>>>  -'make dt_binding_check' result improvement
>>>  -Add the missing property list
>>>  -Align the indentation of continued lines/entries
>>>  ---
>>>   .../bindings/pci/axis,artpec8-pcie-ep.yaml         | 109 +++++++++++++++++++
>>>   .../devicetree/bindings/pci/axis,artpec8-pcie.yaml | 120 +++++++++++++++++++++
>>>   2 files changed, 229 insertions(+)
>>>   create mode 100644 Documentation/devicetree/bindings/pci/axis,artpec8-pcie-ep.yaml
>>>   create mode 100644 Documentation/devicetree/bindings/pci/axis,artpec8-pcie.yaml
>>>  
>>>  diff --git a/Documentation/devicetree/bindings/pci/axis,artpec8-pcie-ep.yaml b/Documentation/devicetree/bindings/pci/axis,artpec8-pcie-ep.yaml
>>>  new file mode 100644
>>>  index 0000000..d802bba
>>>  --- /dev/null
>>>  +++ b/Documentation/devicetree/bindings/pci/axis,artpec8-pcie-ep.yaml
>>>  @@ -0,0 +1,109 @@
>>>  +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>>>  +%YAML 1.2
>>>  +---
>>>  +$id: https://protect2.fireeye.com/v1/url?k=87636683-e61e8c00-8762edcc-74fe48600158-e7a1c3794076f0b9&q=1&e=35e09b7f-4fb1-4c8f-83ac-7ec33e124d44&u=http%3A%2F%2Fdevicetree.org%2Fschemas%2Fpci%2Faxis%2Cartpec8-pcie-ep.yaml%23
>>>  +$schema: https://protect2.fireeye.com/v1/url?k=36f56c4e-578886cd-36f4e701-74fe48600158-afd7270f84937054&q=1&e=35e09b7f-4fb1-4c8f-83ac-7ec33e124d44&u=http%3A%2F%2Fdevicetree.org%2Fmeta-schemas%2Fcore.yaml%23
>>>  +
>>>  +title: ARTPEC-8 SoC PCIe Controller
>>>  +
>>>  +maintainers:
>>>  +  - Jesper Nilsson <jesper.nilsson@axis.com>
>>>  +
>>>  +description: |+
>>>  +  This PCIe end-point controller is based on the Synopsys DesignWare PCIe IP
>>>  +  and thus inherits all the common properties defined in snps,dw-pcie-ep.yaml.
>>>  +
>>>  +allOf:
>>>  +  - $ref: /schemas/pci/snps,dw-pcie-ep.yaml#
>>>  +
>>>  +properties:
>>>  +  compatible:
>>>  +    const: axis,artpec8-pcie-ep
>>>  +
>>>  +  reg:
>>>  +    items:
>>>  +      - description: Data Bus Interface (DBI) registers.
>>>  +      - description: Data Bus Interface (DBI2) registers.
>>>  +      - description: PCIe address space region.
>>>  +
>>>  +  reg-names:
>>>  +    items:
>>>  +      - const: dbi
>>>  +      - const: dbi2
>>>  +      - const: addr_space
>>>  +
>>>  +  interrupts:
>>>  +    maxItems: 1
>>>  +
>>>  +  clocks:
>>>  +    items:
>>>  +      - description: PIPE clock, used by the controller to clock the PIPE
>>>  +      - description: PCIe dbi clock, ungated version
>>>  +      - description: PCIe master clock, ungated version
>>>  +      - description: PCIe slave clock, ungated version
>>>  +
>>>  +  clock-names:
>>>  +    items:
>>>  +      - const: pipe
>>>  +      - const: dbi
>>>  +      - const: mstr
>>>  +      - const: slv
>>>  +
>>>  +  phys:
>>>  +    maxItems: 1
>>>  +
>>>  +  num-lanes:
>>>  +    const: 2
>>>  +
>>>  +required:
>>>  +  - compatible
>>>  +  - reg
>>>  +  - reg-names
>>>  +  - interrupts
>>>  +  - interrupt-names
>>>  +  - clocks
>>>  +  - clock-names
>>>  +  - samsung,fsys-sysreg
>>>  +  - samsung,syscon-phandle
>>>  +  - samsung,syscon-bus-s-fsys
>>>  +  - samsung,syscon-bus-p-fsys
>>
>>
>> We are making circles... This was before and I commented already it is
>> wrong. You cannot have some unknown/random properties in "required:"
>> without describing them in "properties:". Please list all your
>> properties in "properties:", except the ones coming from snps
>> bindings/schema.
>>
> 
> I missed that when adding new items to "required",
> it should also be added to "properties".
> I will add the following items to the property.
> 
> samsung,fsys-sysreg:
>   description:
>     Phandle to system register of fsys block.
>   $ref: /schemas/types.yaml#/definitions/phandle

This is ok.

> 
> samsung,syscon-phandle:
>   description:
>     Phandle to the PMU system controller node.
>   $ref: /schemas/types.yaml#/definitions/phandle

This is ok.

> 
> samsung,syscon-bus-s-fsys:
>   description:
>     Phandle to bus-s path of fsys block, this register
>     are used for enabling bus-s.
>   $ref: /schemas/types.yaml#/definitions/phandle
> 
> samsung,syscon-bus-p-fsys:
>   description:
>     Phandle to bus-p path of fsys block, this register
>     are used for enabling bus-p.
>   $ref: /schemas/types.yaml#/definitions/phandle

This two look unspecific and hacky workaround for missing drivers. Looks
like instead of implementing interconnect or clock driver, you decided
to poke some other registers. Why this cannot be an interconnect driver?


Best regards,
Krzysztof
