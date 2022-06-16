Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DB0A54EDA7
	for <lists+linux-pci@lfdr.de>; Fri, 17 Jun 2022 00:54:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379203AbiFPWyg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 16 Jun 2022 18:54:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379148AbiFPWyf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 16 Jun 2022 18:54:35 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6D2562222
        for <linux-pci@vger.kernel.org>; Thu, 16 Jun 2022 15:54:30 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id t2so2416126pld.4
        for <linux-pci@vger.kernel.org>; Thu, 16 Jun 2022 15:54:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=KvdFdybzsfCrVLJiE6jE28GhzC47Iq7vrpUoy7lQWTA=;
        b=hJtSAjHgQBG7RZVsQrUmH9gCs/GTX59zAbc8l1SsA2LzCowbx/R5AvPzFON5JgVLeU
         dn+uev+AAYMsJjrfmNUzPaeNJ02nsUxEzEJNVhK54AfgTN2D+BOkz/NYf18MJl36x3sO
         73v0wR3XlHJ0L0Hg7gnz8Yd7Iw346TNE7Yj2apcsMhfsUc4mRShvbyVypJ5W5XqvqbT3
         5mPUh9NJ930n2Ypt3mmbMPUGuhTFeKeu41w2PZkSfolc+YhxxSM4PeUyHhUz7dYFpOV6
         NXdjTEalcXxXahk7eUcmZ4s9rKZTXCed6WhdzHw3kGRkLSFlnmRSmibIGqXiGUGFoTPS
         uw/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=KvdFdybzsfCrVLJiE6jE28GhzC47Iq7vrpUoy7lQWTA=;
        b=oKzgg/okhaxFpy6Q3R1BH+5sJWEa+qNyI3Flex7B+95TrkTqbo2CEpd/SpXMwImKS8
         p+rZb4/1+/KAvSrJ4ShMzaPhlflzZTf+tNxOxC0a+AxAsrjNUML7kx4UzUlomreJPQ7n
         OOhSeFUByOTsyGLeKhnsdJRoXdLohAGhqhg/Hyy4tFzQP2eZtRE2OfTZkT057rlW5FRB
         mnMfO3K1LfBeOaM9dT3wJ40aE/4a/KOI8BkLLecMVcXyEN67XuGuWV0vwEKQ2Wxseo+i
         9nMM1Jq7/aQQnpZolLWPeUta+uG/kOdpU4HQsVUKfGpdKxXGi3ZBIqNsyfNmwwUzyls9
         9HeQ==
X-Gm-Message-State: AJIora85mQRdNnKrvjV5K5AQO25YygTDoLs2ll1ihBgiBgBUB3Jl2+LB
        XQSJUEm3Q2+GH+x/Di/DuAPDtQ==
X-Google-Smtp-Source: AGRyM1tUQAz1x5ZGtXe2AU2lhklwM3xE7SHjf9AUkKRbU20CnWAFSWAxen6PCWze2dccrry4SWdCsA==
X-Received: by 2002:a17:903:25c5:b0:16a:30e:34b8 with SMTP id jc5-20020a17090325c500b0016a030e34b8mr1153769plb.170.1655420069803;
        Thu, 16 Jun 2022 15:54:29 -0700 (PDT)
Received: from [172.22.33.138] ([192.77.111.2])
        by smtp.gmail.com with ESMTPSA id m2-20020a170902768200b0015eb200cc00sm2108938pll.138.2022.06.16.15.54.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Jun 2022 15:54:29 -0700 (PDT)
Message-ID: <8d806fc9-0067-2c8d-ec41-13787c7644a2@linaro.org>
Date:   Thu, 16 Jun 2022 15:54:28 -0700
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
References: <20220614011616epcms2p7dcaa67c53b7df5802dd7a697e2d472d7@epcms2p7>
 <CGME20220614011616epcms2p7dcaa67c53b7df5802dd7a697e2d472d7@epcms2p8>
 <20220614012713epcms2p810386a5137fbcf6aefc41fe086badc0b@epcms2p8>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220614012713epcms2p810386a5137fbcf6aefc41fe086badc0b@epcms2p8>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 13/06/2022 18:27, Wangseok Lee wrote:
> Add description to support Axis, ARTPEC-8 SoC.
> ARTPEC-8 is the SoC platform of Axis Communications
> and PCIe controller is designed based on Design-Ware PCIe controller.
> 
> Signed-off-by: Wangseok Lee <wangseok.lee@samsung.com>
> ---
> v2->v3 :
> - modify version history to fit the linux commit rule
> - remove 'Device Tree Bindings' on title
> - remove the interrupt-names, phy-names entries
> - remove '_clk' suffix
> - add the compatible entries on required
> - change node name to soc from artpec8 on examples
> 
> v1->v2 :
> -'make dt_binding_check' result improvement
> -Add the missing property list
> -Align the indentation of continued lines/entries
> ---
>  .../bindings/pci/axis,artpec8-pcie-ep.yaml         | 109 +++++++++++++++++++
>  .../devicetree/bindings/pci/axis,artpec8-pcie.yaml | 120 +++++++++++++++++++++
>  2 files changed, 229 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pci/axis,artpec8-pcie-ep.yaml
>  create mode 100644 Documentation/devicetree/bindings/pci/axis,artpec8-pcie.yaml
> 
> diff --git a/Documentation/devicetree/bindings/pci/axis,artpec8-pcie-ep.yaml b/Documentation/devicetree/bindings/pci/axis,artpec8-pcie-ep.yaml
> new file mode 100644
> index 0000000..d802bba
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pci/axis,artpec8-pcie-ep.yaml
> @@ -0,0 +1,109 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/pci/axis,artpec8-pcie-ep.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: ARTPEC-8 SoC PCIe Controller
> +
> +maintainers:
> +  - Jesper Nilsson <jesper.nilsson@axis.com>
> +
> +description: |+
> +  This PCIe end-point controller is based on the Synopsys DesignWare PCIe IP
> +  and thus inherits all the common properties defined in snps,dw-pcie-ep.yaml.
> +
> +allOf:
> +  - $ref: /schemas/pci/snps,dw-pcie-ep.yaml#
> +
> +properties:
> +  compatible:
> +    const: axis,artpec8-pcie-ep
> +
> +  reg:
> +    items:
> +      - description: Data Bus Interface (DBI) registers.
> +      - description: Data Bus Interface (DBI2) registers.
> +      - description: PCIe address space region.
> +
> +  reg-names:
> +    items:
> +      - const: dbi
> +      - const: dbi2
> +      - const: addr_space
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  clocks:
> +    items:
> +      - description: PIPE clock, used by the controller to clock the PIPE
> +      - description: PCIe dbi clock, ungated version
> +      - description: PCIe master clock, ungated version
> +      - description: PCIe slave clock, ungated version
> +
> +  clock-names:
> +    items:
> +      - const: pipe
> +      - const: dbi
> +      - const: mstr
> +      - const: slv
> +
> +  phys:
> +    maxItems: 1
> +
> +  num-lanes:
> +    const: 2
> +
> +required:
> +  - compatible
> +  - reg
> +  - reg-names
> +  - interrupts
> +  - interrupt-names
> +  - clocks
> +  - clock-names
> +  - samsung,fsys-sysreg
> +  - samsung,syscon-phandle
> +  - samsung,syscon-bus-s-fsys
> +  - samsung,syscon-bus-p-fsys


We are making circles... This was before and I commented already it is
wrong. You cannot have some unknown/random properties in "required:"
without describing them in "properties:". Please list all your
properties in "properties:", except the ones coming from snps
bindings/schema.

> +  - phys
> +  - num-lanes
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +
> +    soc {
> +        #address-cells = <2>;
> +        #size-cells = <2>;
> +        pcie_ep: pcie-ep@17200000 {
> +            compatible = "axis,artpec8-pcie-ep";
> +            reg = <0x0 0x17200000 0x0 0x1000>,
> +                  <0x0 0x17201000 0x0 0x1000>,
> +                  <0x2 0x00000000 0x6 0x00000000>;
> +            reg-names = "dbi", "dbi2", "addr_space";
> +            #interrupt-cells = <1>;
> +            interrupts = <GIC_SPI 115 IRQ_TYPE_LEVEL_HIGH>;
> +            interrupt-names = "intr";
> +            clocks = <&clock_cmu_fsys 39>,
> +                     <&clock_cmu_fsys 38>,
> +                     <&clock_cmu_fsys 37>,
> +                     <&clock_cmu_fsys 36>;
> +            clock-names = "pipe", "dbi", "mstr", "slv";
> +            samsung,fsys-sysreg = <&syscon_fsys>;
> +            samsung,syscon-phandle = <&pmu_system_controller>;
> +            samsung,syscon-bus-s-fsys = <&syscon_bus_s_fsys>;
> +            samsung,syscon-bus-p-fsys = <&syscon_bus_p_fsys>;
> +            phys = <&pcie_phy>;
> +            phy-names = "pcie_phy";
> +            num-lanes = <2>;
> +            bus-range = <0x00 0xff>;
> +            num-ib-windows = <16>;
> +            num-ob-windows = <16>;
> +        };
> +    };
> +...
> diff --git a/Documentation/devicetree/bindings/pci/axis,artpec8-pcie.yaml b/Documentation/devicetree/bindings/pci/axis,artpec8-pcie.yaml
> new file mode 100644
> index 0000000..dbbe1fd
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pci/axis,artpec8-pcie.yaml
> @@ -0,0 +1,120 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/pci/axis,artpec8-pcie.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Artpec-8 SoC PCIe Controller
> +
> +maintainers:
> +  - Jesper Nilsson <jesper.nilsson@axis.com>
> +
> +description: |+
> +  This PCIe host controller is based on the Synopsys DesignWare PCIe IP
> +  and thus inherits all the common properties defined in snps,dw-pcie.yaml.
> +
> +allOf:
> +  - $ref: /schemas/pci/snps,dw-pcie.yaml#
> +
> +properties:
> +  compatible:
> +    const: axis,artpec8-pcie
> +
> +  reg:
> +    items:
> +      - description: Data Bus Interface (DBI) registers.
> +      - description: External Local Bus interface (ELBI) registers.
> +      - description: PCIe configuration space region.
> +
> +  reg-names:
> +    items:
> +      - const: dbi
> +      - const: elbi
> +      - const: config
> +
> +  ranges:
> +    maxItems: 2
> +
> +  num-lanes:
> +    const: 2
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  clocks:
> +    items:
> +      - description: PIPE clock, used by the controller to clock the PIPE
> +      - description: PCIe dbi clock, ungated version
> +      - description: PCIe master clock,  ungated version
> +      - description: PCIe slave clock, ungated version
> +
> +  clock-names:
> +    items:
> +      - const: pipe
> +      - const: dbi
> +      - const: mstr
> +      - const: slv
> +
> +  phys:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - reg-names
> +  - device_type
> +  - ranges
> +  - num-lanes
> +  - interrupts
> +  - interrupt-names
> +  - clocks
> +  - clock-names
> +  - samsung,fsys-sysreg
> +  - samsung,syscon-phandle
> +  - samsung,syscon-bus-s-fsys
> +  - samsung,syscon-bus-p-fsys

Same problem.

Best regards,
Krzysztof
