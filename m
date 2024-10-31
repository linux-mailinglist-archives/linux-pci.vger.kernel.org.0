Return-Path: <linux-pci+bounces-15750-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C4D929B844D
	for <lists+linux-pci@lfdr.de>; Thu, 31 Oct 2024 21:25:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 844E8284834
	for <lists+linux-pci@lfdr.de>; Thu, 31 Oct 2024 20:25:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F3A41CB521;
	Thu, 31 Oct 2024 20:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gHRPRDWL"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D93C1A2562;
	Thu, 31 Oct 2024 20:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730406331; cv=none; b=g/Cna2C+hgcjzn4iHA3QQGSKd2iT90sTpRlm/woBD7ylOkwtg0XLV3NWP9rJO7bc9FmvFvkqJIeopfHMIcCc4HMgtORhBm7B9bb/VxK1UeFl7p6qD6tty8B1TLNPWBGo0itWZtvj4GQhlyQYhBt1A+kNZIswxO3jFBad4AA4ang=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730406331; c=relaxed/simple;
	bh=SXxJLnwmliE4sTl2okXJbGuvdeDDxukFYNzonEm748E=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lok3AgLYT6QVn0Iq3IOcXYeveMAxMLJ3ff5ol6ocr5z/uTwcYVt7+1z9ksol/vk6/7FZ/Fm577X2uQFjCm0H7I8X1cNrHFEhmvdTpLurI4Bm+jRsuMYAGJgK55E53JG560TyBU9ZBNscEute3Edesf7P8TN1+eZRoF8DfKs5CuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gHRPRDWL; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-7eda47b7343so983609a12.0;
        Thu, 31 Oct 2024 13:25:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730406328; x=1731011128; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JP9sRmcVEjno6np3uwfTiX/MWx/3bhU6Ar7kOBUlziU=;
        b=gHRPRDWLWIi+6ZNr7zetxpitFexQpsD0OEYniV8N60NizWhvTbSfwDayANIw54aSb8
         ALkDlhy+C/J+qzseVXR9q+oVfhQlbky3BI/k3ZsISALsUHuHMoidZqqEVpM74yaXp57X
         /WA0Zg1S31SnlEzkCNmVU3AGNhAQbFUnNtQMsvcImSdaET63wPqus65mL4uOGXvVocKd
         +MyerNgiNb+RVo+KG5AmFBTFjJ85FjEzuhC067zFN+5vjq7EDVbi39TSAEiR5zxuz3YI
         io2YPUhRlDUtO7dY8udr5W1P5Va4rT2duMX+od0LhgbkGATHPNkUnJh5gNNX1BWQfvyE
         OJzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730406328; x=1731011128;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JP9sRmcVEjno6np3uwfTiX/MWx/3bhU6Ar7kOBUlziU=;
        b=kksiv1I0wrKwr8CHKdbg+dMvR2yZ5QBKGvVketRfMnwUUndOz0cEuj+rG2h/IVdA0N
         MFt65RbeCSUtyXBOrL5B67+3ALNTOCtXLzJ7u+Hnvy8xzYcdwkt6j3CpSHO/46CupjLI
         T7D4uVAZMoxksV9QTr+tX+LG2iMdlWH9bVL4AoP4IFAYK+sx8CTh07UgxSAFyD7Zw//h
         QfkAW9GI11AeCb86IkEp2FslbUFPQUWwh1GInggUYaALxhicPWkXPviU9mvGSASoOpuS
         pLrVD9HaYki0V1jVJuYMaNKYo2L81u3OYGROLWvNeLCJX19HeS5ubkFmajp99S1POVVx
         aPlA==
X-Forwarded-Encrypted: i=1; AJvYcCVo2mbTKywVh41+BFe/YuPihXYfY4JhnFSlA6gZlDBkMWCvc23DqM7Rr/XC8EXv/RHdcclcTuxLZFmE@vger.kernel.org, AJvYcCWQ11fJs8+3f6vMSKePEcGwE94mBMQpdfRSFGJcQQvBwS2Cq8CpSvk88QRD/WJw0OSuikS0G1pD1l1ICYXS@vger.kernel.org, AJvYcCXzJ+q2vvuWOAYhjbasG6QmKCTqng1DyWlYniQeDMvQ85AVZZLsQlfN9HEIyz08tYrmxn4eGpH6AOE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDc9uOE65TNnGGAjIenEmpGPMhujQoL8WOSygBE2SQzp+GJgDH
	sBvLNXGVniLO5ShXUis0hMfy2YKxoBoD0P40itBxvrQCMywazz5buqiMcQ==
X-Google-Smtp-Source: AGHT+IG2yf4+3tcnyIFunU30HkVWTtJjBqO29GTyQa5oE9K5gI36udLNH0NyRtVasXUOkjqBtZvKBg==
X-Received: by 2002:a17:903:230d:b0:20b:8776:4902 with SMTP id d9443c01a7336-210c6c34577mr272895695ad.38.1730406328157;
        Thu, 31 Oct 2024 13:25:28 -0700 (PDT)
