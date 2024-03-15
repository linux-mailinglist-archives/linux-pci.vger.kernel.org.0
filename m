Return-Path: <linux-pci+bounces-4847-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B97B87C8DE
	for <lists+linux-pci@lfdr.de>; Fri, 15 Mar 2024 07:50:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9EF0F1F21A9C
	for <lists+linux-pci@lfdr.de>; Fri, 15 Mar 2024 06:50:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EABF31A38CE;
	Fri, 15 Mar 2024 06:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XQopmXfS"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3756914A85
	for <linux-pci@vger.kernel.org>; Fri, 15 Mar 2024 06:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710485057; cv=none; b=E4ZQxgWOd2eigBIs1Nw+rut2ZDbHBdKMy8kjk5Hfbj/l+h0Qz9/WoGw+FBpu//j/5ZU/sXhQdn/aT2yBaTGL7RyB+x9jacyPd3cwJXH9XVLKTSKzbf7tjxmHtr/w2YylRflxEh9tNnNgupEkda34iFeocagTLvm8Q7Je4zPSrFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710485057; c=relaxed/simple;
	bh=nfPR5sokkMxZAkS4MaLUQwplV+xO+3UoIc4nSVpPiT8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EWy22qbIe7L8TuVp0RaLqdaeV4JvrfLttAlrOb+wq35uNMl8odt5SvPxMyd8KeOBHdQudlwJl1W67Fo3KxgCojoapYO/nK2VGbk68pjtJG+OO+sRUF8zRuP65oXdbb90AFimoMVJE2F58sC/0BUhPgd6/7Ie0r6TftfIhBYDZqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XQopmXfS; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-6e6b729669bso1914501b3a.3
        for <linux-pci@vger.kernel.org>; Thu, 14 Mar 2024 23:44:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710485055; x=1711089855; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=OgGanv2N85Or9J/LIYR92UbwkyyQ353OlNbPFUfEBU8=;
        b=XQopmXfSk1zcRreqp1UWsQPtPRlszFtLJ9m6X7kIMZRhcUdKHRpRDk8sDdmUgczRSX
         8SRl9oL7QWxGAh7sZOcZMybcIrORwO6B8p6zfbeX6aXysv6t5ivHi3KD79IeXyodG9sD
         D2cGwidQq8pSnAVCMDLn+bjd6H/1+GHnyz/bSg1AAx/D5Qy67FrVAPfVtrYLPg3AxdOq
         4UgNGXN5Lie6J27ddr8WEErI1GDKQuxmkStIhNaj4pqeU12HIbMYd7WAh+rkuIJpc1Wj
         HI9Rb1DHeCr6812njgLRakYu8MB5/X/uzu41HbM8uONXfioL6x+fcyPEJVPekS3fmO1S
         Hc4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710485055; x=1711089855;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OgGanv2N85Or9J/LIYR92UbwkyyQ353OlNbPFUfEBU8=;
        b=ih+dgldUl0oHkvvRnEOctQt6Cx8UnfGxhL0ica15KsWlJRB/OAFoH6P8ShGxWgEGEo
         tml760lZJRO+0gXxYU19Kq61OgxEmIh1t9mN1NQYcIHG4vS4mHgGwIj4K3R8+ACbZrTK
         Dv1igjh7Eqn1p5hQYAe6zBGUxXqhfx1DAKYhC2wUmG3TGAXZw83zdYpJltbN9yNHlL85
         8dbH7/+kj8G13iOd5wfdrARcVBKzflEpz0JRKhKkxycUz2p8npM8aMLtYQLnWJ7kwRid
         XqAlC02iZhm38jOxwhRfplI0phTznqA638tAnZ56WHpVELEkcQTHeXnpuH3AjE6KVD7a
         WCRA==
X-Forwarded-Encrypted: i=1; AJvYcCUOQkz8AyXENTl4F/gDEoXdUadhBsw/HtGbSXfIK8/5eA5L79mT5/7V8475HkbNo2iBzuqKjb5qUjdaE+ReW7f9QOAyZbVSwM47
X-Gm-Message-State: AOJu0YxWPlQyIth74EKgrggtwZ2j7fN7WtvCxVzfkadWSN3bYxfpHt5a
	GQAEMi5uBGXN4vzl2+KtSk1lD3v8we7bsPHCZSVsJnBdB1+ZiufLACVmzbVDAQ==
X-Google-Smtp-Source: AGHT+IFF/NIlwq1MGho9Ky4bdjy6US11VSAZ789bSns8o7RQuZJB94+oPAQMhMMTfhme4aW21+M9bg==
X-Received: by 2002:a05:6a00:1887:b0:6e6:c61d:114c with SMTP id x7-20020a056a00188700b006e6c61d114cmr5202335pfh.0.1710485055334;
        Thu, 14 Mar 2024 23:44:15 -0700 (PDT)
Received: from thinkpad ([117.207.30.211])
        by smtp.gmail.com with ESMTPSA id y15-20020aa793cf000000b006e6b9a963a5sm2620363pff.131.2024.03.14.23.44.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Mar 2024 23:44:14 -0700 (PDT)
Date: Fri, 15 Mar 2024 12:14:08 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Niklas Cassel <cassel@kernel.org>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Shradha Todi <shradha.t@samsung.com>,
	Damien Le Moal <dlemoal@kernel.org>, linux-pci@vger.kernel.org,
	arnd@arndb.de
Subject: Re: [PATCH v3 9/9] PCI: endpoint: Set prefetch when allocating
 memory for 64-bit BARs
Message-ID: <20240315064408.GI3375@thinkpad>
References: <20240313105804.100168-1-cassel@kernel.org>
 <20240313105804.100168-10-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240313105804.100168-10-cassel@kernel.org>

+ Arnd

On Wed, Mar 13, 2024 at 11:58:01AM +0100, Niklas Cassel wrote:
> From the PCIe 6.0 base spec:

It'd be good to mention the section also.

> "Generally only 64-bit BARs are good candidates, since only Legacy
> Endpoints are permitted to set the Prefetchable bit in 32-bit BARs,
> and most scalable platforms map all 32-bit Memory BARs into
> non-prefetchable Memory Space regardless of the Prefetchable bit value."
> 
> "For a PCI Express Endpoint, 64-bit addressing must be supported for all
> BARs that have the Prefetchable bit Set. 32-bit addressing is permitted
> for all BARs that do not have the Prefetchable bit Set."
> 
> "Any device that has a range that behaves like normal memory should mark
> the range as prefetchable. A linear frame buffer in a graphics device is
> an example of a range that should be marked prefetchable."
> 
> The PCIe spec tells us that we should have the prefetchable bit set for
> 64-bit BARs backed by "normal memory". The backing memory that we allocate
> for a 64-bit BAR using pci_epf_alloc_space() (which calls
> dma_alloc_coherent()) is obviously "normal memory".
> 

I'm not sure this is correct. Memory returned by 'dma_alloc_coherent' is not the
'normal memory' but rather 'consistent/coherent memory'. Here the question is,
can the memory returned by dma_alloc_coherent() be prefetched or write-combined
on all architectures.

I hope Arnd can answer this question.

- Mani

> Thus, set the prefetchable bit when allocating backing memory for a 64-bit
> BAR.
> 
> Signed-off-by: Niklas Cassel <cassel@kernel.org>
> ---
>  drivers/pci/endpoint/pci-epf-core.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/pci/endpoint/pci-epf-core.c b/drivers/pci/endpoint/pci-epf-core.c
> index e7dbbeb1f0de..20d2bde0747c 100644
> --- a/drivers/pci/endpoint/pci-epf-core.c
> +++ b/drivers/pci/endpoint/pci-epf-core.c
> @@ -309,6 +309,9 @@ void *pci_epf_alloc_space(struct pci_epf *epf, size_t size, enum pci_barno bar,
>  	else
>  		epf_bar[bar].flags |= PCI_BASE_ADDRESS_MEM_TYPE_32;
>  
> +	if (epf_bar[bar].flags & PCI_BASE_ADDRESS_MEM_TYPE_64)
> +		epf_bar[bar].flags |= PCI_BASE_ADDRESS_MEM_PREFETCH;
> +
>  	return space;
>  }
>  EXPORT_SYMBOL_GPL(pci_epf_alloc_space);
> -- 
> 2.44.0
> 

-- 
மணிவண்ணன் சதாசிவம்

