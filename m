Return-Path: <linux-pci+bounces-806-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 86CA680F38F
	for <lists+linux-pci@lfdr.de>; Tue, 12 Dec 2023 17:51:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D9CD1F216A2
	for <lists+linux-pci@lfdr.de>; Tue, 12 Dec 2023 16:51:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6645E7A238;
	Tue, 12 Dec 2023 16:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="blDeZJNj"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C27F78E98;
	Tue, 12 Dec 2023 16:51:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B600CC433C8;
	Tue, 12 Dec 2023 16:51:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702399872;
	bh=pxoxG3L7DCf9PxhMDZX23WIDnwrk05Pc2sbWEHLjkNQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=blDeZJNjTGcsepBC0e9cnsV21kV4vavWGKn7kBDtx5LFlCX50m0ODmn1lOnkUnsnY
	 +iUm5MB3K30bxLX2XmAnHsRXgAyYMKDWD8LVWYA+ydkVvFQo4o8Ml0MMP9xg6Go0uT
	 /4gkSZh8F80TGibEU6dIILcy0ME4SpV0a8RFLhfeSCxD5kyAXYFInUj74nwColB4GF
	 XlAJZIdkH3OMnvB3egXPcF3LO63DbaPMoxV5l/3cIoHXzSSveFbunExJsyLITllSGB
	 LuBfIKV6EHuS9XWfS16UBDl+O3YOeA7fS//0xAYcx7Zl3Up88u9bTOwR4d0MKC16mK
	 OoZslS2ePbgJA==
Date: Tue, 12 Dec 2023 16:51:06 +0000
From: Conor Dooley <conor@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: bhelgaas@google.com, conor+dt@kernel.org, devicetree@vger.kernel.org,
	festevam@gmail.com, helgaas@kernel.org, hongxing.zhu@nxp.com,
	imx@lists.linux.dev, kernel@pengutronix.de,
	krzysztof.kozlowski+dt@linaro.org, kw@linux.com,
	l.stach@pengutronix.de, linux-arm-kernel@lists.infradead.org,
	linux-imx@nxp.com, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, lpieralisi@kernel.org,
	manivannan.sadhasivam@linaro.org, robh@kernel.org,
	s.hauer@pengutronix.de, shawnguo@kernel.org
Subject: Re: [PATCH v3 12/13] dt-bindings: imx6q-pcie: Add iMX95 pcie
 endpoint compatible string
Message-ID: <20231212-snowiness-verbalize-d1fbb8c80a99@spud>
References: <20231211215842.134823-1-Frank.Li@nxp.com>
 <20231211215842.134823-13-Frank.Li@nxp.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ehk5DdTkek4HJjlY"
Content-Disposition: inline
In-Reply-To: <20231211215842.134823-13-Frank.Li@nxp.com>


--ehk5DdTkek4HJjlY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 11, 2023 at 04:58:41PM -0500, Frank Li wrote:
> Add i.MX95 PCIe "fsl,imx95-pcie-ep" compatible string.
> Add reg-name: "atu", "dbi2", "dma" and "serdes".
>=20
> Signed-off-by: Frank Li <Frank.Li@nxp.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

> ---
>=20
> Notes:
>     Change from v1 to v3
>     - new patches at v3
>=20
>  .../bindings/pci/fsl,imx6q-pcie-ep.yaml       | 20 +++++++++++++++++++
>  1 file changed, 20 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie-ep.yaml=
 b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie-ep.yaml
> index ee155ed5f1811..36d8f117fdfb3 100644
> --- a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie-ep.yaml
> +++ b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie-ep.yaml
> @@ -22,6 +22,7 @@ properties:
>        - fsl,imx8mm-pcie-ep
>        - fsl,imx8mq-pcie-ep
>        - fsl,imx8mp-pcie-ep
> +      - fsl,imx95-pcie-ep
> =20
>    reg:
>      minItems: 2
> @@ -62,11 +63,30 @@ required:
>  allOf:
>    - $ref: /schemas/pci/snps,dw-pcie-ep.yaml#
>    - $ref: /schemas/pci/fsl,imx6q-pcie-common.yaml#
> +  - if:
> +      properties:
> +        compatible:
> +          enum:
> +            - fsl,imx95-pcie-ep
> +    then:
> +      properties:
> +        reg:
> +          minItems: 6
> +        reg-names:
> +          items:
> +            - const: dbi
> +            - const: atu
> +            - const: dbi2
> +            - const: serdes
> +            - const: dma
> +            - const: addr_space
> +
>    - if:
>        properties:
>          compatible:
>            enum:
>              - fsl,imx8mq-pcie-ep
> +            - fsl,imx95-pcie-ep
>      then:
>        properties:
>          clocks:
> --=20
> 2.34.1
>=20

--ehk5DdTkek4HJjlY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZXiPegAKCRB4tDGHoIJi
0ilmAQDQ1GfJs7PkFWStKchAvAk/4FgCatGA4wPKZ8PH27gQ4QEAmAksUAUSPt0S
tNrfj2EzCLZd4RIPyNmTSRq1WY6OLgc=
=KvBM
-----END PGP SIGNATURE-----

--ehk5DdTkek4HJjlY--

