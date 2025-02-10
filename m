Return-Path: <linux-pci+bounces-21119-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 12F78A2F9C9
	for <lists+linux-pci@lfdr.de>; Mon, 10 Feb 2025 21:16:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC4F33A8176
	for <lists+linux-pci@lfdr.de>; Mon, 10 Feb 2025 20:16:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D56F19D067;
	Mon, 10 Feb 2025 20:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="L/AXbWI9"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A7801925AF
	for <linux-pci@vger.kernel.org>; Mon, 10 Feb 2025 20:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739218593; cv=none; b=GAuMY9CMLd+IiKJ9KYLpv2T1AVkltn3JSJQz4+Mog3J+/sAE4oMH/Lc/DK4LkUsCTO+j0mN675cvjfGrXMHDediPWZ0cA01rptFjZ3+uWGTgegW8CUflJhWPfeqOLYyEa5IGNR/7bkT2UP6ZszOXlFgLX33N5ESkm1JTJjtOVEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739218593; c=relaxed/simple;
	bh=zOVCuLqqp7lIFVY+RQFVpAD9kWvnhUx4b7NUg6zFx6k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ue5f+j9BLlRjHkOclzUu1TD4Hu9r69F9OnDI70WazaN+kDVmvhbLtBR64Z+Pd/48hWrNP++VhVTXay2yTmim9iBRwkbFPt0uqP63wDy5jtAE/TfFicyNpDwATwMGOlEy2CeUKZXRTX3BO16RkwARBTny1uWRzCSnEX1HBCHJu3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=L/AXbWI9; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-6e440e64249so52729396d6.3
        for <linux-pci@vger.kernel.org>; Mon, 10 Feb 2025 12:16:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1739218590; x=1739823390; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TmZaS9Q5ARi+stLwMR+ytvy82MSixmOKvEzop3aGNRg=;
        b=L/AXbWI929HQpvOIwDtqsnNvDhxPQC03FwUQYTXsRMF6RCCCtewcYho0K7iz+MpjLF
         NiGJ4D4j5cNKua6Ls61xNVYUlu7KrGJK6fYw5azWCjxOnonw/Ux+4tsInL5YFGZ3pLJd
         kvDfDZTeQA8sZgthFoAIa3kBhv1sB6qf9y+sLOassCZBoMGxh5hWIt5aVcjWs/o73Z7t
         oFC8wurl8W8yX2CDXgBhjewVUYHMSR1uxfw46Sn64PBOYaglri59PA31ExRjVDehhAhW
         fBahxbIxFu/92L0djMxEJd+qHFVbksAuF9sg4JmK79BpZ3PgLgPvh2KwIJBvCDEtvdsx
         y8Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739218590; x=1739823390;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TmZaS9Q5ARi+stLwMR+ytvy82MSixmOKvEzop3aGNRg=;
        b=kIQ7R197w4MO3NLFHFCXutr2bBgWY5VdlixtLDEVA1/hrV0YkfkJG5pl/lsTawJFNP
         Hcgot9M0igsh4RxnJ3e+sFPRmwwBTBiu5jQV0ux8Tn5dgRfkwum7Y9aJHPV4XClsuLj8
         vaJp1DtnZOag5csriBYDo9c06IjLtwV+gVl+1VXETmCGkCNguA2TrJvxEE1FpKo1Cvyp
         zjPs7fT2kIIuUuDxC0OzlHtidP9C8SCaduiIZUTedkXBOLsrnD/YO6XLWNbJzt/bTKfN
         /SxE1u+jgU0ULBwYpdSyM3x3Me2eoWyW6t84nwPhfTf/8fvL0GWdUSh5tFPawTePNbyo
         cZyA==
X-Forwarded-Encrypted: i=1; AJvYcCVh+dYPkHzOJ5FqTTY7doGvmXvRZlYXaNc/Mz9G6PTXF+3KA0faxGXkiSbggp25mEThVUZ6UfYG/VM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAT4VP/gKZTp9ahUaA9cNzYbn+zoDFVs7aEyxKIZRjYu16bWWi
	cbazB/7xzSI8say/QxlMrrQsAcKuF9piyvy/eBNF+U+dc/rdV2jhNjAGmultae8=
X-Gm-Gg: ASbGncsGj/BKYVY5RgFOQJqbHqsNBVrpG9KNNVuMMqHQYAy263GmjCJETHupyOTdq6i
	PzJL1cEAAbBMg0pF3vQjHvjQDKjgtcgeOqnbBB5iJNUzrB3ljTKi89ePN5OP4WrJeaTbnHlh6+Y
	pNukV4GUlVBalPzCbZImaO96cNN77tyDNdYcCSOnohYBae2Umkps/mxtBhhhvDW60QA1K3TQ2rG
	O5B6OBr6zvp7fvR447tCk89EoE4RdwtMFdCtOqQKstOmx1smFi1Slr2MLX/6R8EBfl5gZUoq3sC
	xNwfeMow1hz2gz+S4oIGLAVuP0OaxdW+MhkoTc73ts+qxSrM3WZEO+Xu1z1/CoNfhkn+rComfg=
	=
X-Google-Smtp-Source: AGHT+IHaWy6OWyyGWl5uHJt1PdJryLmgsKNr7oFda7GMAIR7eYtWwDbpamF5pLaQI6ezCFdzn8zwsg==
X-Received: by 2002:a05:6214:234d:b0:6dd:d3b:de27 with SMTP id 6a1803df08f44-6e44561dda0mr199510966d6.18.1739218590061;
        Mon, 10 Feb 2025 12:16:30 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e43bad58c0sm50428806d6.118.2025.02.10.12.16.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2025 12:16:29 -0800 (PST)
Date: Mon, 10 Feb 2025 15:16:27 -0500
From: Gregory Price <gourry@gourry.net>
To: Terry Bowman <terry.bowman@amd.com>
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, nifan.cxl@gmail.com, dave@stgolabs.net,
	jonathan.cameron@huawei.com, dave.jiang@intel.com,
	alison.schofield@intel.com, vishal.l.verma@intel.com,
	dan.j.williams@intel.com, bhelgaas@google.com, mahesh@linux.ibm.com,
	ira.weiny@intel.com, oohall@gmail.com, Benjamin.Cheatham@amd.com,
	rrichter@amd.com, nathan.fontenot@amd.com,
	Smita.KoralahalliChannabasappa@amd.com, lukas@wunner.de,
	ming.li@zohomail.com, PradeepVineshReddy.Kodamati@amd.com
Subject: Re: [PATCH v6 09/17] cxl/pci: Update RAS handler interfaces to also
 support CXL PCIe Ports
Message-ID: <Z6pem7NaFiBdcCxy@gourry-fedora-PF4VCD3F>
References: <20250208002941.4135321-1-terry.bowman@amd.com>
 <20250208002941.4135321-10-terry.bowman@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250208002941.4135321-10-terry.bowman@amd.com>

On Fri, Feb 07, 2025 at 06:29:33PM -0600, Terry Bowman wrote:
> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index 4af39abbfab3..0adebf261fe7 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
> @@ -652,7 +652,7 @@ void read_cdat_data(struct cxl_port *port)
>  }
>  EXPORT_SYMBOL_NS_GPL(read_cdat_data, "CXL");
>  
> -static void __cxl_handle_cor_ras(struct cxl_dev_state *cxlds,
> +static void __cxl_handle_cor_ras(struct device *dev,
>  				 void __iomem *ras_base)
>  {
>  	void __iomem *addr;
> @@ -663,10 +663,8 @@ static void __cxl_handle_cor_ras(struct cxl_dev_state *cxlds,
>  
>  	addr = ras_base + CXL_RAS_CORRECTABLE_STATUS_OFFSET;
>  	status = readl(addr);
> -	if (!(status & CXL_RAS_CORRECTABLE_STATUS_MASK)) {
> -		dev_err(cxl_dev, "%s():%d: CE Status is empty\n", __func__, __LINE__);
> +	if (!(status & CXL_RAS_CORRECTABLE_STATUS_MASK))
>  		return;
> -	}
>  	writel(status & CXL_RAS_CORRECTABLE_STATUS_MASK, addr);
>  
>  	if (is_cxl_memdev(cxl_dev))


This seems like where you actually wanted this original change:

diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index aa855c2068e0..a0c78655a8af 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -714,7 +714,7 @@ void cxl_cper_trace_uncorr_port_prot_err(struct pci_dev *pdev,
 }
 EXPORT_SYMBOL_NS_GPL(cxl_cper_trace_uncorr_port_prot_err, "CXL");
 
-static void __cxl_handle_cor_ras(struct cxl_dev_state *cxlds,
+static void __cxl_handle_cor_ras(struct device *dev,
                                 void __iomem *ras_base)
 {
        void __iomem *addr;
@@ -725,15 +725,19 @@ static void __cxl_handle_cor_ras(struct cxl_dev_state *cxlds,
 
        addr = ras_base + CXL_RAS_CORRECTABLE_STATUS_OFFSET;
        status = readl(addr);
-       if (status & CXL_RAS_CORRECTABLE_STATUS_MASK) {
-               writel(status & CXL_RAS_CORRECTABLE_STATUS_MASK, addr);
-               trace_cxl_aer_correctable_error(cxlds->cxlmd, status);
-       }
+       if (!(status & CXL_RAS_CORRECTABLE_STATUS_MASK))
+               return;
+       writel(status & CXL_RAS_CORRECTABLE_STATUS_MASK, addr);
+
+       if (is_cxl_memdev(dev))
+               trace_cxl_aer_correctable_error(to_cxl_memdev(dev), status);
+       else if (is_cxl_port(dev))
+               trace_cxl_port_aer_correctable_error(dev, status);
 }

