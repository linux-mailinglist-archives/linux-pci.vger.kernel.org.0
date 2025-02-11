Return-Path: <linux-pci+bounces-21219-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3D51A31694
	for <lists+linux-pci@lfdr.de>; Tue, 11 Feb 2025 21:25:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9344D1670FF
	for <lists+linux-pci@lfdr.de>; Tue, 11 Feb 2025 20:25:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D60B6262D0F;
	Tue, 11 Feb 2025 20:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dSHFFhfC"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A780926156B;
	Tue, 11 Feb 2025 20:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739305553; cv=none; b=LsnkQfWcvyyzmVUNGsMH6gL+b6IFBMnwIlGruvOkuYJhqRGAxFmN1wiIrxiphusNcLUBVWB2qe7d1OieWtTdyZNthZggEwsdHFasf072UcPhsBEWu18qWAQqJ3B8LqbmF7dUb6xP3yV2RV0dR0uqxxurW/i6xSo+FsIqViWAbs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739305553; c=relaxed/simple;
	bh=48gzJgcITRa5XQ6Ud238wwhbUgPKwfcs2YVV+bj1R28=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=JR/hAO4PoiW3bxeYiW3156NymM0HMsfclS5OIt19405XhlBFrbLglNpmNvfnDVVCHSznLusRoxfw6/d9Mp56IOnbm3e0xJNzqsmZyiW2HKgsoIBmGsT0pCbvE7xeoVFyXXN45NC1KuPR6Fx1/94IWt0UEUy9MH2Rk2GsoJ8/+zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dSHFFhfC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F24BFC4CEDD;
	Tue, 11 Feb 2025 20:25:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739305553;
	bh=48gzJgcITRa5XQ6Ud238wwhbUgPKwfcs2YVV+bj1R28=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=dSHFFhfCn2aAHOp8I+VYdlzYczQUJ5Ci6383Tx+zoVH4ERGEpu/TizYzyXuqSEx7V
	 oMd30x4ZBQQ6dujTtBYzpu6edrs3qKoBhfTTq17lXteYd+fWY6MuoBAVoUKFhzE12D
	 VfOy5V5GNF5e6nVGchPlQgtn8AxO0g75KXhjis0yLVkobapPyltVWFQBrylFYEwygx
	 ET0PacuXk2zjD4nkIesY1SxjyoNcBePYS/ZfIWhs1y3gRUYR2FCPog1loYN9IenQSL
	 VO6zK9Vq/Z1xrTqEz9a8L1AL9kMIZM93PKS53Hgtt3/eHFoDmQ5voLuHcoXYnMHC4d
	 ZXBN4B0pHgulg==
Date: Tue, 11 Feb 2025 14:25:51 -0600
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
Subject: Re: [PATCH v7 01/17] PCI/AER: Introduce 'struct cxl_err_handlers'
 and add to 'struct pci_driver'
Message-ID: <20250211202551.GA53774@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250211192444.2292833-2-terry.bowman@amd.com>

On Tue, Feb 11, 2025 at 01:24:28PM -0600, Terry Bowman wrote:
> CXL.io is implemented on top of PCIe Protocol Errors. But, CXL.io and PCIe
> have different handling requirements for uncorrectable errors (UCE).
> 
> The PCIe AER service driver may attempt recovering PCIe devices with
> UCE while recovery is not used for CXL.io. Recovery is not used in the
> CXL.io case because of potential corruption on what can be system memory.
> 
> Create pci_driver::cxl_err_handlers structure similar to
> pci_driver::error_handler. Create handlers for correctable and
> uncorrectable CXL.io error handling.
> 
> The CXL error handlers will be used in future patches adding CXL PCIe
> Port Protocol Error handling.
> 
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> Reviewed-by: Fan Ni <fan.ni@samsung.com>
> Reviewed-by: Ira Weiny <ira.weiny@intel.com>
> Reviewed-by: Gregory Price <gourry@gourry.net>

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

> ---
>  include/linux/pci.h | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 47b31ad724fa..1d62e785ae1f 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -884,6 +884,14 @@ struct pci_error_handlers {
>  	void (*cor_error_detected)(struct pci_dev *dev);
>  };
>  
> +/* Compute Express Link (CXL) bus error event callbacks */
> +struct cxl_error_handlers {
> +	/* CXL bus error detected on this device */
> +	pci_ers_result_t (*error_detected)(struct pci_dev *dev);
> +
> +	/* Allow device driver to record more details of a correctable error */
> +	void (*cor_error_detected)(struct pci_dev *dev);
> +};
>  
>  struct module;
>  
> @@ -929,6 +937,7 @@ struct module;
>   * @sriov_get_vf_total_msix: PF driver callback to get the total number of
>   *              MSI-X vectors available for distribution to the VFs.
>   * @err_handler: See Documentation/PCI/pci-error-recovery.rst
> + * @cxl_err_handler: Compute Express Link specific error handlers.
>   * @groups:	Sysfs attribute groups.
>   * @dev_groups: Attributes attached to the device that will be
>   *              created once it is bound to the driver.
> @@ -954,6 +963,7 @@ struct pci_driver {
>  	int  (*sriov_set_msix_vec_count)(struct pci_dev *vf, int msix_vec_count); /* On PF */
>  	u32  (*sriov_get_vf_total_msix)(struct pci_dev *pf);
>  	const struct pci_error_handlers *err_handler;
> +	const struct cxl_error_handlers *cxl_err_handler;
>  	const struct attribute_group **groups;
>  	const struct attribute_group **dev_groups;
>  	struct device_driver	driver;
> -- 
> 2.34.1
> 

