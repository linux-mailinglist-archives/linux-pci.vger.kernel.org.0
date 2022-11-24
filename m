Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BACA637454
	for <lists+linux-pci@lfdr.de>; Thu, 24 Nov 2022 09:45:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229507AbiKXIpY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 24 Nov 2022 03:45:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbiKXIpX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 24 Nov 2022 03:45:23 -0500
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EEF8FAE94
        for <linux-pci@vger.kernel.org>; Thu, 24 Nov 2022 00:45:22 -0800 (PST)
Received: by mail-lj1-x22d.google.com with SMTP id l8so1192887ljh.13
        for <linux-pci@vger.kernel.org>; Thu, 24 Nov 2022 00:45:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=o+bou2Eqve5CvNCEe8A4y27WMBYElKaquLsQIo7P2JQ=;
        b=Eqfk1RGF9j3RdprJYIXx7HGeIq9xPFflC0DBHFZv84z8rXJQ5/vglbRa3wWOGKWGIQ
         gLftpjDA8F2d9p131D/taQD+L1ualWywLsR9jmFpVeUEmOyx3skcNVLbLGmxUv01Ccs1
         h8hoaQCg3vx1YFG8Tv7hav6GCcfU3oehhr9h4Za3ef5AV/vCOoMBq1g36K8bi4XB0fMz
         v5tqdMn4k68ROH2+hh2ygTIlS1j0bf0Y31Iv9IyMpkN5hK6rGEl5kftjMe56NRobUhlc
         CY3p8z8pvDn+c0fA/4z7p97JFRmkc4RMljDdiyIZ86cIR8ax3Xoh4vis9omLr9B5CBQ9
         KUSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=o+bou2Eqve5CvNCEe8A4y27WMBYElKaquLsQIo7P2JQ=;
        b=xiNgOo4X7rElHIsNStJoch4GKdogoDaxbw2okyHfrJkaY95lsEFIxUftlwAIaL//qL
         tMXe94AF6hgrfcMFUIy7oPpjxOQtEOTtnBHTPa8QbnuLL1S6ggsG1GIg37OY6L1eZAyb
         VdKrVwMEPg+9oiZF1zts2ODokube5lp0zTVeUH45BtKWqUbkGwPLyfZ0Y2iQqSCdSh9U
         aNH8m/5UsY/XdAzdnGWEhbLaYSnPN1/RitLJlLo/JrfaSfA5YZRfz8rM/DqJAs4r4f/O
         tLLIsyvt4gpT58ESMJcgY3oQRNq1OE2XXrruy+DooREIDNGA1BVPM1FnKUPpbH2zwIH8
         TzSg==
X-Gm-Message-State: ANoB5pkFQIQa20xDQsJ4C2JAB4XPWzcUHDWtJlWMSrwP53y5lEf+BHpY
        xq1z0BVXsEx8R/KyN7TpDzmLcA==
X-Google-Smtp-Source: AA0mqf6Z3tWCtGpuP577dWMuvzhmVrpzGUmuDSeOU43vilip13LGn5V10NAdwcMHcLQV3aLfRXGe8Q==
X-Received: by 2002:a05:651c:c89:b0:26f:bd61:ac4f with SMTP id bz9-20020a05651c0c8900b0026fbd61ac4fmr5219103ljb.396.1669279520992;
        Thu, 24 Nov 2022 00:45:20 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id z8-20020a2e8848000000b0026b2094f6fcsm48669ljj.73.2022.11.24.00.45.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Nov 2022 00:45:20 -0800 (PST)
Message-ID: <0b203c11-851c-fd6c-faeb-e283b158f1c8@linaro.org>
Date:   Thu, 24 Nov 2022 09:45:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH 1/3] dt-bindings: PHY: P2U: Add PCIe lane margining
 support
To:     Manikanta Maddireddy <mmaddireddy@nvidia.com>, vkoul@kernel.org,
        kishon@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        thierry.reding@gmail.com, jonathanh@nvidia.com, vidyas@nvidia.com
Cc:     linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, bhelgaas@google.com,
        lpieralisi@kernel.org, nkristam@nvidia.com
References: <20221124083510.3008139-1-mmaddireddy@nvidia.com>
 <20221124083510.3008139-2-mmaddireddy@nvidia.com>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221124083510.3008139-2-mmaddireddy@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 24/11/2022 09:35, Manikanta Maddireddy wrote:
> Tegra234 supports PCIe lane margining. P2U HW acts as a relay to exchange

typo: merging?

> margin control data and margin status between PCIe controller and UPHY.

Please use scripts/get_maintainers.pl to get a list of necessary people
and lists to CC.  It might happen, that command when run on an older
kernel, gives you outdated entries.  Therefore please be sure you base
your patches on recent Linux kernel.


> 
> Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
> ---
>  .../bindings/phy/phy-tegra194-p2u.yaml        | 50 +++++++++++++++++++
>  1 file changed, 50 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/phy/phy-tegra194-p2u.yaml b/Documentation/devicetree/bindings/phy/phy-tegra194-p2u.yaml
> index 4dc5205d893b..0ba3f6a0b474 100644
> --- a/Documentation/devicetree/bindings/phy/phy-tegra194-p2u.yaml
> +++ b/Documentation/devicetree/bindings/phy/phy-tegra194-p2u.yaml
> @@ -40,6 +40,51 @@ properties:
>    '#phy-cells':
>      const: 0
>  
> +  interrupts:
> +    items:
> +      description: P2U interrupt for Gen4 lane margining functionality.

typo: merging?

> +
> +  interrupt-names:
> +    items:
> +      - const: intr

Drop entire property, not really useful.

> +
> +  nvidia,bpmp:
> +    $ref: /schemas/types.yaml#/definitions/phandle-array
> +    description: Must contain a pair of phandles to BPMP controller node followed by P2U ID.
> +    items:
> +      - items:
> +          - description: phandle to BPMP controller node
> +          - description: P2U instance ID
> +            maximum: 24
> +
> +allOf:
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - nvidia,tegra194-p2u
> +    then:
> +      required:
> +        - reg
> +        - reg-names
> +        - '#phy-cells'

That's not how it should be done. You have only two variants here, so
add a "required:" block with above and only one if:then: clause for
interrupts and nvidia,bpmp.

Requiring reg/reg-names/phy-cells should be in separate patch with its
own reasoning.


Best regards,
Krzysztof

