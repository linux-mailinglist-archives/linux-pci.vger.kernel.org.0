Return-Path: <linux-pci+bounces-19020-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83AAC9FC15A
	for <lists+linux-pci@lfdr.de>; Tue, 24 Dec 2024 19:50:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 14EC116421C
	for <lists+linux-pci@lfdr.de>; Tue, 24 Dec 2024 18:50:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF9ED20E327;
	Tue, 24 Dec 2024 18:50:08 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C4A91D90AC;
	Tue, 24 Dec 2024 18:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735066208; cv=none; b=mwJPvFu6EflEw3nvqHWbs/0T2zZWP8opWdeIFaFLlCll3TR+tgITMeEHHw3SSqN2e3XTeyyfVKlzVkaEOVYOGOs355Cd+CxO9j1mGyFyb+1GvAjKPunowFt0T6bNk/4aWkkuh9UpmCUgPJ40CjKA+VK6xc7gF/GA/WavLcBpO5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735066208; c=relaxed/simple;
	bh=z30OxrYLbJj6bVuoQ5USJPMXfB6n0tYkxD0rIy5LMK4=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z/QFpFl6QVzBbQsm1d85GRY8DSGmmO5DNkOqKf/L4Xv47G12RCiJ7X3ZP/ZUEUlF9X1tESHjLzlO7fh07wddudL4LRLpsOki6w9HplgvM1kLTtPHcG5z75P8MwjMH33kcvPl0dgdHJo1b9pRv9qCYz2kMf1IM/KtRf4ZCFIL5qE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4YHkTM6McTz6K6QM;
	Wed, 25 Dec 2024 02:49:43 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 53B8B140736;
	Wed, 25 Dec 2024 02:50:04 +0800 (CST)
Received: from localhost (10.48.156.150) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 24 Dec
 2024 19:50:03 +0100
Date: Tue, 24 Dec 2024 18:50:00 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Terry Bowman <terry.bowman@amd.com>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <nifan.cxl@gmail.com>, <ming4.li@intel.com>,
	<dave@stgolabs.net>, <dave.jiang@intel.com>, <alison.schofield@intel.com>,
	<vishal.l.verma@intel.com>, <dan.j.williams@intel.com>,
	<bhelgaas@google.com>, <mahesh@linux.ibm.com>, <ira.weiny@intel.com>,
	<oohall@gmail.com>, <Benjamin.Cheatham@amd.com>, <rrichter@amd.com>,
	<nathan.fontenot@amd.com>, <Smita.KoralahalliChannabasappa@amd.com>,
	<lukas@wunner.de>, <PradeepVineshReddy.Kodamati@amd.com>
Subject: Re: [PATCH v4 14/15] cxl/pci: Add support to assign and clear
 pci_driver::cxl_err_handlers
Message-ID: <20241224185000.00001a5f@huawei.com>
In-Reply-To: <20241211234002.3728674-15-terry.bowman@amd.com>
References: <20241211234002.3728674-1-terry.bowman@amd.com>
	<20241211234002.3728674-15-terry.bowman@amd.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100001.china.huawei.com (7.191.160.183) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Wed, 11 Dec 2024 17:40:01 -0600
Terry Bowman <terry.bowman@amd.com> wrote:

> pci_driver::cxl_err_handlers are not currently assigned handler callbacks.
> The handlers can't be set in the pci_driver static definition because the
> CXL PCIe Port devices are bound to the portdrv driver which is not CXL
> driver aware.
> 
> Add cxl_assign_port_error_handlers() in the cxl_core module. This
> function will assign the default handlers for a CXL PCIe Port device.
> 
> When the CXL Port (cxl_port or cxl_dport) is destroyed the device's
> pci_driver::cxl_err_handlers must be set to NULL indicating they should no
> longer be used.
> 
> Create cxl_clear_port_error_handlers() and register it to be called
> when the CXL Port device (cxl_port or cxl_dport) is destroyed.
> 
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> ---
>  drivers/cxl/core/pci.c | 40 ++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 40 insertions(+)
> 
> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index 3294ad5ff28f..9734a4c55b29 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
> @@ -841,8 +841,38 @@ static bool cxl_port_error_detected(struct pci_dev *pdev)
>  	return __cxl_handle_ras(&pdev->dev, ras_base);
>  }
>  
> +static const struct cxl_error_handlers cxl_port_error_handlers = {
> +	.error_detected	= cxl_port_error_detected,
> +	.cor_error_detected = cxl_port_cor_error_detected,
> +};
> +
> +static void cxl_assign_port_error_handlers(struct pci_dev *pdev)
> +{
> +	struct pci_driver *pdrv;
> +
> +	if (!pdev || !pdev->driver)
> +		return;
> +
> +	pdrv = pdev->driver;

What stops a race here?  It's fiddly to remove that driver but
it can be done.  At least I think we are messing withe portdrv
but this is such a fiddly stack I'm not 100% sure.

> +	pdrv->cxl_err_handler = &cxl_port_error_handlers;
> +}
> +
> +static void cxl_clear_port_error_handlers(void *data)
> +{
> +	struct pci_dev *pdev = data;
> +	struct pci_driver *pdrv;
> +
> +	if (!pdev || !pdev->driver)
> +		return;
> +
> +	pdrv = pdev->driver;
Likewise. Smells like a possible race.

> +	pdrv->cxl_err_handler = NULL;
> +}
> +
>  void cxl_uport_init_ras_reporting(struct cxl_port *port)
>  {
> +	struct pci_dev *pdev = to_pci_dev(port->uport_dev);
> +
>  	/* uport may have more than 1 downstream EP. Check if already mapped. */
>  	if (port->uport_regs.ras)
>  		return;
> @@ -853,6 +883,9 @@ void cxl_uport_init_ras_reporting(struct cxl_port *port)
>  		dev_err(&port->dev, "Failed to map RAS capability.\n");
>  		return;
>  	}
> +
> +	cxl_assign_port_error_handlers(pdev);
> +	devm_add_action_or_reset(port->uport_dev, cxl_clear_port_error_handlers, pdev);
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_uport_init_ras_reporting, CXL);
>  
> @@ -864,6 +897,7 @@ void cxl_dport_init_ras_reporting(struct cxl_dport *dport)
>  {
>  	struct device *dport_dev = dport->dport_dev;
>  	struct pci_host_bridge *host_bridge = to_pci_host_bridge(dport_dev);
> +	struct pci_dev *pdev = to_pci_dev(dport_dev);
>  
>  	dport->reg_map.host = dport_dev;
>  	if (dport->rch && host_bridge->native_aer) {
> @@ -880,6 +914,12 @@ void cxl_dport_init_ras_reporting(struct cxl_dport *dport)
>  		dev_err(dport_dev, "Failed to map RAS capability.\n");
>  		return;
>  	}
> +
> +	if (dport->rch)
> +		return;
> +
> +	cxl_assign_port_error_handlers(pdev);
> +	devm_add_action_or_reset(dport_dev, cxl_clear_port_error_handlers, pdev);
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_dport_init_ras_reporting, CXL);
>  


