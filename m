Return-Path: <linux-pci+bounces-28784-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 65BE9ACA808
	for <lists+linux-pci@lfdr.de>; Mon,  2 Jun 2025 03:25:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE13D173F2E
	for <lists+linux-pci@lfdr.de>; Mon,  2 Jun 2025 01:25:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA0CF1DFD8F;
	Mon,  2 Jun 2025 01:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=shdwchn.io header.i=@shdwchn.io header.b="r51K+Rni"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-24422.protonmail.ch (mail-24422.protonmail.ch [109.224.244.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60283383
	for <linux-pci@vger.kernel.org>; Mon,  2 Jun 2025 01:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748826594; cv=none; b=h+ngdsPhJDcl5eou/gW6DZfUqCGayYSL5onVn8wsul081Zdw+gg56rgvJ9ov8YhctPaIaGG6UoMeXtZUtSmClkVYRZb0RG3crVnekBP7DBJXi7MsvLLIp6THQLkMCygu96iVAYhqo+xEz1wOgOaKufvGnDT1lHeo1Etpsle0PZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748826594; c=relaxed/simple;
	bh=EZaYfANRHxPJfwY2Ec0dCf9g+tUnQCVVVD04Q668M64=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UnqHQhyAhsxawgq+RPFXP/f5Gyg653cvpbQ2P15ga4U7gGmN+WPrVGZu6MmioKRzbFf9T76D9QbKvubiBzNoXWHDoX71IUNUVno8GuFkPcOz5VDTMDFsujfkaPQhGfnTVmu8DGitI4R0Fi3CuLoqJ3SW8utePFS4LBrn7QIiTxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shdwchn.io; spf=pass smtp.mailfrom=shdwchn.io; dkim=pass (2048-bit key) header.d=shdwchn.io header.i=@shdwchn.io header.b=r51K+Rni; arc=none smtp.client-ip=109.224.244.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shdwchn.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shdwchn.io
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shdwchn.io;
	s=protonmail; t=1748826584; x=1749085784;
	bh=EZaYfANRHxPJfwY2Ec0dCf9g+tUnQCVVVD04Q668M64=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=r51K+RnibSqXDJ9sWk4GZdY60sU1KizK+DyFBcAKY8RThoaAP/Swpnp1dIc8e34SX
	 Z44YuP/bfbAHGBzXW5rhr8hagTRjc7ovBTeylmoNNuQWkHReLY/vPks1I34ltDioMB
	 hgSBJVgMTbP7SakEVCm7RZkGm6YmpXKGNXZnL4ntmLYpb3KnD+WZsl2/q8h/6fSlA+
	 j++gg4jd4dUZeNs/eToITse25ypPc6rPwTTgYWGRFa+9Y0FQddK/2WEHzzV+OSKPiq
	 WDi2SExIp13Z/EGlYwg6AFUIdh2sDOsEIowKUAOcl9bXaW8isatesCpJNyKX0/HhG5
	 WUCsLesJTRtzA==
Date: Mon, 02 Jun 2025 01:09:41 +0000
To: Bjorn Helgaas <helgaas@kernel.org>
From: Andrey Brusnik <dev@shdwchn.io>
Cc: linux-pci@vger.kernel.org, Lukas Wunner <lukas@wunner.de>, Andreas Noever <andreas.noever@gmail.com>, Michael Jamet <michael.jamet@intel.com>, Mika Westerberg <westeri@kernel.org>, Yehezkel Bernat <YehezkelShB@gmail.com>, Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, linux-usb@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: [bugzilla-daemon@kernel.org: [Bug 220175] New: NVMe SSD doesn't work via Thunderbolt enclosure on Framework 13 (Ryzen AI 300)]
Message-ID: <JeHMKChVhpNReeCujhPWnnVXkEuC9YpTrwt8mqZ8c8wwMQqeIg7ZVlAmqRlJ9MCmgak5KvAdVJkGDr-vfehzT0T66ALA082JEOMaXGrE6Qg=@shdwchn.io>
In-Reply-To: <20250529222223.GA119209@bhelgaas>
References: <20250529222223.GA119209@bhelgaas>
Feedback-ID: 27773722:user:proton
X-Pm-Message-ID: b8164dfafc7d193af4022fa99ba236eeb36c7ed4
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha512; boundary="------5a1b726c2bb2cadc38536e69d746567d4d9f909c73e39e41a9773a96532cbdba"; charset=utf-8

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------5a1b726c2bb2cadc38536e69d746567d4d9f909c73e39e41a9773a96532cbdba
Content-Type: multipart/mixed;boundary=---------------------02b76b9018760c600334190c3c7e05f7

-----------------------02b76b9018760c600334190c3c7e05f7
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;charset=utf-8

On Friday, May 30th, 2025 at 02:22, Bjorn Helgaas <helgaas@kernel.org> wro=
te:

> IIUC, if you boot while the SSD in the enclosure is already attached
> to the USB 3.2 port, everything works fine? Could you please attach a
> complete dmesg log from such a boot to the bugzilla, just as a
> baseline?

I added a complete dmesg with USB 3.2 (and USB4 too) connection before boo=
t to the bugzilla. USB 3.2 connection works fine both when connected befor=
e boot and when hotplugged. Is any other information I can provide needed?

--
Andrey
-----------------------02b76b9018760c600334190c3c7e05f7--

--------5a1b726c2bb2cadc38536e69d746567d4d9f909c73e39e41a9773a96532cbdba
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: ProtonMail

wnUEARYKACcFgmg8+cUJkC2//WlsAqGpFiEEowm2UA7MQsEG7isELb/9aWwC
oakAAHLgAQDHDnoBE5k8UqkQkiCJutsW6wbD18grUGgGPBvEoMsmogD/cDPr
BM4C+1+peIvFcYEZW8gXPKf0cLx2NGskPTppswc=
=ROpA
-----END PGP SIGNATURE-----


--------5a1b726c2bb2cadc38536e69d746567d4d9f909c73e39e41a9773a96532cbdba--


