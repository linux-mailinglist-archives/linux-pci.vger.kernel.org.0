Return-Path: <linux-pci+bounces-28165-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61747ABE6E2
	for <lists+linux-pci@lfdr.de>; Wed, 21 May 2025 00:26:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 132154C6E66
	for <lists+linux-pci@lfdr.de>; Tue, 20 May 2025 22:27:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80D2825DB0A;
	Tue, 20 May 2025 22:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HiFzR3vU"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E9B325B66D;
	Tue, 20 May 2025 22:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747780015; cv=none; b=EqpXueeRucUnT2X7D8pkIDQtf9Ua3j8JMcJFrfS7+/rbKiSAg8rUKgcadx2/crlJ8MqLBPBYPcDTZt2Wxwim96H3rupzGZ+vrvS85ZLNOOg02UmsCuC60MnxhpmDe3+bGkSSWvmiTZS2aAKFGHmR4ElCl8au8tZmpfbTNVqNt/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747780015; c=relaxed/simple;
	bh=8tFeW05/7XCVuFCJ6OwQew4Gt09wQRdhiAtl6NZm4Vs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fc4gxR6/vreEfY90m1BdWp+mnjdxTCZxJFHuXdxamzZab/80fD5xn6EZtypfGxmWwN8uqqVkV3QXzKfD95OmCI0NUNOKE26SsBj/i6X5fHPr/E2hJbo34BzghTS60qZWupSOueVlwfLBntf9FPXNjDbDi8J2Lrbv59vsgYogUIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HiFzR3vU; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747780013; x=1779316013;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=8tFeW05/7XCVuFCJ6OwQew4Gt09wQRdhiAtl6NZm4Vs=;
  b=HiFzR3vUwIgnf9JfPc3SKFcdPsoJ10O/hMLq2ZtG+C/6yida05k/pk+J
   9FqILe1JB5SfjrtHP8hIx/F1MPI6iMLvMygaJo85Up9SokFNG/A6dVH/U
   GD69gWmLbkU/wlc80yg4gtRyeg7WSBL1Czw9h/NhObMPj+gu6HLnFWHS2
   s8EbvLaUfifTU5xXNXmKsbW0B/NhK6dUTexrp6SOmwwIJQvwyKCzJway6
   fTtg69lOhAOEc4l7aySWehsyY4mmhn6FU/59JX9+WWUZcC6AWEdTCdMn4
   4iT/vDJXXyOzeDXRp/c+UcTWD9LzVhIJxfraQcBgMhaPNS4EinVVupfH/
   A==;
X-CSE-ConnectionGUID: 5nyMtIZBQZy7b7X/CdusMw==
X-CSE-MsgGUID: 8qz85ansRJKn1HQaEnB8tQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11439"; a="49835301"
X-IronPort-AV: E=Sophos;i="6.15,303,1739865600"; 
   d="scan'208";a="49835301"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2025 15:26:52 -0700
X-CSE-ConnectionGUID: DEx49EBDSU2K0eC3jg1jlw==
X-CSE-MsgGUID: ZKAIxYD7Rsq5IwWloIgvsQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,303,1739865600"; 
   d="scan'208";a="144786555"
Received: from iweiny-desk3.amr.corp.intel.com (HELO [10.124.222.89]) ([10.124.222.89])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2025 15:26:50 -0700
Message-ID: <bacf754b-7807-4058-be4b-6b5c5a17a4d6@linux.intel.com>
Date: Tue, 20 May 2025 15:26:49 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 03/17] PCI/AER: Factor COR/UNCOR error handling out
 from aer_isr_one_error()
To: Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org
Cc: Jon Pan-Doh <pandoh@google.com>,
 Karolina Stolarek <karolina.stolarek@oracle.com>,
 Weinan Liu <wnliu@google.com>, Martin Petersen <martin.petersen@oracle.com>,
 Ben Fuller <ben.fuller@oracle.com>, Drew Walton <drewwalton@microsoft.com>,
 Anil Agrawal <anilagrawal@meta.com>, Tony Luck <tony.luck@intel.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Lukas Wunner <lukas@wunner.de>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Sargun Dhillon <sargun@meta.com>, "Paul E . McKenney" <paulmck@kernel.org>,
 Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Oliver O'Halloran <oohall@gmail.com>, Kai-Heng Feng <kaihengf@nvidia.com>,
 Keith Busch <kbusch@kernel.org>, Robert Richter <rrichter@amd.com>,
 Terry Bowman <terry.bowman@amd.com>, Shiju Jose <shiju.jose@huawei.com>,
 Dave Jiang <dave.jiang@intel.com>, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, Bjorn Helgaas <bhelgaas@google.com>
References: <20250520215047.1350603-1-helgaas@kernel.org>
 <20250520215047.1350603-4-helgaas@kernel.org>
Content-Language: en-US
From: Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20250520215047.1350603-4-helgaas@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 5/20/25 2:50 PM, Bjorn Helgaas wrote:
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
> ---

Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

>   drivers/pci/pcie/aer.c | 36 +++++++++++++++++++++++-------------
>   1 file changed, 23 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index a1cf8c7ef628..568229288ca3 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -1273,17 +1273,32 @@ static inline void aer_process_err_devices(struct aer_err_info *e_info)
>   }
>   
>   /**
> - * aer_isr_one_error - consume an error detected by Root Port
> - * @rpc: pointer to the Root Port which holds an error
> + * aer_isr_one_error_type - consume a Correctable or Uncorrectable Error
/s/cosume/Consume/
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
>    * @e_src: pointer to an error source
>    */
> -static void aer_isr_one_error(struct aer_rpc *rpc,
> +static void aer_isr_one_error(struct pci_dev *root,
>   		struct aer_err_source *e_src)
>   {
> -	struct pci_dev *pdev = rpc->rpd;
>   	struct aer_err_info e_info;
>   
> -	pci_rootport_aer_stats_incr(pdev, e_src);
> +	pci_rootport_aer_stats_incr(root, e_src);
>   
>   	/*
>   	 * There is a possibility that both correctable error and
> @@ -1297,10 +1312,8 @@ static void aer_isr_one_error(struct aer_rpc *rpc,
>   			e_info.multi_error_valid = 1;
>   		else
>   			e_info.multi_error_valid = 0;
> -		aer_print_port_info(pdev, &e_info);
>   
> -		if (find_source_device(pdev, &e_info))
> -			aer_process_err_devices(&e_info);
> +		aer_isr_one_error_type(root, &e_info);
>   	}
>   
>   	if (e_src->status & PCI_ERR_ROOT_UNCOR_RCV) {
> @@ -1316,10 +1329,7 @@ static void aer_isr_one_error(struct aer_rpc *rpc,
>   		else
>   			e_info.multi_error_valid = 0;
>   
> -		aer_print_port_info(pdev, &e_info);
> -
> -		if (find_source_device(pdev, &e_info))
> -			aer_process_err_devices(&e_info);
> +		aer_isr_one_error_type(root, &e_info);
>   	}
>   }
>   
> @@ -1340,7 +1350,7 @@ static irqreturn_t aer_isr(int irq, void *context)
>   		return IRQ_NONE;
>   
>   	while (kfifo_get(&rpc->aer_fifo, &e_src))
> -		aer_isr_one_error(rpc, &e_src);
> +		aer_isr_one_error(rpc->rpd, &e_src);
>   	return IRQ_HANDLED;
>   }
>   

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer


