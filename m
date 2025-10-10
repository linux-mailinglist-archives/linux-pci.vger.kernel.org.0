Return-Path: <linux-pci+bounces-37833-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 85485BCEC6B
	for <lists+linux-pci@lfdr.de>; Sat, 11 Oct 2025 01:49:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 0BD9334FBDC
	for <lists+linux-pci@lfdr.de>; Fri, 10 Oct 2025 23:49:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C32842E9EAE;
	Fri, 10 Oct 2025 23:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=permerror (0-bit key) header.d=sapience.com header.i=@sapience.com header.b="bBsgZB7j";
	dkim=pass (2048-bit key) header.d=sapience.com header.i=@sapience.com header.b="BjlxOxh/"
X-Original-To: linux-pci@vger.kernel.org
Received: from s1.sapience.com (s1.sapience.com [72.84.236.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EF9B2E9755;
	Fri, 10 Oct 2025 23:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=72.84.236.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760140178; cv=fail; b=QV/Qi6zZSiUY+0FfBAxn/v3+90/X4Zq2B6uPzPevC5BLSaESHOREjN2Gx/9B9Q4HgUFQR2O9ckSa4yjaOpjXypdI5t6dU7u63yWrQgyP2LX/QSBc0WXG8OxfLXUQ1Na6CXhVxU1dIg5aYuLjFAuLH0AMZomfc7TfYQjU7FbrStA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760140178; c=relaxed/simple;
	bh=1Y68sADJlVcz3CTM1RhBuA8huX1jYz6MJFnmx1aqQEg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nPMTO8kU+EdHbEY43cpbseZbbWtIMbNGfGgjzTiEfUIyUZCqvA2AGNwLdFTYWLEU6WVHWPenB5fOGaDgeKzRfBJ+n9Nqgw32lmpouRusa6+ikQePiAkaevZwUw/u2HlB64NjLPnqp/spvIVtiKmOQWX/uHdL+gV1T09tQJ3jhZ0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sapience.com; spf=pass smtp.mailfrom=sapience.com; dkim=permerror (0-bit key) header.d=sapience.com header.i=@sapience.com header.b=bBsgZB7j; dkim=pass (2048-bit key) header.d=sapience.com header.i=@sapience.com header.b=BjlxOxh/; arc=fail smtp.client-ip=72.84.236.66
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
	by s1.sapience.com (Postfix) with ESMTPS id 13548480A19;
	Fri, 10 Oct 2025 19:49:34 -0400 (EDT)
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=sapience.com;
 i=@sapience.com; q=dns/txt; s=dk-ed25519-220413; t=1760140174;
 h=message-id : subject : from : to : cc : date : in-reply-to :
 references : content-type : mime-version : from;
 bh=lITNrOoYlz5NtF0dTO17OVkT1HBT4ddwp1sL9fNtp1M=;
 b=bBsgZB7jkggR+GCu7jBiVn9b74/8Xb8eJpe86L3v7lw8CTLvTVFITv9TsiqOvP5Vxxael
 +QF3DRp2o16+LVpCw==
ARC-Seal: i=1; a=rsa-sha256; d=sapience.com; s=arc6-rsa-220412; t=1760140174;
	cv=none; b=Yqtmvavk2akNencssa/kz6cWMHQWRqeh8nsLKCJf33MFVYbTEj1+N1ububAEZ4YU7AC1SLzVkJcSiZW8IMr8bfbxuN/FvulGrq+scSncBIJ5a1hIfdVnhVK+z080aGoKh4fvFEbpZFxewabNGvveXmIh3ewnAf5/EQCRxra2F6G/cZVa/eqzVZDjY+zg8/yMNeYtQ/tWhZ3vd4gC2vhXclE5K4l6rusDUQvAhoFMcVGyzh3Afey57t/HOjvIO0SOHdu1Zd+XvGrWTZt/RcSPRXGgoeuqwJ+V95EhTeXDwaxeQmqIigJXAP/t0Ir5kcrMIZ2LLrJC+57rGv5/6lEbKg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=sapience.com; s=arc6-rsa-220412;
	t=1760140174; c=relaxed/simple;
	bh=1Y68sADJlVcz3CTM1RhBuA8huX1jYz6MJFnmx1aqQEg=;
	h=DKIM-Signature:DKIM-Signature:Message-ID:Subject:From:To:Cc:Date:
	 In-Reply-To:References:Autocrypt:Content-Type:User-Agent:
	 MIME-Version; b=P77in1VfHX8zHPeeR5Hf07CULZqINUEQn6/1eyXYXEVerUcWBZhGY8411GNvX9EyI+/bJ0het/kc341NjkPqPQquEKKxqRYzbqX7++2FfoReKq/DYbNzGvF/a9HI8GyKtktRs37mWAtkUwGz1OWaoiBA8g+5dpv3P+cduyc+8PgG6NYHw9pg7p8n4xR+p5aG0q40eV5OXzwxsUyWCSbHo2LXscndZn53TgaTMJ4k6F4rTTU3Y05JCw8FeyxVZ6UjWzkFj8PvuyERCYfmCku6nQ94VHh7js37kFdKYdWbjv74mMySeiL+adqBCkT9HEIGT4ccHi4nfXNvB7HZ+7MsPQ==
ARC-Authentication-Results: i=1; arc-srv8.sapience.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sapience.com;
 i=@sapience.com; q=dns/txt; s=dk-rsa-220413; t=1760140174;
 h=message-id : subject : from : to : cc : date : in-reply-to :
 references : content-type : mime-version : from;
 bh=lITNrOoYlz5NtF0dTO17OVkT1HBT4ddwp1sL9fNtp1M=;
 b=BjlxOxh/xZqgY78K8vukPyiZB3vzRYIkAZtb+6Vck7kRTUirlkr5L/Xzqu4ZLAUiHCq5q
 a0ElUTTLEwgi04p+XspT10KJWuCUrS01A6WGq+WDQV8NY1bOKGSS0IZug5CLjo3pXjAi/SH
 BR1efEgh0UPCWZ0gurzgtzDHKWfcVRL44/oqEFr1sD+FoV1C473t5mWhOhJRs5bIkQylQnI
 Do7EZg3CfSNEKA/t/mJAmVitTgny3jq9n+HQkzHIu3CQr5YxECalYmYzU1rzUFjZeSyenof
 8Idbm+DxULbFQa02dSfLh+ITpT7q7P0GGbhDk1u1laG0zwE/qmlkO/EWRxVg==
Received: by srv8.prv.sapience.com (Postfix) id C8A53284286;
	Fri, 10 Oct 2025 19:49:34 -0400 (EDT)
Message-ID: <3152ca947e89ee37264b90c422e77bb0e3d575b9.camel@sapience.com>
Subject: Re: mainline boot fail nvme/block? [BISECTED]
From: Genes Lists <lists@sapience.com>
To: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org
Cc: linux-pci@vger.kernel.org
Date: Fri, 10 Oct 2025 19:49:34 -0400
In-Reply-To: <cf4e88c6-0319-4084-8311-a7ca28a78c81@kernel.dk>
References: <4b392af8847cc19720ffcd53865f60ab3edc56b3.camel@sapience.com>
	 <cf4e88c6-0319-4084-8311-a7ca28a78c81@kernel.dk>
Autocrypt: addr=lists@sapience.com; prefer-encrypt=mutual;
 keydata=mDMEXSY9GRYJKwYBBAHaRw8BAQdAwzFfmp+m0ldl2vgmbtPC/XN7/k5vscpADq3BmRy5R
 7y0LU1haWwgTGlzdHMgKEwwIDIwMTkwNzEwKSA8bGlzdHNAc2FwaWVuY2UuY29tPoiWBBMWCAA+Ah
 sBBQsJCAcCBhUKCQgLAgQWAgMBAh4BAheAFiEE5YMoUxcbEgQOvOMKc+dlCv6PxQAFAmPJfooFCRl
 vRHEACgkQc+dlCv6PxQAc/wEA/Dbmg91DOGXll0OW1GKaZQGQDl7fHibMOKRGC6X/emoA+wQR5FIz
 BnV/PrXbao8LS/h0tSkeXgPsYxrzvfZInIAC
Content-Type: multipart/signed; micalg="pgp-sha384";
	protocol="application/pgp-signature"; boundary="=-EzuXFgResxDP94lPU5BL"
User-Agent: Evolution 3.58.1 
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0


--=-EzuXFgResxDP94lPU5BL
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2025-10-10 at 08:54 -0600, Jens Axboe wrote:
> On 10/10/25 8:29 AM, Genes Lists wrote:
> > Mainline fails to boot - 6.17.1 works fine.
> > Same kernel on an older laptop without any nvme works just fine.
> >=20
> > It seems to get stuck enumerating disks within the initramfs
> > created by
> > dracut.
> >=20
> > ,,,
> >=20
> > Machine is dell xps 9320 laptop (firmware 2.23.0) with nvme
> > partitioned:
> >=20
> > =C2=A0=C2=A0=C2=A0 # lsblk -f
> > =C2=A0=C2=A0=C2=A0 NAME=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 FSTYP=
E=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 FSVER LABEL FSAVAIL FSUSE%
> > MOUNTPOINTS=C2=A0=C2=A0=C2=A0=20
> > =C2=A0=C2=A0=C2=A0 sr0
> > =C2=A0=C2=A0=C2=A0 nvme0n1
> > =C2=A0=C2=A0=C2=A0 =E2=94=9C=E2=94=80nvme0n1p1 vfat=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 FAT32 ESP=C2=A0=C2=A0 2.6G=C2=A0=C2=A0=C2=A0 12% /=
boot
> > =C2=A0=C2=A0=C2=A0 =E2=94=9C=E2=94=80nvme0n1p2 ext4=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 1.0=C2=A0=C2=A0 root=C2=A0 77.7G=C2=A0=C2=A0=C2=A0=
 42% /=20
> > =C2=A0=C2=A0=C2=A0 =E2=94=94=E2=94=80nvme0n1p3 crypto_LUKS 2=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=20
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =E2=94=94=E2=94=80home=C2=A0=C2=A0=C2=A0=
 btrfs=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 home=C2=A0 1.3T=C2=A0=C2=A0=C2=A0 26% /opt
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0
> > /home=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=20
> >=20
> >=20
> >=20
> > Will try do bisect over the weekend.
>=20
> That'd be great, because there's really not much to glean from this
> bug
> report.

Bisect landed here. (cc linux-pci@vger.kernel.org)
Hopefully it is helpful, even though I don't see MSI in lspci output
(which is provided below).

gene


54f45a30c0d0153d2be091ba2d683ab6db6d1d5b is the first bad commit
commit 54f45a30c0d0153d2be091ba2d683ab6db6d1d5b (HEAD)
Author: Inochi Amaoto <inochiama@gmail.com>
Date:   Thu Aug 14 07:28:32 2025 +0800

    PCI/MSI: Add startup/shutdown for per device domains

    As the RISC-V PLIC cannot apply affinity settings without invoking
    irq_enable(), it will make the interrupt unavailble when used as an
    underlying interrupt chip for the MSI controller.

    Implement the irq_startup() and irq_shutdown() callbacks for the
PCI MSI
    and MSI-X templates.

    For chips that specify MSI_FLAG_PCI_MSI_STARTUP_PARENT, the parent
startup
    and shutdown functions are invoked. That allows the interrupt on
the parent
    chip to be enabled if the interrupt has not been enabled during
    allocation. This is necessary for MSI controllers which use PLIC as
    underlying parent interrupt chip.

    Suggested-by: Thomas Gleixner <tglx@linutronix.de>
    Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
    Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
    Tested-by: Chen Wang <unicorn_wang@outlook.com> # Pioneerbox
    Reviewed-by: Chen Wang <unicorn_wang@outlook.com>
    Acked-by: Bjorn Helgaas <bhelgaas@google.com>
    Link: https://lore.kernel.org/all/20250813232835.43458-3-
inochiama@gmail.com

 drivers/pci/msi/irqdomain.c | 52
++++++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/msi.h         |  2 ++
 2 files changed, 54 insertions(+)


----------------------------------------- lspci output ----------------
In case helpful here's lspci output:

0000:00:00.0 Host bridge: Intel Corporation Raptor Lake-P/U 4p+8e cores
Host Bridge/DRAM Controller
0000:00:02.0 VGA compatible controller: Intel Corporation Raptor Lake-P
[Iris Xe Graphics] (rev 04)
0000:00:04.0 Signal processing controller: Intel Corporation Raptor
Lake Dynamic Platform and Thermal Framework Processor Participant
0000:00:05.0 Multimedia controller: Intel Corporation Raptor Lake IPU
0000:00:06.0 System peripheral: Intel Corporation RST VMD Managed
Controller
0000:00:07.0 PCI bridge: Intel Corporation Raptor Lake-P Thunderbolt 4
PCI Express Root Port #0
0000:00:07.2 PCI bridge: Intel Corporation Raptor Lake-P Thunderbolt 4
PCI Express Root Port #2
0000:00:08.0 System peripheral: Intel Corporation GNA Scoring
Accelerator module
0000:00:0a.0 Signal processing controller: Intel Corporation Raptor
Lake Crashlog and Telemetry (rev 01)
0000:00:0d.0 USB controller: Intel Corporation Raptor Lake-P
Thunderbolt 4 USB Controller
0000:00:0d.2 USB controller: Intel Corporation Raptor Lake-P
Thunderbolt 4 NHI #0
0000:00:0d.3 USB controller: Intel Corporation Raptor Lake-P
Thunderbolt 4 NHI #1
0000:00:0e.0 RAID bus controller: Intel Corporation Volume Management
Device NVMe RAID Controller Intel Corporation
0000:00:12.0 Serial controller: Intel Corporation Alder Lake-P
Integrated Sensor Hub (rev 01)
0000:00:14.0 USB controller: Intel Corporation Alder Lake PCH USB 3.2
xHCI Host Controller (rev 01)
0000:00:14.2 RAM memory: Intel Corporation Alder Lake PCH Shared SRAM
(rev 01)
0000:00:14.3 Network controller: Intel Corporation Raptor Lake PCH CNVi
WiFi (rev 01)
0000:00:15.0 Serial bus controller: Intel Corporation Alder Lake PCH
Serial IO I2C Controller #0 (rev 01)
0000:00:15.1 Serial bus controller: Intel Corporation Alder Lake PCH
Serial IO I2C Controller #1 (rev 01)
0000:00:16.0 Communication controller: Intel Corporation Alder Lake PCH
HECI Controller (rev 01)
0000:00:1e.0 Communication controller: Intel Corporation Alder Lake PCH
UART #0 (rev 01)
0000:00:1e.3 Serial bus controller: Intel Corporation Alder Lake SPI
Controller (rev 01)
0000:00:1f.0 ISA bridge: Intel Corporation Raptor Lake LPC/eSPI
Controller (rev 01)
0000:00:1f.3 Multimedia audio controller: Intel Corporation Raptor
Lake-P/U/H cAVS (rev 01)
0000:00:1f.4 SMBus: Intel Corporation Alder Lake PCH-P SMBus Host
Controller (rev 01)
0000:00:1f.5 Serial bus controller: Intel Corporation Alder Lake-P PCH
SPI Controller (rev 01)
0000:01:00.0 PCI bridge: Intel Corporation Thunderbolt 4 Bridge [Goshen
Ridge 2020] (rev 02)
0000:02:00.0 PCI bridge: Intel Corporation Thunderbolt 4 Bridge [Goshen
Ridge 2020] (rev 02)
0000:02:01.0 PCI bridge: Intel Corporation Thunderbolt 4 Bridge [Goshen
Ridge 2020] (rev 02)
0000:02:02.0 PCI bridge: Intel Corporation Thunderbolt 4 Bridge [Goshen
Ridge 2020] (rev 02)
0000:02:03.0 PCI bridge: Intel Corporation Thunderbolt 4 Bridge [Goshen
Ridge 2020] (rev 02)
0000:02:04.0 PCI bridge: Intel Corporation Thunderbolt 4 Bridge [Goshen
Ridge 2020] (rev 02)
10000:e0:06.0 PCI bridge: Intel Corporation Raptor Lake PCIe 4.0
Graphics Port
10000:e1:00.0 Non-Volatile memory controller: SK hynix Platinum
P41/PC801 NVMe Solid State Drive


--=20
Gene

--=-EzuXFgResxDP94lPU5BL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iHUEABYJAB0WIQRByXNdQO2KDRJ2iXo5BdB0L6Ze2wUCaOmbjgAKCRA5BdB0L6Ze
298VAQCrzY8P7s8NGYPCxJ67f9kebbbfRXANLOptITSfMlvWpQEA4BCMploFlid4
nlm45XFlxw363kivOWeDbAY9yx6Gyww=
=j5Lv
-----END PGP SIGNATURE-----

--=-EzuXFgResxDP94lPU5BL--

