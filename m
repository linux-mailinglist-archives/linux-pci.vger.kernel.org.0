Return-Path: <linux-pci+bounces-9013-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 56D0591028B
	for <lists+linux-pci@lfdr.de>; Thu, 20 Jun 2024 13:31:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 09AD71F22242
	for <lists+linux-pci@lfdr.de>; Thu, 20 Jun 2024 11:31:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE5A815B107;
	Thu, 20 Jun 2024 11:31:10 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8616878C9C;
	Thu, 20 Jun 2024 11:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718883070; cv=none; b=VJRUzpE+Jjl7ZqlKhQWkOZ5jQ0CXTtEY5l4YLWTbYCuRvp9zNC8RR84JfCXuAad8nNBWeTYnXEFXmmstTnMQD6jsDC6nbAuMWxLvQPE2kQeQbTqhiEEyk9WS927s+tQwgW+TsBclZFHZ3AsdPxrMx+cCuPnG3In86naP9cf6Q/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718883070; c=relaxed/simple;
	bh=ngXGENhKJ5ubOJfWmkGWNflPB0T6h1OvqocKXTMdnEY=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dBt6mm2cvI6BaoXC0UNnOoyPz1lFo7MQMlM0BIBhWNIq2EcZWCQFuSJJBDI/fObtFJWh9IpEUDwEPg+I0/qxtu0ZWUIOoR51EQWrax/8ChZWOOCpI+1X/b1mQvw1MDsUb6EhEAaA7T4fmKoMqouv9fgZNfcGgp0MDBdZ980YvYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4W4dbX34SNz6JB7h;
	Thu, 20 Jun 2024 19:31:04 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 2D3C31400D9;
	Thu, 20 Jun 2024 19:31:06 +0800 (CST)
Received: from localhost (10.203.174.77) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 20 Jun
 2024 12:31:05 +0100
Date: Thu, 20 Jun 2024 12:31:04 +0100
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
Subject: Re: [RFC PATCH 2/9] PCI/AER: Call AER CE handler before clearing
 AER CE status register
Message-ID: <20240620123104.000029cf@Huawei.com>
In-Reply-To: <20240617200411.1426554-3-terry.bowman@amd.com>
References: <20240617200411.1426554-1-terry.bowman@amd.com>
	<20240617200411.1426554-3-terry.bowman@amd.com>
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
X-ClientProxiedBy: lhrpeml500002.china.huawei.com (7.191.160.78) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Mon, 17 Jun 2024 15:04:04 -0500
Terry Bowman <terry.bowman@amd.com> wrote:

> The AER service driver clears the AER correctable error (CE) status before
> calling the correctable error handler. This results in the error's status
> not correctly reflected if read from the CE handler.
> 
> The AER CE status is needed by the portdrv's CE handler. The portdrv's
> CE handler is intended to only call the registered notifier callbacks
> if the CE error status has correctable internal error (CIE) set.
> 
> This is not a problem for AER uncorrrectbale errors (UCE). The UCE status

uncorrectable

> is still present in the AER capability and available for reading, if
> needed, when the UCE handler is called.

I'm seeing the clear in the DPC path for UCE. For other cases is
it a side effect of the reset?

> 
> Change the order of clearing the CE status and calling the CE handler.
> Make it to call the CE handler first and then clear the CE status
> after returning.
> 
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: linux-pci@vger.kernel.org
Seems reasonable, but many gremlins around the ordering in these
flows, so I'm to particularly confident. With that in mind.
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huwei.com>

> ---
>  drivers/pci/pcie/aer.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index ac6293c24976..4dc03cb9aff0 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -1094,9 +1094,6 @@ static void pci_aer_handle_error(struct pci_dev *dev, struct aer_err_info *info)
>  		 * Correctable error does not need software intervention.
>  		 * No need to go through error recovery process.
>  		 */
> -		if (aer)
> -			pci_write_config_dword(dev, aer + PCI_ERR_COR_STATUS,
> -					info->status);
>  		if (pcie_aer_is_native(dev)) {
>  			struct pci_driver *pdrv = dev->driver;
>  
> @@ -1105,6 +1102,10 @@ static void pci_aer_handle_error(struct pci_dev *dev, struct aer_err_info *info)
>  				pdrv->err_handler->cor_error_detected(dev);
>  			pcie_clear_device_status(dev);
>  		}
> +		if (aer)
> +			pci_write_config_dword(dev, aer + PCI_ERR_COR_STATUS,
> +					info->status);
> +
>  	} else if (info->severity == AER_NONFATAL)
>  		pcie_do_recovery(dev, pci_channel_io_normal, aer_root_reset);
>  	else if (info->severity == AER_FATAL)


