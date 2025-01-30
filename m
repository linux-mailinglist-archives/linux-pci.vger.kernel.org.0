Return-Path: <linux-pci+bounces-20565-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73B41A228F6
	for <lists+linux-pci@lfdr.de>; Thu, 30 Jan 2025 07:54:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C4683A6DFA
	for <lists+linux-pci@lfdr.de>; Thu, 30 Jan 2025 06:54:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C309A193070;
	Thu, 30 Jan 2025 06:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HjEbcfqE"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 827E71531DC
	for <linux-pci@vger.kernel.org>; Thu, 30 Jan 2025 06:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738220073; cv=none; b=iEdiLKM0xGsLCmAQcqcYACkEy0ssbdKKeBdRxx37YNa3cHOC3YkfSW9t5hUQ6GkEZEk2qqEL6y+sOgTbTqTAI0qcepcS+5vcjRK38O054TOWY/dwScsCOK2f34jmZYPw8b3YjO55m04zwE94xcM6qoc84GFHxV/ny203ZudL1fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738220073; c=relaxed/simple;
	bh=ToL2l/AiJeSs56gfh2pIkKnhd/BdbrlUaYzTppwVTkQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lM8BE+v5eD05Ya/PV3kifp/WDEZwyaBCgrAOLhRZ824KMpIJ4acrePcdKUH0YnwQqmF6wUj7c9Z7FKMVG3Mj7MZt2zpe4rTTl2V3o/z3lYSenyWQ6j8hN22NoH1U6K0Xke1eCtE3dnzAh0jJ2tRRmZab59SiO8oOt9UJLqc8wCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HjEbcfqE; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738220072; x=1769756072;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ToL2l/AiJeSs56gfh2pIkKnhd/BdbrlUaYzTppwVTkQ=;
  b=HjEbcfqEznBWsGykIbCdrWoJBwIu7xw2lyASiXXAogdKoYErk9D3SUqe
   sBeHMdfWsoU8hP2+jA+uW1YOlPqf8yC7UbHbiVlCWzd9BokHMTo/93Hek
   UtyjX21kF/X1RE2YCLrLtS3N/HSh64j6r27fGzDEJK06OP6PRCCRDRQpZ
   Mc7u7nwS8SrU+WUSKbbAUr0TpbIFZZVhtsh7EOcvvnyUX1krbBpSBCnrv
   Z5XmBJYpsKMxRShWCNr7pxucKftPq05YYWAN4hsiqdqpN9nFxODPZ4hJi
   J8m6KOu8vB/X1Ou6Jj5EeP9Q/BzuY6QWE+CG/ZKkVRCx3kEFkJxPbsI3C
   A==;
X-CSE-ConnectionGUID: G65OpIJJR6C7bqG4Vi/8Xw==
X-CSE-MsgGUID: eZ3TRgm5RMaQaArAvPgbZw==
X-IronPort-AV: E=McAfee;i="6700,10204,11330"; a="42413094"
X-IronPort-AV: E=Sophos;i="6.13,244,1732608000"; 
   d="scan'208";a="42413094"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2025 22:54:31 -0800
X-CSE-ConnectionGUID: a7kRCHn2RW6BNty6jUqrbA==
X-CSE-MsgGUID: wnkyVkyxQG6L5FPOPi9WAw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,244,1732608000"; 
   d="scan'208";a="109222182"
Received: from uaeoff-desk2.amr.corp.intel.com (HELO [10.124.221.160]) ([10.124.221.160])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2025 22:54:30 -0800
Message-ID: <3ea23e26-6df5-43b8-88ec-eb8e15dc9b69@linux.intel.com>
Date: Wed, 29 Jan 2025 22:54:27 -0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] PCI/ASPM: fix link state exit during switch upstream
 function removal.
To: Bjorn Helgaas <helgaas@kernel.org>, Daniel Stodden <dns@arista.com>
Cc: dinghui@sangfor.com.cn, Daniel Stodden <daniel.stodden@gmail.com>,
 bhelgaas@google.com, david.e.box@linux.intel.com,
 kai.heng.feng@canonical.com, linux-pci@vger.kernel.org,
 michael.a.bottini@linux.intel.com, qinzongquan@sangfor.com.cn,
 rajatja@google.com, refactormyself@gmail.com, vidyas@nvidia.com
References: <20250129212912.GA502577@bhelgaas>
Content-Language: en-US
From: Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20250129212912.GA502577@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 1/29/25 1:29 PM, Bjorn Helgaas wrote:
> On Sun, Dec 22, 2024 at 07:39:08PM -0800, Daniel Stodden wrote:
>> From: Daniel Stodden <daniel.stodden@gmail.com>

If possible include where you noticed this issue and any dmesg
logs related to it.

