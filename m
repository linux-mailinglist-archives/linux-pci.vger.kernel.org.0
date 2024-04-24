Return-Path: <linux-pci+bounces-6612-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 431AE8B0617
	for <lists+linux-pci@lfdr.de>; Wed, 24 Apr 2024 11:32:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6CEF41C22AF4
	for <lists+linux-pci@lfdr.de>; Wed, 24 Apr 2024 09:32:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B5E8158D98;
	Wed, 24 Apr 2024 09:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UWpiYij3"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9272D1EF1A;
	Wed, 24 Apr 2024 09:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713951169; cv=none; b=iYEEadptpD6vJvOj77Pn5NQ0ibm2/w++O1hRbtuRF0FO2yRdNct+ysqC/mDVjVpB07i08b47OkA9w/gDxtqmqtmwsIKExJPuD0MFF/aQ3pnq0Q5WL8PaIPxMByVKztpGfUMpmcyeJhtXXtQv8M2ei/2AgZRUEw5PBfbAIsdKWt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713951169; c=relaxed/simple;
	bh=odLCeXV/7pBP8vRHrz9jbJlhc8urXDK1R3TAXp+bME0=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=BRXiXTPfxkmZRHCaPQ+KAe7iEnNpSf5Xo4EdIAO5LhCJLEANVF6Z75GSrbfPybC/cQjclSrJbMjUHNlLe+0ipF67ZB5/PF50PZ/Y9H8xCPZ7oA6nBtBQmMx07rVsUb56pIkBLeiRswgMG82mxb36jqKFC0fmzaKZa3Gi2L/zl/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UWpiYij3; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713951168; x=1745487168;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=odLCeXV/7pBP8vRHrz9jbJlhc8urXDK1R3TAXp+bME0=;
  b=UWpiYij31oNeUXiVNFPFvtB2c5QqZvH77tYC44rURL8rUGL/mIREaD9s
   bLJ9rlzcjt5XHYYxlSsTOGuhjUWmpRF6wa8dxcULweycI4wrUqMUR2p8n
   WysrlRR/D3d24i6UYnKwyxXTB+RmDWbvChP7i9w0doEco02huumJdffaV
   mV5/i4d+A3qfKEA4f3tXjDxg2LMGi6pE0Gx7QXq5kBaqHYwAFvsJtr/xj
   s7Lqt8R+FQnr5+big1vfwtIZ3YCTCs2ed6yXhIfz7nuDe6G32DmOlIWsu
   1Xk8RS3OdBPEab4jWW6Ha/tbSQKUUWvWN/YL5rmx2xW8P/kqBIEI79iS5
   Q==;
X-CSE-ConnectionGUID: xY7vXIJAQzC+bsrUtGxXMA==
X-CSE-MsgGUID: WwS+QIxOQnKbDzVXdwqw6Q==
X-IronPort-AV: E=McAfee;i="6600,9927,11053"; a="20266894"
X-IronPort-AV: E=Sophos;i="6.07,225,1708416000"; 
   d="scan'208";a="20266894"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2024 02:32:46 -0700
X-CSE-ConnectionGUID: 1IlfOP5SSgKRTdVfu3HG8A==
X-CSE-MsgGUID: 3htIX186StqgyE5VNjzD0g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,225,1708416000"; 
   d="scan'208";a="47910954"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.41])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2024 02:32:42 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Wed, 24 Apr 2024 12:32:36 +0300 (EEST)
To: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
cc: linux-pci@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, 
    Bjorn Helgaas <helgaas@kernel.org>, 
    Mahesh J Salgaonkar <mahesh@linux.ibm.com>, Lukas Wunner <lukas@wunner.de>, 
    Yazen Ghannam <yazen.ghannam@amd.com>, Bowman Terry <terry.bowman@amd.com>, 
    Hagan Billy <billy.hagan@amd.com>, Simon Guinot <simon.guinot@seagate.com>, 
    "Maciej W . Rozycki" <macro@orcam.me.uk>, 
    Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Subject: Re: [PATCH] PCI: pciehp: Clear LBMS on hot-remove to prevent link
 speed reduction
In-Reply-To: <20240424033339.250385-1-Smita.KoralahalliChannabasappa@amd.com>
Message-ID: <52290bb0-97bc-aa52-6606-cc734a492cc1@linux.intel.com>
References: <20240424033339.250385-1-Smita.KoralahalliChannabasappa@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Wed, 24 Apr 2024, Smita Koralahalli wrote:

> Clear Link Bandwidth Management Status (LBMS) if set, on a hot-remove event.
> 
> The hot-remove event could result in target link speed reduction if LBMS
> is set, due to a delay in Presence Detect State Change (PDSC) happening
> after a Data Link Layer State Change event (DLLSC).
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
> indicating that there is actually a device down an inactive link.
> However, hardware could have already set LBMS when the device was
> connected to the port i.e when the state was DL_Up or DL_Active. Some
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

Did you hit the 60 sec delay issue without series 824858? If you've tested 
them and the fixes helped your case, could you perhaps give Tested-by for 
that series too (in the relevant thread)?

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

LBMS is write-1-to-clear, pcie_capability_clear_word() tries to write 0 
there (the accessor doesn't do what you seem to expect, it clears normal 
bits, not write-1-to-clear bits).

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

It's enough to unconditionally write PCI_EXP_LNKSTA_LBMS, no need to 
check first. The comment is just spelling out what can already be read 
from the code so I'd drop the comment.

I agree it makes sense to clear the LBMS when device is removed.

-- 
 i.


