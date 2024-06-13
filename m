Return-Path: <linux-pci+bounces-8761-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E343D907E1B
	for <lists+linux-pci@lfdr.de>; Thu, 13 Jun 2024 23:26:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74D0D2823C6
	for <lists+linux-pci@lfdr.de>; Thu, 13 Jun 2024 21:26:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76BDD13DDAB;
	Thu, 13 Jun 2024 21:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Zw56GY+4"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4AB85F876;
	Thu, 13 Jun 2024 21:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718314007; cv=none; b=Yr4yUrsqu/dz4rn92VLCuuSsAxCJFmdU3O65C7hLsFZ3LMb+JH6RlpLXBPqUZp2KmG7l2UGnG2NV359L4yOuMEjJdfa1DEccz1SceWlrBzghWpPtBlMvWRrESF8NLYRjZFjLviW5PZ4kYirDqAl6khHkADVFombJ/raxn15tU0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718314007; c=relaxed/simple;
	bh=/dsgC1O4XfHN86562SNESM1KB8oXQGHcFgFn21xIy6w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=udaX7U5iWYWTZVbvAB9ZwOC4zgAOxbLc7oqMil5coGLJhYGVJqVMSTOeSI0YSfZH7fXBgEHy9N48a33QFiuLvQQOZkk2Q3D+DGH9rOxxJmxu/Cu91czr6CzIG0ybbnp8UJxSITeWCrdCSOoiO94nKEHMv072Kcvf56WBpriASXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Zw56GY+4; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718314006; x=1749850006;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=/dsgC1O4XfHN86562SNESM1KB8oXQGHcFgFn21xIy6w=;
  b=Zw56GY+4TfTDsYHxFF6BZ/GNfvrUaXiTE/MyceL658O05tb7Im3Xdspj
   fVWs9H7ad7EQ+YNiAfIU+SUNnp/xZOgbPcZ6c2VgN6ueOmGxw+K0kCtY4
   gpwE39iNLOQAyZhrwCMTg2eGJbsPpni+yY+qTKc19uhs0zuJ9KYnCT40F
   c5EllXEuhqEi83l36w/VabaaMdM11aduw5DTdC7Kn3jYjhgIOKpgsGBhG
   QBRlwtiaV6jIEYliM9GKsuTtRwlspBteoRpaV2cdSqPqJ5HB2M+yOYjFH
   9qyNtp9S70eK47vaZKu27zqWLvPnn+TpYKBeDd/Mdar1fChOXRsXiZtOy
   g==;
X-CSE-ConnectionGUID: ajFQ1uxERhyzpIDd/66WlQ==
X-CSE-MsgGUID: hxU0tIJpR/W53ksDxJWJxw==
X-IronPort-AV: E=McAfee;i="6700,10204,11102"; a="18958801"
X-IronPort-AV: E=Sophos;i="6.08,236,1712646000"; 
   d="scan'208";a="18958801"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2024 14:26:45 -0700
X-CSE-ConnectionGUID: 4F0zvwCORKmPCpXRfr0cEg==
X-CSE-MsgGUID: rDaE7UXYTeGHIIuzz9pTTw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,236,1712646000"; 
   d="scan'208";a="71070869"
Received: from sramkris-mobl1.amr.corp.intel.com (HELO [10.124.223.37]) ([10.124.223.37])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2024 14:26:43 -0700
Message-ID: <53a3795b-4ccd-458e-88cd-d510031bc6b6@linux.intel.com>
Date: Thu, 13 Jun 2024 14:26:42 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/3] PCI/AER: Store UNCOR_STATUS bits that might be
 ANFE in aer_err_info
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, linux-pci@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org, linux-acpi@vger.kernel.org,
 rafael@kernel.org, lenb@kernel.org, james.morse@arm.com,
 tony.luck@intel.com, bp@alien8.de, dave@stgolabs.net,
 jonathan.cameron@huawei.com, dave.jiang@intel.com,
 alison.schofield@intel.com, vishal.l.verma@intel.com, ira.weiny@intel.com,
 bhelgaas@google.com, helgaas@kernel.org, mahesh@linux.ibm.com,
 oohall@gmail.com, linmiaohe@huawei.com, shiju.jose@huawei.com,
 adam.c.preble@intel.com, lukas@wunner.de,
 Smita.KoralahalliChannabasappa@amd.com, rrichter@amd.com,
 linux-cxl@vger.kernel.org, linux-edac@vger.kernel.org,
 linux-kernel@vger.kernel.org, erwin.tsaur@intel.com,
 sathyanarayanan.kuppuswamy@intel.com, dan.j.williams@intel.com,
 feiting.wanyan@intel.com, yudong.wang@intel.com, chao.p.peng@intel.com,
 qingshun.wang@linux.intel.com
References: <20240509084833.2147767-1-zhenzhong.duan@intel.com>
 <20240509084833.2147767-2-zhenzhong.duan@intel.com>
Content-Language: en-US
From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20240509084833.2147767-2-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 5/9/24 1:48 AM, Zhenzhong Duan wrote:
> In some cases the detector of a Non-Fatal Error(NFE) is not the most
> appropriate agent to determine the type of the error. For example,
> when software performs a configuration read from a non-existent
> device or Function, completer will send an ERR_NONFATAL Message.
> On some platforms, ERR_NONFATAL results in a System Error, which
> breaks normal software probing.
>
> Advisory Non-Fatal Error(ANFE) is a special case that can be used
> in above scenario. It is predominantly determined by the role of the
> detecting agent (Requester, Completer, or Receiver) and the specific
> error. In such cases, an agent with AER signals the NFE (if enabled)
> by sending an ERR_COR Message as an advisory to software, instead of
> sending ERR_NONFATAL.
>
> When processing an ANFE, ideally both correctable error(CE) status and
> uncorrectable error(UE) status should be cleared. However, there is no
> way to fully identify the UE associated with ANFE. Even worse, Non-Fatal
> Error(NFE) may set the same UE status bit as ANFE. Treating an ANFE as
> NFE will reproduce above mentioned issue, i.e., breaking softwore probing;
> treating NFE as ANFE will make us ignoring some UEs which need active
> recover operation. To avoid clearing UEs that are not ANFE by accident,
> the most conservative route is taken here: If any of the NFE Detected
> bits is set in Device Status, do not touch UE status, they should be
> cleared later by the UE handler. Otherwise, a specific set of UEs that
> may be raised as ANFE according to the PCIe specification will be cleared
> if their corresponding severity is Non-Fatal.
>
> To achieve above purpose, store UNCOR_STATUS bits that might be ANFE
> in aer_err_info.anfe_status. So that those bits could be printed and
> processed later.
>
> Tested-by: Yudong Wang <yudong.wang@intel.com>
> Co-developed-by: "Wang, Qingshun" <qingshun.wang@linux.intel.com>
> Signed-off-by: "Wang, Qingshun" <qingshun.wang@linux.intel.com>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> ---
>  drivers/pci/pci.h      |  1 +
>  drivers/pci/pcie/aer.c | 53 ++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 54 insertions(+)
>
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index 17fed1846847..3f9eb807f9fd 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -412,6 +412,7 @@ struct aer_err_info {
>  
>  	unsigned int status;		/* COR/UNCOR Error Status */
>  	unsigned int mask;		/* COR/UNCOR Error Mask */
> +	unsigned int anfe_status;	/* UNCOR Error Status for ANFE */
>  	struct pcie_tlp_log tlp;	/* TLP Header */
>  };
>  
> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index ac6293c24976..f2839b51321a 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -107,6 +107,12 @@ struct aer_stats {
>  					PCI_ERR_ROOT_MULTI_COR_RCV |	\
>  					PCI_ERR_ROOT_MULTI_UNCOR_RCV)
>  
> +#define AER_ERR_ANFE_UNC_MASK		(PCI_ERR_UNC_POISON_TLP |	\
> +					PCI_ERR_UNC_COMP_TIME |		\
> +					PCI_ERR_UNC_COMP_ABORT |	\
> +					PCI_ERR_UNC_UNX_COMP |		\
> +					PCI_ERR_UNC_UNSUP)
> +
>  static int pcie_aer_disable;
>  static pci_ers_result_t aer_root_reset(struct pci_dev *dev);
>  
> @@ -1196,6 +1202,49 @@ void aer_recover_queue(int domain, unsigned int bus, unsigned int devfn,
>  EXPORT_SYMBOL_GPL(aer_recover_queue);
>  #endif
>  
> +static void anfe_get_uc_status(struct pci_dev *dev, struct aer_err_info *info)
> +{
> +	u32 uncor_mask, uncor_status, anfe_status;
> +	u16 device_status;
> +	int aer = dev->aer_cap;
> +
> +	pci_read_config_dword(dev, aer + PCI_ERR_UNCOR_STATUS, &uncor_status);
> +	pci_read_config_dword(dev, aer + PCI_ERR_UNCOR_MASK, &uncor_mask);
> +	/*
> +	 * According to PCIe Base Specification Revision 6.1,
> +	 * Section 6.2.3.2.4, if an UNCOR error is raised as
> +	 * Advisory Non-Fatal error, it will match the following
> +	 * conditions:
> +	 *	a. The severity of the error is Non-Fatal.
> +	 *	b. The error is one of the following:
> +	 *		1. Poisoned TLP           (Section 6.2.3.2.4.3)
> +	 *		2. Completion Timeout     (Section 6.2.3.2.4.4)
> +	 *		3. Completer Abort        (Section 6.2.3.2.4.1)
> +	 *		4. Unexpected Completion  (Section 6.2.3.2.4.5)
> +	 *		5. Unsupported Request    (Section 6.2.3.2.4.1)
> +	 */
> +	anfe_status = uncor_status & ~uncor_mask & ~info->severity &
> +		      AER_ERR_ANFE_UNC_MASK;
> +
> +	if (pcie_capability_read_word(dev, PCI_EXP_DEVSTA, &device_status))
> +		return;
> +	/*
> +	 * Take the most conservative route here. If there are Non-Fatal errors
> +	 * detected, do not assume any bit in uncor_status is set by ANFE.
> +	 */
> +	if (device_status & PCI_EXP_DEVSTA_NFED)
> +		return;

You can move this check to the top of the function. You don't need to check
the rest if NFE error is detected in device status.

> +
> +	/*
> +	 * If there is another ANFE between reading uncor_status and clearing
> +	 * PCI_ERR_COR_ADV_NFAT bit in cor_status register, that ANFE isn't
> +	 * recorded in info->anfe_status. It will be read out as NFE in
> +	 * following uncor_status register reading and processed by NFE
> +	 * handler.
> +	 */
> +	info->anfe_status = anfe_status;
> +}
> +
>  /**
>   * aer_get_device_error_info - read error status from dev and store it to info
>   * @dev: pointer to the device expected to have a error record
> @@ -1213,6 +1262,7 @@ int aer_get_device_error_info(struct pci_dev *dev, struct aer_err_info *info)
>  
>  	/* Must reset in this function */
>  	info->status = 0;
> +	info->anfe_status = 0;
>  	info->tlp_header_valid = 0;
>  
>  	/* The device might not support AER */
> @@ -1226,6 +1276,9 @@ int aer_get_device_error_info(struct pci_dev *dev, struct aer_err_info *info)
>  			&info->mask);
>  		if (!(info->status & ~info->mask))
>  			return 0;
> +
> +		if (info->status & PCI_ERR_COR_ADV_NFAT)
> +			anfe_get_uc_status(dev, info);
>  	} else if (type == PCI_EXP_TYPE_ROOT_PORT ||
>  		   type == PCI_EXP_TYPE_RC_EC ||
>  		   type == PCI_EXP_TYPE_DOWNSTREAM ||

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer


