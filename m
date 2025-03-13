Return-Path: <linux-pci+bounces-23592-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B979A5F035
	for <lists+linux-pci@lfdr.de>; Thu, 13 Mar 2025 11:04:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EFC0419C172C
	for <lists+linux-pci@lfdr.de>; Thu, 13 Mar 2025 10:04:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B37E526462B;
	Thu, 13 Mar 2025 10:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="GVd+xnki"
X-Original-To: linux-pci@vger.kernel.org
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8E1F264630
	for <linux-pci@vger.kernel.org>; Thu, 13 Mar 2025 10:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741860262; cv=none; b=e4gSpgWHraLVvovUjqfaFKpyX+PnVFUYHm0QgBojZATOCqULnLEzFgAUppCv9yHo8SH8px8bLjIqBYo7c3AhQvxnZvL+WTPfrZcN4MkflFYexV3yB242LYDXyyLKb/k4joxx19akKbb/XgrHykxsIVfPKKzKd3Td65BYqR3pVME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741860262; c=relaxed/simple;
	bh=SNse85hwvTNgWan+jvh77pDCpp4UhKv+YJcqiQ9cRvA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=WKJxmDNqQZjJYItyq0SBNoP3naG27p6G0oQ9Orcv4f23nIHD5ZRlpuDn5+nWsgXtTjFnSQDiVwx+PryG2zAHvtLHmGpzLjj763CAMPEAclhKAs/t0GfftIZf1OJunMfZ0G3DwiqydxnsOq1wfP/Z0ZZQapboifjkHSa122Afsac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=GVd+xnki; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20250313095635euoutp02c22bd29f29b2c08bdb9e952e490ff630~sVEFBiOaw1327913279euoutp02D
	for <linux-pci@vger.kernel.org>; Thu, 13 Mar 2025 09:56:35 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20250313095635euoutp02c22bd29f29b2c08bdb9e952e490ff630~sVEFBiOaw1327913279euoutp02D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1741859795;
	bh=7r/w7U2XT56aa+CytAsw7Ns1CvaaFUfylTEwM6MP9Lo=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=GVd+xnki6izV8NpKyMd0jAQoPZ6/ebpxSOown5qxvT1gDv6cEl1glr9IdntK+B+GF
	 yvP/Gd0Bo/lSG52bqwIv1mruWSJMYc4CHFGmbn2jzDOWXYscqyhXGSvjU+HzQ82csY
	 E5sjXB54qMbvqtAZHJ5Qj/g/8yZPN4NSpN0Ne5oU=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTP id
	20250313095634eucas1p1da7a0d632d9b840f4b395a7056b6df3e~sVEEKmZPv1667916679eucas1p1H;
	Thu, 13 Mar 2025 09:56:34 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
	eusmges1new.samsung.com (EUCPMTA) with SMTP id C2.0A.20821.2DBA2D76; Thu, 13
	Mar 2025 09:56:34 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20250313095633eucas1p29cb55f2504b4bcf67c16b3bd3fa9b8cd~sVEDqsHsm1164611646eucas1p21;
	Thu, 13 Mar 2025 09:56:33 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
	eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20250313095633eusmtrp136118e25435f486b85010eeb2dcbf1b5~sVEDpxfNx3259832598eusmtrp1d;
	Thu, 13 Mar 2025 09:56:33 +0000 (GMT)
X-AuditID: cbfec7f2-b11c470000005155-ce-67d2abd233ec
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
	eusmgms2.samsung.com (EUCPMTA) with SMTP id FD.6E.19654.1DBA2D76; Thu, 13
	Mar 2025 09:56:33 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20250313095631eusmtip2272fadc46d8e4aade8ba7e9684d144ed~sVEBNWsrM0285602856eusmtip2P;
	Thu, 13 Mar 2025 09:56:30 +0000 (GMT)
Message-ID: <9b358d68-332e-404e-9a75-740297f7b28d@samsung.com>
Date: Thu, 13 Mar 2025 10:56:30 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] iommu: Get DT/ACPI parsing into the proper probe
 path
