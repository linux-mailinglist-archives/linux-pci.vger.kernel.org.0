Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF4276178A2
	for <lists+linux-pci@lfdr.de>; Thu,  3 Nov 2022 09:25:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229964AbiKCIZQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 3 Nov 2022 04:25:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbiKCIZP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 3 Nov 2022 04:25:15 -0400
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CFED6168;
        Thu,  3 Nov 2022 01:25:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1667463914; x=1698999914;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2r8XOQHsUrbaJSTuWBrN7e0+u5i0EbmM5QIq6etLik0=;
  b=JvTOm0YN94I0zWfW7aDRVtVXa0MnXxHCopL5qrA8+OOnDMaFzs+TkDCb
   jxe4MqG2rxmvsQ2oMBCr/v2TOp5qje081Si42pPPIGzHYk4cT08E9rFFY
   9U40aH8DV6OatOKtPc3pS5nJVKhJkvviRedlxwVtVu4+2U7Ybw6RQqXbc
   kYP3zANWLxxwaHMAk8aaD/v2tdP1sfEXOOQhJ02fJKrrGqaf0fb66KzqX
   hQBRh5H2XxF+RweYSnJYkp1FAfiXBs6r7COipR72lV+pyifauGrQWouQ4
   9N/p4x0wC8cebCWbQ5cFco5kGYvFbDRV8MJ1lfKlNqryvCuHFZP1GEDlj
   g==;
X-IronPort-AV: E=Sophos;i="5.95,235,1661810400"; 
   d="scan'208";a="27127502"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 03 Nov 2022 09:25:12 +0100
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Thu, 03 Nov 2022 09:25:12 +0100
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Thu, 03 Nov 2022 09:25:12 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1667463912; x=1698999912;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2r8XOQHsUrbaJSTuWBrN7e0+u5i0EbmM5QIq6etLik0=;
  b=PK67dABSA8JXGS8ZUFkoi7t0r+o5ZxlBdZumbVGIarUiLJdKF38KPsYn
   aaoERMSuxRSqfR3ne8XCbe73S9XoFj8c24gcem7xaCqPkmylZQfM0tfqG
   OcPWBE/k+GeSlH26Zz42qXnKNAYe7piJcXCFd//dqLlXy32vzueMcWUzM
   59qFrh5U6eyLZsF844qQKBCXC98MRGrUX2nClUNqEhZpB7OA9eWnn5iid
   r5KAT+Sy72gGAyFLbSoBZYe3b4qvlJrECbdHrOP2PsngPhvZEeGmFrm42
   qoM/o3rbELmIpJ7T/93oxIrjHlMwn1ErLG7xV847Gi1bW1uFJr9slTjK+
   w==;
X-IronPort-AV: E=Sophos;i="5.95,235,1661810400"; 
   d="scan'208";a="27127501"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 03 Nov 2022 09:25:11 +0100
Received: from steina-w.localnet (unknown [10.123.53.21])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id AFC42280056;
        Thu,  3 Nov 2022 09:25:11 +0100 (CET)
From:   Alexander Stein <alexander.stein@ew.tq-group.com>
To:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Marek Vasut <marex@denx.de>
Cc:     linux-pci@vger.kernel.org, Fabio Estevam <festevam@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Richard Zhu <hongxing.zhu@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        NXP Linux Team <linux-imx@nxp.com>,
        Marek Vasut <marex@denx.de>
Subject: Re: [PATCH 1/3] dt-bindings: imx6q-pcie: Handle various clock configurations
Date:   Thu, 03 Nov 2022 09:25:12 +0100
Message-ID: <7630472.EvYhyI6sBW@steina-w>
Organization: TQ-Systems GmbH
In-Reply-To: <20221102215729.147335-1-marex@denx.de>
References: <20221102215729.147335-1-marex@denx.de>
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

Am Mittwoch, 2. November 2022, 22:57:27 CET schrieb Marek Vasut:
> The i.MX SoCs have various clock configurations routed into the PCIe IP,
> the list of clock is below. Document all those configurations in the DT
> binding document.
> 
> All SoCs: pcie, pcie_bus
> 6QDL, 7D: + pcie_phy
> 6SX:      + pcie_phy          pcie_inbound_axi
> 8MQ:      + pcie_phy pcie_aux
> 8MM, 8MP: +          pcie_aux
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
>  .../bindings/pci/fsl,imx6q-pcie.yaml          | 74 +++++++++++++++++--
>  1 file changed, 69 insertions(+), 5 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
> b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml index
> 376e739bcad40..1cfea8ca72576 100644
> --- a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
> +++ b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
> @@ -14,9 +14,6 @@ description: |+
>    This PCIe host controller is based on the Synopsys DesignWare PCIe IP
>    and thus inherits all the common properties defined in snps,dw-pcie.yaml.
> 
> -allOf:
> -  - $ref: /schemas/pci/snps,dw-pcie.yaml#
> -
>  properties:
>    compatible:
>      enum:
> @@ -60,8 +57,8 @@ properties:
>      items:
>        - const: pcie
>        - const: pcie_bus
> -      - const: pcie_phy
> -      - const: pcie_inbound_axi for imx6sx-pcie, pcie_aux for imx8mq-pcie
> +      - enum: [pcie_phy, pcie_aux]
> +      - enum: [pcie_inbound_axi, pcie_aux]
> 
>    num-lanes:
>      const: 1
> @@ -177,6 +174,73 @@ required:
> 
>  unevaluatedProperties: false
> 
> +allOf:
> +  - $ref: /schemas/pci/snps,dw-pcie.yaml#
> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - fsl,imx6sx-pcie
> +              - fsl,imx8mq-pcie
> +    then:
> +      properties:
> +        clocks:
> +          maxItems: 4
> +        clock-names:
> +          maxItems: 4
> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: fsl,imx6sx-pcie
> +    then:
> +      properties:
> +        clock-names:
> +          items:
> +            - const: pcie
> +            - const: pcie_bus
> +            - const: pcie_phy
> +            - const: pcie_inbound_axi
> +    else:
> +      if:
> +        properties:
> +          compatible:
> +            contains:
> +              const: fsl,imx8mq-pcie
> +      then:
> +        properties:
> +          clock-names:
> +            items:
> +              - const: pcie
> +              - const: pcie_bus
> +              - const: pcie_phy
> +              - const: pcie_aux
> +      else:
> +        if:
> +          properties:
> +            compatible:
> +              contains:
> +                enum:
> +                  - fsl,imx8mm-pcie
> +                  - fsl,imx8mp-pcie
> +        then:
> +          properties:
> +            clock-names:
> +              items:
> +                - const: pcie
> +                - const: pcie_bus
> +                - const: pcie_aux
> +        else:
> +          properties:
> +            clock-names:
> +              items:
> +                - const: pcie
> +                - const: pcie_bus
> +                - const: pcie_phy
> +
>  examples:
>    - |
>      #include <dt-bindings/clock/imx6qdl-clock.h>

Acked-by: Alexander Stein <alexander.stein@ew.tq-group.com>


