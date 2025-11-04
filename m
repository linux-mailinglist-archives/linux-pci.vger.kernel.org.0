Return-Path: <linux-pci+bounces-40264-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 328EDC32820
	for <lists+linux-pci@lfdr.de>; Tue, 04 Nov 2025 19:03:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BEB6F4E4072
	for <lists+linux-pci@lfdr.de>; Tue,  4 Nov 2025 18:03:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79EE933BBCB;
	Tue,  4 Nov 2025 18:03:27 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B2CB2F4A1B;
	Tue,  4 Nov 2025 18:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762279407; cv=none; b=Ln4U7QK+TPHEI3PXKgDfvN9FrgtoP4Zh1bYprCkukuzJ22FL/Tr2b1beV5LbQwfOX4L1J7F66KY/QlKE/pe2l3U4R8uqtpfstYbUdU8A60qnwyKo1M8x4ZoFlrKGc+7QJ8umFv5Cyxr2iJ0+OPg2QYu3I+IGQjR7ksXMfFW0+wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762279407; c=relaxed/simple;
	bh=Q1zn8ItUsHkPOaNtqJLrpaeUG7joduusUR85T9TqSaw=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n/TxxL9S0cGunJMqvMDgA1ZoR8bV1MErSgW1eln7jObun0evfmXAbjx7GBTP3E6QT8PpteLDFYI9IczeXLoJqAkmYIDljZymJXdlwdKf7YxfvM98r9lGgJfe9VO41P1Cm+zpPDbAsMn9ZuKE7kdUOQmA1tLa4nnDiw39daAJX4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4d1GXN5pwdzHnGhV;
	Wed,  5 Nov 2025 02:03:16 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id 96C9A1404C6;
	Wed,  5 Nov 2025 02:03:20 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 4 Nov
 2025 18:03:19 +0000
Date: Tue, 4 Nov 2025 18:03:18 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Terry Bowman <terry.bowman@amd.com>
CC: <dave@stgolabs.net>, <dave.jiang@intel.com>, <alison.schofield@intel.com>,
	<dan.j.williams@intel.com>, <bhelgaas@google.com>, <shiju.jose@huawei.com>,
	<ming.li@zohomail.com>, <Smita.KoralahalliChannabasappa@amd.com>,
	<rrichter@amd.com>, <dan.carpenter@linaro.org>,
	<PradeepVineshReddy.Kodamati@amd.com>, <lukas@wunner.de>,
	<Benjamin.Cheatham@amd.com>, <sathyanarayanan.kuppuswamy@linux.intel.com>,
	<linux-cxl@vger.kernel.org>, <alucerop@amd.com>, <ira.weiny@intel.com>,
	<linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>
Subject: Re: [RESEND v13 06/25] cxl: Move CXL driver's RCH error handling
 into core/ras_rch.c
Message-ID: <20251104180318.00005d9a@huawei.com>
In-Reply-To: <20251104170305.4163840-7-terry.bowman@amd.com>
References: <20251104170305.4163840-1-terry.bowman@amd.com>
	<20251104170305.4163840-7-terry.bowman@amd.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100011.china.huawei.com (7.191.174.247) To
 dubpeml100005.china.huawei.com (7.214.146.113)

On Tue, 4 Nov 2025 11:02:46 -0600
Terry Bowman <terry.bowman@amd.com> wrote:

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
Fairly sure this patch had changes seeing as code now in a different file.

A few minor comments inline. With those tidied up
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>


J

> Changes in v12->v13:
> - None
> 
> Changes v11->v12:
> - Moved CXL_RCH_RAS Kconfig definition here from following commit.
> 
> Changes v10->v11:
> - New patch
> ---
>  drivers/cxl/Kconfig        |   7 +++
>  drivers/cxl/core/Makefile  |   1 +
>  drivers/cxl/core/core.h    |   5 +-
>  drivers/cxl/core/pci.c     | 115 -----------------------------------
>  drivers/cxl/core/ras_rch.c | 120 +++++++++++++++++++++++++++++++++++++
>  tools/testing/cxl/Kbuild   |   1 +
>  6 files changed, 132 insertions(+), 117 deletions(-)
>  create mode 100644 drivers/cxl/core/ras_rch.c
> 
> diff --git a/drivers/cxl/Kconfig b/drivers/cxl/Kconfig
> index 217888992c88..ffe6ad981434 100644
> --- a/drivers/cxl/Kconfig
> +++ b/drivers/cxl/Kconfig
> @@ -237,4 +237,11 @@ config CXL_RAS
>  	def_bool y
>  	depends on ACPI_APEI_GHES && PCIEAER && CXL_PCI
>  
> +config CXL_RCH_RAS
> +	bool "CXL: Restricted CXL Host (RCH) protocol error handling"
> +	def_bool n

Don't need to specify a default of no as that is always the default if
not overridden.

> +	depends on CXL_RAS
> +	help
> +	  RAS support for Restricted CXL Host (RCH) defined in CXL1.1.
> +
>  endif
> diff --git a/drivers/cxl/core/Makefile b/drivers/cxl/core/Makefile
> index b2930cc54f8b..fa1d4aed28b9 100644
> --- a/drivers/cxl/core/Makefile
> +++ b/drivers/cxl/core/Makefile
> @@ -20,3 +20,4 @@ cxl_core-$(CONFIG_CXL_MCE) += mce.o
>  cxl_core-$(CONFIG_CXL_FEATURES) += features.o
>  cxl_core-$(CONFIG_CXL_EDAC_MEM_FEATURES) += edac.o
>  cxl_core-$(CONFIG_CXL_RAS) += ras.o
> +cxl_core-$(CONFIG_CXL_RCH_RAS) += ras_rch.o
> diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
> index bc818de87ccc..c30ab7c25a92 100644
> --- a/drivers/cxl/core/core.h
> +++ b/drivers/cxl/core/core.h
> @@ -4,6 +4,7 @@
>  #ifndef __CXL_CORE_H__
>  #define __CXL_CORE_H__
>  
> +#include <linux/pci.h>
Why this include. I'm not spotting anything pci specific being added to this header.
If it should already have been here, belongs in a separate patch.

>  #include <cxl/mailbox.h>
>  #include <linux/rwsem.h>
>  
> @@ -167,7 +168,7 @@ static inline void cxl_handle_cor_ras(struct cxl_dev_state *cxlds, void __iomem
>  #endif /* CONFIG_CXL_RAS */
>  
>  /* Restricted CXL Host specific RAS functions */
> -#ifdef CONFIG_CXL_RAS
> +#ifdef CONFIG_CXL_RCH_RAS
>  void cxl_dport_map_rch_aer(struct cxl_dport *dport);
>  void cxl_disable_rch_root_ints(struct cxl_dport *dport);
>  void cxl_handle_rdport_errors(struct cxl_dev_state *cxlds);
> @@ -175,7 +176,7 @@ void cxl_handle_rdport_errors(struct cxl_dev_state *cxlds);
>  static inline void cxl_dport_map_rch_aer(struct cxl_dport *dport) { }
>  static inline void cxl_disable_rch_root_ints(struct cxl_dport *dport) { }
>  static inline void cxl_handle_rdport_errors(struct cxl_dev_state *cxlds) { }
> -#endif /* CONFIG_CXL_RAS */
> +#endif /* CONFIG_CXL_RCH_RAS */
>  
>  int cxl_gpf_port_setup(struct cxl_dport *dport);

> diff --git a/drivers/cxl/core/ras_rch.c b/drivers/cxl/core/ras_rch.c
> new file mode 100644
> index 000000000000..f6de5492a8b7
> --- /dev/null
> +++ b/drivers/cxl/core/ras_rch.c
> @@ -0,0 +1,120 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/* Copyright(c) 2025 AMD Corporation. All rights reserved. */
> +
> +#include <linux/pci.h>
> +#include <linux/aer.h>
> +#include <cxl/event.h>
> +#include <cxlmem.h>
> +#include "trace.h"
We should be trying to follow include what you use principles.
So linux/types.h for resource_size_t
Probably a forwards def for struct device as well.


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
> +		dport->regs.dport_aer = devm_cxl_iomap_block(host, aer_phys,
> +							     sizeof(struct aer_capability_regs));
Maybe keep original alignment or even something like
		dport->regs.dport_aer =
			devm_cxl_iomap_block(host, aer_phys,
					     sizeof(struct aer_capability_regs));


> +	}
> +}
> +




