Return-Path: <linux-pci+bounces-29748-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D16DAD9153
	for <lists+linux-pci@lfdr.de>; Fri, 13 Jun 2025 17:32:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 677F11BC3E98
	for <lists+linux-pci@lfdr.de>; Fri, 13 Jun 2025 15:32:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C19DA1DED47;
	Fri, 13 Jun 2025 15:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="W8lGPEDx"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 322E71B424F;
	Fri, 13 Jun 2025 15:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749828717; cv=none; b=XcZ53CfuR3+8PfszZJrSzg0ZwAvrg1vF3IDYZHcRmFuZ9WsOWAQDHN7Xvl981ltCQs71A2dpJ3P5AbUfRYRo4Q6ncBBgKUsYSAUW1PbMVBIriG5uVnIwqZREGTP12+XopSL7vztltNH8bvm8LfzouobJ9YkTZfT5bung5zxXPM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749828717; c=relaxed/simple;
	bh=39OJrVgYkt2pbn5Ca38HYkVcpBgtJKtkv7FSzbSoOB8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=chhldE4/kaduiXIjTpneOdGm3P/Y9EF5mmv4Bmjn8jMt0Mn5nyIcDenLoAE/sibgajtSllbiy7c9p/HuU9bi8L0w7UOZjX4sYXv75s7kEUNDkfREIztRwtDqhWwYm1f7stkOCmjdXlbiANLShQK+9imz7Fz6EjH0jucY2WdNS/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=W8lGPEDx; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=5NrQGEgPHc7OkD7NNgqkynvWlZ+jmCbXo3ptECvtkyA=;
	b=W8lGPEDx7LESJxpUb5VJPClUujkjL1q6IcJemBE/+s8uUCG+le4HuLjIiSP08i
	00jHcgFvqQ0eJyxPIFB1t7Kknu8YOUsVHY2D5XfYCqTCqotfmJmMYSpCqmT+c/b6
	o7CKAx2RlyzPFwUe3SO6ZnCHGxX11y86maPP0ZSxrlSCM=
Received: from [192.168.71.94] (unknown [])
	by gzga-smtp-mtada-g1-4 (Coremail) with SMTP id _____wBX3ZU1RExoruMjIQ--.51583S2;
	Fri, 13 Jun 2025 23:31:02 +0800 (CST)
Message-ID: <1e3ba7e1-dad3-4728-85d2-276945119ab0@163.com>
Date: Fri, 13 Jun 2025 23:31:01 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/2] PCI: Configure root port MPS during host probing
To: Niklas Cassel <cassel@kernel.org>, Manivannan Sadhasivam <mani@kernel.org>
Cc: lpieralisi@kernel.org, kw@linux.com, bhelgaas@google.com,
 heiko@sntech.de, manivannan.sadhasivam@linaro.org, yue.wang@amlogic.com,
 pali@kernel.org, neil.armstrong@linaro.org, robh@kernel.org,
 jingoohan1@gmail.com, khilman@baylibre.com, jbrunet@baylibre.com,
 martin.blumenstingl@googlemail.com, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-amlogic@lists.infradead.org, linux-rockchip@lists.infradead.org
References: <20250510155607.390687-1-18255117159@163.com>
 <20250510155607.390687-2-18255117159@163.com>
 <co2q55j4mk2ux7af4sj6snnfomditwizg5jevg6oilo3luby5z@6beqtbn3l432>
 <aEwRAZgLJUECbGz6@ryzen>
Content-Language: en-US
From: Hans Zhang <18255117159@163.com>
In-Reply-To: <aEwRAZgLJUECbGz6@ryzen>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_____wBX3ZU1RExoruMjIQ--.51583S2
X-Coremail-Antispam: 1Uf129KBjvJXoW3Aw1rKr4fGr1UCr17uw1xKrg_yoWxGF1xpa
	y5Ga1SyFykGry3GanFv3W09r1Ygr93Zry3Jr98J340v3Z0yF17JrWYkr4rCas7GrZ3Aa42
	vrn0qryxu3ZYvFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UgvtZUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/1tbiOgtro2hMOpDXRQAAsl



On 2025/6/13 19:52, Niklas Cassel wrote:
> On Fri, Jun 13, 2025 at 12:08:31PM +0530, Manivannan Sadhasivam wrote:
>> On Sat, May 10, 2025 at 11:56:06PM +0800, Hans Zhang wrote:
>>> Current PCIe initialization logic may leave root ports operating with
>>> non-optimal Maximum Payload Size (MPS) settings. While downstream device
>>> configuration is handled during bus enumeration, root port MPS values
>>> inherited from firmware or hardware defaults might not utilize the full
>>> capabilities supported by the controller hardware. This can result is
>>> uboptimal data transfer efficiency across the PCIe hierarchy.
>>>
>>> During host controller probing phase, when PCIe bus tuning is enabled,
>>> the implementation now configures root port MPS settings to their
>>> hardware-supported maximum values. By iterating through bridge devices
>>> under the root bus and identifying PCIe root ports, each port's MPS is
>>> set to 128 << pcie_mpss to match the device's maximum supported payload
>>> size.
>>
>> I don't think the above statement is accurate. This patch is not iterating
>> through the bridges and you cannot identify root ports using that. What this
>> patch does is, it checks whether the device is root port or not and if it is,
>> then it sets the MPS to MPSS (hw maximum) if PCIE_BUS_TUNE_OFF is not set.
> 
> Correct.
> Later, when the bus is walked, if any downstream device does not support
> the MPS value currently configured in the root port, pci_configure_mps()
> will reduce the MPS in the root port to the max supported by the downstream
> device.
> 
> So even we start off by setting MPS in the root port to the max supported
> by the root port, it might get reduced later on.
> 
> 

Dear Mani and Niklas,

Is it okay to modify the commit message as follows? The last paragraph 
remains unchanged.



Current PCIe initialization logic may leave root ports operating with
non-optimal Maximum Payload Size (MPS) settings. While downstream device
configuration is handled during bus enumeration, root port MPS values
inherited from firmware or hardware defaults might not utilize the full
capabilities supported by the controller hardware. This can result in
suboptimal data transfer efficiency across the PCIe hierarchy.

During host controller probing phase, when PCIe bus tuning is enabled,
the implementation now configures root port MPS settings to their
hardware-supported maximum values. Specifically, when configuring the MPS
for a PCIe device, if the device is a root port and the bus tuning is not
disabled (PCIE_BUS_TUNE_OFF), the MPS is set to 128 << dev->pcie_mpss to
match the device's maximum supported payload size. The Max Read Request
Size (MRRS) is subsequently adjusted through existing companion logic to
maintain compatibility with PCIe specifications.

Note that this initial setting of the root port MPS to the maximum might
be reduced later during the enumeration of downstream devices if any of
those devices do not support the maximum MPS of the root port.

>>
>>> The Max Read Request Size (MRRS) is subsequently adjusted through
>>> existing companion logic to maintain compatibility with PCIe
>>> specifications.
>>>
>>> Explicit initialization at host probing stage ensures consistent PCIe
>>> topology configuration before downstream devices perform their own MPS
>>> negotiations. This proactive approach addresses platform-specific
>>> requirements where controller drivers depend on properly initialized
>>> root port settings, while maintaining backward compatibility through
>>> PCIE_BUS_TUNE_OFF conditional checks. Hardware capabilities are fully
>>> utilized without altering existing device negotiation behaviors.
>>>
>>> Suggested-by: Niklas Cassel <cassel@kernel.org>
>>> Signed-off-by: Hans Zhang <18255117159@163.com>
>>> ---
>>>   drivers/pci/probe.c | 72 ++++++++++++++++++++++++++-------------------
>>>   1 file changed, 41 insertions(+), 31 deletions(-)
>>>
>>> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
>>> index 364fa2a514f8..1f67c03d170a 100644
>>> --- a/drivers/pci/probe.c
>>> +++ b/drivers/pci/probe.c
>>> @@ -2149,6 +2149,37 @@ int pci_setup_device(struct pci_dev *dev)
>>>   	return 0;
>>>   }
>>>   
>>> +static void pcie_write_mps(struct pci_dev *dev, int mps)
>>> +{
>>> +	int rc;
>>> +
>>> +	if (pcie_bus_config == PCIE_BUS_PERFORMANCE) {
>>> +		mps = 128 << dev->pcie_mpss;
>>> +
>>> +		if (pci_pcie_type(dev) != PCI_EXP_TYPE_ROOT_PORT &&
>>> +		    dev->bus->self)
>>> +
>>> +			/*
>>> +			 * For "Performance", the assumption is made that
>>> +			 * downstream communication will never be larger than
>>> +			 * the MRRS.  So, the MPS only needs to be configured
>>> +			 * for the upstream communication.  This being the case,
>>> +			 * walk from the top down and set the MPS of the child
>>> +			 * to that of the parent bus.
>>> +			 *
>>> +			 * Configure the device MPS with the smaller of the
>>> +			 * device MPSS or the bridge MPS (which is assumed to be
>>> +			 * properly configured at this point to the largest
>>> +			 * allowable MPS based on its parent bus).
>>> +			 */
>>> +			mps = min(mps, pcie_get_mps(dev->bus->self));
>>> +	}
>>> +
>>> +	rc = pcie_set_mps(dev, mps);
>>> +	if (rc)
>>> +		pci_err(dev, "Failed attempting to set the MPS\n");
>>> +}
>>> +
>>>   static void pci_configure_mps(struct pci_dev *dev)
>>>   {
>>>   	struct pci_dev *bridge = pci_upstream_bridge(dev);
>>> @@ -2178,6 +2209,16 @@ static void pci_configure_mps(struct pci_dev *dev)
>>>   		return;
>>>   	}
>>>   
>>> +	/*
>>> +	 * Unless MPS strategy is PCIE_BUS_TUNE_OFF (don't touch MPS at all),
>>> +	 * start off by setting root ports' MPS to MPSS. Depending on the MPS
>>> +	 * strategy, and the MPSS of the devices below the root port, the MPS
>>> +	 * of the root port might get overridden later.
>>> +	 */
>>> +	if (pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT &&
>>> +	    pcie_bus_config != PCIE_BUS_TUNE_OFF)
>>> +		pcie_write_mps(dev, 128 << dev->pcie_mpss);
>>
>> I believe you can just use "pcie_set_mps(dev, 128 << dev->pcie_mpss)" directly
>> and avoid moving pcie_write_mps() around.
> 
> +1
> 

Mani and Niklas,

Thank you very much for your review and suggestions. Will change.

Best regards,
Hans


> 
> Kind regards,
> Niklas


