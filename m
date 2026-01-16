Return-Path: <linux-pci+bounces-44998-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B88B2D29637
	for <lists+linux-pci@lfdr.de>; Fri, 16 Jan 2026 01:14:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 742B5302C12D
	for <lists+linux-pci@lfdr.de>; Fri, 16 Jan 2026 00:14:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B39A23ABB0;
	Fri, 16 Jan 2026 00:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="fy7eP2SU"
X-Original-To: linux-pci@vger.kernel.org
Received: from canpmsgout10.his.huawei.com (canpmsgout10.his.huawei.com [113.46.200.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2112279CD
	for <linux-pci@vger.kernel.org>; Fri, 16 Jan 2026 00:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768522450; cv=none; b=TRFcuKEOqcQq93DhlXqODffKC7MZcL2098LfZJtCGz4pnO2m05tS5n4n6vAASBbFR3HnLSGk6yTPq/nWE68Ik1DiobBcMV80Ao0GP2SiTjYwqmixrGlt7azk3SP05/zBI05nZSZcWlI13UiXqsHaigU50abv0sd/NJUShNsI4jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768522450; c=relaxed/simple;
	bh=X3SVaf3CGmuQBZz5Ri1LtqPdRdX2rFRAXFscS3cdzQE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=PHlIPoYZ4Sp13eYhOBrl6UynwAIMlgiFXe2Mj4BtGsXrmw5p3SXNLlajRXRX/uywI6mxF2odVaMsyNi/WOmHQvpryWIwC6TTb2TOWOYfFaPfPFxCN7v96Nu4RdrTRSG4hQy4iCpz0dBMV0PoeuRU4NmW11bYaeEZ94bWlHFcTYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=fy7eP2SU; arc=none smtp.client-ip=113.46.200.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=RMqo5s2RxL4kuhTDTgBX9B7K2YG8/V9YboFGxwYqUp0=;
	b=fy7eP2SUStuS9UUNdsbxx2skXbHwuMWR2Epm4xi/EhydVsvI/7qF3e3hmyboMCHsUJc9wOEHl
	5CX7u+V/7ZQ282eRXg1F3y6K2i6aq+cghcFYnXbJVdBpHXsaMmBWTkJTSdxEIzWIbtD1WMi3iB8
	n4v7krS2ePgKVxI4Uvg/f8E=
Received: from mail.maildlp.com (unknown [172.19.163.15])
	by canpmsgout10.his.huawei.com (SkyGuard) with ESMTPS id 4dsgH86MnJz1K96l;
	Fri, 16 Jan 2026 08:10:44 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
	by mail.maildlp.com (Postfix) with ESMTPS id 6186F40539;
	Fri, 16 Jan 2026 08:14:03 +0800 (CST)
Received: from [10.67.121.161] (10.67.121.161) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 16 Jan 2026 08:14:02 +0800
Message-ID: <843cc325-c41b-4e19-99fd-bb65e984fa1f@huawei.com>
Date: Fri, 16 Jan 2026 08:14:02 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: RFC about how to obtain PCIE TPH steer-tag on ARM64 platform
To: Wei Huang <wei.huang2@amd.com>
CC: Bjorn Helgaas <helgaas@kernel.org>, <linux-pci@vger.kernel.org>,
	<Eric.VanTassell@amd.com>, <bhelgaas@google.com>,
	<jonathan.cameron@huawei.com>, <wangzhou1@hisilicon.com>,
	<wanghuiqiang@huawei.com>, <liuyonglong@huawei.com>
References: <0cba9df3-8fe5-47ef-929c-6da64d31bf69@huawei.com>
 <20260113190713.GA775730@bhelgaas> <aWbJX75VdCEOBCgx@weiserver>
 <85b11747-de25-432d-86ab-2c156f6b6976@huawei.com>
 <aWfF-ZNp55n5DHR5@weiserver>
Content-Language: en-US
From: fengchengwen <fengchengwen@huawei.com>
In-Reply-To: <aWfF-ZNp55n5DHR5@weiserver>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemk500009.china.huawei.com (7.202.194.94)

On 1/15/2026 12:36 AM, Wei Huang wrote:
> On Wed, Jan 14, 2026 at 11:52:50AM +0800, fengchengwen wrote:
>> On 1/14/2026 6:38 AM, Wei Huang wrote:
>>> On Tue, Jan 13, 2026 at 01:07:13PM -0600, Bjorn Helgaas wrote:
>>>> On Mon, Jan 12, 2026 at 11:01:31AM +0800, fengchengwen wrote:
>>>>> Hi all,
>>>>>
>>>>> We want to enable PCIE TPH feature on ARM64 platform, but we encounter the
>>>>> following problem:
>>>>>
>>>>> 1. The pcie_tph_get_cpu_st() function invokes the ACPI DSM method to
>>>>>    obtain the steer-tag of the CPU. According to the definition of
>>>>>    the DSM method [1], the cpu_uid should be "ACPI processor uid".
>>>>
>>>>> 2. In the current implementation, the ACPI DSM method is invoked
>>>>>    directly using the logical core number, which works on the x86
>>>>>    platform but does not work on the ARM64 platform because the
>>>>>    logical core ID is not the same as the ACPI processor ID when the
>>>>>    PG exists.
>>>>
>>>> PG?
>>>>
>>>>> Because the ARM64 platform generates steer-tag based on the MPIDR
>>>>> information (at least for the Kunpeng platform). Therefore, we have
>>>>> two option:
>>>>>
>>>>> Option-1: convert logic core ID to ACPI process ID: use
>>>>>           get_acpi_id_for_cpu() to get ACPI process ID in
>>>>>           pcie_tph_get_cpu_st() before invoke dsm [2], and BIOS/ACPI
>>>>>           use process ID to get corresponding MPIDR, and then
>>>>>           generate steer-tag from MPIDR.
>>>
>>> In my opinion, if this is achievable in your BIOS/ACPI, it is clean vs. Option-2 and preferred.
>>
>> Yes, it's achievable for out BIOS/ACPI, and we will adopt this option.
>>
>>>
>>>>>
>>>>> Option-2: convert logic core ID to MPIDR: use cpu_logical_map() to
>>>>>           get MPIDR in pcie_tph_get_cpu_st() before invoke dsm, and
>>>>>           BIOS/ACPI use it to generate steer-tag directly.
>>>
>>> This solution requires you to change the ECN and ratify it (as suggested by Bjorn below). The implementation can also be complicated.
>>
>> Indeed, and it may take a long time.
>>
>> @Wei, I have another question:
>> The cache is hierarchical, for example, L2 or L3. Does the DSM mode support the specified cache level?
>> I checked the ECN doc and there are "Cache Reference" fields, but the kernel code don't enable them.
> 
> ECN does provide the "Cache Reference" field as part of argument2. Our platforms don't use it and don't plan to use it soon. You can explore the use cases if your platforms need it.
> 
> I want to point out that PCIe TLP header doesn't have a field for cache level. So no matter what, TLP header will stuck with 8- or 16-bit STs.

Okay, I will try to understand how to use "Cache Reference" as cache level parameter.
I think this would give the user a more refined ability.

> 
>>
> 
> 


