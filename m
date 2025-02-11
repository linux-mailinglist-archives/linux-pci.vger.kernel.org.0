Return-Path: <linux-pci+bounces-21224-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2745A316A8
	for <lists+linux-pci@lfdr.de>; Tue, 11 Feb 2025 21:29:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E4AD3A646A
	for <lists+linux-pci@lfdr.de>; Tue, 11 Feb 2025 20:29:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A3B926217C;
	Tue, 11 Feb 2025 20:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MSwgg3hE"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40984265609;
	Tue, 11 Feb 2025 20:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739305761; cv=none; b=i9vYnOaOiRxbTejWRG3BMLIWlHr5Sbnr3A8oJhPdDjzXPfkhG6Y5qRA3lIVRuGhkxvP2CsGfNQwIOyG9C9is7tp0XcpKzgyWIZ66jgg4rkWcQc+0/L60bMPe65rwFeFwtG2ScvvXfAWlkBK3h1HSQx+ZTSe1pa3i/Ux4fY0calQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739305761; c=relaxed/simple;
	bh=zGlYad9Tufo8u/AXDss/2a0R3YUW/N52Eo2lgDYUO4E=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=WW0Oq/0SXr8PuK/SZDDQkjvnSwqX32e74GvAUk0HstGLX6nb4BqbzIOwQuCL9VDAyY5/cPkQeUcLFl5pnfJebk+bhh2673umGpgeeu7XAfinpswqi+o7SNf7FF8zdkEH2UxJunXGlULb3EojeuXOuiAcCwN1+dh6a1QNEcFOBaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MSwgg3hE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4B61C4CEDD;
	Tue, 11 Feb 2025 20:29:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739305761;
	bh=zGlYad9Tufo8u/AXDss/2a0R3YUW/N52Eo2lgDYUO4E=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=MSwgg3hE0kfyr1laR2q8ROj1xcqXz3PkCzV0ALPhKO3VnZpDq029uWMaPLtz5zaND
	 NmoCifBOfk6X1tXmFi4lSRDRhjkKl8Vi/WDtQXszlvt3VWvvdSiXnEIo6sZstd6N6N
	 y3/VwmnAEVGKHB+WtPHZaFYuQ468RvYBgEg5+EJcBNQN5R5mGdG2T19M0SykWdUQk6
	 K0sdWiBUfWMi3MGSlRWvq6ZMr3UzaVfj+dHWs/yNKdo8VZRJYMw14kmXG+lQTd5FdK
	 ctABFA4yOFK5TdK6cnkATXOs3tV96TNYUNfGWOh5NHd2CFHBX5m2Zr5FXr7a396K99
	 yrgz7N5qoSenw==
Date: Tue, 11 Feb 2025 14:29:19 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Terry Bowman <terry.bowman@amd.com>
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, nifan.cxl@gmail.com, dave@stgolabs.net,
	jonathan.cameron@huawei.com, dave.jiang@intel.com,
	alison.schofield@intel.com, vishal.l.verma@intel.com,
	dan.j.williams@intel.com, bhelgaas@google.com, mahesh@linux.ibm.com,
	ira.weiny@intel.com, oohall@gmail.com, Benjamin.Cheatham@amd.com,
	rrichter@amd.com, nathan.fontenot@amd.com,
	Smita.KoralahalliChannabasappa@amd.com, lukas@wunner.de,
	ming.li@zohomail.com, PradeepVineshReddy.Kodamati@amd.com
Subject: Re: [PATCH v7 06/17] PCI/AER: Add CXL PCIe Port uncorrectable error
 recovery in AER service driver
Message-ID: <20250211202919.GA54027@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250211192444.2292833-7-terry.bowman@amd.com>

On Tue, Feb 11, 2025 at 01:24:33PM -0600, Terry Bowman wrote:
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

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

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
> +	pdrv = dev->driver;
> +	if (!pdrv || !pdrv->cxl_err_handler ||
> +	    !pdrv->cxl_err_handler->error_detected)
> +		goto out;
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
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 82a0401c58d3..5b539b5bf0d1 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -864,6 +864,9 @@ enum pci_ers_result {
>  
>  	/* No AER capabilities registered for the driver */
>  	PCI_ERS_RESULT_NO_AER_DRIVER = (__force pci_ers_result_t) 6,
> +
> +	/* System is unstable, panic  */
> +	PCI_ERS_RESULT_PANIC = (__force pci_ers_result_t) 7,
>  };
>  
>  /* PCI bus error event callbacks */
> -- 
> 2.34.1
> 

