Return-Path: <linux-pci+bounces-9014-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 061F8910439
	for <lists+linux-pci@lfdr.de>; Thu, 20 Jun 2024 14:32:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7720E1F21E50
	for <lists+linux-pci@lfdr.de>; Thu, 20 Jun 2024 12:32:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C73A1ACE65;
	Thu, 20 Jun 2024 12:30:35 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B52F91AC255;
	Thu, 20 Jun 2024 12:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718886635; cv=none; b=c1bZgsgaBDFwFud0NQMln9GO8Ftt2dBlWIBsK5ZO/zNJnWBpf3+f0ZF7T58sjPCh6u/7tRzQ4X8XXBbj4IhBO+K/XJ1Q0X9Vj9YkEcGCWRl26s3PGp6qFuonaFih65+fDwitrcTpPTKJnLZ6NCejI/q5V5dK22Mw6GvFkIt1wZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718886635; c=relaxed/simple;
	bh=E/tMBWgqECjSpTbCNeHEJfdD6kMr0Vd0U5MuM6NTzYc=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C+1Njcu9sMbuNRQbIESM1jcDo1aCo63PO0b/9JkiGck3d1Z8GhwR10HvLaPzwXMUIIwIjeDNi64e1YPoQj26T7gJrWhBYFYNtvnMWHdLAzCIz2xjUazq3CdQpCuuofzfMS4sbF2P31wR73cp3IRLy6pxuvi01cIBQdd53VIEzW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4W4ftH3gzFz67kr9;
	Thu, 20 Jun 2024 20:28:55 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id B9D12140A90;
	Thu, 20 Jun 2024 20:30:28 +0800 (CST)
Received: from localhost (10.203.174.77) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 20 Jun
 2024 13:30:28 +0100
Date: Thu, 20 Jun 2024 13:30:27 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Terry Bowman <terry.bowman@amd.com>
CC: <dan.j.williams@intel.com>, <ira.weiny@intel.com>, <dave@stgolabs.net>,
	<dave.jiang@intel.com>, <alison.schofield@intel.com>, <ming4.li@intel.com>,
	<vishal.l.verma@intel.com>, <jim.harris@samsung.com>,
	<ilpo.jarvinen@linux.intel.com>, <ardb@kernel.org>,
	<sathyanarayanan.kuppuswamy@linux.intel.com>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <Yazen.Ghannam@amd.com>,
	<Robert.Richter@amd.com>, Bjorn Helgaas <bhelgaas@google.com>,
	<linux-pci@vger.kernel.org>
Subject: Re: [RFC PATCH 3/9] PCI/portdrv: Update portdrv with an atomic
 notifier for reporting AER internal errors
Message-ID: <20240620133027.000047e1@Huawei.com>
In-Reply-To: <20240617200411.1426554-4-terry.bowman@amd.com>
References: <20240617200411.1426554-1-terry.bowman@amd.com>
	<20240617200411.1426554-4-terry.bowman@amd.com>
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
X-ClientProxiedBy: lhrpeml100004.china.huawei.com (7.191.162.219) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Mon, 17 Jun 2024 15:04:05 -0500
Terry Bowman <terry.bowman@amd.com> wrote:

> PCIe port devices are bound to portdrv, the PCIe port bus driver. portdrv
> does not implement an AER correctable handler (CE) but does implement the
> AER uncorrectable error (UCE). The UCE handler is fairly straightforward
> in that it only checks for frozen error state and returns the next step
> for recovery accordingly.
> 
> As a result, port devices relying on AER correctable internal errors (CIE)
> and AER uncorrectable internal errors (UIE) will not be handled. Note,
> the PCIe spec indicates AER CIE/UIE can be used to report implementation
> specific errors.[1]
> 
> CXL root ports, CXL downstream switch ports, and CXL upstream switch ports
> are examples of devices using the AER CIE/UIE for implementation specific
> purposes. These CXL ports use the AER interrupt and AER CIE/UIE status to
> report CXL RAS errors.[2]
> 
> Add an atomic notifier to portdrv's CE/UCE handlers. Use the atomic
> notifier to report CIE/UIE errors to the registered functions. This will
> require adding a CE handler and updating the existing UCE handler.
> 
> For the UCE handler, the CXL spec states UIE errors should return need
> reset: "The only method of recovering from an Uncorrectable Internal Error
> is reset or hardware replacement."[1]
> 
> [1] PCI6.0 - 6.2.10 Internal Errors
> [2] CXL3.1 - 12.2.2 CXL Root Ports, Downstream Switch Ports, and
>              Upstream Switch Ports
> 
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: linux-pci@vger.kernel.org
> ---
>  drivers/pci/pcie/portdrv.c | 32 ++++++++++++++++++++++++++++++++
>  drivers/pci/pcie/portdrv.h |  2 ++
>  2 files changed, 34 insertions(+)
> 
> diff --git a/drivers/pci/pcie/portdrv.c b/drivers/pci/pcie/portdrv.c
> index 14a4b89a3b83..86d80e0e9606 100644
> --- a/drivers/pci/pcie/portdrv.c
> +++ b/drivers/pci/pcie/portdrv.c
> @@ -37,6 +37,9 @@ struct portdrv_service_data {
>  	u32 service;
>  };
>  
> +ATOMIC_NOTIFIER_HEAD(portdrv_aer_internal_err_chain);
> +EXPORT_SYMBOL_GPL(portdrv_aer_internal_err_chain);

Perhaps these should be per instance of the portdrv?
I'd imagine we only want to register CXL ones on CXL ports etc
and it's annoying to have to check at runtime for relevance
of a particular notifier.

> +
>  /**
>   * release_pcie_device - free PCI Express port service device structure
>   * @dev: Port service device to release
> @@ -745,11 +748,39 @@ static void pcie_portdrv_shutdown(struct pci_dev *dev)
>  static pci_ers_result_t pcie_portdrv_error_detected(struct pci_dev *dev,
>  					pci_channel_state_t error)
>  {
> +	if (dev->aer_cap) {
> +		u32 status;
> +
> +		pci_read_config_dword(dev, dev->aer_cap + PCI_ERR_UNCOR_STATUS,
> +				      &status);
> +
> +		if (status & PCI_ERR_UNC_INTN) {
> +			atomic_notifier_call_chain(&portdrv_aer_internal_err_chain,
> +						   AER_FATAL, (void *)dev);

Don't think the cast is needed as always fine to implicitly cast to and from
void * in C.

> +			return PCI_ERS_RESULT_NEED_RESET;
> +		}
> +	}
> +
>  	if (error == pci_channel_io_frozen)
>  		return PCI_ERS_RESULT_NEED_RESET;
>  	return PCI_ERS_RESULT_CAN_RECOVER;
>  }
>  
> +static void pcie_portdrv_cor_error_detected(struct pci_dev *dev)
> +{
> +	u32 status;
> +
> +	if (!dev->aer_cap)
> +		return;
> +
> +	pci_read_config_dword(dev, dev->aer_cap + PCI_ERR_COR_STATUS,
> +			      &status);
> +
> +	if (status & PCI_ERR_COR_INTERNAL)
> +		atomic_notifier_call_chain(&portdrv_aer_internal_err_chain,
> +					   AER_CORRECTABLE, (void *)dev);

No need for the cast.

> +}
> +
>  static pci_ers_result_t pcie_portdrv_slot_reset(struct pci_dev *dev)
>  {
>  	size_t off = offsetof(struct pcie_port_service_driver, slot_reset);
> @@ -780,6 +811,7 @@ static const struct pci_device_id port_pci_ids[] = {
>  
>  static const struct pci_error_handlers pcie_portdrv_err_handler = {
>  	.error_detected = pcie_portdrv_error_detected,
> +	.cor_error_detected = pcie_portdrv_cor_error_detected,
>  	.slot_reset = pcie_portdrv_slot_reset,
>  	.mmio_enabled = pcie_portdrv_mmio_enabled,
>  };
> diff --git a/drivers/pci/pcie/portdrv.h b/drivers/pci/pcie/portdrv.h
> index 12c89ea0313b..8a39197f0203 100644
> --- a/drivers/pci/pcie/portdrv.h
> +++ b/drivers/pci/pcie/portdrv.h
> @@ -121,4 +121,6 @@ static inline void pcie_pme_interrupt_enable(struct pci_dev *dev, bool en) {}
>  #endif /* !CONFIG_PCIE_PME */
>  
>  struct device *pcie_port_find_device(struct pci_dev *dev, u32 service);
> +
> +extern struct atomic_notifier_head portdrv_aer_internal_err_chain;
>  #endif /* _PORTDRV_H_ */


