Return-Path: <linux-pci+bounces-30915-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ED74AEB5A0
	for <lists+linux-pci@lfdr.de>; Fri, 27 Jun 2025 13:01:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B62291C21EDF
	for <lists+linux-pci@lfdr.de>; Fri, 27 Jun 2025 11:01:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24D8229A9E4;
	Fri, 27 Jun 2025 11:01:08 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7179293C76;
	Fri, 27 Jun 2025 11:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751022068; cv=none; b=MfVmzMWbyYP3Wpad8AR35OPn1EIk+RE7r5LO69nifbN6OSR4yvF0vRiMITgnRyhxGZ+vHJyzgWn4tx2g2hT9dFxawohxATnqg8q/B2yOin2+WyNarIqYm1Ob3rFSY5c91HXlNoCmDhaBbSbR6tmYXqkBD3RvLE+zNyt0ZXtkevQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751022068; c=relaxed/simple;
	bh=N3XRBdiKzMPDGgz2NDdVvWFw0c6XbfWNBNrfipfZlyA=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bNi9q/zadiEgR2dZ+dw8jXl9qlY/iXE2png8n5XllfC8ivmrnbIWlM7/fLyVUjllKS7LgBgYYnsvZ6ymMddNvqeFsTlHVJw/kXhyICoTsqkpDYkNQ699fT2ZIqHiBFC9EMKtuJG0PWGnZb8XgZ2CYqrKQdZQWTbhAXDe+UMgDjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bTCJF2Ybxz6M4sX;
	Fri, 27 Jun 2025 19:00:13 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id DF7641402ED;
	Fri, 27 Jun 2025 19:01:01 +0800 (CST)
Received: from localhost (10.48.153.213) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 27 Jun
 2025 13:00:52 +0200
Date: Fri, 27 Jun 2025 12:00:50 +0100
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
Subject: Re: [PATCH v10 06/17] PCI/AER: Dequeue forwarded CXL error
Message-ID: <20250627120050.00001461@huawei.com>
In-Reply-To: <20250626224252.1415009-7-terry.bowman@amd.com>
References: <20250626224252.1415009-1-terry.bowman@amd.com>
	<20250626224252.1415009-7-terry.bowman@amd.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500004.china.huawei.com (7.191.163.9) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Thu, 26 Jun 2025 17:42:41 -0500
Terry Bowman <terry.bowman@amd.com> wrote:

> The AER driver is now designed to forward CXL protocol errors to the CXL
> driver. Update the CXL driver with functionality to dequeue the forwarded
> CXL error from the kfifo. Also, update the CXL driver to begin the protocol
> error handling processing using the work received from the FIFO.
> 
> Introduce function cxl_proto_err_work_fn() to dequeue work forwarded by the

After earlier update it already exists, you are just filling it in here.
So reword this.

> AER service driver. This will begin the CXL protocol error processing with
> a call to cxl_handle_proto_error().
> 
> Update cxl/core/native_ras.c by adding cxl_rch_handle_error_iter() that was
> previously in the AER driver. Add check that Endpoint is bound to a CXL
> driver.
> 
> Introduce logic to take the SBDF values from 'struct cxl_proto_error_info'
> and use in discovering the erring PCI device. The call to pci_get_domain_bus_and_slot()
> will return a reference counted 'struct pci_dev *'. This will serve as
> reference count to prevent releasing the CXL Endpoint's mapped RAS while
> handling the error. Use scope base __free() to put the reference count.
> This will change when adding support for CXL port devices in the future.
> 
> Implement cxl_handle_proto_error() to differentiate between Restricted CXL
> Host (RCH) protocol errors and CXL virtual host (VH) protocol errors. RCH
> errors will be processed with a call to walk the associated Root Complex
> Event Collector's (RCEC) secondary bus looking for the Root Complex
> Integrated Endpoint (RCiEP) to handle the RCH error. Export pcie_walk_rcec()
> so the CXL driver can walk the RCEC's downstream bus, searching for the
> RCiEP.

I'd drop the RCiEP description beyond saying 'handle it as before'
as I think there is no major change in this.

> 
> VH correctable error (CE) processing will call the CXL CE handler. VH
> uncorrectable errors (UCE) will call cxl_do_recovery(), implemented as a
> stub for now and to be updated in future patch. Export pci_aer_clean_fatal_status()
> and pci_clean_device_status() used to clean up AER status after handling.
> 
> Maintain the locking logic found in the original AER driver. Replace the
> existing device_lock() in cxl_rch_handle_error_iter() to use guard(device)
> lock for maintainability.

This change is fine, but it is an AND change in a patch doing quite a few other
things.  So do it in a trivial precursor patch.  Look at the other things in this
description and see if they can be factored out too so that the guts of this
patch are much easier to spot.


