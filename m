Return-Path: <linux-pci+bounces-9102-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2751491300B
	for <lists+linux-pci@lfdr.de>; Sat, 22 Jun 2024 00:06:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1087287907
	for <lists+linux-pci@lfdr.de>; Fri, 21 Jun 2024 22:06:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F65317DE04;
	Fri, 21 Jun 2024 22:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="taMpRQ6/"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3659117D8BE;
	Fri, 21 Jun 2024 22:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719007444; cv=none; b=gKBbADUkbjlMATyK6MKqPSdrXa3SkceOiibmcbJgLTT/9Z6zY7p7KOipUHFEuevdiV8rSOfHS6oMKkcXFJXv1+pqh2zUGQoH+uglGlYncXokuZa9gLfiueIyEXzRYClazAmCp0a46I593Imv+CP9cbVhxmrd1y9i/R9wuBUMSA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719007444; c=relaxed/simple;
	bh=/Du/16Fm/7+7K5Nz0r9Yf9xRXhOT4EhavnWXHlF818E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n2yL0HYT47/kcNFHwIRIAXSYrCrdks4PJMyqlt5K156sZPR3XTX/1V8wCk4KefHTVtf0Y+mmlI4v1IJQ4gDPKi3k8TuAQYugRsm8SMglnPVYdV0Fdn2K0dFQCavRSnDgpUTzpXN/sFLsk2aigfdtBBhGvbhHrMVG9YcGt/gdt7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=taMpRQ6/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50967C2BBFC;
	Fri, 21 Jun 2024 22:04:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719007442;
	bh=/Du/16Fm/7+7K5Nz0r9Yf9xRXhOT4EhavnWXHlF818E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=taMpRQ6/ggVqSTEK+68ZtBCvG2LgqjACMZG1EKqG0Cda0bAKNqcQc3mvY2oAmplnh
	 MoLkzjgsGzWrmf5zxDT8BaYrH7JNt37zF+eY+7RD2JB+hIN7PwkPuSCXlzk0epeiCc
	 v5Ik6vrsXVv96RLpWv5NkV004zn4/wUX8FnrUoM2M+ikI4K5BYXOl105a8d6/pWqxF
	 Nfk9r5W6cn3COgxuiHICz7exkRHU5f08ttTxS5Z4mCnAQdRpKPs4ZXUDTpVcBp2712
	 ji87ROWGTCX4pacYhBfneURF0XAq/lR6g68708osiQkggdOH6zdUxxySlRhzD8PydQ
	 KjbAq2PxN25MQ==
Date: Sat, 22 Jun 2024 00:03:59 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org, ryder.lee@mediatek.com,
	lpieralisi@kernel.org, kw@linux.com, robh@kernel.org,
	bhelgaas@google.com, linux-mediatek@lists.infradead.org,
	lorenzo.bianconi83@gmail.com, linux-arm-kernel@lists.infradead.org,
	krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org,
	nbd@nbd.name, dd@embedd.com, upstream@airoha.com,
	angelogioacchino.delregno@collabora.com
Subject: Re: [PATCH 4/4] PCI: mediatek-gen3: Add Airoha EN7581 support
Message-ID: <ZnX4z9-UxXYdyBPT@lore-desk>
References: <f044eb44654522801d4a93e94918a32c72c4c49f.1718980864.git.lorenzo@kernel.org>
 <20240621180250.GA1396831@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="3EmFiM8r3ZH3wxen"
Content-Disposition: inline
In-Reply-To: <20240621180250.GA1396831@bhelgaas>


--3EmFiM8r3ZH3wxen
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On Fri, Jun 21, 2024 at 04:48:50PM +0200, Lorenzo Bianconi wrote:
> > Introduce support for Airoha EN7581 pcie controller to mediatek-gen3
> > pcie controller driver.
>=20
> s/pcie/PCIe/ (twice)
>=20

ack, I will fix them in v2

> > Tested-by: Zhengping Zhang <zhengping.zhang@airoha.com>
> > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> > ---
> >  drivers/pci/controller/Kconfig              |  2 +-
> >  drivers/pci/controller/pcie-mediatek-gen3.c | 84 ++++++++++++++++++++-
> >  2 files changed, 84 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/drivers/pci/controller/Kconfig b/drivers/pci/controller/Kc=
onfig
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
> > diff --git a/drivers/pci/controller/pcie-mediatek-gen3.c b/drivers/pci/=
controller/pcie-mediatek-gen3.c
> > index 9842617795a9..2dacfed665c6 100644
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
> > @@ -21,6 +22,8 @@
> >  #include <linux/pm_domain.h>
> >  #include <linux/pm_runtime.h>
> >  #include <linux/reset.h>
> > +#include <linux/of_pci.h>
> > +#include <linux/of_device.h>
>=20
> Existing list of includes is sorted.  Preserve that sorted order.

ack, I will fix them in v2

>=20
> > +static int mtk_pcie_en7581_power_up(struct mtk_gen3_pcie *pcie)
> > +{
> > +	struct device *dev =3D pcie->dev;
> > +	int err;
> > +
> > +	writel_relaxed(0x23020133, pcie->base + 0x10044);
> > +	writel_relaxed(0x50500032, pcie->base + 0x15030);
> > +	writel_relaxed(0x50500032, pcie->base + 0x15130);
>=20
> Magic.  Needs #defines at least for the registers.  These offsets are
> HUGE, far bigger than the existing offsets:

ack. Anyway they are in pcie mapped regions (I have not posted the dts chan=
ges
yet):

pcie0: reg =3D <0x0 0x1fc00000 0x0 0x20000>;
pcie1: reg =3D <0x0 0x1fc20000 0x0 0x20000>;

But they are undocumented. I will try to get some info for them.

>=20
>   #define PCIE_CFGNUM_REG                 0x140
>   #define PCIE_CFG_OFFSET_ADDR            0x1000
>   #define PCIE_TRANS_TABLE_BASE_REG       0x800
>   #define PCIE_MSI_SET_BASE_REG           0xc00
>   #define PCIE_MSI_SET_ADDR_HI_BASE       0xc80
>   #define PCIE_MSI_SET_ENABLE_REG         0x190
>   #define PCIE_INT_ENABLE_REG             0x180
>   #define PCIE_SETTING_REG                0x80
>   #define PCIE_PCI_IDS_1                  0x9c
>   #define PCIE_MISC_CTRL_REG              0x348
>   #define PCIE_RST_CTRL_REG               0x148
>   #define PCIE_LINK_STATUS_REG            0x154
>   #define PCIE_LTSSM_STATUS_REG           0x150
>   #define PCIE_INT_STATUS_REG             0x184
>=20
> > +	err =3D phy_init(pcie->phy);
> > +	if (err) {
> > +		dev_err(dev, "failed to initialize PHY\n");
> > +		return err;
> > +	}
> > +	mdelay(30);
>=20
> Source?  Cite the spec that requires this delay and add a #define if
> possible.

They are undocumented in the vendor sdk, I will try some info for them (and
even for the ones below).

Regards,
Lorenzo

>=20
> > +	err =3D phy_power_on(pcie->phy);
> > +	if (err) {
> > +		dev_err(dev, "failed to power on PHY\n");
> > +		goto err_phy_on;
> > +	}
> > +
> > +	err =3D reset_control_bulk_deassert(pcie->soc->phy_resets.num_rsts,
> > +					  pcie->phy_resets);
> > +	if (err) {
> > +		dev_err(dev, "failed to deassert PHYs\n");
> > +		goto err_phy_deassert;
> > +	}
> > +	usleep_range(5000, 10000);
>=20
> Source?
>=20
> > +	pm_runtime_enable(dev);
> > +	pm_runtime_get_sync(dev);
> > +
> > +	err =3D clk_bulk_prepare(pcie->num_clks, pcie->clks);
> > +	if (err) {
> > +		dev_err(dev, "failed to prepare clock\n");
> > +		goto err_clk_prepare;
> > +	}
> > +
> > +	writel_relaxed(0x41474147, pcie->base + PCIE_EQ_PRESET_01_REF);
> > +	writel_relaxed(0x1018020f, pcie->base + PCIE_PIPE4_PIE8_REG);
> > +	mdelay(10);
>=20
> Source?

--3EmFiM8r3ZH3wxen
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZnX4zgAKCRA6cBh0uS2t
rLeCAQCFBOcP+pRhRD/u3Qw4FOgCe5z9/sbvOwpJaImvU67BlAD/XMMbMXVmeSDQ
r6i2QxAtvWovWR/oUbE94cvwl082LgE=
=kaKN
-----END PGP SIGNATURE-----

--3EmFiM8r3ZH3wxen--

