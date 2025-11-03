Return-Path: <linux-pci+bounces-40137-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0568BC2DC6D
	for <lists+linux-pci@lfdr.de>; Mon, 03 Nov 2025 20:01:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B34FC3BC53E
	for <lists+linux-pci@lfdr.de>; Mon,  3 Nov 2025 19:01:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D732BBA45;
	Mon,  3 Nov 2025 19:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b="ZznU2pnB"
X-Original-To: linux-pci@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C2062CCC5;
	Mon,  3 Nov 2025 19:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762196487; cv=pass; b=WwtbeozBtBUXtqZvftJpjlSh6OqSHkkXnySGTEt3Dxxy8ba9Tu7L+R5Ym51CSej6ADrrFD7x0+krOdC77IIavzHJtkBSdtzBFssNK543FjgbAvi5OePNQWBpJT1c7YEqLZQXFUlS5oCHxVS1IxfifAtl+0CQnrNolkJ8fepMOy4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762196487; c=relaxed/simple;
	bh=yJC87dA8BpOjpzyrYOBsDmH+6xNqhPdamuFM53Bv7q4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TVozm/a9S52gN7XMKuZ7vQuHsHVgQCaYVeriXYRY+APCVhBzKfMQSZDcKdX5pSxR57ZsOfDrfQ64OLlPstx7Lw7TfQRZs7u6uupVXP7M7b965EpcoYrTivkec4TOTyakUJ6GK5OCaN4XgJOV3oWKQB80jTF2+9cLcmgOXCvE2vo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b=ZznU2pnB; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1762196454; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=MzqOKhqJa9gC88iyxwI7s7fOQZnWvoV2aM/+RTvqDD4mxXfEG9LJjtR77alZUHm51ui76ALrT4oZnwufmrcsxbzVI0epHtG0v5MqEI4+14qZGLF8yOjXVyyF9iuPy+3DB2g/wQiAA9J9qiuiRb/xXUO7O+f8n5KJDiA2k0gujaY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1762196454; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=kNKSQa2kVwPMCXQR0sV5pA6zP64EIfrRIVHoLe4gYdQ=; 
	b=m6OfssqaUlgY2ekPgKcnW3P4V+DvM9hzZewH/Gqv+pX1zvhRsxV0eo6xjg6BiGlxl1wOlvDHCvsJacxXoJBcH1PijR1x6dSbsG8/VtrSUmMlKK/byLu7wqtP1w0ZhX9dz1aKpTmmZbc1nMgxu4xIioKh7EAm5zrJt6i1nu064Pk=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=sebastian.reichel@collabora.com;
	dmarc=pass header.from=<sebastian.reichel@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1762196454;
	s=zohomail; d=collabora.com; i=sebastian.reichel@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=kNKSQa2kVwPMCXQR0sV5pA6zP64EIfrRIVHoLe4gYdQ=;
	b=ZznU2pnBIg9Gek3PXRc/sHRorf7yD0gfJO5ILLjdlMkhoGZjhT1jwHCDmr39QeFF
	up9KK+Xao29K3w11ICC/knQW/kSjMsWUzKNFd7rQu8fRssEDiHx9dfkgjqD+//d+aZF
	YseptpAb4jRSdCE95LGYit0MeyK3huyXFpwhHrZ0=
Received: by mx.zohomail.com with SMTPS id 1762196452142381.11883699950636;
	Mon, 3 Nov 2025 11:00:52 -0800 (PST)
Received: by venus (Postfix, from userid 1000)
	id D186A182F6B; Mon, 03 Nov 2025 20:00:45 +0100 (CET)
Date: Mon, 3 Nov 2025 20:00:45 +0100
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Heiko Stuebner <heiko@sntech.de>, Philipp Zabel <p.zabel@pengutronix.de>, 
	Jingoo Han <jingoohan1@gmail.com>, Shawn Lin <shawn.lin@rock-chips.com>, linux-pci@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, 
	kernel@collabora.com
Subject: Re: [PATCH v4 9/9] PCI: dwc: support missing PCIe device on resume
Message-ID: <s67opnadijrebativ27oiofub5cgr3lbclhxnmwnqrkltweqqj@j4douhswobsv>
References: <20251029-rockchip-pcie-system-suspend-v4-0-ce2e1b0692d2@collabora.com>
 <20251029-rockchip-pcie-system-suspend-v4-9-ce2e1b0692d2@collabora.com>
 <dc230a62-bd31-450a-9acd-fa654f694b3a@oss.qualcomm.com>
 <qlil44i7ywwxurdfovkbqvvjff7dey53uy5hzq4zbmvg7jg54o@zdg27w4q26gr>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="obly2eyx2h24unc2"
