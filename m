Return-Path: <linux-pci+bounces-5748-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CC884898F53
	for <lists+linux-pci@lfdr.de>; Thu,  4 Apr 2024 22:01:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 45DF71F24068
	for <lists+linux-pci@lfdr.de>; Thu,  4 Apr 2024 20:01:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F447134439;
	Thu,  4 Apr 2024 20:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="gprRlAjO"
X-Original-To: linux-pci@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1858C6D1AB;
	Thu,  4 Apr 2024 20:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712260907; cv=none; b=sazwdvwiL2Wcsvp1ocuGBryFM8m5k8zU7V8q/ElsTHQmDtbiVHZA6wAK5elRuFfQuWpGbZczRExbNCJjDUsrEEtGb3KmECMrMF/vjg0WBOo1v1hBBbJz1hpkFa/izO9vknk4PiMUM0YbFWt3wKlXOKAzIEXwBWboQuxOLclfbG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712260907; c=relaxed/simple;
	bh=JxyaE0ZL0hvUhMwJSJH0ciGtnwxPSgrxrSBEjSbyWRM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QNXWpIYIEbCf3qSdAzF4f37c/XqgKZ8s6PD6tGBww5AJ8rQsGCXotTSsn3DsAfXEG48KbRx/kWwTKGIRsRSsAk+ydgribw/cR+xNW8QhbpyYsp00voFxmFuu+GCaCoWpHaR1e7bGS6Dj++2xJ3Yfe9UQEANSwEQ/fxa6ictETig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=none smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=gprRlAjO; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=debian.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Ar7Lw4eA7hfvt1/r0rsI3i5UsJ6oVUk1F07naco9tuc=; b=gprRlAjOYiNDqsDOIwPI3iTr/h
	I/7c/p843XxMifqRrgotVdV7/DiYdU97vaCKV5WTBdztUG8vS24060IFXLWt7q4azpC+V3lmksQYE
	wn8Mmf9Pp7ZseDLc7y5cTU2in0zlY4g3R2/103+buy3HQRxmZ/0HML9OhHzsJRrKWAKcHzcpi2Eby
	yLJnkWhVLAmh1ziwp5b3+0vX0uURaKK93avzifOAJi14kj/Ol1OLLG0UJh3/C3Z4POJtZElKXiZe6
	Z8V7yRnUdAdTWJPywZdxG2m1DQtJQmAtNcDyZMydCHjnSAOLU0tsGjDGAhm6cekG4/pgiiZVTKcEB
	mbXjnv8g==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.94.2)
	(envelope-from <kibi@debian.org>)
	id 1rsTHB-00DWaO-8M; Thu, 04 Apr 2024 20:01:34 +0000
Date: Thu, 4 Apr 2024 22:01:29 +0200
From: Cyril Brulebois <kibi@debian.org>
To: Jim Quinlan <james.quinlan@broadcom.com>
Cc: linux-pci@vger.kernel.org, Nicolas Saenz Julienne <nsaenz@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Phil Elwell <phil@raspberrypi.com>,
	bcm-kernel-feedback-list@broadcom.com,
	Conor Dooley <conor+dt@kernel.org>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Jim Quinlan <jim2101024@gmail.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	"moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>,
	open list <linux-kernel@vger.kernel.org>,
	"moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" <linux-rpi-kernel@lists.infradead.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v9 0/4] PCI: brcmstb: Configure appropriate HW CLKREQ#
 mode
Message-ID: <20240404200129.3qp4qs6zklbk2prl@mraw.org>
Organization: Debian
References: <20240403213902.26391-1-james.quinlan@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="4mlfdkp3wjmc3cs3"
Content-Disposition: inline
In-Reply-To: <20240403213902.26391-1-james.quinlan@broadcom.com>
X-Debian-User: kibi


--4mlfdkp3wjmc3cs3
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Jim,

Jim Quinlan <james.quinlan@broadcom.com> (2024-04-03):
> v9 -- v8 was setting an internal bus timeout to accomodate large L1 exit
>       latencies.  After meeting the PCIe HW team it was revealed that the
>       HW default timeout value was set low for the purposes of HW debuggi=
ng
>       convenience; for nominal operation it needs to be set to a higher
>       value independent of this submission's purpose.  This is now a
>       separate commit.
>=20
>    -- With v8, Bjorne asked what was preventing a device from exceeding t=
he
>       time required for the above internal bus timeout.  The answer to th=
is
>       is for us to set the endpoints' max latency {no-,}snoop value to
>       something below this internal timeout value.  If the endpoint
>       respects this value as it should, it will not send an LTR request
>       with a larger latency value and not put itself in a situation
>       that requires more latency than is possible for the platform.
>=20
>       Typically, ACPI or FW sets these max latency values.  In most of our
>       systems we do not have this happening so it is up to the RC driver =
to
>       set these values in the endpoint devices.  If the endpoints already
>       have non-zero values that are lower than what we are setting, we let
>       them be, as it is possible ACPI or FW set them and knows something
>       that we do not.
>=20
>    -- The "clkreq" commit has only been changed to remove the code that w=
as
>       setting the timeout value, as this code is now its own commit.

