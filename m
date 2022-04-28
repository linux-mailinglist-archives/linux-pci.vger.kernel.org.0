Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C975512B9D
	for <lists+linux-pci@lfdr.de>; Thu, 28 Apr 2022 08:33:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244054AbiD1GgX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 28 Apr 2022 02:36:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233520AbiD1GgW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 28 Apr 2022 02:36:22 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C7D221E0F
        for <linux-pci@vger.kernel.org>; Wed, 27 Apr 2022 23:33:09 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id y21so4364821edo.2
        for <linux-pci@vger.kernel.org>; Wed, 27 Apr 2022 23:33:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=ZGNUaKvmhdWADegA9+35rNWReEdvm/VLEsDmu8SXlcI=;
        b=uxezT5LnyHKSBkq6AQW89pc3qDtfxZHYMAix0t8fNa7iN8SiPU1Ilsl1nM1G37M5R+
         +iu92f1x/5vR1NTnqi8ROX0/LwJwdGKQmoBkn8pixlB6fKZyo7GpO6a7YYkK1pW1jNQT
         wNHmkFGVSfRqXb8sEShA2W6HoHm5NLbFl5Spems7FPFI6zXPRgGCACekKLjBWUJQMl4E
         73ek80xKQJ1KRfH67Egat8mV375c+FUSf/cJw5OVhhrlizX0esnpjiAi8Erb1aORY0vE
         o3rPGR9G86LWNf4VY5otQY/Gm6CzHNWFv8J3C1ofMgFmk3ptIhJGQ5VBAyLp82amwWr1
         6tbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ZGNUaKvmhdWADegA9+35rNWReEdvm/VLEsDmu8SXlcI=;
        b=FgkIxX+Mx1a9gIF5VhIkkHDMBOA2tLr7J+L9whQeuCtfeJ6BsVZqJEBxABhRgUSnXc
         JjnKoLCzKp//zKD48TfQ4p/aT7npPbs7pG7YmbTbt6PgL+xgam8m6ZKp6z03ojHzRpI+
         Ujb7A+tH2kKq93yV+AJmQkNBLzQ51/G7PTjpF6UhUgKCyZphsepArSaHzsU00vn2qvcm
         PIcg9TrCR4zVcqEUMQ6kmQPvoc0YrBSjURvXlr1vdodmzBHIzSfF6inYg+u5D6i5EGHo
         TyoQ+PztBHWadaYaJIFWXld8jY0H0zUEPHHdVvL9+z2yDPQj98cc4oDlqGqAR4jv2Il9
         5MMQ==
X-Gm-Message-State: AOAM530kOSAILTlPo95PbDUJ+waD7gcy5G7lDJR7vu0bIzb4X460jtjq
        uLY3+LlE0mdhfF9wCjjLa+/pGQ==
X-Google-Smtp-Source: ABdhPJw0+ayf81Ms9n+w6fNeDibHnLry7oeKKqMj4gZt2cgaTDG/qOgtHFpuAxQnWZ5n0HmQ9WFJHA==
X-Received: by 2002:a05:6402:43cc:b0:425:fda3:ac3a with SMTP id p12-20020a05640243cc00b00425fda3ac3amr12162862edc.70.1651127587742;
        Wed, 27 Apr 2022 23:33:07 -0700 (PDT)
Received: from [192.168.0.159] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id i23-20020a0564020f1700b0042617ba6382sm943988eda.12.2022.04.27.23.33.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Apr 2022 23:33:06 -0700 (PDT)
Message-ID: <f002b635-75c5-b7ba-72c4-70f0e20369e7@linaro.org>
Date:   Thu, 28 Apr 2022 08:33:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [RFC/RFT v2 01/11] dt-bindings: phy: rockchip: add PCIe v3 phy
Content-Language: en-US
To:     Frank Wunderlich <linux@fw-web.de>,
        linux-rockchip@lists.infradead.org
