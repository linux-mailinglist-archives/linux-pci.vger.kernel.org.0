Return-Path: <linux-pci+bounces-26295-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9728DA94657
	for <lists+linux-pci@lfdr.de>; Sun, 20 Apr 2025 03:25:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E0A257A28A0
	for <lists+linux-pci@lfdr.de>; Sun, 20 Apr 2025 01:24:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC7691426C;
	Sun, 20 Apr 2025 01:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="F9Iuod3l"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 561E317E0;
	Sun, 20 Apr 2025 01:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745112330; cv=none; b=SGlZ4OCHIN/1cnwip4hGklpGJlNTynzvOD+hSipd+pZUrHBLrcz9PP1d4tLxBMVXgj/sUMwLe2kdEAgj58twhlEAoYVcGdhd+Z5pqYxlLQ7rMioRLJmphzl2oRps+o2lXtSplU8/sLiTrf2zAVvnwEz7Y3K1bFiERKHPv5HmE94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745112330; c=relaxed/simple;
	bh=5atS7FFvmFxbssnIE/lCOBgY4+PdYuxAh3bI2+OokjE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tJLV7gVQ34nY5knGj9RfzoyDrOFLgBzkjGv/y9cqLB/FaWqA+MtC3n76i/8Y5TEenxFX4OQf+A22cD8u9byswuUq1sbHk7I79bMAGWCFRpOJwaRoMCsyWC1JpnDl2RfUw2momIxnnrIeSCCHFnfU96JIOpIMJoukLa3LtAwzzbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=F9Iuod3l; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:From:
	Content-Type; bh=ZI5YA1hMU5Y0iOLUPey0MFJ6qdSoV0qfKyN2Ge7o89w=;
	b=F9Iuod3lCyule7G5J1NMA7526srFhHpNE9oP0Bwh72KKGYabqelomvcJ34opEE
	K5LOELXbXz1v1Crb/AsVpI96tRk6+qjMrFyMhUkNczwETUt2T1cyCiQtS1ZVAhDt
	iOg9dN2UivGuvr2saLVjcilmtmbrXbx8d7uhjjlJ63Qdg=
Received: from [192.168.71.89] (unknown [])
	by gzga-smtp-mtada-g0-1 (Coremail) with SMTP id _____wCnTsnTTARoeswdBQ--.57004S2;
	Sun, 20 Apr 2025 09:24:36 +0800 (CST)
Message-ID: <348fd943-3ada-4688-bafc-3b6095e86b61@163.com>
Date: Sun, 20 Apr 2025 09:24:35 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] PCI: cadence: Fix runtime atomic count underflow.
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: lpieralisi@kernel.org, kw@linux.com, robh@kernel.org,
 bhelgaas@google.com, s-vadapalli@ti.com, thomas.richard@bootlin.com,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, rockswang7@gmail.com
References: <20250419133058.162048-1-18255117159@163.com>
 <pjacxodfaywqxabqeftguqcrz2eoib5l5l32oevy5j5rrwl5s6@hhglbkyrmnzg>
Content-Language: en-US
From: Hans Zhang <18255117159@163.com>
In-Reply-To: <pjacxodfaywqxabqeftguqcrz2eoib5l5l32oevy5j5rrwl5s6@hhglbkyrmnzg>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_____wCnTsnTTARoeswdBQ--.57004S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7tw18Gry7Jw4fZF1DWF4DArb_yoW8tr1rpF
	ZrWF1xCan7Xayjy3Z2v3Z8XFyayF9xJryDJws7Kw1xZr13Cw1DtFsFqayYgFnrKrZ7tr1x
	J3WqvasrCFnxAF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UgtxDUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/1tbiOhI0o2gD1IoZTQABsf



On 2025/4/20 00:51, Manivannan Sadhasivam wrote:
> On Sat, Apr 19, 2025 at 09:30:58PM +0800, Hans Zhang wrote:
>> If the call to pci_host_probe() in cdns_pcie_host_setup()
>> fails, PM runtime count is decremented in the error path using
>> pm_runtime_put_sync().But the runtime count is not incremented by this
>> driver, but only by the callers (cdns_plat_pcie_probe/j721e_pcie_probe).
>> And the callers also decrement theruntime PM count in their error path.
>> So this leads to the below warning from the PM core:
>>
>> runtime PM usage count underflow!
>>
>> So fix it by getting rid of pm_runtime_put_sync() in the error path and
>> directly return the errno.
>>
>> Fixes: 1b79c5284439 ("PCI: cadence: Add host driver for Cadence PCIe controller")
>>
> 
> This is not the correct Fixes commit. In fact it took me a while to find the
> correct one. This exact same issue was already fixed by commit, 19abcd790b51
> ("PCI: cadence: Fix cdns_pcie_{host|ep}_setup() error path").
> 
> But then, this bug got reintroduced while fixing the merge conflict in:
> 49e427e6bdd1 ("Merge branch 'pci/host-probe-refactor'")
> 
> I will change the tag while applying.
> 

Hi Mani,

Thank you very much.

Best regards,
Hans

> - Mani
> 
>> Signed-off-by: Hans Zhang <18255117159@163.com>
>> ---
>>   drivers/pci/controller/cadence/pcie-cadence-host.c | 11 +----------
>>   1 file changed, 1 insertion(+), 10 deletions(-)
>>
>> diff --git a/drivers/pci/controller/cadence/pcie-cadence-host.c b/drivers/pci/controller/cadence/pcie-cadence-host.c
>> index 8af95e9da7ce..741e10a575ec 100644
>> --- a/drivers/pci/controller/cadence/pcie-cadence-host.c
>> +++ b/drivers/pci/controller/cadence/pcie-cadence-host.c
>> @@ -570,14 +570,5 @@ int cdns_pcie_host_setup(struct cdns_pcie_rc *rc)
>>   	if (!bridge->ops)
>>   		bridge->ops = &cdns_pcie_host_ops;
>>   
>> -	ret = pci_host_probe(bridge);
>> -	if (ret < 0)
>> -		goto err_init;
>> -
>> -	return 0;
>> -
>> - err_init:
>> -	pm_runtime_put_sync(dev);
>> -
>> -	return ret;
>> +	return pci_host_probe(bridge);
>>   }
>>
>> base-commit: a24588245776dafc227243a01bfbeb8a59bafba9
>> -- 
>> 2.25.1
>>
> 


