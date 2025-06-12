Return-Path: <linux-pci+bounces-29537-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E0154AD6F1D
	for <lists+linux-pci@lfdr.de>; Thu, 12 Jun 2025 13:37:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 948DB3A0BD6
	for <lists+linux-pci@lfdr.de>; Thu, 12 Jun 2025 11:37:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C4482F4321;
	Thu, 12 Jun 2025 11:36:58 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A07C62F431D;
	Thu, 12 Jun 2025 11:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749728218; cv=none; b=MaWV83JpyzVrmblg1l1qSyrfjSxtpCQt9N/0vFyahxxZfJpPqWPE6y6XmlyN3cq+RATYtObS85faDUbiS29yree069MhZcyB4RXATuRchCMCaaDSnKXaNI5yBrxOUFW/Va/oMAXk6j/TbhRrtvzLP/dOB4k1xUtS5GY0IXis/UE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749728218; c=relaxed/simple;
	bh=hxzDTyu/j+LB5NGXyqsobkBQ9+K2Svtz4qgXDwQnKJ4=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QsA1tUxFpAkaSdYe0nLWsLF5hAvxAQ8pdIWAZlZm+CHMKa8Cfpx3DJTLlxGftTCGiknufUzuTayH0oEX/F2UwmpU4i3cvddIj6Z09xvQN1Tf330xAljPuGugzVL1NNP3nPD1c+C1krRChNLoS9wifRxDfMNZabjuSqfRT4h9p6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bJ0kR5HfQz6H6h6;
	Thu, 12 Jun 2025 19:32:31 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 1C34F1400DC;
	Thu, 12 Jun 2025 19:36:53 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 12 Jun
 2025 13:36:52 +0200
Date: Thu, 12 Jun 2025 12:36:50 +0100
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
Subject: Re: [PATCH v9 04/16] PCI/AER: Dequeue forwarded CXL error
Message-ID: <20250612123650.0000321b@huawei.com>
In-Reply-To: <20250603172239.159260-5-terry.bowman@amd.com>
References: <20250603172239.159260-1-terry.bowman@amd.com>
	<20250603172239.159260-5-terry.bowman@amd.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500009.china.huawei.com (7.191.174.84) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Tue, 3 Jun 2025 12:22:27 -0500
Terry Bowman <terry.bowman@amd.com> wrote:

> The AER driver is now designed to forward CXL protocol errors to the CXL
> driver. Update the CXL driver with functionality to dequeue the forwarded
> CXL error from the kfifo. Also, update the CXL driver to begin the protocol
> error handling processing using the work received from the FIFO.
> 
> Introduce function cxl_prot_err_work_fn() to dequeue work forwarded by the
> AER service driver. This will begin the CXL protocol error processing
> with a call to cxl_handle_prot_error().
> 
> Update cxl/core/ras.c by adding cxl_rch_handle_error_iter() that was
> previously in the AER driver.
> 
> Introduce sbdf_to_pci() to take the SBDF values from 'struct cxl_prot_error_info'
> and use in discovering the erring PCI device. Make scope based reference
> increments/decrements for the discovered PCI device and the associated
> CXL device.
> 
> Implement cxl_handle_prot_error() to differentiate between Restricted CXL
> Host (RCH) protocol errors and CXL virtual host (VH) protocol errors.
> RCH errors will be processed with a call to walk the associated Root
> Complex Event Collector's (RCEC) secondary bus looking for the Root Complex
> Integrated Endpoint (RCiEP) to handle the RCH error. Export pcie_walk_rcec()
> so the CXL driver can walk the RCEC's downstream bus, searching for
> the RCiEP.
> 
> VH correctable error (CE) processing will call the CXL CE handler. VH
> uncorrectable errors (UCE) will call cxl_do_recovery(), implemented as a
> stub for now and to be updated in future patch. Export pci_aer_clean_fatal_status()
> and pci_clean_device_status() used to clean up AER status after handling.
> 
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>

Hopefully I haven't duplicated existing feedback. A few more minor things
inline.

> +
> +static struct pci_dev *sbdf_to_pci(struct cxl_prot_error_info *err_info)

That's an odd function name as the sbdf is buried.
Unless it's going to get a lot of use, I'd just put the lookup
inline and not have a 'hard to name' function.  With other suggested
changes you only need (at where this is currently called)
	struct pci_dev *pdev __free(pci_dev_put) =
		pci_get_domain_bus_and_slot(err_info->segment, err_info->bus,
					    err_info->devfn);

> +{
> +	unsigned int devfn = PCI_DEVFN(err_info->device,
> +				       err_info->function);

This makes me wonder if you should have just use devfn inside the err_info.
Is there a good reason to split them up before storing them?

IIRC ARI makes a mess anyway of their meaning when separate.

> +	struct pci_dev *pdev __free(pci_dev_put) =
> +		pci_get_domain_bus_and_slot(err_info->segment,
> +					    err_info->bus,
> +					    devfn);
> +	return pdev;
> +}
> +
> +static void cxl_handle_prot_error(struct cxl_prot_error_info *err_info)
> +{
> +	struct pci_dev *pdev __free(pci_dev_put) = pci_dev_get(sbdf_to_pci(err_info));
> +
> +	if (!pdev) {
> +		pr_err("Failed to find the CXL device\n");
> +		return;
> +	}
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
> +		int aer = pdev->aer_cap;
> +		struct cxl_dev_state *cxlds = pci_get_drvdata(pdev);
> +		struct device *dev __free(put_device) = get_device(&cxlds->cxlmd->dev);
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
> +
>  static void cxl_prot_err_work_fn(struct work_struct *work)
>  {
> +	struct cxl_prot_err_work_data wd;
> +
> +	while (cxl_prot_err_kfifo_get(&wd)) {
> +		struct cxl_prot_error_info *err_info = &wd.err_info;
> +
> +		cxl_handle_prot_error(err_info);

I'm not seeing value in the local variable.
Ignore if this code changes later and that makes more sense!

> +	}
>  }
>  
>  #else


