Return-Path: <linux-pci+bounces-4540-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D2480872A3F
	for <lists+linux-pci@lfdr.de>; Tue,  5 Mar 2024 23:36:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 891091F215A6
	for <lists+linux-pci@lfdr.de>; Tue,  5 Mar 2024 22:36:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 742437E590;
	Tue,  5 Mar 2024 22:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Q3Y+Ab0G"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E75845BF1;
	Tue,  5 Mar 2024 22:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709678161; cv=none; b=YpLMI61hrIVwJuDnwqOBtwBQrTJ1Z88OiQcSG3lQkzqzv0Zo3RZu79mrvmuOWRUs223EJgGpkPUdtORFtFOAh7wQmw7IsaDSA4CdvjYbddCb76f/phGUvwojAfzVQjgI6voTOPwD3nLPdRr7HkKu2kwbr1c7YHHBIRhRhP1TGCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709678161; c=relaxed/simple;
	bh=WI1i+Vg/4OnoURbe4EGryHRT4EGzOTvFlqPo3SYK438=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=M/89zT7hY7jsktgl2Wp6Sqxn3QyG2fOKR7lwnPvuINYVFVQDYD+IMagZ7+0iudUN/RGuwMRvLFy3ED5f2fsQBVVuw5G+dJKcwooFIGvDVI0+SkcSAB1tjPNRTm8ojUi9cs9JBOV/Omv8kpUus5b1EAIc8Rwb3H6uytnaD13kmkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Q3Y+Ab0G; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709678159; x=1741214159;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=WI1i+Vg/4OnoURbe4EGryHRT4EGzOTvFlqPo3SYK438=;
  b=Q3Y+Ab0GkzbIGGC+v7zKo4kmhQJOiVwHzFaKbmBx2Tj7Pr34rahr+mvn
   OtVsiZtY49vu6RJm0dt+NKaxJMC2sFl/bcofGqMUYa4mudcCPeGbrTEDr
   vFmwpZO/joQpVxrjzvCxS9+jFIBodrded12Fm7+nyYdQJEFcIkLnCO8aY
   dgszXcwyA3kUmQt3Hxy5g+pxeFKziE2DncIKnF+G4OxiJZ0PXdX4gZxJB
   w/Ic/WvIeoSscsLCRScaKCDApj09zEUlZUapuQFVSs7DEgoBmFADXONV9
   fP216K2GiABhqTOPHw+erZBf1eDNW+/u6qGjHRauiJrTXGzXN13k+P3Ne
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11004"; a="4842149"
X-IronPort-AV: E=Sophos;i="6.06,206,1705392000"; 
   d="scan'208";a="4842149"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2024 14:35:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,206,1705392000"; 
   d="scan'208";a="9953445"
Received: from msavchak-mobl.amr.corp.intel.com (HELO [10.209.19.134]) ([10.209.19.134])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2024 14:35:58 -0800
Message-ID: <8aa0f7c3-0656-4c1b-94c3-cb0d056e84fe@linux.intel.com>
Date: Tue, 5 Mar 2024 14:35:57 -0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4] PCI/ASPM: Update saved buffers with latest ASPM
Content-Language: en-US
To: Bjorn Helgaas <helgaas@kernel.org>, Vidya Sagar <vidyas@nvidia.com>,
 "David E. Box" <david.e.box@linux.intel.com>
Cc: bhelgaas@google.com, macro@orcam.me.uk, ajayagarwal@google.com,
 ilpo.jarvinen@linux.intel.com, hkallweit1@gmail.com,
 johan+linaro@kernel.org, xueshuai@linux.alibaba.com,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, treding@nvidia.com,
 jonathanh@nvidia.com, kthota@nvidia.com, mmaddireddy@nvidia.com,
 sagar.tv@gmail.com
References: <20240305220342.GA552530@bhelgaas>
From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20240305220342.GA552530@bhelgaas>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 3/5/24 2:03 PM, Bjorn Helgaas wrote:
> [+to Sathy, David in case you want to update your Reviewed-by]
>
> On Thu, Feb 22, 2024 at 11:14:36PM +0530, Vidya Sagar wrote:
>> Many PCIe device drivers save the configuration state of their respective
>> devices during probe and restore the same when their 'slot_reset' hook
>> is called through PCIe Error Recovery Handler.
>>
>> If the system has a change in ASPM policy after the driver's probe is
>> called and before error event occurred, 'slot_reset' hook restores the
>> PCIe configuration state to what it was at the time of probe but not to
>> what it was just before the occurrence of the error event.
>> This effectively leads to a mismatch in the ASPM configuration between
>> the device and its upstream parent device.
>>
>> Update the saved configuration state of the device with the latest info
>> whenever there is a change w.r.t ASPM policy.
>>
>> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
>> -void pci_save_aspm_state(struct pci_dev *pdev);
>> +void pci_save_aspm_l1ss_state(struct pci_dev *pdev);
> I rebased this again on top of my pci/aspm updates to remove the need
> for the rename above.
>
>> +static void pci_save_aspm_state(struct pci_dev *dev)
>> +{
>> +	struct pci_cap_saved_state *save_state;
>> +	u16 *cap;
>> +
>> +	if (!pci_is_pcie(dev))
>> +		return;
>> +
>> +	save_state = pci_find_saved_cap(dev, PCI_CAP_ID_EXP);
>> +	if (!save_state)
>> +		return;
>> +
>> +	cap = (u16 *)&save_state->cap.data[0];
>> +	pcie_capability_read_word(dev, PCI_EXP_LNKCTL, &cap[1]);
> And I changed this part so it only updates the PCI_EXP_LNKCTL_ASPMC
> bits, not the entire LNKCTL.
>
> Updating the entire saved register probably wouldn't *break* anything,
> but it could randomly hide other LNKCTL changes depending on whether
> or not ASPM configuration was changed in the interim.  For example:
>
>   - driver .probe() saves LNKCTL
>   - LNKCTL changes some non-ASPMC thing via setpci or other mechanism
>   - save_state updated via pcie_config_aspm_link()
>
> A restore in .slot_reset() would restore different LNKCTL values for
> the non-ASPMC change depending on whether pcie_config_aspm_link() was
> used.
>
> I applied it on pci/aspm for v6.9.  Please take a look and make sure
> it still does what you need:
> https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git/commit/?h=aspm&id=a6315434436d587f70e489e6365c5b7e20176a71
>
> Sathy and David, I didn't add your Reviewed-by because I didn't want
> to presume that you were OK with my changes.  But I'd be more than
> happy to add them if you take a look.

Your update looks fine to me.

Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

>
> Bjorn
>
>> +}
>> +
>>  void pci_aspm_get_l1ss(struct pci_dev *pdev)
>>  {
>>  	/* Read L1 PM substate capabilities */
>>  	pdev->l1ss = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_L1SS);
>>  }
>>  
>> -void pci_save_aspm_state(struct pci_dev *pdev)
>> +void pci_save_aspm_l1ss_state(struct pci_dev *pdev)
>>  {
>>  	struct pci_cap_saved_state *save_state;
>>  	u16 l1ss = pdev->l1ss;
>> @@ -309,10 +325,12 @@ static void pcie_set_clkpm_nocheck(struct pcie_link_state *link, int enable)
>>  	struct pci_bus *linkbus = link->pdev->subordinate;
>>  	u32 val = enable ? PCI_EXP_LNKCTL_CLKREQ_EN : 0;
>>  
>> -	list_for_each_entry(child, &linkbus->devices, bus_list)
>> +	list_for_each_entry(child, &linkbus->devices, bus_list) {
>>  		pcie_capability_clear_and_set_word(child, PCI_EXP_LNKCTL,
>>  						   PCI_EXP_LNKCTL_CLKREQ_EN,
>>  						   val);
>> +		pci_save_aspm_state(child);
>> +	}
>>  	link->clkpm_enabled = !!enable;
>>  }
>>  
>> @@ -931,6 +949,12 @@ static void pcie_config_aspm_link(struct pcie_link_state *link, u32 state)
>>  		pcie_config_aspm_dev(parent, upstream);
>>  
>>  	link->aspm_enabled = state;
>> +
>> +	/* Update latest ASPM configuration in saved context */
>> +	pci_save_aspm_state(link->downstream);
>> +	pci_save_aspm_l1ss_state(link->downstream);
>> +	pci_save_aspm_state(parent);
>> +	pci_save_aspm_l1ss_state(parent);
>>  }
>>  
>>  static void pcie_config_aspm_path(struct pcie_link_state *link)
>> -- 
>> 2.25.1
>>
-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer


