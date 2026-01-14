Return-Path: <linux-pci+bounces-44858-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AC517D21317
	for <lists+linux-pci@lfdr.de>; Wed, 14 Jan 2026 21:35:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 654E93027E17
	for <lists+linux-pci@lfdr.de>; Wed, 14 Jan 2026 20:35:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0D08352C53;
	Wed, 14 Jan 2026 20:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AY1nvTGh"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6839B329E6A;
	Wed, 14 Jan 2026 20:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768422947; cv=none; b=gr+YvtlhvNT/xjsDaSCzZNQOEmUwoRrsO1C3ntcDnXFdmpvVVw+ih6kfuyQyDxyuvTPyp9FWe1+sb+XWttFsu1VHNftmuIh6L1wmjDX2z4Wt2dJs9qjD8sTLxwZGTkwByWWDCo7LJ7ErX1aQ9T3DmRv7H1EN/7PnQdbesgd9NYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768422947; c=relaxed/simple;
	bh=pUJm3eQE4UOyrCb6z+nKug7ix67xd/dTrJ1NMO5jbHA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Oro72nEyaoeyG2ZufhjbDoNNAq8FGaMPUKmZ+J3pfKApdVWRTuLqfLNLCfWmBq2vkeO14jrwerWPQOE8eC13iUO9b+CqNu8+y+EkNTdDGk6o2meq50HWWPJRbs+5SsZ68OExs7N46L2+dQiBSly7BuH+wL6FVp6mKqUG21G2aZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AY1nvTGh; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768422945; x=1799958945;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=pUJm3eQE4UOyrCb6z+nKug7ix67xd/dTrJ1NMO5jbHA=;
  b=AY1nvTGho5SsMwQjIOA/QnA7mj3PrGpGAfXxmHLFSfs98xHj6ZUY+N8S
   oo9DcLkCBd9nVT5v8ao/guSGTD5sIii04pjYl9L5qBnoWTMOw+daCHUTS
   UOrSwFBoy0Nr8Mi+wYMgec5UFgP5+aedy6cEUXu/2/TXmJjC3yrNj/xNE
   LqifGLbvNhfvY+tFFn3pzdd3E5Fi0J+AS2DWo7YhNMcj1ah+8CMTXf5lv
   QeLdH1QLq9sD48cYX0+Xmki90j/uVhKKuhdJev6cUAtEmcRVJTGRJCMgx
   fgTM9q1QWRG8363EQweQYTCzouDhyjmi7Q1cAI72HZ6yex6pl59yoatB9
   g==;
X-CSE-ConnectionGUID: WLdy+GEoRhiJBIHOEvbkZw==
X-CSE-MsgGUID: 0xpVzFNrTOKnZXNxTcGOog==
X-IronPort-AV: E=McAfee;i="6800,10657,11671"; a="69630885"
X-IronPort-AV: E=Sophos;i="6.21,226,1763452800"; 
   d="scan'208";a="69630885"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2026 12:35:45 -0800
X-CSE-ConnectionGUID: L2yWXfHTQ3WnUcR0DpHryg==
X-CSE-MsgGUID: KmjokH+fRWCBp6FlKwrRog==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,226,1763452800"; 
   d="scan'208";a="235498616"
Received: from dwoodwor-mobl2.amr.corp.intel.com (HELO [10.125.111.5]) ([10.125.111.5])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2026 12:35:43 -0800
Message-ID: <21623130-2ef8-4420-8282-3c33f5203e1a@intel.com>
Date: Wed, 14 Jan 2026 13:35:42 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 08/34] cxl/pci: Move CXL driver's RCH error handling
 into core/ras_rch.c
To: Terry Bowman <terry.bowman@amd.com>, dave@stgolabs.net,
 jonathan.cameron@huawei.com, alison.schofield@intel.com,
 dan.j.williams@intel.com, bhelgaas@google.com, shiju.jose@huawei.com,
 ming.li@zohomail.com, Smita.KoralahalliChannabasappa@amd.com,
 rrichter@amd.com, dan.carpenter@linaro.org,
 PradeepVineshReddy.Kodamati@amd.com, lukas@wunner.de,
 Benjamin.Cheatham@amd.com, sathyanarayanan.kuppuswamy@linux.intel.com,
 linux-cxl@vger.kernel.org, vishal.l.verma@intel.com, alucerop@amd.com,
 ira.weiny@intel.com
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
References: <20260114182055.46029-1-terry.bowman@amd.com>
 <20260114182055.46029-9-terry.bowman@amd.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20260114182055.46029-9-terry.bowman@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 1/14/26 11:20 AM, Terry Bowman wrote:
> Restricted CXL Host (RCH) protocol error handling uses a procedure distinct
> from the CXL Virtual Hierarchy (VH) handling. This is because of the
> differences in the RCH and VH topologies. Improve the maintainability and
> add ability to enable/disable RCH handling.
> 
> Move and combine the RCH handling code into a single block conditionally
> compiled with the CONFIG_CXL_RCH_RAS kernel config.
> 
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> 

Reviewed-by: Dave Jiang <dave.jiang@intel.com>


> ---
> 
> Changes in v13->v14:
> - Add sign-off for Dan and Jonathan
> - Revert inadvertent formatting of cxl_dport_map_rch_aer() (Jonathan)
> - Remove default value for CXL_RCH_RAS (Dan)
> - Remove unnecessary pci.h include in core.h & ras_rch.c (Jonathan)
> - Add linux/types.h include in ras_rch.c (Jonathan)
> - Change CONFIG_CXL_RCH_RAS -> CONFIG_CXL_RAS (Dan)
> 
> Changes in v12->v13:
> - None
> 
> Changes v11->v12:
> - Moved CXL_RCH_RAS Kconfig definition here from following commit.
> 
> Changes v10->v11:
> - New patch
> ---
>  drivers/cxl/core/Makefile  |   1 +
>  drivers/cxl/core/core.h    |  11 +---
>  drivers/cxl/core/pci.c     | 115 -----------------------------------
>  drivers/cxl/core/ras_rch.c | 121 +++++++++++++++++++++++++++++++++++++
>  tools/testing/cxl/Kbuild   |   1 +
>  5 files changed, 126 insertions(+), 123 deletions(-)
>  create mode 100644 drivers/cxl/core/ras_rch.c
> 
> diff --git a/drivers/cxl/core/Makefile b/drivers/cxl/core/Makefile
> index b2930cc54f8b..b37f38d502d8 100644
> --- a/drivers/cxl/core/Makefile
> +++ b/drivers/cxl/core/Makefile
> @@ -20,3 +20,4 @@ cxl_core-$(CONFIG_CXL_MCE) += mce.o
>  cxl_core-$(CONFIG_CXL_FEATURES) += features.o
>  cxl_core-$(CONFIG_CXL_EDAC_MEM_FEATURES) += edac.o
>  cxl_core-$(CONFIG_CXL_RAS) += ras.o
> +cxl_core-$(CONFIG_CXL_RAS) += ras_rch.o
> diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
> index bc818de87ccc..724361195057 100644
> --- a/drivers/cxl/core/core.h
> +++ b/drivers/cxl/core/core.h
> @@ -149,6 +149,9 @@ int cxl_ras_init(void);
>  void cxl_ras_exit(void);
>  bool cxl_handle_ras(struct cxl_dev_state *cxlds, void __iomem *ras_base);
>  void cxl_handle_cor_ras(struct cxl_dev_state *cxlds, void __iomem *ras_base);
> +void cxl_dport_map_rch_aer(struct cxl_dport *dport);
> +void cxl_disable_rch_root_ints(struct cxl_dport *dport);
> +void cxl_handle_rdport_errors(struct cxl_dev_state *cxlds);
>  #else
>  static inline int cxl_ras_init(void)
>  {
> @@ -164,14 +167,6 @@ static inline bool cxl_handle_ras(struct cxl_dev_state *cxlds, void __iomem *ras
>  	return false;
>  }
>  static inline void cxl_handle_cor_ras(struct cxl_dev_state *cxlds, void __iomem *ras_base) { }
> -#endif /* CONFIG_CXL_RAS */
> -
> -/* Restricted CXL Host specific RAS functions */
> -#ifdef CONFIG_CXL_RAS
> -void cxl_dport_map_rch_aer(struct cxl_dport *dport);
> -void cxl_disable_rch_root_ints(struct cxl_dport *dport);
> -void cxl_handle_rdport_errors(struct cxl_dev_state *cxlds);
> -#else
>  static inline void cxl_dport_map_rch_aer(struct cxl_dport *dport) { }
>  static inline void cxl_disable_rch_root_ints(struct cxl_dport *dport) { }
>  static inline void cxl_handle_rdport_errors(struct cxl_dev_state *cxlds) { }
> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index e132fff80979..b838c59d7a3c 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
> @@ -632,121 +632,6 @@ void read_cdat_data(struct cxl_port *port)
>  }
>  EXPORT_SYMBOL_NS_GPL(read_cdat_data, "CXL");
>  
> -#ifdef CONFIG_CXL_RAS
> -void cxl_dport_map_rch_aer(struct cxl_dport *dport)
> -{
> -	resource_size_t aer_phys;
> -	struct device *host;
> -	u16 aer_cap;
> -
> -	aer_cap = cxl_rcrb_to_aer(dport->dport_dev, dport->rcrb.base);
> -	if (aer_cap) {
> -		host = dport->reg_map.host;
> -		aer_phys = aer_cap + dport->rcrb.base;
> -		dport->regs.dport_aer = devm_cxl_iomap_block(host, aer_phys,
> -						sizeof(struct aer_capability_regs));
> -	}
> -}
> -
> -void cxl_disable_rch_root_ints(struct cxl_dport *dport)
> -{
> -	void __iomem *aer_base = dport->regs.dport_aer;
> -	u32 aer_cmd_mask, aer_cmd;
> -
> -	if (!aer_base)
> -		return;
> -
> -	/*
> -	 * Disable RCH root port command interrupts.
> -	 * CXL 3.0 12.2.1.1 - RCH Downstream Port-detected Errors
> -	 *
> -	 * This sequence may not be necessary. CXL spec states disabling
> -	 * the root cmd register's interrupts is required. But, PCI spec
> -	 * shows these are disabled by default on reset.
> -	 */
> -	aer_cmd_mask = (PCI_ERR_ROOT_CMD_COR_EN |
> -			PCI_ERR_ROOT_CMD_NONFATAL_EN |
> -			PCI_ERR_ROOT_CMD_FATAL_EN);
> -	aer_cmd = readl(aer_base + PCI_ERR_ROOT_COMMAND);
> -	aer_cmd &= ~aer_cmd_mask;
> -	writel(aer_cmd, aer_base + PCI_ERR_ROOT_COMMAND);
> -}
> -
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
> -void cxl_handle_rdport_errors(struct cxl_dev_state *cxlds)
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
> -
> -	if (severity == AER_CORRECTABLE)
> -		cxl_handle_cor_ras(cxlds, dport->regs.ras);
> -	else
> -		cxl_handle_ras(cxlds, dport->regs.ras);
> -}
> -#endif
> -
>  static int cxl_flit_size(struct pci_dev *pdev)
>  {
>  	if (cxl_pci_flit_256(pdev))
> diff --git a/drivers/cxl/core/ras_rch.c b/drivers/cxl/core/ras_rch.c
> new file mode 100644
> index 000000000000..ed58afd18ecc
> --- /dev/null
> +++ b/drivers/cxl/core/ras_rch.c
> @@ -0,0 +1,121 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/* Copyright(c) 2025 AMD Corporation. All rights reserved. */
> +
> +#include <linux/types.h>
> +#include <linux/aer.h>
> +#include "cxl.h"
> +#include "core.h"
> +#include "cxlmem.h"
> +
> +void cxl_dport_map_rch_aer(struct cxl_dport *dport)
> +{
> +	resource_size_t aer_phys;
> +	struct device *host;
> +	u16 aer_cap;
> +
> +	aer_cap = cxl_rcrb_to_aer(dport->dport_dev, dport->rcrb.base);
> +	if (aer_cap) {
> +		host = dport->reg_map.host;
> +		aer_phys = aer_cap + dport->rcrb.base;
> +		dport->regs.dport_aer =
> +			devm_cxl_iomap_block(host, aer_phys,
> +					     sizeof(struct aer_capability_regs));
> +	}
> +}
> +
> +void cxl_disable_rch_root_ints(struct cxl_dport *dport)
> +{
> +	void __iomem *aer_base = dport->regs.dport_aer;
> +	u32 aer_cmd_mask, aer_cmd;
> +
> +	if (!aer_base)
> +		return;
> +
> +	/*
> +	 * Disable RCH root port command interrupts.
> +	 * CXL 3.0 12.2.1.1 - RCH Downstream Port-detected Errors
> +	 *
> +	 * This sequence may not be necessary. CXL spec states disabling
> +	 * the root cmd register's interrupts is required. But, PCI spec
> +	 * shows these are disabled by default on reset.
> +	 */
> +	aer_cmd_mask = (PCI_ERR_ROOT_CMD_COR_EN |
> +			PCI_ERR_ROOT_CMD_NONFATAL_EN |
> +			PCI_ERR_ROOT_CMD_FATAL_EN);
> +	aer_cmd = readl(aer_base + PCI_ERR_ROOT_COMMAND);
> +	aer_cmd &= ~aer_cmd_mask;
> +	writel(aer_cmd, aer_base + PCI_ERR_ROOT_COMMAND);
> +}
> +
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
> +void cxl_handle_rdport_errors(struct cxl_dev_state *cxlds)
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
> diff --git a/tools/testing/cxl/Kbuild b/tools/testing/cxl/Kbuild
> index b7ea66382f3b..6eceefefb0e0 100644
> --- a/tools/testing/cxl/Kbuild
> +++ b/tools/testing/cxl/Kbuild
> @@ -63,6 +63,7 @@ cxl_core-$(CONFIG_CXL_MCE) += $(CXL_CORE_SRC)/mce.o
>  cxl_core-$(CONFIG_CXL_FEATURES) += $(CXL_CORE_SRC)/features.o
>  cxl_core-$(CONFIG_CXL_EDAC_MEM_FEATURES) += $(CXL_CORE_SRC)/edac.o
>  cxl_core-$(CONFIG_CXL_RAS) += $(CXL_CORE_SRC)/ras.o
> +cxl_core-$(CONFIG_CXL_RAS) += $(CXL_CORE_SRC)/ras_rch.o
>  cxl_core-y += config_check.o
>  cxl_core-y += cxl_core_test.o
>  cxl_core-y += cxl_core_exports.o


