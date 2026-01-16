Return-Path: <linux-pci+bounces-44999-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EB3B1D29663
	for <lists+linux-pci@lfdr.de>; Fri, 16 Jan 2026 01:21:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 56B0930090F6
	for <lists+linux-pci@lfdr.de>; Fri, 16 Jan 2026 00:21:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F700253F05;
	Fri, 16 Jan 2026 00:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="dBRDE4Dy"
X-Original-To: linux-pci@vger.kernel.org
Received: from canpmsgout06.his.huawei.com (canpmsgout06.his.huawei.com [113.46.200.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A323F2F25F8
	for <linux-pci@vger.kernel.org>; Fri, 16 Jan 2026 00:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768522901; cv=none; b=RMxnQlHkN7mdoB3hEKftfGbdCAS263xlMpVm/pmW6ZzqEYsN1G2YTkS6XU6gyKQx4w4G6msqDrun/x06no4p++dsLQbh5HZb1Uz5Wjm+M7O4vo5maFh3lL5dPgv7Kb5+7dHz0HW5GD2M8SBfV4mJbzEMQnTyHmylXwiGpUaJIcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768522901; c=relaxed/simple;
	bh=2mkWPds5GW6wj5N26vYqipQUmrXmf/uFWyEUCanH8hU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=p4I5LfoZyZqsoT5KLDVafjuAzBxWYCSm5Mmrt4iUdZzDMG7mdulp1mGE6dXSj4AkWTah7hpt7DrODZ0jzRCME0alwwF+YG4nisb7HCPD/7jpd8qr7P0jJhXAHs8jVCodo7+042Mn8H0uJlzqpH8csBaNwsqGRno06oAt2oERNuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=dBRDE4Dy; arc=none smtp.client-ip=113.46.200.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=tap7slxu5f7Ei/GwDcggXcBLbVt4H7LnRxJ6CZAi3po=;
	b=dBRDE4Dy35cHy7IO5JswQMpGvArILIrSKdoy+xA0cNNR2Jbk5XZvkYcfw52L3H/KN9jqTz1Hv
	lERsYiDmbvMoJZyubnz453UkC+5zS89MXqWFapRU5AseV3qPMYZTqtmgj1tVqgiQh7y9DX2uZ1z
	LOdAcocKU2aPIYsRKeJmC2w=
Received: from mail.maildlp.com (unknown [172.19.162.223])
	by canpmsgout06.his.huawei.com (SkyGuard) with ESMTPS id 4dsgRk1Mn2zRhQT;
	Fri, 16 Jan 2026 08:18:10 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
	by mail.maildlp.com (Postfix) with ESMTPS id 0689640569;
	Fri, 16 Jan 2026 08:21:31 +0800 (CST)
Received: from [10.67.121.161] (10.67.121.161) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 16 Jan 2026 08:21:30 +0800
Message-ID: <b5106e61-adec-4c7f-af64-9782a81a5954@huawei.com>
Date: Fri, 16 Jan 2026 08:21:30 +0800
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
References: <20260114170355.GA822475@bhelgaas>
Content-Language: en-US
From: fengchengwen <fengchengwen@huawei.com>
In-Reply-To: <20260114170355.GA822475@bhelgaas>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemk500009.china.huawei.com (7.202.194.94)

On 1/15/2026 1:03 AM, Bjorn Helgaas wrote:
> On Wed, Jan 14, 2026 at 11:39:27AM +0800, fengchengwen wrote:
>> On 1/14/2026 3:07 AM, Bjorn Helgaas wrote:
>>> On Mon, Jan 12, 2026 at 11:01:31AM +0800, fengchengwen wrote:
>>>> Hi all,
>>>>
>>>> We want to enable PCIE TPH feature on ARM64 platform, but we encounter the
>>>> following problem:
>>>>
>>>> 1. The pcie_tph_get_cpu_st() function invokes the ACPI DSM method to
>>>>    obtain the steer-tag of the CPU. According to the definition of
>>>>    the DSM method [1], the cpu_uid should be "ACPI processor uid".
>>>
>>>> 2. In the current implementation, the ACPI DSM method is invoked
>>>>    directly using the logical core number, which works on the x86
>>>>    platform but does not work on the ARM64 platform because the
>>>>    logical core ID is not the same as the ACPI processor ID when the
>>>>    PG exists.
>>>
>>> PG?
>>
>> partial good
> 
> I still don't know what "partial good" means :)  Is that something
> from a spec?

Because of some issues (like manufacturing variances), certain circuits
(e.g., some cores) might not work normally. For these cases, we can use
the part at a reduced specification, which is the PG mentioned here.

> 


