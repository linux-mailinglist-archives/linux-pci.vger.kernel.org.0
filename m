Return-Path: <linux-pci+bounces-37065-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 477A4BA1F9E
	for <lists+linux-pci@lfdr.de>; Fri, 26 Sep 2025 01:31:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ECC1116D2D9
	for <lists+linux-pci@lfdr.de>; Thu, 25 Sep 2025 23:31:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 380002ECD27;
	Thu, 25 Sep 2025 23:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="h4QxVYzy"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F15C189BB6;
	Thu, 25 Sep 2025 23:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758843093; cv=none; b=G3DL1lNryxwdtOsJ8jZQ/YnDR3h68W90NJelgJPCJXFtDwJznnjvk5TtdqwL1iNoX1HUQfxXpYvZlVbI5xNIP0iw+uNRgmRvxyZUDdOu+wy025gmLpwf8qdUzg6GPkKHFuMsjkfIMXCIPB1eT61m2QixvIeE2AJtsJ0r0dSN9Yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758843093; c=relaxed/simple;
	bh=Ym9rZ8TlAn0U/jY41YeVQHdv2W/YMv9jrEOIjS1R/5Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QlWMLCLmCbnxHjQaRveJ1uzVxLZYGzjnipcS4rJWwpNdan79KHqqvTGfAfB5YYblTnr23V5nisC5XcSBPYs+RXQ/4CxdSrEJAepFWvh4ho107LYKEVtaa//NjyE0P3Q0Bp0/WBsEvU6FI/ERPV3+qr3Y/g+cuBL9idhgqzuw1YY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=h4QxVYzy; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758843091; x=1790379091;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Ym9rZ8TlAn0U/jY41YeVQHdv2W/YMv9jrEOIjS1R/5Y=;
  b=h4QxVYzyE2z0nO/8HvZduo7gUvGvP8wqH0pVgJC32JilB++Bpy3vsRsL
   46Cpk48UZ5Omw7GJRqocXIu8bKy3mO+p5MF23tfAPzSL2afwK+bx6DTBQ
   gxcNDxLAixQngykvbb0QvJoNsuzuN4AIb+JJgFyVGef2yX8Z4ElE+xIOJ
   buzDSiqfLFLchblnR4NV4tdKMlA6+Voji3xVoviFTdddrQwVc9/phJnVS
   VlDwV7b/cTx8/yfBGzZWZe8cdMHSW0vTrCGegDNF9VgHeEK04rTqdgJ8Z
   hgU60oa9Y26h8m6vH5ctnofuX5uytLgclNWkHrw6/BuLHgpTH0X/3InSS
   w==;
X-CSE-ConnectionGUID: ywkDJE8jQ6SekrrvyQY3qA==
X-CSE-MsgGUID: CPhLI+8LRKqto3DD97TjMw==
X-IronPort-AV: E=McAfee;i="6800,10657,11564"; a="72537252"
X-IronPort-AV: E=Sophos;i="6.18,293,1751266800"; 
   d="scan'208";a="72537252"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2025 16:31:30 -0700
X-CSE-ConnectionGUID: 9fi/J5umSR658jlAq8hGFQ==
X-CSE-MsgGUID: oXthAToATxCK6QYYaxZfcQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,293,1751266800"; 
   d="scan'208";a="176740586"
Received: from gabaabhi-mobl2.amr.corp.intel.com (HELO [10.125.109.4]) ([10.125.109.4])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2025 16:31:28 -0700
Message-ID: <01bebc6a-c982-4826-8202-703a948c1d48@intel.com>
Date: Thu, 25 Sep 2025 16:31:26 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 05/25] cxl: Move CXL driver RCH error handling into
 CONFIG_CXL_RCH_RAS conditional block
To: Terry Bowman <terry.bowman@amd.com>, dave@stgolabs.net,
 jonathan.cameron@huawei.com, alison.schofield@intel.com,
 dan.j.williams@intel.com, bhelgaas@google.com, shiju.jose@huawei.com,
 ming.li@zohomail.com, Smita.KoralahalliChannabasappa@amd.com,
 rrichter@amd.com, dan.carpenter@linaro.org,
 PradeepVineshReddy.Kodamati@amd.com, lukas@wunner.de,
 Benjamin.Cheatham@amd.com, sathyanarayanan.kuppuswamy@linux.intel.com,
 linux-cxl@vger.kernel.org, alucerop@amd.com, ira.weiny@intel.com
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
References: <20250925223440.3539069-1-terry.bowman@amd.com>
 <20250925223440.3539069-6-terry.bowman@amd.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20250925223440.3539069-6-terry.bowman@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 9/25/25 3:34 PM, Terry Bowman wrote:
> Restricted CXL Host (RCH) protocol error handling uses a procedure distinct
> from the CXL Virtual Hierarchy (VH) handling. This is because of the
> differences in the RCH and VH topologies. Improve the maintainability and
> add ability to enable/disable RCH handling.
> 
> Move and combine the RCH handling code into a single block conditionally
> compiled with the CONFIG_CXL_RCH_RAS kernel config.
> 
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> 
> ---
> 
> v11->v12:
> - Moved CXL_RCH_RAS Kconfig definition here from following commit.
> 
> v10->v11:
> - New patch
> ---
>  drivers/cxl/Kconfig    |   7 ++
>  drivers/cxl/core/ras.c | 178 +++++++++++++++++++++--------------------
>  2 files changed, 100 insertions(+), 85 deletions(-)
> 
> diff --git a/drivers/cxl/Kconfig b/drivers/cxl/Kconfig
> index b92d544cfe6f..028201e24523 100644
> --- a/drivers/cxl/Kconfig
> +++ b/drivers/cxl/Kconfig
> @@ -236,4 +236,11 @@ config CXL_MCE
>  config CXL_RAS
>  	def_bool y
>  	depends on ACPI_APEI_GHES && PCIEAER && CXL_PCI
> +
> +config CXL_RCH_RAS
> +	bool "CXL: Restricted CXL Host (RCH) protocol error handling"
> +	def_bool n
> +	depends on CXL_RAS
> +	help
> +	  RAS support for Restricted CXL Host (RCH) defined in CXL1.1.
>  endif
> diff --git a/drivers/cxl/core/ras.c b/drivers/cxl/core/ras.c
> index 0875ce8116ff..1ec4ea8c56f1 100644
> --- a/drivers/cxl/core/ras.c
> +++ b/drivers/cxl/core/ras.c
> @@ -126,6 +126,10 @@ void cxl_ras_exit(void)
>  	cancel_work_sync(&cxl_cper_prot_err_work);
>  }
>  
> +static void cxl_handle_cor_ras(struct cxl_dev_state *cxlds, void __iomem *ras_base);
> +static bool cxl_handle_ras(struct cxl_dev_state *cxlds, void __iomem *ras_base);
> +
> +#ifdef CONFIG_CXL_RCH_RAS

I don't love this in the C file. If we are going to have a Kconfig that we can use to gate the code, maybe we need core/ras_rch.c? Don't forget to add the new object entry to KBuild for cxl_test when you do that. 

DJ

>  static void cxl_dport_map_rch_aer(struct cxl_dport *dport)
>  {
>  	resource_size_t aer_phys;
> @@ -141,18 +145,6 @@ static void cxl_dport_map_rch_aer(struct cxl_dport *dport)
>  	}
>  }
>  
> -static void cxl_dport_map_ras(struct cxl_dport *dport)
> -{
> -	struct cxl_register_map *map = &dport->reg_map;
> -	struct device *dev = dport->dport_dev;
> -
> -	if (!map->component_map.ras.valid)
> -		dev_dbg(dev, "RAS registers not found\n");
> -	else if (cxl_map_component_regs(map, &dport->regs.component,
> -					BIT(CXL_CM_CAP_CAP_ID_RAS)))
> -		dev_dbg(dev, "Failed to map RAS capability.\n");
> -}
> -
>  static void cxl_disable_rch_root_ints(struct cxl_dport *dport)
>  {
>  	void __iomem *aer_base = dport->regs.dport_aer;
> @@ -177,6 +169,95 @@ static void cxl_disable_rch_root_ints(struct cxl_dport *dport)
>  	writel(aer_cmd, aer_base + PCI_ERR_ROOT_COMMAND);
>  }
>  
> +/*
> + * Copy the AER capability registers using 32 bit read accesses.
> + * This is necessary because RCRB AER capability is MMIO mapped. Clear the
> + * status after copying.
> + *
> + * @aer_base: base address of AER capability block in RCRB
> + * @aer_regs: destination for copying AER capability
> + */
> +static bool cxl_rch_get_aer_info(void __iomem *aer_base,
> +				 struct aer_capability_regs *aer_regs)
> +{
> +	int read_cnt = sizeof(struct aer_capability_regs) / sizeof(u32);
> +	u32 *aer_regs_buf = (u32 *)aer_regs;
> +	int n;
> +
> +	if (!aer_base)
> +		return false;
> +
> +	/* Use readl() to guarantee 32-bit accesses */
> +	for (n = 0; n < read_cnt; n++)
> +		aer_regs_buf[n] = readl(aer_base + n * sizeof(u32));
> +
> +	writel(aer_regs->uncor_status, aer_base + PCI_ERR_UNCOR_STATUS);
> +	writel(aer_regs->cor_status, aer_base + PCI_ERR_COR_STATUS);
> +
> +	return true;
> +}
> +
> +/* Get AER severity. Return false if there is no error. */
> +static bool cxl_rch_get_aer_severity(struct aer_capability_regs *aer_regs,
> +				     int *severity)
> +{
> +	if (aer_regs->uncor_status & ~aer_regs->uncor_mask) {
> +		if (aer_regs->uncor_status & PCI_ERR_ROOT_FATAL_RCV)
> +			*severity = AER_FATAL;
> +		else
> +			*severity = AER_NONFATAL;
> +		return true;
> +	}
> +
> +	if (aer_regs->cor_status & ~aer_regs->cor_mask) {
> +		*severity = AER_CORRECTABLE;
> +		return true;
> +	}
> +
> +	return false;
> +}
> +
> +static void cxl_handle_rdport_errors(struct cxl_dev_state *cxlds)
> +{
> +	struct pci_dev *pdev = to_pci_dev(cxlds->dev);
> +	struct aer_capability_regs aer_regs;
> +	struct cxl_dport *dport;
> +	int severity;
> +
> +	struct cxl_port *port __free(put_cxl_port) =
> +		cxl_pci_find_port(pdev, &dport);
> +	if (!port)
> +		return;
> +
> +	if (!cxl_rch_get_aer_info(dport->regs.dport_aer, &aer_regs))
> +		return;
> +
> +	if (!cxl_rch_get_aer_severity(&aer_regs, &severity))
> +		return;
> +
> +	pci_print_aer(pdev, severity, &aer_regs);
> +	if (severity == AER_CORRECTABLE)
> +		cxl_handle_cor_ras(cxlds, dport->regs.ras);
> +	else
> +		cxl_handle_ras(cxlds, dport->regs.ras);
> +}
> +#else
> +static inline void cxl_dport_map_rch_aer(struct cxl_dport *dport) { }
> +static inline void cxl_disable_rch_root_ints(struct cxl_dport *dport) { }
> +static inline void cxl_handle_rdport_errors(struct cxl_dev_state *cxlds) { }
> +#endif
> +
> +static void cxl_dport_map_ras(struct cxl_dport *dport)
> +{
> +	struct cxl_register_map *map = &dport->reg_map;
> +	struct device *dev = dport->dport_dev;
> +
> +	if (!map->component_map.ras.valid)
> +		dev_dbg(dev, "RAS registers not found\n");
> +	else if (cxl_map_component_regs(map, &dport->regs.component,
> +					BIT(CXL_CM_CAP_CAP_ID_RAS)))
> +		dev_dbg(dev, "Failed to map RAS capability.\n");
> +}
>  
>  /**
>   * cxl_dport_init_ras_reporting - Setup CXL RAS report on this dport
> @@ -270,79 +351,6 @@ static bool cxl_handle_ras(struct cxl_dev_state *cxlds, void __iomem *ras_base)
>  	return true;
>  }
>  
> -/*
> - * Copy the AER capability registers using 32 bit read accesses.
> - * This is necessary because RCRB AER capability is MMIO mapped. Clear the
> - * status after copying.
> - *
> - * @aer_base: base address of AER capability block in RCRB
> - * @aer_regs: destination for copying AER capability
> - */
> -static bool cxl_rch_get_aer_info(void __iomem *aer_base,
> -				 struct aer_capability_regs *aer_regs)
> -{
> -	int read_cnt = sizeof(struct aer_capability_regs) / sizeof(u32);
> -	u32 *aer_regs_buf = (u32 *)aer_regs;
> -	int n;
> -
> -	if (!aer_base)
> -		return false;
> -
> -	/* Use readl() to guarantee 32-bit accesses */
> -	for (n = 0; n < read_cnt; n++)
> -		aer_regs_buf[n] = readl(aer_base + n * sizeof(u32));
> -
> -	writel(aer_regs->uncor_status, aer_base + PCI_ERR_UNCOR_STATUS);
> -	writel(aer_regs->cor_status, aer_base + PCI_ERR_COR_STATUS);
> -
> -	return true;
> -}
> -
> -/* Get AER severity. Return false if there is no error. */
> -static bool cxl_rch_get_aer_severity(struct aer_capability_regs *aer_regs,
> -				     int *severity)
> -{
> -	if (aer_regs->uncor_status & ~aer_regs->uncor_mask) {
> -		if (aer_regs->uncor_status & PCI_ERR_ROOT_FATAL_RCV)
> -			*severity = AER_FATAL;
> -		else
> -			*severity = AER_NONFATAL;
> -		return true;
> -	}
> -
> -	if (aer_regs->cor_status & ~aer_regs->cor_mask) {
> -		*severity = AER_CORRECTABLE;
> -		return true;
> -	}
> -
> -	return false;
> -}
> -
> -static void cxl_handle_rdport_errors(struct cxl_dev_state *cxlds)
> -{
> -	struct pci_dev *pdev = to_pci_dev(cxlds->dev);
> -	struct aer_capability_regs aer_regs;
> -	struct cxl_dport *dport;
> -	int severity;
> -
> -	struct cxl_port *port __free(put_cxl_port) =
> -		cxl_pci_find_port(pdev, &dport);
> -	if (!port)
> -		return;
> -
> -	if (!cxl_rch_get_aer_info(dport->regs.dport_aer, &aer_regs))
> -		return;
> -
> -	if (!cxl_rch_get_aer_severity(&aer_regs, &severity))
> -		return;
> -
> -	pci_print_aer(pdev, severity, &aer_regs);
> -	if (severity == AER_CORRECTABLE)
> -		cxl_handle_cor_ras(cxlds, dport->regs.ras);
> -	else
> -		cxl_handle_ras(cxlds, dport->regs.ras);
> -}
> -
>  void cxl_cor_error_detected(struct pci_dev *pdev)
>  {
>  	struct cxl_dev_state *cxlds = pci_get_drvdata(pdev);


