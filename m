Return-Path: <linux-pci+bounces-15749-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C0EF19B844B
	for <lists+linux-pci@lfdr.de>; Thu, 31 Oct 2024 21:24:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80B3A281E92
	for <lists+linux-pci@lfdr.de>; Thu, 31 Oct 2024 20:24:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 101471CBEA1;
	Thu, 31 Oct 2024 20:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BJyHgGYo"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 196CF1A2562;
	Thu, 31 Oct 2024 20:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730406278; cv=none; b=g1DCIi2TqZGqr0w9u2+7MJNLS1sd95boGfws9U+qZbTX9JMhJ0kDBTvQ503qvL/NsQ8/2i8Kt1C9PTkga4Gy1lpemIjI73kXvkto/xmaO1h/GcVtOHsOgWm5OzpSNMBsV17fWAJyFvixb1tPUN5GnAFES9phzfBmzk/H39f8aJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730406278; c=relaxed/simple;
	bh=wrFSEeZQV9brU3Dbe6yQ2USyHr8bTrVEo03V9uBxbN8=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XVRObGLKhhRxfJhGuSuUv6NH1uT7S6ndzC3K58H5AKdUR+v3X+pL6b326PzEi52AKgDVcWjyU9kXU5WqcVxNhiOcuHiC6FcpLkuIQa3aHhpESoGCeF5GwRHTb1r3N7T6FjmhBdOz/PFdcpOME5Uk5Hhjc2EDDO5mHz6hzpgl5zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BJyHgGYo; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-20cdbe608b3so14460205ad.1;
        Thu, 31 Oct 2024 13:24:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730406275; x=1731011075; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bvul/ButslL/SfFParCrQ24MY7VsrtOizUyLtg7jpC0=;
        b=BJyHgGYovkjJXTVC8qs95XGyYadvHragMpecxTkiuknvQt7DXYpNwCrOv1hv2M0FRV
         2thAbeC3QxF5G3jzHTv7PpJ6pLB/kRGBjEzeyYAVs1BZyzg/Qkn/hSSlKnnoQRwvnayB
         sb/hq9mwSuGLcldySxWcWnEOtzPRrZrOvntOzxDG9x2IRbinn4RqTO6iZYdoyO//6SC/
         GnDwA45kY+8+noVbs7YxaKIfNURkSZN/HkJXO/tDcEpa1rxhi6q6dcOcOiI9aaCrPMpF
         hTZUGv0h9rh/p93NrLzo//Zs/tldtOvMTbbmxbgRMgDZ8G2K1pN4CsTUGXwSgPBaw5lH
         dq5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730406275; x=1731011075;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bvul/ButslL/SfFParCrQ24MY7VsrtOizUyLtg7jpC0=;
        b=o/d5Cy+96u+EmD5CNe6T0k1P7l/5UHLKURSTd8cfIYYSyYyuJjwcQrqr71KsICAlE3
         YMvUfmx94ptzOuJmpnDUB/QcpKsxGJGgz9RI8qy/KRl+3BOFGn4HRPSHshoYajn/QQxv
         ShCevxqTa/Rt6pN+dRCNtwHBUSKzY9ZxjjuyktSZ3dz+/Wy5R9ZhEWrlm0ruRJTTyc2i
         5Q1CLAiSoFBPQEv5hHJ8sNgjQskjn1hshl4PpqDqW+K4VEsVkbIKI7iFMxco1AP1ye+Y
         vBhMvt+XqpfjcG05A40o0xmzakGEH1O9G77gVDiSi1fwg0+I2ntPlHUCO+RvwEN/dxUt
         Jojg==
X-Forwarded-Encrypted: i=1; AJvYcCV2b8J2TKQKARrw98hEAobGO+xdPq4l5f2lrlThruZFgEhRFrF94CqFfMvwV8M0GGZ03pKOzUrw5odTcjcd@vger.kernel.org, AJvYcCW9cZFW4qAYDaznI0d6Dkrc//juwRQMYVu9DJucPoVWyqXuzWJG7VCwAhBwcJlj+lo8mPqsvn6cGHb4@vger.kernel.org, AJvYcCXabIgK/6WcMWrtYFckDgVUcQhxMhhdMJXtoEeR7lM7bcwwnwHzn+ihsAXph5B7y/w9gz0pWJ5zsg0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXXjjibfbNutovyPDOUGrqc7dx0GgFDBYj4ldKr53qYX5+DrRh
	Fzn9HT03/peLjq4afz4Q3aPxld+y/tKqr4t541hVwTrq702cZJFX
