Return-Path: <linux-pci+bounces-45148-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 44731D39B9D
	for <lists+linux-pci@lfdr.de>; Mon, 19 Jan 2026 01:18:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 49C3D300B6B2
	for <lists+linux-pci@lfdr.de>; Mon, 19 Jan 2026 00:17:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFB4A1DDC1B;
	Mon, 19 Jan 2026 00:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="AvtEY6TZ"
X-Original-To: linux-pci@vger.kernel.org
Received: from canpmsgout08.his.huawei.com (canpmsgout08.his.huawei.com [113.46.200.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB4517E105
	for <linux-pci@vger.kernel.org>; Mon, 19 Jan 2026 00:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768781871; cv=none; b=jRPUvO/3UXfjSYOloCJtYZfB0SA5Tbn0cRMtAQqxZdN3mUU0Al86t0c/Z8aplqOCdktWDK/or6+5JxMJgeEMvDLvdAAYRTwb90czNXYws/kiCajhb6XcPUEtdGW8eo51R3QIccPRaQu4gE5ihnwF5/CpV5EM6IXdvoN2HkpdujI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768781871; c=relaxed/simple;
	bh=Vdj5DilSJk/GkiFkS400ufZmrLLzmhGDRSY4F2QVISs=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=FKBQC5b6OkFkMmUg2LMcgfiViXUiFlneN/8BxiTQrF599hr5tYtkYpP3kIkRXXwFtPhpN8910rCz8luSvLcqHLrU3i0DrqbODTygLpPiRXvYF8GfiQZgqsr800bBMskTIXPoQlNeTAPUoJ1c3C1HcCwKP0YIw23wp9jy45uDCg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=AvtEY6TZ; arc=none smtp.client-ip=113.46.200.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=LPEjpVdluDBTwkEbzRKlodD7+GjZDmickKMQYGpf+ks=;
	b=AvtEY6TZzMD1gHtVP3Q9Xo7o7ObeRhuiJlEuibdc1pt6dNKYwnD6eQUiZnlkBTEXnXjUG0hES
	wnP6EqlTQnO4Uxmx1/W+Yf94QM3nkLmlPkjOoD/fBYYXBS28rSJahQhy7JZOHhOkN+5IrciudEc
	miHuiWeKzcg49ZG38MGMeI8=
Received: from mail.maildlp.com (unknown [172.19.163.163])
	by canpmsgout08.his.huawei.com (SkyGuard) with ESMTPS id 4dvWCr5B0nzmV7m;
	Mon, 19 Jan 2026 08:14:16 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
	by mail.maildlp.com (Postfix) with ESMTPS id B136B40565;
	Mon, 19 Jan 2026 08:17:39 +0800 (CST)
Received: from [10.67.121.161] (10.67.121.161) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 19 Jan 2026 08:17:39 +0800
Message-ID: <60b34308-36cf-45f4-b493-42d97562e3b9@huawei.com>
Date: Mon, 19 Jan 2026 08:17:38 +0800
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
References: <20260116193203.GA959102@bhelgaas>
Content-Language: en-US
From: fengchengwen <fengchengwen@huawei.com>
In-Reply-To: <20260116193203.GA959102@bhelgaas>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemk500009.china.huawei.com (7.202.194.94)

On 1/17/2026 3:32 AM, Bjorn Helgaas wrote:
> On Fri, Jan 16, 2026 at 08:21:30AM +0800, fengchengwen wrote:
>> On 1/15/2026 1:03 AM, Bjorn Helgaas wrote:
>>> On Wed, Jan 14, 2026 at 11:39:27AM +0800, fengchengwen wrote:
>>>> On 1/14/2026 3:07 AM, Bjorn Helgaas wrote:
>>>>> On Mon, Jan 12, 2026 at 11:01:31AM +0800, fengchengwen wrote:
>>>>>> Hi all,
>>>>>>
>>>>>> We want to enable PCIE TPH feature on ARM64 platform, but we encounter the
>>>>>> following problem:
>>>>>>
>>>>>> 1. The pcie_tph_get_cpu_st() function invokes the ACPI DSM method to
>>>>>>    obtain the steer-tag of the CPU. According to the definition of
>>>>>>    the DSM method [1], the cpu_uid should be "ACPI processor uid".
>>>>>
>>>>>> 2. In the current implementation, the ACPI DSM method is invoked
>>>>>>    directly using the logical core number, which works on the x86
>>>>>>    platform but does not work on the ARM64 platform because the
>>>>>>    logical core ID is not the same as the ACPI processor ID when the
>>>>>>    PG exists.
>>>>>
>>>>> PG?
>>>>
>>>> partial good
>>>
>>> I still don't know what "partial good" means :)  Is that something
>>> from a spec?
>>
>> Because of some issues (like manufacturing variances), certain circuits
>> (e.g., some cores) might not work normally. For these cases, we can use
>> the part at a reduced specification, which is the PG mentioned here.
> 
> Ah, got it :)  If you go this direction, maybe you can expand that
> part of the commit log a bit, since I don't think "PG" or "partial
> good" is a widely-known term.

Alright, thank you for the reminder.

> 


