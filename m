Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D58147E9DDE
	for <lists+linux-pci@lfdr.de>; Mon, 13 Nov 2023 14:54:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230319AbjKMNyB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 13 Nov 2023 08:54:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230043AbjKMNyA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 13 Nov 2023 08:54:00 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16A8DD5C;
        Mon, 13 Nov 2023 05:53:58 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6206EC433C7;
        Mon, 13 Nov 2023 13:53:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699883637;
        bh=plF/r4HIEuooKGmnsFRar8GaRxhKP0L4EfThVigAiCY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jPJXpBhZw16BZzwtzm0uvW7wge2Aro67mW43BIE38LUZbU4kbtgYcwBB46uYMfHmM
         qhAktBDNxSQtd2LYxEEenXoSpbrlmZY+h18Q4DaKdwlXvyxdny67ABNZ9UOOxWDrid
         bcJPE646qrhPJrpomct9wBA7Q0GmkI+stFJkyJh2p9rTp+RX1t13wjj0xzPlA9h9M3
         40+cWtO/SsSINvV+2W26Fc3vWryYrjlQatSA+jwLN1PND0mE5z73q4qTlIlOr9zO0f
         4ut19ixOqFn2wSAK7ZuBkCrdqxfQHYGHDvOP7aDL5fLbv1rHeOIRTjJTAwdlDGvGvF
         p8i4eqCxq82fA==
Date:   Mon, 13 Nov 2023 13:53:54 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: PCI: qcom: adjust iommu-map for
 different SoC
Message-ID: <20231113-shortly-catchable-9110f1b63943@squawk>
References: <20231112184557.3801-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="kU0g80bZlb7NsLLb"
Content-Disposition: inline
In-Reply-To: <20231112184557.3801-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--kU0g80bZlb7NsLLb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 12, 2023 at 07:45:56PM +0100, Krzysztof Kozlowski wrote:
> The PCIe controller on SDX55 has five entries in its iommu-map, MSM8998
> has one and SDM845 has sixteen, so allow wider number of items to fix
> dtbs_check warnings like:
>=20
>   qcom-sdx55-mtp.dtb: pcie@1c00000: iommu-map: [[0, 21, 512, 1], [256, 21=
, 513, 1],
>     [512, 21, 514, 1], [768, 21, 515, 1], [1024, 21, 516, 1]] is too long
>=20
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

> ---
>  Documentation/devicetree/bindings/pci/qcom,pcie.yaml | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml b/Docum=
entation/devicetree/bindings/pci/qcom,pcie.yaml
> index 8bfae8eb79a3..14d25e8a18e4 100644
> --- a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
> +++ b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
> @@ -62,7 +62,8 @@ properties:
>      maxItems: 8
> =20
>    iommu-map:
> -    maxItems: 2
> +    minItems: 1
> +    maxItems: 16
> =20
>    # Common definitions for clocks, clock-names and reset.
>    # Platform constraints are described later.
> --=20
> 2.34.1
>=20

--kU0g80bZlb7NsLLb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZVIqbwAKCRB4tDGHoIJi
0qY1AP9i/3gvKL8whJl5EdsGw0HYkilJh0o9sZue21L0oWgM0wD/ZIJm4cDxnLzk
NZTYlZScX/bEZrUi8+Z/Q4N2qJ6KZwo=
=SXnR
-----END PGP SIGNATURE-----

--kU0g80bZlb7NsLLb--
