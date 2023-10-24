Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5376D7D5853
	for <lists+linux-pci@lfdr.de>; Tue, 24 Oct 2023 18:29:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343884AbjJXQ3n (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 24 Oct 2023 12:29:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343901AbjJXQ3l (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 24 Oct 2023 12:29:41 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFC7510F9
        for <linux-pci@vger.kernel.org>; Tue, 24 Oct 2023 09:29:35 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F623C433C7;
        Tue, 24 Oct 2023 16:29:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698164975;
        bh=ToOuDiwID7kYMJgwK7NAcFBO1+obD7vq8ICE/ePutgM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bAHZIHkcyLdhkhrgG7n1TAPSNDSKFGBgu0cm5CvBb8cyKj4yj35FQcxUMojfEFeXd
         HhLTYYZ9yI8UGpubvQdnYYuEfesBxfu+tUvdE+0pfyKcE76Mr87VxJZoBFWPXpo7bu
         2e/V87MxrKtDAYDqv9iYQRzTrkmuVRaj4MaDIq5WKwZmUqFN39ensnxMEHI6WK7cYn
         ePxDQRXL/v971RAG+5hUmlBJof35vOL7Ggn9EvflerRMDAX/lpZSvvl5nGY90gZjky
         83vnHCs+rGtn9Y8lOVMkecw3ycH9QPZ+jjy2JNMSPIyaErjbSEsYI9/TS43ci3snl3
         Zjqb2HeQsvOzQ==
Date:   Tue, 24 Oct 2023 17:29:28 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Niklas Cassel <nks@flawful.org>
Cc:     Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Simon Xue <xxm@rock-chips.com>,
        Damien Le Moal <dlemoal@kernel.org>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Niklas Cassel <niklas.cassel@wdc.com>,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v2 1/4] dt-bindings: PCI: dwc: rockchip: Add atu property
Message-ID: <20231024-zoology-preteen-5627e1125ae0@spud>
References: <20231024151014.240695-1-nks@flawful.org>
 <20231024151014.240695-2-nks@flawful.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="GmxiJMkWxFE9W0TW"
Content-Disposition: inline
In-Reply-To: <20231024151014.240695-2-nks@flawful.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--GmxiJMkWxFE9W0TW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 24, 2023 at 05:10:08PM +0200, Niklas Cassel wrote:
> From: Niklas Cassel <niklas.cassel@wdc.com>
>=20
> Even though rockchip-dw-pcie.yaml inherits snps,dw-pcie.yaml
> using:
>=20
> allOf:
>   - $ref: /schemas/pci/snps,dw-pcie.yaml#
>=20
> and snps,dw-pcie.yaml does have the atu property defined, in order to be
> able to use this property, while still making sure 'make CHECK_DTBS=3Dy'
> pass, we need to add this property to rockchip-dw-pcie.yaml.
>=20
> Signed-off-by: Niklas Cassel <niklas.cassel@wdc.com>
> ---
>  Documentation/devicetree/bindings/pci/rockchip-dw-pcie.yaml | 4 ++++
>  1 file changed, 4 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/pci/rockchip-dw-pcie.yaml =
b/Documentation/devicetree/bindings/pci/rockchip-dw-pcie.yaml
> index 1ae8dcfa072c..229f8608c535 100644
> --- a/Documentation/devicetree/bindings/pci/rockchip-dw-pcie.yaml
> +++ b/Documentation/devicetree/bindings/pci/rockchip-dw-pcie.yaml
> @@ -29,16 +29,20 @@ properties:
>            - const: rockchip,rk3568-pcie
> =20
>    reg:
> +    minItems: 3
>      items:
>        - description: Data Bus Interface (DBI) registers
>        - description: Rockchip designed configuration registers
>        - description: Config registers
> +      - description: iATU registers

Is this extra register only for the ..88 or for the ..68 and for the
=2E.88 models?

> =20
>    reg-names:
> +    minItems: 3
>      items:
>        - const: dbi
>        - const: apb
>        - const: config
> +      - const: atu
> =20
>    clocks:
>      minItems: 5
> --=20
> 2.41.0
>=20

--GmxiJMkWxFE9W0TW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZTfw6AAKCRB4tDGHoIJi
0qb/AP4hIJGUoqERu3QlpvqCaZ/CBI2cf+nZgPkQl4kGAYVyfgD+PXkXwVjXkAbA
HSw5kLuiPMl+65KV5fy0La1elPqpSwc=
=qavj
-----END PGP SIGNATURE-----

--GmxiJMkWxFE9W0TW--
