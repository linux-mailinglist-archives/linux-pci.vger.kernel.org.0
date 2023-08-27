Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C65EA789DC8
	for <lists+linux-pci@lfdr.de>; Sun, 27 Aug 2023 14:13:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229544AbjH0MKt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 27 Aug 2023 08:10:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbjH0MKh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 27 Aug 2023 08:10:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9CAE130;
        Sun, 27 Aug 2023 05:10:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7751B60F0F;
        Sun, 27 Aug 2023 12:10:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84B0DC433C7;
        Sun, 27 Aug 2023 12:10:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693138233;
        bh=WMzxN+/vPzfmnWAACf8mcof6OpZORi1WlHwqzQDLUrk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jCAZep4DsRDmbmzerSlURVj5dx6DHazJVvmof31F0VAjS3U6WGGomC14azfCjxn73
         7aqr07Ia/1W6K0EMqWSRGkgQYSs0rWRWfeFhjKG1w1XQsqwOZw0THjcQEWQdijPQ1c
         N0qUJOtf0V61x/PXv0rfbNheIhOOuQJ6Sn96EPpUHplPiJLJv/GukG3b3zgFsE89sf
         g7e0Lm8SQZfjHzyFT7sw2jjHy+1uQhfbB94ST/x6KxHj8wbweG9Il6CrhluyYf5xHU
         lFFVTi5nDVGKeegzZXqO2Rl5QBFG8ZjktDtJbkG8mAP4rdjAGMb+6ny6V+hB4C7nyb
         V0Gt5YLkbNCTg==
Date:   Sun, 27 Aug 2023 13:10:28 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Manivannan Sadhasivam <mani@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Rohit Agarwal <quic_rohiagar@quicinc.com>,
        linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: PCI: qcom: fix SDX65 compatible
Message-ID: <20230827-eggshell-rift-94f423e74dab@spud>
References: <20230827085351.21932-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Y5ooK+v/FYTMRcoa"
Content-Disposition: inline
In-Reply-To: <20230827085351.21932-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--Y5ooK+v/FYTMRcoa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 27, 2023 at 10:53:51AM +0200, Krzysztof Kozlowski wrote:
> Commit c0aba9f32801 ("dt-bindings: PCI: qcom: Add SDX65 SoC") adding
> SDX65 was not ever tested and is clearly bogus.  The qcom,sdx65-pcie-ep
> compatible is followed by fallback in DTS and there is no driver
> matching by this compatible.  Driver matches by its fallback
> qcom,sdx55-pcie-ep.  This fixes also dtbs_check warnings like:
>=20
>   qcom-sdx65-mtp.dtb: pcie-ep@1c00000: compatible: ['qcom,sdx65-pcie-ep',=
 'qcom,sdx55-pcie-ep'] is too long
>=20
> Fixes: c0aba9f32801 ("dt-bindings: PCI: qcom: Add SDX65 SoC")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

> ---
>  .../devicetree/bindings/pci/qcom,pcie-ep.yaml        | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml b/Do=
cumentation/devicetree/bindings/pci/qcom,pcie-ep.yaml
> index 811112255d7d..c94b49498f69 100644
> --- a/Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml
> +++ b/Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml
> @@ -11,10 +11,13 @@ maintainers:
> =20
>  properties:
>    compatible:
> -    enum:
> -      - qcom,sdx55-pcie-ep
> -      - qcom,sdx65-pcie-ep
> -      - qcom,sm8450-pcie-ep
> +    oneOf:
> +      - enum:
> +          - qcom,sdx55-pcie-ep
> +          - qcom,sm8450-pcie-ep
> +      - items:
> +          - const: qcom,sdx65-pcie-ep
> +          - const: qcom,sdx55-pcie-ep
> =20
>    reg:
>      items:
> @@ -110,7 +113,6 @@ allOf:
>            contains:
>              enum:
>                - qcom,sdx55-pcie-ep
> -              - qcom,sdx65-pcie-ep
>      then:
>        properties:
>          clocks:
> --=20
> 2.34.1
>=20

--Y5ooK+v/FYTMRcoa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZOs9NAAKCRB4tDGHoIJi
0iL6APsGucI4pCdyWDXNGs3In99cNJWvdrvhE7ev5q0DILG3NAEA+2q4eG9xiZCJ
POmCuJO6gXOLawwxCu2gSWuTtCNA1w4=
=pkml
-----END PGP SIGNATURE-----

--Y5ooK+v/FYTMRcoa--
