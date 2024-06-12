Return-Path: <linux-pci+bounces-8676-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F5C390583D
	for <lists+linux-pci@lfdr.de>; Wed, 12 Jun 2024 18:13:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36B9F28A376
	for <lists+linux-pci@lfdr.de>; Wed, 12 Jun 2024 16:13:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACC2F180A79;
	Wed, 12 Jun 2024 16:13:08 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7795C17B516;
	Wed, 12 Jun 2024 16:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718208788; cv=none; b=NDzsKsB38T0QrdqwQwJMyW2/7ka0iteQrYkywM64PoBtqjR3G2m1Tu9tWAB+qNBXyvNFSnLsBBjqTAKnCRZ6HK1ce0MkRk00AGIjR2tEuAqNMr9HP74+Y2f+PlH3VkQhhJqahsxdzfYb8ddUYJCKyHKFmvsPE7zMZdjbVQdYCCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718208788; c=relaxed/simple;
	bh=TqdikSL4T/F8T6RVHBxSBxob3KUr7m3yyjdVJKKjxEk=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Je5XNbSZWJWWwo29ArSZN2PE0A1gZnqwobNYVKaxG21bbbRWVKSI6Oyl/xj1S7VylUgqv8TFkhf3KA7XBf5p+fv7RKuAUhMLiboSSrzp1Q6/CePdNDc0coEH8ImXca45HH7ROe3gR9W/fvwh974przTzlTRWL1+CrdBP/ahJKuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 33ACD1042;
	Wed, 12 Jun 2024 09:13:30 -0700 (PDT)
Received: from [192.168.20.22] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E7B443F73B;
	Wed, 12 Jun 2024 09:13:04 -0700 (PDT)
Message-ID: <a1dd1847-5e77-41dc-a4ad-d44984c3cf98@arm.com>
Date: Wed, 12 Jun 2024 11:10:14 -0500
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Raspberry Pi5 - RP1 driver - RFC
Content-Language: en-US
To: Stefan Wahren <wahrenst@gmx.net>, Lee Jones <lee@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Florian Fainelli <florian.fainelli@broadcom.com>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, devicetree@vger.kernel.org,
 linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
 linux-pci@vger.kernel.org, Dave Ertman <david.m.ertman@intel.com>,
 Lizhi Hou <lizhi.hou@amd.com>, clement.leger@bootlin.com
References: <ZmhvqwnOIdpi7EhA@apocalypse>
 <ba8cdf39-3ba3-4abc-98f5-d394d6867f95@gmx.net>
From: Jeremy Linton <jeremy.linton@arm.com>
In-Reply-To: <ba8cdf39-3ba3-4abc-98f5-d394d6867f95@gmx.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi,

On 6/11/24 14:05, Stefan Wahren wrote:
> Hi Andrea,
> 
> i added Jeremy, because AFAIK he was deeply involved in ACPI
> implementation of the RPi 4.

I'm not sure what to add here, the RPi4 work was done as an example of 
using firmware standards to boot multiple OSs with a single 
boot/firmware interface. Which means ACPI.

Alternatively, the PCIe/SMCCC might be able to make this device look 
more regular, by putting everything on separate PCIe functions.

OTOH, I don't think this device is particularly special, except maybe to 
the extent that it doubles down on ideas regarded as best left in the 
1990's. The kernel documents how to handle these cases with ACPI _ADR(). 
A PCI device can create the _ADR nodes by injecting an SSDT into the 
ACPI namespace via the PCI option ROMs if the platform firmware doesn't 
provide them. Should it though? If I were doing it I might be tempted to 
configure the root port in early firmware and hide it from the OS, 
claiming instead a bunch of platform devices.

IMHO, DT/Linux platforms should probably do something similar to _ADR() 
for consistency rather than requiring the EP driver to get involved. 
Further, mixing DT's into a possible ACPI platform is really the worst 
of both.  Even worse if it requires further distro 
dracut/initrd/grub/etc one off hacking or polluting the initrd or ESP of 
non RPi platforms to handle the overlay.

So, a custom EP/bus driver option solves the problem on linux for both 
DT and ACPI implementations if the device type/offsets are hard coded 
into it. And presumably if there is a follow on device, it would use 
multiple PCIe functions to avoid all these problems, the ones around 
securing the platform with an IOMMU, enabling VFIO, and everything else 
one gets for "free" with a proper PCIe EP.


PS:
The PCIe/SMCC API could probably make all these devices appear as PCIe 
functions avoiding the need for a monolithic bus or DT/ACPI description 
to handle it. But that will likely break the second this device is 
plugged into something with an SMMU (this platform doesn't have one, 
correct?), and of course if would require all the firmware configured 
BAR mappings to remain static, which isn't a problem if its presented as 
an integrated endpoint. If someone is interested in doing it that way 
then we should talk.


> 
> Am 11.06.24 um 17:39 schrieb Andrea della Porta:
>> Hi,
>> I'm on the verge of reworking the RP1 driver from downstream in order 
>> for it to be
>> in good shape for upstream inclusion.
>> RP1 is an MFD chipset that acts as a south-bridge PCIe endpoint 
>> sporting a pletora
>> of subdevices (i.e.  Ethernet, USB host controller, I2C, PWM, etc.) 
>> whose registers
>> are all reachable starting from an offset from the BAR address.
>> The main point here is that while the RP1 as an endpoint itself is 
>> discoverable via
>> usual PCI enumeraiton, the devices it contains are not discoverable 
>> and must be
>> declared e.g. via the devicetree. This is an RFC about the correct 
>> approach to use
>> in integrating the driver and registering the subdevices.
>>
> I cannot provide much input into the technical discussion, but i would
> prefer an approach which works good with DT and ACPI.
> 
> Best regards
> Stefan
>>
>> Link:
>> - [1]: 
>> https://github.com/raspberrypi/linux/blob/rpi-6.6.y/arch/arm/boot/dts/broadcom/rp1.dtsi
>> - [2]: 
>> https://github.com/raspberrypi/linux/blob/rpi-6.6.y/drivers/mfd/rp1.c
>> - [3]: 
>> https://lpc.events/event/17/contributions/1421/attachments/1337/2680/LPC2023%20Non-discoverable%20devices%20in%20PCI.pdf
>> - [4]: 
>> https://lore.kernel.org/lkml/20230419231155.GA899497-robh@kernel.org/t/
>> - [5]: https://lore.kernel.org/lkml/Y862WTT03%2FJxXUG8@kroah.com/
> 


