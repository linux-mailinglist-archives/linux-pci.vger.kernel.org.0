Return-Path: <linux-pci+bounces-19642-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 92D97A0A0EE
	for <lists+linux-pci@lfdr.de>; Sat, 11 Jan 2025 06:02:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 971F73AB32D
	for <lists+linux-pci@lfdr.de>; Sat, 11 Jan 2025 05:02:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91B37322A;
	Sat, 11 Jan 2025 05:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="C0zezy5P"
X-Original-To: linux-pci@vger.kernel.org
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B47E2114
	for <linux-pci@vger.kernel.org>; Sat, 11 Jan 2025 05:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736571738; cv=none; b=tPcxpuHjW0i/310XZT/I/VseuBiT54gqkeQ5UKuhvyVOBJkFM6md2OluHuA2yJr9V1+S6Hu/lIECx0ec3vurmZpxn1fgjjHj8Hmg5KqXkOwkPo5YnsQwKCbdYV7YweXNHiZlYD8/9m/FOvXfOiK6JKLsCT6y7TsWLzIfxFMjDAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736571738; c=relaxed/simple;
	bh=lXQ+4fameH3M8MHVRJJmDZ81eufW0DFRjZ9ZkSbUcN4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WVA4qRpEzwZ55VGOVgq55wyMZR/bcZHUDYjlsrcErHw39JK/L5wbfaG3gu38glb/y7u0IDRhtLqzRYxRuXgc5EXmNNkCUmfSxsW+1Q0XHXlXrZk2fiy//M1M9fel0OeYMrAiLL9n6nHRMSRgT/8MFK70LK5sIvEV/vV561b/3xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=C0zezy5P; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <bcb30b80-0902-4561-94f9-a6e451702138@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1736571726;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=87PFbocV5iG/YEPJ261ZyupRxofHWTgUBw6ylFg04/A=;
	b=C0zezy5PH3NjJJ3rja00SNNPSHRoK8WteCqC6PRIpIiAhISp3YUvWQ6F/rB5uExooUh/5q
	P2EgIwDrZfl5AnTomUIUOUbdH0GAEdogAHNXGVJotDgyAgAaSj8KKZ/4nFsHh5KpBP06Dd
	B4MOur/ybskGrVPM4vzws7U/dGEGsbw=
Date: Fri, 10 Jan 2025 22:02:00 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 2/3] vmd: disable MSI remapping bypass under Xen
To: Bjorn Helgaas <helgaas@kernel.org>, Roger Pau Monne <roger.pau@citrix.com>
Cc: linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org,
 linux-pci@vger.kernel.org, Nirmal Patel <nirmal.patel@linux.intel.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>
References: <20250110222525.GA318386@bhelgaas>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Jonathan Derrick <jonathan.derrick@linux.dev>
In-Reply-To: <20250110222525.GA318386@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Hi Bjorn,

On 1/10/25 3:25 PM, Bjorn Helgaas wrote:
> Match historical subject line style for prefix and capitalization:
> 
>    PCI: vmd: Set devices to D0 before enabling PM L1 Substates
>    PCI: vmd: Add DID 8086:B06F and 8086:B60B for Intel client SKUs
>    PCI: vmd: Fix indentation issue in vmd_shutdown()
> 
> On Fri, Jan 10, 2025 at 03:01:49PM +0100, Roger Pau Monne wrote:
>> MSI remapping bypass (directly configuring MSI entries for devices on the VMD
>> bus) won't work under Xen, as Xen is not aware of devices in such bus, and
>> hence cannot configure the entries using the pIRQ interface in the PV case, and
>> in the PVH case traps won't be setup for MSI entries for such devices.
>>
>> Until Xen is aware of devices in the VMD bus prevent the
>> VMD_FEAT_CAN_BYPASS_MSI_REMAP capability from being used when running as any
>> kind of Xen guest.
> 
> Wrap to fit in 75 columns.
> 
> Can you include a hint about *why* Xen is not aware of devices below
> VMD?  That will help to know whether it's a permanent unfixable
> situation or something that could be done eventually.
> 
I wasn't aware of the Xen issue with VMD but if I had to guess it's 
probably due to the special handling of the downstream device into the 
dmar table.

[1] 4fda230ecddc2
[2] 9b4a824b889e1


>> Signed-off-by: Roger Pau Monné <roger.pau@citrix.com>
>> ---
>>   drivers/pci/controller/vmd.c | 9 +++++++++
>>   1 file changed, 9 insertions(+)
>>
>> diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
>> index 264a180403a0..d9b7510ace29 100644
>> --- a/drivers/pci/controller/vmd.c
>> +++ b/drivers/pci/controller/vmd.c
>> @@ -965,6 +965,15 @@ static int vmd_probe(struct pci_dev *dev, const struct pci_device_id *id)
>>   	struct vmd_dev *vmd;
>>   	int err;
>>   
>> +	if (xen_domain())
>> +		/*
>> +		 * Xen doesn't have knowledge about devices in the VMD bus.
> 
> Also here.
> 
>> +		 * Bypass of MSI remapping won't work in that case as direct
>> +		 * write to the MSI entries won't result in functional
>> +		 * interrupts.
>> +		 */
>> +		features &= ~VMD_FEAT_CAN_BYPASS_MSI_REMAP;
>> +
>>   	if (resource_size(&dev->resource[VMD_CFGBAR]) < (1 << 20))
>>   		return -ENOMEM;
>>   
>> -- 
>> 2.46.0
>>


