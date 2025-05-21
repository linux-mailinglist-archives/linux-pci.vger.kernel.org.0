Return-Path: <linux-pci+bounces-28220-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4413BABF88F
	for <lists+linux-pci@lfdr.de>; Wed, 21 May 2025 17:00:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C28047A75F8
	for <lists+linux-pci@lfdr.de>; Wed, 21 May 2025 14:59:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AF9621B9C7;
	Wed, 21 May 2025 14:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="bEG+QU3s"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6651421CC71;
	Wed, 21 May 2025 14:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747839359; cv=none; b=KN1yV4JzPF9vpqpKBDK/DsLbYG6yp0g27jO50hqzMXAfMGrJ1PFauzluT3Y+yraZZyBpX3I2LofhLuOFBNJrsvU1tYkkugDvAmP7LCtmktwSGvU8HA6BUVTnBHRYIs1JmdrXTLJbla1wjYbnU9oJPH9KL0cc2gvb/61e1sUol7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747839359; c=relaxed/simple;
	bh=LkusQmqOpI75o2Q1VxnAhBjBHjhBv81PTj17PfR973Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EDz5D6YHMTOWKFnPLIQKZ+TaCofmnVy1UIbcT9siSaHroZHXQOWF+7a160lDjcaBaRbAt/XDtYaiz0iQjP33OfxI7E7+6jpXAwtMtFM+uD2CsAxj6lFw8FaSaL0usBWA2oDAcW/NPlaiz2dYmJBTs05kgYNOe9TTMZ6CmhOMN1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=bEG+QU3s; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=nhOxlgQ7+nfY4fwX45DJfisexcraDE8HthO3m6cUSD8=;
	b=bEG+QU3sKSN/NuvpbocLmTAFjn3OMDEwDPaUnaC4kS0C3iK4mzIwaEF4HmcXVO
	ZnavcnhanmaTbXJVe895+oOvXpEvoByrtyGULwfs5LbkZZWGHlKzzDNA9uV/SDpM
	sPf/8zRaFqw9/a8dXV2ei6j7Fyqo0BTA7lfmWG7yDChVg=
Received: from [192.168.71.93] (unknown [])
	by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id _____wDX_2cp6S1oyxI2DA--.34395S2;
	Wed, 21 May 2025 22:54:34 +0800 (CST)
Message-ID: <1c21ec0b-ca89-4f7e-85f2-bdb48edb8055@163.com>
Date: Wed, 21 May 2025 22:54:33 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] pci: implement "pci=aer_panic"
To: Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>,
 bhelgaas@google.com, tglx@linutronix.de, kw@linux.com,
 manivannan.sadhasivam@linaro.org, mahesh@linux.ibm.com
Cc: oohall@gmail.com, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <20250516165518.125495-1-18255117159@163.com>
 <a1fdd6e1-8cd9-46b0-bd27-526729a1199d@linux.intel.com>
 <8434dc81-5d2d-4ce1-ab73-ca1cf16cb550@163.com>
 <e6ad7ef5-de9c-49bc-9882-5e97bd549168@163.com>
 <3dd17a45-2305-4ac4-a195-4c54ce357ddc@linux.intel.com>
Content-Language: en-US
From: Hans Zhang <18255117159@163.com>
In-Reply-To: <3dd17a45-2305-4ac4-a195-4c54ce357ddc@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDX_2cp6S1oyxI2DA--.34395S2
X-Coremail-Antispam: 1Uf129KBjvJXoW3GFy3GrW7tF1fZF13XF1DKFg_yoWxAw1rpa
	yrAa1jkr4DJFyxAFn2yw1xXryYyasrJwn8Wrn5Jr1agrn0vryUXr4SvF45CF98WrnrWw1U
	ZF40v3srWr15ZFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07U1rWwUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/1tbiOg5Uo2gt4OzfkwAAsG



On 2025/5/21 00:09, Sathyanarayanan Kuppuswamy wrote:
> 
> On 5/19/25 7:41 AM, Hans Zhang wrote:
>>
>>
>> On 2025/5/19 22:21, Hans Zhang wrote:
>>>
>>>
>>> On 2025/5/17 02:10, Sathyanarayanan Kuppuswamy wrote:
>>>>
>>>> On 5/16/25 9:55 AM, Hans Zhang wrote:
>>>>> The following series introduces a new kernel command-line option 
>>>>> aer_panic
>>>>> to enhance error handling for PCIe Advanced Error Reporting (AER) in
>>>>> mission-critical environments. This feature ensures deterministic 
>>>>> recover
>>>>> from fatal PCIe errors by triggering a controlled kernel panic when 
>>>>> device
>>>>> recovery fails, avoiding indefinite system hangs.
>>>>
>>>> Why would a device recovery failure lead to a system hang? Worst case
>>>> that device may not be accessible, right?  Any real use case?
>>>>
>>>
>>>
>>> Dear Sathyanarayanan,
>>>
>>> Due to Synopsys and Cadence PCIe IP, their AER interrupts are usually 
>>> SPI interrupts, not INTx/MSI/MSIx interrupts.  (Some customers will 
>>> design it as an MSI/MSIx interrupt, e.g.: RK3588, but not all 
>>> customers have designed it this way.)  For example, when many mobile 
>>> phone SoCs of Qualcomm handle AER interrupts and there is a link 
>>> down, that is, a fatal problem occurs in the current PCIe physical 
>>> link, the system cannot recover.  At this point, a system restart is 
>>> needed to solve the problem.
>>>
>>> And our company design of SOC: http://radxa.com/products/orion/o6/, 
>>> it has 5 road PCIe port.
>>> There is also the same problem.  If there is a problem with one of 
>>> the PCIe ports, it will cause the entire system to hang.  So I hope 
>>> linux OS can offer an option that enables SOC manufacturers to choose 
>>> to restart the system in case of fatal hardware errors occurring in 
>>> PCIe.
>>>
>>> There are also products such as mobile phones and tablets.  We don't 
>>> want to wait until the battery is completely used up before 
>>> restarting them.
>>>
>>> For the specific code of Qualcomm, please refer to the email I sent.
>>>
>>
>>
>> Dear Sathyanarayanan,
>>
>> Supplementary reasons:
>>
>> drivers/pci/controller/cadence/pcie-cadence-host.c
>> cdns_pci_map_bus
>>     /* Clear AXI link-down status */
>>     cdns_pcie_writel(pcie, CDNS_PCIE_AT_LINKDOWN, 0x0);
>>
>> https://elixir.bootlin.com/linux/v6.15-rc6/source/drivers/pci/controller/cadence/pcie-cadence-host.c#L52
>>
>> If there has been a link down in this PCIe port, the register 
>> CDNS_PCIE_AT_LINKDOWN must be set to 0 for the AXI transmission to 
>> continue.  This is different from Synopsys.
>>
>> If CPU Core0 runs to code L52 and CPU Core1 is executing NVMe SSD 
>> saving files, since the CDNS_PCIE_AT_LINKDOWN register is still 1, it 
>> causes CPU Core1 to be unable to send TLP transfers and hang. This is 
>> a very extreme situation.
>> (The current Cadence code is Legacy PCIe IP, and the HPA IP is still 
>> in the upstream process at present.)
>>
>> Radxa O6 uses Cadence's PCIe HPA IP.
>> http://radxa.com/products/orion/o6/
>>
> 
> It sounds like a system level issue to me. Why not they rely on watchdog 
> to reboot for
> this case ?

Dear Sathyanarayanan,

Thank you for your reply. Yes, personally, I think it's also a problem 
at the system level. I conducted a local test. When I directly unplugged 
the EP device on the slot, the system would hang. It has been tested 
many times. Since we don't have a bus timeout response mechanism for 
PCIe, it hangs easily.

> 
> Even if you want to add this support, I think it is more appropriate to 
> add this to your
> specific PCIe controller driver.  I don't see why you want to add it 
> part of generic
> AER driver.
> 
Because we want to use the processing logic of the general AER driver. 
If the recovery is successful, there will be no problem. If the recovery 
fails, my original intention was to restart the system.

If added to the specific PCIe controller driver, a lot of repetitive AER 
processing logic will be written. So I was thinking whether the AER 
driver could be changed to be compiled as a KO module.


If this series is not reasonable, I'll drop it.


Best regards,
Hans

>>>
>>>>>
>>>>> Problem Statement
>>>>> In systems where unresolved PCIe errors (e.g., bus hangs) occur,
>>>>> traditional error recovery mechanisms may leave the system 
>>>>> unresponsive
>>>>> indefinitely. This is unacceptable for high-availability environment
>>>>> requiring prompt recovery via reboot.
>>>>>
>>>>> Solution
>>>>> The aer_panic option forces a kernel panic on unrecoverable AER 
>>>>> errors.
>>>>> This bypasses prolonged recovery attempts and ensures immediate 
>>>>> reboot.
>>>>>
>>>>> Patch Summary:
>>>>> Documentation Update: Adds aer_panic to kernel-parameters.txt, 
>>>>> explaining
>>>>> its purpose and usage.
>>>>>
>>>>> Command-Line Handling: Implements pci=aer_panic parsing and state
>>>>> management in PCI core.
>>>>>
>>>>> State Exposure: Introduces pci_aer_panic_enabled() to check if the 
>>>>> panic
>>>>> mode is active.
>>>>>
>>>>> Panic Trigger: Modifies recovery logic to panic the system when 
>>>>> recovery
>>>>> fails and aer_panic is enabled.
>>>>>
>>>>> Impact
>>>>> Controlled Recovery: Reduces downtime by replacing hangs with 
>>>>> immediate
>>>>> reboots.
>>>>>
>>>>> Optional: Enabled via pci=aer_panic; no default behavior change.
>>>>>
>>>>> Dependency: Requires CONFIG_PCIEAER.
>>>>>
>>>>> For example, in mobile phones and tablets, when there is a problem 
>>>>> with
>>>>> the PCIe link and it cannot be restored, it is expected to provide an
>>>>> alternative method to make the system panic without waiting for the
>>>>> battery power to be completely exhausted before restarting the system.
>>>>>
>>>>> ---
>>>>> For example, the sm8250 and sm8350 of qcom will panic and restart the
>>>>> system when they are linked down.
>>>>>
>>>>> https://github.com/DOITfit/xiaomi_kernel_sm8250/blob/d42aa408e8cef14f4ec006554fac67ef80b86d0d/drivers/pci/controller/pci-msm.c#L5440
>>>>>
>>>>> https://github.com/OnePlusOSS/android_kernel_oneplus_sm8350/blob/13ca08fdf0979fdd61d5e8991661874bb2d19150/drivers/net/wireless/cnss2/pci.c#L950
>>>>>
>>>>>
>>>>> Since the design schemes of each SOC manufacturer are different, 
>>>>> the AXI
>>>>> and other buses connected by PCIe do not have a design to prevent 
>>>>> hanging.
>>>>> Once a FATAL error occurs in the PCIe link and cannot be restored, the
>>>>> system needs to be restarted.
>>>>>
>>>>>
>>>>> Dear Mani,
>>>>>
>>>>> I wonder if you know how other SoCs of qcom handle FATAL errors 
>>>>> that occur
>>>>> in PCIe link.
>>>>> ---
>>>>>


