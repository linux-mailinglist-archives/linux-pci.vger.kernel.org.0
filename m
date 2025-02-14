Return-Path: <linux-pci+bounces-21467-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DBD0EA3611C
	for <lists+linux-pci@lfdr.de>; Fri, 14 Feb 2025 16:12:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C74216F718
	for <lists+linux-pci@lfdr.de>; Fri, 14 Feb 2025 15:12:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55EC2266189;
	Fri, 14 Feb 2025 15:11:57 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E9BE3595C;
	Fri, 14 Feb 2025 15:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739545917; cv=none; b=BeYwVwl9l8hex8m9umqXk7zAa0QsMxs941boHPY8Q+HGo+HKHCzlzoh3jAJamytWgXIAei1qlS6zuB4+K1259RMjN89x6DSJo3JbxJwsJRsV/kTNaWMBucMAWYDkUnyO5xghUS+wfGGuVOx7UOJILxZaeym0KlanWEePBLFVSMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739545917; c=relaxed/simple;
	bh=9iiDSRSxBmUzKWUuI10Xjb8WAH71L18L9CmmiYg+ego=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tqCzBEve/KKUfgiDqnMUB7c8PvXdA3dHhnMDE/0dVPOh74C+tkXwyQXaoeYKwy0ZAErwdg+RgVeRkzkExsvKfCtdaJV8x6v3CaF2GXWCHMLJjw91ruDEb9ZiGCNsLNDAycEeLV744hZy5JtTOAtgEAvf5oHDsHpWdGQndivjIUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Yvb8P3gfRz6HJgG;
	Fri, 14 Feb 2025 23:10:29 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 21B431404F5;
	Fri, 14 Feb 2025 23:11:51 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 14 Feb
 2025 16:11:50 +0100
Date: Fri, 14 Feb 2025 15:11:48 +0000
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
Subject: Re: [PATCH v7 06/17] PCI/AER: Add CXL PCIe Port uncorrectable error
 recovery in AER service driver
Message-ID: <20250214151148.000033f4@huawei.com>
In-Reply-To: <20250211192444.2292833-7-terry.bowman@amd.com>
References: <20250211192444.2292833-1-terry.bowman@amd.com>
	<20250211192444.2292833-7-terry.bowman@amd.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100004.china.huawei.com (7.191.162.219) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Tue, 11 Feb 2025 13:24:33 -0600
Terry Bowman <terry.bowman@amd.com> wrote:

> Existing recovery procedure for PCIe uncorrectable errors (UCE) does not
> apply to CXL devices. Recovery can not be used for CXL devices because of
> potential corruption on what can be system memory. Also, current PCIe UCE
> recovery, in the case of a Root Port (RP) or Downstream Switch Port (DSP),
> does not begin at the RP/DSP but begins at the first downstream device.
> This will miss handling CXL Protocol Errors in a CXL RP or DSP. A separate
> CXL recovery is needed because of the different handling requirements
> 
> Add a new function, cxl_do_recovery() using the following.
> 
> Add cxl_walk_bridge() to iterate the detected error's sub-topology.
> cxl_walk_bridge() is similar to pci_walk_bridge() but the CXL flavor
> will begin iteration at the RP or DSP rather than beginning at the
Hi Terry,

Trivial nitpick but you wrap point is shrinking wrt to the previous paragraph.
Just looks odd rather than actually mattering :)

> first downstream device.
> 
> pci_walk_bridge() is candidate to possibly reuse cxl_walk_bridge() but
> needs further investigation. This will be left for future improvement
> to make the CXL and PCI handling paths more common.
> 
> Add cxl_report_error_detected() as an analog to report_error_detected().
> It will call pci_driver::cxl_err_handlers for each iterated downstream
> device. The pci_driver::cxl_err_handler's UCE handler returns a boolean
> indicating if there was a UCE error detected during handling.
> 
> cxl_do_recovery() uses the status from cxl_report_error_detected() to
> determine how to proceed. Non-fatal CXL UCE errors will be treated as
> fatal. If a UCE was present during handling then cxl_do_recovery()
> will kernel panic.
> 
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
One trivial suggestion inline.  Probably something for another day!

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  drivers/pci/pci.h      |  3 +++
>  drivers/pci/pcie/aer.c |  4 +++
>  drivers/pci/pcie/err.c | 58 ++++++++++++++++++++++++++++++++++++++++++
>  include/linux/pci.h    |  3 +++
>  4 files changed, 68 insertions(+)
> 
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index 01e51db8d285..deb193b387af 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -722,6 +722,9 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
>  		pci_channel_state_t state,
>  		pci_ers_result_t (*reset_subordinates)(struct pci_dev *pdev));
>  
> +/* CXL error reporting and handling */
> +void cxl_do_recovery(struct pci_dev *dev);
> +
>  bool pcie_wait_for_link(struct pci_dev *pdev, bool active);
>  int pcie_retrain_link(struct pci_dev *pdev, bool use_lt);
>  
> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index 34ec0958afff..ee38db08d005 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -1012,6 +1012,8 @@ static int cxl_rch_handle_error_iter(struct pci_dev *dev, void *data)
>  			err_handler->error_detected(dev, pci_channel_io_normal);
>  		else if (info->severity == AER_FATAL)
>  			err_handler->error_detected(dev, pci_channel_io_frozen);
> +
> +		cxl_do_recovery(dev);
>  	}
>  out:
>  	device_unlock(&dev->dev);
> @@ -1041,6 +1043,8 @@ static void cxl_handle_error(struct pci_dev *dev, struct aer_err_info *info)
>  			pdrv->cxl_err_handler->cor_error_detected(dev);
>  
>  		pcie_clear_device_status(dev);
> +	} else {
> +		cxl_do_recovery(dev);
>  	}
>  }
>  
> diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
> index 31090770fffc..05f2d1ef4c36 100644
> --- a/drivers/pci/pcie/err.c
> +++ b/drivers/pci/pcie/err.c
> @@ -24,6 +24,9 @@
>  static pci_ers_result_t merge_result(enum pci_ers_result orig,
>  				  enum pci_ers_result new)
>  {
> +	if (new == PCI_ERS_RESULT_PANIC)
> +		return PCI_ERS_RESULT_PANIC;
> +
>  	if (new == PCI_ERS_RESULT_NO_AER_DRIVER)
>  		return PCI_ERS_RESULT_NO_AER_DRIVER;
>  
> @@ -276,3 +279,58 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
>  
>  	return status;
>  }
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
> +static int cxl_report_error_detected(struct pci_dev *dev, void *data)
> +{
> +	const struct cxl_error_handlers *cxl_err_handler;
> +	pci_ers_result_t vote, *result = data;
> +	struct pci_driver *pdrv;
> +
> +	device_lock(&dev->dev);
Could use
	guard(device)(&dev->dev);

> +	pdrv = dev->driver;
> +	if (!pdrv || !pdrv->cxl_err_handler ||
> +	    !pdrv->cxl_err_handler->error_detected)
> +		goto out;

allowing you to return here.

Same approach would simplify the rch code as well.
> +
> +	cxl_err_handler = pdrv->cxl_err_handler;
> +	vote = cxl_err_handler->error_detected(dev);
> +	*result = merge_result(*result, vote);
> +out:
> +	device_unlock(&dev->dev);
> +	return 0;
> +}
> +
> +void cxl_do_recovery(struct pci_dev *dev)
> +{
> +	struct pci_host_bridge *host = pci_find_host_bridge(dev->bus);
> +	pci_ers_result_t status = PCI_ERS_RESULT_CAN_RECOVER;
> +
> +	cxl_walk_bridge(dev, cxl_report_error_detected, &status);
> +	if (status == PCI_ERS_RESULT_PANIC)
> +		panic("CXL cachemem error.");
> +
> +	/*
> +	 * If we have native control of AER, clear error status in the device
> +	 * that detected the error.  If the platform retained control of AER,
> +	 * it is responsible for clearing this status.  In that case, the
> +	 * signaling device may not even be visible to the OS.
> +	 */
> +	if (host->native_aer || pcie_ports_native) {
> +		pcie_clear_device_status(dev);
> +		pci_aer_clear_nonfatal_status(dev);
> +		pci_aer_clear_fatal_status(dev);
> +	}
> +
> +	pci_info(dev, "CXL uncorrectable error.\n");
> +}



