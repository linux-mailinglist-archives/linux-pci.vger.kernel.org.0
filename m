Return-Path: <linux-pci+bounces-15633-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E0DF69B6828
	for <lists+linux-pci@lfdr.de>; Wed, 30 Oct 2024 16:43:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 654561F2249F
	for <lists+linux-pci@lfdr.de>; Wed, 30 Oct 2024 15:43:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A20712139A2;
	Wed, 30 Oct 2024 15:42:56 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2DAA213143;
	Wed, 30 Oct 2024 15:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730302976; cv=none; b=r53gU7WB8Aozuf1CC8igq0HPSPKQsCAv7WZwqBKQv4aCNQe7gISWmSF7jK4ik/Rjnkc6J5OaHrNjLEYG/4HJziH3woUPul0lUcGId1h+S3jCBQQEJC+/ZI+ae58yH9C+SCCXmURtJugh75Wdlc8QOTBK+Nb3Enx1r/B31f/Zm8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730302976; c=relaxed/simple;
	bh=7kcnWVYIKaF+38h6wpgdybIdYb0dLLBerv1NN1T1BA0=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b3YCh5BomvdHhqFIe4/mdjvMqtjfLzYp03gOhzui+sQfvv05pgkEW69APWyRm325tSjOHXdza6mUSuhRFlRnik+Js86WZlqZx4LNCGPpTpXtnDQ4o4aW210c5SJUB0nmWWwbHHRUU3Yk3sDGB++OluERngTdFZU5aWQAqzl1gKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XdrtG5GvKz6K6X2;
	Wed, 30 Oct 2024 23:40:22 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 29E8C140B3C;
	Wed, 30 Oct 2024 23:42:48 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 30 Oct
 2024 16:42:47 +0100
Date: Wed, 30 Oct 2024 15:42:46 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Terry Bowman <terry.bowman@amd.com>
CC: <ming4.li@intel.com>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<dave@stgolabs.net>, <dave.jiang@intel.com>, <alison.schofield@intel.com>,
	<vishal.l.verma@intel.com>, <dan.j.williams@intel.com>,
	<bhelgaas@google.com>, <mahesh@linux.ibm.com>, <ira.weiny@intel.com>,
	<oohall@gmail.com>, <Benjamin.Cheatham@amd.com>, <rrichter@amd.com>,
	<nathan.fontenot@amd.com>, <Smita.KoralahalliChannabasappa@amd.com>
Subject: Re: [PATCH v2 07/14] PCI/AER: Add CXL PCIe port uncorrectable error
 recovery in AER service driver
Message-ID: <20241030154246.000059d2@Huawei.com>
In-Reply-To: <20241025210305.27499-8-terry.bowman@amd.com>
References: <20241025210305.27499-1-terry.bowman@amd.com>
	<20241025210305.27499-8-terry.bowman@amd.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500006.china.huawei.com (7.191.161.198) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Fri, 25 Oct 2024 16:02:58 -0500
Terry Bowman <terry.bowman@amd.com> wrote:

> Existing recovery procedure for PCIe uncorrectable errors (UCE) does not
> apply to CXL devices. Recovery can not be used for CXL devices because of
> the potential for corruption on what can be system memory. Also, current
> PCIe UCE recovery does not begin at the bridge but begins at the bridge's
> first downstream device. 

I'm still stuck on why it is fine for PCIe to skip handling errors in the
root port.  Can't see why it should be different.

I might take a poke at what happens on an emulated PCIe system to try and
understand this better but probably not that quickly.

Without understanding the reasoning behind that I'm reluctant to make
an assessment of whether this code is right.

One trivial comment inline.

Jonathan


> This will miss handling CXL protocol errors in a
> CXL root port. A separate CXL recovery is needed because of the different
> handling requirements
> 
> Add a new function, cxl_do_recovery() using the following.
> 
> Add cxl_walk_bridge() to iterate the detected error's sub-topology.
> cxl_walk_bridge() is similar to pci_walk_bridge() but the CXL flavor
> will begin iteration at the bridge rather than beginning at the
> bridge's first downstream child.
> 
> Add cxl_report_error_detected() as an analog to report_error_detected().
> It will call pci_driver::cxl_err_handlers for each iterated downstream
> child. The pci_driver::cxl_err_handlers UCE handler returns a boolean
> indicating if there was a UCE error detected during handling.
> 
> cxl_do_recovery() uses the status from cxl_report_error_detected() to
> determine how to proceed. Non-fatal CXL UCE errors will be treated as
> fatal. If a UCE was present during handling then cxl_do_recovery()
> will kernel panic.
> 
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> ---
>  drivers/pci/pci.h      |  3 +++
>  drivers/pci/pcie/aer.c |  5 +++-
>  drivers/pci/pcie/err.c | 54 ++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 61 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index 14d00ce45bfa..5a67e41919d8 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -658,6 +658,9 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
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
> index d772f123c6a2..19432ab2cfb6 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -1048,7 +1048,10 @@ static void cxl_handle_error(struct pci_dev *dev, struct aer_err_info *info)
>  			pdrv->cxl_err_handler->cor_error_detected(dev);
>  
>  		pcie_clear_device_status(dev);
> -	}
> +	} else if (info->severity == AER_NONFATAL)
> +		cxl_do_recovery(dev);
> +	else if (info->severity == AER_FATAL)
Needs {}

> +		cxl_do_recovery(dev);
>  }
>  
>  static int handles_cxl_error_iter(struct pci_dev *dev, void *data)
> diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
> index 31090770fffc..3785f4ca5103 100644
> --- a/drivers/pci/pcie/err.c
> +++ b/drivers/pci/pcie/err.c
> @@ -276,3 +276,57 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
>  
>  	return status;
>  }
> +
> +static void cxl_walk_bridge(struct pci_dev *bridge,
> +			    int (*cb)(struct pci_dev *, void *),
> +			    void *userdata)
> +{
> +	bool *status = userdata;
> +
> +	cb(bridge, status);
> +	if (bridge->subordinate && !*status)
> +		pci_walk_bus(bridge->subordinate, cb, status);
> +}
> +
> +static int cxl_report_error_detected(struct pci_dev *dev, void *data)
> +{
> +	struct pci_driver *pdrv = dev->driver;
> +	bool *status = data;
> +
> +	device_lock(&dev->dev);
> +	if (pdrv && pdrv->cxl_err_handler &&
> +	    pdrv->cxl_err_handler->error_detected) {
> +		const struct cxl_error_handlers *cxl_err_handler =
> +			pdrv->cxl_err_handler;
> +		*status |= cxl_err_handler->error_detected(dev);
> +	}
> +	device_unlock(&dev->dev);
> +	return *status;
> +}
> +
> +void cxl_do_recovery(struct pci_dev *dev)
> +{
> +	struct pci_host_bridge *host = pci_find_host_bridge(dev->bus);
> +	int type = pci_pcie_type(dev);
> +	struct pci_dev *bridge;
> +	int status;
> +
> +	if (type == PCI_EXP_TYPE_ROOT_PORT ||
> +	    type == PCI_EXP_TYPE_DOWNSTREAM ||
> +	    type == PCI_EXP_TYPE_UPSTREAM ||
> +	    type == PCI_EXP_TYPE_ENDPOINT)
> +		bridge = dev;
> +	else
> +		bridge = pci_upstream_bridge(dev);
> +
> +	cxl_walk_bridge(bridge, cxl_report_error_detected, &status);
> +	if (status)
> +		panic("CXL cachemem error. Invoking panic");
> +
> +	if (host->native_aer || pcie_ports_native) {
> +		pcie_clear_device_status(dev);
> +		pci_aer_clear_nonfatal_status(dev);
> +	}
> +
> +	pci_info(bridge, "No uncorrectable error found. Continuing.\n");
> +}


