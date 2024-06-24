Return-Path: <linux-pci+bounces-9196-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E0C491522A
	for <lists+linux-pci@lfdr.de>; Mon, 24 Jun 2024 17:25:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 30C361C21435
	for <lists+linux-pci@lfdr.de>; Mon, 24 Jun 2024 15:25:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C04919B59C;
	Mon, 24 Jun 2024 15:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fxlB3Z1F"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8179913DDD3;
	Mon, 24 Jun 2024 15:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719242703; cv=none; b=UjKWyf/s21NVUnPT1H8Hqr89tYianbHF7Jht3so+dLOnR4FNn2QwdgD088254D+tW0cG4Zn6BfkRdPsV2HGItKYqlT5z4hYO9N7UArk46ip0KnJP6/oVjAJz9phH6/O6MaGcvcQkzrK5XnO7ASiLWNFN1Z1z+Apvv0zTvrjpYYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719242703; c=relaxed/simple;
	bh=1Ws/Ed6y5L8GYmrcA/MoHh7GVRGBZ0KCtTP4feV7btw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LSX/11wZLpB/GL2uCQOJp2S9VuFTnG1vncCaSUWbluRrn1p+R1Uk0llRDr2qpYW+qacpL/QGDmMA2l+jA70cYo28Fxc4oFuo/QouPNu2cP86V1fXUKwqY7YIyQYBGZrlE9FIInYKkZAJsQLjkwrjciNlqhAz7ZYvyPbX4UHQFtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fxlB3Z1F; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719242701; x=1750778701;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1Ws/Ed6y5L8GYmrcA/MoHh7GVRGBZ0KCtTP4feV7btw=;
  b=fxlB3Z1F5J69brbZLpE61Ls6Vcs7ME4tl/TibZ03iT5ZEOoeAsfEtNVr
   VjAWU7IoAagTa1TvYLDuRMGVH7mzqCWL2IOVcdrmqXquXjvAIoIgzPrFk
   hgasuaLlrX7KClBGvVVku+LV7qMxnEL6YZ1piFiZe4bXFdPsykhh1oqoT
   ZkSPc7vdWqrUm4SWSCICjySrUmPV8xsvhGNEkppJnbWK0ZYgQIvyMtkCJ
   n7oCKPQF5lOcyeu8eOJWVhlhvY7TWE3u+Yq3PyATQ0CH0w7ZPwF6T7pHt
   NlLudrIBgfN65i0Q0LvWmFefHO6TElLzFOZFnScXfgo7rzio+3/KIeJaJ
   w==;
X-CSE-ConnectionGUID: 1SkxRThJRSu3vX2rWSINhg==
X-CSE-MsgGUID: qrktJfgoTXSEsC0QURVthw==
X-IronPort-AV: E=McAfee;i="6700,10204,11113"; a="19121354"
X-IronPort-AV: E=Sophos;i="6.08,262,1712646000"; 
   d="scan'208";a="19121354"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2024 08:25:01 -0700
X-CSE-ConnectionGUID: I7G4voT4R0CTzwYa5RiMRw==
X-CSE-MsgGUID: I0XnPKvoQiqlwB7fPIseEw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,262,1712646000"; 
   d="scan'208";a="47781455"
Received: from patelni-mobl1.amr.corp.intel.com (HELO localhost) ([10.124.49.93])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2024 08:24:59 -0700
Date: Mon, 24 Jun 2024 08:24:58 -0700
From: Nirmal Patel <nirmal.patel@linux.intel.com>
To: Jian-Hong Pan <jhp@endlessos.org>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Francisco Munoz
 <francisco.munoz.ruiz@linux.intel.com>, Johan Hovold <johan@kernel.org>,
 David Box <david.e.box@linux.intel.com>, Ilpo =?ISO-8859-1?Q?J=E4rvinen?=
 <ilpo.jarvinen@linux.intel.com>, Kuppuswamy Sathyanarayanan
 <sathyanarayanan.kuppuswamy@linux.intel.com>, Mika Westerberg
 <mika.westerberg@linux.intel.com>, Damien Le Moal <dlemoal@kernel.org>,
 Jonathan Derrick <jonathan.derrick@linux.dev>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux@endlessos.org, Paul M Stillwell Jr
 <paul.m.stillwell.jr@intel.com>
Subject: Re: [PATCH v6 3/3] PCI: vmd: Drop resetting PCI bus action after
 scan mapped PCI child bus
Message-ID: <20240624082458.00006da1@linux.intel.com>
In-Reply-To: <20240624082144.10265-2-jhp@endlessos.org>
References: <20240624081108.10143-2-jhp@endlessos.org>
	<20240624082144.10265-2-jhp@endlessos.org>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.38; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 24 Jun 2024 16:21:45 +0800
Jian-Hong Pan <jhp@endlessos.org> wrote:

> According to "PCIe r6.0, sec 5.5.4", before enabling ASPM L1.2 on the
> PCIe Root Port and the child device, they should be programmed with
> the same LTR1.2_Threshold value. However, they have different values
> on VMD mapped PCI child bus. For example, Asus B1400CEAE's VMD mapped
> PCI bridge and NVMe SSD controller have different LTR1.2_Threshold
> values:
> 
> 10000:e0:06.0 PCI bridge: Intel Corporation 11th Gen Core Processor
> PCIe Controller (rev 01) (prog-if 00 [Normal decode]) ...
>     Capabilities: [200 v1] L1 PM Substates
>         L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+
> L1_PM_Substates+ PortCommonModeRestoreTime=45us PortTPowerOnTime=50us
>         L1SubCtl1: PCI-PM_L1.2- PCI-PM_L1.1- ASPM_L1.2+ ASPM_L1.1-
>         	   T_CommonMode=45us LTR1.2_Threshold=101376ns
>         L1SubCtl2: T_PwrOn=50us
> 
> 10000:e1:00.0 Non-Volatile memory controller: Sandisk Corp WD Blue
> SN550 NVMe SSD (rev 01) (prog-if 02 [NVM Express]) ...
>     Capabilities: [900 v1] L1 PM Substates
>         L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1- ASPM_L1.2+ ASPM_L1.1-
> L1_PM_Substates+ PortCommonModeRestoreTime=32us PortTPowerOnTime=10us
>         L1SubCtl1: PCI-PM_L1.2- PCI-PM_L1.1- ASPM_L1.2+ ASPM_L1.1-
>                    T_CommonMode=0us LTR1.2_Threshold=0ns
>         L1SubCtl2: T_PwrOn=10us
> 
> After debug in detail, both of the VMD mapped PCI bridge and the NVMe
> SSD controller have been configured properly with the same
> LTR1.2_Threshold value. But, become misconfigured after reset the VMD
> mapped PCI bus which is introduced from commit 0a584655ef89 ("PCI:
> vmd: Fix secondary bus reset for Intel bridges") and commit
> 6aab5622296b ("PCI: vmd: Clean up domain before enumeration"). So,
> drop the resetting PCI bus action after scan VMD mapped PCI child bus.
> 
> Signed-off-by: Jian-Hong Pan <jhp@endlessos.org>
> ---
> v6:
> - Introduced based on the discussion
> https://lore.kernel.org/linux-pci/CAPpJ_efYWWxGBopbSQHB=Y2+1RrXFR2XWeqEhGTgdiw3XX0Jmw@mail.gmail.com/ 
> 
>  drivers/pci/controller/vmd.c | 20 --------------------
>  1 file changed, 20 deletions(-)
> 
> diff --git a/drivers/pci/controller/vmd.c
> b/drivers/pci/controller/vmd.c index 5309afbe31f9..af413cdb4f4e 100644
> --- a/drivers/pci/controller/vmd.c
> +++ b/drivers/pci/controller/vmd.c
> @@ -793,7 +793,6 @@ static int vmd_enable_domain(struct vmd_dev *vmd,
> unsigned long features) resource_size_t offset[2] = {0};
>  	resource_size_t membar2_offset = 0x2000;
>  	struct pci_bus *child;
> -	struct pci_dev *dev;
>  	int ret;
>  
>  	/*
> @@ -935,25 +934,6 @@ static int vmd_enable_domain(struct vmd_dev
> *vmd, unsigned long features) pci_scan_child_bus(vmd->bus);
>  	vmd_domain_reset(vmd);
>  
> -	/* When Intel VMD is enabled, the OS does not discover the
> Root Ports
> -	 * owned by Intel VMD within the MMCFG space.
> pci_reset_bus() applies
> -	 * a reset to the parent of the PCI device supplied as
> argument. This
> -	 * is why we pass a child device, so the reset can be
> triggered at
> -	 * the Intel bridge level and propagated to all the children
> in the
> -	 * hierarchy.
> -	 */
> -	list_for_each_entry(child, &vmd->bus->children, node) {
> -		if (!list_empty(&child->devices)) {
> -			dev = list_first_entry(&child->devices,
> -					       struct pci_dev,
> bus_list);
> -			ret = pci_reset_bus(dev);
> -			if (ret)
> -				pci_warn(dev, "can't reset device:
> %d\n", ret); -
> -			break;
> -		}
> -	}
> -
>  	pci_assign_unassigned_bus_resources(vmd->bus);
>  
>  	pci_walk_bus(vmd->bus, vmd_pm_enable_quirk, &features);

Thanks for the patch.

pci_reset_bus is required to avoid failure in vmd domain creation
during multiple soft reboots test. So I believe we can't just remove
it without proper testing. vmd_pm_enable_quirk happens after
pci_reset_bus, then how is it resetting LTR1.2_Threshold value?

Thanks
-nirmal

