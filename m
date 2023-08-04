Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7231E76FAD6
	for <lists+linux-pci@lfdr.de>; Fri,  4 Aug 2023 09:11:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234163AbjHDHLv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 4 Aug 2023 03:11:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234184AbjHDHLb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 4 Aug 2023 03:11:31 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A32D1713;
        Fri,  4 Aug 2023 00:11:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1691133086; x=1722669086;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+s9qRet6tPrj/OpzOYkhaF1D+Vqrsl5l9yFKErU+JTc=;
  b=OA2Nobe+dSsEytXO01uycF+2gpn4cRP11m8n1b54Rcv21Vj9X2HuEPjo
   TqHOGFJYw5/nB6oFFh/QOvUf82DP6c5YKR8vpDiTYkdEr9VWaSJsGmWzr
   BueWyWJ++0gY3uXF+iFQU+SsrC0I6yYzAZ86wg1UpiPeODjwQKR7b33V5
   b1nQtt4keyhvh5ykL3eDdR2VniFJCb3SnDCwHGkcxws6CzjWhdELZHtPW
   +utlSR1Xyi2EE1QgEBRUojs5Q65r+cATXRvsFg9Z8mgokLGR/rE902GVE
   lyxbE9MAP3OeQiBENJKPcxj3WvA5lsYghJm2gtIJetiafxrTBIAELctqI
   Q==;
X-IronPort-AV: E=Sophos;i="6.01,254,1684825200"; 
   d="asc'?scan'208";a="239767328"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 04 Aug 2023 00:11:24 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 4 Aug 2023 00:11:24 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Fri, 4 Aug 2023 00:11:22 -0700
Date:   Fri, 4 Aug 2023 08:10:45 +0100
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Minda Chen <minda.chen@starfivetech.com>
CC:     Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Daire McNamara <daire.mcnamara@microchip.com>,
        Conor Dooley <conor@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pci@vger.kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Mason Huo <mason.huo@starfivetech.com>,
        Leyfoon Tan <leyfoon.tan@starfivetech.com>,
        Kevin Xie <kevin.xie@starfivetech.com>
Subject: Re: [PATCH v2 3/4] dt-bindings: PCI: Add StarFive JH7110 PCIe
 controller
Message-ID: <20230804-irregular-distrust-c5d46afe3d9c@wendy>
References: <20230727103949.26149-1-minda.chen@starfivetech.com>
 <20230727103949.26149-4-minda.chen@starfivetech.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="cdGNq5+PX24zOdzQ"
Content-Disposition: inline
In-Reply-To: <20230727103949.26149-4-minda.chen@starfivetech.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

--cdGNq5+PX24zOdzQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 27, 2023 at 06:39:48PM +0800, Minda Chen wrote:
> Add StarFive JH7110 SoC PCIe controller dt-bindings.
> JH7110 using PLDA XpressRICH PCIe host controller IP.
>=20
> Signed-off-by: Minda Chen <minda.chen@starfivetech.com>
> Reviewed-by: Hal Feng <hal.feng@starfivetech.com>
> ---
>  .../bindings/pci/starfive,jh7110-pcie.yaml    | 133 ++++++++++++++++++
>  1 file changed, 133 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pci/starfive,jh7110=
-pcie.yaml
>=20
> diff --git a/Documentation/devicetree/bindings/pci/starfive,jh7110-pcie.y=
aml b/Documentation/devicetree/bindings/pci/starfive,jh7110-pcie.yaml
> new file mode 100644
> index 000000000000..9273e029fb20
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pci/starfive,jh7110-pcie.yaml
> @@ -0,0 +1,133 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/pci/starfive,jh7110-pcie.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: StarFive JH7110 PCIe host controller
> +
> +maintainers:
> +  - Kevin Xie <kevin.xie@starfivetech.com>
> +
> +allOf:
> +  - $ref: /schemas/pci/pci-bus.yaml#
> +  - $ref: plda,xpressrich3-axi-common.yaml#
> +  - $ref: /schemas/interrupt-controller/msi-controller.yaml#
> +  - $ref: /schemas/gpio/gpio-consumer-common.yaml#
> +
> +properties:
> +  compatible:
> +    const: starfive,jh7110-pcie
> +
> +  clocks:
> +    items:
> +      - description: NOC bus clock
> +      - description: Transport layer clock
> +      - description: AXI MST0 clock
> +      - description: APB clock
> +
> +  clock-names:
> +    items:
> +      - const: noc
> +      - const: tl
> +      - const: axi_mst0
> +      - const: apb
> +
> +  resets:
> +    items:
> +      - description: AXI MST0 reset
> +      - description: AXI SLAVE0 reset
> +      - description: AXI SLAVE reset
> +      - description: PCIE BRIDGE reset
> +      - description: PCIE CORE reset
> +      - description: PCIE APB reset
> +
> +  reset-names:
> +    items:
> +      - const: mst0
> +      - const: slv0
> +      - const: slv
> +      - const: brg
> +      - const: core
> +      - const: apb
> +
> +  starfive,stg-syscon:
> +    $ref: /schemas/types.yaml#/definitions/phandle-array
> +    items:
> +      - items:
> +          - description: phandle to System Register Controller stg_sysco=
n node.
> +          - description: register0 offset of STG_SYSCONSAIF__SYSCFG regi=
ster for PCIe.
> +          - description: register1 offset of STG_SYSCONSAIF__SYSCFG regi=
ster for PCIe.
> +          - description: register2 offset of STG_SYSCONSAIF__SYSCFG regi=
ster for PCIe.
> +          - description: register3 offset of STG_SYSCONSAIF__SYSCFG regi=
ster for PCIe.
> +    description:
> +      The phandle to System Register Controller syscon node and the offs=
et
> +      of STG_SYSCONSAIF__SYSCFG register for PCIe. Total 4 regsisters of=
fset
> +      for PCIe.

These property names tie them closely with naming on the jh7110, but
there's little value in specifying all of these offsets when you have
one implementation where they are all fixed.
Do you know what the jh81xx stuff is going to do yet w.r.t. PCI and if
so, how could you reuse this property?
Particularly, saying "register 0" seems unlikely to transfer well
between SoCs.
I'd be inclined to drop the offsets entirely & rely on match data to
provide them if needed in the future.

> +
> +  phys:
> +    description:
> +      Specified PHY is attached to PCIe controller.
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - clocks
> +  - resets
> +  - starfive,stg-syscon
> +  - "#interrupt-cells"
> +  - interrupt-map-mask
> +  - interrupt-map
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +    soc {
> +        #address-cells =3D <2>;
> +        #size-cells =3D <2>;
> +
> +        pcie0: pcie@2b000000 {

nit: you don't need labels in examples if they are not referenced
anywhere.

Otherwise, this looks good to me.

Thanks,
Conor.

> +            compatible =3D "starfive,jh7110-pcie";
> +            reg =3D <0x9 0x40000000 0x0 0x10000000>,
> +                  <0x0 0x2b000000 0x0 0x1000000>;
> +            reg-names =3D "cfg", "apb";
> +            #address-cells =3D <3>;
> +            #size-cells =3D <2>;
> +            #interrupt-cells =3D <1>;
> +            device_type =3D "pci";
> +            ranges =3D <0x82000000  0x0 0x30000000  0x0 0x30000000 0x0 0=
x08000000>,
> +                     <0xc3000000  0x9 0x00000000  0x9 0x00000000 0x0 0x4=
0000000>;
> +            starfive,stg-syscon =3D <&stg_syscon 0xc0 0xc4 0x130 0x1b8>;
> +            bus-range =3D <0x0 0xff>;
> +            interrupt-parent =3D <&plic>;
> +            interrupts =3D <56>;
> +            interrupt-map-mask =3D <0x0 0x0 0x0 0x7>;
> +            interrupt-map =3D <0x0 0x0 0x0 0x1 &pcie_intc0 0x1>,
> +                            <0x0 0x0 0x0 0x2 &pcie_intc0 0x2>,
> +                            <0x0 0x0 0x0 0x3 &pcie_intc0 0x3>,
> +                            <0x0 0x0 0x0 0x4 &pcie_intc0 0x4>;
> +            msi-parent =3D <&pcie0>;
> +            msi-controller;
> +            clocks =3D <&syscrg 86>,
> +                     <&stgcrg 10>,
> +                     <&stgcrg 8>,
> +                     <&stgcrg 9>;
> +            clock-names =3D "noc", "tl", "axi_mst0", "apb";
> +            resets =3D <&stgcrg 11>,
> +                     <&stgcrg 12>,
> +                     <&stgcrg 13>,
> +                     <&stgcrg 14>,
> +                     <&stgcrg 15>,
> +                     <&stgcrg 16>;
> +            reset-gpios =3D <&gpios 26 GPIO_ACTIVE_LOW>;
> +            phys =3D <&pciephy0>;
> +
> +            pcie_intc0: interrupt-controller {
> +                #address-cells =3D <0>;
> +                #interrupt-cells =3D <1>;
> +                interrupt-controller;
> +            };
> +        };
> +    };
> --=20
> 2.17.1
>=20

--cdGNq5+PX24zOdzQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZMykdQAKCRB4tDGHoIJi
0urtAQD+uAgwanWF3tcw70mUXOMX9M4WA3VagkD+PyGR6DrfIgEAxZ+jsQ6U+nqg
RUrPskxjjmhKcthPEpbSDMucTKvZgws=
=ayX+
-----END PGP SIGNATURE-----

--cdGNq5+PX24zOdzQ--
