Return-Path: <linux-pci+bounces-27983-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 07EC3ABC075
	for <lists+linux-pci@lfdr.de>; Mon, 19 May 2025 16:22:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7DA4B3B9732
	for <lists+linux-pci@lfdr.de>; Mon, 19 May 2025 14:22:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D509D28368E;
	Mon, 19 May 2025 14:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="FB3ziFub"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0800267386;
	Mon, 19 May 2025 14:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747664545; cv=none; b=g4iJlGvw4tWRjhN9jR7KGtLRpsh1Dsp6viSp+rF3y49b7PF7Z2umX7FMix0TzQtwqtILCPwh65MWI117Y8BQCeyVJqEbWKvVQgTWL5yRfhnbKu3y/DC1YcolGrFNOR5QJVIQeIo6GET0H2D2OX4qYI8p7CQPG1HOZEdQXrZnFkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747664545; c=relaxed/simple;
	bh=WGvI9Sys8UB/5p7lpWZaoHuxDNCB9H661muuNo3jXoU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pQkN6ylax88/SIBxP0K/OXqYIWdooTev5EVktbIsVGq7rx7W0mWeEjB/zgRO+ahljXUdtg46b1eXsKuVgwbEwVzB/GRuBySzhwWcis+52+JYZ66cU5EI1bsvuESRWl6eTMQB6sBxgYjX6gcwC4a0sQBdwvWhRM2LXgI53r68TJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=FB3ziFub; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=Z2COa8w3JR4EYXhLeTUvFO6Inm7EKTyZBbRTLmDni7E=;
	b=FB3ziFubphHMYU5LQ7efemNN3Zhxa04GyYK48muKgSmw0L5i954sxw3nM+7na6
	Cqf+g1zHtLKic9/xHuI8HbzgejhoS1hGXipK9SdWnjdUGJAA4iJQwkDPM1FvSGNm
	QVerCOcJLGqQZOiju88OsMr9IiPrmIZyBVzQMcRpS34JM=
Received: from [192.168.71.93] (unknown [])
	by gzsmtp2 (Coremail) with SMTP id PSgvCgCXq7VZPitoHf_MAw--.1861S2;
	Mon, 19 May 2025 22:21:13 +0800 (CST)
Message-ID: <8434dc81-5d2d-4ce1-ab73-ca1cf16cb550@163.com>
Date: Mon, 19 May 2025 22:21:12 +0800
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
Content-Language: en-US
From: Hans Zhang <18255117159@163.com>
In-Reply-To: <a1fdd6e1-8cd9-46b0-bd27-526729a1199d@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PSgvCgCXq7VZPitoHf_MAw--.1861S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxurW3Ww1DXF1DXw1DuFWUCFg_yoWrKrWUpa
	yrCan0krZ5GFyIk3Z2k3WxWryYyas3t345GrykG342qF1aqFyYqrWSvFWY9F9IgrZYga15
	ZrW0va4UWF1DZF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07U15l8UUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/1tbiOgZSo2grO5lKPAAAsa



On 2025/5/17 02:10, Sathyanarayanan Kuppuswamy wrote:
> 
> On 5/16/25 9:55 AM, Hans Zhang wrote:
>> The following series introduces a new kernel command-line option 
>> aer_panic
>> to enhance error handling for PCIe Advanced Error Reporting (AER) in
>> mission-critical environments. This feature ensures deterministic recover
>> from fatal PCIe errors by triggering a controlled kernel panic when 
>> device
>> recovery fails, avoiding indefinite system hangs.
> 
> Why would a device recovery failure lead to a system hang? Worst case
> that device may not be accessible, right?  Any real use case?
> 


Dear Sathyanarayanan,

Due to Synopsys and Cadence PCIe IP, their AER interrupts are usually 
SPI interrupts, not INTx/MSI/MSIx interrupts.  (Some customers will 
design it as an MSI/MSIx interrupt, e.g.: RK3588, but not all customers 
have designed it this way.)  For example, when many mobile phone SoCs of 
Qualcomm handle AER interrupts and there is a link down, that is, a 
fatal problem occurs in the current PCIe physical link, the system 
cannot recover.  At this point, a system restart is needed to solve the 
problem.

And our company design of SOC: http://radxa.com/products/orion/o6/, it 
has 5 road PCIe port.
There is also the same problem.  If there is a problem with one of the 
PCIe ports, it will cause the entire system to hang.  So I hope linux OS 
can offer an option that enables SOC manufacturers to choose to restart 
the system in case of fatal hardware errors occurring in PCIe.

There are also products such as mobile phones and tablets.  We don't 
want to wait until the battery is completely used up before restarting them.

For the specific code of Qualcomm, please refer to the email I sent.

Best regards,
Hans

>>
>> Problem Statement
>> In systems where unresolved PCIe errors (e.g., bus hangs) occur,
>> traditional error recovery mechanisms may leave the system unresponsive
>> indefinitely. This is unacceptable for high-availability environment
>> requiring prompt recovery via reboot.
>>
>> Solution
>> The aer_panic option forces a kernel panic on unrecoverable AER errors.
>> This bypasses prolonged recovery attempts and ensures immediate reboot.
>>
>> Patch Summary:
>> Documentation Update: Adds aer_panic to kernel-parameters.txt, explaining
>> its purpose and usage.
>>
>> Command-Line Handling: Implements pci=aer_panic parsing and state
>> management in PCI core.
>>
>> State Exposure: Introduces pci_aer_panic_enabled() to check if the panic
>> mode is active.
>>
>> Panic Trigger: Modifies recovery logic to panic the system when recovery
>> fails and aer_panic is enabled.
>>
>> Impact
>> Controlled Recovery: Reduces downtime by replacing hangs with immediate
>> reboots.
>>
>> Optional: Enabled via pci=aer_panic; no default behavior change.
>>
>> Dependency: Requires CONFIG_PCIEAER.
>>
>> For example, in mobile phones and tablets, when there is a problem with
>> the PCIe link and it cannot be restored, it is expected to provide an
>> alternative method to make the system panic without waiting for the
>> battery power to be completely exhausted before restarting the system.
>>
>> ---
>> For example, the sm8250 and sm8350 of qcom will panic and restart the
>> system when they are linked down.
>>
>> https://github.com/DOITfit/xiaomi_kernel_sm8250/blob/d42aa408e8cef14f4ec006554fac67ef80b86d0d/drivers/pci/controller/pci-msm.c#L5440
>>
>> https://github.com/OnePlusOSS/android_kernel_oneplus_sm8350/blob/13ca08fdf0979fdd61d5e8991661874bb2d19150/drivers/net/wireless/cnss2/pci.c#L950
>>
>>
>> Since the design schemes of each SOC manufacturer are different, the AXI
>> and other buses connected by PCIe do not have a design to prevent 
>> hanging.
>> Once a FATAL error occurs in the PCIe link and cannot be restored, the
>> system needs to be restarted.
>>
>>
>> Dear Mani,
>>
>> I wonder if you know how other SoCs of qcom handle FATAL errors that 
>> occur
>> in PCIe link.
>> ---
>>
>> Hans Zhang (4):
>>    pci: implement "pci=aer_panic"
>>    PCI/AER: Introduce aer_panic kernel command-line option
>>    PCI/AER: Expose AER panic state via pci_aer_panic_enabled()
>>    PCI/AER: Trigger kernel panic on recovery failure if aer_panic is set
>>
>>   .../admin-guide/kernel-parameters.txt          |  7 +++++++
>>   drivers/pci/pci.c                              |  2 ++
>>   drivers/pci/pci.h                              |  4 ++++
>>   drivers/pci/pcie/aer.c                         | 18 ++++++++++++++++++
>>   drivers/pci/pcie/err.c                         |  8 ++++++--
>>   5 files changed, 37 insertions(+), 2 deletions(-)
>>
>>
>> base-commit: fee3e843b309444f48157e2188efa6818bae85cf
>> prerequisite-patch-id: 299f33d3618e246cd7c04de10e591ace2d0116e6
>> prerequisite-patch-id: 482ad0609459a7654a4100cdc9f9aa4b671be50b
> 


