Return-Path: <linux-pci+bounces-30262-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86217AE1DF5
	for <lists+linux-pci@lfdr.de>; Fri, 20 Jun 2025 16:57:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E9FB177A57
	for <lists+linux-pci@lfdr.de>; Fri, 20 Jun 2025 14:57:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50B32280327;
	Fri, 20 Jun 2025 14:57:27 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-m21469.qiye.163.com (mail-m21469.qiye.163.com [117.135.214.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B553C2BD5B9;
	Fri, 20 Jun 2025 14:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.214.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750431447; cv=none; b=giayTTbtFsXsXuXgV4Um2J+KLKeR/NWhC3P5P+DK07FVx1VnaUThXtEG395Hc7pcHGanxlWFWFTpGjltPLBlOPMvKkCDieDpXVW943bXjDo8uyjB6Fm7/BYcB33IaeHWRiFF6l5MdEf7fcN1AwI4cDHM4q8vVIml3X/EwCzHwLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750431447; c=relaxed/simple;
	bh=nEieat/MdT1fvVX1SsqoS+kbALvTEjIirRnEuYybfgw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A1eIb5boLwBimKAMmSrcrLhit1xLCDIRKp+/BcXtzJj0TifsrV3btz0XYJ3PGyft5mUxUGd3vL4QS47jrEoAi1EkOmaB71iDcBsugI9QIwZLNWOABm/WnNaCPj7yfh+JoOJ2FyY13olRqN4FYO8NFOuUdQgXRaF5OmUcvjVxnZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hj-micro.com; spf=pass smtp.mailfrom=hj-micro.com; arc=none smtp.client-ip=117.135.214.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hj-micro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hj-micro.com
Received: from [172.21.129.96] (unknown [122.224.241.34])
	by smtp.qiye.163.com (Hmail) with ESMTP id 1956def94;
	Fri, 20 Jun 2025 13:54:05 +0800 (GMT+08:00)
Message-ID: <b95a60f8-0e1d-4c81-8d5a-e2ea7d083780@hj-micro.com>
Date: Fri, 20 Jun 2025 13:54:05 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] PCI: pciehp: Replace fixed delay with polling for
 slot power-off
To: Lukas Wunner <lukas@wunner.de>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 peter.du@hj-micro.com, jemma.zhang@hj-micro.com
References: <20250619093228.283171-1-andy.xu@hj-micro.com>
 <aFP598Yyl0el1uKh@wunner.de>
From: Hongbo Yao <andy.xu@hj-micro.com>
In-Reply-To: <aFP598Yyl0el1uKh@wunner.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkZTBpOVh0ZT01PGB9LSB1MSlYVFAkWGhdVEwETFh
	oSFyQUDg9ZV1kYEgtZQVlKSUlVSUlPVUlPSlVIT1lXWRYaDxIVHRRZQVlPS0hVQkJJTktVSktLVU
	pCS0JZBg++
X-HM-Tid: 0a978be6c2a103afkunm0488a5943ba0a8
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Mzo6Pww*KzE3DjQ9CAI2FjYO
	KC5PFDVVSlVKTE5LSEJDQ09NTUlKVTMWGhIXVRoVHwJVAw47ExFWFhIYCRRVGBQWRVlXWRILWUFZ
	SklJVUlJT1VJT0pVSE9ZV1kIAVlBTktNSzcG



在 2025/6/19 19:52, Lukas Wunner 写道:
> On Thu, Jun 19, 2025 at 05:32:28PM +0800, Hongbo Yao wrote:
>> Fixed 1-second delay in remove_board() fails to accommodate certain
>> hardware like multi-host OCP cards, which exhibit longer power-off
>> latencies.
> 
> Please name the affected product(s).
> 
> They don't seem to comply to the spec.  How prevalent are they?
> If there are only few deployed, quirks like this are probably
> best addressed by an out-of-tree patch.
> 

Hi Lukas,
Thank you for reviewing the patch.

The affected hardware configuration:
 - Host system: Arm Neoverse N2 based server
 - Multi-host OCP card: Mellanox Technologies MT2910 Family [ConnectX-7]


>> Logs before fix:
>> [157.778307] pcieport 0003:00:00.0: pciehp: pending interrupts 0x0001 from Slot Status
>> [157.778321] pcieport 0003:00:00.0: pciehp: Slot(31): Attention button pressed
>> [157.785445] pcieport 0003:00:00.0: pciehp: Slot(31): Powering off due to button press
>> [157.798931] pcieport 000b:00:02.0: pciehp: pending interrupts 0x0001 from Slot Status
> 
> This log excerpt mixes messages from two separate hotplug ports
> (0003:00:00.0 and 000b:00:02.0).  Are these hotplug ports related?
> If not, please reduce the log excerpt to a single hotplug port
> to avoid confusion.
> 
Sorry for not providing adequate context in the patch submission.

Yes, these two hotplug ports are related - they are part of the same
physical multi-host OCP card.

Key points:
1. The OCP card has two independent PCIe endpoints
2. Each endpoint connected to a PCIe root port:
   - Endpoint 1 → Port 0003:00:00.0
   - Endpoint 2 → Port 000b:00:02.0
3. Both endpoints share a common power domain
4. Full power-off occurs only after BOTH endpoints are powered down
5. DLLSC is triggered only after complete power-off

Critical log events:
[157.778307] Both ports: Attention button pressed
[167.540342] Port 0003:00:00.0 power off command issued
[172.289366] Port 000b:00:02.0 power off command issued
[172.302385] Card fully powered off, trigger AER interrupts and DLLSC

Full power-off occurs only after BOTH ports complete their sequences,
taking about 5s total.

>> --- a/drivers/pci/hotplug/pciehp_ctrl.c
>> +++ b/drivers/pci/hotplug/pciehp_ctrl.c
>> @@ -30,6 +30,25 @@
>>  #define SAFE_REMOVAL	 true
>>  #define SURPRISE_REMOVAL false
>>  
>> +static void pciehp_wait_for_link_inactive(struct controller *ctrl)
>> +{
>> +	u16 lnk_status;
>> +	int timeout = 10000, step = 20;
>> +
>> +	do {
>> +		pcie_capability_read_word(ctrl->pcie->port, PCI_EXP_LNKSTA,
>> +					  &lnk_status);
>> +
>> +		if (!(lnk_status & PCI_EXP_LNKSTA_DLLLA))
>> +			return;
>> +
>> +		msleep(step);
>> +		timeout -= step;
>> +	} while (timeout >= 0);
>> +
>> +	ctrl_dbg(ctrl, "Timeout waiting for link inactive state\n");
>> +}
> 
> Any chance you can use one of the existing helpers, such as
> pcie_wait_for_link()?
> 
> Is the 10 second delay chosen arbitrarily or how did you come up
> with it?  How much time do the affected products really need?
>
Ok,  I will try to use pcie_wait_for_link().

The 10-second timeout was determined from actual log observations. The
power-off process for the multi-host OCP card takes approximately 5-9
seconds in our measurements.

>> @@ -119,8 +138,11 @@ static void remove_board(struct controller *ctrl, bool safe_removal)
>>  		 * After turning power off, we must wait for at least 1 second
>>  		 * before taking any action that relies on power having been
>>  		 * removed from the slot/adapter.
>> +		 *
>> +		 * Extended wait with polling to ensure hardware has completed
>> +		 * power-off sequence.
>>  		 */
>> -		msleep(1000);
>> +		pciehp_wait_for_link_inactive(ctrl);
>>  
>>  		/* Ignore link or presence changes caused by power off */
>>  		atomic_and(~(PCI_EXP_SLTSTA_DLLSC | PCI_EXP_SLTSTA_PDC),
> 
> Please keep the msleep(1000), that's the minimum we need to wait
> per PCIe r6.3 sec 6.7.1.8.
> 
> Please make the extra wait for link down conditional on
> ctrl->pcie->port->link_active_reporting.  (DLLLA reporting is
> optional for hotplug ports conforming to older spec revisions.)
> 
Thank you for the valuable suggestion. i'll  revise the patch

Best regards,
Hongbo.> Thanks,
> 
> Lukas
> 
> 


