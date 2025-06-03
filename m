Return-Path: <linux-pci+bounces-28917-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17EC2ACCF58
	for <lists+linux-pci@lfdr.de>; Tue,  3 Jun 2025 23:49:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB5693A1FFD
	for <lists+linux-pci@lfdr.de>; Tue,  3 Jun 2025 21:48:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AC651EFF9F;
	Tue,  3 Jun 2025 21:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KCi8MaWp"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0D6F1C3BEB;
	Tue,  3 Jun 2025 21:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748987356; cv=none; b=G0iQ1CJvu1Fmz2cNvXs9VDRsT0NYfmDoAvnMloZPBsGwFMjCdfjAdn04jm+xmPjbGPrAzDCfLW7h3PEQV6vpvdNordpu3tp3IEVzLZWkqQx6IvZdug4aiF6QyLttduolQS2e9Xil65qjgsQ0fq6/exLrEWCLdRzamz6y+DcIefs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748987356; c=relaxed/simple;
	bh=/72GejJlyaFyHD9yEsDhR0fa1xsa7AXd9PwGG3Wdsz4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gI41N+AAct2x7nKXCrnDKhxAiV94nmNtv23a5eeDKoUqr8hewFMfQQyq0RKnCk+QqR2cc3gnTn5Gjp2ab3SqMv81N7fsJgbXi0OsbaHJCiW33MkfkUZI6QYXwfz49EgHce8ClMuh4C3TZ0dXy6/XYeVSKAJ3hUEOJwCFD5cz+pY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KCi8MaWp; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748987355; x=1780523355;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=/72GejJlyaFyHD9yEsDhR0fa1xsa7AXd9PwGG3Wdsz4=;
  b=KCi8MaWpaBRlU46vQacxzGulb2YatHswXHsDAt1k059UfWB6Oe2ozghn
   8ei/WUEjN/5Sp8CorVdzvINXdTgcgl8aD4NRyBFCJRc8d5tgNlnzYzS7e
   lkmy4IJjvQhEb06PYHbBIl7UDS10DIWH1YF9sdBUheRMFm3yyUMHFVndm
   T6NCu4qFd5oGWfwIMYTmo4dWpGBNqGpOdAH3hZynbEd0G29JNt8lMCPEf
   hmDv2QE7JM90La2yxUOxDG9SD/DcpWwXoiGvjvawSiKKD+stUMLMnLijL
   cXKDRfzZxhv+wfSq0fUVQDiLxsx0GbOn+QbmIeANeKMmUNhqgZvgrTJSQ
   g==;
X-CSE-ConnectionGUID: ix1GvoE3Q+mkc3VX6IE66A==
X-CSE-MsgGUID: BSfpVw8vQ0aXH6p9XSMJHA==
X-IronPort-AV: E=McAfee;i="6700,10204,11453"; a="62405370"
X-IronPort-AV: E=Sophos;i="6.16,207,1744095600"; 
   d="scan'208";a="62405370"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2025 14:49:14 -0700
X-CSE-ConnectionGUID: x1lAca+5SRCCSc7N8LZBFQ==
X-CSE-MsgGUID: ibOCymN6QieUiSF771rJRA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,207,1744095600"; 
   d="scan'208";a="150035277"
Received: from iherna2-mobl4.amr.corp.intel.com (HELO [10.125.110.198]) ([10.125.110.198])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2025 14:49:13 -0700
Message-ID: <d37669fc-72e6-48d8-a080-e0353ccc812d@intel.com>
Date: Tue, 3 Jun 2025 14:49:10 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4 v3] ACPI: extlog: Trace CPER PCI Express Error Section
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
 <20250603155536.577493-4-fabio.m.de.francesco@linux.intel.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20250603155536.577493-4-fabio.m.de.francesco@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 6/3/25 8:54 AM, Fabio M. De Francesco wrote:
> I/O Machine Check Architecture events may signal failing PCIe components
> or links. The AER event contains details on what was happening on the wire
> when the error was signaled.
> 
> Trace the CPER PCIe Error section (UEFI v2.10, Appendix N.2.7) reported
> by the I/O MCA.
> 
> Cc: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Fabio M. De Francesco <fabio.m.de.francesco@linux.intel.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  drivers/acpi/Kconfig       |  1 +
>  drivers/acpi/acpi_extlog.c | 32 ++++++++++++++++++++++++++++++++
>  drivers/pci/pcie/aer.c     |  2 +-
>  include/linux/aer.h        |  8 ++++++--
>  4 files changed, 40 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
> index 7bc40c2735ac0..2bbd9e4868ad7 100644
> --- a/drivers/acpi/Kconfig
> +++ b/drivers/acpi/Kconfig
> @@ -493,6 +493,7 @@ config ACPI_EXTLOG
>  	tristate "Extended Error Log support"
>  	depends on X86_MCE && X86_LOCAL_APIC && EDAC
>  	select UEFI_CPER
> +	select ACPI_APEI_PCIEAER
>  	help
>  	  Certain usages such as Predictive Failure Analysis (PFA) require
>  	  more information about the error than what can be described in
> diff --git a/drivers/acpi/acpi_extlog.c b/drivers/acpi/acpi_extlog.c
> index 47d11cb5c9120..b2928ff297eda 100644
> --- a/drivers/acpi/acpi_extlog.c
> +++ b/drivers/acpi/acpi_extlog.c
> @@ -132,6 +132,34 @@ static int print_extlog_rcd(const char *pfx,
>  	return 1;
>  }
>  
> +static void extlog_print_pcie(struct cper_sec_pcie *pcie_err,
> +			      int severity)
> +{
> +	struct aer_capability_regs *aer;
> +	struct pci_dev *pdev;
> +	unsigned int devfn;
> +	unsigned int bus;
> +	int aer_severity;
> +	int domain;
> +
> +	if (!(pcie_err->validation_bits & CPER_PCIE_VALID_DEVICE_ID ||
> +	      pcie_err->validation_bits & CPER_PCIE_VALID_AER_INFO))
> +		return;
> +
> +	aer_severity = cper_severity_to_aer(severity);
> +	aer = (struct aer_capability_regs *)pcie_err->aer_info;
> +	domain = pcie_err->device_id.segment;
> +	bus = pcie_err->device_id.bus;
> +	devfn = PCI_DEVFN(pcie_err->device_id.device,
> +			  pcie_err->device_id.function);
> +	pdev = pci_get_domain_bus_and_slot(domain, bus, devfn);
> +	if (!pdev)
> +		return;
> +
> +	pci_print_aer(KERN_DEBUG, pdev, aer_severity, aer);
> +	pci_dev_put(pdev);
> +}
> +
>  static int extlog_print(struct notifier_block *nb, unsigned long val,
>  			void *data)
>  {
> @@ -183,6 +211,10 @@ static int extlog_print(struct notifier_block *nb, unsigned long val,
>  			if (gdata->error_data_length >= sizeof(*mem))
>  				trace_extlog_mem_event(mem, err_seq, fru_id, fru_text,
>  						       (u8)gdata->error_severity);
> +		} else if (guid_equal(sec_type, &CPER_SEC_PCIE)) {
> +			struct cper_sec_pcie *pcie_err = acpi_hest_get_payload(gdata);
> +
> +			extlog_print_pcie(pcie_err, gdata->error_severity);
>  		} else {
>  			void *err = acpi_hest_get_payload(gdata);
>  
> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index d0ebf7c15afa9..627fcf4346983 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -801,7 +801,7 @@ void pci_print_aer(char *level, struct pci_dev *dev, int aer_severity,
>  	trace_aer_event(dev_name(&dev->dev), (status & ~mask),
>  			aer_severity, tlp_header_valid, &aer->header_log);
>  }
> -EXPORT_SYMBOL_NS_GPL(pci_print_aer, "CXL");
> +EXPORT_SYMBOL_GPL(pci_print_aer);
>  
>  /**
>   * add_error_device - list device to be handled
> diff --git a/include/linux/aer.h b/include/linux/aer.h
> index 45d0fb2e2e759..6ce433cee4625 100644
> --- a/include/linux/aer.h
> +++ b/include/linux/aer.h
> @@ -56,16 +56,20 @@ struct aer_capability_regs {
>  #if defined(CONFIG_PCIEAER)
>  int pci_aer_clear_nonfatal_status(struct pci_dev *dev);
>  int pcie_aer_is_native(struct pci_dev *dev);
> +void pci_print_aer(char *level, struct pci_dev *dev, int aer_severity,
> +		   struct aer_capability_regs *aer);
>  #else
>  static inline int pci_aer_clear_nonfatal_status(struct pci_dev *dev)
>  {
>  	return -EINVAL;
>  }
>  static inline int pcie_aer_is_native(struct pci_dev *dev) { return 0; }
> +static inline void pci_print_aer(char *level, struct pci_dev *dev,
> +				 int aer_severity,
> +				 struct aer_capability_regs *aer)
> +{ }
>  #endif
>  
> -void pci_print_aer(char *level, struct pci_dev *dev, int aer_severity,
> -		   struct aer_capability_regs *aer);
>  int cper_severity_to_aer(int cper_severity);
>  void aer_recover_queue(int domain, unsigned int bus, unsigned int devfn,
>  		       int severity, struct aer_capability_regs *aer_regs);