>> Before change 456d8aa37d0f "Disable ASPM on MFD function removal to
>> avoid use-after-free", we would free the ASPM link only after the last
>> function on the bus pertaining to the given link was removed.
>>
>> That was too late. If function 0 is removed before sibling function,
>> link->downstream would point to free'd memory after.
>>
>> After above change, we freed the ASPM parent link state upon any
>> function removal on the bus pertaining to a given link.
>>
>> That is too early. If the link is to a PCIe switch with MFD on the
>> upstream port, then removing functions other than 0 first would free a
>> link which still remains parent_link to the remaining downstream
>> ports.
> Is this specific to a Switch?  It seems like removal of any
> multi-function device might trip over this.
>
>> The resulting GPFs are especially frequent during hot-unplug, because
>> pciehp removes devices on the link bus in reverse order.
> Do you have a sample GPF?  If we can include a few pertinent lines
> here it may help people connect a problem with this fix.
>
>> On that switch, function 0 is the virtual P2P bridge to the internal
>> bus. Free exactly when function 0 is removed -- before the parent link
>> is obsolete, but after all subordinate links are gone.
> I agree this is a problem.
>
> IIUC we allocate pcie_link_state when enumerating a device on the
> upstream end of a link, i.e., a Root Port or Switch Downstream Port,
> but we deallocate it when removing a device on the downstream end of
> the link, i.e., an Endpoint or Switch Upstream Port.  This asymmetry
> seems kind of prone to error.
>
> Also, struct pcie_link_state contains redundant information, e.g., the
> pdev, downstream, parent, and sibling members basically duplicate the
> hierarchy already described by the struct pci_bus parent, self, and
> devices members.  Redundancy like this is also error prone.
>
> This patch is attractive because it's a very small fix, and maybe we
> should use it for that reason.  But I do think we're basically
> papering over a pretty serious design defect in ASPM.
>
> I think we'd ultimately be better off if we allocated pcie_link_state
> either as a member of struct pci_dev (instead of using a pointer), or
> perhaps in pci_setup_device() when we set up the rest of the
> bridge-related things and made it live as long as the bridge device.
>
> Actually, if we removed all the redundant pointers in struct
> pcie_link_state, it would be smaller than a single pointer, so there'd
> be no reason to allocate it dynamically.
>
> Of course this would be a much bigger change to aspm.c.

Agree. I also think creating the link at the setup would be a better
approach.

But If this issue is seen in any real hardware now and need a urgent
fix, may be we can merge this change for now.

>
>> Fixes: 456d8aa37d0f ("PCI/ASPM: Disable ASPM on MFD function removal to avoid use-after-free")
> Do we have any public problem reports we could mention here?  I'm
> actually a little surprised that this hasn't been a bigger problem,
> given that 456d8aa37d0f appeared in v6.5 in Aug 2023.  But maybe there
> is some unusual topology or hot-unplug involved?
>
>> Signed-off-by: Daniel Stodden <dns@arista.com>
>> ---
>>   drivers/pci/pcie/aspm.c | 17 +++++++++--------
>>   1 file changed, 9 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
>> index e0bc90597dca..8ae7c75b408c 100644
>> --- a/drivers/pci/pcie/aspm.c
>> +++ b/drivers/pci/pcie/aspm.c
>> @@ -1273,16 +1273,16 @@ void pcie_aspm_exit_link_state(struct pci_dev *pdev)
>>   	parent_link = link->parent;
>>   
>>   	/*
>> -	 * link->downstream is a pointer to the pci_dev of function 0.  If
>> -	 * we remove that function, the pci_dev is about to be deallocated,
>> -	 * so we can't use link->downstream again.  Free the link state to
>> -	 * avoid this.
>> +	 * Free the parent link state, no later than function 0 (i.e.
>> +	 * link->downstream) being removed.
>>   	 *
>> -	 * If we're removing a non-0 function, it's possible we could
>> -	 * retain the link state, but PCIe r6.0, sec 7.5.3.7, recommends
>> -	 * programming the same ASPM Control value for all functions of
>> -	 * multi-function devices, so disable ASPM for all of them.
>> +	 * Do not free free the link state any earlier. If function 0

Above line is not very clear. May be you can remove " Do not free free 
the link state any earlier"
>> +	 * is a switch upstream port, this link state is parent_link
>> +	 * to all subordinate ones.
>>   	 */
>> +	if (pdev != link->downstream)
>> +		goto out;
>> +
>>   	pcie_config_aspm_link(link, 0);
>>   	list_del(&link->sibling);
>>   	free_link_state(link);
>> @@ -1293,6 +1293,7 @@ void pcie_aspm_exit_link_state(struct pci_dev *pdev)
>>   		pcie_config_aspm_path(parent_link);
>>   	}
>>   
>> + out:
>>   	mutex_unlock(&aspm_lock);
>>   	up_read(&pci_bus_sem);
>>   }
>> -- 
>> 2.47.0
>>
-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer


