Return-Path: <linux-pci+bounces-41198-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id CA77EC5ADFA
	for <lists+linux-pci@lfdr.de>; Fri, 14 Nov 2025 02:04:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D007C345AE5
	for <lists+linux-pci@lfdr.de>; Fri, 14 Nov 2025 01:03:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BCD22192EA;
	Fri, 14 Nov 2025 01:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="YP7Acl8v"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-m3269.qiye.163.com (mail-m3269.qiye.163.com [220.197.32.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 436DF163;
	Fri, 14 Nov 2025 01:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763082187; cv=none; b=EeO53bF+EERDEq5VPJpZSr3ZR+ephl8f68oPb/zQEguM2Pnh8U/dtOG3YQPg8bMmTeCLmz9OghQEW5pHGfIbc7+162Kw1tTtrhojPVeq6qNhIn+xNdOMJ0PkrDZklVvpGx8LtthnjsK6hGiubUaXxFiyEeakX8wLOIoND3XtJUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763082187; c=relaxed/simple;
	bh=CQoq6PMx8qJxH9R1nksizClk7X+KvrHzV4SU2EAENyk=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=lI/xLhJVQ7pW/RBO6e6xa27B9BrZa6ucPea6UzxV6gPjyIOUKYf7lHy00OM5V2nUrWWaV2VO6s5KjfKH1xzjVRWLngBh0SpHk8dUmNtVV+Xw2PQObGVEAn8UMo5iqXOUfsdlR1zjefPpZu7go5KhOtG+3CQbENkLZ6eAQu1F0kE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=YP7Acl8v; arc=none smtp.client-ip=220.197.32.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from [172.16.12.129] (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 298723ecb;
	Fri, 14 Nov 2025 09:02:51 +0800 (GMT+08:00)
Message-ID: <589ea395-f133-4522-91e5-066c41916cd5@rock-chips.com>
Date: Fri, 14 Nov 2025 09:02:47 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: shawn.lin@rock-chips.com,
 Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
 andersson@kernel.org, robh@kernel.org, manivannan.sadhasivam@linaro.org,
 krzk@kernel.org, helgaas@kernel.org, linux-arm-msm@vger.kernel.org,
 devicetree@vger.kernel.org, lpieralisi@kernel.org, kw@linux.com,
 conor+dt@kernel.org, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree-spec@vger.kernel.org,
 quic_vbadigan@quicinc.com
Subject: Re: [PATCH v2] schemas: pci: Document PCIe T_POWER_ON
To: Manivannan Sadhasivam <mani@kernel.org>, Lukas Wunner <lukas@wunner.de>
References: <20251110112947.2071036-1-krishna.chundru@oss.qualcomm.com>
 <aRHdiYYcn2uZkLor@wunner.de>
 <44c7b4a8-33ce-4516-81bf-349b5e555806@oss.qualcomm.com>
 <aRWYoHvaCCN95ZR9@wunner.de>
 <epqkkezjnkwznh4minlvhh7vbnwh3isqeofqamgupj7rjnhjv2@wtrx4ecjgvob>
From: Shawn Lin <shawn.lin@rock-chips.com>
In-Reply-To: <epqkkezjnkwznh4minlvhh7vbnwh3isqeofqamgupj7rjnhjv2@wtrx4ecjgvob>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9a7fe2f3d309cckunm7df1131438582d
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQ0hIGlZOTk1LT01JSx5OHU1WFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=YP7Acl8vbwtTaY33kEqeey/faq0UGGe9d/nheRb1LEIwau649WCt0kT2wPiOowouohWQolaQlU99knIRBQIgLmuVjhw0K+0+0ZPhPDvE5VHqk+E6yHC6DrqDZENQ5eHKpx6lRa/MIYge+QJ2VdxImCZFNzKyNm+40uUfLXJ3Alk=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=QOiKLcyDhGH6tCscfk11AwDm2zmGxDE8qbFURUj6Xa8=;
	h=date:mime-version:subject:message-id:from;

在 2025/11/14 星期五 0:41, Manivannan Sadhasivam 写道:
> On Thu, Nov 13, 2025 at 09:36:48AM +0100, Lukas Wunner wrote:
>> On Thu, Nov 13, 2025 at 09:33:54AM +0530, Krishna Chaitanya Chundru wrote:
>>> On 11/10/2025 6:11 PM, Lukas Wunner wrote:
>>>> On Mon, Nov 10, 2025 at 04:59:47PM +0530, Krishna Chaitanya Chundru wrote:
>>>>>   From PCIe r6, sec 5.5.4 & Table 5-11 in sec 5.5.5 T_POWER_ON is the
>>>> Please use the latest spec version as reference, i.e. PCIe r7.0.
>>> ack.
>>>>> minimum amount of time(in us) that each component must wait in L1.2.Exit
>>>>> after sampling CLKREQ# asserted before actively driving the interface to
>>>>> ensure no device is ever actively driving into an unpowered component and
>>>>> these values are based on the components and AC coupling capacitors used
>>>>> in the connection linking the two components.
>>>>>
>>>>> This property should be used to indicate the T_POWER_ON for each Root Port.
>>>> What's the difference between this property and the Port T_POWER_ON_Scale
>>>> and T_POWER_ON_Value in the L1 PM Substates Capabilities Register?
>>>>
>>>> Why do you need this in the device tree even though it's available
>>>> in the register?
>>>
>>> This value is same as L1 PM substates value, some controllers needs to
>>> update this
>>> value before enumeration as hardware might now program this value
>>> correctly[1].
>>>
>>> [1]: [PATCH] PCI: qcom: Program correct T_POWER_ON value for L1.2 exit
>>> timing
>>>
>>> <https://lore.kernel.org/all/20251104-t_power_on_fux-v1-1-eb5916e47fd7@oss.qualcomm.com/>
>>
>> Per PCIe r7.0 sec 7.8.3.2, all fields in the L1 PM Substates Capabilities
>> Register are of type "HwInit", which sec 7.4 defines as:
>>
>>     "Register bits are permitted, as an implementation option, to be
>>      hard-coded, initialized by system/device firmware, or initialized
>>      by hardware mechanisms such as pin strapping or nonvolatile storage.
>>      Initialization by system firmware is permitted only for
>>      system-integrated devices.
>>      Bits must be fixed in value and read-only after initialization."
>>                                      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>>
>> These bits are not supposed to be writable by the operating system,
>> so what you're doing in that patch is not spec-compliant.
>>
> 
> I interpret 'initialized by system/device firmware', same as 'initialized by
> OS', as both are mostly same for the devicetree platforms. So it is fine IMO.
> Ofc, if the initialization was carried out by the firmware, then OS has no
> business in changing it, but it is not the case.
> 

Yes, I tend to agree with Mani. Another problem is the s2r process in
embedded ARM world. For power-saving, most platforms would cut-off the
power supply of PCIe controller during system suspend, so we save and
restore this value when relink is done, right? OS had already done this
kind of thing already.

>> I think it needs to be made explicit in the devicetree schema that
>> the property is only intended for non-compliant hardware which allows
>> (and requires) the operating system to initialize the register.
>>
> 
> Sorry, I disagree. The hardware is spec compliant, just that the firmware missed
> initializing the fields.
> 
>> Maybe it makes more sense to have a property which specifies the raw
>> 32-bit register contents, instead of having a property for each
>> individual field.  Otherwise you'll have to amend the schema
>> whenever the PCIe spec extends the register with additional fields.
>>
> 
> DT properties do not specify a register value, but instead they specify hardware
> configuration value and that's what this property is doing. The OS/other DT
> consumers should interpret this value as per the spec and program the relevant
> registers.
> 
> - Mani
> 