X-Google-Smtp-Source: AGHT+IF8/Jj1mz6ZXbFcpAc6WbNpTLEt+rE2mRrtARP8nrTGarcDw9XqiTfO/Gph0pGEN4+53/cH6w==
X-Received: by 2002:a17:902:f68a:b0:20c:c880:c3b0 with SMTP id d9443c01a7336-210f751dd47mr104971915ad.21.1730406275259;
        Thu, 31 Oct 2024 13:24:35 -0700 (PDT)
Received: from fan ([2601:646:8f03:9fee:1a14:7759:606e:c90])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211057a2531sm12413625ad.139.2024.10.31.13.24.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2024 13:24:34 -0700 (PDT)
From: Fan Ni <nifan.cxl@gmail.com>
X-Google-Original-From: Fan Ni <fan.ni@samsung.com>
Date: Thu, 31 Oct 2024 13:24:18 -0700
To: Terry Bowman <terry.bowman@amd.com>
Cc: ming4.li@intel.com, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	dave@stgolabs.net, jonathan.cameron@huawei.com,
	dave.jiang@intel.com, alison.schofield@intel.com,
	vishal.l.verma@intel.com, dan.j.williams@intel.com,
	bhelgaas@google.com, mahesh@linux.ibm.com, ira.weiny@intel.com,
	oohall@gmail.com, Benjamin.Cheatham@amd.com, rrichter@amd.com,
	nathan.fontenot@amd.com, Smita.KoralahalliChannabasappa@amd.com
Subject: Re: [PATCH v2 01/14] PCI/AER: Introduce 'struct cxl_err_handlers'
 and add to 'struct pci_driver'
Message-ID: <ZyPncuiISDL7ubqN@fan>
References: <20241025210305.27499-1-terry.bowman@amd.com>
 <20241025210305.27499-2-terry.bowman@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241025210305.27499-2-terry.bowman@amd.com>

On Fri, Oct 25, 2024 at 04:02:52PM -0500, Terry Bowman wrote:
> CXL.io provides PCIe like protocol error implementation, but CXL.io and
> PCIe have different handling requirements.
> 
> The PCIe AER service driver may attempt recovering PCIe devices with
> uncorrectable errors while recovery is not used for CXL.io. Recovery is not
> used in the CXL.io recovery because of the potential for corruption on
> what can be system memory.
> 
> Create pci_driver::cxl_err_handlers similar to pci_driver::error_handler.
> Create handlers for correctable and uncorrectable CXL.io error
> handling.
> 
> The CXL error handlers will be used in future patches adding CXL PCIe
> port protocol error handling.
> 
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> ---

Reviewed-by: Fan Ni <fan.ni@samsung.com>

>  include/linux/pci.h | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 573b4c4c2be6..106ac83e3a7b 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -886,6 +886,14 @@ struct pci_error_handlers {
>  	void (*cor_error_detected)(struct pci_dev *dev);
>  };
>  
> +/* CXL bus error event callbacks */
> +struct cxl_error_handlers {
> +	/* CXL bus error detected on this device */
> +	bool (*error_detected)(struct pci_dev *dev);
> +
> +	/* Allow device driver to record more details of a correctable error */
> +	void (*cor_error_detected)(struct pci_dev *dev);
> +};
>  
>  struct module;
>  
> @@ -956,6 +964,7 @@ struct pci_driver {
>  	int  (*sriov_set_msix_vec_count)(struct pci_dev *vf, int msix_vec_count); /* On PF */
>  	u32  (*sriov_get_vf_total_msix)(struct pci_dev *pf);
>  	const struct pci_error_handlers *err_handler;
> +	const struct cxl_error_handlers *cxl_err_handler;
>  	const struct attribute_group **groups;
>  	const struct attribute_group **dev_groups;
>  	struct device_driver	driver;
> -- 
> 2.34.1
> 

-- 
Fan Ni

