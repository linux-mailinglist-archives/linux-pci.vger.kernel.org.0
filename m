Return-Path: <linux-pci+bounces-40136-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B55BC2DC51
	for <lists+linux-pci@lfdr.de>; Mon, 03 Nov 2025 19:59:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 564EB3B97CC
	for <lists+linux-pci@lfdr.de>; Mon,  3 Nov 2025 18:59:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FFB32D1F64;
	Mon,  3 Nov 2025 18:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b="JEL+pbhc"
X-Original-To: linux-pci@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1EF886352;
	Mon,  3 Nov 2025 18:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762196345; cv=pass; b=EmsF9ZS0ytI5GqOIij2PZlLN+L5uX32RvP0kw4B3mW73a8NqVacygkiP4GIYzoFUmJSTQKX4z0NFGKhsw3XsJL2mnAi5rupKlTEcWICBF0oC52pVAR+IzkTyy0/NnAj1DfEUZouV4ewd3LsOvOO2OeC/LxYTW1T46q/jdrD7hvI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762196345; c=relaxed/simple;
	bh=1e/8NtdhqFQR+0vCrqeS3gizrB4dGEQBUO7vC2OBnIw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G7C306iki4dn6Vhi5FvCY9GDZFy/APZ9CHNkb/05wKIZ7iy5bPux4quRMPR24bL6fzTofU2RaqpvXatGXrlVoyPTLhjJBbfWnY1ESxNrtmik09dz4m+LsayunLFlTiQifO7y5FAyMH0i3ojb1TQyitZZbxQwrpEgO0aDpqBsiRE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b=JEL+pbhc; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1762196309; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=ECZ5ky1XIV0JIuHY1wM6bR4Fz/1Giq+pDGCzXa9Z3sWbSoUeY0PHBoChGWvCJ4JAbwuYi3gZxo0UJU0u2XxCdOlONoKWkV4o/Gv/1GhZoIc2I3bjUuEafX/6gyhPjWPstwwuWibtn7awGSywvEWRzriZGnxBeo3hq6CNp4c79S4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1762196309; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=TH3yqasRfeQp6b3ZhZZ90WJQERq/LUl+1qHlgx+8ZXs=; 
	b=fsIgd0NUr4/4QeEEF4PQgtQ+ibnEa3SUpdY6D0BCpAyIP9WMyrWsMnjbxqu5C4sXfH8yKPGpUqhaV7jed6E/HHriPsSDmTN+NaGHJ0eCQQH1RVL+cz84uXoQQ7OaT31ASndcLT5KENsVgmtY6vpVtED77rTUIVr/oh/z1YwV4tA=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=sebastian.reichel@collabora.com;
	dmarc=pass header.from=<sebastian.reichel@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1762196309;
	s=zohomail; d=collabora.com; i=sebastian.reichel@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=TH3yqasRfeQp6b3ZhZZ90WJQERq/LUl+1qHlgx+8ZXs=;
	b=JEL+pbhcacBrS2/IZygPnbXLt15rbdGjSWuG1ZFJ1pALljMiGdrpgzs+z3jwHb2H
	ahR7hg6Yus31v2V8Gu7kkDIgn692MpgMeAgZcJXFfzjOjrHDeLx56nb0dB2GNX2ceqc
	UKqklgSyWO994ahNem59jfizGoF0cPe6jdT8dswU=
Received: by mx.zohomail.com with SMTPS id 1762196306239659.8542788627383;
	Mon, 3 Nov 2025 10:58:26 -0800 (PST)
Received: by venus (Postfix, from userid 1000)
	id CF49B182F6B; Mon, 03 Nov 2025 19:58:15 +0100 (CET)
Date: Mon, 3 Nov 2025 19:58:15 +0100
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Rob Herring <robh@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Heiko Stuebner <heiko@sntech.de>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Jingoo Han <jingoohan1@gmail.com>, 
	Shawn Lin <shawn.lin@rock-chips.com>, linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, kernel@collabora.com
