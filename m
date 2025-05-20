Return-Path: <linux-pci+bounces-28166-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CAF1ABE6E6
	for <lists+linux-pci@lfdr.de>; Wed, 21 May 2025 00:28:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B96C13BAEB1
	for <lists+linux-pci@lfdr.de>; Tue, 20 May 2025 22:27:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FA2625DB0A;
	Tue, 20 May 2025 22:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lA83djm+"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AACAA25B66D;
	Tue, 20 May 2025 22:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747780079; cv=none; b=tqnhas3nyHt0xEjO+if3f5AMdgLprEo9R2un1ZrugccHvtJ8ir+WUKSASN+pfOdxPk4HNo1NIq1s0wyQtYn7BD29wdN+E6x4OoqYjdzYl/M6n3Uf4MTp1Co5BksOu8ZDpnsTcRYR128CWLNf+CxvVCm3K1yoquDmlRz38qpZ384=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747780079; c=relaxed/simple;
	bh=l1cP/qs5vRZwTD2Bx8knT8IoVRjZHeWsMztzxK6U6fU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dx/mTxOmGuSOoH9EJOEQcoMjUeL+CuTfxIqICf3JGffCdpafQSS2a3qWjcHkBNd/qycmQ1THV24ORb3EHfL0kL59VZFnbl06UPL00Cuny7tzzhHnYmsQ5bpyttqTIOs14IpWATjoyHZ4wuwbOyrLP8szZFxcoZZX46/GKpT8+Ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lA83djm+; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747780078; x=1779316078;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=l1cP/qs5vRZwTD2Bx8knT8IoVRjZHeWsMztzxK6U6fU=;
  b=lA83djm+QbuDBsMAviuLM2g8dETFKU5khBrkGk+0SXm9YZf0hr9OJgXz
   SxEsEPRU3MJQ8KlMG5GMrPHFuqU4Y0B6HlMwwxdiCfNVBZRc1Dpz0mmcS
   QgDUHHpAv0dKSd+OABrBhGK+plITMTFL1jT89jY8CzYJ+COSleKB1Aaua
   v3nZgJbTqeZS1qiherqToyhgGHvO7L+h6xlTttjySbiBUIR8D3E+ga8sC
   tdTAtPBdrMx3tGrI6ZPR9VPkKeky/ErQsKkPmLbu9KlpcNP41RiMqcXTy
   zmB5vE8rJeYGFlfTArrEy5r4yhhzpjFh6HI5ARbFzAcVULMupcd0okZux
   Q==;
X-CSE-ConnectionGUID: KKwyIrc4QTCvAZoTKOjeXw==
X-CSE-MsgGUID: V3slUM5uQ4WKERqChLWSCA==
X-IronPort-AV: E=McAfee;i="6700,10204,11439"; a="49835328"
X-IronPort-AV: E=Sophos;i="6.15,303,1739865600"; 
   d="scan'208";a="49835328"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2025 15:27:57 -0700
X-CSE-ConnectionGUID: qW9qWDnrScyHgWk0lNpy4A==
X-CSE-MsgGUID: uLC217MUQne/69bSqCsZ3g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,303,1739865600"; 
   d="scan'208";a="144786813"
Received: from iweiny-desk3.amr.corp.intel.com (HELO [10.124.222.89]) ([10.124.222.89])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2025 15:27:55 -0700
Message-ID: <8898c999-b43b-4568-afe1-6a996fc90bbc@linux.intel.com>
Date: Tue, 20 May 2025 15:27:54 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 04/17] PCI/AER: Consolidate Error Source ID logging in
 aer_isr_one_error_type()
To: Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org
Cc: Jon Pan-Doh <pandoh@google.com>,
 Karolina Stolarek <karolina.stolarek@oracle.com>,
 Weinan Liu <wnliu@google.com>, Martin Petersen <martin.petersen@oracle.com>,
 Ben Fuller <ben.fuller@oracle.com>, Drew Walton <drewwalton@microsoft.com>,
 Anil Agrawal <anilagrawal@meta.com>, Tony Luck <tony.luck@intel.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Lukas Wunner <lukas@wunner.de>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Sargun Dhillon <sargun@meta.com>, "Paul E . McKenney" <paulmck@kernel.org>,
 Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Oliver O'Halloran <oohall@gmail.com>, Kai-Heng Feng <kaihengf@nvidia.com>,
 Keith Busch <kbusch@kernel.org>, Robert Richter <rrichter@amd.com>,
 Terry Bowman <terry.bowman@amd.com>, Shiju Jose <shiju.jose@huawei.com>,
 Dave Jiang <dave.jiang@intel.com>, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, Bjorn Helgaas <bhelgaas@google.com>
References: <20250520215047.1350603-1-helgaas@kernel.org>
 <20250520215047.1350603-5-helgaas@kernel.org>
Content-Language: en-US
From: Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20250520215047.1350603-5-helgaas@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 5/20/25 2:50 PM, Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
>
> Previously we decoded the AER Error Source ID in aer_isr_one_error_type(),
> then again in find_source_device() if we didn't find any devices with
> errors logged in their AER Capabilities.
>
> Consolidate this so we only decode and log the Error Source ID once in
> aer_isr_one_error_type().  Add a "details" parameter so we can add a note
> when we didn't find any downstream devices with errors logged in their AER
> Capability.
>
> This changes the dmesg logging when we found no devices with errors logged:
>
>    - pci 0000:00:01.0: AER: Correctable error message received from 0000:02:00.0
>    - pci 0000:00:01.0: AER: found no error details for 0000:02:00.0
>    + pci 0000:00:01.0: AER: Correctable error message received from 0000:02:00.0 (no details found)
>
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> ---

Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

>   drivers/pci/pcie/aer.c | 22 +++++++++-------------
>   1 file changed, 9 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index 568229288ca3..488a6408c7a8 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -733,16 +733,17 @@ void aer_print_error(struct pci_dev *dev, struct aer_err_info *info)
>   			info->severity, info->tlp_header_valid, &info->tlp);
>   }
>   
> -static void aer_print_port_info(struct pci_dev *dev, struct aer_err_info *info)
> +static void aer_print_port_info(struct pci_dev *dev, struct aer_err_info *info,
> +				const char *details)
>   {
>   	u8 bus = info->id >> 8;
>   	u8 devfn = info->id & 0xff;
>   
> -	pci_info(dev, "%s%s error message received from %04x:%02x:%02x.%d\n",
> +	pci_info(dev, "%s%s error message received from %04x:%02x:%02x.%d%s\n",
>   		 info->multi_error_valid ? "Multiple " : "",
>   		 aer_error_severity_string[info->severity],
>   		 pci_domain_nr(dev->bus), bus, PCI_SLOT(devfn),
> -		 PCI_FUNC(devfn));
> +		 PCI_FUNC(devfn), details);
>   }
>   
>   #ifdef CONFIG_ACPI_APEI_PCIEAER
> @@ -926,15 +927,8 @@ static bool find_source_device(struct pci_dev *parent,
>   	else
>   		pci_walk_bus(parent->subordinate, find_device_iter, e_info);
>   
> -	if (!e_info->error_dev_num) {
> -		u8 bus = e_info->id >> 8;
> -		u8 devfn = e_info->id & 0xff;
> -
> -		pci_info(parent, "found no error details for %04x:%02x:%02x.%d\n",
> -			 pci_domain_nr(parent->bus), bus, PCI_SLOT(devfn),
> -			 PCI_FUNC(devfn));
> +	if (!e_info->error_dev_num)
>   		return false;
> -	}
>   	return true;
>   }
>   
> @@ -1281,9 +1275,11 @@ static inline void aer_process_err_devices(struct aer_err_info *e_info)
>   static void aer_isr_one_error_type(struct pci_dev *root,
>   				   struct aer_err_info *info)
>   {
> -	aer_print_port_info(root, info);
> +	bool found;
>   
> -	if (find_source_device(root, info))
> +	found = find_source_device(root, info);
> +	aer_print_port_info(root, info, found ? "" : " (no details found");
> +	if (found)
>   		aer_process_err_devices(info);
>   }
>   

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer


