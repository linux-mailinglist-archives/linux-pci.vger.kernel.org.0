Return-Path: <linux-pci+bounces-30631-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 187EAAE8930
	for <lists+linux-pci@lfdr.de>; Wed, 25 Jun 2025 18:07:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DEB883A8F65
	for <lists+linux-pci@lfdr.de>; Wed, 25 Jun 2025 16:06:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5914526A1AA;
	Wed, 25 Jun 2025 16:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="sFcLtMDj"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-10629.protonmail.ch (mail-10629.protonmail.ch [79.135.106.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCDE0170826
	for <linux-pci@vger.kernel.org>; Wed, 25 Jun 2025 16:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.29
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750867631; cv=none; b=FN+pa/evLUT7jk0e2Qsefzk2M3kuJc8vfiIocOYmOCaHnk1fUQ5JglKGR1mnXElOGE0t56x11sdvmWqPOZscaFCAwmIAFTeuqeoIOrwdA4Bhz0TbomjALl9IY6tx882f8Nr8DOh69kDSeAoAPU+XyE6dCl8oI2d/fgEaS5n0j98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750867631; c=relaxed/simple;
	bh=ZpfYCEWj8L+gcpCFc+GCQF6J305mSvJ6XjTNU93ElsM=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MMrHFlpSzIw97ShcNrB7Kz33lS5NYYharNqDtodw0I/XjsqlRW4eYkflwQlZrxlWsdEPCgFUa3zuJ6IwmV7r1Xwz4qYDV9hhuvTTaGu+xMq/f75PLpZzO/LoLbrbli4JgECpqm880Tk6+g1VL6ine+FJ11uV8Q/CQ1lXv1wVJ+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=sFcLtMDj; arc=none smtp.client-ip=79.135.106.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1750867626; x=1751126826;
	bh=ZpfYCEWj8L+gcpCFc+GCQF6J305mSvJ6XjTNU93ElsM=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=sFcLtMDjZQgAKsZzGLgyYNW/OWyjpoXos+6lPGwVBjEB7pz46gw6b1LTAmZ+Om7iu
	 osHAy+r74VCLYZC9XTiUqrXJK7xJdXKWCgaKo2POBbNLW9cgmO6tMdUAsvGYKwd42h
	 uNOU94ClyZw+v/p/YIIjrZYzeplC4XkuS841wIza3/9pe9TF00fQg0bKJgue5YYb/i
	 h+sT1ipM09Z/uGwbew5Ac0xVzHGw2l5fa7egiwGPODwMJbHS4GIMARv2K4t8ZcA+7h
	 PwO5lgkSmp9MqSGifYXe/80Iu/28HrAA1KIT7Iy3PQWb+NorioCuXdM2Qcn8Isn5JH
	 xB4Q2xpXrBwIA==
Date: Wed, 25 Jun 2025 16:06:58 +0000
To: Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>
From: andreasx0 <andreasx0@protonmail.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Lukas Wunner <lukas@wunner.de>, Ilpo Jarvinen <ilpo.jarvinen@linux.intel.com>, "Maciej W. Rozycki" <macro@orcam.me.uk>, Matthew W Carlis <mattc@purestorage.com>, linux-pci@vger.kernel.org, Jiwei Sun <sunjw10@lenovo.com>, Adrian Huang12 <ahuang12@lenovo.com>
Subject: Re: [PATCH] PCI: Fix link speed calculation on retrain failure
Message-ID: <9GZ44D4l8VOon-B2Uc15vxasiaSrnTLkvk18qrogb08_K_aCKBPOep6JxmMQRK8UuxTnv0ZxgxIOFA8v8e3yJZuVtLLPzZsmmwRc7BODcVs=@protonmail.com>
In-Reply-To: <b08df1b0-a2ba-402d-93b2-59cf03eff1df@linux.intel.com>
References: <20250624164846.GA1482201@bhelgaas> <b08df1b0-a2ba-402d-93b2-59cf03eff1df@linux.intel.com>
Feedback-ID: 4793980:user:proton
X-Pm-Message-ID: 0bb7f7cc28c9868810926456b4c2eb8e2a5fe5db
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha512; boundary="------29845f7e0471a4c7ac6daba8d4dbda20a30ddd563cfbaec68716f1cfc9c3495d"; charset=utf-8

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------29845f7e0471a4c7ac6daba8d4dbda20a30ddd563cfbaec68716f1cfc9c3495d
Content-Type: multipart/mixed;boundary=---------------------833a26fda0a9472d424a94c3043e9dea

-----------------------833a26fda0a9472d424a94c3043e9dea
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;charset=utf-8

Again. As said the patch from Lucas fixed the warning that was caused beca=
use the discrete nvidia gpu was disabled by bios.


On Tuesday, June 24th, 2025 at 21:13, Sathyanarayanan Kuppuswamy <sathyana=
rayanan.kuppuswamy@linux.intel.com> wrote:

> On 6/24/25 9:48 AM, Bjorn Helgaas wrote:
> =


> > [+cc Sathy, Jiwei, Adrian]
> > =


> > On Mon, Jun 23, 2025 at 03:22:14PM +0200, Lukas Wunner wrote:
> > =


> > > When pcie_failed_link_retrain() fails to retrain, it tries to revert=
 to
> > > the previous link speed. However it calculates that speed from the L=
ink
> > > Control 2 register without masking out non-speed bits first.
> > > =


> > > PCIE_LNKCTL2_TLS2SPEED() converts such incorrect values to
> > > PCI_SPEED_UNKNOWN, which in turn causes a WARN splat in
> > > pcie_set_target_speed():
> > > =


> > > pci 0000:00:01.1: [1022:14ed] type 01 class 0x060400 PCIe Root Port
> > > pci 0000:00:01.1: broken device, retraining non-functional downstrea=
m link at 2.5GT/s
> > > pci 0000:00:01.1: retraining failed
> > > WARNING: CPU: 1 PID: 1 at drivers/pci/pcie/bwctrl.c:168 pcie_set_tar=
get_speed
> > > RDX: 0000000000000001 RSI: 00000000000000ff RDI: ffff9acd82efa000
> > > pcie_failed_link_retrain
> > > pci_device_add
> > > pci_scan_single_device
> > > pci_scan_slot
> > > pci_scan_child_bus_extend
> > > acpi_pci_root_create
> > > pci_acpi_scan_root
> > > acpi_pci_root_add
> > > acpi_bus_attach
> > > device_for_each_child
> > > acpi_dev_for_each_child
> > > acpi_bus_attach
> > > device_for_each_child
> > > acpi_dev_for_each_child
> > > acpi_bus_attach
> > > acpi_bus_scan
> > > acpi_scan_init
> > > acpi_init
> > > =


> > > Per the calling convention of the System V AMD64 ABI, the arguments =
to
> > > pcie_set_target_speed(struct pci_dev *, enum pci_bus_speed, bool) ar=
e
> > > stored in RDI, RSI, RDX. As visible above, RSI contains 0xff, i.e.
> > > PCI_SPEED_UNKNOWN.
> > > =


> > > Fixes: f68dea13405c ("PCI: Revert to the original speed after PCIe f=
ailed link retraining")
> > > Reported-by: Andrew andreasx0@protonmail.com
> > > Closes: https://lore.kernel.org/r/7iNzXbCGpf8yUMJZBQjLdbjPcXrEJqBxy5=
-bHfppz0ek-h4_-G93b1KUrm106r2VNF2FV_sSq0nENv4RsRIUGnlYZMlQr2ZD2NyB5sdj5aU=3D=
@protonmail.com/
> > > Signed-off-by: Lukas Wunner lukas@wunner.de
> > > Cc: stable@vger.kernel.org # v6.12+
> > > I like the brevity of this patch, but I do worry that if we ever hav=
e
> > > other users of PCIE_LNKCTL2_TLS2SPEED(), we might have the same
> > > problem again.
> > =


> > Also, it looks like PCIE_LNKCAP_SLS2SPEED() has the same problem.
> > =


> > f68dea13405c predates PCIE_LNKCTL2_TLS2SPEED(), and I don't think this
> > problem existed as of f68dea13405c. I think the Fixes: tag should be
> > for de9a6c8d5dbf ("PCI/bwctrl: Add pcie_set_target_speed() to set PCIe
> > Link Speed"), which added PCIE_LNKCTL2_TLS2SPEED() and
> > PCIE_LNKCAP_SLS2SPEED() without masking out the other bits.
> > =


> > I think I'll take Jiwei's patch [1], which fixes
> > PCIE_LNKCTL2_TLS2SPEED() and PCIE_LNKCAP_SLS2SPEED() without requiring
> > changes in the users. I'll add the details of Andrew's report to the
> > commit log.
> =


> =


> Agree. It is better to fix it in the macro.
> =


> > [1] https://lore.kernel.org/all/20250123055155.22648-2-sjiwei@163.com/
> > =


> > > ---
> > > drivers/pci/quirks.c | 2 +-
> > > 1 file changed, 1 insertion(+), 1 deletion(-)
> > > =


> > > diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> > > index d7f4ee6..deaaf4f 100644
> > > --- a/drivers/pci/quirks.c
> > > +++ b/drivers/pci/quirks.c
> > > @@ -108,7 +108,7 @@ int pcie_failed_link_retrain(struct pci_dev *dev=
)
> > > pcie_capability_read_word(dev, PCI_EXP_LNKCTL2, &lnkctl2);
> > > pcie_capability_read_word(dev, PCI_EXP_LNKSTA, &lnksta);
> > > if (!(lnksta & PCI_EXP_LNKSTA_DLLLA) && pcie_lbms_seen(dev, lnksta))=
 {
> > > - u16 oldlnkctl2 =3D lnkctl2;
> > > + u16 oldlnkctl2 =3D lnkctl2 & PCI_EXP_LNKCTL2_TLS;
> > > =


> > > pci_info(dev, "broken device, retraining non-functional downstream l=
ink at 2.5GT/s\n");
> > > =


> > > --
> > > 2.47.2
> =


> --
> Sathyanarayanan Kuppuswamy
> Linux Kernel Developer
-----------------------833a26fda0a9472d424a94c3043e9dea
Content-Type: application/pgp-keys; filename="publickey - andreasx0@protonmail.com - 0xF61BB148.asc"; name="publickey - andreasx0@protonmail.com - 0xF61BB148.asc"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="publickey - andreasx0@protonmail.com - 0xF61BB148.asc"; name="publickey - andreasx0@protonmail.com - 0xF61BB148.asc"

LS0tLS1CRUdJTiBQR1AgUFVCTElDIEtFWSBCTE9DSy0tLS0tCgp4ak1FWkk3bTN4WUpLd1lCQkFI
YVJ3OEJBUWRBN1NSTmw4bVlHN2lIZUY5QytpNWdzbXBZdUJpeXQzYjYKM0FlNGN4d1c3cUxOTTJG
dVpISmxZWE40TUVCd2NtOTBiMjV0WVdsc0xtTnZiU0E4WVc1a2NtVmhjM2d3ClFIQnliM1J2Ym0x
aGFXd3VZMjl0UHNLTUJCQVdDZ0ErQllKa2p1YmZCQXNKQndnSmtMWm8xSzhrbmExUQpBeFVJQ2dR
V0FBSUJBaGtCQXBzREFoNEJGaUVFOWh1eFNGUmFIWUNLNWdMOHRtalVyeVNkclZBQUFLOWsKQVFD
ODlZS20rT3YvdDl3OVo3WS95Z2x1anl2dFBPZkcrenpDVDNtcmpVTU52QUQvYTE0eENQZGVTSXFk
CnFRM1dhcktycXpnczVlSzBSNHVTU1h0MU42b0dUZy9PT0FSa2p1YmZFZ29yQmdFRUFaZFZBUVVC
QVFkQQpYUUE5aGdVcjRYazRXemU1TVhOTUIwOEMvcEtBR0lrcWNvd2w2MmpjV1cwREFRZ0h3bmdF
R0JZSUFDb0YKZ21TTzV0OEprTFpvMUs4a25hMVFBcHNNRmlFRTlodXhTRlJhSFlDSzVnTDh0bWpV
cnlTZHJWQUFBR2ZICkFRRDZkUmxnZmtKZWFyaHdLWHFtbWlHTVlmU1c0V3hhMVFvSm9JbHdzQXQz
YndEL1hTWmo4ZUFibStpMQpxaDRhbWh0eTFHYitTMGV3MVNicnRrSjREWmNNdUFRPQo9dGZYVQot
LS0tLUVORCBQR1AgUFVCTElDIEtFWSBCTE9DSy0tLS0tCg==
-----------------------833a26fda0a9472d424a94c3043e9dea--

--------29845f7e0471a4c7ac6daba8d4dbda20a30ddd563cfbaec68716f1cfc9c3495d
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: ProtonMail

wrsEARYKAG0FgmhcHpYJkLZo1K8kna1QRRQAAAAAABwAIHNhbHRAbm90YXRp
b25zLm9wZW5wZ3Bqcy5vcmdElfI/6LNzywae1/RJd1v2/XyUgQzm5xRSnUSQ
y0ixQRYhBPYbsUhUWh2AiuYC/LZo1K8kna1QAABBrQEAsghnFnf1mai13D7L
uAa6RQZ3oRQAEFHiKDIGYD29IQ0BAO56NiCh/0HC0dn85UYPnez+74XZ33Rh
nAyMdOLBAZAC
=GSMj
-----END PGP SIGNATURE-----


--------29845f7e0471a4c7ac6daba8d4dbda20a30ddd563cfbaec68716f1cfc9c3495d--


