Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED9F853E800
	for <lists+linux-pci@lfdr.de>; Mon,  6 Jun 2022 19:08:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233561AbiFFKPy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 6 Jun 2022 06:15:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234001AbiFFKPB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 6 Jun 2022 06:15:01 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68435A98A4
        for <linux-pci@vger.kernel.org>; Mon,  6 Jun 2022 03:14:23 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id h19so18160340edj.0
        for <linux-pci@vger.kernel.org>; Mon, 06 Jun 2022 03:14:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=BkH5Y5j/4diyxC4BxZO4A1oyviqTC8HdJoLfxxc2uC0=;
        b=JDHsJs2As/HiUSVG6Jc2zao2gEZhqwTSDMAMoS2looKDYr21f49v97yHQ3pV4sMDqy
         vRYp+WFd9g346m2ZlrUsuhtg4/R1e/PlRZnlZWXR6/G6WMCeUFALGba/oXPHraJaQWVW
         i61aJMJyXm6nyUEgf93zRqoM8eW39gQdUcSeytyM5aWqQfBMogZF032e6xDIOcfTee4q
         m3NDN+uypgctVRFXqBuY0gcbzUmlMFnF8ctPfFO4+6QuW+hNutDv1ZJjwxSfqhgvWTNw
         njEeEbwWKlFC2HG4JStkfHlMv5zdhf1jq+I6+SQte0KNn37clYLikv64rk2NZK/Bgsw9
         OXcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=BkH5Y5j/4diyxC4BxZO4A1oyviqTC8HdJoLfxxc2uC0=;
        b=fYat7ZenKBNZyWN4l0vXToLmEzaKAsR4YwiCYs20VfQJw3g6BRhItSuWuB6OU+UF5q
         Y8czYSFROCJ9pCIsKI1zSpzqdBAG7Jf2Z+xdq5qps4D7lAYJZeAZXg8wOLvkEZbEkgMm
         UAopl4U1Eff7BPy9D4aI+ZK+VYxDSLC+s6aex+KRcQLF41SsMH1g1F2RVykXoJd3AmHC
         RSpEFcwI50LIs4brHpqKve/r4mF0Zv+I1vEJWV4urNzDzxDzpCmIwwLXrAdc0NOtMYO+
         4y5I5IgR0SYz+PwvA0zGfa95Wv7w283AGJK4SoDw7grARS4FWO8u7nrRvtrzQO2L2YK/
         wzkg==
X-Gm-Message-State: AOAM531R/C467wjpluSfFweNydQHMgNm+WZoPf1oqRoTFb6m1yu3p/br
        pkvyOa8IyNM74qupjy923r4UIQ==
X-Google-Smtp-Source: ABdhPJyihbUPMb1yzM0sumOLqAsH/9XFxEOokF/wNE+hvrWNaIwgvk2Az0zFUc4w0QtiT60n6ZBIug==
X-Received: by 2002:a05:6402:3899:b0:42d:d79e:acef with SMTP id fd25-20020a056402389900b0042dd79eacefmr25822942edb.12.1654510461646;
        Mon, 06 Jun 2022 03:14:21 -0700 (PDT)
Received: from [192.168.0.181] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id a26-20020a1709062b1a00b006f3ef214db4sm5268472ejg.26.2022.06.06.03.14.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Jun 2022 03:14:21 -0700 (PDT)
Message-ID: <45aa26be-625e-47eb-c21f-92497e60b6dd@linaro.org>
Date:   Mon, 6 Jun 2022 12:14:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v2 2/5] dt-bindings: phy: Add ARTPEC-8 PCIe phy
Content-Language: en-US
To:     wangseok.lee@samsung.com,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
        "kishon@ti.com" <kishon@ti.com>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jesper.nilsson@axis.com" <jesper.nilsson@axis.com>,
        "lars.persson@axis.com" <lars.persson@axis.com>
Cc:     "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "kw@linux.com" <kw@linux.com>,
        "linux-arm-kernel@axis.com" <linux-arm-kernel@axis.com>,
        "kernel@axis.com" <kernel@axis.com>,
        Moon-Ki Jun <moonki.jun@samsung.com>,
        Sang Min Kim <hypmean.kim@samsung.com>,
        Dongjin Yang <dj76.yang@samsung.com>
References: <20220603015431epcms2p6203908cebe6a320854136559a32b54cb@epcms2p6>
 <CGME20220603015431epcms2p6203908cebe6a320854136559a32b54cb@epcms2p6>
 <20220603023158epcms2p6949f6cd93926b9e811e1b4d52fbef91b@epcms2p6>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220603023158epcms2p6949f6cd93926b9e811e1b4d52fbef91b@epcms2p6>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 03/06/2022 04:31, Wangseok Lee wrote:
> Add description to support Axis, ARTPEC-8 SoC.
> ARTPEC-8 is the SoC platform of Axis Communications
> and PCIe phy is designed based on SAMSUNG PHY.

This does not look like wrapped in Linux commit style.
https://elixir.bootlin.com/linux/v5.18-rc4/source/Documentation/process/submitting-patches.rst#L586

> 
> changes since v1 :
> -'make dt_binding_check' result improvement
> -Add the missing property list
> -Align the indentation of continued lines/entries
> 
> Signed-off-by: Wangseok Lee <wangseok.lee@samsung.com>
> ---
>  .../bindings/phy/axis,artpec8-pcie-phy.yaml        | 70 ++++++++++++++++++++++
>  1 file changed, 70 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/phy/axis,artpec8-pcie-phy.yaml
> 
> diff --git a/Documentation/devicetree/bindings/phy/axis,artpec8-pcie-phy.yaml b/Documentation/devicetree/bindings/phy/axis,artpec8-pcie-phy.yaml
> new file mode 100644
> index 0000000..ab9766f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/phy/axis,artpec8-pcie-phy.yaml
> @@ -0,0 +1,70 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/phy/axis,artpec8-pcie-phy.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: ARTPEC-8 SoC PCIe PHY Device Tree Bindings

Same comment as patch #1.

> +
> +maintainers:
> +  - Jesper Nilsson <jesper.nilsson@axis.com>
> +
> +properties:
> +  compatible:
> +    const: axis,artpec8-pcie-phy
> +
> +  reg:
> +    items:
> +      - description: PHY registers.
> +      - description: PHY coding sublayer registers.
> +
> +  reg-names:
> +    items:
> +      - const: phy
> +      - const: pcs
> +
> +  "#phy-cells":
> +    const: 0
> +
> +  clocks:
> +    items:
> +      - description: PCIe PHY reference clock
> +
> +  clock-names:
> +    items:
> +      - const: ref_clk

Same comment as patch #1.

> +
> +  num-lanes:
> +    const: 2
> +
> +required:
> +  - compatible
> +  - reg
> +  - reg-names
> +  - "#phy-cells"
> +  - clocks
> +  - clock-names
> +  - num-lanes
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +
> +    artpec8 {

Same comment as patch #1.


> +        #address-cells = <2>;
> +        #size-cells = <2>;
> +        pcie_phy: pcie-phy@16c80000 {
> +            compatible = "axis,artpec8-pcie-phy";
> +            reg = <0x0 0x16c80000 0x0 0x2000>,
> +                  <0x0 0x16c90000 0x0 0x1000>;
> +            reg-names = "phy", "pcs";
> +            #phy-cells = <0>;
> +            clocks = <&clock_cmu_fsys 53>;
> +            clock-names = "ref_clk";
> +            num-lanes = <2>;
> +        };
> +    };
> +...


Best regards,
Krzysztof
