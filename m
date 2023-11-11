Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFC2E7E8BA0
	for <lists+linux-pci@lfdr.de>; Sat, 11 Nov 2023 17:32:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231320AbjKKQcC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 11 Nov 2023 11:32:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229797AbjKKQcB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 11 Nov 2023 11:32:01 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B87B53A9D;
        Sat, 11 Nov 2023 08:31:58 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2B1EC433C7;
        Sat, 11 Nov 2023 16:31:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699720318;
        bh=N4eJORdtlqjk4Cwso9ZXK77iVw8ec8lYE0PGsvPkPBw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=D0YgOD50dpSUrRk9oAOF7CzFTENh2qk5pm/cGFPS7mc5Rc5Ph7nMDFyVXDmJNO1ws
         x0qH+bMoeZd0V/swxrJWTv82D3UCMIdwNdtTzDG43anFa5FtEe0wWkjx8emNkNNMif
         n1qVEk14wx1F6wpPu8VQgUPdxyhSHEG5Rzk9jAd4yyyMcxV2ouiKiqtXca7ngf97j1
         RI7QCl9wWQLH50JZRg2TiI2sf3rUXN9RXEexnyylxLVf9xSi4KJnAk33rrEKFM+RVt
         +z+e3SM26p49Ru+a+NC5Fd5TJPchBFZrM/LsmhD7BsxAoe0Z876el/59oV3ydbdSU/
         OLeSfkVwuwdLA==
Date:   Sat, 11 Nov 2023 16:31:55 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: PCI: qcom: Correct reset-names property
Message-ID: <20231111-unenvied-riot-5203bd2ea685@squawk>
References: <20231111142006.51883-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="u7srXMTkl7pfa03y"
Content-Disposition: inline
In-Reply-To: <20231111142006.51883-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--u7srXMTkl7pfa03y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 11, 2023 at 03:20:06PM +0100, Krzysztof Kozlowski wrote:
> There is no "resets-names" property, but "reset-names".
>=20
> Fixes: 075a9d55932e ("dt-bindings: PCI: qcom: Convert to YAML")

The original text binding did in fact use reset not resets.
Acked-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  Documentation/devicetree/bindings/pci/qcom,pcie.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml b/Docum=
entation/devicetree/bindings/pci/qcom,pcie.yaml
> index eadba38171e1..8bfae8eb79a3 100644
> --- a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
> +++ b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
> @@ -88,7 +88,7 @@ properties:
>      minItems: 1
>      maxItems: 12
> =20
> -  resets-names:
> +  reset-names:
>      minItems: 1
>      maxItems: 12
> =20
> --=20
> 2.34.1
>=20

--u7srXMTkl7pfa03y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZU+sdAAKCRB4tDGHoIJi
0uomAQDyCLq9m9qUDaFBJF/w18Szow4VuL9mIlwQk/lpPkNoFwD/T2m6YDFljKTI
BUD0mnOCmcWZ9t/Ld7y769itwch4JQY=
=fLVh
-----END PGP SIGNATURE-----

--u7srXMTkl7pfa03y--
