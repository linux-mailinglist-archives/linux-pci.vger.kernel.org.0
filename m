Return-Path: <linux-pci+bounces-9732-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B652C92651E
	for <lists+linux-pci@lfdr.de>; Wed,  3 Jul 2024 17:41:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6EE26287A39
	for <lists+linux-pci@lfdr.de>; Wed,  3 Jul 2024 15:41:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAB9517E8EE;
	Wed,  3 Jul 2024 15:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CilsAVSC"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3617177980;
	Wed,  3 Jul 2024 15:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720021266; cv=none; b=JnM/bGI249/6uLIQH4tO9f9/ZYWflfaMV/iRSiclPgKkhkO1czmTVAR14kra2PaFngnxf99805pEiS1a4GT+waKe1nKfSIS20vFvE8BWHkVKmX9nA5XqypCcKw0qcK5gzc1/fp9GwsEOADmXspKfqboC9vb5wUFE3pZeRc+aBzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720021266; c=relaxed/simple;
	bh=qNF4mrVfx5AQWFS7p9pT6gLM7OgpbW8ynfjACZWYQr4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iL2yxeuEuC4KkSfPPijNxrLr35uov2d38XbhbGOU8U9xahAutHXobZXAgHrzosaHiGqU+gKO3+WgwRUT17Vga2zR0TvDI+YtedUR3KArD7qiX/XkjhNgHYBEtnQWZ+TmQWOzzkUv/HDgWtpfhdtxJgCHSAU+xgfkK9vS3EfUaKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CilsAVSC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03F73C2BD10;
	Wed,  3 Jul 2024 15:41:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720021266;
	bh=qNF4mrVfx5AQWFS7p9pT6gLM7OgpbW8ynfjACZWYQr4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CilsAVSCce0+7YMR2aIY6rC2xwsqNYF0VhQFcC4NQGmMt1G1d8L6njuKzrBU/STal
	 YAvgoT7PgSmtiuqka5F6BM/64fYA6SKSVbBIRkzbQNHKD6S9BRCyXyXkA4+dPaN9ud
	 AP0SiCCI6/ck4dOJJCU3j2wyh91lSveVAUV8UxLGcYlVu+0U/MQpnAAcTiqxdpJR5G
	 g0f4U8JzqMcXdZDFULUO6mYNMHklGEGvnDqZYZ0FvQLl+RzS3Wb1ihy33NcxRSac46
	 TxqgoISLpJ+hH/YSrU4/HMvwmiSNwFr421RQ9D1Pul+c6bSdbmLR+gA909gP7GcRM7
	 8SfRkqFn1RGXw==
Date: Wed, 3 Jul 2024 17:41:02 +0200
From: "lorenzo@kernel.org" <lorenzo@kernel.org>
To: Jianjun Wang =?utf-8?B?KOeOi+W7uuWGmyk=?= <Jianjun.Wang@mediatek.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"angelogioacchino.delregno@collabora.com" <angelogioacchino.delregno@collabora.com>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"nbd@nbd.name" <nbd@nbd.name>, "dd@embedd.com" <dd@embedd.com>,
	"robh@kernel.org" <robh@kernel.org>, "kw@linux.com" <kw@linux.com>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"krzysztof.kozlowski+dt@linaro.org" <krzysztof.kozlowski+dt@linaro.org>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	"lpieralisi@kernel.org" <lpieralisi@kernel.org>,
	Ryder Lee <Ryder.Lee@mediatek.com>,
	"lorenzo.bianconi83@gmail.com" <lorenzo.bianconi83@gmail.com>,
	upstream <upstream@airoha.com>
Subject: Re: [PATCH v3 4/4] PCI: mediatek-gen3: Add Airoha EN7581 support
Message-ID: <ZoVxDgxqH9pxlcjN@lore-desk>
References: <cover.1719668763.git.lorenzo@kernel.org>
 <27d28fabbf761e7a38bc6c8371234bf6a6462473.1719668763.git.lorenzo@kernel.org>
 <d04c396556612307b690c07a9b3fda7f0d4238ee.camel@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="/ROTeEc7ctHaENRg"
Content-Disposition: inline
In-Reply-To: <d04c396556612307b690c07a9b3fda7f0d4238ee.camel@mediatek.com>


--/ROTeEc7ctHaENRg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On Sat, 2024-06-29 at 15:51 +0200, Lorenzo Bianconi wrote:
> >  	=20
> > External email : Please do not click links or open attachments until
> > you have verified the sender or the content.
> >  Introduce support for Airoha EN7581 PCIe controller to mediatek-gen3
> > PCIe controller driver.
> >=20
> > Reviewed-by: AngeloGioacchino Del Regno <
> > angelogioacchino.delregno@collabora.com>
> > Tested-by: Zhengping Zhang <zhengping.zhang@airoha.com>
> > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> > ---
> >  drivers/pci/controller/Kconfig              |   2 +-
> >  drivers/pci/controller/pcie-mediatek-gen3.c | 108
> > +++++++++++++++++++-
> >  2 files changed, 108 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/drivers/pci/controller/Kconfig
> > b/drivers/pci/controller/Kconfig
> > index e534c02ee34f..3bd6c9430010 100644
> > --- a/drivers/pci/controller/Kconfig
> > +++ b/drivers/pci/controller/Kconfig
> > @@ -196,7 +196,7 @@ config PCIE_MEDIATEK
> > =20
> >  config PCIE_MEDIATEK_GEN3
> >  	tristate "MediaTek Gen3 PCIe controller"
> > -	depends on ARCH_MEDIATEK || COMPILE_TEST
> > +	depends on ARCH_AIROHA || ARCH_MEDIATEK || COMPILE_TEST
> >  	depends on PCI_MSI
> >  	help
> >  	  Adds support for PCIe Gen3 MAC controller for MediaTek SoCs.
> > diff --git a/drivers/pci/controller/pcie-mediatek-gen3.c
> > b/drivers/pci/controller/pcie-mediatek-gen3.c
> > index 438a5222d986..f3f76d1bfd4c 100644
> > --- a/drivers/pci/controller/pcie-mediatek-gen3.c
> > +++ b/drivers/pci/controller/pcie-mediatek-gen3.c
> > @@ -7,6 +7,7 @@
> >   */
> > =20
> >  #include <linux/clk.h>
> > +#include <linux/clk-provider.h>
> >  #include <linux/delay.h>
> >  #include <linux/iopoll.h>
> >  #include <linux/irq.h>
> > @@ -15,6 +16,8 @@
> >  #include <linux/kernel.h>
> >  #include <linux/module.h>
> >  #include <linux/msi.h>
> > +#include <linux/of_device.h>
> > +#include <linux/of_pci.h>
> >  #include <linux/pci.h>
> >  #include <linux/phy/phy.h>
> >  #include <linux/platform_device.h>
> > @@ -29,6 +32,12 @@
> >  #define PCI_CLASS(class)		(class << 8)
> >  #define PCIE_RC_MODE			BIT(0)
> > =20
> > +#define PCIE_EQ_PRESET_01_REG		0x100
> > +#define PCIE_VAL_LN0_DOWNSTREAM		GENMASK(6, 0)
> > +#define PCIE_VAL_LN0_UPSTREAM		GENMASK(14, 8)
> > +#define PCIE_VAL_LN1_DOWNSTREAM		GENMASK(22, 16)
> > +#define PCIE_VAL_LN1_UPSTREAM		GENMASK(30, 24)
> > +
> >  #define PCIE_CFGNUM_REG			0x140
> >  #define PCIE_CFG_DEVFN(devfn)		((devfn) & GENMASK(7,
> > 0))
> >  #define PCIE_CFG_BUS(bus)		(((bus) << 8) & GENMASK(15, 8))
> > @@ -68,6 +77,14 @@
> >  #define PCIE_MSI_SET_ENABLE_REG		0x190
> >  #define PCIE_MSI_SET_ENABLE		GENMASK(PCIE_MSI_SET_NUM - 1,
> > 0)
> > =20
> > +#define PCIE_PIPE4_PIE8_REG		0x338
> > +#define PCIE_K_FINETUNE_MAX		GENMASK(5, 0)
> > +#define PCIE_K_FINETUNE_ERR		GENMASK(7, 6)
> > +#define PCIE_K_PRESET_TO_USE		GENMASK(18, 8)
> > +#define PCIE_K_PHYPARAM_QUERY		BIT(19)
> > +#define PCIE_K_QUERY_TIMEOUT		BIT(20)
> > +#define PCIE_K_PRESET_TO_USE_16G	GENMASK(31, 21)
> > +
> >  #define PCIE_MSI_SET_BASE_REG		0xc00
> >  #define PCIE_MSI_SET_OFFSET		0x10
> >  #define PCIE_MSI_SET_STATUS_OFFSET	0x04
> > @@ -100,7 +117,13 @@
> >  #define PCIE_ATR_TLP_TYPE_MEM		PCIE_ATR_TLP_TYPE(0)
> >  #define PCIE_ATR_TLP_TYPE_IO		PCIE_ATR_TLP_TYPE(2)
> > =20
> > -#define MAX_NUM_PHY_RESETS		1
> > +#define MAX_NUM_PHY_RESETS		3
> > +
> > +/* EN7581 */
> > +/* PCIe-PHY initialization delay in ms */
> > +#define PHY_INIT_TIME_MS		30
>=20
> Since we have already moved the PHY related settings to the PHY driver,
> can we also move this init time to the PHY driver?
>=20
> Thanks.

ack, I will do in the next revision.

Regards,
Lorenzo

>=20
> > +/* PCIe reset line delay in ms */
> > +#define PCIE_RESET_TIME_MS		100
> > =20
> >  struct mtk_gen3_pcie;
> >=20

--/ROTeEc7ctHaENRg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZoVxDgAKCRA6cBh0uS2t
rGfGAQDIriAbkLJknBu1tBTxYNqinQr+iUOxkoVRaXkkrIA5gQD/XIXKIQ7grira
ndUBnqqJrxPYzzTP0aN8DGTR2EaRFwk=
=E8/M
-----END PGP SIGNATURE-----

--/ROTeEc7ctHaENRg--

