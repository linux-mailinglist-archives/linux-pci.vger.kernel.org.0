Return-Path: <linux-pci+bounces-22772-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D014EA4CA8D
	for <lists+linux-pci@lfdr.de>; Mon,  3 Mar 2025 18:58:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 816A43AC7EF
	for <lists+linux-pci@lfdr.de>; Mon,  3 Mar 2025 17:35:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5089B229B07;
	Mon,  3 Mar 2025 17:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="amwY23J5"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F8F7215061;
	Mon,  3 Mar 2025 17:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741022580; cv=none; b=gdYhNtGFF/c/RQBLdbP5O6aUbyKAVnUVvDTgWz3vHiX2ll65aTO2eIXeIn2/0HQ76F4UkjrD8zMKQmY9jJP6dT3JIwXKvHJOWpaGoPCEGhRQ0+DC7Rett5nu5nqf520b5Y7y6KPBww91DwEKDq7IFu+FWSTbXiNdy+6J56mVCxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741022580; c=relaxed/simple;
	bh=BojXVM7TuWbWt/szVo1jrbABw+mVS2arDbx8q9WpoZY=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U6Mh6R/Y/8K93Luqa1nU3xrzItoPylyRNABwoWgHzdvDMwPTzc/VDq6k3Wqn8gVXzGllOFTgUIouHKps1MYEPVSTS9jDi7zlc4QFaFbUgA/aah08Pj05oWorHhwCjyS2rPQjqiK7VsdNW92V/zPkDQCJOJW3cckX/hI7BZ+gGrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=amwY23J5; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-22382657540so39851015ad.2;
        Mon, 03 Mar 2025 09:22:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741022578; x=1741627378; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=INEL+mkWEKLq34Mczv2nLd5ND0XQsLg0DNbt4SnzHDQ=;
        b=amwY23J5gsz1xRWkInms3FLDMAzTeRbTYqN5DBJhjmnjWucir9X3AqhED8a5BqSnOd
         53prtB6uMxMceCGb9KaSKkiRKphtyu7s1Fc+fBzjfS6KqFn3EoClu67pQmNcg7OfXTJA
         TuiyHW8Q9WP81zE5i+2H9Ys2mw1ek9JoFkE8Jwohc0YKcyVJowh0wffnhnXmLl+n2i1r
         8O8WTm+Kbvdx1e0nAQ72+OARKs4zv6TcQxp1l5YT8ozAaGYCNlrdxDvsWdabv2H1Wn3z
         JzyYTHKlxNPXUQi+jYq7DgdmUlLdg8qZR8bHP6H4VjwwRZtWIgw3UgXfWNV6Qp9pRJMz
         3zdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741022578; x=1741627378;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=INEL+mkWEKLq34Mczv2nLd5ND0XQsLg0DNbt4SnzHDQ=;
        b=Ozr+CuYyENEPwF2gM2g07QVQ18xWlZUBZDe/3D0zF+UtXkM8w7FcI4zufm4ECEE9RU
         g9Ahnl75GZEnz8b/XeVHWG8x5k2PFWcM+UPtqEWARPIyNawkDX4fLf4ifjS06GXLQ3Xb
         ckZ3XKPD+DfuD92qNKbLtBtFwujbFmpS0Z7vFtUTCiQYdhvx9BHaJftSqNkSn27gg82c
         tmKsnhMKB0f7C46tCJkUXqXhMJZqGr8B+jtmIkJk+LIuZyMAKqRAy3E0OdX1sesg5CTx
         e8qqlvAWOjn+tm2tDXfqUjVexJ0l2wmMn+ZjEQIE2HxwTQldALqq6d3QznffjNDEJykU
         HL+w==
X-Forwarded-Encrypted: i=1; AJvYcCU/0mVeBnfLS/VfwooAM7FPAvjGUyIV9sAfPz9Ggi8ycW0hQ5f0MdtHWPY6Bo27+GfPIr5lQIWpmZc=@vger.kernel.org, AJvYcCXcjNMFIdbVct/xi7UDOCbCE2MsDxHluLVKincnYpnms2+U8isLSmHpGRfKP2Zw56v9RN+NZt7rBWYCiGQUKfaKiw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwOmAQLbMXUnv50uH2pTvF1KapilnUDOJ+AidaSAdN2vVf/M4Fk
	hrkvzEAdZVi18dwk/H9SkbxIP/EeMeSHn2L8KRldFLXJlslRqumw
X-Gm-Gg: ASbGncs6u5+3cywXiT3sgoB46YwZcIKk0gKMnIkQM148QSqc0WbIqFQ39X53UmwBxjb
	SajxXraIvLfmbz52/x/IaXcck+F3cijLD9eMn3Yj/FJ70UhnBxLdMMbAXzYalbDomk0Njfk3HXm
	SwvHiKImFBlrOaeA+cRNyg8sJ0VEgGx3PuIAiCqLKZ2KlfUs/xwHNQRn/zzdNAOUrA7nOoJpbBO
	oaVvC9pDmag1NfxfOI7q4DtmM8hYFMUmAcla0O8xnrHjBu2epWf1cnSc55c54i44b1ROaFy7Doc
	w6W7CC++j14Nzv6P42r0MoyqATQnkg8YSKI5smrp
X-Google-Smtp-Source: AGHT+IGYNi+2VxBOSdALmg07N0zm4mXQing5p3PqQ+CWp+YUijGcJXrzBi5jiCAbCilBAkdB5b8amA==
X-Received: by 2002:a17:903:fa5:b0:220:f40c:71e9 with SMTP id d9443c01a7336-22368f71f0dmr184667325ad.9.1741022576289;
        Mon, 03 Mar 2025 09:22:56 -0800 (PST)
Received: from debian ([2607:fb90:8e63:c2b3:5405:c8bf:c1d1:41d5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-223504c596esm80333925ad.152.2025.03.03.09.22.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 09:22:55 -0800 (PST)
From: Fan Ni <nifan.cxl@gmail.com>
X-Google-Original-From: Fan Ni <fan.ni@samsung.com>
Date: Mon, 3 Mar 2025 09:22:50 -0800
To: Shradha Todi <shradha.t@samsung.com>
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org, manivannan.sadhasivam@linaro.org,
	lpieralisi@kernel.org, kw@linux.com, robh@kernel.org,
	bhelgaas@google.com, jingoohan1@gmail.com,
	Jonathan.Cameron@huawei.com, nifan.cxl@gmail.com,
	a.manzanares@samsung.com, pankaj.dubey@samsung.com,
	cassel@kernel.org, 18255117159@163.com, xueshuai@linux.alibaba.com,
	renyu.zj@linux.alibaba.com, will@kernel.org, mark.rutland@arm.com
Subject: Re: [PATCH v7 2/5] PCI: dwc: Add helper to find the Vendor Specific
 Extended Capability (VSEC)
Message-ID: <Z8XlapjLRfz44hF7@debian>
References: <20250221131548.59616-1-shradha.t@samsung.com>
 <CGME20250221132029epcas5p1e56dd355e7ac912ceb25325595de0d24@epcas5p1.samsung.com>
 <20250221131548.59616-3-shradha.t@samsung.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250221131548.59616-3-shradha.t@samsung.com>

On Fri, Feb 21, 2025 at 06:45:45PM +0530, Shradha Todi wrote:
> dw_pcie_find_vsec_capability() is used by upcoming DWC APIs to find the
How are about "Add dw_pcie_find_ext_capability(), which will be used by
..."

Other than that,


Reviewed-by: Fan Ni <fan.ni@samsung.com>

> VSEC capabilities like PTM, RAS etc.
> 
> Co-developed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> Signed-off-by: Shradha Todi <shradha.t@samsung.com>
> ---
>  drivers/pci/controller/dwc/pcie-designware.c | 40 ++++++++++++++++++++
>  1 file changed, 40 insertions(+)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
> index 145e7f579072..a7c0671c6715 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.c
> +++ b/drivers/pci/controller/dwc/pcie-designware.c
> @@ -16,6 +16,7 @@
>  #include <linux/gpio/consumer.h>
>  #include <linux/ioport.h>
>  #include <linux/of.h>
> +#include <linux/pcie-dwc.h>
>  #include <linux/platform_device.h>
>  #include <linux/sizes.h>
>  #include <linux/types.h>
> @@ -283,6 +284,45 @@ u16 dw_pcie_find_ext_capability(struct dw_pcie *pci, u8 cap)
>  }
>  EXPORT_SYMBOL_GPL(dw_pcie_find_ext_capability);
>  
> +static u16 __dw_pcie_find_vsec_capability(struct dw_pcie *pci, u16 vendor_id,
> +					  u16 vsec_id)
> +{
> +	u16 vsec = 0;
> +	u32 header;
> +
> +	if (vendor_id != dw_pcie_readw_dbi(pci, PCI_VENDOR_ID))
> +		return 0;
> +
> +	while ((vsec = dw_pcie_find_next_ext_capability(pci, vsec,
> +						       PCI_EXT_CAP_ID_VNDR))) {
> +		header = dw_pcie_readl_dbi(pci, vsec + PCI_VNDR_HEADER);
> +		if (PCI_VNDR_HEADER_ID(header) == vsec_id)
> +			return vsec;
> +	}
> +
> +	return 0;
> +}
> +
> +static u16 dw_pcie_find_vsec_capability(struct dw_pcie *pci,
> +					const struct dwc_pcie_vsec_id *vsec_ids)
> +{
> +	const struct dwc_pcie_vsec_id *vid;
> +	u16 vsec;
> +	u32 header;
> +
> +	for (vid = vsec_ids; vid->vendor_id; vid++) {
> +		vsec = __dw_pcie_find_vsec_capability(pci, vid->vendor_id,
> +						      vid->vsec_id);
> +		if (vsec) {
> +			header = dw_pcie_readl_dbi(pci, vsec + PCI_VNDR_HEADER);
> +			if (PCI_VNDR_HEADER_REV(header) == vid->vsec_rev)
> +				return vsec;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
>  int dw_pcie_read(void __iomem *addr, int size, u32 *val)
>  {
>  	if (!IS_ALIGNED((uintptr_t)addr, size)) {
> -- 
> 2.17.1
> 