> CE errors did not include locking in previous driver
> implementation. Leave the updated CE handling path as-is.
> 
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
A few comments inline.

Jonathan

> ---
>  drivers/cxl/core/native_ras.c | 87 +++++++++++++++++++++++++++++++++++
>  drivers/cxl/cxlpci.h          |  1 +
>  drivers/cxl/pci.c             |  6 +++
>  drivers/pci/pci.c             |  1 +
>  drivers/pci/pci.h             |  7 ---
>  drivers/pci/pcie/aer.c        |  1 +
>  drivers/pci/pcie/cxl_aer.c    | 41 -----------------
>  drivers/pci/pcie/rcec.c       |  1 +
>  include/linux/aer.h           |  2 +
>  include/linux/pci.h           | 10 ++++
>  10 files changed, 109 insertions(+), 48 deletions(-)
> 
> diff --git a/drivers/cxl/core/native_ras.c b/drivers/cxl/core/native_ras.c
> index 011815ddaae3..5bd79d5019e7 100644
> --- a/drivers/cxl/core/native_ras.c
> +++ b/drivers/cxl/core/native_ras.c
> @@ -6,9 +6,96 @@
>  #include <cxl/event.h>
>  #include <cxlmem.h>
>  #include <core/core.h>
> +#include <cxlpci.h>
> +
> +static void cxl_do_recovery(struct pci_dev *pdev)
> +{
> +}
> +
> +static bool is_cxl_rcd(struct pci_dev *pdev)
> +{
> +	if (pci_pcie_type(pdev) != PCI_EXP_TYPE_RC_END)
> +		return false;
> +
> +	/*
> +	 * The capability, status, and control fields in Device 0,
> +	 * Function 0 DVSEC control the CXL functionality of the
> +	 * entire device (CXL 3.2, 8.1.3).
> +	 */
> +	if (pdev->devfn != PCI_DEVFN(0, 0))
> +		return false;
> +
> +	/*
> +	 * CXL Memory Devices must have the 502h class code set (CXL

Short wrap.

> +	 * 3.2, 8.1.12.1).
> +	 */
> +	if (FIELD_GET(PCI_CLASS_CODE_MASK, pdev->class) != PCI_CLASS_MEMORY_CXL)
> +		return false;
> +
> +	return true;


If this isn't going to get more complex

	return FIELD_GET(...)

> +}
> +
> +static int cxl_rch_handle_error_iter(struct pci_dev *pdev, void *data)
> +{
> +	struct cxl_proto_error_info *err_info = data;
> +
> +	guard(device)(&pdev->dev);
> +
> +	if (!is_cxl_rcd(pdev) || !cxl_pci_drv_bound(pdev))
> +		return 0;
> +
> +	if (err_info->severity == AER_CORRECTABLE)
> +		cxl_cor_error_detected(pdev);
> +	else
> +		cxl_error_detected(pdev, pci_channel_io_frozen);
> +
> +	return 1;
> +}
> +
> +static void cxl_handle_proto_error(struct cxl_proto_error_info *err_info)
> +{
> +	struct pci_dev *pdev __free(pci_dev_put) =
> +		pci_get_domain_bus_and_slot(err_info->segment,
> +					    err_info->bus,
> +					    err_info->devfn);
> +
> +	if (!pdev) {
> +		pr_err("Failed to find the CXL device (SBDF=%x:%x:%x:%x)\n",
> +		       err_info->segment, err_info->bus, PCI_SLOT(err_info->devfn),
> +		       PCI_FUNC(err_info->devfn));
> +		return;
> +	}
> +
> +	/*
> +	 * Internal errors of an RCEC indicate an AER error in an
> +	 * RCH's downstream port. Check and handle them in the CXL.mem
> +	 * device driver.

I don't think the reference here to the CXL.mem driver is that helpful
given the code is immediate above. Maybe move the comment?


> +	 */
> +	if (pci_pcie_type(pdev) == PCI_EXP_TYPE_RC_EC)
> +		return pcie_walk_rcec(pdev, cxl_rch_handle_error_iter, err_info);
> +
> +	if (err_info->severity == AER_CORRECTABLE) {
> +		int aer = pdev->aer_cap;
> +
> +		if (aer)
> +			pci_clear_and_set_config_dword(pdev,
> +						       aer + PCI_ERR_COR_STATUS,
> +						       0, PCI_ERR_COR_INTERNAL);
> +
> +		cxl_cor_error_detected(pdev);
> +
> +		pcie_clear_device_status(pdev);
> +	} else {
> +		cxl_do_recovery(pdev);
> +	}
> +}



