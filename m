Return-Path: <linux-pci+bounces-26562-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF456A9951A
	for <lists+linux-pci@lfdr.de>; Wed, 23 Apr 2025 18:29:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA3D34609B4
	for <lists+linux-pci@lfdr.de>; Wed, 23 Apr 2025 16:29:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE7B828137D;
	Wed, 23 Apr 2025 16:28:51 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99A27149E17;
	Wed, 23 Apr 2025 16:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745425731; cv=none; b=RVa83ae37NzJYGBu1Pb+ZVZTCVhhuNRjg4oItk2Osl1f5fuoaYOZQ5HwAvhDItZtKPKMUlJZJk6e/U+N+s/BDVs2zfFWrC6vfnWVollBqicgUZORrHSkhVjXj3VILpohc6ynLN8JMVOmOmmNgbaWVr4bxTzqSTg3J3zJe3pxH7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745425731; c=relaxed/simple;
	bh=Z0fDQOuwRcguhZ1Or6eiI96vfRR7I8y0ZUeQ9q8xSMU=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TmU7tqViQVjOw8nSfmWXatuFso3/ia5HWSJ4YgjlO8QeufotkKWWfQ2bWa+Q4ieyjhCkwt5QdzCB21Q68tMCrdAa++vwYgIloVG4a76CFoepzMIQg8dScQscIH5BYWTKkAITJJxsPgoGrrswXHIfXs7D8DTjupflNwTA+ZdD9s0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4ZjPdK0sRpz6L570;
	Thu, 24 Apr 2025 00:27:01 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id D35CB1400DB;
	Thu, 24 Apr 2025 00:28:44 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 23 Apr
 2025 18:28:44 +0200
Date: Wed, 23 Apr 2025 17:28:42 +0100
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
Subject: Re: [PATCH v8 05/16] PCI/AER: CXL driver dequeues CXL error
 forwarded from AER service driver
Message-ID: <20250423172842.00002c40@huawei.com>
In-Reply-To: <20250327014717.2988633-6-terry.bowman@amd.com>
References: <20250327014717.2988633-1-terry.bowman@amd.com>
	<20250327014717.2988633-6-terry.bowman@amd.com>
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

On Wed, 26 Mar 2025 20:47:06 -0500
Terry Bowman <terry.bowman@amd.com> wrote:

> The AER driver is now designed to forward CXL protocol errors to the CXL
> driver. Update the CXL driver with functionality to dequeue the forwarded
> CXL error from the kfifo. Also, update the CXL driver to process the CXL
> protocol errors using CXL protocol error handlers.
> 
> First, move cxl_rch_handle_error_iter() from aer.c to cxl/core/ras.c.
> Remove and drop the cxl_rch_handle_error() in aer.c as it is not needed.
> 
> Introduce function cxl_prot_err_work_fn() to dequeue work forwarded by the
> AER service driver. This will begin the CXL protocol error processing
> with the call to cxl_handle_prot_error().
> 
> Introduce cxl_handle_prot_error() to differntiate between Restricted CXL
> Host (RCH) protocol errors and CXL virtual host (VH) protocol errors.
> RCH errors will be processed with a call to walk the associated Root
> Complex Event Collector's (RCEC) secondary bus looking for the Root Complex
> Integrated Endpoint (RCiEP) to handle the RCH error. Export pcie_walk_rcec()
> so the CXL driver can walk the RCEC's downstream bus, searching for
> the RCiEP.
> 
> VH correctable error (CE) processing will call the CXL CE handler if
> present. VH uncorrectable errors (UCE) will call cxl_do_recovery(),
> implemented as a stub for now and to be updated in future patch. Export
> pci_aer_clean_fatal_status() and pci_clean_device_status() used to clean up
> AER status after handling.
> 
> Create cxl_driver::error_handler structure similar to
> pci_driver::error_handlers. Add handlers for CE and UCE CXL.io errors. Add
> 'struct cxl_prot_error_info' as a parameter to the CXL CE and UCE error
> handlers.
> 
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> ---
>  drivers/cxl/core/ras.c  | 102 +++++++++++++++++++++++++++++++++++++++-
>  drivers/cxl/cxl.h       |  17 +++++++
>  drivers/pci/pci.c       |   1 +
>  drivers/pci/pci.h       |   6 ---
>  drivers/pci/pcie/aer.c  |  42 +----------------
>  drivers/pci/pcie/rcec.c |   1 +
>  include/linux/aer.h     |   2 +
>  include/linux/pci.h     |  10 ++++
>  8 files changed, 133 insertions(+), 48 deletions(-)
> 
> diff --git a/drivers/cxl/core/ras.c b/drivers/cxl/core/ras.c
> index ecb60a5962de..eca8f11a05d9 100644
> --- a/drivers/cxl/core/ras.c
> +++ b/drivers/cxl/core/ras.c
> @@ -139,8 +139,108 @@ int cxl_create_prot_err_info(struct pci_dev *_pdev, int severity,
>  
>  	return 0;
>  }
> +EXPORT_SYMBOL_NS_GPL(cxl_create_prot_err_info, "CXL");
>  
> -struct work_struct cxl_prot_err_work;
> +static void cxl_do_recovery(struct pci_dev *pdev) { }
> +
> +static int cxl_rch_handle_error_iter(struct pci_dev *pdev, void *data)
> +{
> +	struct cxl_prot_error_info *err_info = data;
> +	const struct cxl_error_handlers *err_handler;
> +	struct device *dev = err_info->dev;
> +	struct cxl_driver *pdrv;
> +
> +	/*
> +	 * The capability, status, and control fields in Device 0,
> +	 * Function 0 DVSEC control the CXL functionality of the
> +	 * entire device (CXL 3.0, 8.1.3).
> +	 */
> +	if (pdev->devfn != PCI_DEVFN(0, 0))
> +		return 0;
> +
> +	/*
> +	 * CXL Memory Devices must have the 502h class code set (CXL
> +	 * 3.0, 8.1.12.1).
> +	 */
> +	if ((pdev->class >> 8) != PCI_CLASS_MEMORY_CXL)
> +		return 0;
> +
> +	if (!is_cxl_memdev(dev) || !dev->driver)
> +		return 0;
> +
> +	pdrv = to_cxl_drv(dev->driver);
> +	if (!pdrv || !pdrv->err_handler)
> +		return 0;
> +
> +	err_handler = pdrv->err_handler;
> +	if (err_info->severity == AER_CORRECTABLE) {
> +		if (err_handler->cor_error_detected)
> +			err_handler->cor_error_detected(dev, err_info);
> +	} else if (err_handler->error_detected) {
> +		cxl_do_recovery(pdev);
> +	}
> +
> +	return 0;
> +}
> +
> +static void cxl_handle_prot_error(struct pci_dev *pdev, struct cxl_prot_error_info *err_info)
> +{
> +	if (!pdev || !err_info)

Are these real potential conditions?  If so can we have a comment on why.
If this is defensive only, do we need it? 
Looks like the caller below checked pdev already.

> +		return;
> +
> +	/*
> +	 * Internal errors of an RCEC indicate an AER error in an
> +	 * RCH's downstream port. Check and handle them in the CXL.mem
> +	 * device driver.
> +	 */
> +	if (pci_pcie_type(pdev) == PCI_EXP_TYPE_RC_EC)
> +		return pcie_walk_rcec(pdev, cxl_rch_handle_error_iter, err_info);
> +
> +	if (err_info->severity == AER_CORRECTABLE) {
> +		struct device *dev __free(put_device) = get_device(err_info->dev);

Similar question around lifetimes. The caller already got this. Why again?

> +		struct cxl_driver *pdrv;

calling a cxl driver pdrv seems odd.  cdrv maybe?

> +		int aer = pdev->aer_cap;
> +
> +		if (!dev || !dev->driver)
> +			return;
> +
> +		if (aer) {
> +			int ras_status;
> +
> +			pci_read_config_dword(pdev, aer + PCI_ERR_COR_STATUS, &ras_status);

If we get multiple bits set in this register, can this wipe out ones we haven't noticed
anywhere else in the handling?  Bad tlp etc.  Maybe we need to ensure this only clears
the internal error bit?

> +			pci_write_config_dword(pdev, aer + PCI_ERR_COR_STATUS,
> +					       ras_status);
> +		}
> +
> +		pdrv = to_cxl_drv(dev->driver);
> +		if (!pdrv || !pdrv->err_handler ||
> +		    !pdrv->err_handler->cor_error_detected)
> +			return;
> +
> +		pdrv->err_handler->cor_error_detected(dev, err_info);
> +		pcie_clear_device_status(pdev);
> +	} else {
> +		cxl_do_recovery(pdev);
> +	}
> +}
> +
> +static void cxl_prot_err_work_fn(struct work_struct *work)
> +{
> +	struct cxl_prot_err_work_data wd;
> +
> +	while (cxl_prot_err_kfifo_get(&wd)) {
> +		struct cxl_prot_error_info *err_info = &wd.err_info;
> +		struct device *dev __free(put_device) = get_device(err_info->dev);
> +		struct pci_dev *pdev __free(pci_dev_put) = pci_dev_get(err_info->pdev);
> +
> +		if (!dev || !pdev)
> +			continue;
> +
> +		cxl_handle_prot_error(pdev, err_info);
> +	}
> +}
> +
> +static DECLARE_WORK(cxl_prot_err_work, cxl_prot_err_work_fn);

Ah! Here it is... I think this can be in patch 3. With a stub of the function
(which is what the patch 3 description claims is there).

>  

Jonathan


