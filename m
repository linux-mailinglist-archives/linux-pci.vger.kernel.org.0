Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01503507A67
	for <lists+linux-pci@lfdr.de>; Tue, 19 Apr 2022 21:40:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345599AbiDSTnU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 19 Apr 2022 15:43:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345585AbiDSTnL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 19 Apr 2022 15:43:11 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C010B4132A
        for <linux-pci@vger.kernel.org>; Tue, 19 Apr 2022 12:40:27 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id t11so34977552eju.13
        for <linux-pci@vger.kernel.org>; Tue, 19 Apr 2022 12:40:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=QPOqgsEid6Wqxx1M40rGK1q2D5Xysrda2vwxz+DKUPc=;
        b=Ov/14cWHpDKy5PQzUQZKB6HCjf/IXjwsbqJGUZ5ZgQSB0Nvi5HVGxGRPW0J73z29L7
         cQAMtVhwFPyV4fsWvz9sin/nxOJ5nX76c3cwKLa7RU/Af+R+NwozF+GGqqmzhV/z7r+z
         B6/hzWzcQzCs+P6k40mSURlW7eG0E9z/ZXS/qG2MiiseRag8zVEOM3tRGquuk+C7BC6T
         SfQLe+ElfqVxf04HDySjhuEZdLIaexqei9P73XfigZ3VCeWoEJHdCl6rz0RNdxv/j9fR
         JA1Log/TBQ8umsABpgUIR5JFXjU9Jmt98jqQmeZgCSnZDELufrTubTIFo1U7gBgDcoF0
         LzoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=QPOqgsEid6Wqxx1M40rGK1q2D5Xysrda2vwxz+DKUPc=;
        b=oFcFG4aMigCOyNV74Wr5SsaDG9ECzMTJ9VhDUTI1gihrbVchG7ybMnPt0ZUG6Z86SI
         tCvt4SQBNpFYuBzpan+r2yHLcMPOJW8noX6Vi0yeqRpjsTqetGjhizUjqzLJs7Um95Sf
         89zogtcYwqjgNVaW99XcEu860uwQAC2alV2ptvOSO1O5G3Ive2QnUcW4d9E5Dn6bUgrx
         6IdcwpCxlsiY+9tzyI4E90o3Sw7g9C7a3LfzGET955QwCQ7f9lTHYD9khvOMUEIx3k9D
         DIiPWZ6CzBwAXupy2RTMEvAIs3eQ1CCVqFhZwRiaJ2KKuzMCkuz9UN46027y1VjHM8CP
         g3GQ==
X-Gm-Message-State: AOAM532f+7CLW8rBOuuxY5ewHL6Ne4nd6hxutr4mJUggxVITxoSxgEDK
        yMFMQo8x8m9M0u70SM1qO3FMHw==
X-Google-Smtp-Source: ABdhPJx6DouuY7dAxuX1ycupL8N+u0hCgEeKCHYUoIMUdZg7qUxXIXsBqnuYBYopZ2gDNL26oum7Kg==
X-Received: by 2002:a17:907:6e92:b0:6e4:de0d:464 with SMTP id sh18-20020a1709076e9200b006e4de0d0464mr14986441ejc.348.1650397226276;
        Tue, 19 Apr 2022 12:40:26 -0700 (PDT)
Received: from [192.168.0.221] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id u6-20020a17090626c600b006e74ef7f092sm6012164ejc.176.2022.04.19.12.40.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Apr 2022 12:40:25 -0700 (PDT)
Message-ID: <8b9ad0a6-acc0-aad9-c49d-e4a4b38374bb@linaro.org>
Date:   Tue, 19 Apr 2022 21:40:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: Aw: Re: [RFC/RFT 2/6] dt-bindings: soc: grf: add
 pcie30-{phy,pipe}-grf
Content-Language: en-US
To:     Frank Wunderlich <frank-w@public-files.de>
Cc:     Frank Wunderlich <linux@fw-web.de>,
        linux-rockchip@lists.infradead.org,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Johan Jonker <jbx6244@gmail.com>,
        Peter Geis <pgwipeout@gmail.com>,
        Michael Riesch <michael.riesch@wolfvision.net>,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
References: <20220416135458.104048-1-linux@fw-web.de>
 <20220416135458.104048-3-linux@fw-web.de>
 <02b3fe1c-12f9-8f96-a9b5-df44ca001825@linaro.org>
 <trinity-c60358c4-ebd1-47bf-91e0-9ae0beefd39f-1650389348418@3c-app-gmx-bap70>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <trinity-c60358c4-ebd1-47bf-91e0-9ae0beefd39f-1650389348418@3c-app-gmx-bap70>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 19/04/2022 19:29, Frank Wunderlich wrote:
>> Gesendet: Montag, 18. April 2022 um 17:54 Uhr
>> Von: "Krzysztof Kozlowski" <krzysztof.kozlowski@linaro.org>
> 
>>> --- a/Documentation/devicetree/bindings/soc/rockchip/grf.yaml
>>> +++ b/Documentation/devicetree/bindings/soc/rockchip/grf.yaml
>>> @@ -14,6 +14,8 @@ properties:
>>>      oneOf:
>>>        - items:
>>>            - enum:
>>> +              - rockchip,pcie30-phy-grf
>>> +              - rockchip,pcie30-pipe-grf
>>
>> These are without SoC parts. Are these PCIe v3 General Register Files
>> part of some PCIe spec?
> 
> imho they are shared across SoCs rk3568 and rk3588, but have only seen rk3568 implementation yet.
> PCIe driver currently supports these 2 Soc (different offsets in the Phy-GRF), but can only test rk3568.
> 
> pipe-grf seems only be used for rk35688 (offset used in probe is defined for this SoC), which i cannot test.
> 
> so i have left them SoC independed.

Compatibles should be SoC dependent, with some exceptions. Lack of
documentation or lack of possibility of testing is actually argument
against any exception, so they should be SoC specific/dependent.


Best regards,
Krzysztof
