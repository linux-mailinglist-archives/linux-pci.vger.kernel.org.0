Return-Path: <linux-pci+bounces-26570-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84911A99588
	for <lists+linux-pci@lfdr.de>; Wed, 23 Apr 2025 18:40:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5DD433B630E
	for <lists+linux-pci@lfdr.de>; Wed, 23 Apr 2025 16:35:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6687A202961;
	Wed, 23 Apr 2025 16:35:49 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1FE321C170;
	Wed, 23 Apr 2025 16:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745426149; cv=none; b=tf33KE0hYg6qKrKGcpLQhhRBm9q/c512oWwP+X6DTCuPEBABvoPRXiraib2YBUBkm8k3LFOIUpzOqmfzOxDGNQFvyqAFLqhBKBKlSJeEJIQa11Hz4r+/puBaVSwATe5wIpboLBNBls0JboKR0+Gss+at7oL9SQ1mJ4SafV24Nf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745426149; c=relaxed/simple;
	bh=boUVDAU3r+tzDXVrXhJSWVcA6Sw1bXSjkjrO7enIONE=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E7WO5sDJEcIWdlUfKa3cBuVwnkSe6Q8WQS/6wB7NCXBlh0PI1AgottteXGkVq3OnzcPX1MXa1dEd1qqVZhGuQfxbvtncZbgG6y3ZfQ+dJUtGiSHEi/umdmi1gT8CNlYAnsSg9itUbhgnA0bIa2UcJsDZTTQP5ArLIhyDzAIVi/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4ZjPkY3YsKz6M4kJ;
	Thu, 24 Apr 2025 00:31:33 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 0A6F91402EB;
	Thu, 24 Apr 2025 00:35:43 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 23 Apr
 2025 18:35:41 +0200
Date: Wed, 23 Apr 2025 17:35:40 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Terry Bowman <terry.bowman@amd.com>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <nifan.cxl@gmail.com>, <dave@stgolabs.net>,
	<dave.jiang@intel.com>, <alison.schofield@intel.com>,
	<vishal.l.verma@intel.com>, <dan.j.williams@intel.com>,
	<bhelgaas@google.com>, <mahesh@linux.ibm.com>, <ira.weiny@intel.com>,
	<oohall@gmail.com>, <Benjamin.Cheatham@amd.com>, <rrichter@amd.com>,
	<nathan.fontenot@amd.com>, <Smita.KoralahalliChannabasappa@amd.com>,
	<lukas@wunner.de>, <ming.li@zohomail.com>,
	<PradeepVineshReddy.Kodamati@amd.com>
Subject: Re: [PATCH v8 06/16] CXL/PCI: Introduce CXL uncorrectable protocol
 error 'recovery'
Message-ID: <20250423173540.000034b3@huawei.com>
In-Reply-To: <20250327014717.2988633-7-terry.bowman@amd.com>
References: <20250327014717.2988633-1-terry.bowman@amd.com>
	<20250327014717.2988633-7-terry.bowman@amd.com>
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

On Wed, 26 Mar 2025 20:47:07 -0500
Terry Bowman <terry.bowman@amd.com> wrote:

> Create cxl_do_recovery() to provide uncorrectable protocol error (UCE)
> handling. Follow similar design as found in PCIe error driver,
> pcie_do_recovery(). One difference is that cxl_do_recovery() will treat all
> UCEs as fatal with a kernel panic. This is to prevent corruption on CXL
> memory.
> 
> Copy the PCIe error handlers merge_result(). Introduce PCI_ERS_RESULT_PANIC
> and add support in the merge_result() routine.
> 
> Copy pci_walk_bridge() to cxl_walk_bridge(). Make a change to walk the
> first device in all cases.
> 
> Copy report_error_detected() to cxl_report_error_detected(). Update this
> function to populate the CXL error information structure, 'struct
> cxl_prot_error_info', before calling the device error handler.
> 
> Call panic() to halt the system in the case of uncorrectable errors (UCE)
> in cxl_do_recovery(). Export pci_aer_clear_fatal_status() for CXL to use
> if a UCE is not found. In this case the AER status must be cleared and
> uses pci_aer_clear_fatal_status().
> 
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> ---
>  drivers/cxl/core/ras.c | 92 +++++++++++++++++++++++++++++++++++++++++-
>  drivers/pci/pci.h      |  2 -
>  include/linux/pci.h    |  5 +++
>  3 files changed, 96 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/cxl/core/ras.c b/drivers/cxl/core/ras.c
> index eca8f11a05d9..1f94fc08e72b 100644
> --- a/drivers/cxl/core/ras.c
> +++ b/drivers/cxl/core/ras.c
> @@ -141,7 +141,97 @@ int cxl_create_prot_err_info(struct pci_dev *_pdev, int severity,
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_create_prot_err_info, "CXL");
>  
> -static void cxl_do_recovery(struct pci_dev *pdev) { }
> +
> +static pci_ers_result_t merge_result(enum pci_ers_result orig,

Rename perhaps to avoid confusion / grep clashed...

> +				     enum pci_ers_result new)
> +{
> +	if (new == PCI_ERS_RESULT_PANIC)
> +		return PCI_ERS_RESULT_PANIC;
> +
> +	if (new == PCI_ERS_RESULT_NO_AER_DRIVER)
> +		return PCI_ERS_RESULT_NO_AER_DRIVER;
> +
> +	if (new == PCI_ERS_RESULT_NONE)
> +		return orig;
> +
> +	switch (orig) {
> +	case PCI_ERS_RESULT_CAN_RECOVER:
> +	case PCI_ERS_RESULT_RECOVERED:
> +		orig = new;
> +		break;
> +	case PCI_ERS_RESULT_DISCONNECT:
> +		if (new == PCI_ERS_RESULT_NEED_RESET)
> +			orig = PCI_ERS_RESULT_NEED_RESET;
> +		break;
> +	default:
> +		break;
> +	}
> +
> +	return orig;
> +}
> +
> +static void cxl_walk_bridge(struct pci_dev *bridge,
> +			    int (*cb)(struct pci_dev *, void *),
> +			    void *userdata)
> +{
> +	if (cb(bridge, userdata))
> +		return;
> +
> +	if (bridge->subordinate)
> +		pci_walk_bus(bridge->subordinate, cb, userdata);
> +}
> +

Trivial but seems there are two blank lines where one will do.

> +
> +static int cxl_report_error_detected(struct pci_dev *pdev, void *data)
> +{
> +	struct cxl_driver *pdrv;
> +	pci_ers_result_t vote, *result = data;
> +	struct cxl_prot_error_info err_info = { 0 };
> +	const struct cxl_error_handlers *cxl_err_handler;
> +
> +	if (cxl_create_prot_err_info(pdev, AER_FATAL, &err_info))
> +		return 0;
> +
> +	struct device *dev __free(put_device) = get_device(err_info.dev);
> +	if (!dev)
> +		return 0;
> +
> +	pdrv = to_cxl_drv(dev->driver);
> +	if (!pdrv || !pdrv->err_handler ||
> +	    !pdrv->err_handler->error_detected)
> +		return 0;
> +
> +	cxl_err_handler = pdrv->err_handler;
> +	vote = cxl_err_handler->error_detected(dev, &err_info);
> +
> +	*result = merge_result(*result, vote);
> +
> +	return 0;
> +}
> +
> +static void cxl_do_recovery(struct pci_dev *pdev)
> +{
> +	struct pci_host_bridge *host = pci_find_host_bridge(pdev->bus);
> +	pci_ers_result_t status = PCI_ERS_RESULT_CAN_RECOVER;
> +
> +	cxl_walk_bridge(pdev, cxl_report_error_detected, &status);
> +	if (status == PCI_ERS_RESULT_PANIC)
> +		panic("CXL cachemem error.");
> +
> +	/*
> +	 * If we have native control of AER, clear error status in the device
> +	 * that detected the error.  If the platform retained control of AER,
> +	 * it is responsible for clearing this status.  In that case, the
> +	 * signaling device may not even be visible to the OS.
> +	 */
> +	if (host->native_aer) {
> +		pcie_clear_device_status(pdev);
> +		pci_aer_clear_nonfatal_status(pdev);
> +		pci_aer_clear_fatal_status(pdev);
> +	}
> +
> +	pci_info(pdev, "CXL uncorrectable error.\n");
> +}
>  
>  static int cxl_rch_handle_error_iter(struct pci_dev *pdev, void *data)
>  {



