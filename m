Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF04F58072F
	for <lists+linux-pci@lfdr.de>; Tue, 26 Jul 2022 00:18:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236918AbiGYWR7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 25 Jul 2022 18:17:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231225AbiGYWR6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 25 Jul 2022 18:17:58 -0400
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFF752528E;
        Mon, 25 Jul 2022 15:17:57 -0700 (PDT)
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-10d845dcf92so16496955fac.12;
        Mon, 25 Jul 2022 15:17:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2rrcb9f4QNI+rrP3iu4IqG0Ip38ZT7x7ewT7RQRw2sw=;
        b=Mw749SKn1KIkv7S6sKKtrngAeKnNGiAkgQo29bryUNai2sPCPT3XcG+E+g/5v9kVxJ
         MZJa5TqvrK9RgqBl1gRE503sWsvCZnv3fEjk7hwVm8AN9oO26pv7I6l3CnzDRLURbeXp
         +QDgcVVZ8B7d/qUmDqIofxP8lwU9b33cUeSxzgmg/hTjLDyzNvX6mR1iXjTWI9fWrVBg
         NkDOjwUUb4Fkka+PB3j2rH+D2wQ2Qr0HIHzPIWdwBfN3eVx8ijl7AA2dpOjuTCJqA40N
         whIC90cIV31wYS0WN8TB9qEGgeX2+FjDYUF++2pM8QgXafYyt9G+WYdBWgjWQ4zxwUbD
         5F/A==
X-Gm-Message-State: AJIora+AnOaXjBtvHUNEj5ZnXWr1VOQ98+nMcmNgxMW/AT7xLMEv8QoY
        wse8OekXE9E7zu+7XzOX9w==
X-Google-Smtp-Source: AGRyM1sIYz6SRC/uSCi6BXyC9JlXtZ08PZ4e/NVxwwPHpjKRIYFBs1sh4Y3MOfnSzgKwaSVVWkHu2w==
X-Received: by 2002:a05:6870:5809:b0:101:ce10:b267 with SMTP id r9-20020a056870580900b00101ce10b267mr15416392oap.83.1658787477036;
        Mon, 25 Jul 2022 15:17:57 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id k1-20020a544401000000b0033aef871695sm793944oiw.16.2022.07.25.15.17.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jul 2022 15:17:55 -0700 (PDT)
Received: (nullmailer pid 2841630 invoked by uid 1000);
        Mon, 25 Jul 2022 22:17:53 -0000
Date:   Mon, 25 Jul 2022 16:17:53 -0600
From:   Rob Herring <robh@kernel.org>
To:     Wangseok Lee <wangseok.lee@samsung.com>
Cc:     "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
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
        "kernel@axis.com" <kernel@axis.com>,
        Moon-Ki Jun <moonki.jun@samsung.com>,
        Sang Min Kim <hypmean.kim@samsung.com>,
        Dongjin Yang <dj76.yang@samsung.com>,
        Yeeun Kim <yeeun119.kim@samsung.com>
Subject: Re: [PATCH v4 2/5] dt-bindings: phy: Add ARTPEC-8 PCIe phy
Message-ID: <20220725221753.GA2838092-robh@kernel.org>
References: <20220720055108epcms2p563c65b3de6333ccbc68386aa2471a800@epcms2p5>
 <CGME20220720055108epcms2p563c65b3de6333ccbc68386aa2471a800@epcms2p6>
 <20220720055716epcms2p60e80b1089dca0f83a894262bce676858@epcms2p6>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220720055716epcms2p60e80b1089dca0f83a894262bce676858@epcms2p6>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jul 20, 2022 at 02:57:16PM +0900, Wangseok Lee wrote:
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

Why do you need num-lanes if 2 is the only possible value?

Rob

