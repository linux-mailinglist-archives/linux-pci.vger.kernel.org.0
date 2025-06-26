Return-Path: <linux-pci+bounces-30846-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 30E3FAEA9B3
	for <lists+linux-pci@lfdr.de>; Fri, 27 Jun 2025 00:33:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0614256439B
	for <lists+linux-pci@lfdr.de>; Thu, 26 Jun 2025 22:33:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E14E121ADB9;
	Thu, 26 Jun 2025 22:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="kaFsil4C"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C44921A440
	for <linux-pci@vger.kernel.org>; Thu, 26 Jun 2025 22:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750977206; cv=none; b=DbNx5MVJGNE7YaPyBpsiLleSLCjcTCgZf5GZ+4K9fGynBE6xFbT/2c2Q/fqx2jpGd26lbgLa9yDc/JkQ6IrsgmJYqbGk1yYggQfDvzazlnnybA18B1ezsfqijvNsA7huAb4maC710xqi2xEgqIhvP2lsOmLXhWeUVPbGGnijd38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750977206; c=relaxed/simple;
	bh=Vq9qzlrhxPvDIiFof/pt5BVM/gC/1NURBaZT2wLedo0=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=spTh8W1wc4Gv9vaeCiagOc4YGHYvIYLepAQDAvju/Xi5n+Uw4IxeOiwiS8vDl+GjtuAglmBr2fZB4DjEFVcj3lleuszKxgAFvqbzNV9A4b8BWQH0YYoQN/cjgAoXYltlDqrLG6onAsvS8guPPxReuXRBh6gkxTzgp0MWGFAlBDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=kaFsil4C; arc=none smtp.client-ip=185.70.43.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1750977196; x=1751236396;
	bh=Vq9qzlrhxPvDIiFof/pt5BVM/gC/1NURBaZT2wLedo0=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=kaFsil4CV6No784rlhmXdY85lvlCRlwEBAUDTqucMNvoJksfufoiHiIDlfyrDskxU
	 baYSMEJCfiE3gA8amUJ8XV2BeepRk6q5es1ITe2EoSpAy9bnRDR4rwJroMAV1+UTfs
	 7/CorYeMnJ60al5xiMl3FFLkZhh/S1IdLABbMtPR2supCnv5f+31XCZBZ0cFAsoPH9
	 VsCA1klxZWmkr+eER/CfpD5HUf4VvGh3L1puHCe0AHlsSfKyppiMIvYfpo8rXRs4s4
	 sT0QBxR25o1mil/0OQITzpp/8naed3XQF9Tq7on8D8z2Sg69tdDVWbs8PhGbrjuFOI
	 yZP20ofV+eg1w==
Date: Thu, 26 Jun 2025 22:33:13 +0000
To: Bjorn Helgaas <helgaas@kernel.org>
From: andreasx0 <andreasx0@protonmail.com>
Cc: Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>, Lukas Wunner <lukas@wunner.de>, Ilpo Jarvinen <ilpo.jarvinen@linux.intel.com>, "Maciej W. Rozycki" <macro@orcam.me.uk>, Matthew W Carlis <mattc@purestorage.com>, linux-pci@vger.kernel.org, Jiwei Sun <sunjw10@lenovo.com>, Adrian Huang12 <ahuang12@lenovo.com>
Subject: Re: [PATCH] PCI: Fix link speed calculation on retrain failure
Message-ID: <-iazzzuIfhAVFE-lEWHGlqmsvIaM8ExGLqRrXA5eghr0s6pTzi4xevmAdUgxiT4L88eHDAdxYQ4TFsGtcnDZ8dmo9uJsPxxpNDSuVilefKY=@protonmail.com>
In-Reply-To: <20250625174652.GA1578845@bhelgaas>
References: <20250625174652.GA1578845@bhelgaas>
Feedback-ID: 4793980:user:proton
X-Pm-Message-ID: 5ebe5c72cc6383df686cc4cd6449b40f5aa3fd4e
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha512; boundary="------cbc5330ca62e96ccb965966526f86f1a06e8bff077618e6313517280a0b4d4a8"; charset=utf-8

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------cbc5330ca62e96ccb965966526f86f1a06e8bff077618e6313517280a0b4d4a8
Content-Type: multipart/mixed;boundary=---------------------fe7bab295f5641feab62dde617cf3fdc

-----------------------fe7bab295f5641feab62dde617cf3fdc
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;charset=utf-8

Tested and passed.
But what i mean is why try to retrain the line of the connected bios disab=
led discrete GPU? Is the normal of disabled to drop it to 2.5?


On Wednesday, June 25th, 2025 at 20:46, Bjorn Helgaas <helgaas@kernel.org>=
 wrote:

> On Wed, Jun 25, 2025 at 04:06:58PM +0000, andreasx0 wrote:
> =


> > Again. As said the patch from Lucas fixed the warning that was
> > caused because the discrete nvidia gpu was disabled by bios.
> =


> =


> The series I applied is at
> https://lore.kernel.org/all/20250123055155.22648-1-sjiwei@163.com/.
> The patches currently queued are at
> https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git/log/?h=3Denu=
meration
> =


> I cc'd you on my response to that series, so if you think the commit
> log needs a change, feel free to suggest something in that thread.
> It's a generic problem, not anything specific to the GPU, so I just
> included the log messages a user would see when the problem happens.
> =


> I added your Reported-by because I think the first patch [2] should
> fix the problem you saw. If it doesn't, please let me know. If you
> test it and it does fix the problem, I'd be happy to add your
> Tested-by as well.
> =


> Thanks very much for reporting this issue and giving it a nudge to get
> it fixed!
> =


> [2] https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git/commit/?=
id=3D9989e0ca7462
> =


> > On Tuesday, June 24th, 2025 at 21:13, Sathyanarayanan Kuppuswamy sathy=
anarayanan.kuppuswamy@linux.intel.com wrote:
> > =


> > > On 6/24/25 9:48 AM, Bjorn Helgaas wrote:
> > =


> > > > [+cc Sathy, Jiwei, Adrian]
> > =


> > > > On Mon, Jun 23, 2025 at 03:22:14PM +0200, Lukas Wunner wrote:
> > =


> > > > > When pcie_failed_link_retrain() fails to retrain, it tries to re=
vert to
> > > > > the previous link speed. However it calculates that speed from t=
he Link
> > > > > Control 2 register without masking out non-speed bits first.
> > =


> > > > > PCIE_LNKCTL2_TLS2SPEED() converts such incorrect values to
> > > > > PCI_SPEED_UNKNOWN, which in turn causes a WARN splat in
> > > > > pcie_set_target_speed():
> > =


> > > > > pci 0000:00:01.1: [1022:14ed] type 01 class 0x060400 PCIe Root P=
ort
> > > > > pci 0000:00:01.1: broken device, retraining non-functional downs=
tream link at 2.5GT/s
> > > > > pci 0000:00:01.1: retraining failed
> > > > > WARNING: CPU: 1 PID: 1 at drivers/pci/pcie/bwctrl.c:168 pcie_set=
_target_speed
> > > > > RDX: 0000000000000001 RSI: 00000000000000ff RDI: ffff9acd82efa00=
0
> > > > > pcie_failed_link_retrain
> > > > > pci_device_add
> > > > > pci_scan_single_device
> > > > > pci_scan_slot
> > > > > pci_scan_child_bus_extend
> > > > > acpi_pci_root_create
> > > > > pci_acpi_scan_root
> > > > > acpi_pci_root_add
> > > > > acpi_bus_attach
> > > > > device_for_each_child
> > > > > acpi_dev_for_each_child
> > > > > acpi_bus_attach
> > > > > device_for_each_child
> > > > > acpi_dev_for_each_child
> > > > > acpi_bus_attach
> > > > > acpi_bus_scan
> > > > > acpi_scan_init
> > > > > acpi_init
> > =


> > > > > Per the calling convention of the System V AMD64 ABI, the argume=
nts to
> > > > > pcie_set_target_speed(struct pci_dev *, enum pci_bus_speed, bool=
) are
> > > > > stored in RDI, RSI, RDX. As visible above, RSI contains 0xff, i.=
e.
> > > > > PCI_SPEED_UNKNOWN.
> > =


