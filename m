Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E12336178B2
	for <lists+linux-pci@lfdr.de>; Thu,  3 Nov 2022 09:29:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229745AbiKCI3s (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 3 Nov 2022 04:29:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbiKCI3q (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 3 Nov 2022 04:29:46 -0400
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D863711A;
        Thu,  3 Nov 2022 01:29:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1667464185; x=1699000185;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=nhzYPUwoc2molQBCwNVn4uqguZHlXyZ1jSm1Y79u20Y=;
  b=KIvowcUsCYS4slAr1TxaAOvaLjD2VUwhrZ3pBEghijnwHP4s0kgCKPUV
   zs80mSsAvjRUIwWU85y/CtmStHQnattjp5YN01LbmkXgONlTnsYtvcdPe
   s1wHdAM7jdj9C2H73+4jXMOp6xJaEydTnoHBg62pO+VqHbWPR7Dv958r/
   SibBnsXHB9QBvGiSS5txNnh601fKbWkQElk3MeOvgZJ4vI/eGhn2X9EAH
   QTpnpe/HoSOcaQPG8zpp9Rgif59shSN0lCHCJmLdlvQjNpk4XX+TrxImE
   LpQPS1mwsdGHWYah+R+ubUvFSiEuDFkHNhF38kSH527LrAzb1LY4K1gS9
   w==;
X-IronPort-AV: E=Sophos;i="5.95,235,1661810400"; 
   d="scan'208";a="27127637"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 03 Nov 2022 09:29:43 +0100
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Thu, 03 Nov 2022 09:29:43 +0100
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Thu, 03 Nov 2022 09:29:43 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1667464183; x=1699000183;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=nhzYPUwoc2molQBCwNVn4uqguZHlXyZ1jSm1Y79u20Y=;
  b=e42VJ7IXPFvp+zmNrKjhGvCmi+0RhzV9vtvix+TWORZJppjhWb10eaFT
   tLI8Vp9+riMwmzaYnGYjo4EQZJkctUs8iThJ+swjuXe1uY1gH3L4A+2mA
   +mqXHdEFuKCW09RHH+0cowIk2TwKpK/Gyb5hfLm6GhujlHutP846TSyfS
   FlElL/f8exOGiifiAvNH6kyISadKvr1wQjhG5tjEfPE9zrcaZmhenwuc7
   ZnQzmrDEiAd4/vSnKCl9cS/t89H6JOCiRZSoKrn4rmZdk5KHlJlFk9DJV
   hCLI9D8FHhHQs9bbI/9S2JU7TaESFWrcEROXLAvVxQs4AeVZk/5CVdfVx
   A==;
X-IronPort-AV: E=Sophos;i="5.95,235,1661810400"; 
   d="scan'208";a="27127636"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 03 Nov 2022 09:29:42 +0100
Received: from steina-w.localnet (unknown [10.123.53.21])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id 3812A280056;
        Thu,  3 Nov 2022 09:29:42 +0100 (CET)
From:   Alexander Stein <alexander.stein@ew.tq-group.com>
To:     Marek Vasut <marex@denx.de>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pci@vger.kernel.org, Fabio Estevam <festevam@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Richard Zhu <hongxing.zhu@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        NXP Linux Team <linux-imx@nxp.com>,
        Marek Vasut <marex@denx.de>
Subject: Re: [PATCH 2/3] dt-bindings: imx6q-pcie: Handle various PD configurations
Date:   Thu, 03 Nov 2022 09:29:42 +0100
Message-ID: <3645906.iIbC2pHGDl@steina-w>
Organization: TQ-Systems GmbH
In-Reply-To: <20221102215729.147335-2-marex@denx.de>
References: <20221102215729.147335-1-marex@denx.de> <20221102215729.147335-2-marex@denx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Marek,

Am Mittwoch, 2. November 2022, 22:57:28 CET schrieb Marek Vasut:
> The i.MX SoCs have various power domain configurations routed into
> the PCIe IP. MX6SX is the only one which contains 2 domains and also
> uses power-domain-names. MX6QDL do not use any domains. All the rest
> uses one domain and does not use power-domain-names anymore.
> 
> Document all those configurations in the DT binding document.
> 
> Signed-off-by: Marek Vasut <marex@denx.de>
> ---
> Cc: Fabio Estevam <festevam@gmail.com>
> Cc: Lucas Stach <l.stach@pengutronix.de>
> Cc: Richard Zhu <hongxing.zhu@nxp.com>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: NXP Linux Team <linux-imx@nxp.com>
> To: devicetree@vger.kernel.org
> ---
>  .../bindings/pci/fsl,imx6q-pcie.yaml          | 47 ++++++++++++++-----
>  1 file changed, 34 insertions(+), 13 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
> b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml index
> 1cfea8ca72576..fc8d4d7b80b38 100644
> --- a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
> +++ b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
> @@ -68,19 +68,6 @@ properties:
>      description: A phandle to an fsl,imx7d-pcie-phy node. Additional
>        required properties for imx7d-pcie and imx8mq-pcie.
> 
> -  power-domains:
> -    items:
> -      - description: The phandle pointing to the DISPLAY domain for
> -          imx6sx-pcie, to PCIE_PHY power domain for imx7d-pcie and
> -          imx8mq-pcie.
> -      - description: The phandle pointing to the PCIE_PHY power domains
> -          for imx6sx-pcie.
> -
> -  power-domain-names:
> -    items:
> -      - const: pcie
> -      - const: pcie_phy
> -
>    resets:
>      maxItems: 3
>      description: Phandles to PCIe-related reset lines exposed by SRC
> @@ -241,6 +228,40 @@ allOf:
>                  - const: pcie_bus
>                  - const: pcie_phy
> 
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: fsl,imx6sx-pcie
> +    then:
> +      properties:
> +        power-domains:
> +          items:
> +            - description: The phandle pointing to the DISPLAY domain for
> +                imx6sx-pcie, to PCIE_PHY power domain for imx7d-pcie and
> +                imx8mq-pcie.
> +            - description: The phandle pointing to the PCIE_PHY power
> domains +                for imx6sx-pcie.
> +        power-domain-names:
> +          items:
> +            - const: pcie
> +            - const: pcie_phy
> +    else:
> +      if:
> +        not:
> +          properties:
> +            compatible:
> +              contains:
> +                enum:
> +                  - fsl,imx6q-pcie
> +                  - fsl,imx6qp-pcie
> +      then:
> +        properties:
> +          power-domains:
> +            description: |
> +               The phandle pointing to the DISPLAY domain for imx6sx-pcie,
> to +               PCIE_PHY power domain for imx7d-pcie and imx8mq-pcie. +

Doesn't it makes more sense to keep the power-domains descriptions in the 
common part on top, as before, but adjust minItems/maxItems for each 
compatible?

Regards,
Alexander

>  examples:
>    - |
>      #include <dt-bindings/clock/imx6qdl-clock.h>




