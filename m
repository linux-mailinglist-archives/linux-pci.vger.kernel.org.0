Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F0906191BC
	for <lists+linux-pci@lfdr.de>; Fri,  4 Nov 2022 08:19:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231374AbiKDHTP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 4 Nov 2022 03:19:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231485AbiKDHTO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 4 Nov 2022 03:19:14 -0400
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6819B27916;
        Fri,  4 Nov 2022 00:19:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1667546351; x=1699082351;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=R0yqydx+O0k9fNWZ/yQ6A//nOTWddN8lKx5pQ56sZaE=;
  b=mZmkaVMU820Yj4KEhi0/wPsusxBdxKHW7r+DQkvNPfKkFaYwhuR35obi
   JQw4zd4pwRfZrtYzll2AeBXtmT9ukDe1ZAC8yBHdSkNh3CH0fUjFGCAcy
   39sNFqUYLb9dHbkoL99dArO+w5ybA+08aXGfCxThcWfoANDH8L47rpJ+d
   X5AG6QoHqaF6xwt+u/D9AiSM/W9lB1qW/BXhIuZdf/QRs9rDt8EPiCWCw
   iEZy7ioI84lEpu88QzvwKoicacwezSVEUQj8Ih7zA/pXPyDfyux56vt5i
   +YHe52qbL1hwvpKv3Xv7EyOvWjmrVzlCBg4w6ta3N3C1wcq6yVbc0NqZG
   g==;
X-IronPort-AV: E=Sophos;i="5.96,136,1665439200"; 
   d="scan'208";a="27152894"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 04 Nov 2022 08:19:09 +0100
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Fri, 04 Nov 2022 08:19:09 +0100
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Fri, 04 Nov 2022 08:19:09 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1667546349; x=1699082349;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=R0yqydx+O0k9fNWZ/yQ6A//nOTWddN8lKx5pQ56sZaE=;
  b=GPU2bH14o3c1W9hVrUhcDtrfAicaIZrm06ry+nrOydTQXiJYB7AkJxJ3
   1EF+NSzpUxgsjqypq8gNeFReUY+2Moygbgtg+RscNvYrqJGSd7kRdRJir
   eqiEUa6IoNO+Jhgf3ndISeKomjD8I8OqvwcykNHKsv/wZsp4ZVp57D+cB
   kOXB4kMcMbDi1a5Zofv3OLpKUJCkpvd0sXDFvRWyxOEKwCcnn1Qt5SuVP
   a5836qGcHHBauUxAdjXCbSkvld6S2Y0Z70FwHSRj0xmrFPjhqu/EmCaE0
   FgwVDj0nTWhVoafTc6+PWstA4ErQ+HnTJHQYHdtxQJ07gf2BDsQYxK44s
   w==;
X-IronPort-AV: E=Sophos;i="5.96,136,1665439200"; 
   d="scan'208";a="27152893"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 04 Nov 2022 08:19:09 +0100
Received: from steina-w.localnet (unknown [10.123.53.21])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id A1596280056;
        Fri,  4 Nov 2022 08:19:08 +0100 (CET)
From:   Alexander Stein <alexander.stein@ew.tq-group.com>
To:     Marek Vasut <marex@denx.de>
Cc:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
        Fabio Estevam <festevam@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Richard Zhu <hongxing.zhu@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>
Subject: Re: [PATCH 2/3] dt-bindings: imx6q-pcie: Handle various PD configurations
Date:   Fri, 04 Nov 2022 08:19:07 +0100
Message-ID: <2911185.BEx9A2HvPv@steina-w>
Organization: TQ-Systems GmbH
In-Reply-To: <2908d3ff-f476-4750-90cf-1554492c69c9@denx.de>
References: <20221102215729.147335-1-marex@denx.de> <CAL_JsqLg893rWwEQhgf_9=78WNiA7bstqPVvP6SQe4SyAhhyUw@mail.gmail.com> <2908d3ff-f476-4750-90cf-1554492c69c9@denx.de>
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

Am Donnerstag, 3. November 2022, 17:25:46 CET schrieb Marek Vasut:
> On 11/3/22 13:32, Rob Herring wrote:
> > On Thu, Nov 3, 2022 at 3:29 AM Alexander Stein
> > 
> > <alexander.stein@ew.tq-group.com> wrote:
> >> Hi Marek,
> >> 
> >> Am Mittwoch, 2. November 2022, 22:57:28 CET schrieb Marek Vasut:
> >>> The i.MX SoCs have various power domain configurations routed into
> >>> the PCIe IP. MX6SX is the only one which contains 2 domains and also
> >>> uses power-domain-names. MX6QDL do not use any domains. All the rest
> >>> uses one domain and does not use power-domain-names anymore.
> >>> 
> >>> Document all those configurations in the DT binding document.
> >>> 
> >>> Signed-off-by: Marek Vasut <marex@denx.de>
> >>> ---
> >>> Cc: Fabio Estevam <festevam@gmail.com>
> >>> Cc: Lucas Stach <l.stach@pengutronix.de>
> >>> Cc: Richard Zhu <hongxing.zhu@nxp.com>
> >>> Cc: Rob Herring <robh+dt@kernel.org>
> >>> Cc: Shawn Guo <shawnguo@kernel.org>
> >>> Cc: linux-arm-kernel@lists.infradead.org
> >>> Cc: NXP Linux Team <linux-imx@nxp.com>
> >>> To: devicetree@vger.kernel.org
> >>> ---
> >>> 
> >>>   .../bindings/pci/fsl,imx6q-pcie.yaml          | 47 ++++++++++++++-----
> >>>   1 file changed, 34 insertions(+), 13 deletions(-)
> >>> 
> >>> diff --git a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
> >>> b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml index
> >>> 1cfea8ca72576..fc8d4d7b80b38 100644
> >>> --- a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
> >>> +++ b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
> >>> 
> >>> @@ -68,19 +68,6 @@ properties:
> >>>       description: A phandle to an fsl,imx7d-pcie-phy node. Additional
> >>>       
> >>>         required properties for imx7d-pcie and imx8mq-pcie.
> >>> 
> >>> -  power-domains:
> >>> -    items:
> >>> -      - description: The phandle pointing to the DISPLAY domain for
> >>> -          imx6sx-pcie, to PCIE_PHY power domain for imx7d-pcie and
> >>> -          imx8mq-pcie.
> >>> -      - description: The phandle pointing to the PCIE_PHY power domains
> >>> -          for imx6sx-pcie.
> >>> -
> >>> -  power-domain-names:
> >>> -    items:
> >>> -      - const: pcie
> >>> -      - const: pcie_phy
> >>> -
> >>> 
> >>>     resets:
> >>>       maxItems: 3
> >>>       description: Phandles to PCIe-related reset lines exposed by SRC
> >>> 
> >>> @@ -241,6 +228,40 @@ allOf:
> >>>                   - const: pcie_bus
> >>>                   - const: pcie_phy
> >>> 
> >>> +  - if:
> >>> +      properties:
> >>> +        compatible:
> >>> +          contains:
> >>> +            const: fsl,imx6sx-pcie
> >>> +    then:
> >>> +      properties:
> >>> +        power-domains:
> >>> +          items:
> >>> +            - description: The phandle pointing to the DISPLAY domain
> >>> for
> >>> +                imx6sx-pcie, to PCIE_PHY power domain for imx7d-pcie
> >>> and
> >>> +                imx8mq-pcie.
> >>> +            - description: The phandle pointing to the PCIE_PHY power
> >>> domains +                for imx6sx-pcie.
> >>> +        power-domain-names:
> >>> +          items:
> >>> +            - const: pcie
> >>> +            - const: pcie_phy
> >>> +    else:
> >>> +      if:
> >>> +        not:
> >>> +          properties:
> >>> +            compatible:
> >>> +              contains:
> >>> +                enum:
> >>> +                  - fsl,imx6q-pcie
> >>> +                  - fsl,imx6qp-pcie
> >>> +      then:
> >>> +        properties:
> >>> +          power-domains:
> >>> +            description: |
> >>> +               The phandle pointing to the DISPLAY domain for
> >>> imx6sx-pcie,
> >>> to +               PCIE_PHY power domain for imx7d-pcie and imx8mq-pcie.
> >>> +
> >> 
> >> Doesn't it makes more sense to keep the power-domains descriptions in the
> >> common part on top, as before, but adjust minItems/maxItems for each
> >> compatible?
> > 
> > Yes. Keep properties defined at the top level.
> 
> The problem I keep running into here is that if I apply patch like below
> (basically what you and Alex are suggesting), I get this warning:
> 
> arch/arm64/boot/dts/freescale/imx8mm-board.dtb: pcie@33800000:
> power-domains: [[86]] is too short

I guess you need this:
> --- a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
> +++ b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
@@ -65,6 +65,7 @@ properties:
       required properties for imx7d-pcie and imx8mq-pcie.
 
   power-domains:
+    minItems: 1
     items:
       - description: The phandle pointing to the DISPLAY domain for
           imx6sx-pcie, to PCIE_PHY power domain for imx7d-pcie and

I have a similar WIP change on my tree which add 'minItems: 1' to power-
domains and also sets 'maxItems: 1' to power-domains for everything being not 
fsl,imx6sx-pcie.

Best regards,
Alexander

> I think that's because power-domains: contains items: and to validate
> that imx8mm.dtsi with pcie@33800000 { power-domains = <&pgc_pcie>; };, I
> would need to get rid of those items: ? Which is what I did in the
> aforementioned patch for imx8m, that's why I removed it from the common
> part.
> 
> diff --git a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
> b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
> index 12c7baba489aa..ec5e8dfe541ea 100644
> --- a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
> +++ b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
> @@ -68,6 +68,18 @@ properties:
>       description: A phandle to an fsl,imx7d-pcie-phy node. Additional
>         required properties for imx7d-pcie and imx8mq-pcie.
> 
> +  power-domains:
> +    items:
> +      - description: The phandle pointing to the DISPLAY domain for
> +          imx6sx-pcie, to PCIE_PHY power domain for imx7d-pcie and
> +          imx8mq-pcie.
> +      - description: The phandle pointing to the PCIE_PHY power domains
> +          for imx6sx-pcie.
> +  power-domain-names:
> +    items:
> +      - const: pcie
> +      - const: pcie_phy
> +
>     resets:
>       maxItems: 2
>       description: Phandles to PCIe-related reset lines exposed by SRC
> @@ -235,16 +247,11 @@ allOf:
>       then:
>         properties:
>           power-domains:
> -          items:
> -            - description: The phandle pointing to the DISPLAY domain for
> -                imx6sx-pcie, to PCIE_PHY power domain for imx7d-pcie and
> -                imx8mq-pcie.
> -            - description: The phandle pointing to the PCIE_PHY power
> domains
> -                for imx6sx-pcie.
> +          minItems: 2
> +          maxItems: 2
>           power-domain-names:
> -          items:
> -            - const: pcie
> -            - const: pcie_phy
> +          minItems: 2
> +          maxItems: 2
>       else:
>         if:
>           not:
> @@ -257,9 +264,8 @@ allOf:
>         then:
>           properties:
>             power-domains:
> -            description: |
> -               The phandle pointing to the DISPLAY domain for
> imx6sx-pcie, to
> -               PCIE_PHY power domain for imx7d-pcie and imx8mq-pcie.
> +            minItems: 1
> +            maxItems: 1
> 
>     - if:
>         properties:




