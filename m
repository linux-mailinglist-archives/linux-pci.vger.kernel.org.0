Return-Path: <linux-pci+bounces-23199-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AC61A5807C
	for <lists+linux-pci@lfdr.de>; Sun,  9 Mar 2025 04:34:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A10A516CDE6
	for <lists+linux-pci@lfdr.de>; Sun,  9 Mar 2025 03:34:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41D1E18E25;
	Sun,  9 Mar 2025 03:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="OcGRrHIw"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEFDC2F37;
	Sun,  9 Mar 2025 03:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741491284; cv=none; b=Z4Udv8tVtRS+4480ETGxM5o8YRbaCnXHZyF3US4tAZaci3rgDO81z1Q9FBuCLVYQR4RsN/oxgo1mDkwaYJhtMLZpl0R/glV80e17hXP9x88U7PHv1idywGAe9i3IQqoXNTlINAxfnla/jPg9KKFsxfRFAtcxPYV85R0BdwwaZNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741491284; c=relaxed/simple;
	bh=ZEljvK6TXXkF9KIDjBL54vkzcwco5AbxJYqi+1Fp/SM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nsBja2s2mYUDtG8ZwmyqBW9uS6sAoji6HXuaNT2Lgtb+YbtO9SoMO+IpV+Lg0UVI7Tfi0hfM7HgUFWg8lDsFBAMb9fv1EZiAvdLdhENOOgEr1uUK605CcBOsi8urC71iClDE1lJNEDy6sVyJlvZW93MSmqELnh89GsvmMmwLLxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=OcGRrHIw; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:From:
	Content-Type; bh=i8QHOBFSPFU1eJvG1lLQptd27nYiLV+ujTCG8nZRuW0=;
	b=OcGRrHIwxzEF4gniP4y+nPj063t1Frs1OEEVBg4xmTjc5O7/hraogVLXpmCd2+
	JoOOdmH8f6fZCSWqoIdUqP17HiJJyccYjyaFK83XxESlxfedZz/pEi5i8rlzYV22
	f5lEJ8Fy7/0+1isr9xKxNUnlqzb9pnerjeYmb8N//Wdeg=
Received: from [192.168.71.45] (unknown [])
	by gzga-smtp-mtada-g1-4 (Coremail) with SMTP id _____wCHD1N9CM1nRqkUQg--.47998S2;
	Sun, 09 Mar 2025 11:18:22 +0800 (CST)
Message-ID: <3e6645a8-6de9-4125-8444-fa1a4f526881@163.com>
Date: Sun, 9 Mar 2025 11:18:21 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [v2] PCI: cadence: Add configuration space capability search API
To: Siddharth Vadapalli <s-vadapalli@ti.com>
Cc: lpieralisi@kernel.org, kw@linux.com, manivannan.sadhasivam@linaro.org,
 robh@kernel.org, bhelgaas@google.com, bwawrzyn@cisco.com,
 thomas.richard@bootlin.com, wojciech.jasko-EXT@continental-corporation.com,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250308133903.322216-1-18255117159@163.com>
 <20250309023839.2cakdpmsbzn6pm7g@uda0492258>
Content-Language: en-US
From: Hans Zhang <18255117159@163.com>
In-Reply-To: <20250309023839.2cakdpmsbzn6pm7g@uda0492258>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_____wCHD1N9CM1nRqkUQg--.47998S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7ZF1xJFWxZFykGrWrXF1DJrb_yoW8Cw1DpF
	4DXF9YkF1DGr47Crs7Ww4jvFyjg395Ja4UK3s8Cw1rZrs09F1YkFsa9w4UZF97WrZ293WF
	v3yYgrsrtw12vFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UhZ2-UUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbBDwsLo2fNB2cgcQAAs3



On 2025/3/9 10:38, Siddharth Vadapalli wrote:
> On Sat, Mar 08, 2025 at 09:39:03PM +0800, Hans Zhang wrote:
>> Add configuration space capability search API using struct cdns_pcie*
>> pointer.
>>
>> The offset address of capability or extended capability designed by
>> different SOC design companies may not be the same. Therefore, a flexible
>> public API is required to find the offset address of a capability or
>> extended capability in the configuration space.
>>
>> Signed-off-by: Hans Zhang <18255117159@163.com>
>> ---
>> Changes since v1:
>> https://lore.kernel.org/linux-pci/20250123070935.1810110-1-18255117159@163.com
>>
>> - Added calling the new API in PCI-Cadence ep.c.
>> - Add a commit message reason for adding the API.
> 
> In reply to your v1 patch, you have mentioned the following:
> "Our controller driver currently has no plans for upstream and needs to
> wait for notification from the boss."
> at:
> https://lore.kernel.org/linux-pci/fcfd4827-4d9e-4bcd-b1d0-8f9e349a6be7@163.com/
> 
> Since you have posted this patch, does it mean that you will be
> upstreaming your driver as well? If not, we still end up in the same
> situation as earlier where the Upstream Linux has APIs to support a
> Downstream driver.
> 
> Bjorn indicated the above already at:
> https://lore.kernel.org/linux-pci/20250123170831.GA1226684@bhelgaas/
> and you did agree to do so. But this patch has no reference to the
> upstream driver series which shall be making use of the APIs in this
> patch.

Hi Siddharth,


Bjorn:
   If/when you upstream code that needs this interface, include this
   patch as part of the series.  As Siddharth pointed out, we avoid
   merging code that has no upstream users.


Hans: This user is: pcie-cadence-ep.c. I think this is an optimization 
of Cadence common code. I think this is an optimization of Cadence 
common code. Siddharth, what do you think?


Best regards,
Hans



