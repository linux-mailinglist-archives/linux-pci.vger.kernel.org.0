Return-Path: <linux-pci+bounces-44846-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 70803D21178
	for <lists+linux-pci@lfdr.de>; Wed, 14 Jan 2026 20:49:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 803DA3019A59
	for <lists+linux-pci@lfdr.de>; Wed, 14 Jan 2026 19:49:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC2FF350A09;
	Wed, 14 Jan 2026 19:48:57 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DCE7350282;
	Wed, 14 Jan 2026 19:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768420137; cv=none; b=jha57MpbzVlxzOZMRlEtCo3iu24ngqG0xR1T6DL8mfZDtZFswrH4IgPS/h4swBAaeAYuTkMq1CWd/n8n4wppJ2pojiqOxtlzB4LN+MqTMVzmksaOhfcEA6AIqI7TOzECt3VQckZzUiq145gJXEsZfqTg3JeXvsM5Hi1QGRzKCjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768420137; c=relaxed/simple;
	bh=ycCrpYZH2yKl5gggnnKBPQba3+hCheX6hNvUyV935Z8=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NPdPGupv0+lvn7rgeK/hhqAeS/i6OlfcGaBRnyouoaUg3g6jSCrsncqvRjPoGSSAQC5FaigrrrCismxv0qlvvoJn27flTGX0xW4Da2sQRIVaMLZy0RScRD52nKrWtzLzoxpNSA3I3tA6g/jfL5SsBFr9E4ao+DqwGdEViev/aWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.83])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4drxWB3ZnLzJ4674;
	Thu, 15 Jan 2026 03:48:38 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id 9B94740569;
	Thu, 15 Jan 2026 03:48:53 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Wed, 14 Jan
 2026 19:48:52 +0000
Date: Wed, 14 Jan 2026 19:48:51 +0000
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
Subject: Re: [PATCH v14 15/34] PCI/AER: Update struct aer_err_info with
 kernel-doc formatting
Message-ID: <20260114194851.000047bc@huawei.com>
In-Reply-To: <20260114182055.46029-16-terry.bowman@amd.com>
References: <20260114182055.46029-1-terry.bowman@amd.com>
	<20260114182055.46029-16-terry.bowman@amd.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100010.china.huawei.com (7.191.174.197) To
 dubpeml100005.china.huawei.com (7.214.146.113)

On Wed, 14 Jan 2026 12:20:36 -0600
Terry Bowman <terry.bowman@amd.com> wrote:

> Update the existing 'struct aer_err_info' definition to use kernel-doc
> formatting. Remove the inline comments to reduce noise and do not introduce
> functional changes. This will improve readability and maintainability.
> 
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Hi Terry.

I didn't check but I think kernel-doc script will complain
about partial docs.  Other than that possibly needing fixing with
a trivial entry for __pad1

Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>


> 
> ---
> 
> Changes in v13->v14:
> - New commit
> ---
>  drivers/pci/pci.h | 29 +++++++++++++++++++++++------
>  1 file changed, 23 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index 41ec38e82c08..dbc547db208a 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -724,16 +724,33 @@ static inline bool pci_dev_binding_disallowed(struct pci_dev *dev)
>  
>  #define AER_MAX_MULTI_ERR_DEVICES	5	/* Not likely to have more */
>  
> +/**
> + * struct aer_err_info - AER Error Information
> + * @dev: Devices reporting error
> + * @ratelimit_print: Flag to log or not log the devices' error. 0=NotLog/1=Log
> + * @error_dev_num: Number of devices reporting an error
> + * @level: printk level to use in logging
> + * @id: Value from register PCI_ERR_ROOT_ERR_SRC
> + * @severity: AER severity, 0-UNCOR Non-fatal, 1-UNCOR fatal, 2-COR
> + * @root_ratelimit_print: Flag to log or not log the root's error. 0=NotLog/1=Log

The kernel-doc scripts are annoying fussy. Do they not moan about __pad1
being undocumented? 

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
> @@ -742,9 +759,9 @@ struct aer_err_info {
>  	unsigned int is_cxl:1;
>  	unsigned int tlp_header_valid:1;
>  
> -	unsigned int status;		/* COR/UNCOR Error Status */
> -	unsigned int mask;		/* COR/UNCOR Error Mask */
> -	struct pcie_tlp_log tlp;	/* TLP Header */
> +	unsigned int status;
> +	unsigned int mask;
> +	struct pcie_tlp_log tlp;
>  };
>  
>  int aer_get_device_error_info(struct aer_err_info *info, int i);


