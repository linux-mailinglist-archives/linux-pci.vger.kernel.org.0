Return-Path: <linux-pci+bounces-27088-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D8F9AA6CB6
	for <lists+linux-pci@lfdr.de>; Fri,  2 May 2025 10:43:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1FBCA1BC0756
	for <lists+linux-pci@lfdr.de>; Fri,  2 May 2025 08:43:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF4A322ACE7;
	Fri,  2 May 2025 08:43:20 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BBBF8828;
	Fri,  2 May 2025 08:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746175400; cv=none; b=EZJZI9s8KS+27SaBZDyzJvnRb5f50uOf5gS5zt+YEkJxYPrLoIq1nUzZhgyPaPP9yqwHDs7YuKleI1F1tWlt/bMWk4VXWKUFK8bvVd/qqVRRZpSdaOgnxu2bwYUwttx16wsls3F1mRKXeC1frddeTaBosPFyV9oGcp8xUBUmC4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746175400; c=relaxed/simple;
	bh=x2aq1XKqHbH6eCxQRGcIKB3OrIuNOfWz2k3HWH6042s=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LWUJDpIJyBZeYDKm8iLpY8nHDql6wFFHmfone03xyNFZVU/19dACXZoEee9ye1teORRQYGQFHHklY7jSMfKhKd43QwKzpji9eXHNjOCdEzbFgpdPeUXtU1TwmCpI1Qs7Nuw9GmkrJYiF9JN2t2Dc/M6Zct+IqaPQXSkoOofkRtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4ZpkpJ5b0Nz6K5rg;
	Fri,  2 May 2025 16:38:16 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id A06D41402FE;
	Fri,  2 May 2025 16:43:15 +0800 (CST)
Received: from localhost (10.48.156.249) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 2 May
 2025 10:43:14 +0200
Date: Fri, 2 May 2025 09:43:13 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Erick Karanja <karanja99erick@gmail.com>
CC: <manivannan.sadhasivam@linaro.org>, <kw@linux.com>, <kishon@kernel.org>,
	<bhelgaas@google.com>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <julia.lawall@inria.fr>
Subject: Re: [PATCH 2/2] PCI: endpoint: Use scoped_guard for manual mutex
 lock/unlock
Message-ID: <20250502094313.000055d1@huawei.com>
In-Reply-To: <88bf352aab2b3ba68b2381b23706513e4cdea155.1746114596.git.karanja99erick@gmail.com>
References: <cover.1746114596.git.karanja99erick@gmail.com>
	<88bf352aab2b3ba68b2381b23706513e4cdea155.1746114596.git.karanja99erick@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500004.china.huawei.com (7.191.163.9) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Thu,  1 May 2025 18:56:12 +0300
Erick Karanja <karanja99erick@gmail.com> wrote:

> This refactor replaces manual mutex lock/unlock with scoped_guard()
> in places where early exits use goto. Using scoped_guard()
> avoids error-prone unlock paths and simplifies control flow.
> 
> Signed-off-by: Erick Karanja <karanja99erick@gmail.com>
> ---
>  drivers/pci/endpoint/pci-epc-core.c | 53 +++++++++++++----------------
>  1 file changed, 24 insertions(+), 29 deletions(-)
> 
> diff --git a/drivers/pci/endpoint/pci-epc-core.c b/drivers/pci/endpoint/pci-epc-core.c
> index beabea00af91..3f3ff36fa8ab 100644
> --- a/drivers/pci/endpoint/pci-epc-core.c
> +++ b/drivers/pci/endpoint/pci-epc-core.c
> @@ -709,7 +709,6 @@ int pci_epc_add_epf(struct pci_epc *epc, struct pci_epf *epf,
>  {
>  	struct list_head *list;
>  	u32 func_no;
> -	int ret = 0;
>  
>  	if (IS_ERR_OR_NULL(epc) || epf->is_vf)
>  		return -EINVAL;
> @@ -720,36 +719,32 @@ int pci_epc_add_epf(struct pci_epc *epc, struct pci_epf *epf,
>  	if (type == SECONDARY_INTERFACE && epf->sec_epc)
>  		return -EBUSY;
>  
> -	mutex_lock(&epc->list_lock);
> -	func_no = find_first_zero_bit(&epc->function_num_map,
> -				      BITS_PER_LONG);
> -	if (func_no >= BITS_PER_LONG) {
> -		ret = -EINVAL;
> -		goto ret;
> -	}
> -
> -	if (func_no > epc->max_functions - 1) {
> -		dev_err(&epc->dev, "Exceeding max supported Function Number\n");
> -		ret = -EINVAL;
> -		goto ret;
> +	scoped_guard(mutex, &epc->list_lock) {
This one is better, but using
	guard(mutex)(&epc->list_lock);
Is going to make for an easier to read patch and lower indent etc.

Unless there is some subsystem related reason that scoped_guard() is
preferred then I'd go that way.

> +		func_no = find_first_zero_bit(&epc->function_num_map,
> +					      BITS_PER_LONG);
> +		if (func_no >= BITS_PER_LONG)
> +			return -EINVAL;
> +
> +		if (func_no > epc->max_functions - 1) {
> +			dev_err(&epc->dev, "Exceeding max supported Function Number\n");
> +			return -EINVAL;
> +		}
> +
> +		set_bit(func_no, &epc->function_num_map);
> +		if (type == PRIMARY_INTERFACE) {
> +			epf->func_no = func_no;
> +			epf->epc = epc;
> +			list = &epf->list;
> +		} else {
> +			epf->sec_epc_func_no = func_no;
> +			epf->sec_epc = epc;
> +			list = &epf->sec_epc_list;
> +		}
> +
> +		list_add_tail(list, &epc->pci_epf);
>  	}
>  
> -	set_bit(func_no, &epc->function_num_map);
> -	if (type == PRIMARY_INTERFACE) {
> -		epf->func_no = func_no;
> -		epf->epc = epc;
> -		list = &epf->list;
> -	} else {
> -		epf->sec_epc_func_no = func_no;
> -		epf->sec_epc = epc;
> -		list = &epf->sec_epc_list;
> -	}
> -
> -	list_add_tail(list, &epc->pci_epf);
> -ret:
> -	mutex_unlock(&epc->list_lock);
> -
> -	return ret;
> +	return 0;
>  }
>  EXPORT_SYMBOL_GPL(pci_epc_add_epf);
>  


