Return-Path: <linux-pci+bounces-22009-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 848A1A3FCA1
	for <lists+linux-pci@lfdr.de>; Fri, 21 Feb 2025 18:03:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4C5957AB105
	for <lists+linux-pci@lfdr.de>; Fri, 21 Feb 2025 17:00:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CE5124397C;
	Fri, 21 Feb 2025 17:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K7y4Lsqx"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0C301EF08D;
	Fri, 21 Feb 2025 17:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740157308; cv=none; b=eiHm46doM3DU1K6LDjZMUXAQdEeMA39nRS4tczs9cPxXEWo0KC4kE12OO3JNjEcbZ0EbmqIMU3gahIx8RSIvyk2nNusMqp9LbHyNaIXScmVMrrTQ5LDLRMjDBNb1MGmHoU3YHAFTkJK4WfArxnlImk6jr6wsaHxRNfhrm3j7AWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740157308; c=relaxed/simple;
	bh=Nm2OwrU5Opm62TA7+IMK61wEIcI9SxvvGpqljE9y1TY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aFCwei4EK6pL5NOquqw10pXt8vWIPW6L/IcP/2lvNlJglBR+1WhUG85Y9SvkSzGZDJ0cdNWFkiRpYesDNYEM/Jrm5L1p6AWPAx7qRs5BjsrLIz1FUjym+phZxhWvuQyub8o8akMH0KS82u7mADzcJIK7VZcVin0lNLPGE20PKf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K7y4Lsqx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC0ECC4CED6;
	Fri, 21 Feb 2025 17:01:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740157307;
	bh=Nm2OwrU5Opm62TA7+IMK61wEIcI9SxvvGpqljE9y1TY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=K7y4Lsqx4BYbpTnKHQfGDsoec/J3KB9jvHrvPrk2znKHh4QoRv/ohDcuGZKcgHyYq
	 kk/nzq1fSotL4bLoISg5r5+1AVKCAaMhVgzj7iQg1OmH0dDK5QQdv2vpE+S1kkujuL
	 oQWthL3n2/N8rUDLQBmh+6ytxEPUtvdanuzY+NJeZIVsbyhfnYOaowGQNM8sC4FFnR
	 apgRSuoq81/o2/uO2m1txPtgolTFtgoTPTBKNMFV13LhfbstNFqtU5rROENANe0kwj
	 khg5ncLk29/73De+NbI49b4PQUMnHqWHgZTKoda+BjzsXM2h+MLKjyKn/FzdInCbPW
	 +yMZJ6Ql+GhYQ==
Date: Fri, 21 Feb 2025 17:01:41 +0000
From: Conor Dooley <conor@kernel.org>
To: Inochi Amaoto <inochiama@gmail.com>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen Wang <unicorn_wang@outlook.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Niklas Cassel <cassel@kernel.org>,
	Shashank Babu Chinta Venkata <quic_schintav@quicinc.com>,
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	sophgo@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org, Yixun Lan <dlan@gentoo.org>,
	Longbin Li <looong.bin@gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: pci: Add Sophgo SG2044 PCIe host
Message-ID: <20250221-cavalier-cramp-6235d4348013@spud>
References: <20250221013758.370936-1-inochiama@gmail.com>
 <20250221013758.370936-2-inochiama@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="MwJINKVsaBRPsMGS"
Content-Disposition: inline
In-Reply-To: <20250221013758.370936-2-inochiama@gmail.com>


--MwJINKVsaBRPsMGS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 21, 2025 at 09:37:55AM +0800, Inochi Amaoto wrote:
> The pcie controller on the SG2044 is designware based with
> custom app registers.
>=20
> Add binding document for SG2044 PCIe host controller.
>=20
> Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
> ---
>  .../bindings/pci/sophgo,sg2044-pcie.yaml      | 125 ++++++++++++++++++
>  1 file changed, 125 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pci/sophgo,sg2044-p=
cie.yaml
>=20
> diff --git a/Documentation/devicetree/bindings/pci/sophgo,sg2044-pcie.yam=
l b/Documentation/devicetree/bindings/pci/sophgo,sg2044-pcie.yaml
> new file mode 100644
> index 000000000000..040dabe905e0
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pci/sophgo,sg2044-pcie.yaml
> @@ -0,0 +1,125 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/pci/sophgo,sg2044-pcie.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: DesignWare based PCIe Root Complex controller on Sophgo SoCs
> +
> +maintainers:
> +  - Inochi Amaoto <inochiama@gmail.com>
> +
> +description: |+
> +  SG2044 SoC PCIe Root Complex controller is based on the Synopsys Desig=
nWare
> +  PCIe IP and thus inherits all the common properties defined in
> +  snps,dw-pcie.yaml.
> +
> +allOf:
> +  - $ref: /schemas/pci/pci-host-bridge.yaml#
> +  - $ref: /schemas/pci/snps,dw-pcie.yaml#
> +
> +properties:
> +  compatible:
> +    const: sophgo,sg2044-pcie
> +
> +  reg:
> +    items:
> +      - description: Data Bus Interface (DBI) registers
> +      - description: iATU registers
> +      - description: Config registers
> +      - description: Sophgo designed configuration registers
> +
> +  reg-names:
> +    items:
> +      - const: dbi
> +      - const: atu
> +      - const: config
> +      - const: app
> +
> +  clocks:
> +    items:
> +      - description: core clk
> +
> +  clock-names:
> +    items:
> +      - const: core
> +
> +  dma-coherent: true

Why's this here? RISC-V is dma-coherent by default, with dma-noncoherent
used to indicate systems/devices that are not.

Cheers,
Conor.

> +
> +  interrupt-controller:
> +    description: Interrupt controller node for handling legacy PCI inter=
rupts.
> +    type: object
> +
> +    properties:
> +      "#address-cells":
> +        const: 0
> +
> +      "#interrupt-cells":
> +        const: 1
> +
> +      interrupt-controller: true
> +
> +      interrupts:
> +        items:
> +          - description: combined legacy interrupt
> +
> +    required:
> +      - "#address-cells"
> +      - "#interrupt-cells"
> +      - interrupt-controller
> +      - interrupts
> +
> +    additionalProperties: false
> +
> +  msi-parent: true
> +
> +  ranges:
> +    maxItems: 5
> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +
> +    soc {
> +      #address-cells =3D <2>;
> +      #size-cells =3D <2>;
> +
> +      pcie@6c00400000 {
> +        compatible =3D "sophgo,sg2044-pcie";
> +        reg =3D <0x6c 0x00400000 0x0 0x00001000>,
> +              <0x6c 0x00700000 0x0 0x00004000>,
> +              <0x40 0x00000000 0x0 0x00001000>,
> +              <0x6c 0x00780c00 0x0 0x00000400>;
> +        reg-names =3D "dbi", "atu", "config", "app";
> +        #address-cells =3D <3>;
> +        #size-cells =3D <2>;
> +        bus-range =3D <0x00 0xff>;
> +        clocks =3D <&clk 0>;
> +        clock-names =3D "core";
> +        device_type =3D "pci";
> +        dma-coherent;
> +        linux,pci-domain =3D <0>;
> +        msi-parent =3D <&msi>;
> +        ranges =3D <0x01000000 0x0  0x00000000  0x40 0x10000000  0x0 0x0=
0200000>,
> +                 <0x42000000 0x0  0x00000000  0x0  0x00000000  0x0 0x040=
00000>,
> +                 <0x02000000 0x0  0x04000000  0x0  0x04000000  0x0 0x040=
00000>,
> +                 <0x43000000 0x42 0x00000000  0x42 0x00000000  0x2 0x000=
00000>,
> +                 <0x03000000 0x41 0x00000000  0x41 0x00000000  0x1 0x000=
00000>;
> +
> +        interrupt-controller {
> +          #address-cells =3D <0>;
> +          #interrupt-cells =3D <1>;
> +          interrupt-controller;
> +          interrupt-parent =3D <&intc>;
> +          interrupts =3D <64 IRQ_TYPE_LEVEL_HIGH>;
> +        };
> +      };
> +    };
> +...
> --=20
> 2.48.1
>=20

--MwJINKVsaBRPsMGS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZ7ixdQAKCRB4tDGHoIJi
0r5bAQD2/xgf2z2mj+PfULdLhil9ssspRZH13YmMyPGC5sanWQD9F/3QXeB0ciDz
5QbRlfDz98HUAUow/IaPa38AV/IlggU=
=WAPh
-----END PGP SIGNATURE-----

--MwJINKVsaBRPsMGS--

