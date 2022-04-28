Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2E69513016
	for <lists+linux-pci@lfdr.de>; Thu, 28 Apr 2022 11:48:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229903AbiD1Jtr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 28 Apr 2022 05:49:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347342AbiD1Jbv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 28 Apr 2022 05:31:51 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 873A77CDEE
        for <linux-pci@vger.kernel.org>; Thu, 28 Apr 2022 02:28:36 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id p4so4859388edx.0
        for <linux-pci@vger.kernel.org>; Thu, 28 Apr 2022 02:28:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=ARjzKSJ1boVbUsyHWVKrd/F0BEB2NcYm5tFfBpPw1B8=;
        b=m9L56/TLMjbkJNGkPq0/4vhj93TF6hX+vp42zkfW2sWK6J+QKnIfFwHN5bf58QgSTG
         pulJdYDFBa3+C+wC+swn1KbaLFRuT3LdB+Q4kxG5j9R2uT5h2JhsWqNXJMYOXi4ihFXA
         5FMsjXrtJhe7ScN8oEx3CG1naMEgWrFbbd54hwxFQ3qKJWnL7DjWnz1b0zt73aAh0rTh
         nSBWhRhGPGrO+Jq50N/al+48Y9vUUPSFtlB+avzPMptKnfgEJ63cR/vSzp86P2RIflbL
         vi7R3GSdcWZAQVxjDC4tCOuPeqXqG572fHa0wYZgyDX6IoDPI7nnE91CjA5LRHXgm0ld
         5sfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ARjzKSJ1boVbUsyHWVKrd/F0BEB2NcYm5tFfBpPw1B8=;
        b=srYadlaMvbgVYSNaRZNXiR551AapgPhJWRI3AZjLj0RZ4ltmlyrjerXgbhWptV2853
         SqL50/JNeji40aQL6buu2VReiFoMF4kXR1pHwYwvtyhubQbjeOsoQ/CnGk5fqkDa+UDj
         0VS3IPUi7liXr7kUu8oqkkb+uWvyi6aYQNgvpeoV9bCoDGoMpW8euLV2T7dCqhhgdxkA
         ZqmsCNzKhvXLuecri69Y//uYXnFs3+rn+C9EzXlCc/8cGWHhS1k9bUxk4MAQ6hTMoCAZ
         oiDxddvaZ9LXu9xVlqVd+O1x4wyHz81pKKqkdmxxzPWuD62I7VoQS2QOOiKN2WgxQ3tn
         medA==
X-Gm-Message-State: AOAM532Xb7uWrPeOA0+dnp3cwfpL1RWt6YDgJLu4nbTbdZj6Y4H2LKdX
        PwRuxpqmqi2nZE5A8fm5p3yuJQ==
X-Google-Smtp-Source: ABdhPJxGwsAH2L/Urtc7neXZ8Wk3ukX7a601iUj1Wv389n0WEpH/jegU2zbjfen3b6tiseIIGqbnVg==
X-Received: by 2002:a05:6402:11cd:b0:425:ee49:58cb with SMTP id j13-20020a05640211cd00b00425ee4958cbmr19442993edw.157.1651138115159;
        Thu, 28 Apr 2022 02:28:35 -0700 (PDT)
Received: from [192.168.0.161] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id b11-20020a17090630cb00b006e83fb1e6b1sm8118357ejb.100.2022.04.28.02.28.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Apr 2022 02:28:34 -0700 (PDT)
Message-ID: <a8d73c8f-76dc-c3ab-baf8-fcc253330fb3@linaro.org>
Date:   Thu, 28 Apr 2022 11:28:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: Aw: Re: [RFC/RFT v2 03/11] dt-bindings: phy: rockchip: add PCIe
 v3 constants
Content-Language: en-US
To:     Frank Wunderlich <frank-w@public-files.de>
Cc:     Frank Wunderlich <linux@fw-web.de>,
        linux-rockchip@lists.infradead.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Johan Jonker <jbx6244@gmail.com>,
        Peter Geis <pgwipeout@gmail.com>,
        Michael Riesch <michael.riesch@wolfvision.net>,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org
References: <20220426132139.26761-1-linux@fw-web.de>
 <20220426132139.26761-4-linux@fw-web.de>
 <918f5bc9-77f6-4d65-7432-ab53aadd6734@linaro.org>
 <trinity-3a10bccf-c3ed-479f-81c8-b48712f34432-1651138074158@3c-app-gmx-bs20>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <trinity-3a10bccf-c3ed-479f-81c8-b48712f34432-1651138074158@3c-app-gmx-bs20>
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

On 28/04/2022 11:27, Frank Wunderlich wrote:
> Hi
> 
>> Gesendet: Donnerstag, 28. April 2022 um 08:34 Uhr
>> Von: "Krzysztof Kozlowski" <krzysztof.kozlowski@linaro.org>
>>
>> On 26/04/2022 15:21, Frank Wunderlich wrote:
>>> From: Frank Wunderlich <frank-w@public-files.de>
>>>
>>>  include/dt-bindings/phy/phy-rockchip-pcie3.h | 21 ++++++++++++++++++++
>>
>> Naming - vendor,device.
> 
> ok, would rename to rockchip,pcie3-phy.h, is this ok?

Yes.

> 
>>> --- /dev/null
>>> +++ b/include/dt-bindings/phy/phy-rockchip-pcie3.h
>>> @@ -0,0 +1,21 @@
>>> +/* SPDX-License-Identifier: (GPL-2.0+ OR MIT) */
>>
>> s/MIT/BSD-2-clause/ just like bindings because it is part of it. Unless
>> you took it from something and it is already licensed like that?
> 
> took this with this license from downstream-repo, only removed snps from name and changed name of include guarding.

Then you need to keep the original license, so it is ok.

Best regards,
Krzysztof
