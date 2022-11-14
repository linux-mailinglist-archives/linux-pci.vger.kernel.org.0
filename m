Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85A54628263
	for <lists+linux-pci@lfdr.de>; Mon, 14 Nov 2022 15:23:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236053AbiKNOXg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 14 Nov 2022 09:23:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235873AbiKNOXe (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 14 Nov 2022 09:23:34 -0500
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FF9430F
        for <linux-pci@vger.kernel.org>; Mon, 14 Nov 2022 06:23:31 -0800 (PST)
Received: by mail-lj1-x232.google.com with SMTP id d3so13400714ljl.1
        for <linux-pci@vger.kernel.org>; Mon, 14 Nov 2022 06:23:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=W18q2oxupdQ12Nl0RSmIe5LepBZSz0XtViretQW+Res=;
        b=uLUyCI+Aay2MbUcYcAyI0OX5pQbbyEv049uGs0QtVcSr2ZXZoCXFztooT1E4tDfVAk
         k1T0lWJPx2QInO6JMUKtbnS8esR3CiEkaTzx4fD9Dshbgsu/10ayw1LDcL5mp5PIeos3
         P2w4dAoxzykDVwPMBkcjBbu0sUzRo5uI/Uf7Q+MlGS5BJKl6VGtvdlBjQlrig4wgJikD
         JYV98tUad9ejnm89iUyFj8286iG9LheLRPBxWtFtpVbg08rPvYhl6FvSUasuxm+BZcKZ
         WsLuHanrElbaTLVl0zA4JXFsXSTGERHFA2jmup/6GYAaYoUw4GqyhgefnXz6QlKtLZcV
         G4lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=W18q2oxupdQ12Nl0RSmIe5LepBZSz0XtViretQW+Res=;
        b=D/pl4tOIki8YuCUenvY72yZBCEFjd/PDcPtz/Un1Yitf1aeXiOXzm4bpE68R12nOLY
         Dq1xel0KMb35DDUBeyWmMiThgQB9rreJgXkh8gZkHpk+w+yxflcta8tBJqixWDrdMeso
         IEALgb9xbXQddVqgUvulOdSwlZmSoTtaz9ZXtklmXMzb26kPkOwXCUurlhO2+iZpfOW7
         vQWknmu61UMgYJ1imffjMDNdya6DuBRu5g/lDjlW+xORQVRm3uxh8eerzl0axDIyRWmy
         FPS3FaSMHhjYnXFS+qkoYAtYcZ11hCGOWXT+wdSG5lFfbKOWH+ASq3LIYmliUG/I+IK+
         JruQ==
X-Gm-Message-State: ANoB5plczWn9NZNxT8UK8C4kfn7tiJY5lnGhrBfVHY0QeNoOg+FCZoBU
        BwXo9EMdXN3SjZyOE0VHJxmK3A==
X-Google-Smtp-Source: AA0mqf7N+uxS1/tolR2OQnty7ew64ZdZzboeRa4wsYDocUn7cnnmIFDpkApY3SaSpwHCrQOxeU1jcw==
X-Received: by 2002:a2e:a914:0:b0:278:f109:2844 with SMTP id j20-20020a2ea914000000b00278f1092844mr3039847ljq.224.1668435809714;
        Mon, 14 Nov 2022 06:23:29 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id p6-20020a056512138600b004a05767bc07sm1838155lfa.28.2022.11.14.06.23.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Nov 2022 06:23:29 -0800 (PST)
Message-ID: <d8edc185-52cd-ffa1-7b46-2ec84d0d712c@linaro.org>
Date:   Mon, 14 Nov 2022 15:23:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH V2 1/2] dt-bindings: PCI: tegra234: Add ECAM support
Content-Language: en-US
To:     Jon Hunter <jonathanh@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>
Cc:     linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, vidyas@nvidia.com,
        mmaddireddy@nvidia.com
References: <20221114140916.200395-1-jonathanh@nvidia.com>
 <20221114140916.200395-2-jonathanh@nvidia.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221114140916.200395-2-jonathanh@nvidia.com>
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

On 14/11/2022 15:09, Jon Hunter wrote:
> From: Vidya Sagar <vidyas@nvidia.com>
> 
> Add support for ECAM aperture that is only supported for Tegra234
> devices.
> 
> Co-developed-by: Vidya Sagar <vidyas@nvidia.com>
> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
> Co-developed-by: Jon Hunter <jonathanh@nvidia.com>
> Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
> ---
> Changes since V1:
> - Restricted the ECAM aperture to only Tegra234 devices that support it.
> 
>  .../bindings/pci/nvidia,tegra194-pcie.yaml    | 76 +++++++++++++++----
>  .../devicetree/bindings/pci/snps,dw-pcie.yaml |  2 +-
>  2 files changed, 62 insertions(+), 16 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/pci/nvidia,tegra194-pcie.yaml b/Documentation/devicetree/bindings/pci/nvidia,tegra194-pcie.yaml
> index 75da3e8eecb9..7ae0f37f5364 100644
> --- a/Documentation/devicetree/bindings/pci/nvidia,tegra194-pcie.yaml
> +++ b/Documentation/devicetree/bindings/pci/nvidia,tegra194-pcie.yaml
> @@ -27,21 +27,12 @@ properties:
>        - nvidia,tegra234-pcie
>  
>    reg:
> -    items:
> -      - description: controller's application logic registers
> -      - description: configuration registers
> -      - description: iATU and DMA registers. This is where the iATU (internal
> -          Address Translation Unit) registers of the PCIe core are made
> -          available for software access.
> -      - description: aperture where the Root Port's own configuration
> -          registers are available.
> +    minItems: 4
> +    maxItems: 5
>  
>    reg-names:
> -    items:
> -      - const: appl
> -      - const: config
> -      - const: atu_dma
> -      - const: dbi
> +    minItems: 4
> +    maxItems: 5
>  
>    interrupts:
>      items:
> @@ -202,6 +193,60 @@ properties:
>  
>  allOf:
>    - $ref: /schemas/pci/snps,dw-pcie.yaml#
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - nvidia,tegra194-pcie
> +    then:
> +      properties:
> +        reg:
> +          minItems: 4
> +          maxItems: 4

How you wrote it, you do not need min/maxItems here, because you have
items below. However see further comment.

> +          items:
> +            - description: controller's application logic registers
> +            - description: configuration registers
> +            - description: iATU and DMA registers. This is where the iATU (internal
> +                Address Translation Unit) registers of the PCIe core are made
> +                available for software access.
> +            - description: aperture where the Root Port's own configuration
> +                registers are available.
> +        reg-names:
> +          items:
> +            - const: appl
> +            - const: config
> +            - const: atu_dma
> +            - const: dbi
> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - nvidia,tegra234-pcie
> +    then:
> +      properties:
> +        reg:
> +          minItems: 5
> +          maxItems: 5

Similar issue.

> +          items:
> +            - description: controller's application logic registers
> +            - description: configuration registers
> +            - description: iATU and DMA registers. This is where the iATU (internal
> +                Address Translation Unit) registers of the PCIe core are made
> +                available for software access.
> +            - description: aperture where the Root Port's own configuration
> +                registers are available.
> +            - description: aperture to access the configuration space through ECAM.

This is unnecessarily duplicated. You can keep the descriptions of items
and reg-names items in top level (with min 4 and max 5) and restrict
maxItems for 194 and minItems for 234 here.


> +        reg-names:
> +          items:
> +            - const: appl
> +            - const: config
> +            - const: atu_dma
> +            - const: dbi
> +            - const: ecam
> +

No need for blank line.
>  
>  unevaluatedProperties: false
>  

Best regards,
Krzysztof

