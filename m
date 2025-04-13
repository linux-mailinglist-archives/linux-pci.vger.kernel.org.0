Return-Path: <linux-pci+bounces-25746-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B95BA872EE
	for <lists+linux-pci@lfdr.de>; Sun, 13 Apr 2025 19:22:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 82DBD1891EAD
	for <lists+linux-pci@lfdr.de>; Sun, 13 Apr 2025 17:22:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49DBA1F0E5D;
	Sun, 13 Apr 2025 17:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="J7KGoahU"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DC2C1F03EE;
	Sun, 13 Apr 2025 17:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744564921; cv=none; b=THfXSRAeWq30r/CROdGnsNG2kJD9jsUOHIjLa14eW2d1jErwEk7nsw6pajrSkx8/FyETqP768oQg3JB+yjfn0Lk5dBSvdXK8KYeoGI8o4gddEP1qZbxZwa7MIWUWHaFKpZStAz0zmzlnHBHFsE3ZO43LfyBWyFCITwdqmVGgooI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744564921; c=relaxed/simple;
	bh=+Sh5cQeQtH2NcUNxMCOy285PDoUIbix7RWnsVlZYC+E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lxRbGTGHmCD72ikkkZJO/63fYa6D8gBKPHNVkHg+Qe57xvsW+CYKOvcGxhk/JbSNcGhsnZShPwk+CGG3dqFbjghbCXOe5a6H0NtVRWSStZ6h3+mr9injWXCd18Xax/I9xjjV67g9UBYYKmuMRRawzKpYBuvpPtYQ/C7Lm2ckuHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=J7KGoahU; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744564919; x=1776100919;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=+Sh5cQeQtH2NcUNxMCOy285PDoUIbix7RWnsVlZYC+E=;
  b=J7KGoahUUFAmuy88r47R/H0xQAMXpzWAa/AKJ/qG60B5kuPqYQlTSiiW
   H5NZYqKsgEbIQj1qevdoF9YIe6yPisWObsSxVx3o8CM5WHlwy43S2Ulg7
   rUjV5EyTI4J1UWvqYse2DPlVVtgVlYdC2bJ00/6wOGTPGhlu0qCV8PujF
   K6SAb7ghf242uyLo7W+bhDK7p8XEWoQm5Hr3QvD4bQ5j6RRcDr8qpQX/2
   Edc0MQhbYClf7gQvJNnmMhyV/mkjioy0sMGOFmXlVWzBD6iHCOnbDLSxE
   m+n8OLqDJdc7t/9yNzAjA2dMLS1U+OMavBGPl3DG7s5gKrZm5re7vtWYD
   w==;
X-CSE-ConnectionGUID: PvJoj6r+SjeztRptjNkrzw==
X-CSE-MsgGUID: TO0Ngy6/RvqR4BPHgeVD+A==
X-IronPort-AV: E=McAfee;i="6700,10204,11402"; a="48740118"
X-IronPort-AV: E=Sophos;i="6.15,210,1739865600"; 
   d="scan'208";a="48740118"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2025 10:21:58 -0700
X-CSE-ConnectionGUID: aD26W1leTkaWxRq58H8+TQ==
X-CSE-MsgGUID: +oaNn1mvQPGGWWsdHy5AZA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,210,1739865600"; 
   d="scan'208";a="129625052"
Received: from jairdeje-mobl1.amr.corp.intel.com (HELO [10.124.222.10]) ([10.124.222.10])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2025 10:21:58 -0700
Message-ID: <5e628372-5cf5-43e6-897e-166b7666e4ed@linux.intel.com>
Date: Sun, 13 Apr 2025 10:21:57 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] PCI: pciehp: Ignore Link Down/Up caused by Secondary
 Bus Reset
To: Lukas Wunner <lukas@wunner.de>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Keith Busch <kbusch@kernel.org>,
 Yicong Yang <yangyicong@hisilicon.com>, linux-pci@vger.kernel.org,
 Stuart Hayes <stuart.w.hayes@gmail.com>,
 Mika Westerberg <mika.westerberg@linux.intel.com>,
 Ilpo Jarvinen <ilpo.jarvinen@linux.intel.com>,
 Joel Mathew Thomas <proxy0@tutamail.com>, Russ Weight
 <russ.weight@linux.dev>, Matthew Gerlach <matthew.gerlach@altera.com>,
 Yilun Xu <yilun.xu@intel.com>, linux-fpga@vger.kernel.org,
 Moshe Shemesh <moshe@nvidia.com>, Shay Drory <shayd@nvidia.com>,
 Saeed Mahameed <saeedm@nvidia.com>,
 Alex Williamson <alex.williamson@redhat.com>
References: <cover.1744298239.git.lukas@wunner.de>
 <d04deaf49d634a2edf42bf3c06ed81b4ca54d17b.1744298239.git.lukas@wunner.de>
 <3e12d065-77b1-49f0-9ee7-32b49c3ab9ef@linux.intel.com>
 <Z_nfuGrVh_CO7vbe@wunner.de>
Content-Language: en-US
From: Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <Z_nfuGrVh_CO7vbe@wunner.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 4/11/25 8:36 PM, Lukas Wunner wrote:
> On Fri, Apr 11, 2025 at 03:28:15PM -0700, Sathyanarayanan Kuppuswamy wrote:
>> On 4/10/25 8:27 AM, Lukas Wunner wrote:
>>> Introduce two helpers to annotate code sections which cause spurious link
>>> changes:  pci_hp_ignore_link_change() and pci_hp_unignore_link_change()
>>> Use those helpers in lieu of masking interrupts in the Slot Control
>>> register.
>>>
>>> Introduce a helper to check whether such a code section is executing
>>> concurrently and if so, await it:  pci_hp_spurious_link_change()
>>> Invoke the helper in the hotplug IRQ thread pciehp_ist().  Re-use the
>>> IRQ thread's existing code which ignores DPC-induced link changes unless
>>> the link is unexpectedly down after reset recovery or the device was
>>> replaced during the bus reset.
>> Since most of the changes in this patch is related to adding framework to
>> ignore spurious hotplug event, why not split it in to a separate patch?
> The idea is to ease backporting.  The issue fixes VFIO passthrough on
> v6.13-rc1 and newer, so the patch will have to be backported at least
> to v6.13, v6.14, v6.15.

Makes sense.

>
>> Is this fix tested in any platform?
> Yes, Joel Mathew Thomas successfully tested it:
>
> https://bugzilla.kernel.org/show_bug.cgi?id=219765
>
> That's an Asus TUF FA507NU dual-GPU laptop (AMD CPU + Nvidia discrete GPU).
> The Nvidia GPU is passed through to a VM.
>
>
>>> --- a/drivers/pci/pci.h
>>> +++ b/drivers/pci/pci.h
>>> @@ -227,6 +227,7 @@ static inline bool pcie_downstream_port(const struct pci_dev *dev)
>>>    /* Functions for PCI Hotplug drivers to use */
>>>    int pci_hp_add_bridge(struct pci_dev *dev);
>>> +bool pci_hp_spurious_link_change(struct pci_dev *pdev);
>> Do you expect this function used outside hotplug code? If not why not leave
>> the declaration in pciehp.h?
> Any hotplug driver may call this.  In particular, there are two other drivers
> implementing the ->reset_slot() callback: pnv_php.c and s390_pci_hpc.c
>
> pnv_php.c does a similar dance as pciehp_hpc.c (before this patch):
> It disables the interrupt, performs a Secondary Bus Reset, clears spurious
> events and re-enables the interrupt.  I think it can be converted to use
> the newly introduced API.  That should make it more robust against removal
> or replacement of the device during the Secondary Bus Reset.
>
> Also, to cope with runtime suspend to D3cold, there's an ignore_hotplug
> bit in struct pci_dev.  The bit is set by drivers for discrete GPUs and
> is honored by acpiphp and pciehp.  I'd like to remove the bit in favor
> of the new mechanism introduced here and that means acpiphp will have to
> be converted to call pci_hp_spurious_link_change().
>
> One thing that's problematic about the current behavior is that hotplug
> events are ignored wholesale for GPUs which runtime suspend to D3cold.
> That works for discrete GPUs in laptops which are soldered down on the
> mainboard, but doesn't work for GPUs which are plugged into an actual
> hotplug port, e.g. data center GPUs.  The new API will allow detecting
> and ignoring spurious events in a more surgical manner.  I envision
> that __pci_set_power_state() will call pci_hp_ignore_link_change()
> if the target power state is D3cold.  Also vga_switcheroo.c will have
> to call that.  But none of the GPU drivers will have to call
> pci_ignore_hotplug() anymore.
>
> To summarize, there are at least two other hotplug drivers besides pciehp
> which I expect will call pci_hp_spurious_link_change() in the foreseeable
> future, acpiphp and pnv_php, hence the declaration is not in pciehp.h
> but in drivers/pci/pci.h.

Thanks for sharing the details.

>
>>> --- a/include/linux/pci.h
>>> +++ b/include/linux/pci.h
>>> @@ -1848,6 +1848,14 @@ static inline void pcie_no_aspm(void) { }
>>>    static inline bool pcie_aspm_enabled(struct pci_dev *pdev) { return false; }
>>>    #endif
>>> +#ifdef CONFIG_HOTPLUG_PCI
>>> +void pci_hp_ignore_link_change(struct pci_dev *pdev);
>>> +void pci_hp_unignore_link_change(struct pci_dev *pdev);
>>> +#else
>>> +static inline void pci_hp_ignore_link_change(struct pci_dev *pdev) { }
>>> +static inline void pci_hp_unignore_link_change(struct pci_dev *pdev) { }
>>> +#endif
>>> +
>> Generally we expose APIs when we really need it.  Since you have already
>> identified some use cases where you will use it in other drivers, why not
>> include one such change as an example?
> Mostly because I wanted to get this fix out the door quickly before more
> people come across the regression it addresses.
>
> Converting the Mellanox Ethernet driver to use the API would require an ack
> from its maintainers.  Since it's not urgent, I was planning to do that in
> a subsequent cycle.  Same for the conversion of D3cold handling.


Got it.


>
> Thanks,
>
> Lukas
>
-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer


