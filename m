Return-Path: <linux-pci+bounces-33653-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BDAACB1F1D7
	for <lists+linux-pci@lfdr.de>; Sat,  9 Aug 2025 03:22:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F1C63BB960
	for <lists+linux-pci@lfdr.de>; Sat,  9 Aug 2025 01:22:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66C98275AE8;
	Sat,  9 Aug 2025 01:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="Ui09g7Ck"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5053194C86
	for <linux-pci@vger.kernel.org>; Sat,  9 Aug 2025 01:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754702542; cv=none; b=A/59Otn3JBZSb0vP+GV0+SkN7lrJj8Km+CLlusBtTJeCdDEXVHU4OHCu1O0l9txjb6NQwKj+3KETiybMRsbSbMFS9IAg6qXy0zZSzilNKfab+cNhMFvnQWNT3tCyCiLV4ffy9DTYI6ocUgllPLuSyIywUiZx2ZC+FWjFw7wRAnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754702542; c=relaxed/simple;
	bh=L5Lh0wTk96hPqFjkYfrosh0oeUJqxetAzfWF0EB6gxc=;
	h=Date:To:From:Subject:Message-ID:MIME-Version:Content-Type; b=VBhyL4Glo4vzg9NDCMDq3A4z2nkzCgXsvjUlbdPyRF4StZGvWygcded3YItEOQBMXzj1f5EAR9RaAIcdTgZaD9CjHK2STSBj0zLxSA9LlK2ep/di7+Acg0Y18nnml9iPCBiuB+N+mU6s2QRV2ZDHl36YaGBbc1xsydTHavkaYv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=Ui09g7Ck; arc=none smtp.client-ip=185.70.43.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1754702538; x=1754961738;
	bh=L5Lh0wTk96hPqFjkYfrosh0oeUJqxetAzfWF0EB6gxc=;
	h=Date:To:From:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=Ui09g7Cku6IZt27pEOGW1zOIGu87Xxb1j9MJj1lzYjYz6NAGftwgO8JF6zbr6OKu1
	 kg29lWko4WH1AOCsaPZlmVGD3lvoiMGMgtK/Ygw83k9gW8Z1JdLTLg/dsV4Mn4wZdu
	 P6ytcy3+o07BmQyD2v6Bz3V2Un6bIPYq+6NlUaXYtzAIP7rdZuN9Ht1BqcS+3qZ1oh
	 fiujWdywpCa3iP5A/bZyj18lYQwgwUr4uw1L68Ni7j3Xt4vBbMPz76ctKgCGu6S1K6
	 cqLtAayds3aBDrdemfphIVCkEwoGwvStJQ1TV2ZZxsJDY52Czv+Zceuz+kRo55FaGx
	 jtNZE3rBJRR7A==
Date: Sat, 09 Aug 2025 01:22:13 +0000
To: Bjorn Helgaas <bhelgaas@google.com>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
From: andreasx0 <andreasx0@protonmail.com>
Subject: [BUG] PCI: build failure in pci_bus_add_device() due to missing pci_dev_allow_binding() declaration (v6.16)
Message-ID: <w_kdHQ9WkOAZaKa2b4PYXiI1fTbeRd0Xi2TQNxCsqJ2hy-Um4039DBYDgmqj46h5D4S8rUFrx9nQU4WhdfTplMsaa5I-vVfNfghCOl4v1OE=@protonmail.com>
Feedback-ID: 4793980:user:proton
X-Pm-Message-ID: 2942132203b9b12e9e5e3082aabd48f2bbfa12cc
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha512; boundary="------453a8256283f3bf5a36d5c99fb5ea40c065bb140f9fed3289ce9e2be2f3ddcf4"; charset=utf-8

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------453a8256283f3bf5a36d5c99fb5ea40c065bb140f9fed3289ce9e2be2f3ddcf4
Content-Type: multipart/mixed;boundary=---------------------a683238229cb78aff6d0fbde53178079

-----------------------a683238229cb78aff6d0fbde53178079
Content-Type: multipart/alternative;boundary=---------------------71555035ec51406ab5fe182695b3a1b7

-----------------------71555035ec51406ab5fe182695b3a1b7
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;charset=utf-8

Hello,
When building Linux kernel v6.16 for x86_64, I encountered the following b=
uild error:

=C2=A0 drivers/pci/bus.c: In function =E2=80=98pci_bus_add_device=E2=80=99=
:
=C2=A0 drivers/pci/bus.c:373:17: error: implicit declaration of function =E2=
=80=98pci_dev_allow_binding=E2=80=99 [-Wimplicit-function-declaration]
=C2=A0 =C2=A0 373 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 pci_dev_allow_binding(dev);
=C2=A0 =C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 ^~~~~~~~~~~~~~~~~~~~~
=C2=A0 make[4]: *** [scripts/Makefile.build:287: drivers/pci/bus.o] Error =
1
=C2=A0 make[3]: *** [scripts/Makefile.build:555: drivers/pci] Error 2


Thanks
-----------------------71555035ec51406ab5fe182695b3a1b7
Content-Type: multipart/related;boundary=---------------------30201383e4f549c3781db94fe841b010

-----------------------30201383e4f549c3781db94fe841b010
Content-Type: text/html;charset=utf-8
Content-Transfer-Encoding: base64

PHNwYW4gc3R5bGU9ImZvbnQtZmFtaWx5OiBBcmlhbCwgc2Fucy1zZXJpZjsgZm9udC1zaXplOiAx
MC41cHQ7IGxpbmUtaGVpZ2h0OiBub3JtYWw7Ij5IZWxsbyw8L3NwYW4+PGRpdj48YnI+PC9kaXY+
PGRpdj48c3BhbiBzdHlsZT0iZm9udC1mYW1pbHk6IEFyaWFsLCBzYW5zLXNlcmlmOyBmb250LXNp
emU6IDEwLjVwdDsgbGluZS1oZWlnaHQ6IG5vcm1hbDsiPldoZW4gYnVpbGRpbmcgTGludXgga2Vy
bmVsIHY2LjE2IGZvciB4ODZfNjQsIEkgZW5jb3VudGVyZWQgdGhlIGZvbGxvd2luZyBidWlsZCBl
cnJvcjo8L3NwYW4+PC9kaXY+PGRpdj48YnI+PC9kaXY+PGRpdj48c3BhbiBzdHlsZT0iZm9udC1m
YW1pbHk6IEFyaWFsLCBzYW5zLXNlcmlmOyBmb250LXNpemU6IDEwLjVwdDsgbGluZS1oZWlnaHQ6
IG5vcm1hbDsiPiZuYnNwOyBkcml2ZXJzL3BjaS9idXMuYzogSW4gZnVuY3Rpb24g4oCYcGNpX2J1
c19hZGRfZGV2aWNl4oCZOjwvc3Bhbj48L2Rpdj48ZGl2PjxzcGFuIHN0eWxlPSJmb250LWZhbWls
eTogQXJpYWwsIHNhbnMtc2VyaWY7IGZvbnQtc2l6ZTogMTAuNXB0OyBsaW5lLWhlaWdodDogbm9y
bWFsOyI+Jm5ic3A7IGRyaXZlcnMvcGNpL2J1cy5jOjM3MzoxNzogZXJyb3I6IGltcGxpY2l0IGRl
Y2xhcmF0aW9uIG9mIGZ1bmN0aW9uIOKAmHBjaV9kZXZfYWxsb3dfYmluZGluZ+KAmSBbLVdpbXBs
aWNpdC1mdW5jdGlvbi1kZWNsYXJhdGlvbl08L3NwYW4+PC9kaXY+PGRpdj48c3BhbiBzdHlsZT0i
Zm9udC1mYW1pbHk6IEFyaWFsLCBzYW5zLXNlcmlmOyBmb250LXNpemU6IDEwLjVwdDsgbGluZS1o
ZWlnaHQ6IG5vcm1hbDsiPiZuYnNwOyAmbmJzcDsgMzczIHwgJm5ic3A7ICZuYnNwOyAmbmJzcDsg
Jm5ic3A7ICZuYnNwOyAmbmJzcDsgJm5ic3A7ICZuYnNwOyBwY2lfZGV2X2FsbG93X2JpbmRpbmco
ZGV2KTs8L3NwYW4+PC9kaXY+PGRpdj48c3BhbiBzdHlsZT0iZm9udC1mYW1pbHk6IEFyaWFsLCBz
YW5zLXNlcmlmOyBmb250LXNpemU6IDEwLjVwdDsgbGluZS1oZWlnaHQ6IG5vcm1hbDsiPiZuYnNw
OyAmbmJzcDsgJm5ic3A7ICZuYnNwOyB8ICZuYnNwOyAmbmJzcDsgJm5ic3A7ICZuYnNwOyAmbmJz
cDsgJm5ic3A7ICZuYnNwOyAmbmJzcDsgXn5+fn5+fn5+fn5+fn5+fn5+fn5+PC9zcGFuPjwvZGl2
PjxkaXY+PHNwYW4gc3R5bGU9ImZvbnQtZmFtaWx5OiBBcmlhbCwgc2Fucy1zZXJpZjsgZm9udC1z
aXplOiAxMC41cHQ7IGxpbmUtaGVpZ2h0OiBub3JtYWw7Ij4mbmJzcDsgbWFrZVs0XTogKioqIFtz
Y3JpcHRzL01ha2VmaWxlLmJ1aWxkOjI4NzogZHJpdmVycy9wY2kvYnVzLm9dIEVycm9yIDE8L3Nw
YW4+PC9kaXY+PGRpdj48c3BhbiBzdHlsZT0iZm9udC1mYW1pbHk6IEFyaWFsLCBzYW5zLXNlcmlm
OyBmb250LXNpemU6IDEwLjVwdDsgbGluZS1oZWlnaHQ6IG5vcm1hbDsiPiZuYnNwOyBtYWtlWzNd
OiAqKiogW3NjcmlwdHMvTWFrZWZpbGUuYnVpbGQ6NTU1OiBkcml2ZXJzL3BjaV0gRXJyb3IgMjwv
c3Bhbj48L2Rpdj48ZGl2IHN0eWxlPSJmb250LWZhbWlseTogQXJpYWwsIHNhbnMtc2VyaWY7IGZv
bnQtc2l6ZTogMTRweDsgY29sb3I6IHJnYigwLCAwLCAwKTsgYmFja2dyb3VuZC1jb2xvcjogcmdi
KDI1NSwgMjU1LCAyNTUpOyI+PHNwYW4+PGJyPjwvc3Bhbj48L2Rpdj48ZGl2IHN0eWxlPSJmb250
LWZhbWlseTogQXJpYWwsIHNhbnMtc2VyaWY7IGZvbnQtc2l6ZTogMTRweDsgY29sb3I6IHJnYigw
LCAwLCAwKTsgYmFja2dyb3VuZC1jb2xvcjogcmdiKDI1NSwgMjU1LCAyNTUpOyI+PHNwYW4gc3R5
bGU9ImZvbnQtZmFtaWx5OiBBcmlhbCwgc2Fucy1zZXJpZjsgZm9udC1zaXplOiAxMC41cHQ7IGxp
bmUtaGVpZ2h0OiBub3JtYWw7Ij5UaGFua3M8L3NwYW4+PC9kaXY+PHNwYW4+PC9zcGFuPg==
-----------------------30201383e4f549c3781db94fe841b010--
-----------------------71555035ec51406ab5fe182695b3a1b7--
-----------------------a683238229cb78aff6d0fbde53178079
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
-----------------------a683238229cb78aff6d0fbde53178079--

--------453a8256283f3bf5a36d5c99fb5ea40c065bb140f9fed3289ce9e2be2f3ddcf4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: ProtonMail

wrsEARYKAG0FgmiWorsJkLZo1K8kna1QRRQAAAAAABwAIHNhbHRAbm90YXRp
b25zLm9wZW5wZ3Bqcy5vcmeHo6zajyfBM95gJYzJQYma3c5EOZWJkOGBShY3
kSqPBRYhBPYbsUhUWh2AiuYC/LZo1K8kna1QAAA9DgD/ZcBsUDuXa4T+FGWQ
7TwV1rm0D46Da//u7OtWLXO7V/wBAOeeCWmE/IeQqNWx6TZQ/TGjb0XIyI82
5B7vmqeXXp4N
=whFY
-----END PGP SIGNATURE-----


--------453a8256283f3bf5a36d5c99fb5ea40c065bb140f9fed3289ce9e2be2f3ddcf4--


