Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70A6275A1F0
	for <lists+linux-pci@lfdr.de>; Thu, 20 Jul 2023 00:31:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230008AbjGSWbc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 19 Jul 2023 18:31:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230056AbjGSWba (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 19 Jul 2023 18:31:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C8041FF3;
        Wed, 19 Jul 2023 15:31:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AAE4661861;
        Wed, 19 Jul 2023 22:31:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83594C433C8;
        Wed, 19 Jul 2023 22:31:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689805887;
        bh=qqmViE+j7/JyQFjtU1ThMJ0/I3rb/IhD8YINnhugbgY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XMRBk3PO6f7xR/G2Cg4+D3QqMlwSypkRWhR3GQWTJjQ800TZ6tAn5pC4jS/xMRdA6
         iiKUqeeVNLN6GcCnc3UAQmG52yFhyHtgNEwtsvFteh7nuhvx5f0WeWusH3oQOLU/zA
         fUARhiyMi4cnrLTZW0BLLQDL3/HlPNpoNdRWPchDVMcQOoz4cTe2radHUV1npidTFm
         hxWDpFTLEKuR116yMUJueNrQg/Nobtoo0NK93u/sQgU8gwhSv4cNz3MTei3PRwyj9q
         l1Oe3VLFYdKwQm//tUa2jjoVL6t3juxBGi6HVlwEZDBavP3Tu/mneNEY+3zlbDX2Qw
         tT23vTMq9RR4w==
Received: (nullmailer pid 890442 invoked by uid 1000);
        Wed, 19 Jul 2023 22:31:24 -0000
Date:   Wed, 19 Jul 2023 16:31:24 -0600
From:   Rob Herring <robh@kernel.org>
To:     Minda Chen <minda.chen@starfivetech.com>
Cc:     Daire McNamara <daire.mcnamara@microchip.com>,
        Conor Dooley <conor@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-pci@vger.kernel.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Mason Huo <mason.huo@starfivetech.com>,
        Leyfoon Tan <leyfoon.tan@starfivetech.com>,
        Kevin Xie <kevin.xie@starfivetech.com>
Subject: Re: [PATCH v1 1/9] dt-bindings: PCI: Add PLDA XpressRICH PCIe host
 common properties
Message-ID: <20230719223124.GB882340-robh@kernel.org>
References: <20230719102057.22329-1-minda.chen@starfivetech.com>
 <20230719102057.22329-2-minda.chen@starfivetech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230719102057.22329-2-minda.chen@starfivetech.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jul 19, 2023 at 06:20:49PM +0800, Minda Chen wrote:
> Add PLDA XpressRICH PCIe host common properties dt-binding doc.
> Microchip PolarFire PCIe host using PLDA IP.
> Extract properties from Microchip PolarFire PCIe host.
> 
> Signed-off-by: Minda Chen <minda.chen@starfivetech.com>
> Reviewed-by: Hal Feng <hal.feng@starfivetech.com>
> ---
>  .../pci/plda,xpressrich-pcie-common.yaml      | 72 +++++++++++++++++++
>  1 file changed, 72 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pci/plda,xpressrich-pcie-common.yaml
> 
> diff --git a/Documentation/devicetree/bindings/pci/plda,xpressrich-pcie-common.yaml b/Documentation/devicetree/bindings/pci/plda,xpressrich-pcie-common.yaml
> new file mode 100644
> index 000000000000..3627a846c5d1
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pci/plda,xpressrich-pcie-common.yaml
> @@ -0,0 +1,72 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/pci/plda,xpressrich-pcie-common.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: PLDA XpressRICH PCIe host common properties
> +
> +maintainers:
> +  - Daire McNamara <daire.mcnamara@microchip.com>
> +  - Minda Chen <minda.chen@starfivetech.com>
> +
> +description:
> +  Generic PLDA XpressRICH PCIe host common properties.
> +
> +select: false
> +
> +properties:
> +  reg:
> +    description:
> +      At least host IP register set and configuration space are
> +      required for normal controller work.
> +    maxItems: 2
> +
> +  reg-names:
> +    oneOf:
> +      - items:
> +          - const: cfg
> +          - const: apb
> +      - items:
> +          - const: host
> +          - const: cfg

This didn't exist before. Where's the reasoning?

There's no reason for 'cfg' to be in different spots and little reason 
to have different names for the host/apb space.

Rob