Given the bot's feedback, I took the liberty of running tests on your
patch series except with an extra =E2=80=9Cstatic=E2=80=9D keyword. On my b=
uild system,
gcc 12 wasn't complaining about it but I didn't spend time trying to
find the right options, or trying a switch to clang to confirm the
before/after situation:

    -void brcm_set_downstream_devs_ltr_max(struct brcm_pcie *pcie)
    +static void brcm_set_downstream_devs_ltr_max(struct brcm_pcie *pcie)


Anyway, this is still:

Tested-by: Cyril Brulebois <cyril@debamax.com>


Test setup:
-----------

 - using a $CM with the 20230111 EEPROM
 - on the same CM4 IO Board
 - with a $PCIE board (PCIe to multiple USB ports)
 - and the same Samsung USB flash drive + Logitech keyboard.

where $CM is one of:

 - CM4 Lite Rev 1.0
 - CM4 8/32 Rev 1.0
 - CM4 4/32 Rev 1.1

and $PCIE is one of:

 - SupaHub PCE6U1C-R02, VER 006
 - SupaHub PCE6U1C-R02, VER 006S
 - Waveshare VIA VL805/806-based


Results:
--------

 1. Given this is already v9, and given I don't see how this could have
    possibly changed, I didn't build or tested an unpatched kernel,
    which I would still expect to produce either a successful boot
    *without* seeing the devices plugged on the PCIe-to-USB board or the
    dreaded SError in most cases.

 2. With a patched kernel (v6.7-562-g9f8413c4a66f2 + this series +
    =E2=80=9Cstatic=E2=80=9D in front of brcm_set_downstream_devs_ltr_max()=
), for all
    $CM/$PCIE combinations, I'm getting a system that boots, sees the
    flash drive, and gives decent read/write performance on it (plus a
    functional keyboard).


Cheers,
--=20
Cyril Brulebois (kibi@debian.org)            <https://debamax.com/>
D-I release manager -- Release team member -- Freelance Consultant

--4mlfdkp3wjmc3cs3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEtg6/KYRFPHDXTPR4/5FK8MKzVSAFAmYPBxYACgkQ/5FK8MKz
VSCIpw//YwRVw8lAie3wKx/qgQbpoFTlOXGLNFVwWKZFPhIgx5EQg+iWTKffg3EE
yoq8uWofgddD3Rcmhspu5a/Af/DX7s7RkrVT3BH3PfwJ+WaAm/60vpVxx8vhNl8r
kQvc1mwzuyyqh4BgmpcC2vYSn7ECJNSdawcY0bi4lJvCHmU60Bv1Lg4SQ0cqVKs/
OSjZdwyeLOTfovDQevKD0xRV52WxlrMZg7dhPG2DcUytrKl+36PPEpO6LdzxibCy
LPAsklzDMOTgfF/7jTZWgAxyL4c5UslXk1X6zkKyWJTmABlvu2RBt7dgdINTKH68
g+5y5vApXegkbkZDFvFes25QvOZMFNx3JcmHVO4qp2EvsVv4krhAIyFb4BX0Zdjw
ORHv2KJQD/x56JweQ/iX72oMz2PKZCpLSTExhLerF2lGrBlubqMLmZqII1MwL6T0
IMwEo1PB4UkBo8wWDZPUhk786Oxp6jNxdNtNRa3caD4KwvQOwP0nbGgSoDN91LHY
tTb1cjdE03S0fmihIdIdfBM+dHZGKbQY6SoPGZ+xtyW98Moc6VpI8O0uAIJYO5gP
FdQSn0NEOTFYlVDZvldQMkgPaAUi4fRmNOBQu7WWvaUHa+nlSFG7TpjqWJKY+CYJ
ekw3PxfOn7Z677QjnBeXPr99kCAqiZBR/KEzs+USaGStNcObWns=
=LON4
-----END PGP SIGNATURE-----

--4mlfdkp3wjmc3cs3--

