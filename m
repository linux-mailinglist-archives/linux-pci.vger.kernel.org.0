Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D91D06662A9
	for <lists+linux-pci@lfdr.de>; Wed, 11 Jan 2023 19:20:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235089AbjAKSUP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 11 Jan 2023 13:20:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235054AbjAKSUO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 11 Jan 2023 13:20:14 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF7341EEE9;
        Wed, 11 Jan 2023 10:20:13 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 80B1CB81BB0;
        Wed, 11 Jan 2023 18:20:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 681F6C433EF;
        Wed, 11 Jan 2023 18:20:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673461211;
        bh=Y6YMceRehLG1qPa4PtJGKgaNebi1JEkzGDnTEex8054=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hK8kUGE30A92eCeDkWBOnb6cSX69Kf5wzWhIhkW3Yr/jsaZVZrVHWMXyf1+3nLxUv
         JWUZ4vogqxHIuZcDWzgB1l43iP8XfYHnv2KpXuNJYQDDpoTFellfqcwY3pZMVFMiWK
         gGoGWVzko9H3a5TbE+1gHwLE3zw7z5mk89W35Le9UMP+0CYj8QqwKY9dL7aK6X2ps/
         OipJt8uhpzPiKKLMoECvwWwRRQsVDi7oMYZHnXL7193XxaxFysc/fhJUx/iPAolz8R
         /a6SrHT2fG+NXNETdaFOGfRAZMcsQY/JboBKRvVSff50RUHelC0X/38f2eAnj65ILA
         Q7kRTA4p1hbgQ==
Date:   Wed, 11 Jan 2023 18:20:05 +0000
From:   Conor Dooley <conor@kernel.org>
To:     daire.mcnamara@microchip.com
Cc:     conor.dooley@microchip.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, paul.walmsley@sifive.com,
        palmer@dabbelt.com, aou@eecs.berkeley.edu, lpieralisi@kernel.org,
        kw@linux.com, bhelgaas@google.com, linux-riscv@lists.infradead.org,
        devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH v3 03/11] PCI: microchip: enable building this driver as
 a module
Message-ID: <Y7791U349F7224sN@spud>
References: <20230111125323.1911373-1-daire.mcnamara@microchip.com>
 <20230111125323.1911373-4-daire.mcnamara@microchip.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="8NGtDQC1ywbBiJk6"
Content-Disposition: inline
In-Reply-To: <20230111125323.1911373-4-daire.mcnamara@microchip.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--8NGtDQC1ywbBiJk6
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 11, 2023 at 12:53:15PM +0000, daire.mcnamara@microchip.com wrot=
e:
> From: Daire McNamara <daire.mcnamara@microchip.com>
>=20
> Enable building this driver as a module. The expected use case is the
> driver is built as a module, is installed when needed, and cannot be
> removed once installed.
>=20
> The remove() callback is not implemented as removing a driver with
> INTx and MSI interrupt handling is inherently unsafe.
>=20
> Link: https://lore.kernel.org/linux-pci/87y1wgbah8.wl-maz@kernel.org/
> Suggested-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> Signed-off-by: Daire McNamara <daire.mcnamara@microchip.com>

Perhaps, if nothing else crops up, Uwe's comment about the commit
message can be addressed on application?

Either way,
Acked-by: Conor Dooley <conor.dooley@microchip.com>

Thanks!

> ---
>  drivers/pci/controller/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/pci/controller/Kconfig b/drivers/pci/controller/Kcon=
fig
> index 76806dc52d1b..fd005b3f8a24 100644
> --- a/drivers/pci/controller/Kconfig
> +++ b/drivers/pci/controller/Kconfig
> @@ -291,7 +291,7 @@ config PCI_LOONGSON
>  	  Loongson systems.
> =20
>  config PCIE_MICROCHIP_HOST
> -	bool "Microchip AXI PCIe host bridge support"
> +	tristate "Microchip AXI PCIe host bridge support"
>  	depends on PCI_MSI
>  	select PCI_MSI_IRQ_DOMAIN
>  	select GENERIC_MSI_IRQ_DOMAIN
> --=20
> 2.25.1
>=20
>=20
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

--8NGtDQC1ywbBiJk6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCY7791QAKCRB4tDGHoIJi
0m/nAPwMHmifmKrAzgKpdjIRcCv4E8BlmGiCuvAFmegDA/5WDAD/YyEuq1GCkply
zzfRq/a8eQqNqX91PC/83+EXxXKRPQo=
=rtFX
-----END PGP SIGNATURE-----

--8NGtDQC1ywbBiJk6--
