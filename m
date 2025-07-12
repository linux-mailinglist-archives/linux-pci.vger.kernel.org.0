Return-Path: <linux-pci+bounces-31994-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D579B02B9E
	for <lists+linux-pci@lfdr.de>; Sat, 12 Jul 2025 17:12:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0EA6AA463C3
	for <lists+linux-pci@lfdr.de>; Sat, 12 Jul 2025 15:12:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46AC428643F;
	Sat, 12 Jul 2025 15:12:50 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from maynard.decadent.org.uk (maynard.decadent.org.uk [65.21.191.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D81014286;
	Sat, 12 Jul 2025 15:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.21.191.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752333170; cv=none; b=U3EUvtR9BmII6G1/o8yB21h88An6bZdDF9dD3GCJpAConU/dSuKZfem4BKilbqOlbK/XeukMLbpx8QUE36lWUKuaHiO8heH0KsqjN6HQZpo3YKeGJ+dIZPq9xLVw10txjsTpelcNpKUU2w1drn5mKqYcVT9t3Jb4KaHC3qc61YA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752333170; c=relaxed/simple;
	bh=ilrqpBJ48BxReMjEg/7sgs7v0a9iPzBDrQJ0GNwV3B0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hiPiJpTzzvUOz18GyOKY71NAFuy0I3o//Ajm/WhBbvnljUCG5nLsF31fLtcjzbKkPiFAb6VuCBnAZulCBrEpF28ou8eM7Fny6lZRmIFaosFA+C/fkKZQFR7mrYW0dV9uiYeGDomPRWl+gN/CLYaZQgxfp+BFbY9hou7mBiEa2/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk; spf=pass smtp.mailfrom=decadent.org.uk; arc=none smtp.client-ip=65.21.191.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=decadent.org.uk
Received: from [89.234.162.240] (helo=deadeye)
	by maynard with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ben@decadent.org.uk>)
	id 1uabtz-0059j5-2N;
	Sat, 12 Jul 2025 15:12:35 +0000
Received: from ben by deadeye with local (Exim 4.98.2)
	(envelope-from <ben@decadent.org.uk>)
	id 1uabty-00000002Vec-2keS;
	Sat, 12 Jul 2025 17:12:34 +0200
Message-ID: <c40b5e6cb26654f698e51b131956065b952ad222.camel@decadent.org.uk>
Subject: Re: Bug#1104670: linux-image-6.12.25-amd64: system does not shut
 down - GHES: Fatal hardware error
From: Ben Hutchings <ben@decadent.org.uk>
To: intel-wired-lan@lists.osuosl.org, linux-pci <linux-pci@vger.kernel.org>,
  Pavan Chebbi <pavan.chebbi@broadcom.com>, Michael Chan <mchan@broadcom.com>
Cc: Laurent Bonnaud <L.Bonnaud@laposte.net>, 1104670@bugs.debian.org, 
	netdev@vger.kernel.org
Date: Sat, 12 Jul 2025 17:12:30 +0200
In-Reply-To: <8a232a97-5917-41d3-8e88-e68abdc83202@laposte.net>
References: <89159d74-c343-480f-9509-b6457244d65d@laposte.net>
	 <8a232a97-5917-41d3-8e88-e68abdc83202@laposte.net>
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-EOHNBDwerU4Tq4Na6UmU"
User-Agent: Evolution 3.56.1-1 
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 89.234.162.240
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on maynard); SAEximRunCond expanded to false


--=-EOHNBDwerU4Tq4Na6UmU
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi all,

On Sun, 2025-05-04 at 13:45 +0200, Laurent Bonnaud wrote:
[...]
>   - Previously the kernel would output an error in /var/lib/systemd/pstor=
e/ but would shutdown anyway.
>=20
>   - Now, with kernel 6.1.135-1, the shutdown is blocked as with 6.12.x ke=
rnels (see below).
> --
> Laurent.
>=20
> <30>[  961.098671] systemd-shutdown[1]: Rebooting.
> <6>[  961.098743] kvm: exiting hardware virtualization
> <6>[  961.361878] megaraid_sas 0000:17:00.0: megasas_disable_intr_fusion =
is called outbound_intr_mask:0x40000009
> <6>[  961.414526] ACPI: PM: Preparing to enter system sleep state S5
> <0>[  963.828210] {1}[Hardware Error]: Hardware error from APEI Generic H=
ardware Error Source: 5
> <0>[  963.828213] {1}[Hardware Error]: event severity: fatal
> <0>[  963.828214] {1}[Hardware Error]:  Error 0, type: fatal
> <0>[  963.828216] {1}[Hardware Error]:   section_type: PCIe error
> <0>[  963.828216] {1}[Hardware Error]:   port_type: 0, PCIe end point
> <0>[  963.828217] {1}[Hardware Error]:   version: 3.0
> <0>[  963.828218] {1}[Hardware Error]:   command: 0x0002, status: 0x0010
> <0>[  963.828220] {1}[Hardware Error]:   device_id: 0000:01:00.1
> <0>[  963.828221] {1}[Hardware Error]:   slot: 6
> <0>[  963.828222] {1}[Hardware Error]:   secondary_bus: 0x00
> <0>[  963.828223] {1}[Hardware Error]:   vendor_id: 0x8086, device_id: 0x=
1563
> <0>[  963.828224] {1}[Hardware Error]:   class_code: 020000
> <0>[  963.828225] {1}[Hardware Error]:   aer_uncor_status: 0x00100000, ae=
r_uncor_mask: 0x00018000
> <0>[  963.828226] {1}[Hardware Error]:   aer_uncor_severity: 0x000ef010
> <0>[  963.828227] {1}[Hardware Error]:   TLP Header: 40000001 0000000f 90=
028090 00000000
[...]

It seems that this is a known bug in the BIOS of several Dell PowerEdge
models including (in this case) the R540.

A workaround was added to the tg3 driver
<https://git.kernel.org/linus/e0efe83ed325277bb70f9435d4d9fc70bebdcca8>
and a similar change was proposed (but not accepted) in the i40e driver
<https://lore.kernel.org/all/20241227035459.90602-1-yue.zhao@shopee.com/>.
On tihis system the erorr log points to a deivce handled by the ixgbe
driver, and no workaround has been implemented for that.

Since this issue seems to affect multiple different NIC vendors and
drivers, would it make more sense to implement this workaround as a PCI
quirk?

Ben.

--=20
Ben Hutchings
Experience is directly proportional to the value of equipment destroyed
                                                    - Carolyn Scheppner

--=-EOHNBDwerU4Tq4Na6UmU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEErCspvTSmr92z9o8157/I7JWGEQkFAmhye14ACgkQ57/I7JWG
EQkCGRAArhhsaQfYReSLaDpResfBQgdhi852snU1Y27XpESTwii1AV8M71XxWPnw
m4WnPVctGUQg2Qb6nrwGaiJUr7Rj/R+RzkKynuYmVsVthZGTZtyOx525S/HjJVmQ
IFOdJA0Mw2czAUo6xB4rwBga9Leq5U7y2zkjvVb9qtMs3A7y5FaLYSv8WRArECXx
HP2BoWtxv3ItxcU9Os4TYwkcVQga9zpKCUxUzrUvLOKOAIneduV3zqUeoy0YD958
kkpXLN+PuqGzaxFLzr/r63d4wlBY+De2Vtd/yWKzSr+5n5ZeZ/yi6ZDxWjJXe42c
B4IIIrh/EsZRXL0ThEwo6sjoaBFxCMwSLhdwIsIhTGXl702VXynS+CqRMT9G8x9T
EUZj5F3PIKYSB5nb+r2t/XEosAL8z2a7bbZWkQUHruUXpycXCdDFa7rLJdqKBva0
TFYgstWr9V7oHzPsocZfT3k/UbArzGAwuKk0sWXTAobYmN1vun//muNK03xmu5V8
ib0t2CXjFiQLtoKPtfev2/BC5lYWb9lMUha7cukLZjPTNQr9dINvqKOc0OlcNd0d
Lefcf8f13nzQDAr8U/kTWWzz0u1+fTR41jwrr+Qz0ohS7/JJis8hpZSW1ji2ImKj
Q2YDgm36H28uGMpQzll638Q0SR7+A6CkCHeelMpKNmtulS9+z1w=
=tyMx
-----END PGP SIGNATURE-----

--=-EOHNBDwerU4Tq4Na6UmU--

