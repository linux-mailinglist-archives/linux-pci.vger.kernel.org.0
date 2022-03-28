Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43F0D4E9F1E
	for <lists+linux-pci@lfdr.de>; Mon, 28 Mar 2022 20:42:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243749AbiC1Snq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 28 Mar 2022 14:43:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234951AbiC1Snp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 28 Mar 2022 14:43:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62F3963BDD;
        Mon, 28 Mar 2022 11:42:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E37786121D;
        Mon, 28 Mar 2022 18:42:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40793C004DD;
        Mon, 28 Mar 2022 18:41:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648492923;
        bh=dZqPQ2evpGDvdU03aILrgKFbB/jCtqkJy9n0EhmsaPE=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=sBQIKt34fkvZofByJo6dJc4pu/Ex63J5X107Tjkda3aJ7DhpBIJrBZWYnXUj/9oke
         iP1ZMqF1fV1ET1S0T6ou/47yj8OgsrbUiiGq+1V8W7+ZGiIPRkZsHel2wWvukr+fAU
         oxNd1i0c9vHEPe+rpHFcZKOPTDImrOOCgcw8G6C3okTqFlqtojqX7r7DZijjzf4udK
         GPdoCoH60mo6AbV2DjKkJdbli5RaQknMIOBGTyj4SZBaBDC6VAXH/Udpc9x1AJiYNp
         yE52st+gUXGeU52b8HYy4bnNN771x4JQ+1kM190TgQPpP8kCQGnwyAd0jmXoHsUlWS
         DoGBOQQ4uHtSA==
Message-ID: <047cec5c-b9e4-5480-be96-01bae8610078@kernel.org>
Date:   Mon, 28 Mar 2022 20:41:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 1/5] dt-bindings: pci: Add ARTPEC-8 PCIe controller
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
        =?UTF-8?B?7KCE66y46riw?= <moonki.jun@samsung.com>
References: <CGME20220328014857epcms2p7d8cfd98d60f059916ef35ccc385bc004@epcms2p7>
 <20220328014857epcms2p7d8cfd98d60f059916ef35ccc385bc004@epcms2p7>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <20220328014857epcms2p7d8cfd98d60f059916ef35ccc385bc004@epcms2p7>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 28/03/2022 03:48, 이왕석 wrote:
> Add description to support Axis, ARTPEC-8 SoC.
> ARTPEC-8 is the SoC platform of Axis Communications
> and PCIe controller is designed based on Design-Ware PCIe controller.
> 
> Signed-off-by: Wangseok Lee <wangseok.lee@samsung.com>
> ---
>  .../bindings/pci/axis,artpec8-pcie-ep.yaml         | 110 +++++++++++++++++++
>  .../devicetree/bindings/pci/axis,artpec8-pcie.yaml | 117 +++++++++++++++++++++
>  2 files changed, 227 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pci/axis,artpec8-pcie-ep.yaml
>  create mode 100644 Documentation/devicetree/bindings/pci/axis,artpec8-pcie.yaml
> 
> diff --git a/Documentation/devicetree/bindings/pci/axis,artpec8-pcie-ep.yaml b/Documentation/devicetree/bindings/pci/axis,artpec8-pcie-ep.yaml
> new file mode 100644
> index 0000000..dc66965
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pci/axis,artpec8-pcie-ep.yaml
> @@ -0,0 +1,110 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/pci/axis,artpec8-pcie-ep.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: ARTPEC-8 SoC PCIe Controller Device Tree Bindings
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
> +      - const: pipe_clk
> +      - const: dbi_clk
> +      - const: mstr_clk
> +      - const: slv_clk
> +
> +  phys:
> +    maxItems: 1
> +
> +  num-lanes:
> +    const: 2
> +
> +required:

compatible

> +  - clocks
> +  - clock-names
> +  - reg
> +  - reg-names
> +  - num-lanes
> +  - bus-range
> +  - interrupts
> +  - interrupt-names
> +  - samsung,fsys-sysreg
> +  - samsung,syscon-phandle
> +  - samsung,syscon-bus-s-fsys
> +  - samsung,syscon-bus-p-fsys

Why are they here but not in properties? Other properties are also
present here but not in properties.

> +  - phys
> +  - phy-names
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +
> +    artec8 {
> +        #address-cells = <2>;
> +        #size-cells = <2>;
> +        pcie_ep: pcie-ep@17200000 {
> +            compatible = "axis,artpec8-pcie-ep";
> +            clocks = <&clock_cmu_fsys 39>,
> +                        <&clock_cmu_fsys 38>,
> +                        <&clock_cmu_fsys 37>,
> +                        <&clock_cmu_fsys 36>;

Align the indentation of continued lines/entries.

> +            clock-names = "pipe_clk", "dbi_clk", "mstr_clk", "slv_clk";
> +            reg = <0x0 0x17200000 0x0 0x1000>,

Put reg after compatible.

> +                    <0x0 0x17201000 0x0 0x1000>,
> +                    <0x2 0x00000000 0x6 0x00000000>;
> +            reg-names = "dbi", "dbi2", "addr_space";
> +            num-lanes = <2>;
> +            bus-range = <0x00 0xff>;
> +            interrupts = <GIC_SPI 115 IRQ_TYPE_LEVEL_HIGH>;
> +            interrupt-names = "intr";
> +            #interrupt-cells = <1>;
> +            num-ib-windows = <16>;
> +            num-ob-windows = <16>;

Did you test the bindings with `make dt_binding_check`?

All comments apply also to your second file.

Best regards,
Krzysztof
