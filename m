Return-Path: <linux-pci+bounces-35804-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 591C6B5172A
	for <lists+linux-pci@lfdr.de>; Wed, 10 Sep 2025 14:43:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5EAD41C819FA
	for <lists+linux-pci@lfdr.de>; Wed, 10 Sep 2025 12:44:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37BD631A555;
	Wed, 10 Sep 2025 12:43:43 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E88BF31B117;
	Wed, 10 Sep 2025 12:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757508223; cv=none; b=t3i6MbTpg0hjR+Czb/6TIYSNMmcPt056pBsUbFlQ5DDbkf27xaKj00CLfmD4xvkHD0AHhGfY4gESaqeB8JbayeM93g7a2Tu/eJNr9WTwReOLJm5D2vY1AAbfHbzJTtDBpYK70W7O9SIXgnoxXybHbs3je/6zJRrB9p6IVnUMdkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757508223; c=relaxed/simple;
	bh=+2TZJn/jYbEmFbdJjtRnq4il2VAT+CuLLgJ3y2/AIr4=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kSns5WEGhNaJFkFlbNekTTeGibtTZMKsEaPNY0GmtDWU73JolhApGSUM5uWK93U0gugWWhGL1V5Tbxk0vvRZRlFS0oiTufViEBCT+rn+JvfkB2z9lUQSRnZcjgarO1yuBwSycKU3PJdsWAflzKQ9v1JnPqAGgglIYhdyRxAqJ90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4cMKzt3Bzsz6LDJ9;
	Wed, 10 Sep 2025 20:40:58 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id D0F431400C8;
	Wed, 10 Sep 2025 20:43:36 +0800 (CST)
Received: from localhost (10.203.177.15) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 10 Sep
 2025 14:43:35 +0200
Date: Wed, 10 Sep 2025 13:43:34 +0100
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
Subject: Re: [PATCH v11 06/23] CXL/AER: Introduce rch_aer.c into AER driver
 for handling CXL RCH errors
Message-ID: <20250910134334.000062b5@huawei.com>
In-Reply-To: <20250827013539.903682-7-terry.bowman@amd.com>
References: <20250827013539.903682-1-terry.bowman@amd.com>
	<20250827013539.903682-7-terry.bowman@amd.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500001.china.huawei.com (7.191.163.213) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Tue, 26 Aug 2025 20:35:21 -0500
Terry Bowman <terry.bowman@amd.com> wrote:

> The restricted CXL Host (RCH) AER error handling logic currently resides
> in the AER driver file, drivers/pci/pcie/aer.c. CXL specific changes are
> conditionally compiled using #ifdefs.
> 
> Improve the AER driver maintainability by separating the RCH specific logic
> from the AER driver's core functionality and removing the ifdefs. Introduce
> drivers/pci/pcie/rch_aer.c for moving the RCH AER logic into.
> 
> Move the CXL logic into the new file but leave helper functions in aer.c
> for now as they will be moved in future patch for CXL virtual hierarchy
> handling.
> 
> 2 changes are required to maintain compilation after the move. Change
> cxl_rch_handle_error() & cxl_rch_enable_rcec() to be non-static inorder for
> accessing from the AER driver in aer.c.
> 
> Introduce CONFIG_CXL_RCH_RAS in cxl/Kconfig. Update pcie/pcie/Makefile to
> conditionally compile rch_aer.c file using CONFIG_CXL_RCH_RAS.
> 
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
Hi Terry,

Sorry it took me so long to get back this.

Anyhow a few 'scope' of export questions inline.

Jonathan


> 
> ---
> Changes in v10->v11:
> - Remove changes in code-split and move to earlier, new patch
> - Add #include <linux/bitfield.h> to cxl_ras.c
> - Move cxl_rch_handle_error() & cxl_rch_enable_rcec() declarations from pci.h
> to aer.h, more localized.
> - Introduce CONFIG_CXL_RCH_RAS, includes Makefile changes, ras.c ifdef changes
> ---
>  drivers/cxl/Kconfig        |   9 +++-
>  drivers/cxl/core/ras.c     |   3 ++
>  drivers/pci/pci.h          |  20 +++++++
>  drivers/pci/pcie/Makefile  |   1 +
>  drivers/pci/pcie/aer.c     | 108 +++----------------------------------
>  drivers/pci/pcie/rch_aer.c |  99 ++++++++++++++++++++++++++++++++++
>  6 files changed, 138 insertions(+), 102 deletions(-)
>  create mode 100644 drivers/pci/pcie/rch_aer.c
> 
> diff --git a/drivers/cxl/Kconfig b/drivers/cxl/Kconfig
> index 1c7c8989fd8b..028201e24523 100644
> --- a/drivers/cxl/Kconfig
> +++ b/drivers/cxl/Kconfig
> @@ -235,5 +235,12 @@ config CXL_MCE
>  
>  config CXL_RAS
>  	def_bool y
> -	depends on ACPI_APEI_GHES && PCIEAER_CXL
> +	depends on ACPI_APEI_GHES && PCIEAER && CXL_PCI
> +
> +config CXL_RCH_RAS
> +	bool "CXL: Restricted CXL Host (RCH) protocol error handling"
> +	def_bool n

Isn't that the default anyway?  So probably drop that explicit default.


> +	depends on CXL_RAS
> +	help
> +	  RAS support for Restricted CXL Host (RCH) defined in CXL1.1.
>  endif

> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index 12215ee72afb..c8a0c0ec0073 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h

> +#ifdef CONFIG_CXL_RAS
> +void pci_aer_unmask_internal_errors(struct pci_dev *dev);
> +bool cxl_error_is_native(struct pci_dev *dev);
> +bool is_internal_error(struct aer_err_info *info);
> +#else
> +static inline void pci_aer_unmask_internal_errors(struct pci_dev *dev) { }
> +static inline bool cxl_error_is_native(struct pci_dev *dev) { return false; }
> +static inline bool is_internal_error(struct aer_err_info *info) { return false; }

For me the ifdef makes sense for the cxl specific one, but not the other two
which I think are reasonable interfaces to expose more generally.

> +#endif
> +
>  #endif /* DRIVERS_PCI_H */
> diff --git a/drivers/pci/pcie/Makefile b/drivers/pci/pcie/Makefile
> index 173829aa02e6..07c299dbcdd7 100644
> --- a/drivers/pci/pcie/Makefile
> +++ b/drivers/pci/pcie/Makefile
> @@ -8,6 +8,7 @@ obj-$(CONFIG_PCIEPORTBUS)	+= pcieportdrv.o bwctrl.o
>  
>  obj-y				+= aspm.o
>  obj-$(CONFIG_PCIEAER)		+= aer.o err.o tlp.o
> +obj-$(CONFIG_CXL_RCH_RAS)	+= rch_aer.o
>  obj-$(CONFIG_PCIEAER_INJECT)	+= aer_inject.o
>  obj-$(CONFIG_PCIE_PME)		+= pme.o
>  obj-$(CONFIG_PCIE_DPC)		+= dpc.o
> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index 7fe9f883f5c5..29de7ee861f7 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -1098,7 +1098,7 @@ static bool find_source_device(struct pci_dev *parent,
>   * Note: AER must be enabled and supported by the device which must be
>   * checked in advance, e.g. with pcie_aer_is_native().
>   */
> -static void pci_aer_unmask_internal_errors(struct pci_dev *dev)
> +void pci_aer_unmask_internal_errors(struct pci_dev *dev)
>  {
>  	int aer = dev->aer_cap;
>  	u32 mask;
> @@ -1111,119 +1111,25 @@ static void pci_aer_unmask_internal_errors(struct pci_dev *dev)
>  	mask &= ~PCI_ERR_COR_INTERNAL;
>  	pci_write_config_dword(dev, aer + PCI_ERR_COR_MASK, mask);
>  }
> +EXPORT_SYMBOL_NS_GPL(pci_aer_unmask_internal_errors, "CXL");
Why put this one in the CXL namespace? 

Maybe check the others as well. For instance is_internal_error()
doesn't feel CXL specific either.


>  
>  /**
>   * pci_aer_handle_error - handle logging error into an event log

> diff --git a/drivers/pci/pcie/rch_aer.c b/drivers/pci/pcie/rch_aer.c
> new file mode 100644
> index 000000000000..bfe071eebf67
> --- /dev/null
> +++ b/drivers/pci/pcie/rch_aer.c


> +static int cxl_rch_handle_error_iter(struct pci_dev *dev, void *data)
> +{
> +	struct aer_err_info *info = (struct aer_err_info *)data;
> +	const struct pci_error_handlers *err_handler;
> +
> +	if (!is_cxl_mem_dev(dev) || !cxl_error_is_native(dev))
> +		return 0;
> +
> +	/* Protect dev->driver */
> +	device_lock(&dev->dev);

Probably not one to bury in this patch (maybe you do it later in which
case ignore this) but given we are touching the code,
	guard(device)(&dev->dev);

to allow early returns and no need to have the goto.

> +
> +	err_handler = dev->driver ? dev->driver->err_handler : NULL;
> +	if (!err_handler)
> +		goto out;
> +
> +	if (info->severity == AER_CORRECTABLE) {
> +		if (err_handler->cor_error_detected)
> +			err_handler->cor_error_detected(dev);
> +	} else if (err_handler->error_detected) {
> +		if (info->severity == AER_NONFATAL)
> +			err_handler->error_detected(dev, pci_channel_io_normal);
> +		else if (info->severity == AER_FATAL)
> +			err_handler->error_detected(dev, pci_channel_io_frozen);
> +	}
> +out:
> +	device_unlock(&dev->dev);
> +	return 0;
> +}


