Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB12B6662A0
	for <lists+linux-pci@lfdr.de>; Wed, 11 Jan 2023 19:18:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233540AbjAKSSn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 11 Jan 2023 13:18:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232042AbjAKSSm (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 11 Jan 2023 13:18:42 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBF6664CC;
        Wed, 11 Jan 2023 10:18:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 681CF61CAD;
        Wed, 11 Jan 2023 18:18:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 268DDC433EF;
        Wed, 11 Jan 2023 18:18:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673461120;
        bh=Ft6ts49/fdxZzt/+lIGE0K5qPyLC/HSErr1aisZrG78=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jmPyapBajBJmsUZ/i0FdFZcz5bzc13Um8acMKnukZjL0n+l9flQk20HAYozaMvC0q
         eCj2+Da18yD40Hx4KC9AVLra2V9syHAQ9l4LrDDB8DmgnajtZq04bOY9SxrHIpvU2y
         EIBFvTnWCyP2tImK+8/Sdh5UuJBtElqyCF8iXPRd8EQp6HOuppJ7KjwnEOT0TaJ25H
         h34ZGNCu1+NvvMJWz/ZSW5rWI+vVh3frDv3xgSWV9+PKhV7sdbE0qzxQfvN/BWfkIX
         zok8Z18lxUNdkgV1PACztsRVX1fBl4rQwWKdeFeuyo1TbxVDBJi6mlpIUrkW438w2F
         hFnV/Iz2Ttb2w==
Date:   Wed, 11 Jan 2023 18:18:35 +0000
From:   Conor Dooley <conor@kernel.org>
To:     daire.mcnamara@microchip.com
Cc:     conor.dooley@microchip.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, paul.walmsley@sifive.com,
        palmer@dabbelt.com, aou@eecs.berkeley.edu, lpieralisi@kernel.org,
        kw@linux.com, bhelgaas@google.com, linux-riscv@lists.infradead.org,
        devicetree@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v3 02/11] PCI: microchip: Remove cast warning for
 devm_add_action_or_reset() arg
Message-ID: <Y779e4gfZW5P5gDP@spud>
References: <20230111125323.1911373-1-daire.mcnamara@microchip.com>
 <20230111125323.1911373-3-daire.mcnamara@microchip.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="3ul3IBHmWNX2j1kt"
Content-Disposition: inline
In-Reply-To: <20230111125323.1911373-3-daire.mcnamara@microchip.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--3ul3IBHmWNX2j1kt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey Daire,

On Wed, Jan 11, 2023 at 12:53:14PM +0000, daire.mcnamara@microchip.com wrot=
e:
> From: Daire McNamara <daire.mcnamara@microchip.com>
>=20
> The kernel test robot reported that the ugly cast from
> void(*)(struct clk *) to void (*)(void *) converts to incompatible
> function type.  This commit adopts the common convention of creating a
> trivial stub function that takes a void * and passes it to the
> underlying function that expects the more specific type.
>=20
> Fixes: 6f15a9c9f941 ("PCI: microchip: Add Microchip PolarFire PCIe contro=
ller driver")

Reported-by: kernel test robot <lkp@intel.com>

> Signed-off-by: Daire McNamara <daire.mcnamara@microchip.com>
> ---
>  drivers/pci/controller/pcie-microchip-host.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/pci/controller/pcie-microchip-host.c b/drivers/pci/c=
ontroller/pcie-microchip-host.c
> index 5c89caaab8c9..5efd480e42fa 100644
> --- a/drivers/pci/controller/pcie-microchip-host.c
> +++ b/drivers/pci/controller/pcie-microchip-host.c
> @@ -848,6 +848,13 @@ static const struct irq_domain_ops event_domain_ops =
=3D {
>  	.map =3D mc_pcie_event_map,
>  };
> =20
> +static inline void mc_pcie_chip_off_action(void *data)
> +{
> +	struct clk *clk =3D data;
> +
> +	clk_disable_unprepare(clk);
> +}
> +
>  static inline struct clk *mc_pcie_init_clk(struct device *dev, const cha=
r *id)
>  {
>  	struct clk *clk;
> @@ -863,8 +870,7 @@ static inline struct clk *mc_pcie_init_clk(struct dev=
ice *dev, const char *id)
>  	if (ret)
>  		return ERR_PTR(ret);
> =20
> -	devm_add_action_or_reset(dev, (void (*) (void *))clk_disable_unprepare,
> -				 clk);
> +	devm_add_action_or_reset(dev, mc_pcie_chip_off_action, clk);

Certainly looks a lot nicer this way, so 2 for the price of 1 I think.
Acked-by: Conor Dooley <conor.dooley@microchip.com>

> =20
>  	return clk;
>  }


--3ul3IBHmWNX2j1kt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCY779ewAKCRB4tDGHoIJi
0g87AQCzYmsXqLFuq7CSIqE4rNjc0xNU0VmLAlH+Se9kAa/SeAEAgxgokT1hVUtr
DSyU7fifErOQxZrXgkYnSguhZVGMvQQ=
=GEx/
-----END PGP SIGNATURE-----

--3ul3IBHmWNX2j1kt--
