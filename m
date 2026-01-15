Return-Path: <linux-pci+bounces-44886-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 30CC3D2230D
	for <lists+linux-pci@lfdr.de>; Thu, 15 Jan 2026 03:50:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8C9633015F49
	for <lists+linux-pci@lfdr.de>; Thu, 15 Jan 2026 02:50:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2E5226CE2D;
	Thu, 15 Jan 2026 02:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="ssr9zAGV"
X-Original-To: linux-pci@vger.kernel.org
Received: from canpmsgout02.his.huawei.com (canpmsgout02.his.huawei.com [113.46.200.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0F72283FC4;
	Thu, 15 Jan 2026 02:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768445435; cv=none; b=k9+ANhdkIugDYNVhwWUSS1iH6gRjIOy+d1YSfiuqrLzgfVuFqmLTSNQArCEexJynFeZPrNzLIVqYRfy6xHGH7IAOKMZ+AQYC0D7d3H/HUD8ZFkR4eaKe8wn/GS3O6DwvALzOSB0S4iO26ZADoQNeS5so97NwwOSCbJ7oKgSfgIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768445435; c=relaxed/simple;
	bh=o2XTS6KlZ6Uq81cKf/FQUOIG0hKImr95Un6PTnpuOOs=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Sog5xusDNakteZOfCGu1roSk+oT6wWZ49NGFDFz1vlvS3rjS9okZt3RQ278cc/TzUhEbv6d8MU9ZNxt3iG2RyACRyMQbXvfM9wkjc0Ya8Bwu1GTxpEXOdQgShZp0CgC11ZcCP59+R/74cLfNBS75+/itJxKqAErVmkY/luL1Hrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=ssr9zAGV; arc=none smtp.client-ip=113.46.200.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=y90JyjgAjmVx2JNM/FVh1UCFheEA05DSbnxClbUCO/A=;
	b=ssr9zAGVhzW/C83lf/l+3J6BUkv0lRvDoznq2M6Q4+61Zt7GvPzek0YQv3+D/cHIECPGwFmIJ
	H/grCh0GVMKdu98Q+D5nlt6AG93/eHTzoTpPGp3+mBUcRcuQkp2x8Ml8rFPpslFGisuusP/c+oe
	Iv7Yg0RQlIy0iYvfCxDaRc4=
Received: from mail.maildlp.com (unknown [172.19.163.0])
	by canpmsgout02.his.huawei.com (SkyGuard) with ESMTPS id 4ds6nd1ksVzcb42;
	Thu, 15 Jan 2026 10:46:45 +0800 (CST)
Received: from kwepemr500012.china.huawei.com (unknown [7.202.195.23])
	by mail.maildlp.com (Postfix) with ESMTPS id 22C194056B;
	Thu, 15 Jan 2026 10:50:31 +0800 (CST)
Received: from [100.103.109.72] (100.103.109.72) by
 kwepemr500012.china.huawei.com (7.202.195.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 15 Jan 2026 10:50:30 +0800
Message-ID: <3a045365-3cd0-408e-a366-4c81a1b60cbb@huawei.com>
Date: Thu, 15 Jan 2026 10:50:29 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI: Fix AB-BA deadlock between aer_isr() and
 device_shutdown()
To: Bjorn Helgaas <helgaas@kernel.org>
CC: <bhelgaas@google.com>, <okaya@kernel.org>, <keith.busch@intel.com>,
	<linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<liuyongqiang13@huawei.com>
References: <20260113185130.GA774840@bhelgaas>
From: duziming <duziming2@huawei.com>
In-Reply-To: <20260113185130.GA774840@bhelgaas>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemr500012.china.huawei.com (7.202.195.23)


在 2026/1/14 2:51, Bjorn Helgaas 写道:
> On Fri, Jan 09, 2026 at 05:56:03PM +0800, Ziming Du wrote:
>> During system shutdown, a deadlock may occur between AER recovery process
>> and device shutdown as follows:
>>
>> The device_shutdown path holds the device_lock throughout the entire
>> process and waits for the irq handlers to complete when release nodes:
>>
>>    device_shutdown
>>      device_lock                      # A hold device_lock
>>      pci_device_shutdown
>>        pcie_port_device_remove
>>          remove_iter
>>            device_unregister
>>              device_del
>>                bus_remove_device
>>                  device_release_driver
>>                    devres_release_all
>>                      release_nodes    # B wait for irq handlers
> Can you add the wait location to these example?  release_nodes()
> doesn't wait itself, so I guess it must be in a dr->node.release()
> function?
>
> And I guess it must be related to something in the IRQ path that is
> held while aer_isr() runs?

When releasing the interrupt resources, the process eventually calls 
free_irq(), and then

__synchronize_irq () will be called to wait until all irq handlers have 
finished.

>> The aer_isr path will acquire device_lock in pci_bus_reset():
>>
>>    aer_isr                            # B execute irq process
>>      aer_isr_one_error
>>        aer_process_err_devices
>>          handle_error_source
>>            pcie_do_recovery
>>            aer_root_reset
>>              pci_bus_error_reset
>>                pci_bus_reset          # A acquire device_lock
>>
>> The circular dependency causes system hang. Fix it by using
>> pci_bus_trylock() instead of pci_bus_lock() in pci_bus_reset(). When the
>> lock is unavailable, return -EAGAIN, as in similar cases.
> pci_bus_error_reset() may use either pci_slot_reset() or
> pci_bus_reset(), and this patch addresses only pci_bus_reset().  Is
> the same deadlock possible in the pci_slot_reset() path?

Looking at the code flow, I agree that there is likely a potential issue 
here.

Unfortunately, my current test environment does not support slot_reset, so

I haven't been able to reproduce this specific scenario locally. It would be

incredibly helpful if someone with a compatible setup could help verify 
or reproduce this behavior.

>> Fixes: c4eed62a2143 ("PCI/ERR: Use slot reset if available")
>> Signed-off-by: Ziming Du <duziming2@huawei.com>
>> ---
>>   drivers/pci/pci.c | 17 ++++++++++++-----
>>   1 file changed, 12 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
>> index 13dbb405dc31..7471bfa6f32e 100644
>> --- a/drivers/pci/pci.c
>> +++ b/drivers/pci/pci.c
>> @@ -5515,15 +5515,22 @@ static int pci_bus_reset(struct pci_bus *bus, bool probe)
>>   	if (probe)
>>   		return 0;
>>   
>> -	pci_bus_lock(bus);
>> +	/*
>> +	 * Replace blocking lock with trylock to prevent deadlock during bus reset.
>> +	 * Same as above except return -EAGAIN if the bus cannot be locked.
> Wrap this to fit in 80 columns like the rest of the file.
>
>> +	 */
>> +	if (pci_bus_trylock(bus)) {
>>   
>> -	might_sleep();
>> +		might_sleep();
>>   
>> -	ret = pci_bridge_secondary_bus_reset(bus->self);
>> +		ret = pci_bridge_secondary_bus_reset(bus->self);
>>   
>> -	pci_bus_unlock(bus);
>> +		pci_bus_unlock(bus);
>>   
>> -	return ret;
>> +		return ret;
>> +	}
>> +
>> +	return -EAGAIN;
>>   }
>>   
>>   /**
>> -- 
>> 2.43.0
>>

