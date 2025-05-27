Return-Path: <linux-pci+bounces-28471-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5A17AC59EA
	for <lists+linux-pci@lfdr.de>; Tue, 27 May 2025 20:14:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C592B8A51A1
	for <lists+linux-pci@lfdr.de>; Tue, 27 May 2025 18:14:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A2A92586EA;
	Tue, 27 May 2025 18:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="cM7CTwz3"
X-Original-To: linux-pci@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE7C517588;
	Tue, 27 May 2025 18:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748369665; cv=none; b=JofVirAFIgdDTdsHzuHJ+ndZ+yL7cjLw+LffA2PRajVn71rI5aviUMqlTA2n5vP7BZniipYHhK7N62cbH0f8S3Wxxv4Udexx7PM7aRjnDiDr8t/wjRkJBGeoINZaEfFr3XZ6o1Q9JhhnlNFBXSKDgVmrdWuzF5tXpGAtTZQPpno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748369665; c=relaxed/simple;
	bh=PU+PyxKn0xcYNa7P58bbs3n1VenxbO0VxwPFev/OMxg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rmgOX/fiKb6SLdlKiE0eLhEGWEtIMVb9M4JJjg0lcP/awWrz70X/ih0TqqLrbWPljMWetewjG+shN8Fkiurg4KZpyq7ZJnRKo2ejcuFfZnqE++sbDe8/iWEbPVz2S/Ow7NC/TBHcgOvh4ElN0CsTqUg4V/8NMTsbkx+H/RO7gpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=cM7CTwz3; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [100.65.224.201] (unknown [20.236.10.206])
	by linux.microsoft.com (Postfix) with ESMTPSA id B4D272068340;
	Tue, 27 May 2025 11:14:17 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com B4D272068340
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1748369657;
	bh=LTVke1CMUNvS4hQqIPDgYVFXjE9OC6zyKXgWVqd3TbI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=cM7CTwz38s7tHQJXyuHl+kGxNFU9J00CxwrR1yGeMDxwKKYn7e4DEjl64yO6iZpXR
	 x3cSVA8gRpRQ8MXZNCO+cenCVtnRzcFKE82gsXx5ENSn2nfcdvi3zMhMLlINviwEkp
	 3wi7MS3TQPXEcJFF3Bn7Y3Q7x8sydCWwi6fQIDEY=
Message-ID: <158e9461-9728-4d8f-801c-58ccb1883414@linux.microsoft.com>
Date: Tue, 27 May 2025 11:14:07 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI: Reduce delay after FLR of Microsoft MANA devices
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org, shyamsaini@linux.microsoft.com,
 code@tyhicks.com, Okaya@kernel.org, bhelgaas@google.com,
 linux-kernel@vger.kernel.org
References: <20250523163932.GA1566378@bhelgaas>
Content-Language: en-US
From: Graham Whyte <grwhyte@linux.microsoft.com>
In-Reply-To: <20250523163932.GA1566378@bhelgaas>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 5/23/2025 9:39 AM, Bjorn Helgaas wrote:
> On Wed, May 21, 2025 at 11:15:39PM +0000, grwhyte@linux.microsoft.com wrote:
>> From: Graham Whyte <grwhyte@linux.microsoft.com>
>>
>> Add a device-specific reset for Microsoft MANA devices with the FLR
>> delay reduced from 100ms to 10ms. While this is not compliant with the pci
>> spec, these devices safely complete the FLR much quicker than 100ms and
>> this can be reduced to optimize certain scenarios
> 
> It looks like this could be done generically if the device advertised
> the Readiness Time Reporting Capability (PCIe r6.0, sec 7.9.16) and
> Linux supported that Capability (which it currently does not)?
> 
>>From 7.9.16.3:
> 
>   FLR Time - is the time that the Function requires to become
>   Configuration-Ready after it was issued an FLR.
> 
> Does the device advertise that capability?  It would be much nicer if
> we didn't have to add a device-specific quirk for this.
> 

Unfortunately our device doesn't support the readiness time 
reporting capability.

>> Signed-off-by: Graham Whyte <grwhyte@linux.microsoft.com>
>> ---
>>  drivers/pci/pci.c    |  3 ++-
>>  drivers/pci/pci.h    |  1 +
>>  drivers/pci/quirks.c | 55 ++++++++++++++++++++++++++++++++++++++++++++
>>  3 files changed, 58 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
>> index 9cb1de7658b5..ad2960117acd 100644
>> --- a/drivers/pci/pci.c
>> +++ b/drivers/pci/pci.c
>> @@ -1262,7 +1262,7 @@ void pci_resume_bus(struct pci_bus *bus)
>>  		pci_walk_bus(bus, pci_resume_one, NULL);
>>  }
>>  
>> -static int pci_dev_wait(struct pci_dev *dev, char *reset_type, int timeout)
>> +int pci_dev_wait(struct pci_dev *dev, char *reset_type, int timeout)
>>  {
>>  	int delay = 1;
>>  	bool retrain = false;
>> @@ -1344,6 +1344,7 @@ static int pci_dev_wait(struct pci_dev *dev, char *reset_type, int timeout)
>>  
>>  	return 0;
>>  }
>> +EXPORT_SYMBOL_GPL(pci_dev_wait);
>>  
>>  /**
>>   * pci_power_up - Put the given device into D0
>> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
>> index f2958318d259..3a98e00eb02a 100644
>> --- a/drivers/pci/pci.h
>> +++ b/drivers/pci/pci.h
>> @@ -109,6 +109,7 @@ void pci_init_reset_methods(struct pci_dev *dev);
>>  int pci_bridge_secondary_bus_reset(struct pci_dev *dev);
>>  int pci_bus_error_reset(struct pci_dev *dev);
>>  int __pci_reset_bus(struct pci_bus *bus);
>> +int pci_dev_wait(struct pci_dev *dev, char *reset_type, int timeout);
>>  
>>  struct pci_cap_saved_data {
>>  	u16		cap_nr;
>> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
>> index c354276d4bac..94bd2c82cbbd 100644
>> --- a/drivers/pci/quirks.c
>> +++ b/drivers/pci/quirks.c
>> @@ -4205,6 +4205,55 @@ static int reset_hinic_vf_dev(struct pci_dev *pdev, bool probe)
>>  	return 0;
>>  }
>>  
>> +#define MSFT_PCIE_RESET_READY_POLL_MS 60000 /* msec */
>> +#define MICROSOFT_2051_SVC 0xb210
>> +#define MICROSOFT_2051_MANA_MGMT 0x00b8
>> +#define MICROSOFT_2051_MANA_MGMT_GFT 0xb290
>> +
>> +/* Device specific reset for msft GFT and gdma devices */
>> +static int msft_pcie_flr(struct pci_dev *dev)
>> +{
>> +	if (!pci_wait_for_pending_transaction(dev))
>> +		pci_err(dev, "timed out waiting for pending transaction; "
>> +			"performing function level reset anyway\n");
>> +
>> +	pcie_capability_set_word(dev, PCI_EXP_DEVCTL, PCI_EXP_DEVCTL_BCR_FLR);
>> +
>> +	if (dev->imm_ready)
>> +		return 0;
>> +
>> +	/*
>> +	 * Per PCIe r4.0, sec 6.6.2, a device must complete an FLR within
>> +	 * 100ms, but may silently discard requests while the FLR is in
>> +	 * progress. However, 100ms is much longer than required for modern
>> +	 * devices, so we can afford to reduce the timeout to 10ms.
>> +	 */
>> +	usleep_range(10000, 10001);
>> +
>> +	return pci_dev_wait(dev, "FLR", MSFT_PCIE_RESET_READY_POLL_MS);
>> +}
>> +
>> +/*
>> + * msft_pcie_reset_flr - initiate a PCIe function level reset
>> + * @dev: device to reset
>> + * @probe: if true, return 0 if device can be reset this way
>> + *
>> + * Initiate a function level reset on @dev.
>> + */
>> +static int msft_pcie_reset_flr(struct pci_dev *dev, bool probe)
>> +{
>> +	if (dev->dev_flags & PCI_DEV_FLAGS_NO_FLR_RESET)
>> +		return -ENOTTY;
>> +
>> +	if (!(dev->devcap & PCI_EXP_DEVCAP_FLR))
>> +		return -ENOTTY;
>> +
>> +	if (probe)
>> +		return 0;
>> +
>> +	return msft_pcie_flr(dev);
>> +}
>> +
>>  static const struct pci_dev_reset_methods pci_dev_reset_methods[] = {
>>  	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82599_SFP_VF,
>>  		 reset_intel_82599_sfp_virtfn },
>> @@ -4220,6 +4269,12 @@ static const struct pci_dev_reset_methods pci_dev_reset_methods[] = {
>>  		reset_chelsio_generic_dev },
>>  	{ PCI_VENDOR_ID_HUAWEI, PCI_DEVICE_ID_HINIC_VF,
>>  		reset_hinic_vf_dev },
>> +	{ PCI_VENDOR_ID_MICROSOFT, MICROSOFT_2051_SVC,
>> +		msft_pcie_reset_flr},
>> +	{ PCI_VENDOR_ID_MICROSOFT, MICROSOFT_2051_MANA_MGMT,
>> +		msft_pcie_reset_flr},
>> +	{ PCI_VENDOR_ID_MICROSOFT, MICROSOFT_2051_MANA_MGMT_GFT,
>> +		msft_pcie_reset_flr},
>>  	{ 0 }
>>  };
>>  
>> -- 
>> 2.25.1
>>


