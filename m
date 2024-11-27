Return-Path: <linux-pci+bounces-17423-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C211C9DAC2C
	for <lists+linux-pci@lfdr.de>; Wed, 27 Nov 2024 18:03:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 67F8B16485F
	for <lists+linux-pci@lfdr.de>; Wed, 27 Nov 2024 17:03:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FB111FF7A9;
	Wed, 27 Nov 2024 17:03:37 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBE8B3FB8B;
	Wed, 27 Nov 2024 17:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732727017; cv=none; b=LO+29DP5l1UwLzhvErPpGUKRt3WcWG7nVKzWHdMbh5Soik50xOtRuI4lLu6tIuPiNn41GFdQyQmrScDVgzOKfxsUtG1OqzEe2THxgVflBTPdtEcU9yNvpjuir5qfHwRRdIXkDI5HvrFDj/pLGnR2StVyyX91cgHY4K5C8xUmG5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732727017; c=relaxed/simple;
	bh=/MBQrgM9w6T2ANg5OY8gZZ/OJNjy1Rx3PVVK42tUjLY=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FvoG1yDT6L0tKNLbchWdoJPe/Voa1ZYSM7Jlq+izppfoSdiKZGdDJc01zLUjAH6d8GzrfabUgsglmMtoZbvawnblMKZUGGjkLAqwiBwy4JisnNguGzE9dKmXghPUsJmQaQGS63gTtnvZ2935PuuFoNrpnwdkEoJxqXeyHMWTPQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Xz5Nc559Dz6D971;
	Thu, 28 Nov 2024 01:02:56 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 16DDD1400D8;
	Thu, 28 Nov 2024 01:03:30 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 27 Nov
 2024 18:03:28 +0100
Date: Wed, 27 Nov 2024 17:03:27 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Terry Bowman <terry.bowman@amd.com>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <nifan.cxl@gmail.com>, <ming4.li@intel.com>,
	<dave@stgolabs.net>, <dave.jiang@intel.com>, <alison.schofield@intel.com>,
	<vishal.l.verma@intel.com>, <dan.j.williams@intel.com>,
	<bhelgaas@google.com>, <mahesh@linux.ibm.com>, <ira.weiny@intel.com>,
	<oohall@gmail.com>, <Benjamin.Cheatham@amd.com>, <rrichter@amd.com>,
	<nathan.fontenot@amd.com>, <Smita.KoralahalliChannabasappa@amd.com>,
	<lukas@wunner.de>
Subject: Re: [PATCH v3 05/15] PCI/AER: Add CXL PCIe port correctable error
 support in AER service driver
Message-ID: <20241127170327.00000374@huawei.com>
In-Reply-To: <20241113215429.3177981-6-terry.bowman@amd.com>
References: <20241113215429.3177981-1-terry.bowman@amd.com>
	<20241113215429.3177981-6-terry.bowman@amd.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100010.china.huawei.com (7.191.174.197) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Wed, 13 Nov 2024 15:54:19 -0600
Terry Bowman <terry.bowman@amd.com> wrote:

> The AER service driver supports handling downstream port protocol errors in
> restricted CXL host (RCH) mode also known as CXL1.1. It needs the same
> functionality for CXL PCIe ports operating in virtual hierarchy (VH)
> mode.[1]
> 
> CXL and PCIe protocol error handling have different requirements that
> necessitate a separate handling path. The AER service driver may try to
> recover PCIe uncorrectable non-fatal errors (UCE). The same recovery is not
> suitable for CXL PCIe port devices because of potential for system memory
> corruption. Instead, CXL protocol error handling must use a kernel panic
> in the case of a fatal or non-fatal UCE. The AER driver's PCIe error
> handling does not panic the kernel in response to a UCE.
> 
> Introduce a separate path for CXL protocol error handling in the AER
> service driver. This will allow CXL protocol errors to use CXL specific
> handling instead of PCIe handling. Add the CXL specific changes without
> affecting or adding functionality in the PCIe handling.
> 
> Make this update alongside the existing downstream port RCH error handling
> logic, extending support to CXL PCIe ports in VH mode.
> 
> is_internal_error() is currently limited by CONFIG_PCIEAER_CXL kernel
> config. Update is_internal_error()'s function declaration such that it is
> always available regardless if CONFIG_PCIEAER_CXL kernel config is enabled
> or disabled.
> 
> The uncorrectable error (UCE) handling will be added in a future patch.
> 
> [1] CXL 3.1 Spec, 12.2.2 CXL Root Ports, Downstream Switch Ports, and
> Upstream Switch Ports
> 
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
I took another look and so a question inline.

Jonathan

>  static int cxl_rch_handle_error_iter(struct pci_dev *dev, void *data)
>  {
>  	struct aer_err_info *info = (struct aer_err_info *)data;
> @@ -1033,14 +1032,23 @@ static int cxl_rch_handle_error_iter(struct pci_dev *dev, void *data)
>  
>  static void cxl_handle_error(struct pci_dev *dev, struct aer_err_info *info)
>  {
> -	/*
> -	 * Internal errors of an RCEC indicate an AER error in an
> -	 * RCH's downstream port. Check and handle them in the CXL.mem
> -	 * device driver.
> -	 */
> -	if (pci_pcie_type(dev) == PCI_EXP_TYPE_RC_EC &&
> -	    is_internal_error(info))
> +	if (pci_pcie_type(dev) == PCI_EXP_TYPE_RC_EC)
>  		pcie_walk_rcec(dev, cxl_rch_handle_error_iter, info);
> +
> +	if (info->severity == AER_CORRECTABLE) {
> +		struct pci_driver *pdrv = dev->driver;
> +		int aer = dev->aer_cap;
> +
> +		if (aer)

How do we get here with no aer?

On a PCIe device AER is optional, but not I think on a CXL device
(I can't find the text but there is a change log entry that says
to clarify that it is required for CXL devices)

Maybe the optionality is why the PCIe code has this check.

Anyhow, I don't really mind keeping it, was just curious.

> +			pci_write_config_dword(dev, aer + PCI_ERR_COR_STATUS,
> +					       info->status);
> +
> +		if (pdrv && pdrv->cxl_err_handler &&
> +		    pdrv->cxl_err_handler->cor_error_detected)
> +			pdrv->cxl_err_handler->cor_error_detected(dev);
> +
> +		pcie_clear_device_status(dev);
> +	}
>  }


