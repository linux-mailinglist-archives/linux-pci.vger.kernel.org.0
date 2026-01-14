Return-Path: <linux-pci+bounces-44835-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 087B2D20FB4
	for <lists+linux-pci@lfdr.de>; Wed, 14 Jan 2026 20:11:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EC8A8300EDCC
	for <lists+linux-pci@lfdr.de>; Wed, 14 Jan 2026 19:11:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED6AC340DA4;
	Wed, 14 Jan 2026 19:11:50 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAEF833D6E7;
	Wed, 14 Jan 2026 19:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768417910; cv=none; b=H5vsB1ebGMUEg6vJ1iJiHK0I1rBxuKqaUnw4yaHPghoWBJNClHNHqKI4ECNS02r8MnMmGbsQvWe9OX747uVBQszCQh8FSSEiC4VDkkS46JZE5Qu1LGu8jjsaiQVQshzA1jp9bFMvLym6dVPmOUjXqsbDkQW2EGiLfAYMV0ZtPSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768417910; c=relaxed/simple;
	bh=vropTZvuSlxUO1hZZWRGv+wTPG7HH2bg0CE0pXeoq84=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IgZ1tTMKSJZyRvmdLbiZzOYzBtXxo0RjA2RHv0AdzCS1tPhPZbsgw6BULxENY/eaW6f+QJwK25X2DdORBm+uVoUFTkJPD+WXxrMrIbuXu62fWHfDNUs5d/s+0TCf8ERHhaUeI5IQHmugs19irFvJGP+jWO7T2JjxXY3oUj5oiVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.107])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4drwhG27w5zHnGgq;
	Thu, 15 Jan 2026 03:11:26 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id BAEFF40570;
	Thu, 15 Jan 2026 03:11:46 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Wed, 14 Jan
 2026 19:11:45 +0000
Date: Wed, 14 Jan 2026 19:11:44 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Terry Bowman <terry.bowman@amd.com>
CC: <dave@stgolabs.net>, <dave.jiang@intel.com>, <alison.schofield@intel.com>,
	<dan.j.williams@intel.com>, <bhelgaas@google.com>, <shiju.jose@huawei.com>,
	<ming.li@zohomail.com>, <Smita.KoralahalliChannabasappa@amd.com>,
	<rrichter@amd.com>, <dan.carpenter@linaro.org>,
	<PradeepVineshReddy.Kodamati@amd.com>, <lukas@wunner.de>,
	<Benjamin.Cheatham@amd.com>, <sathyanarayanan.kuppuswamy@linux.intel.com>,
	<linux-cxl@vger.kernel.org>, <vishal.l.verma@intel.com>, <alucerop@amd.com>,
	<ira.weiny@intel.com>, <linux-kernel@vger.kernel.org>,
	<linux-pci@vger.kernel.org>
Subject: Re: [PATCH v14 12/34] PCI/AER: Use guard() in
 cxl_rch_handle_error_iter()
Message-ID: <20260114191144.0000106e@huawei.com>
In-Reply-To: <20260114182055.46029-13-terry.bowman@amd.com>
References: <20260114182055.46029-1-terry.bowman@amd.com>
	<20260114182055.46029-13-terry.bowman@amd.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500009.china.huawei.com (7.191.174.84) To
 dubpeml100005.china.huawei.com (7.214.146.113)

On Wed, 14 Jan 2026 12:20:33 -0600
Terry Bowman <terry.bowman@amd.com> wrote:

> cxl_rch_handle_error_iter() includes a call to device_lock() using a goto
> for multiple return paths. Improve readability and maintainability by
> using the guard() lock variant.
> 
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> Reviewed-by: Dan Williams <dan.j.williams@intel.com>
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> 
> ---
> 
> Changes in v13 -> v14:
> - Add review-by for Jonathan, Dave Jiang, Dan WIlliams, and Bjorn
> - Remove cleanup.h (Jonathan)

I'm confused.  I asked you to add the include (it wasn't there to be
removed!)

> - Reverted comment removal (Bjorn)
> - Move this patch after pci/pcie/aer_cxl_rch.c creation (Bjorn)
> 
> Changes in v12 -> v13:
> - New patch
> ---
>  drivers/pci/pcie/aer_cxl_rch.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/pci/pcie/aer_cxl_rch.c b/drivers/pci/pcie/aer_cxl_rch.c
> index 6b515edb12c1..e471eefec9c4 100644
> --- a/drivers/pci/pcie/aer_cxl_rch.c
> +++ b/drivers/pci/pcie/aer_cxl_rch.c
> @@ -42,11 +42,11 @@ static int cxl_rch_handle_error_iter(struct pci_dev *dev, void *data)
>  	if (!is_cxl_mem_dev(dev) || !cxl_error_is_native(dev))
>  		return 0;
>  
> -	device_lock(&dev->dev);
> +	guard(device)(&dev->dev);
>  
>  	err_handler = dev->driver ? dev->driver->err_handler : NULL;
>  	if (!err_handler)
> -		goto out;
> +		return 0;
>  
>  	if (info->severity == AER_CORRECTABLE) {
>  		if (err_handler->cor_error_detected)
> @@ -57,8 +57,6 @@ static int cxl_rch_handle_error_iter(struct pci_dev *dev, void *data)
>  		else if (info->severity == AER_FATAL)
>  			err_handler->error_detected(dev, pci_channel_io_frozen);
>  	}
> -out:
> -	device_unlock(&dev->dev);
>  	return 0;
>  }
>  


