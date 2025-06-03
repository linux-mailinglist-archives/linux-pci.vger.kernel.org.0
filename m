Return-Path: <linux-pci+bounces-28912-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65EDDACCE81
	for <lists+linux-pci@lfdr.de>; Tue,  3 Jun 2025 22:53:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54A203A773E
	for <lists+linux-pci@lfdr.de>; Tue,  3 Jun 2025 20:52:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1522E22539F;
	Tue,  3 Jun 2025 20:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="P0vL7EPH"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5794821C16D;
	Tue,  3 Jun 2025 20:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748983884; cv=none; b=hR3T79QXOIT99sshQkOY03Lc6Mv3o9Ey4JS3Bp6lLpH/NoLvmyDul0sOsc+Nbb4wYiODdzIJuRkddC9AVl5k7UzDSRAoHYnaQ4sY+DnhH28zfikl9pwPVSpYyytT2qOKFQtzQcECXK1QI5T7kj1JrWX5USHO+ogM5qAaj3mqrfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748983884; c=relaxed/simple;
	bh=o4zOLvZFW8pO4zLwuxYUFfk4IAFaKCqbEJ5gNrQFVOg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q5TEiN/6pENiawsSglAXRp4znGbXsmr6HgnMPmnPlvLiXnc2Fz6D7wKqNA5ZuKuzdt86w93CZ/eDdnI3uEaoKjWOApdcD+jI+BfdjxkCp3O3fr2/+7NZ2iIyvgmNl317vPjwEKqjGPPmjUqdUUEgbAApNHDANuE94ovHOiTzaqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=P0vL7EPH; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748983882; x=1780519882;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=o4zOLvZFW8pO4zLwuxYUFfk4IAFaKCqbEJ5gNrQFVOg=;
  b=P0vL7EPHuDiqV0+XpZFrTN28HFBGtrV8NqT1FN+9a/q52H1cn/yv6k6w
   buELJecZD3C9nttH0QG7aUmFBR5Z+CCaDJRalv/IOoJU550tfektYp2KT
   UIYj1eNbkGnJLeus3QQHIrVux7qlwHNx+50LgBJ1omD6ay389VzGBvDTH
   QcZLko/wzF9/z+WSU+bigGDzAcnEyNWP8XSIAcjZhehfyv1JRdyeol5Jc
   QgEZ3+cHZg093GH7Q/DaShfM6MXnC4MRqygAtHAn32jUfqEHlPhsiSqDX
   zEr82rgePoo/KeZ0U33Zo0BSBtmRi+MbZTgbfk0sF6B2mAvsiQ36U6XGY
   A==;
X-CSE-ConnectionGUID: Z+CpDmTXQLyaH/ID6G3HwA==
X-CSE-MsgGUID: d/YSKdpnTQ+aIj0Knww0mQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11453"; a="53668521"
X-IronPort-AV: E=Sophos;i="6.16,207,1744095600"; 
   d="scan'208";a="53668521"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2025 13:51:21 -0700
X-CSE-ConnectionGUID: AGrOcP48Te6x84iR91XP2w==
X-CSE-MsgGUID: wCO6PN/LQnmJUW2Bw83T/Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,207,1744095600"; 
   d="scan'208";a="175839494"
Received: from linux.intel.com ([10.54.29.200])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2025 13:51:21 -0700
Received: from [10.124.221.22] (unknown [10.124.221.22])
	by linux.intel.com (Postfix) with ESMTP id B7E6620B58A2;
	Tue,  3 Jun 2025 13:51:19 -0700 (PDT)
Message-ID: <220323bb-ebe1-41f8-aca2-53bb9885ea0a@linux.intel.com>
Date: Tue, 3 Jun 2025 13:51:19 -0700
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
 Dave Jiang <dave.jiang@intel.com>,
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
From: Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20250603155536.577493-3-fabio.m.de.francesco@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 6/3/25 8:54 AM, Fabio M. De Francesco wrote:
> Modify pci_print_aer() to take a printk() log level in preparation of a
> patch that logs PCIe Components and Link errors from ELOG.

I think you need to rebase this patch on top of latest PCI changes. A patch to
consolidate the AER error logging is pushed for v6.16 merge.

> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Fabio M. De Francesco <fabio.m.de.francesco@linux.intel.com>
> ---
>   drivers/cxl/core/pci.c |  2 +-
>   drivers/pci/pcie/aer.c | 16 ++++++++--------
>   include/linux/aer.h    |  4 ++--
>   3 files changed, 11 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index 3b80e9a76ba86..ad8d7939c2e1c 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
> @@ -885,7 +885,7 @@ static void cxl_handle_rdport_errors(struct cxl_dev_state *cxlds)
>   	if (!cxl_rch_get_aer_severity(&aer_regs, &severity))
>   		return;
>   
> -	pci_print_aer(pdev, severity, &aer_regs);
> +	pci_print_aer(KERN_ERR, pdev, severity, &aer_regs);
>   
>   	if (severity == AER_CORRECTABLE)
>   		cxl_handle_rdport_cor_ras(cxlds, dport);
> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index a1cf8c7ef628a..d0ebf7c15afa9 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -760,7 +760,7 @@ int cper_severity_to_aer(int cper_severity)
>   EXPORT_SYMBOL_GPL(cper_severity_to_aer);
>   #endif
>   
> -void pci_print_aer(struct pci_dev *dev, int aer_severity,
> +void pci_print_aer(char *level, struct pci_dev *dev, int aer_severity,
>   		   struct aer_capability_regs *aer)
>   {
>   	int layer, agent, tlp_header_valid = 0;
> @@ -785,14 +785,15 @@ void pci_print_aer(struct pci_dev *dev, int aer_severity,
>   	info.mask = mask;
>   	info.first_error = PCI_ERR_CAP_FEP(aer->cap_control);
>   
> -	pci_err(dev, "aer_status: 0x%08x, aer_mask: 0x%08x\n", status, mask);
> +	pci_printk(level, dev, "aer_status: 0x%08x, aer_mask: 0x%08x\n",
> +		   status, mask);
>   	__aer_print_error(dev, &info);
> -	pci_err(dev, "aer_layer=%s, aer_agent=%s\n",
> -		aer_error_layer[layer], aer_agent_string[agent]);
> +	pci_printk(level, dev, "aer_layer=%s, aer_agent=%s\n",
> +		   aer_error_layer[layer], aer_agent_string[agent]);
>   
>   	if (aer_severity != AER_CORRECTABLE)
> -		pci_err(dev, "aer_uncor_severity: 0x%08x\n",
> -			aer->uncor_severity);
> +		pci_printk(level, dev, "aer_uncor_severity: 0x%08x\n",
> +			   aer->uncor_severity);
>   
>   	if (tlp_header_valid)
>   		pcie_print_tlp_log(dev, &aer->header_log, dev_fmt("  "));
> @@ -1146,8 +1147,7 @@ static void aer_recover_work_func(struct work_struct *work)
>   			       PCI_SLOT(entry.devfn), PCI_FUNC(entry.devfn));
>   			continue;
>   		}
> -		pci_print_aer(pdev, entry.severity, entry.regs);
> -
> +		pci_print_aer(KERN_ERR, pdev, entry.severity, entry.regs);
>   		/*
>   		 * Memory for aer_capability_regs(entry.regs) is being
>   		 * allocated from the ghes_estatus_pool to protect it from
> diff --git a/include/linux/aer.h b/include/linux/aer.h
> index 02940be66324e..45d0fb2e2e759 100644
> --- a/include/linux/aer.h
> +++ b/include/linux/aer.h
> @@ -64,8 +64,8 @@ static inline int pci_aer_clear_nonfatal_status(struct pci_dev *dev)
>   static inline int pcie_aer_is_native(struct pci_dev *dev) { return 0; }
>   #endif
>   
> -void pci_print_aer(struct pci_dev *dev, int aer_severity,
> -		    struct aer_capability_regs *aer);
> +void pci_print_aer(char *level, struct pci_dev *dev, int aer_severity,
> +		   struct aer_capability_regs *aer);
>   int cper_severity_to_aer(int cper_severity);
>   void aer_recover_queue(int domain, unsigned int bus, unsigned int devfn,
>   		       int severity, struct aer_capability_regs *aer_regs);

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer


