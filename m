Return-Path: <linux-pci+bounces-28914-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FAF1ACCEE9
	for <lists+linux-pci@lfdr.de>; Tue,  3 Jun 2025 23:23:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 50D6516EE1A
	for <lists+linux-pci@lfdr.de>; Tue,  3 Jun 2025 21:23:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96B0E22541F;
	Tue,  3 Jun 2025 21:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="j38Ed0r9"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A249F18E1F;
	Tue,  3 Jun 2025 21:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748985822; cv=none; b=Wb16XHWLbVN9C6MKzCS716tWrqhivuY9pmGstGzb9RgcHVxOOAWLDZl4G22sNuQ6Fly2D+yYtcf46ieuG+29PB+d7WUBvW/KR+msNjXr8MNcYGoVtwdvm/+gx4CBamiomXl+PDlfpv67YyCCUDwxibvxs0wIwPN8YTx7Cm8XTjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748985822; c=relaxed/simple;
	bh=Q0L033uSF8rn7qFAG0k3SFoNFf5x+r7D4n4XXeakONE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CEjtWVCUFs6XTY0B+M33b5C2g3a4td7W5RjXn+zg1w/kUE0VLWDMYYOtJGoKFuop0jxT2j2TFN3eNg5nbPpHfuB0E3z5yoDr7zpLokCbyIUhUobI2jinR3jytu0bCmmsfObVQLKz0SmIOvUykmppwnX/KCjmz37+34bix3qhOQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=j38Ed0r9; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748985820; x=1780521820;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Q0L033uSF8rn7qFAG0k3SFoNFf5x+r7D4n4XXeakONE=;
  b=j38Ed0r91UF2fgCNMK41YnGeLWnDZwT7H9gjbfE7MD9kQmpv0eAtN434
   em9iRKgBYWFDYMiAhgA0UoCF0mJUkuufjDhpe7pnOvgyt3ooz3A6opinO
   JiJeVHcLqTgbzn3LEgaRnCNIEyKoWQT+wpL+YmJU5cqbJehFt4/0OYOEr
   A5MYbcpj7MfDOd9buDyzzGDep/DFr/MFuLOsv6f3RdTrRhpX1rRAjTaqX
   YHDGBg5x1chbeU8cVHiposgEFFDCsV4rgRDxVGFPvHYw3T+30Tx0TWKr2
   PD96NsVyHzyEsogR/Lvzk0PYVuFzDvL0fkyxPectkW2wQ/wS91yRh8cn8
   A==;
X-CSE-ConnectionGUID: nisdw0xuQka5OkmRpjoOoQ==
X-CSE-MsgGUID: VIfXZvpNTMO4JogY3BAs4A==
X-IronPort-AV: E=McAfee;i="6700,10204,11453"; a="62436990"
X-IronPort-AV: E=Sophos;i="6.16,207,1744095600"; 
   d="scan'208";a="62436990"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2025 14:23:40 -0700
X-CSE-ConnectionGUID: evdyZjPASNqPmS8z1WRJJA==
X-CSE-MsgGUID: AQMaIvz3QASYtFGYOI91nQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,207,1744095600"; 
   d="scan'208";a="150277461"
Received: from iherna2-mobl4.amr.corp.intel.com (HELO [10.125.110.198]) ([10.125.110.198])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2025 14:23:38 -0700
Message-ID: <e919b8d3-5141-4e4f-9f96-9b680d4a7321@intel.com>
Date: Tue, 3 Jun 2025 14:23:36 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4 v3] PCI/AER: Modify pci_print_aer() to take log level
To: "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>,
 "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
 Davidlohr Bueso <dave@stgolabs.net>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <dan.j.williams@intel.com>,
 Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Oliver O'Halloran <oohall@gmail.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>,
 linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
 linux-cxl@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-pci@vger.kernel.org, linux-edac@vger.kernel.org
Cc: Yazen Ghannam <yazen.ghannam@amd.com>
References: <20250603155536.577493-1-fabio.m.de.francesco@linux.intel.com>
 <20250603155536.577493-3-fabio.m.de.francesco@linux.intel.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20250603155536.577493-3-fabio.m.de.francesco@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 6/3/25 8:54 AM, Fabio M. De Francesco wrote:
> Modify pci_print_aer() to take a printk() log level in preparation of a
> patch that logs PCIe Components and Link errors from ELOG.
> 
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Fabio M. De Francesco <fabio.m.de.francesco@linux.intel.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  drivers/cxl/core/pci.c |  2 +-
>  drivers/pci/pcie/aer.c | 16 ++++++++--------
>  include/linux/aer.h    |  4 ++--
>  3 files changed, 11 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index 3b80e9a76ba86..ad8d7939c2e1c 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
> @@ -885,7 +885,7 @@ static void cxl_handle_rdport_errors(struct cxl_dev_state *cxlds)
>  	if (!cxl_rch_get_aer_severity(&aer_regs, &severity))
>  		return;
>  
> -	pci_print_aer(pdev, severity, &aer_regs);
> +	pci_print_aer(KERN_ERR, pdev, severity, &aer_regs);
>  
>  	if (severity == AER_CORRECTABLE)
>  		cxl_handle_rdport_cor_ras(cxlds, dport);
> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index a1cf8c7ef628a..d0ebf7c15afa9 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -760,7 +760,7 @@ int cper_severity_to_aer(int cper_severity)
>  EXPORT_SYMBOL_GPL(cper_severity_to_aer);
>  #endif
>  
> -void pci_print_aer(struct pci_dev *dev, int aer_severity,
> +void pci_print_aer(char *level, struct pci_dev *dev, int aer_severity,
>  		   struct aer_capability_regs *aer)
>  {
>  	int layer, agent, tlp_header_valid = 0;
> @@ -785,14 +785,15 @@ void pci_print_aer(struct pci_dev *dev, int aer_severity,
>  	info.mask = mask;
>  	info.first_error = PCI_ERR_CAP_FEP(aer->cap_control);
>  
> -	pci_err(dev, "aer_status: 0x%08x, aer_mask: 0x%08x\n", status, mask);
> +	pci_printk(level, dev, "aer_status: 0x%08x, aer_mask: 0x%08x\n",
> +		   status, mask);
>  	__aer_print_error(dev, &info);
> -	pci_err(dev, "aer_layer=%s, aer_agent=%s\n",
> -		aer_error_layer[layer], aer_agent_string[agent]);
> +	pci_printk(level, dev, "aer_layer=%s, aer_agent=%s\n",
> +		   aer_error_layer[layer], aer_agent_string[agent]);
>  
>  	if (aer_severity != AER_CORRECTABLE)
> -		pci_err(dev, "aer_uncor_severity: 0x%08x\n",
> -			aer->uncor_severity);
> +		pci_printk(level, dev, "aer_uncor_severity: 0x%08x\n",
> +			   aer->uncor_severity);
>  
>  	if (tlp_header_valid)
>  		pcie_print_tlp_log(dev, &aer->header_log, dev_fmt("  "));
> @@ -1146,8 +1147,7 @@ static void aer_recover_work_func(struct work_struct *work)
>  			       PCI_SLOT(entry.devfn), PCI_FUNC(entry.devfn));
>  			continue;
>  		}
> -		pci_print_aer(pdev, entry.severity, entry.regs);
> -
> +		pci_print_aer(KERN_ERR, pdev, entry.severity, entry.regs);
>  		/*
>  		 * Memory for aer_capability_regs(entry.regs) is being
>  		 * allocated from the ghes_estatus_pool to protect it from
> diff --git a/include/linux/aer.h b/include/linux/aer.h
> index 02940be66324e..45d0fb2e2e759 100644
> --- a/include/linux/aer.h
> +++ b/include/linux/aer.h
> @@ -64,8 +64,8 @@ static inline int pci_aer_clear_nonfatal_status(struct pci_dev *dev)
>  static inline int pcie_aer_is_native(struct pci_dev *dev) { return 0; }
>  #endif
>  
> -void pci_print_aer(struct pci_dev *dev, int aer_severity,
> -		    struct aer_capability_regs *aer);
> +void pci_print_aer(char *level, struct pci_dev *dev, int aer_severity,
> +		   struct aer_capability_regs *aer);
>  int cper_severity_to_aer(int cper_severity);
>  void aer_recover_queue(int domain, unsigned int bus, unsigned int devfn,
>  		       int severity, struct aer_capability_regs *aer_regs);


