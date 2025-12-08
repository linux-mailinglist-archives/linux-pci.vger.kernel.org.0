Return-Path: <linux-pci+bounces-42785-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 667C3CAE036
	for <lists+linux-pci@lfdr.de>; Mon, 08 Dec 2025 19:40:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D3880308E6D6
	for <lists+linux-pci@lfdr.de>; Mon,  8 Dec 2025 18:40:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2400827FB2D;
	Mon,  8 Dec 2025 18:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pLI7VfwQ"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED7B826159E;
	Mon,  8 Dec 2025 18:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765219239; cv=none; b=ebNmEd/MJKAGD1doU92ChD2yJXDBMC66M8jh3LgDWitXogrZy7HF8/NC69GuIkeLCsU/YuxSem5kkkXMylNcCiKIXRBz6R0c4Di7SR1zVB3c+55pfYEjNbzZbBmQzSJT+HSjNV2DUT4r74xseWC6rXPH8C2QmwlXDb2O7JPFFws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765219239; c=relaxed/simple;
	bh=+eLXREPLkduwuQ3OWUijQvpFB77hLokExdyaSGKVjxQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=b9WN4aKUBEeikkHoXtIR66nqGkTrhV9l9GxRnmUrgAdopemVule10m5Dk0ei4RAnkCfNsRjxExa8EMV7NWfsP/Tto/3sOH79RIl9QjXziAZUX2Bb2xcpM0+L7ToDrjeSDdKGFnjkfOPMSfSpR6tHSAOd5k4jTbKtB3fr690l2U4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pLI7VfwQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6389FC4CEF1;
	Mon,  8 Dec 2025 18:40:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765219238;
	bh=+eLXREPLkduwuQ3OWUijQvpFB77hLokExdyaSGKVjxQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=pLI7VfwQ87R7vueHXaKAls8G5CmHhOrozNbytnsvELUu+ZYxOtgLLr4gJQB+F3lDx
	 79x/ikXcq8XMppiTqi4ORS7D0vKQLg3Cou7aJIpcvUwNiE7VXP+dEmuzS54beQMXIv
	 JTkr0InXb502QF476AMKplOfzMe3G+HyAL7LAkHBNqTN1mvVyn++M5mRGcGDbGu2cl
	 FvQvAnsYJOfIrQx5mRea/KkNWDxgAVkDc7uU0JAH3IM+sWtEG2j+f5Y0vbXcnKba8d
	 KvOHnEQmoHq4NxF3bR56wQZ1fpA96dKxG+LFSRdpUjg7GjPXxJ/jfhaK5EYQ3rncCq
	 wI2a2gd6gI7vQ==
Date: Mon, 8 Dec 2025 12:40:37 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Terry Bowman <terry.bowman@amd.com>
Cc: dave@stgolabs.net, jonathan.cameron@huawei.com, dave.jiang@intel.com,
	alison.schofield@intel.com, dan.j.williams@intel.com,
	bhelgaas@google.com, shiju.jose@huawei.com, ming.li@zohomail.com,
	Smita.KoralahalliChannabasappa@amd.com, rrichter@amd.com,
	dan.carpenter@linaro.org, PradeepVineshReddy.Kodamati@amd.com,
	lukas@wunner.de, Benjamin.Cheatham@amd.com,
	sathyanarayanan.kuppuswamy@linux.intel.com,
	linux-cxl@vger.kernel.org, alucerop@amd.com, ira.weiny@intel.com,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [RESEND v13 23/25] CXL/PCI: Introduce CXL uncorrectable protocol
 error recovery
Message-ID: <20251208184037.GA3421722@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251104170305.4163840-24-terry.bowman@amd.com>

On Tue, Nov 04, 2025 at 11:03:03AM -0600, Terry Bowman wrote:
> Implement cxl_do_recovery() to handle uncorrectable protocol
> errors (UCE), following the design of pcie_do_recovery(). Unlike PCIe,
> all CXL UCEs are treated as fatal and trigger a kernel panic to avoid
> potential CXL memory corruption.
> 
> Add cxl_walk_port(), analogous to pci_walk_bridge(), to traverse the
> CXL topology from the error source through downstream CXL ports and
> endpoints.
> 
> Introduce cxl_report_error_detected(), mirroring PCI's
> report_error_detected(), and implement device locking for the affected
> subtree. Endpoints require locking the PCI device (pdev->dev) and the
> CXL memdev (cxlmd->dev). CXL ports require locking the PCI
> device (pdev->dev) and the parent CXL port.
> 
> The device locks should be taken early where possible. The initially
> reporting device will be locked after kfifo dequeue. Iterated devices
> will be locked in cxl_report_error_detected() and must lock the
> iterated devices except for the first device as it has already been
> locked.
> 
> Export pci_aer_clear_fatal_status() for use when a UCE is not present.
> 
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>

Acked-by: Bjorn Helgaas <bhelgaas@google.com> # drivers/pci/

> ---
> 
> Changes in v12->v13:
> - Add guard() before calling cxl_pci_drv_bound() (Dave Jiang)
> - Add guard() calls for EP (cxlds->cxlmd->dev & pdev->dev) and ports
>   (pdev->dev & parent cxl_port) in cxl_report_error_detected() and
>   cxl_handle_proto_error() (Terry)
> - Remove unnecessary check for endpoint port. (Dave Jiang)
> - Remove check for RCIEP EP in cxl_report_error_detected(). (Terry)
> 
> Changes in v11->v12:
> - Clean up port discovery in cxl_do_recovery() (Dave)
> - Add PCI_EXP_TYPE_RC_END to type check in cxl_report_error_detected()
> 
> Changes in v10->v11:
> - pci_ers_merge_results() - Move to earlier patch
> ---
>  drivers/cxl/core/ras.c | 135 ++++++++++++++++++++++++++++++++++++++++-
>  drivers/pci/pci.h      |   1 -
>  drivers/pci/pcie/aer.c |   1 +
>  include/linux/aer.h    |   2 +
>  4 files changed, 135 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/cxl/core/ras.c b/drivers/cxl/core/ras.c
> index 5bc144cde0ee..52c6f19564b6 100644
> --- a/drivers/cxl/core/ras.c
> +++ b/drivers/cxl/core/ras.c
> @@ -259,8 +259,138 @@ static void device_unlock_if(struct device *dev, bool take)
>  		device_unlock(dev);
>  }
>  
> +/**
> + * cxl_report_error_detected
> + * @dev: Device being reported
> + * @data: Result
> + * @err_pdev: Device with initial detected error. Is locked immediately
> + *            after KFIFO dequeue.
> + */
> +static int cxl_report_error_detected(struct device *dev, void *data, struct pci_dev *err_pdev)
> +{
> +	bool need_lock = (dev != &err_pdev->dev);
> +	pci_ers_result_t vote, *result = data;
> +	struct pci_dev *pdev;
> +
> +	if (!dev || !dev_is_pci(dev))
> +		return 0;
> +	pdev = to_pci_dev(dev);
> +
> +	device_lock_if(&pdev->dev, need_lock);
> +	if (is_pcie_endpoint(pdev) && !cxl_pci_drv_bound(pdev)) {
> +		device_unlock_if(&pdev->dev, need_lock);
> +		return PCI_ERS_RESULT_NONE;
> +	}
> +
> +	if (pdev->aer_cap)
> +		pci_clear_and_set_config_dword(pdev,
> +					       pdev->aer_cap + PCI_ERR_COR_STATUS,
> +					       0, PCI_ERR_COR_INTERNAL);
> +
> +	if (is_pcie_endpoint(pdev)) {
> +		struct cxl_dev_state *cxlds = pci_get_drvdata(pdev);
> +
> +		device_lock_if(&cxlds->cxlmd->dev, need_lock);
> +		vote = cxl_error_detected(&cxlds->cxlmd->dev);
> +		device_unlock_if(&cxlds->cxlmd->dev, need_lock);
> +	} else {
> +		vote = cxl_port_error_detected(dev);
> +	}
> +
> +	pcie_clear_device_status(pdev);
> +	*result = pcie_ers_merge_result(*result, vote);
> +	device_unlock_if(&pdev->dev, need_lock);
> +
> +	return 0;
> +}
> +
> +static int match_port_by_parent_dport(struct device *dev, const void *dport_dev)
> +{
> +	struct cxl_port *port;
> +
> +	if (!is_cxl_port(dev))
> +		return 0;
> +
> +	port = to_cxl_port(dev);
> +
> +	return port->parent_dport->dport_dev == dport_dev;
> +}
> +
> +/**
> + * cxl_walk_port
> + *
> + * @port: Port be traversed into
> + * @cb: Callback for handling the CXL Ports
> + * @userdata: Result
> + * @err_pdev: Device with initial detected error. Is locked immediately
> + *            after KFIFO dequeue.
> + */
> +static void cxl_walk_port(struct cxl_port *port,
> +			  int (*cb)(struct device *, void *, struct pci_dev *),
> +			  void *userdata,
> +			  struct pci_dev *err_pdev)
> +{
> +	struct cxl_port *err_port __free(put_cxl_port) = get_cxl_port(err_pdev);
> +	bool need_lock = (port != err_port);
> +	struct cxl_dport *dport = NULL;
> +	unsigned long index;
> +
> +	device_lock_if(&port->dev, need_lock);
> +	if (is_cxl_endpoint(port)) {
> +		cb(port->uport_dev->parent, userdata, err_pdev);
> +		device_unlock_if(&port->dev, need_lock);
> +		return;
> +	}
> +
> +	if (port->uport_dev && dev_is_pci(port->uport_dev))
> +		cb(port->uport_dev, userdata, err_pdev);
> +
> +	/*
> +	 * Iterate over the set of Downstream Ports recorded in port->dports (XArray):
> +	 *  - For each dport, attempt to find a child CXL Port whose parent dport
> +	 *    match.
> +	 *  - Invoke the provided callback on the dport's device.
> +	 *  - If a matching child CXL Port device is found, recurse into that port to
> +	 *    continue the walk.
> +	 */
> +	xa_for_each(&port->dports, index, dport)
> +	{
> +		struct device *child_port_dev __free(put_device) =
> +			bus_find_device(&cxl_bus_type, &port->dev, dport->dport_dev,
> +					match_port_by_parent_dport);
> +
> +		cb(dport->dport_dev, userdata, err_pdev);
> +		if (child_port_dev)
> +			cxl_walk_port(to_cxl_port(child_port_dev), cb, userdata, err_pdev);
> +	}
> +	device_unlock_if(&port->dev, need_lock);
> +}
> +
>  static void cxl_do_recovery(struct pci_dev *pdev)
>  {
> +	pci_ers_result_t status = PCI_ERS_RESULT_CAN_RECOVER;
> +	struct cxl_port *port __free(put_cxl_port) = get_cxl_port(pdev);
> +
> +	if (!port) {
> +		pci_err(pdev, "Failed to find the CXL device\n");
> +		return;
> +	}
> +
> +	cxl_walk_port(port, cxl_report_error_detected, &status, pdev);
> +	if (status == PCI_ERS_RESULT_PANIC)
> +		panic("CXL cachemem error.");
> +
> +	/*
> +	 * If we have native control of AER, clear error status in the device
> +	 * that detected the error.  If the platform retained control of AER,
> +	 * it is responsible for clearing this status.  In that case, the
> +	 * signaling device may not even be visible to the OS.
> +	 */
> +	if (cxl_error_is_native(pdev)) {
> +		pcie_clear_device_status(pdev);
> +		pci_aer_clear_nonfatal_status(pdev);
> +		pci_aer_clear_fatal_status(pdev);
> +	}
>  }
>  
>  void cxl_handle_cor_ras(struct device *dev, u64 serial, void __iomem *ras_base)
> @@ -483,16 +613,15 @@ static void cxl_proto_err_work_fn(struct work_struct *work)
>  			if (!cxl_pci_drv_bound(pdev))
>  				return;
>  			cxlmd_dev = &cxlds->cxlmd->dev;
> -			device_lock_if(cxlmd_dev, cxlmd_dev);
>  		} else {
>  			cxlmd_dev = NULL;
>  		}
>  
> +		/* Lock the CXL parent Port */
>  		struct cxl_port *port __free(put_cxl_port) = get_cxl_port(pdev);
> -		if (!port)
> -			return;
>  		guard(device)(&port->dev);
>  
> +		device_lock_if(cxlmd_dev, cxlmd_dev);
>  		cxl_handle_proto_error(&wd);
>  		device_unlock_if(cxlmd_dev, cxlmd_dev);
>  	}
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index 2af6ea82526d..3637996d37ab 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -1174,7 +1174,6 @@ void pci_restore_aer_state(struct pci_dev *dev);
>  static inline void pci_no_aer(void) { }
>  static inline void pci_aer_init(struct pci_dev *d) { }
>  static inline void pci_aer_exit(struct pci_dev *d) { }
> -static inline void pci_aer_clear_fatal_status(struct pci_dev *dev) { }
>  static inline int pci_aer_clear_status(struct pci_dev *dev) { return -EINVAL; }
>  static inline int pci_aer_raw_clear_status(struct pci_dev *dev) { return -EINVAL; }
>  static inline void pci_save_aer_state(struct pci_dev *dev) { }
> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index e806fa05280b..4cf44297bb24 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -297,6 +297,7 @@ void pci_aer_clear_fatal_status(struct pci_dev *dev)
>  	if (status)
>  		pci_write_config_dword(dev, aer + PCI_ERR_UNCOR_STATUS, status);
>  }
> +EXPORT_SYMBOL_GPL(pci_aer_clear_fatal_status);
>  
>  /**
>   * pci_aer_raw_clear_status - Clear AER error registers.
> diff --git a/include/linux/aer.h b/include/linux/aer.h
> index 6b2c87d1b5b6..64aef69fb546 100644
> --- a/include/linux/aer.h
> +++ b/include/linux/aer.h
> @@ -66,6 +66,7 @@ struct cxl_proto_err_work_data {
>  
>  #if defined(CONFIG_PCIEAER)
>  int pci_aer_clear_nonfatal_status(struct pci_dev *dev);
> +void pci_aer_clear_fatal_status(struct pci_dev *dev);
>  int pcie_aer_is_native(struct pci_dev *dev);
>  void pci_aer_unmask_internal_errors(struct pci_dev *dev);
>  #else
> @@ -73,6 +74,7 @@ static inline int pci_aer_clear_nonfatal_status(struct pci_dev *dev)
>  {
>  	return -EINVAL;
>  }
> +static inline void pci_aer_clear_fatal_status(struct pci_dev *dev) { }
>  static inline int pcie_aer_is_native(struct pci_dev *dev) { return 0; }
>  static inline void pci_aer_unmask_internal_errors(struct pci_dev *dev) { }
>  #endif
> -- 
> 2.34.1
> 