Subject: Re: [PATCH v4 0/9] PCI: dw-rockchip: add system suspend support
Message-ID: <cbvcjgcd7saxj42ifgqn3l6mwpgenlhbr4zuf5ibqbtj6rmzqh@yuc7flbwyi2y>
References: <20251029-rockchip-pcie-system-suspend-v4-0-ce2e1b0692d2@collabora.com>
 <cf6zumlp4iiltglu7bbrpdeysaznrkyvlemwl4lxwkfjkgux7a@wl37bxilsprx>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="efzunfkzasasexir"
Content-Disposition: inline
In-Reply-To: <cf6zumlp4iiltglu7bbrpdeysaznrkyvlemwl4lxwkfjkgux7a@wl37bxilsprx>
X-Zoho-Virus-Status: 1
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-1.5.1/262.144.53
X-ZohoMailClient: External


--efzunfkzasasexir
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v4 0/9] PCI: dw-rockchip: add system suspend support
MIME-Version: 1.0

Hi,

On Sat, Nov 01, 2025 at 07:29:41PM +0530, Manivannan Sadhasivam wrote:
> On Wed, Oct 29, 2025 at 06:56:39PM +0100, Sebastian Reichel wrote:
> > I've recently been working on fixing up at least basic system suspend
> > support on the Rockchip RK3576 platform. Currently the biggest open
> > issue is missing support in the PCIe driver. This series is a follow-up
> > for Shawn Lin's series with feedback from Niklas Cassel and Manivannan
> > Sadhasivam being handled as well as some of my own changes fixing up
> > things I noticed.
> >=20
> > In opposite to Shawn Lin I did not test with different peripherals as my
> > main goal is getting basic suspend to ram working in the first place.
>=20
> Wouldn't it break users who have connected endpoint devices and suspend t=
heir
> platform? I don't want to have an untested feature that could potentially=
 cause
> regressions, just for the sake of getting basic system PM.
>
> But if your goal is to just add basic system PM operations for CI
> testing, then I would suggest you to do something minimal in the
> suspend/resume path that don't disrupt the operation of a device.
>
> But this also should be tested with some devices for sanity.

My goal is proper system PM support, but I would like to go step by
step. Right now system suspend on the Rockchip RK3576 EVB just hangs
the board and it has to be power cycled afterwards. In parallel to
this series I've send a bunch of fixes to get it working. It surely
isn't perfect, but I fear things regressing again in other areas while
the complex PCIe system sleep is being worked on - simply blocking system
suspend is not very helpful, since it effectively hides suspend problems.

Greetings,

-- Sebastian


> - Mani
>=20
> > I did notice issues with the Broadcom WLAN card on the RK3576 EVB.
> > Suspending that platform without a driver being probed works, but after
> > probing brcmfmac suspend is aborted because brcmf_pcie_pm_enter_D3()
> > does not work. As far as I can tell the problem is unrelated to the
> > Rockchip PCIe driver.
> >=20
> > Changes since PATCHv3:
> >  * https://lore.kernel.org/linux-pci/1744940759-23823-1-git-send-email-=
shawn.lin@rock-chips.com/
> >  * rename rockchip_pcie_get_ltssm to rockchip_pcie_get_ltssm_status_reg
> >    in a separate patch (Niklas Cassel)
> >  * rename rockchip_pcie_get_pure_ltssm to rockchip_pcie_get_ltssm_state
> >    in a separate patch (Niklas Cassel)
> >  * Move devm_phy_get out of phy_init to probe in a separate patch
> >    (Manivannan Sadhasivam)
> >  * Add helper function for enhanced LTSSM control mode in a separate pa=
tch
> >    (Niklas Cassel)
> >  * Add helper function for controller mode in a separate patch
> >    (Niklas Cassel)
> >  * Add helper function for DDL indicator in a separate patch
> >    (Niklas Cassel)
> >  * Move rockchip_pcie_pme_turn_off implementation in a separate patch
> >  * Rebase to v6.18-rc3 using new FIELD_PREP_WM16()
> >  * Improve readability of PME_TURN_OFF/PME_TO_ACK defines (Manivannan S=
adhasivam)
> >  * Fix usage of reverse Xmas (Manivannan Sadhasivam)
> >  * Assert PERST# before turning off other resources (Manivannan Sadhasi=
vam)
> >  * Improve some error messages (Manivannan Sadhasivam)
> >  * Rename goto labels as per their purpose (Manivannan Sadhasivam)
> >  * Add extra patch for dw_pcie_resume_noirq, since I've seen errors
> >    during resume on boards not having anything plugged into their PCIe
> >    port
> >=20
> > Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> > ---
> > Sebastian Reichel (9):
> >       PCI: dw-rockchip: Rename rockchip_pcie_get_ltssm function
> >       PCI: dw-rockchip: Support get_ltssm operation
> >       PCI: dw-rockchip: Move devm_phy_get out of phy_init
> >       PCI: dw-rockchip: Add helper function for enhanced LTSSM control =
mode
> >       PCI: dw-rockchip: Add helper function for controller mode
> >       PCI: dw-rockchip: Add helper function for DDL indicator
> >       PCI: dw-rockchip: Add pme_turn_off support
> >       PCI: dw-rockchip: Add system PM support
> >       PCI: dwc: support missing PCIe device on resume
> >=20
> >  drivers/pci/controller/dwc/pcie-designware-host.c |  13 +-
> >  drivers/pci/controller/dwc/pcie-dw-rockchip.c     | 220 ++++++++++++++=
++++----
> >  2 files changed, 198 insertions(+), 35 deletions(-)
> > ---
> > base-commit: dcb6fa37fd7bc9c3d2b066329b0d27dedf8becaa
> > change-id: 20251028-rockchip-pcie-system-suspend-86cf08a7b229
> >=20
> > Best regards,
> > --=20
> > Sebastian Reichel <sebastian.reichel@collabora.com>
> >=20
>=20
> --=20
> =E0=AE=AE=E0=AE=A3=E0=AE=BF=E0=AE=B5=E0=AE=A3=E0=AF=8D=E0=AE=A3=E0=AE=A9=
=E0=AF=8D =E0=AE=9A=E0=AE=A4=E0=AE=BE=E0=AE=9A=E0=AE=BF=E0=AE=B5=E0=AE=AE=
=E0=AF=8D

--efzunfkzasasexir
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmkI+0AACgkQ2O7X88g7
+prV+A//fQ0srBn/Fw9erSz5jCHGcnolpEsDLgEyrQJk1RJCL/9n1NxofTJ39UZA
mMxrahRzui2C0+oksXBBDLsmyZjEWLy7iocK1IkYP/kVfEKt6+T0hgptbpMfRuDM
ZhTjsADyyil56eDAq98haf2lx6mGC8DzGBsA1a4Wo/E0K5xLplvffqfHZXG+65mx
2DcdDu3sg5AXe8V0aYJuLolATBPheyYZNLOQaG+xaptTJzOeps3dGfe4UM5FkYX8
udk6t7RUpmCb/QiwSFKOsVGlYM7B4M2jZhSzKKFWdGMs1UIsC2ql3claFHLlaGsW
3kkIxRcLAex7hICDghnYejcifCd2WyVgtfrgZien4y68wHYbtF907aLWS2wDnNZ9
+uj7k44Hl6+PhKu2nANq0DlXnq/Gx7Y9tkoZ44lbJ7h5vo7E9K7QCw3JAn+nyUFE
9QyuBK/ytyFwIJkyRKcGbXLFfKHI79fSPbcFekV38KxoAyc92APXHuc+A1Fw2nt/
30LSXpSCd4oqk4PYx80HfsNCDFjE6QZMatquSs0cygiYBQB4IdE+tvb9UWjqkZFI
ZtjxM8W7K+HPe8Ge4EqzKhFANXXdr4ICLLyhultkekTs7AgMBTZurm7i3/txah9E
uGkw3GK0kORPW3X7b/CbryDlucHLpNlM+EDOv03k+f/lAYCOFqM=
=tUN5
-----END PGP SIGNATURE-----

--efzunfkzasasexir--