Received: from fan ([2601:646:8f03:9fee:1a14:7759:606e:c90])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211057bfd09sm12324315ad.183.2024.10.31.13.25.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2024 13:25:27 -0700 (PDT)
From: Fan Ni <nifan.cxl@gmail.com>
X-Google-Original-From: Fan Ni <fan.ni@samsung.com>
Date: Thu, 31 Oct 2024 13:25:24 -0700
To: Terry Bowman <terry.bowman@amd.com>
Cc: ming4.li@intel.com, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	dave@stgolabs.net, jonathan.cameron@huawei.com,
	dave.jiang@intel.com, alison.schofield@intel.com,
	vishal.l.verma@intel.com, dan.j.williams@intel.com,
	bhelgaas@google.com, mahesh@linux.ibm.com, ira.weiny@intel.com,
	oohall@gmail.com, Benjamin.Cheatham@amd.com, rrichter@amd.com,
	nathan.fontenot@amd.com, Smita.KoralahalliChannabasappa@amd.com
Subject: Re: [PATCH v2 02/14] PCI/AER: Rename AER driver's interfaces to also
 indicate CXL PCIe port support
Message-ID: <ZyPntFwZIxCv3hXr@fan>
References: <20241025210305.27499-1-terry.bowman@amd.com>
 <20241025210305.27499-3-terry.bowman@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241025210305.27499-3-terry.bowman@amd.com>

On Fri, Oct 25, 2024 at 04:02:53PM -0500, Terry Bowman wrote:
> The AER service driver already includes support for CXL restricted host
> (RCH) downstream port error handling. The current implementation is based
> on CXL1.1 using a root complex event collector.
> 
> Rename function interfaces and parameters where necessary to include
> virtual hierarchy (VH) mode CXL PCIe port error handling alongside the RCH
> handling.[1] The CXL PCIe port error handling will be added in a future
> patch.
> 
> Limit changes to renaming variable and function names. No functional
> changes are added.
> 
> [1] CXL 3.1 Spec, 9.12.2 CXL Virtual Hierarchy
> 
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>

Reviewed-by: Fan Ni <fan.ni@samsung.com>

> ---
>  drivers/pci/pcie/aer.c | 28 ++++++++++++++--------------
>  1 file changed, 14 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index 13b8586924ea..fe6edf26279e 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -1029,7 +1029,7 @@ static int cxl_rch_handle_error_iter(struct pci_dev *dev, void *data)
>  	return 0;
>  }
>  
> -static void cxl_rch_handle_error(struct pci_dev *dev, struct aer_err_info *info)
> +static void cxl_handle_error(struct pci_dev *dev, struct aer_err_info *info)
>  {
>  	/*
>  	 * Internal errors of an RCEC indicate an AER error in an
> @@ -1052,30 +1052,30 @@ static int handles_cxl_error_iter(struct pci_dev *dev, void *data)
>  	return *handles_cxl;
>  }
>  
> -static bool handles_cxl_errors(struct pci_dev *rcec)
> +static bool handles_cxl_errors(struct pci_dev *dev)
>  {
>  	bool handles_cxl = false;
>  
> -	if (pci_pcie_type(rcec) == PCI_EXP_TYPE_RC_EC &&
> -	    pcie_aer_is_native(rcec))
> -		pcie_walk_rcec(rcec, handles_cxl_error_iter, &handles_cxl);
> +	if (pci_pcie_type(dev) == PCI_EXP_TYPE_RC_EC &&
> +	    pcie_aer_is_native(dev))
> +		pcie_walk_rcec(dev, handles_cxl_error_iter, &handles_cxl);
>  
>  	return handles_cxl;
>  }
>  
> -static void cxl_rch_enable_rcec(struct pci_dev *rcec)
> +static void cxl_enable_internal_errors(struct pci_dev *dev)
>  {
> -	if (!handles_cxl_errors(rcec))
> +	if (!handles_cxl_errors(dev))
>  		return;
>  
> -	pci_aer_unmask_internal_errors(rcec);
> -	pci_info(rcec, "CXL: Internal errors unmasked");
> +	pci_aer_unmask_internal_errors(dev);
> +	pci_info(dev, "CXL: Internal errors unmasked");
>  }
>  
>  #else
> -static inline void cxl_rch_enable_rcec(struct pci_dev *dev) { }
> -static inline void cxl_rch_handle_error(struct pci_dev *dev,
> -					struct aer_err_info *info) { }
> +static inline void cxl_enable_internal_errors(struct pci_dev *dev) { }
> +static inline void cxl_handle_error(struct pci_dev *dev,
> +				    struct aer_err_info *info) { }
>  #endif
>  
>  /**
> @@ -1113,7 +1113,7 @@ static void pci_aer_handle_error(struct pci_dev *dev, struct aer_err_info *info)
>  
>  static void handle_error_source(struct pci_dev *dev, struct aer_err_info *info)
>  {
> -	cxl_rch_handle_error(dev, info);
> +	cxl_handle_error(dev, info);
>  	pci_aer_handle_error(dev, info);
>  	pci_dev_put(dev);
>  }
> @@ -1491,7 +1491,7 @@ static int aer_probe(struct pcie_device *dev)
>  		return status;
>  	}
>  
> -	cxl_rch_enable_rcec(port);
> +	cxl_enable_internal_errors(port);
>  	aer_enable_rootport(rpc);
>  	pci_info(port, "enabled with IRQ %d\n", dev->irq);
>  	return 0;
> -- 
> 2.34.1
> 

-- 
Fan Ni