Cc:     Frank Wunderlich <frank-w@public-files.de>,
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
 <20220426132139.26761-2-linux@fw-web.de>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220426132139.26761-2-linux@fw-web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 26/04/2022 15:21, Frank Wunderlich wrote:
> From: Frank Wunderlich <frank-w@public-files.de>
> 
> Add a new binding file for Rockchip PCIe v3 phy driver.
> 
> Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
> 
> ---
> v2:
> dt-bindings: rename yaml for PCIe v3
> rockchip-pcie3-phy.yaml => rockchip,pcie3-phy.yaml
> 
> changes in pcie3 phy yaml
> - change clock names to ordered const list
> - extend pcie30-phymode description
> - add phy-cells to required properties
> - drop unevaluatedProperties
> - example with 1 clock each line
> - use default property instead of text describing it
> - update license
> ---
>  .../bindings/phy/rockchip,pcie3-phy.yaml      | 84 +++++++++++++++++++
>  1 file changed, 84 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/phy/rockchip,pcie3-phy.yaml
> 
> diff --git a/Documentation/devicetree/bindings/phy/rockchip,pcie3-phy.yaml b/Documentation/devicetree/bindings/phy/rockchip,pcie3-phy.yaml
> new file mode 100644
> index 000000000000..3592888b5ee2
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/phy/rockchip,pcie3-phy.yaml
> @@ -0,0 +1,84 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/phy/rockchip,pcie3-phy.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Rockchip PCIe v3 phy
> +
> +maintainers:
> +  - Heiko Stuebner <heiko@sntech.de>
> +
> +properties:
> +  compatible:
> +    enum:
> +      - rockchip,rk3568-pcie3-phy
> +      - rockchip,rk3588-pcie3-phy
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    minItems: 1
> +    maxItems: 3
> +
> +  clock-names:
> +    items:
> +      - const: "refclk_m"
> +      - const: "refclk_n"
> +      - const: "pclk"

Drop quotes.

> +
> +    minItems: 1

I think we agreed to skip rk3588 or make the number of clocks strict?

> +
> +  "#phy-cells":
> +    const: 0
> +
> +  resets:
> +    maxItems: 1
> +
> +  reset-names:
> +    const: phy
> +
> +  rockchip,phy-grf:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description: phandle to the syscon managing the phy "general register files"
> +
> +  rockchip,pipe-grf:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description: phandle to the syscon managing the pipe "general register files"
> +
> +  rockchip,pcie30-phymode:
> +    $ref: '/schemas/types.yaml#/definitions/uint32'

No need for quotes. You don't use it in other places.

> +    description: |
> +      set the phy-mode for enabling bifurcation
> +      bit0: bifurcation for port 0
> +      bit1: bifurcation for port 1
> +      bit2: aggregation
> +      constants are defined in the dt-bindings/phy/phy-rockchip-pcie3.h

Full path. It should also follow vendor,device naming convention.

> +    minimum: 0x0
> +    maximum: 0x4
> +    default: 0x4
> +
> +required:
> +  - compatible
> +  - reg
> +  - rockchip,phy-grf
> +  - "#phy-cells"
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/rk3568-cru.h>
> +    pcie30phy: phy@fe8c0000 {
> +      compatible = "rockchip,rk3568-pcie3-phy";
> +      reg = <0x0 0xfe8c0000 0x0 0x20000>;
> +      #phy-cells = <0>;
> +      clocks = <&pmucru CLK_PCIE30PHY_REF_M>,
> +               <&pmucru CLK_PCIE30PHY_REF_N>,
> +               <&cru PCLK_PCIE30PHY>;
> +      clock-names = "refclk_m", "refclk_n", "pclk";
> +      resets = <&cru SRST_PCIE30PHY>;
> +      reset-names = "phy";
> +      rockchip,phy-grf = <&pcie30_phy_grf>;
> +    };


Best regards,
Krzysztof
