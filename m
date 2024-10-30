Return-Path: <linux-pci+bounces-15643-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 48CCE9B68EC
	for <lists+linux-pci@lfdr.de>; Wed, 30 Oct 2024 17:11:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F12661F21C2C
	for <lists+linux-pci@lfdr.de>; Wed, 30 Oct 2024 16:11:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77C14212F1D;
	Wed, 30 Oct 2024 16:11:28 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBB9D433D5;
	Wed, 30 Oct 2024 16:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730304688; cv=none; b=Xh8cR5OPMetA4+omSTvWFAO6PL+lkTGOistomrjSq574OY0ZYh+oZUQ62y88KC1DLZNGdJWDyCJAc0I2ZSxuHIDCviMfG2MFcXfNpNjeZWmqeNtHc63idHeu92xuFZEyC/Ek6NxHjnBZIhZPHfuhoT2DA3wbH+ncvhKeeb8bsDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730304688; c=relaxed/simple;
	bh=DQ9O8ymxBFCCJfWsoERVpeUQdjxuhmTL/esmCBryiJs=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NHE3LVsTO4gmMxd92yTI1c7C8DbXef4XyxDYTiwuFmRWWqoB3iWgj6o8H4vD80M5Ll2pyodqLJ0HdSo1Mx8TIof2hwpvrfBwvnoMlKwGzq9bejJLPHm7mynjuY/tVVCZjIlV8KOt18M2G0EqLP6e1tOzyWbJclE8rqYZwLBIOu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XdsXX188Hz6J9sx;
	Thu, 31 Oct 2024 00:10:04 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id AA97A140B39;
	Thu, 31 Oct 2024 00:11:22 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 30 Oct
 2024 17:11:21 +0100
Date: Wed, 30 Oct 2024 16:11:20 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Terry Bowman <terry.bowman@amd.com>
CC: <ming4.li@intel.com>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<dave@stgolabs.net>, <dave.jiang@intel.com>, <alison.schofield@intel.com>,
	<vishal.l.verma@intel.com>, <dan.j.williams@intel.com>,
	<bhelgaas@google.com>, <mahesh@linux.ibm.com>, <ira.weiny@intel.com>,
	<oohall@gmail.com>, <Benjamin.Cheatham@amd.com>, <rrichter@amd.com>,
	<nathan.fontenot@amd.com>, <Smita.KoralahalliChannabasappa@amd.com>
Subject: Re: [PATCH v2 14/14] cxl/pci: Add support to assign and clear
 pci_driver::cxl_err_handlers
Message-ID: <20241030161120.000078b2@Huawei.com>
In-Reply-To: <20241025210305.27499-15-terry.bowman@amd.com>
References: <20241025210305.27499-1-terry.bowman@amd.com>
	<20241025210305.27499-15-terry.bowman@amd.com>
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

On Fri, 25 Oct 2024 16:03:05 -0500
Terry Bowman <terry.bowman@amd.com> wrote:

> pci_driver::cxl_err_handlers are not currrently assigned handler callbacks.
> The handlers can't be set in the pci_driver static definition because the
> CXL PCIe port devices are bound to the portdrv driver which is not CXL
> driver aware.
> 
> Add cxl_assign_port_error_handlers() in the cxl_core module. This
> function will assign the default handlers for a CXL PCIe port device.
> 
> When the CXL port (cxl_port or cxl_dport) is destroyed the CXL PCIe port
> device's pci_driver::cxl_err_handlers must be set to NULL to prevent future
> use. Create cxl_clear_port_error_handlers() and register it to be called
> when the CXL port device (cxl_port or cxl_dport) is destroyed.
> 
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
One trivial comment inline. 
> ---
>  drivers/cxl/core/pci.c | 35 +++++++++++++++++++++++++++++++++++
>  1 file changed, 35 insertions(+)
> 
> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index eeb4a64ba5b5..5f7570c6173c 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
> @@ -839,8 +839,36 @@ static bool cxl_port_error_detected(struct pci_dev *pdev)
>  	return ue;
>  }
>  
> +static const struct cxl_error_handlers cxl_port_error_handlers = {
> +	.error_detected	= cxl_port_error_detected,
> +	.cor_error_detected	= cxl_port_cor_error_detected,
Odd spacing?  I'd just use a single space as aligning these almost
always makes for messy future patches.

> +};
> +
> +static void cxl_assign_port_error_handlers(struct pci_dev *pdev)
> +{
> +	struct pci_driver *pdrv = pdev->driver;
> +
> +	if (!pdrv)
> +		return;
> +
> +	pdrv->cxl_err_handler = &cxl_port_error_handlers;
> +}
> +
> +static void cxl_clear_port_error_handlers(void *data)
> +{
> +	struct pci_dev *pdev = data;
> +	struct pci_driver *pdrv = pdev->driver;
> +
> +	if (!pdrv)
> +		return;
> +
> +	pdrv->cxl_err_handler = NULL;
> +}
> +
>  void cxl_uport_init_ras_reporting(struct cxl_port *port)
>  {
> +	struct pci_dev *pdev = to_pci_dev(port->uport_dev);
> +
>  	/* uport may have more than 1 downstream EP. Check if already mapped. */
>  	if (port->uport_regs.ras) {
>  		dev_warn(&port->dev, "RAS is already mapped\n");
> @@ -853,6 +881,9 @@ void cxl_uport_init_ras_reporting(struct cxl_port *port)
>  		dev_err(&port->dev, "Failed to map RAS capability.\n");
>  		return;
>  	}
> +
> +	cxl_assign_port_error_handlers(pdev);
> +	devm_add_action_or_reset(port->uport_dev, cxl_clear_port_error_handlers, pdev);
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_uport_init_ras_reporting, CXL);
>  
> @@ -865,6 +896,7 @@ void cxl_dport_init_ras_reporting(struct cxl_dport *dport)
>  {
>  	struct device *dport_dev = dport->dport_dev;
>  	struct pci_host_bridge *host_bridge = to_pci_host_bridge(dport_dev);
> +	struct pci_dev *pdev = to_pci_dev(dport_dev);
>  
>  	if (dport->rch && host_bridge->native_aer) {
>  		cxl_dport_map_rch_aer(dport);
> @@ -883,6 +915,9 @@ void cxl_dport_init_ras_reporting(struct cxl_dport *dport)
>  		dev_err(dport_dev, "Failed to map RAS capability.\n");
>  		return;
>  	}
> +
> +	cxl_assign_port_error_handlers(pdev);
> +	devm_add_action_or_reset(dport_dev, cxl_clear_port_error_handlers, pdev);
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_dport_init_ras_reporting, CXL);
>  


