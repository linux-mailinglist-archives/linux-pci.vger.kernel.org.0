Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D2706D9FE8
	for <lists+linux-pci@lfdr.de>; Thu,  6 Apr 2023 20:34:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240193AbjDFSe0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 6 Apr 2023 14:34:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240141AbjDFSeZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 6 Apr 2023 14:34:25 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E47B95
        for <linux-pci@vger.kernel.org>; Thu,  6 Apr 2023 11:34:24 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id by26so3587357ejb.2
        for <linux-pci@vger.kernel.org>; Thu, 06 Apr 2023 11:34:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680806062;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=I6maTLOz1QZeOD8kPuR409/ooOQkEc/E5FwVXHO67l0=;
        b=l0Pbm83fXbEeLt3Hv8z6jPi+3/3lgepiEz69Mdk8tEwL1d5P/Y7l9XzorVvTfDtGoN
         zVkllXsGeXQgZurXgUnmsDHiw/X3RYAx1aA5r4fn2dPePn64dyA+1/yRMu32Ap06R9rM
         HmOAyMouPBsZwMPzPuE6LuG0nGJaS6ppe2WBgth9p3yVoHxLPYnQ5dIXaKZI+A7Zl5z5
         ndMYes4iP3GP0CmNS2zc31iwzWRT5B9dbfGKQSFkuDG37HkMzs1DwAAl0ur/PcTHxf4z
         rjUZX99bL+OlAl7JDAN3izSykxyn0mZ+PQKFl474dHJjzYhpEwFPFe6co0CuGew2HZpG
         D3DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680806062;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I6maTLOz1QZeOD8kPuR409/ooOQkEc/E5FwVXHO67l0=;
        b=DOEpgWK6C1oYCYnSH5aslWeCohrIFylP3sRsKfP8RN/f/517uRZUwVCU2elEHfj9KZ
         FizR/akbm5NTwrCpsQQkJLi+EPTTC5IaCKQl81rtEEpUfP6K96QCvRGQjVKbobNL05Za
         Ag+5XYK+i+Y672eWhpGDNlV6HnUIyVW4DT+9T17skhRkjbPWlDGKzeT+aw0Fg7sWNHYU
         QVPmVhwzD4cQx4xHDLMC7yh9ES7MxjGbM5TH/6XIbABRvI0IxpJUtZ5F92/Tdk7PmFGp
         vTvP8BygtKlmM4uTYv4yEr4rSXh95Q3b8NDB/N9qyAchktp+2a/Ba7A91Oj76QgZIFq+
         XpPA==
X-Gm-Message-State: AAQBX9eZt7ZKrnzm2hq1NzuJet+N+mNRmcLLnyOJx5c5/p7iytpxNBbU
        nEEzdXXHd5KNBvlrUYaCvZHX7w==
X-Google-Smtp-Source: AKy350ZATMlvQLNv3pv0+sJEod1kxGFxxxykAYiMouoefxH0TIUxCu3Ht7TM837ADnjoXY8e2r42nw==
X-Received: by 2002:a17:906:f296:b0:933:6ae6:374d with SMTP id gu22-20020a170906f29600b009336ae6374dmr6331734ejb.73.1680806062616;
        Thu, 06 Apr 2023 11:34:22 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:49e6:bb8c:a05b:c4ed? ([2a02:810d:15c0:828:49e6:bb8c:a05b:c4ed])
        by smtp.gmail.com with ESMTPSA id rk8-20020a170907214800b0091ec885e016sm1127339ejb.54.2023.04.06.11.34.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Apr 2023 11:34:22 -0700 (PDT)
Message-ID: <ebde318b-53be-6779-4f0c-a614c01a0b0a@linaro.org>
Date:   Thu, 6 Apr 2023 20:34:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v1 1/3] dt-bindings: PCI: brcmstb: Add two optional props
Content-Language: en-US
To:     Jim Quinlan <jim2101024@gmail.com>, linux-pci@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Cyril Brulebois <kibi@debian.org>,
        Phil Elwell <phil@raspberrypi.com>,
        bcm-kernel-feedback-list@broadcom.com, james.quinlan@broadcom.com
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20230406124625.41325-1-jim2101024@gmail.com>
 <20230406124625.41325-2-jim2101024@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230406124625.41325-2-jim2101024@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 06/04/2023 14:46, Jim Quinlan wrote:
> Regarding "brcm,enable-l1ss":
> 
>   The Broadcom STB/CM PCIe HW -- which is also used by RPi SOCs -- requires
>   the driver probe to configure one of three clkreq# modes:
> 
>   (a) clkreq# driven by the RC
>   (b) clkreq# driven by the EP for ASPM L0s, L1
>   (c) bidirectional clkreq#, as used for L1 Substates (L1SS).
> 
>   The HW can tell the difference between (a) and (b), but does not know
>   when to configure (c).  Further, the HW will cause a CPU abort on boot if
>   guesses wrong regarding the need for (c).  So we introduce the boolean
>   "brcm,enable-l1ss" property to indicate that (c) is desired.  This
>   property is already present in the Raspian version of Linux, but the
>   driver implementaion that will follow adds more details and discerns
>   between (a) and (b).
> 
> Regarding "brcm,completion-timeout-msecs"
> 
>   Our HW will cause a CPU abort if the L1SS exit time is longer than the
>   completion abort timeout.  We've been asked to make this configurable, so
>   we are introducing "brcm,completion-abort-msecs".
> 
> Signed-off-by: Jim Quinlan <jim2101024@gmail.com>
> ---
>  .../devicetree/bindings/pci/brcm,stb-pcie.yaml       | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml b/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
> index 7e15aae7d69e..ef4ccc05b258 100644
> --- a/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
> +++ b/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
> @@ -64,6 +64,18 @@ properties:
>  
>    aspm-no-l0s: true
>  
> +  brcm,enable-l1ss:
> +    description: Indicates that the downstream device is L1SS
> +      capable and L1SS is desired, e.g. by setting
> +      CONFIG_PCIEASPM_POWER_SUPERSAVE=y.  Note that CLKREQ#

How does CONFIG_PCIEASPM_POWER_SUPERSAVE apply to *BSD?

> +      assertion to clock active must be within 400ns.
> +    type: boolean
> +
> +  brcm,completion-timeout-msecs:

Use standard unit suffixes.

> +    description: Number of msecs before completion timeout
> +      abort occurs.
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +
>    brcm,scb-sizes:
>      description: u64 giving the 64bit PCIe memory
>        viewport size of a memory controller.  There may be up to

Best regards,
Krzysztof