Content-Disposition: inline
In-Reply-To: <qlil44i7ywwxurdfovkbqvvjff7dey53uy5hzq4zbmvg7jg54o@zdg27w4q26gr>
X-Zoho-Virus-Status: 1
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-1.5.1/262.144.53
X-ZohoMailClient: External


--obly2eyx2h24unc2
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v4 9/9] PCI: dwc: support missing PCIe device on resume
MIME-Version: 1.0

Hi,

On Sat, Nov 01, 2025 at 07:50:58PM +0530, Manivannan Sadhasivam wrote:
> On Thu, Oct 30, 2025 at 11:07:19AM +0530, Krishna Chaitanya Chundru wrote:
> >=20
> > On 10/29/2025 11:26 PM, Sebastian Reichel wrote:
> > > When dw_pcie_resume_noirq() is called for a PCIe root complex for a P=
CIe
> > > slot with no device plugged on Rockchip RK3576, dw_pcie_wait_for_link=
()
> > > will return -ETIMEDOUT. During probe time this does not happen, since
> > > the platform sets 'use_linkup_irq'.
> > >=20
> > > This adds the same logic from dw_pcie_host_init() to the PM resume
> > > function to avoid the problem.
> > >=20
> > > Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> > > ---
> > >   drivers/pci/controller/dwc/pcie-designware-host.c | 13 ++++++++++---
> > >   1 file changed, 10 insertions(+), 3 deletions(-)
> > >=20
> > > diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/driv=
ers/pci/controller/dwc/pcie-designware-host.c
> > > index e92513c5bda5..f25f1c136900 100644
> > > --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> > > +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> > > @@ -1215,9 +1215,16 @@ int dw_pcie_resume_noirq(struct dw_pcie *pci)
> > >   	if (ret)
> > >   		return ret;
> > > -	ret =3D dw_pcie_wait_for_link(pci);
> > > -	if (ret)
> > > -		return ret;
> > > +	/*
> > > +	 * Note: Skip the link up delay only when a Link Up IRQ is present.
> > > +	 * If there is no Link Up IRQ, we should not bypass the delay
> > > +	 * because that would require users to manually rescan for devices.
> > > +	 */
> >=20
> > In the resume scenario, we should explicitly wait for the link to be up,
> > there is no IRQ support at this resume phase
>=20
> This could be fixed if the PM handlers are moved to non-no_irq ones.
>=20
> > and secondly after controller resume pm framework will start resuming t=
he
> > bridges & endpoints. what happens
> > if the link is not up by the time endpoint is resume is called. And ent=
ire
> > save & restore states might also gets messed up.
> > There will be no way to recover from this.
> >=20
>=20
> This is true if there were any devices connected to the bus during suspen=
d. If
> there were no devices, then it is fine to skip waiting for the link to be=
 up.

I thought about setting a flag in the suspend routine, that a device
is expected to be there at resume time. But I suppose it might also
have been removed during the system suspend?

Greetings,

-- Sebastian

--obly2eyx2h24unc2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmkI+90ACgkQ2O7X88g7
+pqgZg/9EF9L7gEKTe0tDzzOUncD96XuMsIlIRBt+9Mjsdfd7Xr5Rbr4K0h1lEy6
Ul6KCQTMonZt0skafLBp3yAiv3rGJsZonOjHtFMsOUNeW+fCH8Ifvp2TqW/1blih
SJ85klUOM9ShsN42FYcQBfRMHjCFmh1/A5jAgLsT3hlTAWAsBa1PXUd3HAkH4n0P
cFdNs3+Wlk5FqDY7/xVCUcSEg8Hvfa/VTFbzZrRe6f9E0+tZF/K+rOt5ItRE8WM0
fRTDnExoYbrwOtkyDjHv5eKLNnZ+Ak4SZX4Td5A+Fk+GhAC8tfOXw5i1qbY4PskL
vFpUcKUtaKgeAj4aZjuVd2yYOnY8VnuGv7YSa4FAkvNPWufhg/yuVngdqTB1tgR1
wc5Omt3x/YJzSLl3CYGXTrSnvS1PHYQrOE6kS0mikj/k9h71VYoY7UgpnbryaGjK
Yl7zrqY5qHsEOLXvrrxrGuRqsG6cPJDLnU+3abanBEKd+lcqMKwyFpoaVmWaWkNO
3Fdo7XDpitfwzxu96ZxOZgNFsazcovjlziFQnOSNmFdBsiJXsfDapLX4rQqjdrDn
zFpgCaCCVohNfAAuVq1K1FnH/8z8o6NicAy7rJMCBs8jXw3IpJdfHbT8f3JDNl3r
AsAHt4gzUND2Jtbwu6zpOaZdLgnQqvbfM+yN1NtiCqhxdEKKtOM=
=SFK4
-----END PGP SIGNATURE-----

--obly2eyx2h24unc2--

