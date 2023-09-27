Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 738397B0858
	for <lists+linux-pci@lfdr.de>; Wed, 27 Sep 2023 17:36:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232424AbjI0Pf6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 27 Sep 2023 11:35:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232466AbjI0Pf5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 27 Sep 2023 11:35:57 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 660DF198;
        Wed, 27 Sep 2023 08:35:55 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22173C433C8;
        Wed, 27 Sep 2023 15:35:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695828955;
        bh=Vbcpyf8NR6obj9hRrWqEruzSZGutGz1yExgH+iLFr+Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=A9hxyKZqoQ2qZv3jGkVqTnIuauZkwqAo2+Age9iyTVmJ9qkjfNF2zLfHQdX6ZmKvq
         /MCMSKw1PdhwHoijPT73JL2aDQ0FRhCZBxtDXzgq1aIHrolCMSGN8PV1xGdvC9Yo/N
         SaKBJjDjwaY0350cc14w8W6kRTrIkWAlxuCjbMPtlk7Sdxl7Ty2d9QwCz4LEMk1iZg
         UG7S3AK3FzWGN3aNMkPdcjQV2IhwZ0MMXFhV7Wml8GdgtvJLTTMkFDQ5wdtO77y6go
         p41vvBRfxmJRvcf5Tl4fR2ff2okcVbOhz6cLpmmfAFgSGwB2nPMf9vqUlwr3ALHsQ/
         5b3WlrtnhXRAQ==
Date:   Wed, 27 Sep 2023 16:35:49 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Ray Jui <ray.jui@broadcom.com>,
        Scott Branden <scott.branden@broadcom.com>,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] dt-bindings: PCI: brcm,iproc-pcie: Fix 'msi' child
 node schema
Message-ID: <20230927-utmost-copied-6982126a7f00@spud>
References: <20230926155351.31117-1-robh@kernel.org>
 <20230926155613.33904-3-robh@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="1BjGV0efq9T3tTST"
Content-Disposition: inline
In-Reply-To: <20230926155613.33904-3-robh@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--1BjGV0efq9T3tTST
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 26, 2023 at 10:56:09AM -0500, Rob Herring wrote:
> The 'msi' child node schema is missing constraints on additional properti=
es.
> It turns out it is incomplete and properties for it are documented in the
> parent node by mistake. Move the reference to msi-controller.yaml and
> the custom properties to the 'msi' node. Adding 'unevaluatedProperties'
> ensures all the properties in the 'msi' node are documented.
>=20
> With the schema corrected, a minimal interrupt controller node is needed
> to properly decode the interrupt properties since the example has
> multiple interrupt parents.

I suppose this is an ABI break, but the patch just makes the binding
match the example and intent. Feels like of all the patches doing the
unevaluatedProperty additions, this one is the most deserving of a fixes
tag, since the original binding just seems to be completely wrong?

Otherwise,
Acked-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

>=20
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  .../bindings/pci/brcm,iproc-pcie.yaml         | 24 ++++++++++++-------
>  1 file changed, 16 insertions(+), 8 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/pci/brcm,iproc-pcie.yaml b=
/Documentation/devicetree/bindings/pci/brcm,iproc-pcie.yaml
> index 6730d68fedc7..0e07ab61a48d 100644
> --- a/Documentation/devicetree/bindings/pci/brcm,iproc-pcie.yaml
> +++ b/Documentation/devicetree/bindings/pci/brcm,iproc-pcie.yaml
> @@ -12,7 +12,6 @@ maintainers:
> =20
>  allOf:
>    - $ref: /schemas/pci/pci-bus.yaml#
> -  - $ref: /schemas/interrupt-controller/msi-controller.yaml#
> =20
>  properties:
>    compatible:
> @@ -63,20 +62,24 @@ properties:
> =20
>    msi:
>      type: object
> +    $ref: /schemas/interrupt-controller/msi-controller.yaml#
> +    unevaluatedProperties: false
> +
>      properties:
>        compatible:
>          items:
>            - const: brcm,iproc-msi
> =20
> -  msi-parent: true
> +      interrupts:
> +        maxItems: 4
> =20
> -  msi-controller: true
> +      brcm,pcie-msi-inten:
> +        type: boolean
> +        description:
> +          Needs to be present for some older iProc platforms that requir=
e the
> +          interrupt enable registers to be set explicitly to enable MSI
> =20
> -  brcm,pcie-msi-inten:
> -    type: boolean
> -    description: >
> -      Needs to be present for some older iProc platforms that require the
> -      interrupt enable registers to be set explicitly to enable MSI
> +  msi-parent: true
> =20
>  dependencies:
>    brcm,pcie-ob-axi-offset: ["brcm,pcie-ob"]
> @@ -104,6 +107,11 @@ examples:
>    - |
>      #include <dt-bindings/interrupt-controller/arm-gic.h>
> =20
> +    gic: interrupt-controller {
> +        interrupt-controller;
> +        #interrupt-cells =3D <3>;
> +    };
> +
>      pcie@18012000 {
>          compatible =3D "brcm,iproc-pcie";
>          reg =3D <0x18012000 0x1000>;
> --=20
> 2.40.1
>=20

--1BjGV0efq9T3tTST
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZRRL1QAKCRB4tDGHoIJi
0vG2AQDluSVffOKOHbIEMmIpNz0g1yHoArvULfqpNTho1ylwlQEA/EmGD6/g/1ZF
dKNKjfPaJCXwB3Jg7O7xQ9vpU0G2xA0=
=4PdT
-----END PGP SIGNATURE-----

--1BjGV0efq9T3tTST--
