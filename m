Return-Path: <linux-pci+bounces-40265-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 01FC8C32838
	for <lists+linux-pci@lfdr.de>; Tue, 04 Nov 2025 19:06:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 76D1D4E2E35
	for <lists+linux-pci@lfdr.de>; Tue,  4 Nov 2025 18:06:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72ADC33DED0;
	Tue,  4 Nov 2025 18:06:05 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EFCF2F4A1B;
	Tue,  4 Nov 2025 18:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762279565; cv=none; b=srj0a1CBrA3b9O1SzxjJL/so1pW818p/3yx449G7f4R/lChNDYoYT6Td7DzMoJDxoLAjchnbwfByE+lstQ4IMqOT9Z1z2DzKN/p6Na7r2KMh1qtao+f6FPfaW39liO0FwFYMOvlrSlljxwg4BjY36PF3MypCnC2P2Cx73MK0YBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762279565; c=relaxed/simple;
	bh=JqJE5FHzn/nbKTzmlskd5VoNB415Uny04IyJQPQjECo=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=okBIJ/fZfdmY1zU92QIOv5AqxqGMzc/GjW8q1qhpI9HPFt/eUyqkjWA4inmZEvEJdU7Qzp3knHyvkNUCIJ3bOqezjhC6k6y54OWDMu03No/TKMd4z5e7AxNgotHGzUNgM6La86/hh2bIIDb3U1vZSESlgN6MTbKBj0zVQhgzNVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4d1Gb8624lzJ467F;
	Wed,  5 Nov 2025 02:05:40 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id AFDB61401DC;
	Wed,  5 Nov 2025 02:06:00 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 4 Nov
 2025 18:05:59 +0000
Date: Tue, 4 Nov 2025 18:05:57 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Terry Bowman <terry.bowman@amd.com>
CC: <dave@stgolabs.net>, <dave.jiang@intel.com>, <alison.schofield@intel.com>,
	<dan.j.williams@intel.com>, <bhelgaas@google.com>, <shiju.jose@huawei.com>,
	<ming.li@zohomail.com>, <Smita.KoralahalliChannabasappa@amd.com>,
	<rrichter@amd.com>, <dan.carpenter@linaro.org>,
	<PradeepVineshReddy.Kodamati@amd.com>, <lukas@wunner.de>,
	<Benjamin.Cheatham@amd.com>, <sathyanarayanan.kuppuswamy@linux.intel.com>,
	<linux-cxl@vger.kernel.org>, <alucerop@amd.com>, <ira.weiny@intel.com>,
	<linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>
Subject: Re: [RESEND v13 07/25] CXL/AER: Replace device_lock() in
 cxl_rch_handle_error_iter() with guard() lock
Message-ID: <20251104180557.00002d24@huawei.com>
In-Reply-To: <20251104170305.4163840-8-terry.bowman@amd.com>
References: <20251104170305.4163840-1-terry.bowman@amd.com>
	<20251104170305.4163840-8-terry.bowman@amd.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100011.china.huawei.com (7.191.174.247) To
 dubpeml100005.china.huawei.com (7.214.146.113)

On Tue, 4 Nov 2025 11:02:47 -0600
Terry Bowman <terry.bowman@amd.com> wrote:

> cxl_rch_handle_error_iter() includes a call to device_lock() using a goto
> for multiple return paths. Improve readability and maintainability by
> using the guard() lock variant.
> 
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
I don't think there is any existing use of cleanup.h in here aer.c?
If not you should add

#include <linux/cleanup.h> in appropriate place. 

Other than that LGTM

Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>



> 
> ---
> 
> Changes in v12->v13:
> - New patch
> ---
>  drivers/pci/pcie/aer.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index 0b5ed4722ac3..cbaed65577d9 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -1187,12 +1187,11 @@ static int cxl_rch_handle_error_iter(struct pci_dev *dev, void *data)
>  	if (!is_cxl_mem_dev(dev) || !cxl_error_is_native(dev))
>  		return 0;
>  
> -	/* Protect dev->driver */
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
> @@ -1203,8 +1202,6 @@ static int cxl_rch_handle_error_iter(struct pci_dev *dev, void *data)
>  		else if (info->severity == AER_FATAL)
>  			err_handler->error_detected(dev, pci_channel_io_frozen);
>  	}
> -out:
> -	device_unlock(&dev->dev);
>  	return 0;
>  }
>  


