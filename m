Return-Path: <linux-pci+bounces-23620-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE2B5A5F435
	for <lists+linux-pci@lfdr.de>; Thu, 13 Mar 2025 13:23:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CFC111658D5
	for <lists+linux-pci@lfdr.de>; Thu, 13 Mar 2025 12:23:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 890C9266B67;
	Thu, 13 Mar 2025 12:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="ncVqIfMA"
X-Original-To: linux-pci@vger.kernel.org
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F63E1EF084
	for <linux-pci@vger.kernel.org>; Thu, 13 Mar 2025 12:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741868592; cv=none; b=hZhYyTRovHKHr/Jmma+PioXCTO1jUYxr2nODQgLVKn4MimSYABq8ycB7G1/PI5B2q05U3Cn7xeH3bxiGaMGBQuE3XlbZnBMukPnevV9LkVdgPRREGOWfXPWtREgVla7i3m7SpYSM5x/LrKAFGxGZB2p8vQwpTF5OSy2DUi3LHTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741868592; c=relaxed/simple;
	bh=mcPJXBSTtSrp14iFEKn4WCHM0U1Sm8bBMOiy1wa4/tY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=t6IFLy6aSvqvZMCfeKNfznyg19g01A33ok163l5jI4KH//1Vb7gc3bY2ziHGR5VtNfXNdg5OSBr7uEOqwfXKGBIBpffzbU3qAKJcdxSbO2LRk6EgoCe9FQQ6FNnkVxyCGRPBe7pIs55udtBfRHTp4NKLBciTpdSBRNPbSYeFPZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=ncVqIfMA; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20250313122307euoutp0225fad2a12249d4515e47fee717213a94~sXEBdbEh_1721217212euoutp02O
	for <linux-pci@vger.kernel.org>; Thu, 13 Mar 2025 12:23:07 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20250313122307euoutp0225fad2a12249d4515e47fee717213a94~sXEBdbEh_1721217212euoutp02O
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1741868587;
	bh=qIrd9kTdaGksR+OaXikozpxmp9lFlYZnRIjjmUZsYSY=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=ncVqIfMAINE+TA71Brea12OaCm6nBglZPAc5NalanEPQutFUq3WVO3zvC0fdamruE
	 wc45FVJbyYwI2nQx5qwAzw/3UPddym1UVpzEaJ6FCPPq34I7+Xp+shB4zVu2jj+QOX
	 YOOtgI+L+qbOktQdqzcl8z9L+JCdYJV3wmVg9/Ps=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTP id
	20250313122306eucas1p2f9144caaeaff5f66d77c8defde5a0afe~sXEBBFb0-2324023240eucas1p2L;
	Thu, 13 Mar 2025 12:23:06 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
	eusmges1new.samsung.com (EUCPMTA) with SMTP id 91.5C.20821.A2EC2D76; Thu, 13
	Mar 2025 12:23:06 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20250313122306eucas1p10f67da8328fdf9bfc4590d972e794b8f~sXEAoAej12870728707eucas1p1K;
	Thu, 13 Mar 2025 12:23:06 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
	eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20250313122306eusmtrp26de00c6b81f1b8d1f7a2f1d1f844ed06~sXEAnDFFy2795227952eusmtrp2O;
	Thu, 13 Mar 2025 12:23:06 +0000 (GMT)
X-AuditID: cbfec7f2-b09c370000005155-9a-67d2ce2ae064
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
	eusmgms2.samsung.com (EUCPMTA) with SMTP id 8D.88.19654.A2EC2D76; Thu, 13
	Mar 2025 12:23:06 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20250313122303eusmtip208566caf51a9af37bcc7d3ec7315a939~sXD92k4wN2925829258eusmtip2E;
	Thu, 13 Mar 2025 12:23:03 +0000 (GMT)
Message-ID: <bf2adf5d-1432-4bb7-846c-e1bcfa84858b@samsung.com>
Date: Thu, 13 Mar 2025 13:23:02 +0100
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
In-Reply-To: <417d6f59-0d78-4e81-ad0b-e06846f786b0@arm.com>
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01SfVCTdRzvt+fZs7G7weOA2y+DvFuvyoGSUr8LIy2y57iyLrrLg7tyxcPm
	tQ1uYxlcEfEa84ChjrbhYIecEJKwGTREQHbg1AEqxIsT5CBsCQHSJh4okttjxX+fz+f7+b7e
	l4sJqojN3EOKDFqpEMtEBA9vvbhyNXLbwKBkx3DvTlSbK0VzFXcJVN0zwEZ5J5sI1N1m4KBV
	L0LFlc0c5NU6cdQ2NU+gus4ygKy/j7DR0LkTBOqvchDIrusAKP9hPo70tih0704Fjpqq5cjk
	1WFo/byNg7rvzrCRxr72uKzFhaG6KzYc5Y/H7HmamumuYlEFg2sE1VjVCKihkesY1Wac4FBm
	q5rK75lnU9aGYoLqMjVyqLO131F/njUAyrJgY1Hl57Mpj/XZDwOTeLtTaNmhr2jl9riDPOml
	rkI83Rr+ddHPa0QOOAI1gMuF5C5YYnhTA3hcAVkPoKe0kmCIF0DHyB+AIR4AF2/cwzQgwJ+x
	XNuL+7CArAPwVFkyY1oCsL/iAvAF+GQctLpy/SacfAHq1idZjL4JXjbM+PVQcgucdOk5PhxM
	JsIFzbS/WwhpZcPRgj62j2DkbQCbh8cInwsjhdA1U+2vRJDRUDOv8esBZCxsmHWzGM8WmNdS
	ifmSIWniwdPTcwQzdzxcbC1nMzgYzjp+4TA4DK63+Yr6EooAND+YfEK0AOa4XYBxxcLxgVXC
	dzOM3Aqbzm1n5L1Q49FhzCkD4dj8JmaIQHi09ccnMh/+UChg3C9Co+PMf227rw1iWiAybjiM
	ccOaxg3rGP/vawZ4AxDSapVcQquiFfThKJVYrlIrJFFfpMmt4PELOx85/rYB0+xSlB2wuMAO
	IBcThfBPv3FNIuCniDOzaGXaZ0q1jFbZwTNcXCTk13QVSASkRJxBf0nT6bTy3yiLG7A5h5Vg
	M33rLBze95Ez1b03oLzjWHDJ0aCPD56U9WKcmuekR3oXImI+0PPYi2FTnT9hv65e+e1U8rtl
	nx7fd2L3yxkT0bdSZ5sSX7rero18GJpaqH6f58qxGA7sNwOZ0Ph6qc37dm6K8EZE9mvT9a/0
	HD4evDTEip+6sPL8OyVy/S7N1viim3EtjpWx+wn1n+clJLenZYJPbBcn7DX39+gsQRng1YTL
	XfqY9KCR0czSA5yQO7fyUCS2fxn3mJJCvx/qV4Q1r7oXDTsot/uSJSKLmLsa/sAVv3N8NDzx
	PadANxpZQP21/Faft73C9FS2gLytjf0mNPvmI7O0pbGzL6ujuCTpTKsIV0nF0dswpUr8D68a
	GnExBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrEKsWRmVeSWpSXmKPExsVy+t/xe7pa5y6lG3RfEbVY0pRh8XraBzaL
	+UfOsVo0L17PZnFw50x2i19fLCw6Z29gt/gy4TSLxc6Hb9kslu/rZ7TY9Pgaq8XlXXPYLM7O
	O85mcWjqXkaLlj8tLBYzduhZfH05jcVi/fxci7lfpjJb/N+zg93i4IcnrBZdh/4Cjd14i9li
	+akdLBYtd0wdJD2eHJzH5NF66S+bx5p5axg9Ll+7yOyxc9Zddo8Fm0o9Wo68ZfXYtKqTzWP/
	3DXsHpuX1Hu82DyT0WPjux1MHhP31Hl83iQXwBelZ1OUX1qSqpCRX1xiqxRtaGGkZ2hpoWdk
	YqlnaGwea2VkqqRvZ5OSmpNZllqkb5egl3FifxtLwSbZiva1f9kaGLsluhg5OSQETCS+LTnK
	0sXIxSEksJRRom3eajaIhIzEyWkNrBC2sMSfa11sEEXvGSV2Tv7BDpLgFbCT2HSriQXEZhFQ
	lZj6/z4TRFxQ4uTMJ2BxUQF5ifu3ZoDVCwsES7zresQIMkhEYBurxLV5O5lBHGaBp4wSX84/
	Y4VYcYhJYu2aRrB2ZgFxiVtP5oONZRMwlOh62wV2H6eAtcSqV8+ZIGrMJLq2djFC2PISzVtn
	M09gFJqF5JJZSEbNQtIyC0nLAkaWVYwiqaXFuem5xUZ6xYm5xaV56XrJ+bmbGIGJZ9uxn1t2
	MK589VHvECMTB+MhRgkOZiUR3tW2F9KFeFMSK6tSi/Lji0pzUosPMZoCg2Mis5Rocj4w9eWV
	xBuaGZgamphZGphamhkrifOyXTmfJiSQnliSmp2aWpBaBNPHxMEp1cDEsmTxo4tLa+xFF6yS
	+Ky5eu6iMwodN9/+mMvCxqJwvcPdPna7TNPz4/4HDZzz6iXPzr//y5WrQOBWmLu9jVJIR9Sq
	Vw+TtRrP9/tfLi+qjzIwiueSuSVwjD1H3m6jTX8345re46v7y0V1XUMkRS/s4pz73P7Pj6d3
	aieHvWoL+BVRttxnspjSF9HLF2c1fuZUN3mgnn7pjZPXsU2OR48bWlcuODTDpyt2SZDBwklf
	PjwxaNitH8B14uNnnUdv17wSrnWd2fr54STFOIs/OxhCHSI5fBhu9dTpC7eyG5gt0H8Rsrdp
	6fJdk5a/4AtldGlmPqg4WWlO6o/HQsU5b/98k7GXcV++6V7u/h6reVJKLMUZiYZazEXFiQCr
	NHxfxQMAAA==
X-CMS-MailID: 20250313122306eucas1p10f67da8328fdf9bfc4590d972e794b8f
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20250313095633eucas1p29cb55f2504b4bcf67c16b3bd3fa9b8cd
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20250313095633eucas1p29cb55f2504b4bcf67c16b3bd3fa9b8cd
References: <cover.1740753261.git.robin.murphy@arm.com>
	<e3b191e6fd6ca9a1e84c5e5e40044faf97abb874.1740753261.git.robin.murphy@arm.com>
	<CGME20250313095633eucas1p29cb55f2504b4bcf67c16b3bd3fa9b8cd@eucas1p2.samsung.com>
	<9b358d68-332e-404e-9a75-740297f7b28d@samsung.com>
	<417d6f59-0d78-4e81-ad0b-e06846f786b0@arm.com>

On 13.03.2025 12:01, Robin Murphy wrote:
> On 2025-03-13 9:56 am, Marek Szyprowski wrote:
> [...]
>> This patch landed in yesterday's linux-next as commit bcb81ac6ae3c
>> ("iommu: Get DT/ACPI parsing into the proper probe path"). In my tests I
>> found it breaks booting of ARM64 RK3568-based Odroid-M1 board
>> (arch/arm64/boot/dts/rockchip/rk3568-odroid-m1.dts). Here is the
>> relevant kernel log:
>
> ...and the bug-flushing-out begins!
>
>> Unable to handle kernel NULL pointer dereference at virtual address
>> 00000000000003e8
>> Mem abort info:
>>     ESR = 0x0000000096000004
>>     EC = 0x25: DABT (current EL), IL = 32 bits
>>     SET = 0, FnV = 0
>>     EA = 0, S1PTW = 0
>>     FSC = 0x04: level 0 translation fault
>> Data abort info:
>>     ISV = 0, ISS = 0x00000004, ISS2 = 0x00000000
>>     CM = 0, WnR = 0, TnD = 0, TagAccess = 0
>>     GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
>> [00000000000003e8] user address but active_mm is swapper
>> Internal error: Oops: 0000000096000004 [#1] PREEMPT SMP
>> Modules linked in:
>> CPU: 3 UID: 0 PID: 1 Comm: swapper/0 Not tainted 6.14.0-rc3+ #15533
>> Hardware name: Hardkernel ODROID-M1 (DT)
>> pstate: 00400009 (nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
>> pc : devm_kmalloc+0x2c/0x114
>> lr : rk_iommu_of_xlate+0x30/0x90
>> ...
>> Call trace:
>>    devm_kmalloc+0x2c/0x114 (P)
>>    rk_iommu_of_xlate+0x30/0x90
>
> Yeah, looks like this is doing something a bit questionable which can't
> work properly. TBH the whole dma_dev thing could probably be cleaned up
> now that we have proper instances, but for now does this work?

Yes, this patch fixes the problem I've observed.

Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>

BTW, this dma_dev idea has been borrowed from my exynos_iommu driver and 
I doubt it can be cleaned up.


>
> (annoyingly none of my Rockchip boards are set up for testing right 
> now, but I might have time to dig one out later)
>
> Thanks,
> Robin.
>
> ----->8-----
>
> Subject: [PATCH] iommu/rockchip: Allocate per-device data sensibly
>
> Now that DT-based probing is finally happening in the right order again,
> it reveals an issue in Rockchip's of_xlate, which can now be called
> during registration, but is using the global dma_dev which is only
> assigned later. However, this makes little sense when we're already
> looking up the correct IOMMU device, who should logically be the owner
> of the devm allocation anyway.
>
> Fixes: bcb81ac6ae3c ("iommu: Get DT/ACPI parsing into the proper probe 
> path")
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
>  drivers/iommu/rockchip-iommu.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/iommu/rockchip-iommu.c 
> b/drivers/iommu/rockchip-iommu.c
> index 323cc665c357..48826d1ccfd8 100644
> --- a/drivers/iommu/rockchip-iommu.c
> +++ b/drivers/iommu/rockchip-iommu.c
> @@ -1148,12 +1148,12 @@ static int rk_iommu_of_xlate(struct device *dev,
>      struct platform_device *iommu_dev;
>      struct rk_iommudata *data;
>
> -    data = devm_kzalloc(dma_dev, sizeof(*data), GFP_KERNEL);
> +    iommu_dev = of_find_device_by_node(args->np);
> +
> +    data = devm_kzalloc(&iommu_dev->dev, sizeof(*data), GFP_KERNEL);
>      if (!data)
>          return -ENOMEM;
>
> -    iommu_dev = of_find_device_by_node(args->np);
> -
>      data->iommu = platform_get_drvdata(iommu_dev);
>      data->iommu->domain = &rk_identity_domain;
>      dev_iommu_priv_set(dev, data);

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland


