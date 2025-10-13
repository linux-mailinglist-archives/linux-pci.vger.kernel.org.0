Return-Path: <linux-pci+bounces-37894-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 73B51BD2D49
	for <lists+linux-pci@lfdr.de>; Mon, 13 Oct 2025 13:45:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9679E189D5B7
	for <lists+linux-pci@lfdr.de>; Mon, 13 Oct 2025 11:45:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 674BF1BD9F0;
	Mon, 13 Oct 2025 11:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=permerror (0-bit key) header.d=sapience.com header.i=@sapience.com header.b="i7ialYAl";
	dkim=pass (2048-bit key) header.d=sapience.com header.i=@sapience.com header.b="NV+39r7V"
X-Original-To: linux-pci@vger.kernel.org
Received: from s1.sapience.com (s1.sapience.com [72.84.236.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2849320126A;
	Mon, 13 Oct 2025 11:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=72.84.236.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760355915; cv=fail; b=Baqiey2WXDN0RjYxcvdg6Lx2FqZvpKq75ITICI3BJdhbzFyEj3jM8YMKWbSVtEjhqY14aaNOhu1Zxaj19jJHhPtQrxJVBI6WoquVnNzylFl4x6UJfKgpqo0sGBKyk0avOItjuf3SZpsYq/JWVFVsl1F8fT+6rW49ena7RzgBinA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760355915; c=relaxed/simple;
	bh=D6ewRJampzjtF9Y4k1uKVqxX0juZ56XOrC4QRhC2+JU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oYwQGMqSibsJAqyoHkb2EuuPndFMPf/4Xe+nPJMP5vtyBoOK9ZWNyWLS+mPRFVFdw3mcprfHjXYci6k0B1STMj+qaSC3xbIZOnUdRVero1m0+0ey05e25gvIn7CsoTRl6fcqKWIjidliKEtg1Oxo8my3/GJ/4IOSbA5PLVzDl7Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sapience.com; spf=pass smtp.mailfrom=sapience.com; dkim=permerror (0-bit key) header.d=sapience.com header.i=@sapience.com header.b=i7ialYAl; dkim=pass (2048-bit key) header.d=sapience.com header.i=@sapience.com header.b=NV+39r7V; arc=fail smtp.client-ip=72.84.236.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sapience.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sapience.com
Authentication-Results: dkim-srvy7; dkim=pass (Good ed25519-sha256 
   signature) header.d=sapience.com header.i=@sapience.com 
   header.a=ed25519-sha256; dkim=pass (Good 2048 bit rsa-sha256 signature) 
   header.d=sapience.com header.i=@sapience.com header.a=rsa-sha256
Received: from srv8.sapience.com (srv8.sapience.com [x.x.x.x])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (secp384r1) server-digest SHA384)
	(No client certificate requested)
	by s1.sapience.com (Postfix) with ESMTPS id 8285C4809DD;
	Mon, 13 Oct 2025 07:45:06 -0400 (EDT)
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=sapience.com;
 i=@sapience.com; q=dns/txt; s=dk-ed25519-220413; t=1760355906;
 h=message-id : subject : from : to : cc : date : in-reply-to :
 references : content-type : mime-version : from;
 bh=D6ewRJampzjtF9Y4k1uKVqxX0juZ56XOrC4QRhC2+JU=;
 b=i7ialYAlR4kNGPPahy5RkQVj/rvjLCDu3RfXQeOY8ST6Sw4tVsKiHUpO3Xgxt/YJ6ZN66
 vdGqCua94qUhNmbBQ==
ARC-Seal: i=1; a=rsa-sha256; d=sapience.com; s=arc6-rsa-220412; t=1760355906;
	cv=none; b=pWp5AtkOrpB5Ft2NFJinKhXtHaiVVoh+Ib6xpygjuX1mo4ccQdJmK9OXhqiKnEtKm4OL3TWEKsLimquLOR52ktNurbUGgTuDflEQdVNfrlC7K/9pIUCAafTS6pR1qjxnSuP82o0rxHJX0oQD/rnnzZJfIednY7OCua+Bzq7GSK2cHLjD1ZT4BqeATI3OAkucQJ8tBh4vFeC7T5dxXcWVOZ50owK8o69KONjYjdqwe5np9bEN2hYsA7RPChrFBnoAVbRqYPOu4hmXjqiInUV2c/lCVS6BneY+amFo5xJoS537DftEWthy6t0rJj3IhY5zTJrt+qPhP3nIu5T6rrFohA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=sapience.com; s=arc6-rsa-220412;
	t=1760355906; c=relaxed/simple;
	bh=D6ewRJampzjtF9Y4k1uKVqxX0juZ56XOrC4QRhC2+JU=;
	h=DKIM-Signature:DKIM-Signature:Message-ID:Subject:From:To:Cc:Date:
	 In-Reply-To:References:Autocrypt:Content-Type:User-Agent:
	 MIME-Version; b=ZkkPYQl++pamZ+uT1apN/h9TlCm1qC0R+Yx3QNlIlbzIvp0kA7PBPm0KQhA7w/FljSCpWW71kbuZJsYo3jRWfkP60vWNHoyaLU0JQkGpwaGhX6AtPcRamNiFU7aPLikQIYDgOTQu9iclWTFa7ioI6Bx5FTtN5p4KNZeOURGSQoUy4fVFHi2c9Q6KJhvYCUofNTmKYok39EZgGKrT5qCfK0AbIdD3H8WNd/ifPk5PdvWijwRdhSZdMefkKlRUzQJJFgB52/66m+bZA9IrYkkzenn6j5yQRWxs9/8ukpCTUcCAbhpyZJ3ecgLZ/1JSpYNxQM4Donq51AiBOTNfUrPM7Q==
ARC-Authentication-Results: i=1; arc-srv8.sapience.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sapience.com;
 i=@sapience.com; q=dns/txt; s=dk-rsa-220413; t=1760355906;
 h=message-id : subject : from : to : cc : date : in-reply-to :
 references : content-type : mime-version : from;
 bh=D6ewRJampzjtF9Y4k1uKVqxX0juZ56XOrC4QRhC2+JU=;
 b=NV+39r7VusSqwveMXlPPszRaeC9O1hasF99s6ANTTHFxQn1DNROW67wxOmJumLt61WUWe
 s2BBVVZi5aoEN3KnVnZq7ilQHbI+Qj9OW2nhfAZGO+gaOND8Xqcr483941oN9H8rH98d3L0
 fGx8OWbOzfgutDe5t/uA/uPs9GlQ4nxdsT5EgOW7DqGVXpQ0Su8qJORJAEnG/3vF9qzMYyw
 vrTqRrZGCuvRVxLmU1XJq+c4y83vSlV8z8B9+t12WieCvBepjudBXe9Wrzfyu+p3LJjIqu3
 daS/+iVrO9KylBKN4/WVgVLnvvJDZw/TMpXl7C6Lw5rArbY2QzqsuNKDwC+Q==
Received: by srv8.prv.sapience.com (Postfix) id 4AB4128001B;
	Mon, 13 Oct 2025 07:45:06 -0400 (EDT)
Message-ID: <622d6d7401b5cfd4bd5f359c7d7dc5b3bf8785d5.camel@sapience.com>
Subject: Re: mainline boot fail nvme/block? [BISECTED]
From: Genes Lists <lists@sapience.com>
To: Inochi Amaoto <inochiama@gmail.com>, Jens Axboe <axboe@kernel.dk>, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-nvme@lists.infradead.org
Cc: linux-pci@vger.kernel.org
Date: Mon, 13 Oct 2025 07:45:05 -0400
In-Reply-To: <trdjd7zhpldyeurmpvx4zpgjoz7hmf3ugayybz4gagu2iue56c@zswmzvauqnxk>
References: <4b392af8847cc19720ffcd53865f60ab3edc56b3.camel@sapience.com>
	 <cf4e88c6-0319-4084-8311-a7ca28a78c81@kernel.dk>
	 <3152ca947e89ee37264b90c422e77bb0e3d575b9.camel@sapience.com>
	 <trdjd7zhpldyeurmpvx4zpgjoz7hmf3ugayybz4gagu2iue56c@zswmzvauqnxk>
Autocrypt: addr=lists@sapience.com; prefer-encrypt=mutual;
 keydata=mDMEXSY9GRYJKwYBBAHaRw8BAQdAwzFfmp+m0ldl2vgmbtPC/XN7/k5vscpADq3BmRy5R
 7y0LU1haWwgTGlzdHMgKEwwIDIwMTkwNzEwKSA8bGlzdHNAc2FwaWVuY2UuY29tPoiWBBMWCAA+Ah
 sBBQsJCAcCBhUKCQgLAgQWAgMBAh4BAheAFiEE5YMoUxcbEgQOvOMKc+dlCv6PxQAFAmPJfooFCRl
 vRHEACgkQc+dlCv6PxQAc/wEA/Dbmg91DOGXll0OW1GKaZQGQDl7fHibMOKRGC6X/emoA+wQR5FIz
 BnV/PrXbao8LS/h0tSkeXgPsYxrzvfZInIAC
Content-Type: multipart/signed; micalg="pgp-sha384";
	protocol="application/pgp-signature"; boundary="=-dHWcg0gEsgsjYdWNT31Y"
User-Agent: Evolution 3.58.1 
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0


--=-dHWcg0gEsgsjYdWNT31Y
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2025-10-13 at 16:46 +0800, Inochi Amaoto wrote:
> On Fri, Oct 10, 2025 at 07:49:34PM -0400, Genes Lists wrote:
> > On Fri, 2025-10-10 at 08:54 -0600, Jens Axboe wrote:
> > > On 10/10/25 8:29 AM, Genes Lists wrote:
> > > > Mainline fails to boot - 6.17.1 works fine.
> > > > Same kernel on an older laptop without any nvme works just
> > > > fine.
> > > >=20
> > > > It seems to get stuck enumerating disks within the initramfs
> > > > created by
> > > > dracut.
> > > >=20
> > > > ,
...

> > Bisect landed here. (cc linux-pci@vger.kernel.org)
> > Hopefully it is helpful, even though I don't see MSI in lspci
> > output
> > (which is provided below).
> >=20
> > gene
> >=20
> >=20
> > 54f45a30c0d0153d2be091ba2d683ab6db6d1d5b is the first bad commit
> > commit 54f45a30c0d0153d2be091ba2d683ab6db6d1d5b (HEAD)
> > Author: Inochi Amaoto <inochiama@gmail.com>
> > Date:=C2=A0=C2=A0 Thu Aug 14 07:28:32 2025 +0800
> >=20
> > =C2=A0=C2=A0=C2=A0 PCI/MSI: Add startup/shutdown for per device domains
> >=20
> > =C2=A0=C2=A0=C2=A0 As the RISC-V PLIC cannot apply affinity settings wi=
thout
> > invoking
> > =C2=A0=C2=A0=C2=A0 irq_enable(), it will make the interrupt unavailble =
when used
> > as an
> > =C2=A0=C2=A0=C2=A0 underlying interrupt chip for the MSI controller.
> >=20
> > =C2=A0=C2=A0=C2=A0 Implement the irq_startup() and irq_shutdown() callb=
acks for
> > the
> > PCI MSI
> > =C2=A0=C2=A0=C2=A0 and MSI-X templates.
> >=20
> > =C2=A0=C2=A0=C2=A0 For chips that specify MSI_FLAG_PCI_MSI_STARTUP_PARE=
NT, the
> > parent
> > startup
> > =C2=A0=C2=A0=C2=A0 and shutdown functions are invoked. That allows the =
interrupt
> > on
> > the parent
> > =C2=A0=C2=A0=C2=A0 chip to be enabled if the interrupt has not been ena=
bled during
> > =C2=A0=C2=A0=C2=A0 allocation. This is necessary for MSI controllers wh=
ich use
> > PLIC as
> > =C2=A0=C2=A0=C2=A0 underlying parent interrupt chip.
> >=20
> > =C2=A0=C2=A0=C2=A0 Suggested-by: Thomas Gleixner <tglx@linutronix.de>
> > =C2=A0=C2=A0=C2=A0 Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
> > =C2=A0=C2=A0=C2=A0 Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> > =C2=A0=C2=A0=C2=A0 Tested-by: Chen Wang <unicorn_wang@outlook.com> # Pi=
oneerbox
> > =C2=A0=C2=A0=C2=A0 Reviewed-by: Chen Wang <unicorn_wang@outlook.com>
> > =C2=A0=C2=A0=C2=A0 Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> > =C2=A0=C2=A0=C2=A0 Link: https://lore.kernel.org/all/20250813232835.434=
58-3-
> > inochiama@gmail.com
> >=20
> > =C2=A0drivers/pci/msi/irqdomain.c | 52
> > ++++++++++++++++++++++++++++++++++++++++++++++++++++
> > =C2=A0include/linux/msi.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 |=C2=A0 2 ++
> > =C2=A02 files changed, 54 insertions(+)
> >=20
> >=20
...

>=20
>=20
> I think this is caused by VMD device, which I have a temporary
> solution
> here [1]. Since I have no idea about how VMD works, I hope if anyone
> can help to convert this as an formal fix.
>=20
> [1]
> https://lore.kernel.org/all/qs2vydzm6xngul77xuwjli7h757gzfhmb4siiklzo
> gihz5oplw@gsvgn75lib6t/
>=20
> Regards,
> Inochi

Thank you Inochi

I tried this patch over 6.18-rc1.

=C2=A0It get's further than without the patch but around the time I get
prompted for passphrase for the luks partition
(root is not encrypted) it crashes.=C2=A0

I have uploaded 2 images I took of the screen when this happens and
uploaded them to here:

=C2=A0 =C2=A0=C2=A0https://0x0.st/KSNz.jpg
=C2=A0 =C2=A0=C2=A0https://0x0.st/KSNi.jpg



--=20
Gene

--=-dHWcg0gEsgsjYdWNT31Y
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iHUEABYJAB0WIQRByXNdQO2KDRJ2iXo5BdB0L6Ze2wUCaOzmQQAKCRA5BdB0L6Ze
2793AQC4dSbOull9rvkIgpQMy3u8s0MnMnesKSkr8cl1aCcjhgEA8JsyZE0W3nxn
TlbuPaLE0GUc3sJJApkeNtTtuSG0Eww=
=3Ua6
-----END PGP SIGNATURE-----

--=-dHWcg0gEsgsjYdWNT31Y--

