Return-Path: <linux-pci+bounces-24829-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6D2DA72E59
	for <lists+linux-pci@lfdr.de>; Thu, 27 Mar 2025 12:02:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D21F617C38A
	for <lists+linux-pci@lfdr.de>; Thu, 27 Mar 2025 11:01:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13B5E20FAB5;
	Thu, 27 Mar 2025 11:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=louisalexis.eyraud@collabora.com header.b="ayOkl65d"
X-Original-To: linux-pci@vger.kernel.org
Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FAE220FAB2;
	Thu, 27 Mar 2025 11:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743073268; cv=pass; b=DkWEedINl41PItlo1vmgrXSb2RiOmZjN5ctBxmZpO7bdu3XS4TkcROJ8laQY/HrbpxThGq0lcmWb2RtM1VcFhjge7nl5Hq0FQHUEE8T02tx8LVm4wGxtrE2IaCS6MGF7EP4OBldrpCLPFHmIXlpYnKlD6QiSKkGA7jdQeIQpvCY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743073268; c=relaxed/simple;
	bh=xmmNe9TrmrlzJwtWz2nTc5rreYySpGYxAjdffxrDEMY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=p+s6VyYPGShtimRgHyq/7OSQx6bsEKGqzOeNkpUmI5yACBoxDYxDA4GqieX6ZXII0HQysm71Afxkt1x5sK16CrC1EgmRTFysxOFpqwVCII2Sbotr0SZMvQTPsupNvCkSWURFW9ZsQ1wXtmBxCLzHK1fFKTl/WPLz91iY+VApno0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=louisalexis.eyraud@collabora.com header.b=ayOkl65d; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1743073224; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=APT+wxoRq9/DO7eunJAgq4xMDGuQG1XU4wg5BbR1YvFO2YBmpEhDT1EdMVsStOaavW5IliTtd5GC4l1qf+v2muG2pQX8hX5gIpY0TTrYYaCM7uGXABB8ngW1TF+4n3w9KbCjo5VBK/4O2gC30SukHn0sJ/y30parHcLmbVdWp4k=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1743073224; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=M7KGw6V0JhmfGEKNoLV2jRgPg4HRPOgl0bvoHzTuVVQ=; 
	b=nSVVVwR5Bz7+fM3iw5fBhGl9ibtepzpo0thVfkSSrZgitsURrmUmxEOK7RgXm9w2qCYqIBCkCjn/1UXJov+wtZsjBvu+mOyDcqckhHf/Z1WNLsI46rf5LflVkbxc2Auf8QDQ2pjT17XEVH8WnOCkmDV0JltTbaZ9wsDjFkFju4w=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=louisalexis.eyraud@collabora.com;
	dmarc=pass header.from=<louisalexis.eyraud@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1743073224;
	s=zohomail; d=collabora.com; i=louisalexis.eyraud@collabora.com;
	h=Message-ID:Subject:Subject:From:From:To:To:Cc:Cc:Date:Date:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:MIME-Version:Message-Id:Reply-To;
	bh=M7KGw6V0JhmfGEKNoLV2jRgPg4HRPOgl0bvoHzTuVVQ=;
	b=ayOkl65dZnM6wTo1yGFfase0MMAaCC+2/c2Wt+6hrfRThYPn0gtPiG7oN1ueLGuc
	+wByGbyfjn0RZv8ulhqxTDqt5YKYVcjYZU8PmBFaJoiQ2Xvi7YRVfLTMwdVxYZmrLvM
	kEvveFnLbxbvxS3CCXJ+hiVdbxE0qhM1jDesZ0Kw=
Received: by mx.zohomail.com with SMTPS id 1743073221191726.7733757396418;
	Thu, 27 Mar 2025 04:00:21 -0700 (PDT)
Message-ID: <9ff0ed894902263c413595f35705c26bfc738270.camel@collabora.com>
Subject: Re: [PATCH v2 4/4] iommu: Get DT/ACPI parsing into the proper probe
 path
From: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
To: Chen-Yu Tsai <wenst@chromium.org>, Robin Murphy <robin.murphy@arm.com>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>, Hanjun Guo
 <guohanjun@huawei.com>,  Sudeep Holla <sudeep.holla@arm.com>, "Rafael J.
 Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,  Russell King
 <linux@armlinux.org.uk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Danilo Krummrich	 <dakr@kernel.org>, Stuart Yoder <stuyoder@gmail.com>,
 Laurentiu Tudor	 <laurentiu.tudor@nxp.com>, Nipun Gupta
 <nipun.gupta@amd.com>, Nikhil Agarwal	 <nikhil.agarwal@amd.com>, Joerg
 Roedel <joro@8bytes.org>, Will Deacon	 <will@kernel.org>, Rob Herring
 <robh@kernel.org>, Saravana Kannan	 <saravanak@google.com>, Bjorn Helgaas
 <bhelgaas@google.com>, 	linux-acpi@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, 	linux-kernel@vger.kernel.org,
 iommu@lists.linux.dev, devicetree@vger.kernel.org, 
	linux-pci@vger.kernel.org, Charan Teja Kalla <quic_charante@quicinc.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
 <angelogioacchino.delregno@collabora.com>, 
	linux-mediatek@lists.infradead.org
Date: Thu, 27 Mar 2025 12:00:14 +0100
In-Reply-To: <20250327094701.GA791706@google.com>
References: <cover.1740753261.git.robin.murphy@arm.com>
	 <e3b191e6fd6ca9a1e84c5e5e40044faf97abb874.1740753261.git.robin.murphy@arm.com>
	 <20250327094701.GA791706@google.com>
Organization: Collabora Ltd
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ZohoMailClient: External

Hi,

On Thu, 2025-03-27 at 17:47 +0800, Chen-Yu Tsai wrote:
> Hi,
>=20
> On Fri, Feb 28, 2025 at 03:46:33PM +0000, Robin Murphy wrote:
> > In hindsight, there were some crucial subtleties overlooked when
> > moving
> > {of,acpi}_dma_configure() to driver probe time to allow waiting for
> > IOMMU drivers with -EPROBE_DEFER, and these have become an
> > ever-increasing source of problems. The IOMMU API has some
> > fundamental
> > assumptions that iommu_probe_device() is called for every device
> > added
> > to the system, in the order in which they are added. Calling it in
> > a
> > random order or not at all dependent on driver binding leads to
> > malformed groups, a potential lack of isolation for devices with no
> > driver, and all manner of unexpected concurrency and race
> > conditions.
> > We've attempted to mitigate the latter with point-fix bodges like
> > iommu_probe_device_lock, but it's a losing battle and the time has
> > come
> > to bite the bullet and address the true source of the problem
> > instead.
> >=20
> > The crux of the matter is that the firmware parsing actually serves
> > two
> > distinct purposes; one is identifying the IOMMU instance associated
> > with
> > a device so we can check its availability, the second is actually
> > telling that instance about the relevant firmware-provided data for
> > the
> > device. However the latter also depends on the former, and at the
> > time
> > there was no good place to defer and retry that separately from the
> > availability check we also wanted for client driver probe.
> >=20
> > Nowadays, though, we have a proper notion of multiple IOMMU
> > instances in
> > the core API itself, and each one gets a chance to probe its own
> > devices
> > upon registration, so we can finally make that work as intended for
> > DT/IORT/VIOT platforms too. All we need is for iommu_probe_device()
> > to
> > be able to run the iommu_fwspec machinery currently buried deep in
> > the
> > wrong end of {of,acpi}_dma_configure(). Luckily it turns out to be
> > surprisingly straightforward to bootstrap this transformation by
> > pretty
> > much just calling the same path twice. At client driver probe time,
> > dev->driver is obviously set; conversely at device_add(), or a
> > subsequent bus_iommu_probe(), any device waiting for an IOMMU
> > really
> > should *not* have a driver already, so we can use that as a
> > condition to
> > disambiguate the two cases, and avoid recursing back into the IOMMU
> > core
> > at the wrong times.
> >=20
> > Obviously this isn't the nicest thing, but for now it gives us a
> > functional baseline to then unpick the layers in between without
> > many
> > more awkward cross-subsystem patches. There are some minor side-
> > effects
> > like dma_range_map potentially being created earlier, and some
> > debug
> > prints being repeated, but these aren't significantly detrimental.
> > Let's
> > make things work first, then deal with making them nice.
> >=20
> > With the basic flow finally in the right order again, the next step
> > is
> > probably turning the bus->dma_configure paths inside-out, since all
> > we
> > really need from bus code is its notion of which device and input
> > ID(s)
> > to parse the common firmware properties with...
> >=20
> > Acked-by: Bjorn Helgaas <bhelgaas@google.com> # pci-driver.c
> > Acked-by: Rob Herring (Arm) <robh@kernel.org> # of/device.c
> > Signed-off-by: Robin Murphy <robin.murphy@arm.com>
>=20
> This change causes the MediaTek IOMMU driver to panic on probe,
> resulting in multiple MediaTek platforms not being able to boot.
> This was observed on Linus's tree at commit 1a9239bb4253
> ("Merge tag 'net-next-6.15' of
> git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next")
> which just received the IOMMU updates a couple merge commits
> prior.
>=20
> The regression was bisected down to this patch on MT8183 Juniper
> Chromebook. The error is a NULL pointer dereference. Here's the
> decoded backtrace:
>=20
> =C2=A0=C2=A0=C2=A0 Unable to handle kernel read from unreadable memory at=
 virtual
> address 0000000000000000
> =C2=A0=C2=A0=C2=A0 Mem abort info:
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ESR =3D 0x0000000096000005
> =C2=A0=C2=A0=C2=A0 usb 1-1.1.2: new high-speed USB device number 6 using =
xhci-mtk
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 EC =3D 0x25: DABT (current EL), IL =3D 32 =
bits
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 SET =3D 0, FnV =3D 0
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 EA =3D 0, S1PTW =3D 0
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 FSC =3D 0x05: level 1 translation fault
> =C2=A0=C2=A0=C2=A0 Data abort info:
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ISV =3D 0, ISS =3D 0x00000005, ISS2 =3D 0x=
00000000
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 CM =3D 0, WnR =3D 0, TnD =3D 0, TagAccess =
=3D 0
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 GCS =3D 0, Overlay =3D 0, DirtyBit =3D 0, =
Xs =3D 0
> =C2=A0=C2=A0=C2=A0 [0000000000000000] user address but active_mm is swapp=
er
> =C2=A0=C2=A0=C2=A0 Internal error: Oops: 0000000096000005 [#1]=C2=A0 SMP
> =C2=A0=C2=A0=C2=A0 Modules linked in:
> =C2=A0=C2=A0=C2=A0 CPU: 4 UID: 0 PID: 68 Comm: kworker/u34:1 Tainted: G=
=C2=A0=C2=A0=C2=A0
> B=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 6.14.0-05877-g1a9239bb4253 #621 PREEMPT=C2=A0
> a6631d3f04612a5c23866dc67cf38316c6b023e0
> =C2=A0=C2=A0=C2=A0 Tainted: [B]=3DBAD_PAGE
> =C2=A0=C2=A0=C2=A0 Hardware name: Google juniper sku16 board (DT)
> =C2=A0=C2=A0=C2=A0 Workqueue: events_unbound deferred_probe_work_func
> =C2=A0=C2=A0=C2=A0 pstate: 40400005 (nZcv daif +PAN -UAO -TCO -DIT -SSBS =
BTYPE=3D--)
> =C2=A0=C2=A0=C2=A0 pc : mtk_iommu_device_group (drivers/iommu/mtk_iommu.c=
:368
> drivers/iommu/mtk_iommu.c:940)
> =C2=A0=C2=A0=C2=A0 lr : mtk_iommu_device_group (drivers/iommu/mtk_iommu.c=
:368
> drivers/iommu/mtk_iommu.c:940)
> =C2=A0=C2=A0=C2=A0 sp : ffffffc0809674a0
> =C2=A0=C2=A0=C2=A0 x29: ffffffc0809674a0 x28: ffffff80c1f0f078 x27: fffff=
f80c1f0f460
> =C2=A0=C2=A0=C2=A0 x26: ffffff80c1f0f458 x25: ffffffdb1b738788 x24: fffff=
fc0809676d0
> =C2=A0=C2=A0=C2=A0 x23: ffffff80c8fe4130 x22: ffffffffffffffed x21: 00000=
00000000000
> =C2=A0=C2=A0=C2=A0 x20: ffffff80c1f0f010 x19: ffffff80c8fd7d00 x18: 00000=
00000000000
> =C2=A0=C2=A0=C2=A0 x17: 000000040044ffff x16: 00500072b5593510 x15: 00000=
00000000000
> =C2=A0=C2=A0=C2=A0 x14: ffffff80c09fbb80 x13: ffffffa5bf03f000 x12: fffff=
fbb6399cdf1
> =C2=A0=C2=A0=C2=A0 x11: 1ffffffb6399cdf0 x10: ffffffbb6399cdf0 x9 : dffff=
fc000000000
> =C2=A0=C2=A0=C2=A0 x8 : 000000449c663210 x7 : ffffffdb1cce6f87 x6 : 00000=
00000000001
> =C2=A0=C2=A0=C2=A0 x5 : ffffffdb1cce6f80 x4 : ffffffbb6399cdf1 x3 : 00000=
00000000000
> =C2=A0=C2=A0=C2=A0 x2 : 0000000000000020 x1 : ffffff80c22ed940 x0 : 00000=
00000000001
> =C2=A0=C2=A0=C2=A0 Call trace:
> =C2=A0=C2=A0=C2=A0 mtk_iommu_device_group (drivers/iommu/mtk_iommu.c:368
> drivers/iommu/mtk_iommu.c:940) (P)
> =C2=A0=C2=A0=C2=A0 __iommu_probe_device (drivers/iommu/iommu.c:461
> drivers/iommu/iommu.c:563)
> =C2=A0=C2=A0=C2=A0 probe_iommu_group (drivers/iommu/iommu.c:1722)
> =C2=A0=C2=A0=C2=A0 bus_for_each_dev (drivers/base/bus.c:370)
> =C2=A0=C2=A0=C2=A0 iommu_device_register (drivers/iommu/iommu.c:1875
> drivers/iommu/iommu.c:276)
> =C2=A0=C2=A0=C2=A0 mtk_iommu_probe (drivers/iommu/mtk_iommu.c:1380)
> =C2=A0=C2=A0=C2=A0 platform_probe (drivers/base/platform.c:1404)
> =C2=A0=C2=A0=C2=A0 really_probe (drivers/base/dd.c:579 drivers/base/dd.c:=
658)
> =C2=A0=C2=A0=C2=A0 __driver_probe_device (drivers/base/dd.c:800)
> =C2=A0=C2=A0=C2=A0 driver_probe_device (drivers/base/dd.c:830)
> =C2=A0=C2=A0=C2=A0 __device_attach_driver (drivers/base/dd.c:959)
> =C2=A0=C2=A0=C2=A0 bus_for_each_drv (drivers/base/bus.c:462)
> =C2=A0=C2=A0=C2=A0 __device_attach (drivers/base/dd.c:1032)
> =C2=A0=C2=A0=C2=A0 device_initial_probe (drivers/base/dd.c:1080)
> =C2=A0=C2=A0=C2=A0 bus_probe_device (drivers/base/bus.c:537)
> =C2=A0=C2=A0=C2=A0 deferred_probe_work_func (drivers/base/dd.c:124)
> =C2=A0=C2=A0=C2=A0 process_one_work (./arch/arm64/include/asm/jump_label.=
h:36
> ./include/trace/events/workqueue.h:110 kernel/workqueue.c:3243)
> =C2=A0=C2=A0=C2=A0 worker_thread (kernel/workqueue.c:3313 (discriminator =
2)
> kernel/workqueue.c:3400 (discriminator 2))
> =C2=A0=C2=A0=C2=A0 kthread (kernel/kthread.c:464)
> =C2=A0=C2=A0=C2=A0 ret_from_fork (arch/arm64/kernel/entry.S:863)
> =C2=A0=C2=A0=C2=A0 Code: 92800256 f940d2b5 aa1503e0 97e8dbd7 (f94002b5)
> =C2=A0=C2=A0=C2=A0 All code
> =C2=A0=C2=A0=C2=A0 =3D=3D=3D=3D=3D=3D=3D=3D
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0:	92800256=C2=A0	mov	x22,
> #0xffffffffffffffed=C2=A0=C2=A0=C2=A0=C2=A0	// #-19
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 4:	f940d2b5=C2=A0	ldr	x21, [x21, #41=
6]
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 8:	aa1503e0=C2=A0	mov	x0, x21
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 c:	97e8dbd7=C2=A0	bl	0xffffffffffa36=
f68
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 10:*	f94002b5=C2=A0	ldr	x21, [x21]		<--
> trapping instruction
>=20
> =C2=A0=C2=A0=C2=A0 Code starting with the faulting instruction
> =C2=A0=C2=A0=C2=A0 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0:	f94002b5=C2=A0	ldr	x21, [x21]
> =C2=A0=C2=A0=C2=A0 ---[ end trace 0000000000000000 ]---
>=20
>=20
> ChenYu
>=20
I've sent a patch [1] to fix this issue that I've also observed on
my Mediatek Genio boards (510-EVK and 1200-EVK).

[1]:https://lore.kernel.org/linux-iommu/20250327-fix-mtk-iommu-error-v1-1-d=
f969158e752@collabora.com/

Regards,
Louis-Alexis

> > ---
> >=20
> > v2:
> > =C2=A0- Comment bus driver changes for clarity
> > =C2=A0- Use dev->iommu as the now-robust replay condition
> > =C2=A0- Drop the device_iommu_mapped() checks in the firmware paths as
> > they
> > =C2=A0=C2=A0 weren't doing much - we can't replace probe_device_lock ju=
st
> > yet...
> > =C2=A0
> > =C2=A0drivers/acpi/arm64/dma.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 |=C2=A0 5 +++++
> > =C2=A0drivers/acpi/scan.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 7 -------
> > =C2=A0drivers/amba/bus.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 3 ++-
> > =C2=A0drivers/base/platform.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 |=C2=A0 3 ++-
> > =C2=A0drivers/bus/fsl-mc/fsl-mc-bus.c |=C2=A0 3 ++-
> > =C2=A0drivers/cdx/cdx.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 3 ++-
> > =C2=A0drivers/iommu/iommu.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 | 24 +++++++++++++++++++++---
> > =C2=A0drivers/iommu/of_iommu.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 |=C2=A0 7 ++++++-
> > =C2=A0drivers/of/device.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 7 ++++++-
> > =C2=A0drivers/pci/pci-driver.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 |=C2=A0 3 ++-
> > =C2=A010 files changed, 48 insertions(+), 17 deletions(-)
> >=20
> > diff --git a/drivers/acpi/arm64/dma.c b/drivers/acpi/arm64/dma.c
> > index 52b2abf88689..f30f138352b7 100644
> > --- a/drivers/acpi/arm64/dma.c
> > +++ b/drivers/acpi/arm64/dma.c
> > @@ -26,6 +26,11 @@ void acpi_arch_dma_setup(struct device *dev)
> > =C2=A0	else
> > =C2=A0		end =3D (1ULL << 32) - 1;
> > =C2=A0
> > +	if (dev->dma_range_map) {
> > +		dev_dbg(dev, "dma_range_map already set\n");
> > +		return;
> > +	}
> > +
> > =C2=A0	ret =3D acpi_dma_get_range(dev, &map);
> > =C2=A0	if (!ret && map) {
> > =C2=A0		end =3D dma_range_map_max(map);
> > diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
> > index 9f4efa8f75a6..fb1fe9f3b1a3 100644
> > --- a/drivers/acpi/scan.c
> > +++ b/drivers/acpi/scan.c
> > @@ -1632,13 +1632,6 @@ static int acpi_iommu_configure_id(struct
> > device *dev, const u32 *id_in)
> > =C2=A0		err =3D viot_iommu_configure(dev);
> > =C2=A0	mutex_unlock(&iommu_probe_device_lock);
> > =C2=A0
> > -	/*
> > -	 * If we have reason to believe the IOMMU driver missed
> > the initial
> > -	 * iommu_probe_device() call for dev, replay it to get
> > things in order.
> > -	 */
> > -	if (!err && dev->bus)
> > -		err =3D iommu_probe_device(dev);
> > -
> > =C2=A0	return err;
> > =C2=A0}
> > =C2=A0
> > diff --git a/drivers/amba/bus.c b/drivers/amba/bus.c
> > index 8ef259b4d037..71482d639a6d 100644
> > --- a/drivers/amba/bus.c
> > +++ b/drivers/amba/bus.c
> > @@ -364,7 +364,8 @@ static int amba_dma_configure(struct device
> > *dev)
> > =C2=A0		ret =3D acpi_dma_configure(dev, attr);
> > =C2=A0	}
> > =C2=A0
> > -	if (!ret && !drv->driver_managed_dma) {
> > +	/* @drv may not be valid when we're called from the IOMMU
> > layer */
> > +	if (!ret && dev->driver && !drv->driver_managed_dma) {
> > =C2=A0		ret =3D iommu_device_use_default_domain(dev);
> > =C2=A0		if (ret)
> > =C2=A0			arch_teardown_dma_ops(dev);
> > diff --git a/drivers/base/platform.c b/drivers/base/platform.c
> > index 6f2a33722c52..1813cfd0c4bd 100644
> > --- a/drivers/base/platform.c
> > +++ b/drivers/base/platform.c
> > @@ -1451,7 +1451,8 @@ static int platform_dma_configure(struct
> > device *dev)
> > =C2=A0		attr =3D
> > acpi_get_dma_attr(to_acpi_device_node(fwnode));
> > =C2=A0		ret =3D acpi_dma_configure(dev, attr);
> > =C2=A0	}
> > -	if (ret || drv->driver_managed_dma)
> > +	/* @drv may not be valid when we're called from the IOMMU
> > layer */
> > +	if (ret || !dev->driver || drv->driver_managed_dma)
> > =C2=A0		return ret;
> > =C2=A0
> > =C2=A0	ret =3D iommu_device_use_default_domain(dev);
> > diff --git a/drivers/bus/fsl-mc/fsl-mc-bus.c b/drivers/bus/fsl-
> > mc/fsl-mc-bus.c
> > index d1f3d327ddd1..a8be8cf246fb 100644
> > --- a/drivers/bus/fsl-mc/fsl-mc-bus.c
> > +++ b/drivers/bus/fsl-mc/fsl-mc-bus.c
> > @@ -153,7 +153,8 @@ static int fsl_mc_dma_configure(struct device
> > *dev)
> > =C2=A0	else
> > =C2=A0		ret =3D acpi_dma_configure_id(dev, DEV_DMA_COHERENT,
> > &input_id);
> > =C2=A0
> > -	if (!ret && !mc_drv->driver_managed_dma) {
> > +	/* @mc_drv may not be valid when we're called from the
> > IOMMU layer */
> > +	if (!ret && dev->driver && !mc_drv->driver_managed_dma) {
> > =C2=A0		ret =3D iommu_device_use_default_domain(dev);
> > =C2=A0		if (ret)
> > =C2=A0			arch_teardown_dma_ops(dev);
> > diff --git a/drivers/cdx/cdx.c b/drivers/cdx/cdx.c
> > index c573ed2ee71a..780fb0c4adba 100644
> > --- a/drivers/cdx/cdx.c
> > +++ b/drivers/cdx/cdx.c
> > @@ -360,7 +360,8 @@ static int cdx_dma_configure(struct device
> > *dev)
> > =C2=A0		return ret;
> > =C2=A0	}
> > =C2=A0
> > -	if (!ret && !cdx_drv->driver_managed_dma) {
> > +	/* @cdx_drv may not be valid when we're called from the
> > IOMMU layer */
> > +	if (!ret && dev->driver && !cdx_drv->driver_managed_dma) {
> > =C2=A0		ret =3D iommu_device_use_default_domain(dev);
> > =C2=A0		if (ret)
> > =C2=A0			arch_teardown_dma_ops(dev);
> > diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> > index a3b45b84f42b..1cec7074367a 100644
> > --- a/drivers/iommu/iommu.c
> > +++ b/drivers/iommu/iommu.c
> > @@ -414,9 +414,21 @@ static int iommu_init_device(struct device
> > *dev)
> > =C2=A0	if (!dev_iommu_get(dev))
> > =C2=A0		return -ENOMEM;
> > =C2=A0	/*
> > -	 * For FDT-based systems and ACPI IORT/VIOT, drivers
> > register IOMMU
> > -	 * instances with non-NULL fwnodes, and client devices
> > should have been
> > -	 * identified with a fwspec by this point. Otherwise, we
> > can currently
> > +	 * For FDT-based systems and ACPI IORT/VIOT, the common
> > firmware parsing
> > +	 * is buried in the bus dma_configure path. Properly
> > unpicking that is
> > +	 * still a big job, so for now just invoke the whole
> > thing. The device
> > +	 * already having a driver bound means dma_configure has
> > already run and
> > +	 * either found no IOMMU to wait for, or we're in its
> > replay call right
> > +	 * now, so either way there's no point calling it again.
> > +	 */
> > +	if (!dev->driver && dev->bus->dma_configure) {
> > +		mutex_unlock(&iommu_probe_device_lock);
> > +		dev->bus->dma_configure(dev);
> > +		mutex_lock(&iommu_probe_device_lock);
> > +	}
> > +	/*
> > +	 * At this point, relevant devices either now have a
> > fwspec which will
> > +	 * match ops registered with a non-NULL fwnode, or we can
> > reasonably
> > =C2=A0	 * assume that only one of Intel, AMD, s390, PAMU or
> > legacy SMMUv2 can
> > =C2=A0	 * be present, and that any of their registered instances
> > has suitable
> > =C2=A0	 * ops for probing, and thus cheekily co-opt the same
> > mechanism.
> > @@ -426,6 +438,12 @@ static int iommu_init_device(struct device
> > *dev)
> > =C2=A0		ret =3D -ENODEV;
> > =C2=A0		goto err_free;
> > =C2=A0	}
> > +	/*
> > +	 * And if we do now see any replay calls, they would
> > indicate someone
> > +	 * misusing the dma_configure path outside bus code.
> > +	 */
> > +	if (dev->driver)
> > +		dev_WARN(dev, "late IOMMU probe at driver bind,
> > something fishy here!\n");
> > =C2=A0
> > =C2=A0	if (!try_module_get(ops->owner)) {
> > =C2=A0		ret =3D -EINVAL;
> > diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
> > index e10a68b5ffde..6b989a62def2 100644
> > --- a/drivers/iommu/of_iommu.c
> > +++ b/drivers/iommu/of_iommu.c
> > @@ -155,7 +155,12 @@ int of_iommu_configure(struct device *dev,
> > struct device_node *master_np,
> > =C2=A0		dev_iommu_free(dev);
> > =C2=A0	mutex_unlock(&iommu_probe_device_lock);
> > =C2=A0
> > -	if (!err && dev->bus)
> > +	/*
> > +	 * If we're not on the iommu_probe_device() path (as
> > indicated by the
> > +	 * initial dev->iommu) then try to simulate it. This
> > should no longer
> > +	 * happen unless of_dma_configure() is being misused
> > outside bus code.
> > +	 */
> > +	if (!err && dev->bus && !dev_iommu_present)
> > =C2=A0		err =3D iommu_probe_device(dev);
> > =C2=A0
> > =C2=A0	if (err && err !=3D -EPROBE_DEFER)
> > diff --git a/drivers/of/device.c b/drivers/of/device.c
> > index edf3be197265..5053e5d532cc 100644
> > --- a/drivers/of/device.c
> > +++ b/drivers/of/device.c
> > @@ -99,6 +99,11 @@ int of_dma_configure_id(struct device *dev,
> > struct device_node *np,
> > =C2=A0	bool coherent, set_map =3D false;
> > =C2=A0	int ret;
> > =C2=A0
> > +	if (dev->dma_range_map) {
> > +		dev_dbg(dev, "dma_range_map already set\n");
> > +		goto skip_map;
> > +	}
> > +
> > =C2=A0	if (np =3D=3D dev->of_node)
> > =C2=A0		bus_np =3D __of_get_dma_parent(np);
> > =C2=A0	else
> > @@ -119,7 +124,7 @@ int of_dma_configure_id(struct device *dev,
> > struct device_node *np,
> > =C2=A0		end =3D dma_range_map_max(map);
> > =C2=A0		set_map =3D true;
> > =C2=A0	}
> > -
> > +skip_map:
> > =C2=A0	/*
> > =C2=A0	 * If @dev is expected to be DMA-capable then the bus code
> > that created
> > =C2=A0	 * it should have initialised its dma_mask pointer by this
> > point. For
> > diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
> > index f57ea36d125d..4468b7327cab 100644
> > --- a/drivers/pci/pci-driver.c
> > +++ b/drivers/pci/pci-driver.c
> > @@ -1653,7 +1653,8 @@ static int pci_dma_configure(struct device
> > *dev)
> > =C2=A0
> > =C2=A0	pci_put_host_bridge_device(bridge);
> > =C2=A0
> > -	if (!ret && !driver->driver_managed_dma) {
> > +	/* @driver may not be valid when we're called from the
> > IOMMU layer */
> > +	if (!ret && dev->driver && !driver->driver_managed_dma) {
> > =C2=A0		ret =3D iommu_device_use_default_domain(dev);
> > =C2=A0		if (ret)
> > =C2=A0			arch_teardown_dma_ops(dev);
> > --=20
> > 2.39.2.101.g768bb238c484.dirty
> >=20
>=20


