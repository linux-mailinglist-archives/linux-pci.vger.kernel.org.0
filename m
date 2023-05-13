Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 932BD701945
	for <lists+linux-pci@lfdr.de>; Sat, 13 May 2023 20:39:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229566AbjEMSjc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 13 May 2023 14:39:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjEMSja (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 13 May 2023 14:39:30 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E410E1FCB
        for <linux-pci@vger.kernel.org>; Sat, 13 May 2023 11:39:28 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-965fc25f009so1769517566b.3
        for <linux-pci@vger.kernel.org>; Sat, 13 May 2023 11:39:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684003167; x=1686595167;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tJgRipBTIMb9CKVptB0CK8vcEy1PL4DIIOTmSIIgPL0=;
        b=iG2e9xty+mu13wsk5ZZM2QaivT8V52G8/Af/PifVYBtLEzIXHIe06u/elBe1sr0Djd
         aSAji3yS5LgcoFTRpqxzNPwTOm8stv9rdWo/6ANeKzHlZDreAKLVD94/cUt0xVM5gLB8
         bh7XvLe2HRcyEKASv5Vwswa/IKzWZ5qAGsa72ikRD4XhA6/QbLsuMGoMFSlXLgwpobcS
         urJPJ8tAzXUdsO8gn+IGWMMXRX6q09fLGsj1T2s9mBTSuGT/efeJ8ugbCVhoFSejB/Tb
         RpUjM7gZkem4Ep8SQfrahiNgJY90jVtc5ycgRjkbFJsS6zh34P015AyayIO3TXKXcG5W
         299w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684003167; x=1686595167;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tJgRipBTIMb9CKVptB0CK8vcEy1PL4DIIOTmSIIgPL0=;
        b=d3ggjOvK/PlAT+Aj8spIFb9iXvkctni0Ot789RUtRGEXcFZdlYp1JWFmLYiBRE3To7
         02v9xQZ/1qxjw4DV/sCpCIWfffDcKd8bMgsjidkC25tP9Wtf9XU+Jxxq4ThmYLS/HdvK
         XgLn4NwgJZ6Uj4SX3InD9fouxDYbu9yITpsNF7u+zQkdhWe6cC6X75hm6bPSrOlh8ru5
         E8HVu6SAhzSZ4Hb2IqA8gNnSUXLurGya51J47zJIFO0BqyvMFy4MpxC0AGgQMt/mVc6k
         Wp0VhzTs1phBXq44GaKH56Kv2TTkq5XuTqAMMd5ArksjJml+QJGNmtO4FChGtVbs5nwG
         tExA==
X-Gm-Message-State: AC+VfDyQhKazNLDBDXLuHEkSgN7nu/11aMGUdngRENHxqOZ4wDdlKasc
        YON5hcMREeozltFNBXYZPZRoQg==
X-Google-Smtp-Source: ACHHUZ7KQIKKSFZzxRVxqQy6v2UvaVPHdQTePpga0/dLKovt2/RDIklcz0rqo0618m3DIDXIpqarsw==
X-Received: by 2002:a17:906:db0d:b0:94a:35d1:59a with SMTP id xj13-20020a170906db0d00b0094a35d1059amr23656859ejb.14.1684003167395;
        Sat, 13 May 2023 11:39:27 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:ba68:e5c9:694e:c6e4? ([2a02:810d:15c0:828:ba68:e5c9:694e:c6e4])
        by smtp.gmail.com with ESMTPSA id k18-20020a17090632d200b009661f07db93sm7049268ejk.223.2023.05.13.11.39.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 13 May 2023 11:39:26 -0700 (PDT)
Message-ID: <d137b401-5b4a-bab7-ec21-ea267bd07c41@linaro.org>
Date:   Sat, 13 May 2023 20:39:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [EXTERNAL] Re: [PATCH 3/3] arm64: defconfig: enable J721e PCIe
 controller
Content-Language: en-US
To:     "Verma, Achal" <a-verma1@ti.com>, Tom Joseph <tjoseph@cadence.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof Wilczy_ski <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Bjorn Andersson <quic_bjorande@quicinc.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        "N_colas F . R . A . Prado" <nfraprado@collabora.com>,
        Mark Brown <broonie@kernel.org>,
        Rafa_ Mi_ecki <rafal@milecki.pl>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Nishanth Menon <nm@ti.com>, Milind Parab <mparab@cadence.com>,
        Swapnil Kashinath Jakhade <sjakhade@cadence.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-omap@vger.kernel.org
References: <20230512070510.1873171-1-a-verma1@ti.com>
 <20230512070510.1873171-4-a-verma1@ti.com>
 <13028434-f68c-cad3-056e-d319c1ec35cf@linaro.org>
 <3b5d7c3c-164d-0690-c2e8-2c7daec4865c@ti.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <3b5d7c3c-164d-0690-c2e8-2c7daec4865c@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 13/05/2023 19:58, Verma, Achal wrote:
> 
> Hello Krzysztof,
> On 5/12/2023 12:53 PM, Krzysztof Kozlowski wrote:
>> On 12/05/2023 09:05, Achal Verma wrote:
>>> Enable Cadence PCIe controller and pci-j721e drivers to be built as
>>> kernel modules.
>>
>> Why? IOW, who needs them. Please provide rationale in the commit msg. I
>> am pretty sure I asked for this...
>>
> On TI's J7 SOCs, PCIe is composed of PCIe core from Cadence and TI 
> wrapper. It is desired to have J7 PCIe working on upstream kernel by 
> default. So to enable this I have pushed these defconfig changes.
> 
> BTW, I am planning to hold this change until PCIe code changes (rest of 
> the patches in this series) gets merged.
> 
> Please let me know if there are more concern to this.

The concerns are that commit msg does not explain this. Please always
provide in commit msg answer to "why you are doing this". In case of
defconfig the answer to "why" is: "board foo bar with SoC baz uses it".

Best regards,
Krzysztof

