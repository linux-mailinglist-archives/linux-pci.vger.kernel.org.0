Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B57457C71F
	for <lists+linux-pci@lfdr.de>; Thu, 21 Jul 2022 11:13:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232761AbiGUJNd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 21 Jul 2022 05:13:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232345AbiGUJNc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 21 Jul 2022 05:13:32 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C739357D4
        for <linux-pci@vger.kernel.org>; Thu, 21 Jul 2022 02:13:31 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id u14so1108275lju.0
        for <linux-pci@vger.kernel.org>; Thu, 21 Jul 2022 02:13:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=TpS5izxbfaIi7KiXxTWz4goQ0xYb3Nec6QgQZFgkaFE=;
        b=Ne/Tamn9sbxHkFifvNCByhbqPuu7S59vYRhKjA+pAGtq/voVmRpIKPGl9l2Kjbc98w
         5CKROxuqxUCEqexcCgU3SHklH4gCpLkkMPZ5fTqsEk1Q0mBkpckAnTqyH19AT7cWqqx1
         GtuOTVsIHaeXnoC4oGX78S5T9pCG+PPPP/NfC/cu7xK69P8GkXvmY2Yoe7utySXmSHLB
         l3QomXa/Hw95FksUG9tfQW0bJ+lNDf0NtjzhudXzf2B6isggQukBIHvIZGLeSQl7OOxI
         oqCh+uWtxNvECLXZPtL8zCbd6CyhMkDXx2EuFxw7aizwyLDeGHefcD2w32KfH0X1pIw6
         9qpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=TpS5izxbfaIi7KiXxTWz4goQ0xYb3Nec6QgQZFgkaFE=;
        b=sjoG92ZHBS8ejibXh0nKI8Z2XiVOFeCli/Zzss0wvlyvWmK9XWchIyYdMyHZG9JM1v
         YzWSHOVQ9u2PHyJmJIspz0FsHytgkhKTHNlVQvjq3MKTa0EJkxdc+Y5LvTTVxaYQ1v11
         TYJy9BZpQ/I+kXGS7RcWvU1szwMEptldhQYFzJkY818qii3o85RPi+i3by8jdBS/QB2z
         euPQ6QfRnh3tcfuZpV/hqzMvNI6levo1yeAe+hp2fRt+62aK448axtLYO/HksxCt40Ct
         9E9V9oCaOkp29DaHB2MpEwHfNNRRp33kIxfgxz+aIFejgUQKoMhj2Ook9QIVVQ1K1eDO
         9/wA==
X-Gm-Message-State: AJIora+pW0ZzUKmQ3+yrWnawbwamjleKJqEMuz4tPbXJopGUWLajEyTh
        eWTKhTlJYUHS1c9uKtiT6yvVOw==
X-Google-Smtp-Source: AGRyM1vl+UbQxsnzo9Wgux87cQYIJBlZXhKDpg0KV4cXsthLRh+gvdcdYWQ7aL/wMk5e1MmMIqymUg==
X-Received: by 2002:a2e:504:0:b0:25d:529a:3852 with SMTP id 4-20020a2e0504000000b0025d529a3852mr17569239ljf.179.1658394809488;
        Thu, 21 Jul 2022 02:13:29 -0700 (PDT)
Received: from [192.168.115.193] (89-162-31-138.fiber.signal.no. [89.162.31.138])
        by smtp.gmail.com with ESMTPSA id y11-20020a05651c106b00b002554dce4048sm366771ljm.53.2022.07.21.02.13.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Jul 2022 02:13:28 -0700 (PDT)
Message-ID: <84853ee4-94aa-585d-e13d-dca21a6ac37e@linaro.org>
Date:   Thu, 21 Jul 2022 11:13:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v4 2/5] dt-bindings: phy: Add ARTPEC-8 PCIe phy
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
References: <20220720055108epcms2p563c65b3de6333ccbc68386aa2471a800@epcms2p5>
 <CGME20220720055108epcms2p563c65b3de6333ccbc68386aa2471a800@epcms2p6>
 <20220720055716epcms2p60e80b1089dca0f83a894262bce676858@epcms2p6>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220720055716epcms2p60e80b1089dca0f83a894262bce676858@epcms2p6>
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

On 20/07/2022 07:57, Wangseok Lee wrote:
> Add description to support Axis, ARTPEC-8 SoC. ARTPEC-8 is the SoC platform
> of Axis Communications and PCIe PHY is designed based on Samsung PHY.
> 
> Signed-off-by: Wangseok Lee <wangseok.lee@samsung.com>
> ---
> v3->v4 :
> -Add "fsys-sysreg" to properties
> -Modify the "lcpll-ref-clk" and "clocks" in properties
>  "lcpll-ref-clk" is custom properties, so add 'vendor', type(enum),
>  description
>  Add the maxItem in clocks, add clock-names in properties
> 
> v2->v3 :
> -Modify version history to fit the linux commit rule
> -Remove 'Device Tree Bindings' on title
> -Remove clock-names entries
> -Change node name to soc from artpec8 on excamples
> 
> v1->v2 :
> -'make dt_binding_check' result improvement
> -Add the missing property list
> -Align the indentation of continued lines/entries
> ---
>  .../bindings/phy/axis,artpec8-pcie-phy.yaml        | 85 ++++++++++++++++++++++
>  1 file changed, 85 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/phy/axis,artpec8-pcie-phy.yaml
> 
> diff --git a/Documentation/devicetree/bindings/phy/axis,artpec8-pcie-phy.yaml b/Documentation/devicetree/bindings/phy/axis,artpec8-pcie-phy.yaml
> new file mode 100644
> index 0000000..9db39ef
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/phy/axis,artpec8-pcie-phy.yaml
> @@ -0,0 +1,85 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/phy/axis,artpec8-pcie-phy.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: ARTPEC-8 SoC PCIe PHY
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
> +    maxItems: 1
> +
> +  clock-names:
> +    items:
> +      - const: ref
> +
> +  samsung,fsys-sysreg:
> +    description:
> +      Phandle to system register of fsys block.
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +
> +  num-lanes:
> +    const: 2
> +
> +  axis,lcpll-ref-clk:
> +    description:
> +      select the reference clock of phy and initialization is performed
> +      with the reference clock according to the selected value.
> +    $ref: /schemas/types.yaml#/definitions/uint32

This looks like hardware register value... but after looking at driver
you rather need string... although REF_CLK_RESERVED is confusing. You
need to describe the feature, not some device programming model.

Then looking deeper it seems you just made a workaround around common
clock framework. At least for XO and SOC case - you just implemented a
clock mux in your PHY driver!

Implement a clock driver instead and handle only special case - clock
coming from IO.

Best regards,
Krzysztof
