Return-Path: <linux-pci+bounces-28177-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E5866ABEF4F
	for <lists+linux-pci@lfdr.de>; Wed, 21 May 2025 11:15:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 350661BC0042
	for <lists+linux-pci@lfdr.de>; Wed, 21 May 2025 09:15:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48EF121CA04;
	Wed, 21 May 2025 09:15:36 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91D7735893;
	Wed, 21 May 2025 09:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747818936; cv=none; b=sBt2hNH5IGNbhaKEhViz1LLWvPPZIhtyhtkkkLHsHXFEDz6A+uieEc0QIEmuY7FKPSjbOQ3v/UhEE7NIsfVvX5x/OrmkKxq8YOtUP9nbLSR1B4jiL18RwERFxsdv667vGdcQaP4kJpNiunbGyO1EuOBcq8sD3NVsAwvtK8Arrl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747818936; c=relaxed/simple;
	bh=t1yobnBcqQaDcoFbIHLQ8LdSWAixACdgskTO/gNDpp0=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DZv2YGJGVgoxXTOkFqtnfLQZWQz7gUyTYBsLYfdCChYlVMrszJpexrXi+K8vZy0vS9h4ETE86xVVxwOrPp5ItZUCWu+G78jLJjx3mD2+DpJy7hO9H5ZW+pheFdbGLLYRxd79f2uptcAn1FHq9cFueO97Dr070d5fcbDf0E+NWb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4b2Qfq4j1Bz6H7Ps;
	Wed, 21 May 2025 17:12:19 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 88B57140519;
	Wed, 21 May 2025 17:15:30 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 21 May
 2025 11:15:29 +0200
Date: Wed, 21 May 2025 10:15:27 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Bjorn Helgaas <helgaas@kernel.org>
CC: <linux-pci@vger.kernel.org>, Jon Pan-Doh <pandoh@google.com>, "Karolina
 Stolarek" <karolina.stolarek@oracle.com>, Weinan Liu <wnliu@google.com>,
	Martin Petersen <martin.petersen@oracle.com>, Ben Fuller
	<ben.fuller@oracle.com>, Drew Walton <drewwalton@microsoft.com>, "Anil
 Agrawal" <anilagrawal@meta.com>, Tony Luck <tony.luck@intel.com>, Ilpo
 =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>, Sathyanarayanan
 Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>, Lukas Wunner
	<lukas@wunner.de>, Sargun Dhillon <sargun@meta.com>, "Paul E . McKenney"
	<paulmck@kernel.org>, Mahesh J Salgaonkar <mahesh@linux.ibm.com>, Oliver
 O'Halloran <oohall@gmail.com>, Kai-Heng Feng <kaihengf@nvidia.com>, Keith
 Busch <kbusch@kernel.org>, Robert Richter <rrichter@amd.com>, "Terry Bowman"
	<terry.bowman@amd.com>, Shiju Jose <shiju.jose@huawei.com>, "Dave Jiang"
	<dave.jiang@intel.com>, <linux-kernel@vger.kernel.org>,
	<linuxppc-dev@lists.ozlabs.org>, Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v7 03/17] PCI/AER: Factor COR/UNCOR error handling out
 from aer_isr_one_error()
Message-ID: <20250521101527.000026b4@huawei.com>
In-Reply-To: <20250520215047.1350603-4-helgaas@kernel.org>
References: <20250520215047.1350603-1-helgaas@kernel.org>
	<20250520215047.1350603-4-helgaas@kernel.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
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

On Tue, 20 May 2025 16:50:20 -0500
Bjorn Helgaas <helgaas@kernel.org> wrote:

> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> aer_isr_one_error() duplicates the Error Source ID logging and AER error
> processing for Correctable Errors and Uncorrectable Errors.  Factor out the
> duplicated code to aer_isr_one_error_type().
> 
> aer_isr_one_error() doesn't need the struct aer_rpc pointer, so pass it the
> Root Port or RCEC pci_dev pointer instead.
> 
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
One passing comment inside (on neighbouring code)
Otherwise it is a sensible bit of cleanup.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  drivers/pci/pcie/aer.c | 36 +++++++++++++++++++++++-------------
>  1 file changed, 23 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index a1cf8c7ef628..568229288ca3 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -1273,17 +1273,32 @@ static inline void aer_process_err_devices(struct aer_err_info *e_info)
>  }
>  
>  /**
> - * aer_isr_one_error - consume an error detected by Root Port
> - * @rpc: pointer to the Root Port which holds an error
> + * aer_isr_one_error_type - consume a Correctable or Uncorrectable Error
> + *			    detected by Root Port or RCEC
> + * @root: pointer to Root Port or RCEC that signaled AER interrupt
> + * @info: pointer to AER error info
> + */
> +static void aer_isr_one_error_type(struct pci_dev *root,
> +				   struct aer_err_info *info)
> +{
> +	aer_print_port_info(root, info);
> +
> +	if (find_source_device(root, info))
> +		aer_process_err_devices(info);
> +}
> +
> +/**
> + * aer_isr_one_error - consume error(s) signaled by an AER interrupt from
> + *		       Root Port or RCEC
> + * @root: pointer to Root Port or RCEC that signaled AER interrupt
>   * @e_src: pointer to an error source
>   */
> -static void aer_isr_one_error(struct aer_rpc *rpc,
> +static void aer_isr_one_error(struct pci_dev *root,
>  		struct aer_err_source *e_src)
>  {
> -	struct pci_dev *pdev = rpc->rpd;
>  	struct aer_err_info e_info;

I wonder if, in the interests of readability this should be
initialized.  That would allows some conditions to set
only the valid case (ones) rather than explicit zeros.
 
>  
> -	pci_rootport_aer_stats_incr(pdev, e_src);
> +	pci_rootport_aer_stats_incr(root, e_src);
>  
>  	/*
>  	 * There is a possibility that both correctable error and
> @@ -1297,10 +1312,8 @@ static void aer_isr_one_error(struct aer_rpc *rpc,
>  			e_info.multi_error_valid = 1;
>  		else
>  			e_info.multi_error_valid = 0;
> -		aer_print_port_info(pdev, &e_info);
>  
> -		if (find_source_device(pdev, &e_info))
> -			aer_process_err_devices(&e_info);
> +		aer_isr_one_error_type(root, &e_info);
>  	}
>  
>  	if (e_src->status & PCI_ERR_ROOT_UNCOR_RCV) {
> @@ -1316,10 +1329,7 @@ static void aer_isr_one_error(struct aer_rpc *rpc,
>  		else
>  			e_info.multi_error_valid = 0;
>  
> -		aer_print_port_info(pdev, &e_info);
> -
> -		if (find_source_device(pdev, &e_info))
> -			aer_process_err_devices(&e_info);
> +		aer_isr_one_error_type(root, &e_info);
>  	}
>  }
>  
> @@ -1340,7 +1350,7 @@ static irqreturn_t aer_isr(int irq, void *context)
>  		return IRQ_NONE;
>  
>  	while (kfifo_get(&rpc->aer_fifo, &e_src))
> -		aer_isr_one_error(rpc, &e_src);
> +		aer_isr_one_error(rpc->rpd, &e_src);
>  	return IRQ_HANDLED;
>  }
>  


