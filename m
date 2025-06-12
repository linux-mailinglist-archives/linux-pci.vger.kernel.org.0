Return-Path: <linux-pci+bounces-29560-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0688DAD7789
	for <lists+linux-pci@lfdr.de>; Thu, 12 Jun 2025 18:07:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EC2E17AFBE8
	for <lists+linux-pci@lfdr.de>; Thu, 12 Jun 2025 16:05:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC1D129ACCB;
	Thu, 12 Jun 2025 16:06:29 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E855299A8C;
	Thu, 12 Jun 2025 16:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749744389; cv=none; b=FdWP5/sAnYmF3XkRm2zf3svCflRK2x3orPmK1FT4Q1wMqj4J2+bGoGPHxoq9YBAMa4GK6hUEbl9/gHPKg8KZ83A8QpdyN6z8Vk6QUu6w3Murfcx/Kfc5mhE5mpQh2g3XGU6dwBxdHKJ/HdpCS4ToAQs81yqJGF7qXfiOX6i2JVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749744389; c=relaxed/simple;
	bh=VIUv2Ui3nYFGZ2cBKzI5nTq2hiA+kq32TImfGH+4rXk=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QWWIUIt9fyylJ2iqEJk1NvGJZRldYbB/19CZ6qDyeWgcrIfeIIsl0fomE6CMopO+ujABfWeUpTrDR/TI6BDqfHx+YSVvt1EF3uslYkcZXwjKO/L68TjYm2ePW3EA2Evx/9GoPmuKCnBj1B5GDBWDlTSU58HtVAM4KW4eUYMU8VE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bJ6jQ4d5cz6H76Z;
	Fri, 13 Jun 2025 00:02:02 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 97121140136;
	Fri, 13 Jun 2025 00:06:24 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 12 Jun
 2025 18:06:23 +0200
Date: Thu, 12 Jun 2025 17:06:22 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Terry Bowman <terry.bowman@amd.com>
CC: <PradeepVineshReddy.Kodamati@amd.com>, <dave@stgolabs.net>,
	<dave.jiang@intel.com>, <alison.schofield@intel.com>,
	<vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
	<dan.j.williams@intel.com>, <bhelgaas@google.com>, <bp@alien8.de>,
	<ming.li@zohomail.com>, <shiju.jose@huawei.com>, <dan.carpenter@linaro.org>,
	<Smita.KoralahalliChannabasappa@amd.com>, <kobayashi.da-06@fujitsu.com>,
	<yanfei.xu@intel.com>, <rrichter@amd.com>, <peterz@infradead.org>,
	<colyli@suse.de>, <uaisheng.ye@intel.com>,
	<fabio.m.de.francesco@linux.intel.com>, <ilpo.jarvinen@linux.intel.com>,
	<yazen.ghannam@amd.com>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>
Subject: Re: [PATCH v9 05/16] CXL/PCI: Introduce CXL uncorrectable protocol
 error recovery
Message-ID: <20250612170622.000071df@huawei.com>
In-Reply-To: <20250603172239.159260-6-terry.bowman@amd.com>
References: <20250603172239.159260-1-terry.bowman@amd.com>
	<20250603172239.159260-6-terry.bowman@amd.com>
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

On Tue, 3 Jun 2025 12:22:28 -0500
Terry Bowman <terry.bowman@amd.com> wrote:

> Create cxl_do_recovery() to provide uncorrectable protocol error (UCE)
> handling. Follow similar design as found in PCIe error driver,
> pcie_do_recovery(). One difference is cxl_do_recovery() will treat all UCEs
> as fatal with a kernel panic. This is to prevent corruption on CXL memory.
> 
> Copy the PCI error driver's merge_result() and rename as cxl_merge_result().
> Introduce PCI_ERS_RESULT_PANIC and add support in the cxl_merge_result()
> routine.

Do we need a separate version?  PCI won't ever set PCI_ERS_RESULT_PANIC
so new != PCI_ERS_RESULT_PANIC and the first condition would only do
something on CXL.

> 
> Copy pci_walk_bridge() to cxl_walk_bridge(). Make a change to walk the
> first device in all cases.
> 
> Copy the PCI error driver's report_error_detected() to cxl_report_error_detected().
> Note, only CXL Endpoints are currently supported. Add locking for PCI
> device as done in PCI's report_error_detected(). Add reference counting for
> the CXL device responsible for cleanup of the CXL RAS. This is necessary
> to prevent the RAS registers from disappearing before logging is completed.
> 
> Call panic() to halt the system in the case of uncorrectable errors (UCE)
> in cxl_do_recovery(). Export pci_aer_clear_fatal_status() for CXL to use
> if a UCE is not found. In this case the AER status must be cleared and
> uses pci_aer_clear_fatal_status().
> 
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> ---
>  drivers/cxl/core/ras.c | 79 ++++++++++++++++++++++++++++++++++++++++++
>  include/linux/pci.h    |  3 ++
>  2 files changed, 82 insertions(+)
> 
> diff --git a/drivers/cxl/core/ras.c b/drivers/cxl/core/ras.c
> index 9ed5c682e128..715f7221ea3a 100644
> --- a/drivers/cxl/core/ras.c
> +++ b/drivers/cxl/core/ras.c
> @@ -110,8 +110,87 @@ static DECLARE_WORK(cxl_cper_prot_err_work, cxl_cper_prot_err_work_fn);
>  
>  #ifdef CONFIG_PCIEAER_CXL
>  
> +static pci_ers_result_t cxl_merge_result(enum pci_ers_result orig,
> +					 enum pci_ers_result new)
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
> +static int cxl_report_error_detected(struct pci_dev *pdev, void *data)
> +{
> +	pci_ers_result_t vote, *result = data;
> +	struct cxl_dev_state *cxlds;
> +
> +	if ((pci_pcie_type(pdev) != PCI_EXP_TYPE_ENDPOINT) &&
> +	    (pci_pcie_type(pdev) != PCI_EXP_TYPE_RC_END))
> +		return 0;
> +
> +	cxlds = pci_get_drvdata(pdev);
> +	struct device *dev __free(put_device) = get_device(&cxlds->cxlmd->dev);
> +
> +	device_lock(&pdev->dev);
> +	vote = cxl_error_detected(pdev, pci_channel_io_frozen);
> +	*result = cxl_merge_result(*result, vote);
> +	device_unlock(&pdev->dev);
> +
> +	return 0;
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
>  static void cxl_do_recovery(struct pci_dev *pdev)
>  {
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
>  }
>  
>  static int cxl_rch_handle_error_iter(struct pci_dev *pdev, void *data)
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index cd53715d53f3..b0e7545162de 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -870,6 +870,9 @@ enum pci_ers_result {
>  
>  	/* No AER capabilities registered for the driver */
>  	PCI_ERS_RESULT_NO_AER_DRIVER = (__force pci_ers_result_t) 6,
> +
> +	/* System is unstable, panic  */
> +	PCI_ERS_RESULT_PANIC = (__force pci_ers_result_t) 7,
>  };
>  
>  /* PCI bus error event callbacks */


