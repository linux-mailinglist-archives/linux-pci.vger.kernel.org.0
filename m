Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 979A8692556
	for <lists+linux-pci@lfdr.de>; Fri, 10 Feb 2023 19:27:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232720AbjBJS11 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 10 Feb 2023 13:27:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232876AbjBJS11 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 10 Feb 2023 13:27:27 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D50936CC59;
        Fri, 10 Feb 2023 10:27:25 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7B465B824BF;
        Fri, 10 Feb 2023 18:27:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEE21C433D2;
        Fri, 10 Feb 2023 18:27:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676053643;
        bh=ru75vqtNeMxKc3i0lMcAyuNObS+r1MZ5Asn18pE6VEw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bExP0i1cFK40vvmYCrycuDh+WjwLa2A90peLfb3/ogMKDO9XuDfBTD23KWz18nVCD
         4ra0gPY9RpVaWrlu/gA/nChu0wb5Nz3+RMd4FilqdWClPRewfwSF5W7gcB3P16hS2U
         IyGquHfsILS/4gcZy1b8zOClq9qFtOjO6xuKxMJz9QVjLteyYlqJBF7JWts0+ZqVEG
         pGIXXumGOtroOGUaoHyY3bls6d2tqwEIfjbJ7e/dCiUEvnj7ETP8DB59lMtOVj57Yl
         lis0TvIUErSK0dqmpvsqcGQuMhXIAG+tmloT4zNwE7IEiECp0ZH+637gCX5jT9W4r9
         888/xEl2XM2Fw==
Date:   Fri, 10 Feb 2023 18:27:19 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Nick Alcock <nick.alcock@oracle.com>
Cc:     mcgrof@kernel.org, linux-modules@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH 8/8] kbuild, PCI: microchip: comment out MODULE_LICENSE
 in non-modules
Message-ID: <Y+aMh5e9bWaTphiZ@spud>
References: <20230210164749.368998-1-nick.alcock@oracle.com>
 <20230210164749.368998-9-nick.alcock@oracle.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="UQcsHPcpF5ooaooy"
Content-Disposition: inline
In-Reply-To: <20230210164749.368998-9-nick.alcock@oracle.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--UQcsHPcpF5ooaooy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey Nick,

FYI $subject seems wrong, this is a PCI patch AFAICT.

On Fri, Feb 10, 2023 at 04:47:49PM +0000, Nick Alcock wrote:
> Since commit 8b41fc4454e ("kbuild: create modules.builtin without
> Makefile.modbuiltin or tristate.conf"), MODULE_LICENSE declarations
> are used to identify modules. As a consequence, uses of the macro
> in non-modules will cause modprobe to misidentify their containing
> object file as a module when it is not (false positives), and modprobe
> might succeed rather than failing with a suitable error message.
>=20
> So comment out all uses of MODULE_LICENSE that are not in real modules

This patch should not been needed, there's an existing patch to make
this a module:
https://lore.kernel.org/linux-riscv/20230111125323.1911373-4-daire.mcnamara=
@microchip.com/

> (the license declaration is left in as documentation).

I don't really get this one though, why leave it there as
"documentation" when the file has an SPDX entry anyway?

> Signed-off-by: Nick Alcock <nick.alcock@oracle.com>
> Suggested-by: Luis Chamberlain <mcgrof@kernel.org>
> Cc: Luis Chamberlain <mcgrof@kernel.org>
> Cc: linux-modules@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-pci@vger.kernel.org
> Cc: linux-riscv@lists.infradead.org

One for the future:
How about also CCing those listed in MAINTAINERS for the file you're
changing?

Cheers,
Conor.

> ---
>  drivers/pci/controller/pcie-microchip-host.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/pci/controller/pcie-microchip-host.c b/drivers/pci/c=
ontroller/pcie-microchip-host.c
> index 0ebf7015e9af..08c0b778ce67 100644
> --- a/drivers/pci/controller/pcie-microchip-host.c
> +++ b/drivers/pci/controller/pcie-microchip-host.c
> @@ -1135,6 +1135,6 @@ static struct platform_driver mc_pcie_driver =3D {
>  };
> =20
>  builtin_platform_driver(mc_pcie_driver);
> -MODULE_LICENSE("GPL");
> +/* MODULE_LICENSE("GPL"); */
>  MODULE_DESCRIPTION("Microchip PCIe host controller driver");
>  MODULE_AUTHOR("Daire McNamara <daire.mcnamara@microchip.com>");
> --=20
> 2.39.1.268.g9de2f9a303
>=20

--UQcsHPcpF5ooaooy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCY+aMhwAKCRB4tDGHoIJi
0p75AQCjE3hKHpySZYQwvXOT9WAba8RscTwFwxbmiRhPyoihiAEAl4cR0LIJEcNm
hYM+BjoPrEpdFZ6y/x/hnI/5ADnkkgY=
=6q4t
-----END PGP SIGNATURE-----

--UQcsHPcpF5ooaooy--
