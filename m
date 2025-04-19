Return-Path: <linux-pci+bounces-26285-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BEEC7A9438B
	for <lists+linux-pci@lfdr.de>; Sat, 19 Apr 2025 15:14:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E0141167C84
	for <lists+linux-pci@lfdr.de>; Sat, 19 Apr 2025 13:14:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD1171D86FF;
	Sat, 19 Apr 2025 13:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="kgcfLObo"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 364AD1C3F0C;
	Sat, 19 Apr 2025 13:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745068484; cv=none; b=RSOl095NOKBGX6KVsz9/Jjao6FDcypQBxha5Feuq7nExROBpLEhKe8HrRoCdXpVltDTjmRCiFZGAKOlRc8cD59lhF3j1PXmBGvijl0zqROz/kuw9KIobEdnrWlI+tc9/Ngkuxbk7h7jkWWL/dwGAslvhSmgQQ3moY4Bnp3JJIaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745068484; c=relaxed/simple;
	bh=sl5+eqOtpT0QSyZE8wpHEfq1xzNkUpXKTL5LEleiIdY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TNkatOc9aMdS4BGzZID90rQClDH8wvlD5p2MaH9su66QGzQfzQ14PoTUxKZJ22EzIZJmpeZ8CzD9JD9RLsStW0ZVgPnUzpexsUCEK5f1V4fhSdDd11mfiud00zTHBdktdbc1JvBAapA6YKlan165obazKrjom4wTC4v5Xyq+7hI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=kgcfLObo; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:From:
	Content-Type; bh=bys+Y6TeZSzdEO+EMla5C2QbVwHWwodrEcI4+JxHHsA=;
	b=kgcfLObo4NickwUWJeZGiomwGqaCh6xwrZ3fJq6RFftvEznObOP7v6hdShdKjR
	sjgVovhmBpdLuwgGNIJELBzLHdZpRQDw0LjQpaBWl8UrgYiaa+yFXp/xRUco1Hmu
	NkQBn2pB22KPWU+EbfGVGgp8vLOR1PV6Jeqaz1bNCqJ1w=
Received: from [192.168.71.89] (unknown [])
	by gzga-smtp-mtada-g1-4 (Coremail) with SMTP id _____wB3jt2doQNopvW0Aw--.64843S2;
	Sat, 19 Apr 2025 21:14:06 +0800 (CST)
Message-ID: <a890091b-b28b-4122-a7ae-bbb8d750cd7d@163.com>
Date: Sat, 19 Apr 2025 21:14:05 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND] PCI: cadence: Fix runtime atomic count underflow.
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: lpieralisi@kernel.org, kw@linux.com, robh@kernel.org,
 bhelgaas@google.com, s-vadapalli@ti.com, thomas.richard@bootlin.com,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, rockswang7@gmail.com
References: <20250301124418.291980-1-18255117159@163.com>
 <shhqkx5vt5dwbw452yf5cq6gubgcrqpzw6xatyo2m7laogg7gv@xpnspwe5x7ds>
Content-Language: en-US
From: Hans Zhang <18255117159@163.com>
In-Reply-To: <shhqkx5vt5dwbw452yf5cq6gubgcrqpzw6xatyo2m7laogg7gv@xpnspwe5x7ds>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_____wB3jt2doQNopvW0Aw--.64843S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Zr1xtFyDKFWDKr4kAF4fXwb_yoW8CF43pF
	WDWayxCa10q3y2vFZ2v3WUXFyayasxJ348Jw4vg3W8uF13Cw12qFsrKFyYqFyDKr4qgr12
	qw1qqasxCF4YyFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UKNtsUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/1tbiWwo0o2gDoOEXxAAAs-



On 2025/4/19 18:05, Manivannan Sadhasivam wrote:
> On Sat, Mar 01, 2025 at 08:44:18PM +0800, Hans Zhang wrote:
>> From: "Hans Zhang" <18255117159@163.com>
>>
>> If the pci_host_probe fails to be executed and run one time
>> pm_runtime_put_sync. Run pm_runtime_put_sync or pm_runtime_put again in
>> cdns_plat_pcie_probe or j721e_pcie_probe. Finally, it will print log
>> "runtime PM usage count underflow!".
>>
> 
> Please reword the description as:
> 
> "If the call to pci_host_probe() in cdns_pcie_host_setup() fails, PM runtime
> count is decremented in the error path using pm_runtime_put_sync(). But the
> runtime count is not incremented by this driver, but only by the callers
> (cdns_plat_pcie_probe/j721e_pcie_probe). And the callers also decrement the
> runtime PM count in their error path. So this leads to the below warning from
> the PM core:
> 
> runtime PM usage count underflow!
> 
> So fix it by getting rid of pm_runtime_put_sync() in the error path and directly
> return the errno."
> 

Hi Mani,

Thank you very much for your reply and suggestions.

>> Signed-off-by: Hans Zhang <18255117159@163.com>
> 
> Fixes tag?

Will add.

> 
>> ---
>>   drivers/pci/controller/cadence/pcie-cadence-host.c | 4 +---
>>   1 file changed, 1 insertion(+), 3 deletions(-)
>>
>> diff --git a/drivers/pci/controller/cadence/pcie-cadence-host.c b/drivers/pci/controller/cadence/pcie-cadence-host.c
>> index 8af95e9da7ce..fe0b8d76005e 100644
>> --- a/drivers/pci/controller/cadence/pcie-cadence-host.c
>> +++ b/drivers/pci/controller/cadence/pcie-cadence-host.c
>> @@ -576,8 +576,6 @@ int cdns_pcie_host_setup(struct cdns_pcie_rc *rc)
>>   
>>   	return 0;
>>   
>> - err_init:
>> -	pm_runtime_put_sync(dev);
>> -
>> +err_init:
>>   	return ret;
> 
> You can now directly do 'return ret' instead of using label.

Will change.

Best regards,
Hans


