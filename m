Return-Path: <linux-pci+bounces-14670-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6290C9A101F
	for <lists+linux-pci@lfdr.de>; Wed, 16 Oct 2024 18:54:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26A48281100
	for <lists+linux-pci@lfdr.de>; Wed, 16 Oct 2024 16:54:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B91E620E02F;
	Wed, 16 Oct 2024 16:54:36 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 711B41FDF99;
	Wed, 16 Oct 2024 16:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729097676; cv=none; b=uhSZ73Ia7xgrSmeu/Y50198UHWXrqghl98MEddUtf3nUK34XpBJLpuU5P4YBMrifP8uZ86yzZN3FcOxGHzQSZ0ekG0e4PjZj0s1D36Qp2M1JOAux3JWlZFvjV2O3iss1wO0GX7Q1VqEMgZXe8AcLxUQyuB3AaMsE/5mpqtZT21c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729097676; c=relaxed/simple;
	bh=PYlv1pv0ilaHXl9zv60mR5y5zmk1H8dbAl6VIgahPj4=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mFFwbHegblbdRWS9RGDFRYg/nPcSrzKVkaHi+MBXrTtXZBcGEfmgb7zbdB5Cp9gGfTkI2p57JbQI0DWv/IkXfE9HQlGLSNJxu76qdbeIHEorGXPRz23gxxaJe7o0jg3Zee2L6LVYGFhRD8PbUIfxRtxQXQ7WY5/7bVbFer4hONw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XTH522zhRz6LDKl;
	Thu, 17 Oct 2024 00:49:58 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id A00E2140A86;
	Thu, 17 Oct 2024 00:54:28 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 16 Oct
 2024 18:54:27 +0200
Date: Wed, 16 Oct 2024 17:54:26 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Terry Bowman <terry.bowman@amd.com>
CC: <ming4.li@intel.com>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<dave@stgolabs.net>, <dave.jiang@intel.com>, <alison.schofield@intel.com>,
	<vishal.l.verma@intel.com>, <dan.j.williams@intel.com>,
	<bhelgaas@google.com>, <mahesh@linux.ibm.com>, <oohall@gmail.com>,
	<Benjamin.Cheatham@amd.com>, <rrichter@amd.com>, <nathan.fontenot@amd.com>,
	<smita.koralahallichannabasappa@amd.com>
Subject: Re: [PATCH 07/15] cxl/aer/pci: Add CXL PCIe port uncorrectable
 error recovery in AER service driver
Message-ID: <20241016175426.0000411e@Huawei.com>
In-Reply-To: <20241008221657.1130181-8-terry.bowman@amd.com>
References: <20241008221657.1130181-1-terry.bowman@amd.com>
	<20241008221657.1130181-8-terry.bowman@amd.com>
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
X-ClientProxiedBy: lhrpeml500003.china.huawei.com (7.191.162.67) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Tue, 8 Oct 2024 17:16:49 -0500
Terry Bowman <terry.bowman@amd.com> wrote:

> The current pcie_do_recovery() handles device recovery as result of
> uncorrectable errors (UCE). But, CXL port devices require unique
> recovery handling.
> 
> Create a cxl_do_recovery() function parallel to pcie_do_recovery(). Add CXL
> specific handling to the new recovery function.
> 
> The CXL port UCE recovery must invoke the AER service driver's CXL port
> UCE callback. This is different than the standard pcie_do_recovery()
> recovery that calls the pci_driver::err_handler UCE handler instead.
> 
> Treat all CXL PCIe port UCE errors as fatal and call kernel panic to
> "recover" the error. A panic is called instead of attempting recovery
> to avoid potential system corruption.
> 
> The uncorrectable support added here will be used to complete CXL PCIe
> port error handling in the future.
> 
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>

Hi Terry,

I'm a little bothered by the subtle difference in the bus walks
in here vs the existing cases. If we need them, comments needed
to explain why.

If we are going to have separate handling, see if you can share
a lot more of the code by factoring out common functions for
the pci and cxl handling with callbacks to handle the differences.

I've managed to get my head around this code a few times in the past
(I think!) and really don't fancy having two subtle variants to
consider next time we get a bug :( The RC_EC additions hurt my head.

Jonathan

>  static int handles_cxl_error_iter(struct pci_dev *dev, void *data)
> diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
> index 31090770fffc..de12f2eb19ef 100644
> --- a/drivers/pci/pcie/err.c
> +++ b/drivers/pci/pcie/err.c
> @@ -86,6 +86,63 @@ static int report_error_detected(struct pci_dev *dev,
>  	return 0;
>  }
>  
> +static int cxl_report_error_detected(struct pci_dev *dev,
> +				     pci_channel_state_t state,
> +				     enum pci_ers_result *result)
> +{
> +	struct cxl_port_err_hndlrs *cxl_port_hndlrs;
> +	struct pci_driver *pdrv;
> +	pci_ers_result_t vote;
> +
> +	device_lock(&dev->dev);
> +	cxl_port_hndlrs = find_cxl_port_hndlrs();

Can we refactor to have a common function under this and report_error_detected()?

> +	pdrv = dev->driver;
> +	if (pci_dev_is_disconnected(dev)) {
> +		vote = PCI_ERS_RESULT_DISCONNECT;
> +	} else if (!pci_dev_set_io_state(dev, state)) {
> +		pci_info(dev, "can't recover (state transition %u -> %u invalid)\n",
> +			dev->error_state, state);
> +		vote = PCI_ERS_RESULT_NONE;
> +	} else if (!cxl_port_hndlrs || !cxl_port_hndlrs->error_detected) {
> +		if (dev->hdr_type != PCI_HEADER_TYPE_BRIDGE) {
> +			vote = PCI_ERS_RESULT_NO_AER_DRIVER;
> +			pci_info(dev, "can't recover (no error_detected callback)\n");
> +		} else {
> +			vote = PCI_ERS_RESULT_NONE;
> +		}
> +	} else {
> +		vote = cxl_port_hndlrs->error_detected(dev, state);
> +	}
> +	pci_uevent_ers(dev, vote);
> +	*result = merge_result(*result, vote);
> +	device_unlock(&dev->dev);
> +	return 0;
> +}

>  static int pci_pm_runtime_get_sync(struct pci_dev *pdev, void *data)
>  {
>  	pm_runtime_get_sync(&pdev->dev);
> @@ -188,6 +245,28 @@ static void pci_walk_bridge(struct pci_dev *bridge,
>  		cb(bridge, userdata);
>  }
>  
> +/**
> + * cxl_walk_bridge - walk bridges potentially AER affected
> + * @bridge:	bridge which may be a Port, an RCEC, or an RCiEP
> + * @cb:		callback to be called for each device found
> + * @userdata:	arbitrary pointer to be passed to callback
> + *
> + * If the device provided is a bridge, walk the subordinate bus, including
> + * the device itself and any bridged devices on buses under this bus.  Call
> + * the provided callback on each device found.
> + *
> + * If the device provided has no subordinate bus, e.g., an RCEC or RCiEP,
> + * call the callback on the device itself.
only call the callback on the device itself.

(as you call it as stated above either way).

> + */
> +static void cxl_walk_bridge(struct pci_dev *bridge,
> +			    int (*cb)(struct pci_dev *, void *),
> +			    void *userdata)
> +{
> +	cb(bridge, userdata);
> +	if (bridge->subordinate)
> +		pci_walk_bus(bridge->subordinate, cb, userdata);
The difference between this and pci_walk_bridge() is subtle and
I'd like to avoid having both if we can.

> +}
> +
>  pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
>  		pci_channel_state_t state,
>  		pci_ers_result_t (*reset_subordinates)(struct pci_dev *pdev))
> @@ -276,3 +355,74 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
>  
>  	return status;
>  }
> +
> +pci_ers_result_t cxl_do_recovery(struct pci_dev *bridge,
> +				 pci_channel_state_t state,
> +				 pci_ers_result_t (*reset_subordinates)(struct pci_dev *pdev))
> +{
> +	struct pci_host_bridge *host = pci_find_host_bridge(bridge->bus);
> +	pci_ers_result_t status = PCI_ERS_RESULT_CAN_RECOVER;
> +	int type = pci_pcie_type(bridge);
> +
> +	if ((type != PCI_EXP_TYPE_ROOT_PORT) &&
> +	    (type != PCI_EXP_TYPE_RC_EC) &&
> +	    (type != PCI_EXP_TYPE_DOWNSTREAM) &&
> +	    (type != PCI_EXP_TYPE_UPSTREAM)) {
> +		pci_dbg(bridge, "Unsupported device type (%x)\n", type);
> +		return status;
> +	}
> +

Would similar trick to in pcie_do_recovery work here for the upstream
and downstream ports use pci_upstream_bridge() and for the others pass the dev into
pci_walk_bridge()?

> +	cxl_walk_bridge(bridge, pci_pm_runtime_get_sync, NULL);
> +
> +	pci_dbg(bridge, "broadcast error_detected message\n");
> +	if (state == pci_channel_io_frozen) {
> +		cxl_walk_bridge(bridge, cxl_report_frozen_detected, &status);
> +		if (reset_subordinates(bridge) != PCI_ERS_RESULT_RECOVERED) {
> +			pci_warn(bridge, "subordinate device reset failed\n");
> +			goto failed;
> +		}
> +	} else {
> +		cxl_walk_bridge(bridge, cxl_report_normal_detected, &status);
> +	}
> +
> +	if (status == PCI_ERS_RESULT_PANIC)
> +		panic("CXL cachemem error. Invoking panic");
> +
> +	if (status == PCI_ERS_RESULT_CAN_RECOVER) {
> +		status = PCI_ERS_RESULT_RECOVERED;
> +		pci_dbg(bridge, "broadcast mmio_enabled message\n");
> +		cxl_walk_bridge(bridge, report_mmio_enabled, &status);
> +	}
> +
> +	if (status == PCI_ERS_RESULT_NEED_RESET) {
> +		status = PCI_ERS_RESULT_RECOVERED;
> +		pci_dbg(bridge, "broadcast slot_reset message\n");
> +		report_slot_reset(bridge, &status);
> +		pci_walk_bridge(bridge, report_slot_reset, &status);
> +	}
> +
> +	if (status != PCI_ERS_RESULT_RECOVERED)
> +		goto failed;
> +
> +	pci_dbg(bridge, "broadcast resume message\n");
> +	cxl_walk_bridge(bridge, report_resume, &status);
> +
> +	if (host->native_aer || pcie_ports_native) {
> +		pcie_clear_device_status(bridge);
> +		pci_aer_clear_nonfatal_status(bridge);
> +	}
> +
> +	cxl_walk_bridge(bridge, pci_pm_runtime_put, NULL);
> +
> +	pci_info(bridge, "device recovery successful\n");
> +	return status;
> +
> +failed:
> +	cxl_walk_bridge(bridge, pci_pm_runtime_put, NULL);
> +
> +	pci_uevent_ers(bridge, PCI_ERS_RESULT_DISCONNECT);
> +
> +	pci_info(bridge, "device recovery failed\n");
> +
> +	return status;
> +}


