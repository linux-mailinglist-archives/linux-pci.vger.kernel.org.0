Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBCD34E9EFD
	for <lists+linux-pci@lfdr.de>; Mon, 28 Mar 2022 20:32:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244195AbiC1Sdy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 28 Mar 2022 14:33:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237113AbiC1Sdx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 28 Mar 2022 14:33:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05CEA5EBED;
        Mon, 28 Mar 2022 11:32:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 983CA611EA;
        Mon, 28 Mar 2022 18:32:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BBD2C340F0;
        Mon, 28 Mar 2022 18:32:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648492331;
        bh=qTJLwlHIWwP5+DZq5BGQzbEGxvcxsBdd85KV4h6WqpI=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=OMy5p4bwpv+sG05puY/dpOhz9ypxUvmCeyDMkoTWMl10RTF08relfzTYGCROzpOAd
         POh3wBAcf/VcCcOhl0v0QT+hMgKMGnhZrSBmbCO64TISvszUPv1/R2HvTsyzVqbYSc
         LL8uYBu6Zo2X2h1AEQMeTiEnPFqDFItqLXJ3WykdLkhQ2RUN2fwlvErXpoh7xCqxr5
         vCu1qe/nSZwfYFqakjtivLjA6O6hqihbJk8NoC3JWGARq3Y2qZ7C2SXs/UYqCVImNS
         SK/T9B81DsGmzhD4INH9Rw09vqst4Hf1I+ziwgczt7pWLuUaWkRQBceCLjWR/Ub9p7
         NGZsPMinE4C7A==
Message-ID: <90520a06-8c18-dbed-627b-afe9824cacc0@kernel.org>
Date:   Mon, 28 Mar 2022 20:32:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 2/5] dt-bindings: phy: Add ARTPEC-8 PCIe phy
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
References: <CGME20220328084319epcms2p3670d7836bb111e0d9c648aeebfde8603@epcms2p3>
 <20220328084319epcms2p3670d7836bb111e0d9c648aeebfde8603@epcms2p3>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <20220328084319epcms2p3670d7836bb111e0d9c648aeebfde8603@epcms2p3>
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

On 28/03/2022 10:43, 이왕석 wrote:
> Add description to support Axis, ARTPEC-8 SoC.
> ARTPEC-8 is the SoC platform of Axis Communications
> and PCIe phy is designed based on SAMSUNG PHY.
> 
> Signed-off-by: Wangseok Lee <wangseok.lee@samsung.com>
> ---
>  .../bindings/phy/axis,artpec8-pcie-phy.yaml        | 67 ++++++++++++++++++++++
>  1 file changed, 67 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/phy/axis,artpec8-pcie-phy.yaml
> 
> diff --git a/Documentation/devicetree/bindings/phy/axis,artpec8-pcie-phy.yaml b/Documentation/devicetree/bindings/phy/axis,artpec8-pcie-phy.yaml
> new file mode 100644
> index 0000000..f5f4166
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/phy/axis,artpec8-pcie-phy.yaml
> @@ -0,0 +1,67 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/phy/axis,artpec8-pcie-phy.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: ARTPEC-8 SoC PCIe PHY Device Tree Bindings

s/Device Tree Bindings//

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
> +  clocks:
> +    items:
> +      - description: PCIe PHY reference clock
> +
> +  clock-names:
> +    items:
> +      - const: ref_clk
> +
> +required:
> +  - compatible
> +  - "#phy-cells"
> +  - reg
> +  - reg-names
> +  - clocks
> +  - clock-names
> +  - samsung,fsys-sysreg

It seems you copied some things from some other bindings, so please
clean it up to really fit your device.

Best regards,
Krzysztof
