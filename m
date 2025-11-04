Return-Path: <linux-pci+bounces-40266-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD39AC32871
	for <lists+linux-pci@lfdr.de>; Tue, 04 Nov 2025 19:09:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49A0B46188D
	for <lists+linux-pci@lfdr.de>; Tue,  4 Nov 2025 18:09:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16A6533DEF8;
	Tue,  4 Nov 2025 18:09:07 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECE1733E34A;
	Tue,  4 Nov 2025 18:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762279747; cv=none; b=eIVBvsXGMCdLPZKbdf9Xm3NG0jgflFFYbvYslwDU6MRwr7xJtLvUlVmAswapBbfwp3HsB3Fz3tZkNOoLvOMoEPn8TloMPvwRyWfzlpOtl4EHE1UnOp0KFaRLPqBNwxPia+WSXTKzPu8KUgjy7sAxFA47ph21Bg2WbCK10WFYYHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762279747; c=relaxed/simple;
	bh=tk1Lqs6Mafx9fcLyZado9aJQMJY0tHoiRLzOMObYJFg=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=trj8h8/SwS5iYbMA9QKEzvNSFN9U5C1k7pDkbol1O//TGE8G873JuBeGeZd12mDKq3CXxQwiBvS4T0mynIVXSMVLltHIis5WabkfjUW7+ntOcoHjujLnkHOkTo5WBtcThRJoSAFh7leCU8+1x49ALO4orENmkUAf9wXgDoTnIqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4d1Gfd71yCzJ468g;
	Wed,  5 Nov 2025 02:08:41 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id D2641140278;
	Wed,  5 Nov 2025 02:09:01 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 4 Nov
 2025 18:09:00 +0000
Date: Tue, 4 Nov 2025 18:08:59 +0000
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
Subject: Re: [RESEND v13 09/25] PCI/AER: Report CXL or PCIe bus error type
 in trace logging
Message-ID: <20251104180859.00001e6d@huawei.com>
In-Reply-To: <20251104170305.4163840-10-terry.bowman@amd.com>
References: <20251104170305.4163840-1-terry.bowman@amd.com>
	<20251104170305.4163840-10-terry.bowman@amd.com>
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

On Tue, 4 Nov 2025 11:02:49 -0600
Terry Bowman <terry.bowman@amd.com> wrote:

> The AER service driver and aer_event tracing currently log 'PCIe Bus Type'
> for all errors. Update the driver and aer_event tracing to log 'CXL Bus
> Type' for CXL device errors.
> 
> This requires the AER can identify and distinguish between PCIe errors and
> CXL errors.
> 
> Introduce boolean 'is_cxl' to 'struct aer_err_info'. Add assignment in
> aer_get_device_error_info() and pci_print_aer().
> 
> Update the aer_event trace routine to accept a bus type string parameter.
> 
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> Reviewed-by: Ira Weiny <ira.weiny@intel.com>
> Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> Reviewed-by: Dan Williams <dan.j.williams@intel.com>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> 
Hi Terry,

A couple of things from a fresh look inline.

> ---
> 
> Changes in v12->v13:
> - Remove duplicated aer_err_info inline comments. Is already in the
>   kernel-doc header (Ben)
> 
> Changes in v11->v12:
>  - Change aer_err_info::is_cxl to be bool a bitfield. Update structure
>  padding. (Lukas)
>  - Add kernel-doc for 'struct aer_err_info' (Lukas)
> 
> Changes in v10->v11:
>  - Remove duplicate call to trace_aer_event() (Shiju)
>  - Added Dan William's and Dave Jiang's reviewed-by
> ---
>  drivers/pci/pci.h       | 37 ++++++++++++++++++++++++++++++-------
>  drivers/pci/pcie/aer.c  | 18 ++++++++++++------
>  include/ras/ras_event.h |  9 ++++++---
>  3 files changed, 48 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index d23430e3eea0..446251892bb7 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -701,31 +701,54 @@ static inline bool pci_dev_binding_disallowed(struct pci_dev *dev)
>  
>  #define AER_MAX_MULTI_ERR_DEVICES	5	/* Not likely to have more */
>  
> +/**
> + * struct aer_err_info - AER Error Information
> + * @dev: Devices reporting error
> + * @ratelimit_print: Flag to log or not log the devices' error. 0=NotLog/1=Log
> + * @error_devnum: Number of devices reporting an error
typo error_dev_num

Run kernel-doc script over here to find things like this.

> + * @level: printk level to use in logging
> + * @id: Value from register PCI_ERR_ROOT_ERR_SRC
> + * @severity: AER severity, 0-UNCOR Non-fatal, 1-UNCOR fatal, 2-COR
> + * @root_ratelimit_print: Flag to log or not log the root's error. 0=NotLog/1=Log
> + * @multi_error_valid: If multiple errors are reported
> + * @first_error: First reported error
> + * @is_cxl: Bus type error: 0-PCI Bus error, 1-CXL Bus error
> + * @tlp_header_valid: Indicates if TLP field contains error information
> + * @status: COR/UNCOR error status
> + * @mask: COR/UNCOR mask
> + * @tlp: Transaction packet information
> + */
>  struct aer_err_info {
>  	struct pci_dev *dev[AER_MAX_MULTI_ERR_DEVICES];
>  	int ratelimit_print[AER_MAX_MULTI_ERR_DEVICES];
>  	int error_dev_num;
> -	const char *level;		/* printk level */
> +	const char *level;
>  
>  	unsigned int id:16;
>  
> -	unsigned int severity:2;	/* 0:NONFATAL | 1:FATAL | 2:COR */
> -	unsigned int root_ratelimit_print:1;	/* 0=skip, 1=print */
> +	unsigned int severity:2;
> +	unsigned int root_ratelimit_print:1;
>  	unsigned int __pad1:4;
>  	unsigned int multi_error_valid:1;
>  
>  	unsigned int first_error:5;
> -	unsigned int __pad2:2;
> +	unsigned int __pad2:1;
> +	bool is_cxl:1;
Stick to unsigned int for the bit field just for consistency.

>  	unsigned int tlp_header_valid:1;
>  
> -	unsigned int status;		/* COR/UNCOR Error Status */
> -	unsigned int mask;		/* COR/UNCOR Error Mask */
> -	struct pcie_tlp_log tlp;	/* TLP Header */
> +	unsigned int status;
> +	unsigned int mask;
> +	struct pcie_tlp_log tlp;
>  };

