Return-Path: <linux-pci+bounces-44697-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1688DD1C46B
	for <lists+linux-pci@lfdr.de>; Wed, 14 Jan 2026 04:39:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F25FC300FE03
	for <lists+linux-pci@lfdr.de>; Wed, 14 Jan 2026 03:39:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEEE32D3738;
	Wed, 14 Jan 2026 03:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="Q8+I6x0a"
X-Original-To: linux-pci@vger.kernel.org
Received: from canpmsgout09.his.huawei.com (canpmsgout09.his.huawei.com [113.46.200.224])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7FE3284896
	for <linux-pci@vger.kernel.org>; Wed, 14 Jan 2026 03:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.224
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768361978; cv=none; b=X1zg626qOn2DCIvhl6Ueqp19JFuV1a/vgETL3WG5lmg9Oh78QklAfj0x+KpKReU8/G7dbubNfSwxx1qthkCcm5Kj69oTeb5WcnTZ25ydPLas2GoCa1sWrImE7MA17TNnfq00SxqvUEmQG3LAUceTZZOy6RPZsuaZvWzJt0uV7V0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768361978; c=relaxed/simple;
	bh=Du3EHE2OCxP0yls6gfi62yUryR3v8TIsL+dkH72fvmw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=dr69K5W7g5562tq9PLEx3C1KcWY4dbQFx6cWIR6ctcG1xDKLWXkZImB03J/9amwDeKSph4wOBLwFGUaAzeAzL2wlDPxJu5C9aaogyQuwx48yrgjCz6zeleL2n3vXPPvgByzaKdi/T1LOV5rf02vID9L8TpoyWu3OpQu33XEvLZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=Q8+I6x0a; arc=none smtp.client-ip=113.46.200.224
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=FghKfKCTo754A+YE5myLb+I06sgPMt3foTJV8jnQSpI=;
	b=Q8+I6x0aotS0hbuJUyfHRi3wE+TJGWls41UjIWZPw1GlwOGO+4g8UL3BJdhw2S/gR6Orak94e
	zYXq0eagQQAQsEDb6a0wMvneW0PPEUrJ7G/KTzOAWnrmwhwp84jTM5UoJtTWKv13yN+huwFWQN1
	OtbcxZ2kK8SJ9vq26AM1+wc=
Received: from mail.maildlp.com (unknown [172.19.163.200])
	by canpmsgout09.his.huawei.com (SkyGuard) with ESMTPS id 4drWx51hwbz1cyQp;
	Wed, 14 Jan 2026 11:36:09 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
	by mail.maildlp.com (Postfix) with ESMTPS id 2B5AB4055B;
	Wed, 14 Jan 2026 11:39:28 +0800 (CST)
Received: from [10.67.121.161] (10.67.121.161) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 14 Jan 2026 11:39:27 +0800
Message-ID: <a841956f-1cf0-40aa-ad18-4fafe260bad2@huawei.com>
Date: Wed, 14 Jan 2026 11:39:27 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: RFC about how to obtain PCIE TPH steer-tag on ARM64 platform
To: Bjorn Helgaas <helgaas@kernel.org>
CC: <linux-pci@vger.kernel.org>, Wei <wei.huang2@amd.com>,
	<Eric.VanTassell@amd.com>, <bhelgaas@google.com>,
	<jonathan.cameron@huawei.com>, <wangzhou1@hisilicon.com>,
	<wanghuiqiang@huawei.com>, <liuyonglong@huawei.com>
References: <20260113190713.GA775730@bhelgaas>
Content-Language: en-US
From: fengchengwen <fengchengwen@huawei.com>
In-Reply-To: <20260113190713.GA775730@bhelgaas>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemk500009.china.huawei.com (7.202.194.94)

On 1/14/2026 3:07 AM, Bjorn Helgaas wrote:
> On Mon, Jan 12, 2026 at 11:01:31AM +0800, fengchengwen wrote:
>> Hi all,
>>
>> We want to enable PCIE TPH feature on ARM64 platform, but we encounter the
>> following problem:
>>
>> 1. The pcie_tph_get_cpu_st() function invokes the ACPI DSM method to
>>    obtain the steer-tag of the CPU. According to the definition of
>>    the DSM method [1], the cpu_uid should be "ACPI processor uid".
> 
>> 2. In the current implementation, the ACPI DSM method is invoked
>>    directly using the logical core number, which works on the x86
>>    platform but does not work on the ARM64 platform because the
>>    logical core ID is not the same as the ACPI processor ID when the
>>    PG exists.
> 
> PG?

partial good

> 
>> Because the ARM64 platform generates steer-tag based on the MPIDR
>> information (at least for the Kunpeng platform). Therefore, we have
>> two option:
>>
>> Option-1: convert logic core ID to ACPI process ID: use
>>           get_acpi_id_for_cpu() to get ACPI process ID in
>>           pcie_tph_get_cpu_st() before invoke dsm [2], and BIOS/ACPI
>>           use process ID to get corresponding MPIDR, and then
>>           generate steer-tag from MPIDR.
>>
>> Option-2: convert logic core ID to MPIDR: use cpu_logical_map() to
>>           get MPIDR in pcie_tph_get_cpu_st() before invoke dsm, and
>>           BIOS/ACPI use it to generate steer-tag directly.
>>
>> Option-1 complies with _DSM ECN, but requires BIOS/ACPI to maintain
>> a mapping table from acpi_process_id to MPIDR.
>>
>> Option 2 does not comply with _DSM ECN (if extension is required).
>> But it is easy to implement and can be extended to the DT system
>> (ACPI is not supported) I think.
> 
> Sounds like this would be of interest to any OS, not just Linux.
> 
> Possibly a topic for the PCI-SIG firmware working group
> (https://members.pcisig.com/wg/Firmware/dashboard) or the ACPI spec
> working group (https://uefi.org/workinggroups)?

Thanks
We finally decided to choose option-1.

> 
>> [1] According to _DSM ECN, the input is defined as: "If the target
>>     is a processor, then this field represents the ACPI Processor
>>     UID of the processor as specified in the MADT. If the target is
>>     a processor container, then this field represents the ACPI
>>     Processor UID of the processor container as specified in the
>>     PPTT"
>>
>> [2] git diff about /drivers/pci/tph.c
>> @@ -289,6 +289,9 @@ int pcie_tph_get_cpu_st(struct pci_dev *pdev, enum tph_mem_type mem_type,
>>
>>         rp_acpi_handle = ACPI_HANDLE(rp->bus->bridge);
>>
>> +#ifdef CONFIG_ARM64
>> +       cpu_uid = get_acpi_id_for_cpu(cpu_uid);
>> +#endif
>>         if (tph_invoke_dsm(rp_acpi_handle, cpu_uid, &info) != AE_OK) {
>>                 *tag = 0;
>>                 return -EINVAL;
>>
>>
> 


