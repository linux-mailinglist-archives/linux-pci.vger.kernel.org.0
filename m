Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 944376FA21A
	for <lists+linux-pci@lfdr.de>; Mon,  8 May 2023 10:24:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233079AbjEHIYV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 8 May 2023 04:24:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233009AbjEHIXv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 8 May 2023 04:23:51 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C85D1CFDA;
        Mon,  8 May 2023 01:23:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1683534230; x=1715070230;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=hlyuFLKeGB1+i6aF1UQOhgZD24UMcmO95zWntN5xZBE=;
  b=2dPFf8klo8fVOzWvSGpVH7NYhDq34oITCnJxboSbxuDVxplP5pGD76+M
   kYgfbjYKbLUPIjv2yWhF3kx8Xp6RggbPqy18XCJ/ajn7N4gqeS36e/v2y
   /QNetmERCtE6YkZNBtVKDly5J+lQPD4pfUqLJbE3K3kwrKqyP2OzvSuvE
   U+3+SA8iSf3cDq+eJ2RT4BUSwfAoQSL3b6HKyEOCNqtg48s4RLUWWzs0C
   HiO0LfMlTZbZoUhVjHCMQ7QKcr18Soabp0RwryZJNeXRq8FHOUYg9S+A+
   9T0FZI0BQFUFXPNemFSK29Mv0vMQcIAJtvFXg9RHJF6/V2U6G6YLcPlU/
   Q==;
X-IronPort-AV: E=Sophos;i="5.99,258,1677567600"; 
   d="asc'?scan'208";a="224279113"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 08 May 2023 01:23:48 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 8 May 2023 01:23:48 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Mon, 8 May 2023 01:23:45 -0700
Date:   Mon, 8 May 2023 09:23:26 +0100
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
CC:     Richard Zhu <hongxing.zhu@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        <linux-pci@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH fixes] dt-bindings: PCI: fsl,imx6q: fix assigned-clocks
 warning
Message-ID: <20230508-purely-radar-8fb16747ba60@wendy>
References: <20230508071837.68552-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="QtB+N7QIRkmC4l2w"
Content-Disposition: inline
In-Reply-To: <20230508071837.68552-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

--QtB+N7QIRkmC4l2w
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 08, 2023 at 09:18:37AM +0200, Krzysztof Kozlowski wrote:
> @@ -49,6 +62,31 @@ required:
>  allOf:
>    - $ref: /schemas/pci/snps,dw-pcie-ep.yaml#
>    - $ref: /schemas/pci/fsl,imx6q-pcie-common.yaml#
> +  - if:
> +      properties:
> +        compatible:
> +          enum:
> +            - fsl,imx8mq-pcie-ep

How come this is enum rather than const (and same for the other
single-compatible ones below)?

Cheers,
Conor.

> +    then:
> +      properties:
> +        clocks:
> +          minItems: 4
> +        clock-names:
> +          items:
> +            - const: pcie
> +            - const: pcie_bus
> +            - const: pcie_phy
> +            - const: pcie_aux
> +    else:
> +      properties:
> +        clocks:
> +          maxItems: 3
> +        clock-names:
> +          items:
> +            - const: pcie
> +            - const: pcie_bus
> +            - const: pcie_aux
> +
> =20
>  unevaluatedProperties: false
> =20
> diff --git a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml b/=
Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
> index 2443641754d3..81bbb8728f0f 100644
> --- a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
> +++ b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
> @@ -40,6 +40,19 @@ properties:
>        - const: dbi
>        - const: config
> =20
> +  clocks:
> +    minItems: 3
> +    items:
> +      - description: PCIe bridge clock.
> +      - description: PCIe bus clock.
> +      - description: PCIe PHY clock.
> +      - description: Additional required clock entry for imx6sx-pcie,
> +           imx6sx-pcie-ep, imx8mq-pcie, imx8mq-pcie-ep.
> +
> +  clock-names:
> +    minItems: 3
> +    maxItems: 4
> +
>    interrupts:
>      items:
>        - description: builtin MSI controller.
> @@ -77,6 +90,70 @@ required:
>  allOf:
>    - $ref: /schemas/pci/snps,dw-pcie.yaml#
>    - $ref: /schemas/pci/fsl,imx6q-pcie-common.yaml#
> +  - if:
> +      properties:
> +        compatible:
> +          enum:
> +            - fsl,imx6sx-pcie
> +    then:
> +      properties:
> +        clocks:
> +          minItems: 4
> +        clock-names:
> +          items:
> +            - const: pcie
> +            - const: pcie_bus
> +            - const: pcie_phy
> +            - const: pcie_inbound_axi
> +
> +  - if:
> +      properties:
> +        compatible:
> +          enum:
> +            - fsl,imx8mq-pcie
> +    then:
> +      properties:
> +        clocks:
> +          minItems: 4
> +        clock-names:
> +          items:
> +            - const: pcie
> +            - const: pcie_bus
> +            - const: pcie_phy
> +            - const: pcie_aux
> +
> +  - if:
> +      properties:
> +        compatible:
> +          enum:
> +            - fsl,imx6q-pcie
> +            - fsl,imx6qp-pcie
> +            - fsl,imx7d-pcie
> +    then:
> +      properties:
> +        clocks:
> +          maxItems: 3
> +        clock-names:
> +          items:
> +            - const: pcie
> +            - const: pcie_bus
> +            - const: pcie_phy
> +
> +  - if:
> +      properties:
> +        compatible:
> +          enum:
> +            - fsl,imx8mm-pcie
> +            - fsl,imx8mp-pcie
> +    then:
> +      properties:
> +        clocks:
> +          maxItems: 3
> +        clock-names:
> +          items:
> +            - const: pcie
> +            - const: pcie_bus
> +            - const: pcie_aux
> =20
>  unevaluatedProperties: false
> =20
> --=20
> 2.34.1
>=20

--QtB+N7QIRkmC4l2w
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZFixcAAKCRB4tDGHoIJi
0hl7AP4x1NzK+26z63yAD+Pl99r+yAFmNg1IKq8KmxhVMOHLZwD/c2HvdUBgj+A/
VXIO5d2wSOFSW0nWqet8dkJfD9Aw2w4=
=vPiN
-----END PGP SIGNATURE-----

--QtB+N7QIRkmC4l2w--
