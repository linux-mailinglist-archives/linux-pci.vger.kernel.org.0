Return-Path: <linux-pci+bounces-44348-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 20B98D0844A
	for <lists+linux-pci@lfdr.de>; Fri, 09 Jan 2026 10:40:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 07F053008C9D
	for <lists+linux-pci@lfdr.de>; Fri,  9 Jan 2026 09:40:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14E2731AF3D;
	Fri,  9 Jan 2026 09:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="ck4Vcf/w"
X-Original-To: linux-pci@vger.kernel.org
Received: from canpmsgout09.his.huawei.com (canpmsgout09.his.huawei.com [113.46.200.224])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9709D2ED15F;
	Fri,  9 Jan 2026 09:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.224
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767951613; cv=none; b=o/REVyoLD6E8qW7S4eygQ1OJDGlMYhixsaRGErlNfWnrioA7aMxrhJ1aONM6rt/YwXbrFWY/dOCqBPiAbgGGae4VfppdudY/YSYbB9XbjNgGPx7ePK5obnlbMcToPnKPKmBdPKEy4+HF3w/3GQVvyM83xluZH9LNdMg+IZvk8YE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767951613; c=relaxed/simple;
	bh=T2zOYN70bbCbQXXbh/evuuNBHsFRh5jSZVQh4gWJWkE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=JwYMhtVcvHjSawSA6w5GI/31yF7mbho7zWMO2BEsXnWOvyz3pQcySSxsspajhjV2xY+y+UW90dkicSM2BCQb2CdcMhS9CmgSPW3d3xREyV8j+mI3xFr2YrKXKJFuNBWanzlbwpecQzfZCJgU8BjMPLBkalWr5xfOPn9UR4+CT08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=ck4Vcf/w; arc=none smtp.client-ip=113.46.200.224
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=8JsXyhMNbwnp+YKrNedE1boMnhXYzusZORR+vsFIB+s=;
	b=ck4Vcf/wBGjodRgEDMjv2eTZbM4M+czB/KI30+lZcOl+JgyUgVv7ySutKavAf8d/viirJeX1M
	w8BMcV2QUXL6Z30OPXTwKDB9brewyT+tRtPz9pUmcXDVF1yZmnzHMO7fwhXK57RZWIZHQPOAtsG
	2BQki4zw8ShNmo4C0MFM3CM=
Received: from mail.maildlp.com (unknown [172.19.163.127])
	by canpmsgout09.his.huawei.com (SkyGuard) with ESMTPS id 4dnc9b6L6mz1cyQq;
	Fri,  9 Jan 2026 17:36:51 +0800 (CST)
Received: from kwepemr500012.china.huawei.com (unknown [7.202.195.23])
	by mail.maildlp.com (Postfix) with ESMTPS id F2BB7402AB;
	Fri,  9 Jan 2026 17:40:07 +0800 (CST)
Received: from [100.103.109.72] (100.103.109.72) by
 kwepemr500012.china.huawei.com (7.202.195.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 9 Jan 2026 17:40:07 +0800
Message-ID: <422df374-2afd-48c0-be73-834ce95fb55c@huawei.com>
Date: Fri, 9 Jan 2026 17:40:06 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] PCI/sysfs: Prohibit unaligned access to I/O port
 on non-x86
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
CC: David Laight <david.laight.linux@gmail.com>, <bhelgaas@google.com>,
	<linux-pci@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	<liuyongqiang13@huawei.com>
References: <20260108015944.3520719-1-duziming2@huawei.com>
 <20260108015944.3520719-4-duziming2@huawei.com>
 <20260108085611.0f07816d@pumpkin>
 <98ecea9b-ca2f-4ef7-9f1a-848faa9c92a3@huawei.com>
 <0d57b385-410f-3296-ca8b-8b1370a886b1@linux.intel.com>
From: duziming <duziming2@huawei.com>
In-Reply-To: <0d57b385-410f-3296-ca8b-8b1370a886b1@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemr500012.china.huawei.com (7.202.195.23)


在 2026/1/9 15:21, Ilpo Järvinen 写道:
> On Thu, 8 Jan 2026, duziming wrote:
>
>> 在 2026/1/8 16:56, David Laight 写道:
>>> On Thu, 8 Jan 2026 09:59:44 +0800
>>> Ziming Du <duziming2@huawei.com> wrote:
>>>
>>>> From: Yongqiang Liu <liuyongqiang13@huawei.com>
>>>>
>>>> Unaligned access is harmful for non-x86 archs such as arm64. When we
>>>> use pwrite or pread to access the I/O port resources with unaligned
>>>> offset, system will crash as follows:
>>>>
>>>> Unable to handle kernel paging request at virtual address fffffbfffe8010c1
>>>> Internal error: Oops: 0000000096000061 [#1] SMP
>>>> Call trace:
>>>>    _outw include/asm-generic/io.h:594 [inline]
>>>>    logic_outw+0x54/0x218 lib/logic_pio.c:305
>>>>    pci_resource_io drivers/pci/pci-sysfs.c:1157 [inline]
>>>>    pci_write_resource_io drivers/pci/pci-sysfs.c:1191 [inline]
>>>>    pci_write_resource_io+0x208/0x260 drivers/pci/pci-sysfs.c:1181
>>>>    sysfs_kf_bin_write+0x188/0x210 fs/sysfs/file.c:158
>>>>    kernfs_fop_write_iter+0x2e8/0x4b0 fs/kernfs/file.c:338
>>>>    vfs_write+0x7bc/0xac8 fs/read_write.c:586
>>>>    ksys_write+0x12c/0x270 fs/read_write.c:639
>>>>    __arm64_sys_write+0x78/0xb8 fs/read_write.c:648
>>>>
>>>> Powerpc seems affected as well, so prohibit the unaligned access
>>>> on non-x86 archs.
>>> I'm not sure it makes any real sense for x86 either.
>>> IIRC io space is just like memory space, so a 16bit io access looks the
>>> same as two 8bit accesses to an 8bit device (some put the 'data fifo' on
>>> addresses 0 and 1 so the code could use 16bit io accesses to speed things
>>> up).
>>> The same will have applied to misaligned accesses.
>>> But, in reality, all device registers are aligned.
>>>
>>> I'm not sure EFAULT is the best error code though, EINVAL might be better.
>>> (EINVAL is returned for other address/size errors.)
>>> EFAULT is usually returned for errors accessing the user buffer, a least
>>> one unix system raises SIGSEGV whenever EFAULT is returned.
>>>
>> Just to confirm: should all architectures prohibit unaligned access to device
>> registers?
> In my opinion, yes, also x86 should prohibit it (like I already
> expressed but you ignored that comment until now).
Oops,  I didn’t quite understand your opinion earlier :(
>

