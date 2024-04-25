Return-Path: <linux-pci+bounces-6658-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D66D78B1933
	for <lists+linux-pci@lfdr.de>; Thu, 25 Apr 2024 05:11:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 614DC1F22234
	for <lists+linux-pci@lfdr.de>; Thu, 25 Apr 2024 03:11:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C014171D8;
	Thu, 25 Apr 2024 03:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jJ5SRJxe"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DE9B29D02;
	Thu, 25 Apr 2024 03:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714014639; cv=none; b=qh3vtd3rujLj6VOA6fMqSayUHGZkSBr0yY5cwEA2CW8aiM/yux0w/Ma33NH/0I/tsikkWUwUubWzPSOJZIW9ZgrYRhR8s+IUPI5q3p1222bPDh2AzGX84QHMecv0fNwGORsBPpWDLBjekLfcF5sojfRHofwRVM3RL88zIyzSw9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714014639; c=relaxed/simple;
	bh=US31yN45Q9cD1WXpWnKekU/Go68lcMI7IvL0mpAxY7c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iOuIKDUv6U7Rlw5xNnL96XI8AcKx84bb/Pg+O65scUIgDc2T/VJgpGZHRaYhveeKMHeFbqMFwZyE/hwtni+COKP0cX6o/C5jB1z7m4DHlz2P3yRl8P4PasFI9xyvSc8qdBtB4bXDq1qd9+LK+aFHwyDojH2iy08VRTL7t1D/IYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jJ5SRJxe; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714014637; x=1745550637;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=US31yN45Q9cD1WXpWnKekU/Go68lcMI7IvL0mpAxY7c=;
  b=jJ5SRJxeyDivrrB7bb+DE0zFSpq5AaecDMFrvay1H5g/QxRDqcKLuYN8
   Cpve6z5PyLCQ3mfjC8TzZxiVJ1PUgjPrzpO8xYwVo/mClcpPwMYt5RWgi
   2my6+EtB/PS85uWBy/k0aU9s2vZebHhN3WdyoiwOaqcSV02SfIeZznGYz
   L4UVsj8M9pRaFJmpk/eo+pM8M5ZdmNXVqWvlJJq938qxQ6cnKquGjgpit
   oPHotuXPaBUYAhCC5as6Thm9/T3UNn3C/IW4RHdDPrYg8G4xGMwtsYjcb
   oQvP14LnpfIUnUD4yeOGZiFU4MYxXQ7ushR9Quz2robZjBuu5N7Axa98v
   A==;
X-CSE-ConnectionGUID: 6OmZctslS8OHXPnJEn6jPw==
X-CSE-MsgGUID: B1dgNpEuRdqLpyRClWCNDQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11054"; a="21089686"
X-IronPort-AV: E=Sophos;i="6.07,228,1708416000"; 
   d="scan'208";a="21089686"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2024 20:10:36 -0700
X-CSE-ConnectionGUID: Ubwyc+c1TNepxLSkrw5q+A==
X-CSE-MsgGUID: RGNCJOumQKOq23kV0ze0tQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,228,1708416000"; 
   d="scan'208";a="29712416"
Received: from asbhurke-mobl.amr.corp.intel.com (HELO [10.212.156.26]) ([10.212.156.26])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2024 20:10:36 -0700
Message-ID: <2f6e5a44-e64d-4801-96ff-c99cf034ebdf@linux.intel.com>
Date: Wed, 24 Apr 2024 20:10:35 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI: pciehp: Clear LBMS on hot-remove to prevent link
 speed reduction
To: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Bjorn Helgaas <helgaas@kernel.org>,
 Mahesh J Salgaonkar <mahesh@linux.ibm.com>, Lukas Wunner <lukas@wunner.de>,
 Yazen Ghannam <yazen.ghannam@amd.com>,
 Ilpo Jarvinen <ilpo.jarvinen@linux.intel.com>,
 Bowman Terry <terry.bowman@amd.com>, Hagan Billy <billy.hagan@amd.com>,
 Simon Guinot <simon.guinot@seagate.com>,
 "Maciej W . Rozycki" <macro@orcam.me.uk>
References: <20240424033339.250385-1-Smita.KoralahalliChannabasappa@amd.com>
Content-Language: en-US
From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20240424033339.250385-1-Smita.KoralahalliChannabasappa@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 4/23/24 8:33 PM, Smita Koralahalli wrote:
> Clear Link Bandwidth Management Status (LBMS) if set, on a hot-remove event.
>
> The hot-remove event could result in target link speed reduction if LBMS
> is set, due to a delay in Presence Detect State Change (PDSC) happening
> after a Data Link Layer State Change event (DLLSC).

What is the actual impact? Since this happens during hot-remove,
and there is no device, the link retrain will fail, right?

>
> In reality, PDSC and DLLSC events rarely come in simultaneously. Delay in
> PDSC can sometimes be too late and the slot could have already been
> powered down just by a DLLSC event. And the delayed PDSC could falsely be
> interpreted as an interrupt raised to turn the slot on. This false process
> of powering the slot on, without a link forces the kernel to retrain the
> link if LBMS is set, to a lower speed to restablish the link thereby
> bringing down the link speeds [2].
>
> According to PCIe r6.2 sec 7.5.3.8 [1], it is derived that, LBMS cannot
> be set for an unconnected link and if set, it serves the purpose of

I did not find this detail in the spec. Can you copy paste the lines
in the spec that mentions the case where it cannot set in an
unconnected link? All I see are the cases where it can be set.

> indicating that there is actually a device down an inactive link.
> However, hardware could have already set LBMS when the device was
> connected to the port i.e when the state was DL_Up or DL_Active. Some

Isn't LBMS only set during DL_Down transition ? Why would it be
set during DL_Up?

> hardwares would have even attempted retrain going into recovery mode,
> just before transitioning to DL_Down.
>
> Thus the set LBMS is never cleared and might force software to cause link
> speed drops when there is no link [2].
>
> Dmesg before:
> 	pcieport 0000:20:01.1: pciehp: Slot(59): Link Down
> 	pcieport 0000:20:01.1: pciehp: Slot(59): Card present
> 	pcieport 0000:20:01.1: broken device, retraining non-functional downstream link at 2.5GT/s
> 	pcieport 0000:20:01.1: retraining failed
> 	pcieport 0000:20:01.1: pciehp: Slot(59): No link
>
> Dmesg after:
> 	pcieport 0000:20:01.1: pciehp: Slot(59): Link Down
> 	pcieport 0000:20:01.1: pciehp: Slot(59): Card present
> 	pcieport 0000:20:01.1: pciehp: Slot(59): No link
>
> [1] PCI Express Base Specification Revision 6.2, Jan 25 2024.
>     https://members.pcisig.com/wg/PCI-SIG/document/20590
> [2] Commit a89c82249c37 ("PCI: Work around PCIe link training failures")
>
> Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
> ---
> 1. Should be based on top of fixes for link retrain status in
> pcie_wait_for_link_delay()
> https://patchwork.kernel.org/project/linux-pci/list/?series=824858
> https://lore.kernel.org/linux-pci/53b2239b-4a23-a948-a422-4005cbf76148@linux.intel.com/
>
> Without the fixes patch output would be:
> 	pcieport 0000:20:01.1: pciehp: Slot(59): Link Down
> 	pcieport 0000:20:01.1: pciehp: Slot(59): Card present
> 	pcieport 0000:20:01.1: broken device, retraining non-functional downstream link at 2.5GT/s
> 	pcieport 0000:20:01.1: retraining failed
> 	pcieport 0000:20:01.1: pciehp: Slot(59): No device found.
>
> 2. I initially attempted to wait for both events PDSC and DLLSC to happen
> and then turn on the slot.
> Similar to: https://lore.kernel.org/lkml/20190205210701.25387-1-mr.nuke.me@gmail.com/
> but before turning on the slot.
>
> Something like:
> -		ctrl->state = POWERON_STATE;
> -		mutex_unlock(&ctrl->state_lock);
> -		if (present)
> +		if (present && link_active) {
> +			ctrl->state = POWERON_STATE;
> +			mutex_unlock(&ctrl->state_lock);
> 			ctrl_info(ctrl, "Slot(%s): Card present\n",
> 				  slot_name(ctrl));
> -		if (link_active)
> 			ctrl_info(ctrl, "Slot(%s): Link Up\n",
> 				  slot_name(ctrl));
> -		ctrl->request_result = pciehp_enable_slot(ctrl);
> -		break;
> +			ctrl->request_result = pciehp_enable_slot(ctrl);
> +			break;
> +		}
> +		else {
> +			mutex_unlock(&ctrl->state_lock);
> +			break;
> +		}
>
> This would also avoid printing the lines below on a remove event.
> pcieport 0000:20:01.1: pciehp: Slot(59): Card present
> pcieport 0000:20:01.1: pciehp: Slot(59): No link
>
> I understand this would likely be not applicable in places where broken
> devices hardwire PDS to zero and PDSC would never happen. But I'm open to
> making changes if this is more applicable. Because, SW cannot directly
> track the interference of HW in attempting link retrain and setting LBMS.
>
> 3. I tried introducing delay similar to pcie_wait_for_presence() but I
> was not successful in picking the right numbers. Hence hit with the same
> link speed drop.
>
> 4. For some reason I was unable to clear LBMS with:
> 	pcie_capability_clear_word(ctrl->pcie->port, PCI_EXP_LNKSTA,
> 				   PCI_EXP_LNKSTA_LBMS);
> ---
>  drivers/pci/hotplug/pciehp_pci.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/pci/hotplug/pciehp_pci.c b/drivers/pci/hotplug/pciehp_pci.c
> index ad12515a4a12..9155fdfd1d37 100644
> --- a/drivers/pci/hotplug/pciehp_pci.c
> +++ b/drivers/pci/hotplug/pciehp_pci.c
> @@ -92,7 +92,7 @@ void pciehp_unconfigure_device(struct controller *ctrl, bool presence)
>  {
>  	struct pci_dev *dev, *temp;
>  	struct pci_bus *parent = ctrl->pcie->port->subordinate;
> -	u16 command;
> +	u16 command, lnksta;
>  
>  	ctrl_dbg(ctrl, "%s: domain:bus:dev = %04x:%02x:00\n",
>  		 __func__, pci_domain_nr(parent), parent->number);
> @@ -134,4 +134,10 @@ void pciehp_unconfigure_device(struct controller *ctrl, bool presence)
>  	}
>  
>  	pci_unlock_rescan_remove();
> +
> +	/* Clear LBMS on removal */
> +	pcie_capability_read_word(ctrl->pcie->port, PCI_EXP_LNKSTA, &lnksta);
> +	if (lnksta & PCI_EXP_LNKSTA_LBMS)
> +		pcie_capability_write_word(ctrl->pcie->port, PCI_EXP_LNKSTA,
> +					   PCI_EXP_LNKSTA_LBMS);
>  }

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer


