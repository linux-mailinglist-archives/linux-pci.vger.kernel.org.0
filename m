Return-Path: <linux-pci+bounces-30912-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A8B8AAEB48B
	for <lists+linux-pci@lfdr.de>; Fri, 27 Jun 2025 12:27:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C68418908B8
	for <lists+linux-pci@lfdr.de>; Fri, 27 Jun 2025 10:27:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1AB22949F5;
	Fri, 27 Jun 2025 10:24:43 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C3BC296145;
	Fri, 27 Jun 2025 10:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751019883; cv=none; b=Q8nrweB2IgrMHUflY1PHKC8Biio+6J8tjx7VuG2MDRlyEYQg6pxji0Kjn+LurDq/ycV+5Z91gO1SsHNbcrN5mixkkxJF7FlXZUPYhynl3EfhYHvp+GKr1D4J+au67WCqsOatiTGbgNZxwWE1JLX7bHUXTNQAAWjpQHg+UBM1Zmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751019883; c=relaxed/simple;
	bh=BCbatr1KZPFWU9OTfqGjZ/24IBVjG/LV+9y/pRxtkMM=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ubJpDTpkqgiO19sPpbQCVnmEutOEJaTuqBO7G2XLv6G2bLjk99R0DaB8uxKk5Kvlci2KYgG5+D9DYnxTOq1zCa0a+ZJ+HgJqcDz0mjh/zB/uN2WPsjDZftFp1P9c7hTvRCLNFJNJSBj0EuX+g5NegvI/YedpUZO4eT6P6JxgQOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bTBVx1RGyz6L50b;
	Fri, 27 Jun 2025 18:24:25 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 77F431402EC;
	Fri, 27 Jun 2025 18:24:34 +0800 (CST)
Received: from localhost (10.48.153.213) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 27 Jun
 2025 12:24:33 +0200
Date: Fri, 27 Jun 2025 11:24:29 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Terry Bowman <terry.bowman@amd.com>
CC: <dave@stgolabs.net>, <dave.jiang@intel.com>, <alison.schofield@intel.com>,
	<dan.j.williams@intel.com>, <bhelgaas@google.com>, <shiju.jose@huawei.com>,
	<ming.li@zohomail.com>, <Smita.KoralahalliChannabasappa@amd.com>,
	<rrichter@amd.com>, <dan.carpenter@linaro.org>,
	<PradeepVineshReddy.Kodamati@amd.com>, <lukas@wunner.de>,
	<Benjamin.Cheatham@amd.com>, <sathyanarayanan.kuppuswamy@linux.intel.com>,
	<linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-pci@vger.kernel.org>
Subject: Re: [PATCH v10 05/17] CXL/AER: Introduce kfifo for forwarding CXL
 errors
Message-ID: <20250627112429.00007155@huawei.com>
In-Reply-To: <20250626224252.1415009-6-terry.bowman@amd.com>
References: <20250626224252.1415009-1-terry.bowman@amd.com>
	<20250626224252.1415009-6-terry.bowman@amd.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100006.china.huawei.com (7.191.160.224) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Thu, 26 Jun 2025 17:42:40 -0500
Terry Bowman <terry.bowman@amd.com> wrote:

> CXL error handling will soon be moved from the AER driver into the CXL
> driver. This requires a notification mechanism for the AER driver to share
> the AER interrupt with the CXL driver. The notification will be used
> as an indication for the CXL drivers to handle and log the CXL RAS errors.
> 
> First, introduce cxl/core/native_ras.c to contain changes for the CXL
> driver's RAS native handling. This as an alternative to dropping the
> changes into existing cxl/core/ras.c file with purpose to avoid #ifdefs.
> Introduce CXL Kconfig CXL_NATIVE_RAS, dependent on PCIEAER_CXL, to
> conditionally compile the new file.
> 
> Add a kfifo work queue to be used by the AER driver and CXL driver. The AER
> driver will be the sole kfifo producer adding work and the cxl_core will be
> the sole kfifo consumer removing work. Add the boilerplate kfifo support.
> 
> Add CXL work queue handler registration functions in the AER driver. Export
> the functions allowing CXL driver to access. Implement registration
> functions for the CXL driver to assign or clear the work handler function.
> 
> Introduce 'struct cxl_proto_err_info' to serve as the kfifo work data. This
> will contain the erring device's PCI SBDF details used to rediscover the
> device after the CXL driver dequeues the kfifo work. The device rediscovery
> will be introduced along with the CXL handling in future patches.
> 
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
Hi Terry,

Whilst it obviously makes patch preparation a bit more time consuming
for series like this with many patches it can be useful to add a brief
change log to the individual patches as well as the cover letter.
That helps reviewers figure out where they need to look again.

A few trivial things inline.

With those fixed up
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>

Jonathan


> ---
>  drivers/cxl/Kconfig           | 14 ++++++++
>  drivers/cxl/core/Makefile     |  1 +
>  drivers/cxl/core/core.h       |  8 +++++
>  drivers/cxl/core/native_ras.c | 26 +++++++++++++++
>  drivers/cxl/core/port.c       |  2 ++
>  drivers/cxl/core/ras.c        |  1 +
>  drivers/cxl/cxlpci.h          |  1 +
>  drivers/pci/pci.h             |  4 +++
>  drivers/pci/pcie/aer.c        |  7 ++--
>  drivers/pci/pcie/cxl_aer.c    | 60 +++++++++++++++++++++++++++++++++++
>  include/linux/aer.h           | 31 ++++++++++++++++++
>  11 files changed, 153 insertions(+), 2 deletions(-)
>  create mode 100644 drivers/cxl/core/native_ras.c


>  static void cxl_cper_trace_corr_port_prot_err(struct pci_dev *pdev,
> diff --git a/drivers/cxl/cxlpci.h b/drivers/cxl/cxlpci.h
> index 54e219b0049e..6f1396ef7b77 100644
> --- a/drivers/cxl/cxlpci.h
> +++ b/drivers/cxl/cxlpci.h
> @@ -4,6 +4,7 @@
>  #define __CXL_PCI_H__
>  #include <linux/pci.h>
>  #include "cxl.h"
> +#include "linux/aer.h"

Why?  There are no changes in this header other than the include and the changes
to linux/aer.h are new stuff so I can't see how it becomes necessary if it
wasn't before.

Might well have always been missing and should have been here. If so separate
patch to tidy that up.

>  
>  #define CXL_MEMORY_PROGIF	0x10
>  


> diff --git a/drivers/pci/pcie/cxl_aer.c b/drivers/pci/pcie/cxl_aer.c
> index b2ea14f70055..846ab55d747c 100644
> --- a/drivers/pci/pcie/cxl_aer.c
> +++ b/drivers/pci/pcie/cxl_aer.c

>  static int cxl_rch_handle_error_iter(struct pci_dev *dev, void *data)
>  {
>  	struct aer_err_info *info = (struct aer_err_info *)data;
> @@ -136,3 +152,47 @@ void cxl_rch_enable_rcec(struct pci_dev *rcec)
>  	pci_info(rcec, "CXL: Internal errors unmasked");
>  }
>  
> +static DEFINE_KFIFO(cxl_proto_err_fifo, struct cxl_proto_err_work_data,
> +		    CXL_ERROR_SOURCES_MAX);
> +static DEFINE_SPINLOCK(cxl_proto_err_fifo_lock);
> +struct work_struct *cxl_proto_err_work;

I'm not seeing a declaration for this in the headers, so can it be static?

This is made a little more confusing as in this patch we have both
a structure called cxl_proto_err_work and a pointer to it with exactly the
same name.  Maybe rename this so it's subtly different.  cxl_protocol_err_work
or something silly like that just to make reviewers life a tiny bit easier!

> +

> diff --git a/include/linux/aer.h b/include/linux/aer.h
> index 02940be66324..24c3d9e18ad5 100644
> --- a/include/linux/aer.h
> +++ b/include/linux/aer.h
> @@ -10,6 +10,7 @@
>  
>  #include <linux/errno.h>
>  #include <linux/types.h>
> +#include <linux/workqueue_types.h>
>  
>  #define AER_NONFATAL			0
>  #define AER_FATAL			1
> @@ -53,6 +54,26 @@ struct aer_capability_regs {
>  	u16 uncor_err_source;
>  };
>  
> +/**
> + * struct cxl_proto_err_info - Error information used in CXL error handling
> + * @severity: AER severity
> + * @function: Device's PCI function

Run kernel-doc over the files and fix errors / warning.
Missed updating this to devfn which it would have shouted about.

> + * @device: Device's PCI device
> + * @bus: Device's PCI bus
> + * @segment: Device's PCI segment
> + */
> +struct cxl_proto_error_info {
> +	int severity;
> +
> +	u8 devfn;
> +	u8 bus;
> +	u16 segment;
> +};


