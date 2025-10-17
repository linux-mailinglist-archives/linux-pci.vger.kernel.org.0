Return-Path: <linux-pci+bounces-38441-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FCC5BE7E56
	for <lists+linux-pci@lfdr.de>; Fri, 17 Oct 2025 11:53:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09ADB587512
	for <lists+linux-pci@lfdr.de>; Fri, 17 Oct 2025 09:53:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC6582DAFD7;
	Fri, 17 Oct 2025 09:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="Gbakgtf5"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-m3276.qiye.163.com (mail-m3276.qiye.163.com [220.197.32.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17DDC20C48A;
	Fri, 17 Oct 2025 09:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760694787; cv=none; b=MksWgp5n1ATMKS9VJYjU8HFenX5KT/i2BHg1aqjfHv3aQATTEytv6NTT7xw5ryV6BVf9VVg2lXo5PyXFyPEplI83gSvZILxj4+Bx3yM7uoyqJSfnW8sIeiZD8nT6a8C0FM9rcAgkh8yR9a7klg+HBojtayBRq4SdTr/SLyyjT0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760694787; c=relaxed/simple;
	bh=rrVkaR3LTUAqJg6J+NCfj8sfv1ALYesJTJ177QAbv5Q=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Gpb1XZXOsozPUirN7iqUu3HjyqrahSgq7jVYQpYKPZ2dzS/8f8RTd3mS57q6jf05Rmt1IhUBsdkP85l2zQUkbp3JF4gytloVQ0e1Aq4hvy4Rv83XHqU6OYhc8ldaMJ7V0kyS/zT0vDgcuqpdsjslR83WmkK+mwCiNowPIwmaBDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=Gbakgtf5; arc=none smtp.client-ip=220.197.32.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from [172.16.12.129] (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 264578e33;
	Fri, 17 Oct 2025 17:47:46 +0800 (GMT+08:00)
Message-ID: <0dd51970-a7ac-4500-b96f-d1e328e7a3b2@rock-chips.com>
Date: Fri, 17 Oct 2025 17:47:44 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: shawn.lin@rock-chips.com, Niklas Cassel <cassel@kernel.org>,
 Manivannan Sadhasivam <mani@kernel.org>, Bjorn Helgaas
 <bhelgaas@google.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Rob Herring <robh@kernel.org>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 "David E. Box" <david.e.box@linux.intel.com>,
 Kai-Heng Feng <kai.heng.feng@canonical.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Heiner Kallweit <hkallweit1@gmail.com>,
 Chia-Lin Kao <acelan.kao@canonical.com>, Dragan Simic <dsimic@manjaro.org>,
 linux-rockchip@lists.infradead.org, regressions@lists.linux.dev,
 FUKAUMI Naoki <naoki@radxa.com>
Subject: Re: [PATCH v2 1/2] PCI/ASPM: Override the ASPM and Clock PM states
 set by BIOS for devicetree platforms
To: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
 Bjorn Helgaas <helgaas@kernel.org>
References: <7df0bf91-8ab1-4e76-83fa-841a4059c634@rock-chips.com>
 <20251015233054.GA961172@bhelgaas>
 <hwueivbm2taxwb2iowkvblzvdv2xqnsapx6lenv56vuz7ye6do@fugjdkoyk5gy>
From: Shawn Lin <shawn.lin@rock-chips.com>
In-Reply-To: <hwueivbm2taxwb2iowkvblzvdv2xqnsapx6lenv56vuz7ye6do@fugjdkoyk5gy>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a99f191762b09cckunm3ad1505815a4fb
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQx0aQlZITEwfS01OTRgYQ09WFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=Gbakgtf5juyxXLyjvNEBOoU2BvuKHnl3lmL3wESBLpY49996dwrkHEjjo9SGWwLvIF56Wsck8nli3slIooVAyKq9L+enHuUhC/q3KE9B1PuNWLmcdhnOjynCr1jz20j3T257xIWhvF/s1gJcoQBZZPpzm7az96HLHO564hDbcnw=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=35XhCoKrmzdZQlHWnzUSGhfNFUZ/Pw4yplQ4NAHi5Ic=;
	h=date:mime-version:subject:message-id:from;

Hi Mani and Bjorn

在 2025/10/17 星期五 11:36, Manivannan Sadhasivam 写道:
> On Wed, Oct 15, 2025 at 06:30:54PM -0500, Bjorn Helgaas wrote:
>> On Wed, Oct 15, 2025 at 09:00:41PM +0800, Shawn Lin wrote:
>>> ...
>>
>>> For now, this is a acceptable option if default ASPM policy enable
>>> L1ss w/o checking if the HW could supports it... But how about
>>> adding supports-clkreq stuff to upstream host driver directly? That
>>> would help folks enable L1ss if the HW is ready and they just need
>>> adding property to the DT.
>>> ...
>>
>>> The L1ss support is quite strict and need several steps to check, so we
>>> didn't add supports-clkreq for them unless the HW is ready to go...
>>>
>>> For adding supports of L1ss,
>>> [1] the HW should support CLKREQ#, expecially for PCIe3.0 case on Rockchip
>>> SoCs , since both  CLKREQ# of RC and EP should connect to the
>>> 100MHz crystal generator's enable pin, as L1.2 need to disable refclk as
>>> well. If the enable pin is high active, the HW even need a invertor....
>>>
>>> [2] define proper clkreq iomux to pinctrl of pcie node
>>> [3] make sure the devices work fine with L1ss.(It's hard to check the slot
>>> case with random devices in the wild )
>>> [4] add supports-clkreq to the DT and enable
>>> CONFIG_PCIEASPM_POWER_SUPERSAVE
>>
>> I don't understand the details of the supports-clkreq issue.
>>
>> If we need to add supports-clkreq to devicetree, I want to understand
>> why we need it there when we don't seem to need it for ACPI systems.
>>
>> Generally the OS relies on what the hardware advertises, e.g., in Link
>> Capabilities and the L1 PM Substates Capability, and what is available
>> from firmware, e.g., the ACPI _DSM for Latency Tolerance Reporting.
>>
>> On the ACPI side, I don't think we get any specific information about
>> CLKREQ#.  Can somebody explain why we do need it on the devicetree
>> side?
>>
> 
> I think there is a disconnect between enabling L1ss CAP and CLKREQ#
> availability.. When L1ss CAP is enabled for the Root Port in the hardware, there
> is no guarantee that CLKREQ# is also available. If CLKREQ# is not available,
> then if L1ss is enabled by the OS, it is not possible to exit the L1ss states
> (assuming that L1ss is entered due to CLKREQ# in deassert (default) state).
> 
> Yes, there seems to be no standard way to know CLKREQ# presence in ACPI, but
> in devicetree, we have this 'supports-clkreq' property to tell the OS that
> CLKREQ# is available in the platform. But unfortunately, this property is not
> widely used by the devicetrees out there. So we cannot use it in generic
> pci/aspm.c driver.
> 
> We can certainly rely on the BIOS to enable L1ss as the fw developers would
> have the knowledge of the CLKREQ# availability. But BIOS is not a thing on
> mobile and embedded platforms where L1ss would come handy.
> 
> What I would suggest is, the host controller drivers (mostly for devicetree
> platforms) should enable L1ss CAP for the Root Port only if they know that
> CLKREQ# is available. They can either rely on the 'supports-clkreq' property or
> some platform specific knowledge (for instance, on all Qcom platforms, we
> certainly know that CLKREQ# is available, but we don't set the DT property).

While we're on the topic of ASPM, may I ask a silly question?
I saw the ASPM would only be configured once the function driver calling
pci_enable_device. So if the modular driver hasn't been insmoded, the
link will be in L0 even though there is no transcation on-going. What is
the intention behind it?

> 
> Then in the generic pci/aspm.c driver, we can just enable L1ss for all devices
> if the CAP is set, which we do currently.
> 
> - Mani
> 


