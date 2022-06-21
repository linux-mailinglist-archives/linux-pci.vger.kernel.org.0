Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC45655325C
	for <lists+linux-pci@lfdr.de>; Tue, 21 Jun 2022 14:44:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350556AbiFUMoU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 21 Jun 2022 08:44:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231252AbiFUMoT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 21 Jun 2022 08:44:19 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA90D12091
        for <linux-pci@vger.kernel.org>; Tue, 21 Jun 2022 05:44:17 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id eo8so19259113edb.0
        for <linux-pci@vger.kernel.org>; Tue, 21 Jun 2022 05:44:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=uc5jJq0YvTzf8BEPMUgKkXPq5VOMLMXDxdKkAuvbItk=;
        b=o51LpaWxCfqFP3YFV66q9y40X5oK1xKmN9I5bVSTSRV3Ue6tOFTcBotGnOvkcAkeSG
         JWEuMhVcnHIviKxc+2GgZkmiJALfB8BlzdsSAe9d20F8H7fO+62VPXNVWD6oCHGgSY8z
         +ZaSdxgU7R8eKt8KP2ie6HuPRGZLlefknuUK+XhMdmuN9BzV+/SoJcwr2WzdOdm8mD+P
         oOAOGMlX7iy9zhl2MwrL/HOldGCYQTm5hksNGhq7ZKoy6UmGkQYA2mlbK//z5hPyWKzj
         tcjVSqEmXu6NfJapXTca1fVPcZPXpmCcyGKBi2VwY5afvx6bXrBW4VmYoynDOk946vf4
         Fwmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=uc5jJq0YvTzf8BEPMUgKkXPq5VOMLMXDxdKkAuvbItk=;
        b=t10wQc6D061a+mrtHfEiRp7r4EDFZluYTa1L8fTlKh6Vk3P6zPP1gwoisM80XcCrIQ
         0sjNjg22zwfXBu6/2z+PbzZ31Y6PlxF56FFRFOFNxpKba0fQpa1+uANcPaRTd59XMOhQ
         JcDlUIV2aOOQDstVqE197yLDCRqfqfoTF+rTHyUpcMiwhnGQWKZ+PPb0rgKFFr78vVZx
         pmfSyvCdWvfmsKtWhMfwXvUzq/F5hKzTYK6bsUgivweKr93zKW0xIsRaJciYwUFoxbIj
         ZI6hBw2WrPJKSEuGAsjVjPZ5RPJiI48pg/cwZ60Ig6UlN/nTaI8PB5yF8eBFYZD/QOWX
         fF/A==
X-Gm-Message-State: AJIora+cKMZ8S/D3XNGypZkHvqHYLRqNbLomiNoNSXtJo/Vjtr9KaR9m
        2EEtBxJAaV/dxqV85aWzjAc2ww==
X-Google-Smtp-Source: AGRyM1tUrw283B/iLAAXe1suE6fsNV78cf2NHCU5hHUcZcigWaiVbjFyK+RkskC+/2DrTKT7yzUUeQ==
X-Received: by 2002:a05:6402:5c9:b0:420:aac6:257b with SMTP id n9-20020a05640205c900b00420aac6257bmr34794630edx.128.1655815456285;
        Tue, 21 Jun 2022 05:44:16 -0700 (PDT)
Received: from [192.168.0.220] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id u9-20020a1709061da900b006fe8c831632sm7585849ejh.73.2022.06.21.05.44.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Jun 2022 05:44:15 -0700 (PDT)
Message-ID: <4a58c6c4-be0e-e56c-2498-a14ba46b508d@linaro.org>
Date:   Tue, 21 Jun 2022 14:44:14 +0200
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
References: <f9a877ce-1e18-90f9-67e5-b6e67b3b4156@linaro.org>
 <8d806fc9-0067-2c8d-ec41-13787c7644a2@linaro.org>
 <20220614011616epcms2p7dcaa67c53b7df5802dd7a697e2d472d7@epcms2p7>
 <20220614012713epcms2p810386a5137fbcf6aefc41fe086badc0b@epcms2p8>
 <20220620075548epcms2p61182d9d7f41fadb1eb139b349bf7486d@epcms2p6>
 <CGME20220614011616epcms2p7dcaa67c53b7df5802dd7a697e2d472d7@epcms2p2>
 <20220621074244epcms2p23cb631babfb87e5abb416467fb66e521@epcms2p2>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220621074244epcms2p23cb631babfb87e5abb416467fb66e521@epcms2p2>
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

On 21/06/2022 09:42, Wangseok Lee wrote:
>>>  
>>>  samsung,syscon-bus-s-fsys:
>>>    description:
>>>      Phandle to bus-s path of fsys block, this register
>>>      are used for enabling bus-s.
>>>    $ref: /schemas/types.yaml#/definitions/phandle
>>>  
>>>  samsung,syscon-bus-p-fsys:
>>>    description:
>>>      Phandle to bus-p path of fsys block, this register
>>>      are used for enabling bus-p.
>>>    $ref: /schemas/types.yaml#/definitions/phandle
>>
>> This two look unspecific and hacky workaround for missing drivers. Looks
>> like instead of implementing interconnect or clock driver, you decided
>> to poke some other registers. Why this cannot be an interconnect driver?
>>
>>
> 
> bus-s, bus-p is a register that exists in the sysreg of the fsys block.
> It is the same block as "fsys-sysreg" but is separated separately in
> hardware.

Two points here:
1. If it is in FSYS, why it cannot be accessed with samsung,fsys-sysreg?
2. If it is only register, shuld be described like this. You must
describe item:
https://elixir.bootlin.com/linux/v5.18-rc1/source/Documentation/devicetree/bindings/soc/samsung/exynos-usi.yaml#L42

> So, get resource is performed separately from "fsys-sysreg".
> They set pcie slave, dbi related control settings,
> naming "bus-x" seems to be interconnect.
> I will add this description to property.
> I don't think it need to use the interconnect driver,
> so please let me know your opinion.

Please document both in the bindings and in the driver usage of this
register. Writing there "0" or "1" is not enough. If the documentation
is good, I am fine with it. If the explanation is obfuscated/not
sufficient, it will look like avoiding to implement a driver, which I
don't want to accept.

Best regards,
Krzysztof
