Return-Path: <linux-pci+bounces-35033-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CEAC7B3A1F1
	for <lists+linux-pci@lfdr.de>; Thu, 28 Aug 2025 16:32:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD0CD567F79
	for <lists+linux-pci@lfdr.de>; Thu, 28 Aug 2025 14:25:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB17D1FA15E;
	Thu, 28 Aug 2025 14:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="REVhDYb4"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82F1613C9C4;
	Thu, 28 Aug 2025 14:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756391131; cv=none; b=a4SfEVUHCwrZkF2VoiMRiFLP2lwu004RTNduNL21M4y6JCpy+M/lsiwsk7p5KuXmXL1oKU6Ynw54jugeC4prl7rzpBNW+hFHnbA8pIJ90CweX0dw6lxCvDTwscsLz0E7cU4CCwZOwfODutT5+qABXBudVVSoCzEJsa2XMMy1Cu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756391131; c=relaxed/simple;
	bh=ctXXuZthrYPN8m3zdtlV1bfQrMxBPN7QdSrRnWrEq10=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ENgqpHxsRqAkApD4FEJeb09jhwNM5QZKFRcEQyLYWo4vu+fJHaXO3e9JhU/w/R0i6J1ujBjYqyB0xiFHVCR0KcC6o2+xkbXHkLyc0/HGJCshVYrtlDH2l9o9GBhodGie7ahr818AkBzViOqyGzo+uZRyegFtWIi2sE4g260qH9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=REVhDYb4; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=ZMw82sNcr14CqM0U5e5giT0K80wsieOzfu3KUX+hO4g=;
	b=REVhDYb4AJ/2mWR75HKYOQTsGpPklJAoixEqCU35FVUQQnUrTUUNrfqejZzlTh
	f7Nq6QNrch8frXQNQg9vdUC8zzZlrHp11ahBeshb/YSwtetsDlQrwdJ04GWOliwm
	3jluItSGgpJ2CbGl5S7JChfNBJ0Echu28ITjmDNEGT9XE=
Received: from [IPV6:240e:b8f:919b:3100:3980:6173:5059:2d2a] (unknown [])
	by gzga-smtp-mtada-g1-0 (Coremail) with SMTP id _____wD3H6vLZrBom697FA--.34635S2;
	Thu, 28 Aug 2025 22:25:15 +0800 (CST)
Message-ID: <f4f1f851-5db5-4bdb-bbb2-e984b76c8fef@163.com>
Date: Thu, 28 Aug 2025 22:25:15 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/8] PCI: Replace msleep with fsleep for precise
 secondary bus reset
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250826230552.GA860063@bhelgaas>
Content-Language: en-US
From: Hans Zhang <18255117159@163.com>
In-Reply-To: <20250826230552.GA860063@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_____wD3H6vLZrBom697FA--.34635S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxZr1DXryxGw13ZF1xKw4UArb_yoWrAr4xpF
	W5GF1IyF1kXrWrJws7A3WDu34ru3ZxZFyUCF48K3sYvFn09FWq9FWYkFW5XFykZFZ7Zr1Y
	vFZ5C3s8ZFWYyFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRNBMiUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/1tbiWxq3o2iwZGc6UwAAsn



On 2025/8/27 07:05, Bjorn Helgaas wrote:
> On Wed, Aug 27, 2025 at 01:03:09AM +0800, Hans Zhang wrote:
>> The msleep() function with small values (less than 20ms) may not sleep
>> for the exact duration due to the kernel's timer wheel design. According
>> to the comment in kernel/time/sleep_timeout.c:
>>
>>    "The slack of timers which will end up in level 0 depends on sleep
>>    duration (msecs) and HZ configuration. For example, with HZ=1000 and
>>    a requested sleep of 2ms, the slack can be as high as 50% (1ms) because
>>    the minimum slack is 12.5% but the actual calculation for level 0 timers
>>    is slack = MSECS_PER_TICK / msecs. This means that msleep(2) can
>>    actually take up to 3ms (2ms + 1ms) on a system with HZ=1000."
> 
> I thought I heard something about 20ms being the minimum actual delay
> for small msleeps.  I suppose the error is larger for HZ=100 systems.
> 

Yes.

> The fsleep() would turn into something between 2ms and 2.5ms, so if
> we're talking about reducing 3ms to 2.5ms, I have a hard time getting
> worried about that.
> 
> And we're going to wait at least 100ms before touching the device
> below the bridge anyway.

int pci_bridge_secondary_bus_reset(struct pci_dev *dev)
	pcibios_reset_secondary_bus(dev);
                 pci_reset_secondary_bus(dev);
                         pci_read_config_word(dev, PCI_BRIDGE_CONTROL, 
&ctrl);
                         ctrl |= PCI_BRIDGE_CTL_BUS_RESET;
                         pci_write_config_word(dev, PCI_BRIDGE_CONTROL, 
ctrl);

                         /*
                         * PCI spec v3.0 7.6.4.2 requires minimum Trst 
of 1ms.  Double
                         * this to 2ms to ensure that we meet the 
minimum requirement.
                         */
                         msleep(2);      // As you mentioned, is it 
necessary to be very precise here? Please decide whether you want to 
make the modification.

                         ctrl &= ~PCI_BRIDGE_CTL_BUS_RESET;
                         pci_write_config_word(dev, PCI_BRIDGE_CONTROL, 
ctrl);
	pci_bridge_wait_for_secondary_bus(dev, "bus reset");
                 // There are also some delays in between.

                 // The delay here is also long enough.
                 pci_dev_wait(child, reset_type, 
PCIE_RESET_READY_POLL_MS - delay);




If it's not necessary to do so, do I still need to resubmit the version? 
Or do you choose a few acceptable ones or the first patch?



Best regards,
Hans

> 
>> This unnecessary delay can impact system responsiveness during PCI
>> operations, especially since the PCIe r7.0 specification, section
>> 7.5.1.3.13, requires only a minimum Trst of 1ms. We double this to 2ms
>> to ensure we meet the minimum requirement, but using msleep(2) may
>> actually wait longer than needed.
>>
>> Using fsleep() provides a more precise delay that matches the stated
>> intent of the code. The fsleep() function uses high-resolution timers
>> where available to achieve microsecond precision.
>>
>> Replace msleep(2 * PCI_T_RST_SEC_BUS_DELAY_MS) with
>> fsleep(2 * PCI_T_RST_SEC_BUS_DELAY_US) to ensure the actual delay is
>> closer to the intended 2ms delay.
>>
>> Signed-off-by: Hans Zhang <18255117159@163.com>
>> ---
>>   drivers/pci/pci.c | 2 +-
>>   drivers/pci/pci.h | 2 +-
>>   2 files changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
>> index c05a4c2fa643..81105dfc2f62 100644
>> --- a/drivers/pci/pci.c
>> +++ b/drivers/pci/pci.c
>> @@ -4964,7 +4964,7 @@ void pci_reset_secondary_bus(struct pci_dev *dev)
>>   	pci_write_config_word(dev, PCI_BRIDGE_CONTROL, ctrl);
>>   
>>   	/* Double this to 2ms to ensure that we meet the minimum requirement */
>> -	msleep(2 * PCI_T_RST_SEC_BUS_DELAY_MS);
>> +	fsleep(2 * PCI_T_RST_SEC_BUS_DELAY_US);
>>   
>>   	ctrl &= ~PCI_BRIDGE_CTL_BUS_RESET;
>>   	pci_write_config_word(dev, PCI_BRIDGE_CONTROL, ctrl);
>> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
>> index 4d7e9c3f3453..9d38ef26c6a9 100644
>> --- a/drivers/pci/pci.h
>> +++ b/drivers/pci/pci.h
>> @@ -61,7 +61,7 @@ struct pcie_tlp_log;
>>   #define PCIE_LINK_WAIT_SLEEP_MS		90
>>   
>>   /* PCIe r7.0, sec 7.5.1.3.13, requires minimum Trst of 1ms */
>> -#define PCI_T_RST_SEC_BUS_DELAY_MS	1
>> +#define PCI_T_RST_SEC_BUS_DELAY_US	1000
>>   
>>   /* Message Routing (r[2:0]); PCIe r6.0, sec 2.2.8 */
>>   #define PCIE_MSG_TYPE_R_RC	0
>> -- 
>> 2.25.1
>>