To: Robin Murphy <robin.murphy@arm.com>, Lorenzo Pieralisi
	<lpieralisi@kernel.org>, Hanjun Guo <guohanjun@huawei.com>, Sudeep Holla
	<sudeep.holla@arm.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown
	<lenb@kernel.org>, Russell King <linux@armlinux.org.uk>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, Danilo Krummrich <dakr@kernel.org>, Stuart
	Yoder <stuyoder@gmail.com>, Laurentiu Tudor <laurentiu.tudor@nxp.com>, Nipun
	Gupta <nipun.gupta@amd.com>, Nikhil Agarwal <nikhil.agarwal@amd.com>, Joerg
	Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, Rob Herring
	<robh@kernel.org>, Saravana Kannan <saravanak@google.com>, Bjorn Helgaas
	<bhelgaas@google.com>
Cc: linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	devicetree@vger.kernel.org, linux-pci@vger.kernel.org, Charan Teja Kalla
	<quic_charante@quicinc.com>
Content-Language: en-US
From: Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <e3b191e6fd6ca9a1e84c5e5e40044faf97abb874.1740753261.git.robin.murphy@arm.com>
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01SfUxbVRzN7Xt9fW0svnYYrtuErEYSiZZhRrzbABkh8RFnxOxDx9TZjGch
	lA9bcOoyRmhhUGECkw7KWhrYxixVoOBsJ6NrIXaAIisb1spC2NjccMCgxWRziC1vU/4759xz
	7vn9bi6JiY3EejI7r5BR5skUEkKAn//xwS8ve9o98s2WSzx0ujQL/am7T6DmgREuUrd2EMhp
	b+ShhwGEKps6eShQM4wj+9Qsgdr6vgTIenOci8YunCLQz0Y3gVz1FwHSPNLgqMEmRUt3dTjq
	aM5FhkA9hlZ6bTzkvD/NRVrXcvDaLh+G2oZsONJMxCc/S087jRy6zLNM0BajBdBj41cw2q6/
	zqNN1iJaMzDLpa3mSoJ2GCw8uvv0UfpOdyOgu+ZsHLq2t5j2WyPTwzIECZmMIvsTRhmb9KEg
	S3P2BqegL//Ta48q8BIwsk8L+CSktsAzty8BLRCQYuocgCvOQYIlAQBLDP2PiR9A71Q590mk
	qnqZCGEx1QZgy9DHLF4A0GwvCGEhlQRnymd5IYxTL8Azi1/jrC6Cg43Tq/gZKgpO+hpWPeuo
	XXBOe2N1jHDKyoW/lv3EDRGMugVg5zXvahtGRUDfdDMnhAkqDmpntas6n9oPTdpeLuuJgurv
	mrBQGFIGAazvb8XYsVOh7/tBgsXr4Iy7h8fijXD4RBXOBo4BaPp7ksOSmuAL/OEDrGs7nBh5
	GEyTwYoXYceFWFbeAbX+eiwkQyoMemdF7BBhsO78yceyEFaUi1l3NNS7v/2v1jnqwWqARL/m
	YfRr1tSvWUf/f68J4GYQwRSpcuWMKi6POSRVyXJVRXly6cH8XCsIfuHhf9yLNmCYWZC6AIcE
	LgBJTBIubE8clYuFmbLPPmeU+QeURQpG5QIbSFwSIWxxlMnFlFxWyOQwTAGjfHLKIfnrSzgb
	fES+gZ+Vc6TfUe14ZzFFcaxRvz05POMjcvnwvc1bf1uZwqq7Gyay0yJdhJXf83SZOmWPaqDy
	8nixYXKT9dabPQrfpnNRyjvlGt0Pdkdf6c5hS3bizrn0vKdei/1g2x5R1IOa9wszTkU7j0dU
	JB6a14LUN7aJ/Lyv+lIW+t5uqo2cB2b61b1nxwWjruPJsG4s3hP7iinMe9SqfCk9PmOoBIsh
	uwyZxWlbpqr27j641W5svpqadPev381emFWhvtodLTJfTEnXva7fcaXdf7lFcrtfpw7kvLcU
	d/jk8xuFSzHRIz2laW89d0Bae+SLhbp7rTffTWjb16lz7+/8JqE2c/66BFdlyeJiMKVK9i9x
	joX9MQQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrEKsWRmVeSWpSXmKPExsVy+t/xe7oXV19KN5j5X9FiSVOGxetpH9gs
	5h85x2rRvHg9m8XBnTPZLX59sbDonL2B3eLLhNMsFjsfvmWzWL6vn9Fi0+NrrBaXd81hszg7
	7zibxaGpexktWv60sFjM2KFn8fXlNBaL9fNzLeZ+mcps8X/PDnaLgx+esFp0HfoLNHbjLWaL
	5ad2sFi03DF1kPR4cnAek0frpb9sHmvmrWH0uHztIrPHzll32T0WbCr1aDnyltVj06pONo/9
	c9ewe2xeUu/xYvNMRo+N73YweUzcU+fxeZNcAF+Unk1RfmlJqkJGfnGJrVK0oYWRnqGlhZ6R
	iaWeobF5rJWRqZK+nU1Kak5mWWqRvl2CXkbLskdMBfvyK67+6WBpYDwX2cXIySEhYCLR0/uX
	rYuRi0NIYCmjxOujHSwQCRmJk9MaWCFsYYk/17qgit4zSiw/28YIkuAVsJN41faWHcRmEVCV
	WPppJQtEXFDi5MwnYLaogLzE/VszwGqEBYIl3nU9YgQZJCKwjVXi2rydzCAOs8BTRokv55+x
	QqzoYJRY1/KWGaSFWUBc4taT+UwgNpuAoUTXW5A7ODk4BaIlFnTtYYWoMZPo2trFCGHLSzRv
	nc08gVFoFpJLZiEZNQtJyywkLQsYWVYxiqSWFuem5xYb6RUn5haX5qXrJefnbmIEJp5tx35u
	2cG48tVHvUOMTByMhxglOJiVRHhX215IF+JNSaysSi3Kjy8qzUktPsRoCgyOicxSosn5wNSX
	VxJvaGZgamhiZmlgamlmrCTOy3blfJqQQHpiSWp2ampBahFMHxMHp1QD0+73jwJbDJ5xpG5c
	qRSStmG+yezgMxn3gm8eM+wNDz2bqdkn//U4O9dxxWmrv8dX3vFglFr8PK1Z9EX5uqR7B0rY
	dhuHWKw7lDHp4h8mX493cs8dHPMYPjvYRGlHWLn/UJzRpxonwLc3QpilWbM8ec/aAuulGY92
	Lz206dCKZYJKR34v5OKy/3qt/uaRJSes6gPbf3+Ksi/7Kq++skpeu+mqs76JjqhOwSXVerGk
	fUc5Cj/NiDX+8Drs0c4P14+/mCJ3+G2d6h/Fbr4jidGSa10VpLUeztqRyDX3WEKj0InL56W6
	OCV+3zoy2fH9HI8Q5oWzZzOuC8tLLJEU2cU+2dd6Ru+KTQ6clw7rRP0tUGIpzkg01GIuKk4E
	ACR6U2bFAwAA
X-CMS-MailID: 20250313095633eucas1p29cb55f2504b4bcf67c16b3bd3fa9b8cd
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20250313095633eucas1p29cb55f2504b4bcf67c16b3bd3fa9b8cd
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20250313095633eucas1p29cb55f2504b4bcf67c16b3bd3fa9b8cd
References: <cover.1740753261.git.robin.murphy@arm.com>
	<e3b191e6fd6ca9a1e84c5e5e40044faf97abb874.1740753261.git.robin.murphy@arm.com>
	<CGME20250313095633eucas1p29cb55f2504b4bcf67c16b3bd3fa9b8cd@eucas1p2.samsung.com>

Hi Robin,

On 28.02.2025 16:46, Robin Murphy wrote:
> In hindsight, there were some crucial subtleties overlooked when moving
> {of,acpi}_dma_configure() to driver probe time to allow waiting for
> IOMMU drivers with -EPROBE_DEFER, and these have become an
> ever-increasing source of problems. The IOMMU API has some fundamental
> assumptions that iommu_probe_device() is called for every device added
> to the system, in the order in which they are added. Calling it in a
> random order or not at all dependent on driver binding leads to
> malformed groups, a potential lack of isolation for devices with no
> driver, and all manner of unexpected concurrency and race conditions.
> We've attempted to mitigate the latter with point-fix bodges like
> iommu_probe_device_lock, but it's a losing battle and the time has come
> to bite the bullet and address the true source of the problem instead.
>
> The crux of the matter is that the firmware parsing actually serves two
> distinct purposes; one is identifying the IOMMU instance associated with
> a device so we can check its availability, the second is actually
> telling that instance about the relevant firmware-provided data for the
> device. However the latter also depends on the former, and at the time
> there was no good place to defer and retry that separately from the
> availability check we also wanted for client driver probe.
>
> Nowadays, though, we have a proper notion of multiple IOMMU instances in
> the core API itself, and each one gets a chance to probe its own devices
> upon registration, so we can finally make that work as intended for
> DT/IORT/VIOT platforms too. All we need is for iommu_probe_device() to
> be able to run the iommu_fwspec machinery currently buried deep in the
> wrong end of {of,acpi}_dma_configure(). Luckily it turns out to be
> surprisingly straightforward to bootstrap this transformation by pretty
> much just calling the same path twice. At client driver probe time,
> dev->driver is obviously set; conversely at device_add(), or a
> subsequent bus_iommu_probe(), any device waiting for an IOMMU really
> should *not* have a driver already, so we can use that as a condition to
> disambiguate the two cases, and avoid recursing back into the IOMMU core
> at the wrong times.
>
> Obviously this isn't the nicest thing, but for now it gives us a
> functional baseline to then unpick the layers in between without many
> more awkward cross-subsystem patches. There are some minor side-effects
> like dma_range_map potentially being created earlier, and some debug
> prints being repeated, but these aren't significantly detrimental. Let's
> make things work first, then deal with making them nice.
>
> With the basic flow finally in the right order again, the next step is
> probably turning the bus->dma_configure paths inside-out, since all we
> really need from bus code is its notion of which device and input ID(s)
> to parse the common firmware properties with...
>
> Acked-by: Bjorn Helgaas <bhelgaas@google.com> # pci-driver.c
> Acked-by: Rob Herring (Arm) <robh@kernel.org> # of/device.c
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>

This patch landed in yesterday's linux-next as commit bcb81ac6ae3c 
("iommu: Get DT/ACPI parsing into the proper probe path"). In my tests I 
found it breaks booting of ARM64 RK3568-based Odroid-M1 board 
(arch/arm64/boot/dts/rockchip/rk3568-odroid-m1.dts). Here is the 
relevant kernel log:

Unable to handle kernel NULL pointer dereference at virtual address 
00000000000003e8
Mem abort info:
   ESR = 0x0000000096000004
   EC = 0x25: DABT (current EL), IL = 32 bits
   SET = 0, FnV = 0
   EA = 0, S1PTW = 0
   FSC = 0x04: level 0 translation fault
Data abort info:
   ISV = 0, ISS = 0x00000004, ISS2 = 0x00000000
   CM = 0, WnR = 0, TnD = 0, TagAccess = 0
   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
[00000000000003e8] user address but active_mm is swapper
Internal error: Oops: 0000000096000004 [#1] PREEMPT SMP
Modules linked in:
CPU: 3 UID: 0 PID: 1 Comm: swapper/0 Not tainted 6.14.0-rc3+ #15533
Hardware name: Hardkernel ODROID-M1 (DT)
pstate: 00400009 (nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : devm_kmalloc+0x2c/0x114
lr : rk_iommu_of_xlate+0x30/0x90
...
Call trace:
  devm_kmalloc+0x2c/0x114 (P)
  rk_iommu_of_xlate+0x30/0x90
  of_iommu_xlate+0x9c/0xc8
  of_iommu_configure+0x1c4/0x23c
  of_dma_configure_id+0x244/0x3b8
  platform_dma_configure+0x74/0xac
  __iommu_probe_device+0x258/0x49c
  probe_iommu_group+0x3c/0x64
  bus_for_each_dev+0x74/0xd4
  iommu_device_register+0xd4/0x230
  rk_iommu_probe+0x1f8/0x350
  platform_probe+0x68/0xdc
  really_probe+0xbc/0x298
  __driver_probe_device+0x78/0x12c
  driver_probe_device+0x40/0x164
  __driver_attach+0x9c/0x1ac
  bus_for_each_dev+0x74/0xd4
  driver_attach+0x24/0x30
  bus_add_driver+0xe4/0x208
  driver_register+0x60/0x128
  __platform_driver_register+0x24/0x30
  rk_iommu_driver_init+0x1c/0x28
  do_one_initcall+0x64/0x308
  kernel_init_freeable+0x288/0x4f0
  kernel_init+0x20/0x1d8
  ret_from_fork+0x10/0x20
Code: d2801017 a90153f3 ab0102e0 aa0103f4 (b943eab8)
---[ end trace 0000000000000000 ]---
Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b
SMP: stopping secondary CPUs
Kernel Offset: disabled
CPU features: 0x100,00000040,00901250,8200720b
Memory Limit: none
---[ end Kernel panic - not syncing: Attempted to kill init! 
exitcode=0x0000000b ]---

Let me know if You want me to test any experimental patch or provide 
more information.

> ---
>
> v2:
>   - Comment bus driver changes for clarity
>   - Use dev->iommu as the now-robust replay condition
>   - Drop the device_iommu_mapped() checks in the firmware paths as they
>     weren't doing much - we can't replace probe_device_lock just yet...
>   
>   drivers/acpi/arm64/dma.c        |  5 +++++
>   drivers/acpi/scan.c             |  7 -------
>   drivers/amba/bus.c              |  3 ++-
>   drivers/base/platform.c         |  3 ++-
>   drivers/bus/fsl-mc/fsl-mc-bus.c |  3 ++-
>   drivers/cdx/cdx.c               |  3 ++-
>   drivers/iommu/iommu.c           | 24 +++++++++++++++++++++---
>   drivers/iommu/of_iommu.c        |  7 ++++++-
>   drivers/of/device.c             |  7 ++++++-
>   drivers/pci/pci-driver.c        |  3 ++-
>   10 files changed, 48 insertions(+), 17 deletions(-)
>
> diff --git a/drivers/acpi/arm64/dma.c b/drivers/acpi/arm64/dma.c
> index 52b2abf88689..f30f138352b7 100644
> --- a/drivers/acpi/arm64/dma.c
> +++ b/drivers/acpi/arm64/dma.c
> @@ -26,6 +26,11 @@ void acpi_arch_dma_setup(struct device *dev)
>   	else
>   		end = (1ULL << 32) - 1;
>   
> +	if (dev->dma_range_map) {
> +		dev_dbg(dev, "dma_range_map already set\n");
> +		return;
> +	}
> +
>   	ret = acpi_dma_get_range(dev, &map);
>   	if (!ret && map) {
>   		end = dma_range_map_max(map);
> diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
> index 9f4efa8f75a6..fb1fe9f3b1a3 100644
> --- a/drivers/acpi/scan.c
> +++ b/drivers/acpi/scan.c
> @@ -1632,13 +1632,6 @@ static int acpi_iommu_configure_id(struct device *dev, const u32 *id_in)
>   		err = viot_iommu_configure(dev);
>   	mutex_unlock(&iommu_probe_device_lock);
>   
> -	/*
> -	 * If we have reason to believe the IOMMU driver missed the initial
> -	 * iommu_probe_device() call for dev, replay it to get things in order.
> -	 */
> -	if (!err && dev->bus)
> -		err = iommu_probe_device(dev);
> -
>   	return err;
>   }
>   
> diff --git a/drivers/amba/bus.c b/drivers/amba/bus.c
> index 8ef259b4d037..71482d639a6d 100644
> --- a/drivers/amba/bus.c
> +++ b/drivers/amba/bus.c
> @@ -364,7 +364,8 @@ static int amba_dma_configure(struct device *dev)
>   		ret = acpi_dma_configure(dev, attr);
>   	}
>   
> -	if (!ret && !drv->driver_managed_dma) {
> +	/* @drv may not be valid when we're called from the IOMMU layer */
> +	if (!ret && dev->driver && !drv->driver_managed_dma) {
>   		ret = iommu_device_use_default_domain(dev);
>   		if (ret)
>   			arch_teardown_dma_ops(dev);
> diff --git a/drivers/base/platform.c b/drivers/base/platform.c
> index 6f2a33722c52..1813cfd0c4bd 100644
> --- a/drivers/base/platform.c
> +++ b/drivers/base/platform.c
> @@ -1451,7 +1451,8 @@ static int platform_dma_configure(struct device *dev)
>   		attr = acpi_get_dma_attr(to_acpi_device_node(fwnode));
>   		ret = acpi_dma_configure(dev, attr);
>   	}
> -	if (ret || drv->driver_managed_dma)
> +	/* @drv may not be valid when we're called from the IOMMU layer */
> +	if (ret || !dev->driver || drv->driver_managed_dma)
>   		return ret;
>   
>   	ret = iommu_device_use_default_domain(dev);
> diff --git a/drivers/bus/fsl-mc/fsl-mc-bus.c b/drivers/bus/fsl-mc/fsl-mc-bus.c
> index d1f3d327ddd1..a8be8cf246fb 100644
> --- a/drivers/bus/fsl-mc/fsl-mc-bus.c
> +++ b/drivers/bus/fsl-mc/fsl-mc-bus.c
> @@ -153,7 +153,8 @@ static int fsl_mc_dma_configure(struct device *dev)
>   	else
>   		ret = acpi_dma_configure_id(dev, DEV_DMA_COHERENT, &input_id);
>   
> -	if (!ret && !mc_drv->driver_managed_dma) {
> +	/* @mc_drv may not be valid when we're called from the IOMMU layer */
> +	if (!ret && dev->driver && !mc_drv->driver_managed_dma) {
>   		ret = iommu_device_use_default_domain(dev);
>   		if (ret)
>   			arch_teardown_dma_ops(dev);
> diff --git a/drivers/cdx/cdx.c b/drivers/cdx/cdx.c
> index c573ed2ee71a..780fb0c4adba 100644
> --- a/drivers/cdx/cdx.c
> +++ b/drivers/cdx/cdx.c
> @@ -360,7 +360,8 @@ static int cdx_dma_configure(struct device *dev)
>   		return ret;
>   	}
>   
> -	if (!ret && !cdx_drv->driver_managed_dma) {
> +	/* @cdx_drv may not be valid when we're called from the IOMMU layer */
> +	if (!ret && dev->driver && !cdx_drv->driver_managed_dma) {
>   		ret = iommu_device_use_default_domain(dev);
>   		if (ret)
>   			arch_teardown_dma_ops(dev);
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index a3b45b84f42b..1cec7074367a 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -414,9 +414,21 @@ static int iommu_init_device(struct device *dev)
>   	if (!dev_iommu_get(dev))
>   		return -ENOMEM;
>   	/*
> -	 * For FDT-based systems and ACPI IORT/VIOT, drivers register IOMMU
> -	 * instances with non-NULL fwnodes, and client devices should have been
> -	 * identified with a fwspec by this point. Otherwise, we can currently
> +	 * For FDT-based systems and ACPI IORT/VIOT, the common firmware parsing
> +	 * is buried in the bus dma_configure path. Properly unpicking that is
> +	 * still a big job, so for now just invoke the whole thing. The device
> +	 * already having a driver bound means dma_configure has already run and
> +	 * either found no IOMMU to wait for, or we're in its replay call right
> +	 * now, so either way there's no point calling it again.
> +	 */
> +	if (!dev->driver && dev->bus->dma_configure) {
> +		mutex_unlock(&iommu_probe_device_lock);
> +		dev->bus->dma_configure(dev);
> +		mutex_lock(&iommu_probe_device_lock);
> +	}
> +	/*
> +	 * At this point, relevant devices either now have a fwspec which will
> +	 * match ops registered with a non-NULL fwnode, or we can reasonably
>   	 * assume that only one of Intel, AMD, s390, PAMU or legacy SMMUv2 can
>   	 * be present, and that any of their registered instances has suitable
>   	 * ops for probing, and thus cheekily co-opt the same mechanism.
> @@ -426,6 +438,12 @@ static int iommu_init_device(struct device *dev)
>   		ret = -ENODEV;
>   		goto err_free;
>   	}
> +	/*
> +	 * And if we do now see any replay calls, they would indicate someone
> +	 * misusing the dma_configure path outside bus code.
> +	 */
> +	if (dev->driver)
> +		dev_WARN(dev, "late IOMMU probe at driver bind, something fishy here!\n");
>   
>   	if (!try_module_get(ops->owner)) {
>   		ret = -EINVAL;
> diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
> index e10a68b5ffde..6b989a62def2 100644
> --- a/drivers/iommu/of_iommu.c
> +++ b/drivers/iommu/of_iommu.c
> @@ -155,7 +155,12 @@ int of_iommu_configure(struct device *dev, struct device_node *master_np,
>   		dev_iommu_free(dev);
>   	mutex_unlock(&iommu_probe_device_lock);
>   
> -	if (!err && dev->bus)
> +	/*
> +	 * If we're not on the iommu_probe_device() path (as indicated by the
> +	 * initial dev->iommu) then try to simulate it. This should no longer
> +	 * happen unless of_dma_configure() is being misused outside bus code.
> +	 */
> +	if (!err && dev->bus && !dev_iommu_present)
>   		err = iommu_probe_device(dev);
>   
>   	if (err && err != -EPROBE_DEFER)
> diff --git a/drivers/of/device.c b/drivers/of/device.c
> index edf3be197265..5053e5d532cc 100644
> --- a/drivers/of/device.c
> +++ b/drivers/of/device.c
> @@ -99,6 +99,11 @@ int of_dma_configure_id(struct device *dev, struct device_node *np,
>   	bool coherent, set_map = false;
>   	int ret;
>   
> +	if (dev->dma_range_map) {
> +		dev_dbg(dev, "dma_range_map already set\n");
> +		goto skip_map;
> +	}
> +
>   	if (np == dev->of_node)
>   		bus_np = __of_get_dma_parent(np);
>   	else
> @@ -119,7 +124,7 @@ int of_dma_configure_id(struct device *dev, struct device_node *np,
>   		end = dma_range_map_max(map);
>   		set_map = true;
>   	}
> -
> +skip_map:
>   	/*
>   	 * If @dev is expected to be DMA-capable then the bus code that created
>   	 * it should have initialised its dma_mask pointer by this point. For
> diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
> index f57ea36d125d..4468b7327cab 100644
> --- a/drivers/pci/pci-driver.c
> +++ b/drivers/pci/pci-driver.c
> @@ -1653,7 +1653,8 @@ static int pci_dma_configure(struct device *dev)
>   
>   	pci_put_host_bridge_device(bridge);
>   
> -	if (!ret && !driver->driver_managed_dma) {
> +	/* @driver may not be valid when we're called from the IOMMU layer */
> +	if (!ret && dev->driver && !driver->driver_managed_dma) {
>   		ret = iommu_device_use_default_domain(dev);
>   		if (ret)
>   			arch_teardown_dma_ops(dev);

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland


