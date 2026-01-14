Return-Path: <linux-pci+bounces-44699-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F136ED1C4CC
	for <lists+linux-pci@lfdr.de>; Wed, 14 Jan 2026 04:53:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E18623003496
	for <lists+linux-pci@lfdr.de>; Wed, 14 Jan 2026 03:52:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A422327FB21;
	Wed, 14 Jan 2026 03:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="J8qxSNM4"
X-Original-To: linux-pci@vger.kernel.org
Received: from canpmsgout09.his.huawei.com (canpmsgout09.his.huawei.com [113.46.200.224])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC38729BDBA
	for <linux-pci@vger.kernel.org>; Wed, 14 Jan 2026 03:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.224
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768362777; cv=none; b=kfmXikTk0McBDLBF5JoxRYnR+0w/H/nO/1lL6GM1avNsxqq1/Ts4dfiV0FoOIB/pkz/QCNcYOoez+0xS5kTTwzi+t6aKCLa6QdIVrrXLima/5oN8z3W7YQjKTxObT2vCLUJnkNVvsPhrxamhmbsS28Tu3eSiE1xLqADt9kKOSPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768362777; c=relaxed/simple;
	bh=Kw+NXyMV4si1fj1WCZmXUyva4/k6CgxKnqqeAXnLQog=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=kpZ1VvNduG+ZhCKIOe/4M0/kkjy1RdgvLvZgJ8Myfgtff21v1oP9NDo8gaEQhWzzFDZN87FWVU0Bz1zui7ZAbk5zdSL9NdTG+a1JRJuQGL6D30spyQmxO9V7SZVF/KM/MpBvf8T0MsFC1blUuVYBV/KX9TAbL/CiNm1+aLnuGnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=J8qxSNM4; arc=none smtp.client-ip=113.46.200.224
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=4gGt+Gm4s+asKlmlwjSgJ8PRcyQ7m5TX9ZiNaxnYt1U=;
	b=J8qxSNM4G8N/heUUIA86mtDn/d4IaOnmybF6j1z0PQQVuyp5b08W3fz7pUL8OLdAB2sqmPKnE
	8lwzxdDKeoQqYGEo592ipfKIPr1/wUfIt+ZhVD93r+KBfIClLQrn3vmABV+n59INP/zSAWv4Ljv
	rH71FySpGSqb7LgHknPQ47U=
Received: from mail.maildlp.com (unknown [172.19.162.92])
	by canpmsgout09.his.huawei.com (SkyGuard) with ESMTPS id 4drXDX2hQ7z1cyQp;
	Wed, 14 Jan 2026 11:49:32 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
	by mail.maildlp.com (Postfix) with ESMTPS id 4DD1340562;
	Wed, 14 Jan 2026 11:52:51 +0800 (CST)
Received: from [10.67.121.161] (10.67.121.161) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 14 Jan 2026 11:52:50 +0800
Message-ID: <85b11747-de25-432d-86ab-2c156f6b6976@huawei.com>
Date: Wed, 14 Jan 2026 11:52:50 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: RFC about how to obtain PCIE TPH steer-tag on ARM64 platform
To: Wei Huang <wei.huang2@amd.com>, Bjorn Helgaas <helgaas@kernel.org>
CC: <linux-pci@vger.kernel.org>, <Eric.VanTassell@amd.com>,
	<bhelgaas@google.com>, <jonathan.cameron@huawei.com>,
	<wangzhou1@hisilicon.com>, <wanghuiqiang@huawei.com>,
	<liuyonglong@huawei.com>
References: <0cba9df3-8fe5-47ef-929c-6da64d31bf69@huawei.com>
 <20260113190713.GA775730@bhelgaas> <aWbJX75VdCEOBCgx@weiserver>
Content-Language: en-US
From: fengchengwen <fengchengwen@huawei.com>
In-Reply-To: <aWbJX75VdCEOBCgx@weiserver>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemk500009.china.huawei.com (7.202.194.94)

On 1/14/2026 6:38 AM, Wei Huang wrote:
> On Tue, Jan 13, 2026 at 01:07:13PM -0600, Bjorn Helgaas wrote:
>> On Mon, Jan 12, 2026 at 11:01:31AM +0800, fengchengwen wrote:
>>> Hi all,
>>>
>>> We want to enable PCIE TPH feature on ARM64 platform, but we encounter the
>>> following problem:
>>>
>>> 1. The pcie_tph_get_cpu_st() function invokes the ACPI DSM method to
>>>    obtain the steer-tag of the CPU. According to the definition of
>>>    the DSM method [1], the cpu_uid should be "ACPI processor uid".
>>
>>> 2. In the current implementation, the ACPI DSM method is invoked
>>>    directly using the logical core number, which works on the x86
>>>    platform but does not work on the ARM64 platform because the
>>>    logical core ID is not the same as the ACPI processor ID when the
>>>    PG exists.
>>
>> PG?
>>
>>> Because the ARM64 platform generates steer-tag based on the MPIDR
>>> information (at least for the Kunpeng platform). Therefore, we have
>>> two option:
>>>
>>> Option-1: convert logic core ID to ACPI process ID: use
>>>           get_acpi_id_for_cpu() to get ACPI process ID in
>>>           pcie_tph_get_cpu_st() before invoke dsm [2], and BIOS/ACPI
>>>           use process ID to get corresponding MPIDR, and then
>>>           generate steer-tag from MPIDR.
> 
> In my opinion, if this is achievable in your BIOS/ACPI, it is clean vs. Option-2 and preferred.

Yes, it's achievable for out BIOS/ACPI, and we will adopt this option.

> 
>>>
>>> Option-2: convert logic core ID to MPIDR: use cpu_logical_map() to
>>>           get MPIDR in pcie_tph_get_cpu_st() before invoke dsm, and
>>>           BIOS/ACPI use it to generate steer-tag directly.
> 
> This solution requires you to change the ECN and ratify it (as suggested by Bjorn below). The implementation can also be complicated.

Indeed, and it may take a long time.

@Wei, I have another question:
The cache is hierarchical, for example, L2 or L3. Does the DSM mode support the specified cache level?
I checked the ECN doc and there are "Cache Reference" fields, but the kernel code don't enable them.

> 
>>>
>>> Option-1 complies with _DSM ECN, but requires BIOS/ACPI to maintain
>>> a mapping table from acpi_process_id to MPIDR.
>>>
>>> Option 2 does not comply with _DSM ECN (if extension is required).
>>> But it is easy to implement and can be extended to the DT system
>>> (ACPI is not supported) I think.
> 
> If you plan to revamp it, one (wild) idea is that ST retrieval can be extended to support:
>   1. ACPI _DSM
>   2. DT
>   3. Vendor specific
> 
> After that, your MPIDR solution can be plugged-in under (3).
> 
>>
>> Sounds like this would be of interest to any OS, not just Linux.
>>
>> Possibly a topic for the PCI-SIG firmware working group
>> (https://members.pcisig.com/wg/Firmware/dashboard) or the ACPI spec
>> working group (https://uefi.org/workinggroups)?
>>
>>> [1] According to _DSM ECN, the input is defined as: "If the target
>>>     is a processor, then this field represents the ACPI Processor
>>>     UID of the processor as specified in the MADT. If the target is
>>>     a processor container, then this field represents the ACPI
>>>     Processor UID of the processor container as specified in the
>>>     PPTT"
>>>
>>> [2] git diff about /drivers/pci/tph.c
>>> @@ -289,6 +289,9 @@ int pcie_tph_get_cpu_st(struct pci_dev *pdev, enum tph_mem_type mem_type,
>>>
>>>         rp_acpi_handle = ACPI_HANDLE(rp->bus->bridge);
>>>
>>> +#ifdef CONFIG_ARM64
>>> +       cpu_uid = get_acpi_id_for_cpu(cpu_uid);
>>> +#endif
>>>         if (tph_invoke_dsm(rp_acpi_handle, cpu_uid, &info) != AE_OK) {
>>>                 *tag = 0;
>>>                 return -EINVAL;
>>>
>>>
> 


