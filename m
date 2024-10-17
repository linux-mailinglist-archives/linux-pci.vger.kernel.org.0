Return-Path: <linux-pci+bounces-14786-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 545909A2463
	for <lists+linux-pci@lfdr.de>; Thu, 17 Oct 2024 15:57:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F12BA1F217A8
	for <lists+linux-pci@lfdr.de>; Thu, 17 Oct 2024 13:57:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 029B51DD540;
	Thu, 17 Oct 2024 13:57:14 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA9691DB346;
	Thu, 17 Oct 2024 13:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729173433; cv=none; b=io1A17+ylh/JemOSUixJiCgeW/216hnFuzhqAh7yaydECUe/26NW+u38CF+QLppfkb4KwDLvXqK+znut+Jv57uPnLeste2uguMcmXSpTg58vnbkwVBYFjUI+js6PNJKmvC1EO44skJWSBiODBZkGmoPAecd3c9Cr8Ka9/T+al3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729173433; c=relaxed/simple;
	bh=dtkFcsRlwUuU51KNJdQptg5gAjCKgrQm6G8DaP5HcO4=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZZeX+CUAddfBJoliskc6LlVF5NS8oM60vweEUU3OlVKFWEYhvTsOw4Ij27R8hQld7wAboMh1XbMv8PR7JBpLREplA29B6FJkpm2aziDTW1zWUUUzsRbFnQNwBFU6m6wL1UUcJrlpa7Qe6DtEIbD7brh8SaQhQNcTHHfdtjGEUo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XTq954nS0z6FHBC;
	Thu, 17 Oct 2024 21:55:21 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id DF2A01400C9;
	Thu, 17 Oct 2024 21:57:05 +0800 (CST)
Received: from localhost (10.126.174.164) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 17 Oct
 2024 15:57:04 +0200
Date: Thu, 17 Oct 2024 14:57:02 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Terry Bowman <terry.bowman@amd.com>
CC: <ming4.li@intel.com>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<dave@stgolabs.net>, <dave.jiang@intel.com>, <alison.schofield@intel.com>,
	<vishal.l.verma@intel.com>, <dan.j.williams@intel.com>,
	<bhelgaas@google.com>, <mahesh@linux.ibm.com>, <oohall@gmail.com>,
	<Benjamin.Cheatham@amd.com>, <rrichter@amd.com>, <nathan.fontenot@amd.com>,
	<smita.koralahallichannabasappa@amd.com>
Subject: Re: [PATCH 12/15] cxl/pci: Add error handler for CXL PCIe port RAS
 errors
Message-ID: <20241017145702.00006e58@Huawei.com>
In-Reply-To: <20241008221657.1130181-13-terry.bowman@amd.com>
References: <20241008221657.1130181-1-terry.bowman@amd.com>
	<20241008221657.1130181-13-terry.bowman@amd.com>
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
X-ClientProxiedBy: lhrpeml100006.china.huawei.com (7.191.160.224) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Tue, 8 Oct 2024 17:16:54 -0500
Terry Bowman <terry.bowman@amd.com> wrote:

> The CXL drivers do not contain error handlers for CXL PCIe port
> device protocol errors. These are needed in order to handle and log
> RAS protocol errors.
> 
> Add CXL PCIe port protocol error handlers to the CXL driver.
> 
> Provide access to RAS registers for the specific CXL PCIe port types:
> root port, upstream switch port, and downstream switch port.
> 
> Also, register and unregister the CXL PCIe port error handlers with
> the AER service driver using register_cxl_port_err_hndlrs() and
> unregister_cxl_port_err_hndlrs(). Invoke the registration from
> cxl_pci_driver_init() and the unregistration from cxl_pci_driver_exit().
> 
> [1] CXL3.1 - 12.2.2 CXL Root Ports, Downstream Switch Ports, and
>              Upstream Switch Ports
> 
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
A few comments inline.

Jonathan

> ---
>  drivers/cxl/core/pci.c | 83 ++++++++++++++++++++++++++++++++++++++++++
>  drivers/cxl/cxl.h      |  5 +++
>  drivers/cxl/pci.c      |  8 ++++
>  3 files changed, 96 insertions(+)
> 
> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index c3c82c051d73..7e3770f7a955 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
> @@ -815,6 +815,89 @@ static void cxl_disable_rch_root_ints(struct cxl_dport *dport)
>  	}
>  }
>  
> +static int match_uport(struct device *dev, const void *data)
> +{
> +	struct device *uport_dev = (struct device *)data;
> +	struct cxl_port *port;
> +
> +	if (!is_cxl_port(dev))
> +		return 0;
> +
> +	port = to_cxl_port(dev);
> +
> +	return port->uport_dev == uport_dev;
> +}
> +
> +static void __iomem *cxl_pci_port_ras(struct pci_dev *pdev)
> +{
> +	void __iomem *ras_base;
> +	struct cxl_port *port;
> +
> +	if (!pdev)
> +		return NULL;
Why would this happen?  Seems an odd check to have so maybe a comment.

> +
> +	if ((pci_pcie_type(pdev) == PCI_EXP_TYPE_ROOT_PORT) ||
> +	    (pci_pcie_type(pdev) == PCI_EXP_TYPE_DOWNSTREAM)) {
> +		struct cxl_dport *dport;
> +
> +		port = find_cxl_port(&pdev->dev, &dport);
Can in theory fail.
> +		ras_base = dport ? dport->regs.ras : NULL;
> +		put_device(&port->dev);
If it fails this is a null pointer dereference.

> +		return ras_base;
> +	} else if (pci_pcie_type(pdev) == PCI_EXP_TYPE_UPSTREAM) {
> +		struct device *port_dev __free(put_device);

Should be combined with the next line. We want it to be hard for anyone
to put code in between!

> +
> +		port_dev = bus_find_device(&cxl_bus_type, NULL, &pdev->dev, match_uport);
> +		if (!port_dev)
> +			return NULL;
> +
> +		port = to_cxl_port(port_dev);
> +		if (!port)
> +			return NULL;
> +
> +		ras_base = port ? port->uport_regs.ras : NULL;

Given check above, port exists. Remove one of the two
checks.

> +		return ras_base;
> +	}
> +
> +	return NULL;
> +}

