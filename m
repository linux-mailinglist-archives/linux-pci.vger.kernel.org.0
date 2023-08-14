Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C65F77B9A2
	for <lists+linux-pci@lfdr.de>; Mon, 14 Aug 2023 15:20:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230171AbjHNNUH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 14 Aug 2023 09:20:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230340AbjHNNTo (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 14 Aug 2023 09:19:44 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AACB312D;
        Mon, 14 Aug 2023 06:19:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1692019178; x=1723555178;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=4yeKTYqAjpez7eQcNgoLipzdYDL2hK98LTipXnuNLpI=;
  b=taMwmPp8ioAAkS0/TE4bIGuANfqnxbuRziIDO9tZpvheKD2+hO7JDSWS
   u+pdtyUfg4avUo2eSS5BfHrhdrQJ/xdE1El/qbTZlC4k3XNolCvBLzsNG
   Tn0gA2S17NiUdtXQjQhoxfxeCcuNKTIMsL8iU76R1nGACsP8GFs+olm+p
   JwIs9WgjgU7pFXWlJJQuoguYqWscDCjdJNSdZSWQ3aiweOKQp24dFhkCB
   L+TjMhPnrXE8iDXP2LLzaGoftYHTtHQVExZBA/BwP2QcGJnOVIM4WvAQ9
   2zCzQS8nvpJOlK+1TkXQW6P1OZRw6Q4ITgeVmm8PG8q7xp0uXlvnuJ6js
   Q==;
X-IronPort-AV: E=Sophos;i="6.01,172,1684825200"; 
   d="asc'?scan'208";a="241504570"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 14 Aug 2023 06:19:37 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 14 Aug 2023 06:19:37 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Mon, 14 Aug 2023 06:19:33 -0700
Date:   Mon, 14 Aug 2023 14:18:55 +0100
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Minda Chen <minda.chen@starfivetech.com>
CC:     Daire McNamara <daire.mcnamara@microchip.com>,
        Conor Dooley <conor@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>, <linux-pci@vger.kernel.org>,
        Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Mason Huo <mason.huo@starfivetech.com>,
        Leyfoon Tan <leyfoon.tan@starfivetech.com>,
        Kevin Xie <kevin.xie@starfivetech.com>
Subject: Re: [PATCH v3 09/11] dt-bindings: PCI: Add StarFive JH7110 PCIe
 controller
Message-ID: <20230814-ladies-duckbill-953f13b03e71@wendy>
References: <20230814082016.104181-1-minda.chen@starfivetech.com>
 <20230814082016.104181-10-minda.chen@starfivetech.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Sqa5jIzCxeaGhRmV"
Content-Disposition: inline
In-Reply-To: <20230814082016.104181-10-minda.chen@starfivetech.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

--Sqa5jIzCxeaGhRmV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 14, 2023 at 04:20:14PM +0800, Minda Chen wrote:
> Add StarFive JH7110 SoC PCIe controller dt-bindings.
> JH7110 using PLDA XpressRICH PCIe host controller IP.
>=20
> Signed-off-by: Minda Chen <minda.chen@starfivetech.com>
> Reviewed-by: Hal Feng <hal.feng@starfivetech.com>

This looks good to me now, thanks.
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

> ---
>  .../bindings/pci/starfive,jh7110-pcie.yaml    | 120 ++++++++++++++++++
>  1 file changed, 120 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pci/starfive,jh7110=
-pcie.yaml
>=20
> diff --git a/Documentation/devicetree/bindings/pci/starfive,jh7110-pcie.y=
aml b/Documentation/devicetree/bindings/pci/starfive,jh7110-pcie.yaml
> new file mode 100644
> index 000000000000..67151aaa3948
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pci/starfive,jh7110-pcie.yaml
> @@ -0,0 +1,120 @@
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
> +  - $ref: plda,xpressrich3-axi-common.yaml#
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
> +    description:
> +      The phandle to System Register Controller syscon node.
> +
> +  perst-gpios:
> +    description: GPIO controlled connection to PERST# signal
> +    maxItems: 1
> +
> +  phys:
> +    description:
> +      Specified PHY is attached to PCIe controller.
> +    maxItems: 1
> +
> +required:
> +  - clocks
> +  - resets
> +  - starfive,stg-syscon
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
> +        pcie@940000000 {
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
> +            starfive,stg-syscon =3D <&stg_syscon>;
> +            bus-range =3D <0x0 0xff>;
> +            interrupt-parent =3D <&plic>;
> +            interrupts =3D <56>;
> +            interrupt-map-mask =3D <0x0 0x0 0x0 0x7>;
> +            interrupt-map =3D <0x0 0x0 0x0 0x1 &pcie_intc0 0x1>,
> +                            <0x0 0x0 0x0 0x2 &pcie_intc0 0x2>,
> +                            <0x0 0x0 0x0 0x3 &pcie_intc0 0x3>,
> +                            <0x0 0x0 0x0 0x4 &pcie_intc0 0x4>;
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
> +            perst-gpios =3D <&gpios 26 GPIO_ACTIVE_LOW>;
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

--Sqa5jIzCxeaGhRmV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZNopvgAKCRB4tDGHoIJi
0iSHAQDMRNa7PWUFYKq79mqAOecblr9dEMDz58gNXKX6SU2A5AEA7dPaFdMe0sZv
m5zURgaysbaf4Ap+PX4LTjFyAegQoQI=
=/IdZ
-----END PGP SIGNATURE-----

--Sqa5jIzCxeaGhRmV--