> > > > > Fixes: f68dea13405c ("PCI: Revert to the original speed after PC=
Ie failed link retraining")
> > > > > Reported-by: Andrew andreasx0@protonmail.com
> > > > > Closes: https://lore.kernel.org/r/7iNzXbCGpf8yUMJZBQjLdbjPcXrEJq=
Bxy5-bHfppz0ek-h4_-G93b1KUrm106r2VNF2FV_sSq0nENv4RsRIUGnlYZMlQr2ZD2NyB5sdj=
5aU=3D@protonmail.com/
> > > > > Signed-off-by: Lukas Wunner lukas@wunner.de
> > > > > Cc: stable@vger.kernel.org # v6.12+
> > > > > I like the brevity of this patch, but I do worry that if we ever=
 have
> > > > > other users of PCIE_LNKCTL2_TLS2SPEED(), we might have the same
> > > > > problem again.
> > =


> > > > Also, it looks like PCIE_LNKCAP_SLS2SPEED() has the same problem.
> > =


> > > > f68dea13405c predates PCIE_LNKCTL2_TLS2SPEED(), and I don't think =
this
> > > > problem existed as of f68dea13405c. I think the Fixes: tag should =
be
> > > > for de9a6c8d5dbf ("PCI/bwctrl: Add pcie_set_target_speed() to set =
PCIe
> > > > Link Speed"), which added PCIE_LNKCTL2_TLS2SPEED() and
> > > > PCIE_LNKCAP_SLS2SPEED() without masking out the other bits.
> > =


> > > > I think I'll take Jiwei's patch [1], which fixes
> > > > PCIE_LNKCTL2_TLS2SPEED() and PCIE_LNKCAP_SLS2SPEED() without requi=
ring
> > > > changes in the users. I'll add the details of Andrew's report to t=
he
> > > > commit log.
> > =


> > > Agree. It is better to fix it in the macro.
> > =


> > > > [1] https://lore.kernel.org/all/20250123055155.22648-2-sjiwei@163.=
com/
> > =


> > > > > ---
> > > > > drivers/pci/quirks.c | 2 +-
> > > > > 1 file changed, 1 insertion(+), 1 deletion(-)
> > =


> > > > > diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> > > > > index d7f4ee6..deaaf4f 100644
> > > > > --- a/drivers/pci/quirks.c
> > > > > +++ b/drivers/pci/quirks.c
> > > > > @@ -108,7 +108,7 @@ int pcie_failed_link_retrain(struct pci_dev =
*dev)
> > > > > pcie_capability_read_word(dev, PCI_EXP_LNKCTL2, &lnkctl2);
> > > > > pcie_capability_read_word(dev, PCI_EXP_LNKSTA, &lnksta);
> > > > > if (!(lnksta & PCI_EXP_LNKSTA_DLLLA) && pcie_lbms_seen(dev, lnks=
ta)) {
> > > > > - u16 oldlnkctl2 =3D lnkctl2;
> > > > > + u16 oldlnkctl2 =3D lnkctl2 & PCI_EXP_LNKCTL2_TLS;
> > =


> > > > > pci_info(dev, "broken device, retraining non-functional downstre=
am link at 2.5GT/s\n");
> > =


> > > > > --
> > > > > 2.47.2
> > =


> > > --
> > > Sathyanarayanan Kuppuswamy
> > > Linux Kernel Developer
> =


> =


> =


> =


-----------------------fe7bab295f5641feab62dde617cf3fdc
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
-----------------------fe7bab295f5641feab62dde617cf3fdc--

--------cbc5330ca62e96ccb965966526f86f1a06e8bff077618e6313517280a0b4d4a8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: ProtonMail

wrsEARYKAG0FgmhdyqAJkLZo1K8kna1QRRQAAAAAABwAIHNhbHRAbm90YXRp
b25zLm9wZW5wZ3Bqcy5vcmdfD2sFTDaccMzVdYghBVtgLebfOiMmHAr6WEyY
y7lYKhYhBPYbsUhUWh2AiuYC/LZo1K8kna1QAACsGgD/X8Liwvo6s3TNN92o
aO4zPbjX71IplZWeBvm+JVT93PYA/iOaWery48DOg43i1whUbh0rPaOelL98
BAE210FmJ0ED
=2BAF
-----END PGP SIGNATURE-----


--------cbc5330ca62e96ccb965966526f86f1a06e8bff077618e6313517280a0b4d4a8--


