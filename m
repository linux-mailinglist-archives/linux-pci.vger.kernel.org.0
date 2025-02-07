Return-Path: <linux-pci+bounces-20915-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8382A2C9D0
	for <lists+linux-pci@lfdr.de>; Fri,  7 Feb 2025 18:07:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF6A53A875D
	for <lists+linux-pci@lfdr.de>; Fri,  7 Feb 2025 17:06:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07538192B71;
	Fri,  7 Feb 2025 17:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="u411O57h"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46A7718E03A
	for <linux-pci@vger.kernel.org>; Fri,  7 Feb 2025 17:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738947996; cv=none; b=lna938qPeQOcCfnXb0ZXxSB9B8ZfnomfiUaqz1It+UTBtXlcFdhO0SeQuJehWBGlJt9YNC4tCgcJW4500k9OGYHlpetU5VG4xsnq8cSbGvNvTHt2gXWkC1YJ1NRNiY5QzkSKoicVrp9p+3Z9eZHHZpc35i0kayjx3M4nlg92Qdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738947996; c=relaxed/simple;
	bh=DPcj1tOpKDPHUbPmxsOjmhjlaugj5AJBOIGtZjS0p7s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FAIcSVCaD4xa1yyG77V6E5uwRJTnbDTVZQLs4HpKTHv41AIGwRIdcJG00sT/chRaZ9F4Gi6HgAPAfr3UPxVMflOvm0QV5jZGW7c55fb+ODkbg0QF/qtfiyiRZoNHm4rXWfb1hEq4fq73gW9pfzSGZ0b/+1pxFaccKWRj5Bb6+is=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=u411O57h; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-21f6022c2c3so7455335ad.0
        for <linux-pci@vger.kernel.org>; Fri, 07 Feb 2025 09:06:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1738947994; x=1739552794; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=kz5xpMon3s4aEwrYtbYd37AAr5D97Tv5QUty8rl8Ym0=;
        b=u411O57hJAAts1h82o8twjfEcJoaXGbWrkL/ZQfZXzNNHufsB7fEXTbXFjrfjbwzu/
         WrGSpNN/qCQ2+y4bXel+oqQSk18RynTq6PqO6gdHh9X59da6vil6iYW5WJE5tnjEEmAv
         qOFZQS7TqXnzgim+L8gydDO1l97FVZU/2QgYFdUZ1W0PvGKHGB2MqSoIE+9wQsV1pgDC
         lXt05QZvas/BPXh9g4AdPubkXZiwr5i7xGG2b5IClEg3ej5l0qz/+o7L+VgSuRqMou8J
         20NmkdSQpDf6PI/vpYz3TC4ds/CPZAcZr6Qf4kQCRO2MKqR4gFxuPRfyz9bvDmVx1Ozm
         t8tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738947994; x=1739552794;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kz5xpMon3s4aEwrYtbYd37AAr5D97Tv5QUty8rl8Ym0=;
        b=Kdi/hJqnee44ZiVuEJ7jadydAgzaTjFJB8r3FtFNY22+4iR1MYZI7DNUh+X1Epr8G1
         PgB8MACYDCNtmjpcdSdMcQeQoMUBQ5TAhhKGsu8Wgh/8PfnDMqGwyd8EZJGwdmXrNIxj
         yKQk0yS2dCrvXXQcP9b5ItlZF+1lOk2WY0gWMalICqqz3NRBSX6QkxOJiDjSLmMgliVp
         2sYDfe31CcrIS1Uajlcl//nS4x7kp0cpkRQcNIlNYEMW1xOnWwpNAJpRa92ezeHWBDcI
         WkzrxHmFj6EEY2cOJV5UmIjJHkGUC88OJbmieZdfmQKFEqD5GF8kFAbGrBlKzrjUr3BB
         GlRQ==
X-Forwarded-Encrypted: i=1; AJvYcCXgeQLhrctZYP2jtIZgynU5vvkDhknVsVAf5ifrbxVqUexIb2RuO3wHc619RqKsBY7GZo50JBsKF70=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvPyNfXFhvQYMBsSWDB6C0b8GuQcZ2XojzeSGDA9yv8e8qCFsp
	Tis1KPzqa67c1LoerNSR9ILZqZPlML4vp21sCqAP5bXC+MrR/K/WFE/bhx9c2Q==
X-Gm-Gg: ASbGncuDj0LPsRj6Z/LR4cCxh4Gq8aMRVRaPY6QXuqJcXpKZLgGriqjn6XUbyoRFnU5
	ah2AJT6MPjnBeHJiP1Iz0Z/Hs1cKjdGGJUpix93L3IbzjkGZcxwVLqaBlZFWp8zrsozi3tRDx0S
	zksGlj7BL6kGVmPT2cPrpVMAwCsUQlG56ADcCy5V9fLNsoJUFi9pWe9AYaxA4eh8XsHbywcMJ+g
	x6JVfp1ZJaVvqqI7xpSJusHRGwAipVqGH7CwWE6T7MWSy1H+rAYmh6hE6DYbpuWrjOSskG6MhYH
	9T/4X1KTKY0vqniP3P7eJGNe1w==
X-Google-Smtp-Source: AGHT+IEiBkBVYobWTIk8UNvX8AzWWvHifQQvdFBw/Cq2WUlU7pMZAFwB/LRCFl/7s1NB1kfahhDJpg==
X-Received: by 2002:a05:6a20:d705:b0:1e1:a449:ff71 with SMTP id adf61e73a8af0-1ee05232427mr6568040637.1.1738947993185;
        Fri, 07 Feb 2025 09:06:33 -0800 (PST)
Received: from thinkpad ([120.60.76.168])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73048e1e804sm3208365b3a.156.2025.02.07.09.06.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Feb 2025 09:06:32 -0800 (PST)
Date: Fri, 7 Feb 2025 22:36:28 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Niklas Cassel <cassel@kernel.org>
Cc: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Siddharth Vadapalli <s-vadapalli@ti.com>,
	Udit Kumar <u-kumar1@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH v4 1/7] PCI: endpoint: Allow EPF drivers to configure the
 size of Resizable BARs
Message-ID: <20250207170628.au23b5cw3s7il67j@thinkpad>
References: <20250131182949.465530-9-cassel@kernel.org>
 <20250131182949.465530-10-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250131182949.465530-10-cassel@kernel.org>

On Fri, Jan 31, 2025 at 07:29:50PM +0100, Niklas Cassel wrote:
> A resizable BAR is different from a normal BAR in a few ways:
> -The minimum size of a resizable BAR is 1 MB.
> -Each BAR that is resizable has a Capability and Control register in the
>  Resizable BAR Capability structure.
> 
> These registers contain the supported sizes and the currently selected
> size of a resizable BAR.
> 
> The supported sizes is a bitmap of the supported sizes. The selected size
> is a single value that is equal to one of the supported sizes.
> 
> A resizable BAR thus has to be configured differently than a
> BAR_PROGRAMMABLE BAR, which usually sets the BAR size/mask in a vendor
> specific way.
> 
> The PCI endpoint framework currently does not support resizable BARs.
> 
> Add a BAR type BAR_RESIZABLE, so that an EPC driver can support resizable
> BARs properly.
> 
> Note that the pci_epc_set_bar() API takes a struct pci_epf_bar which tells
> the EPC driver how it wants to configure the BAR.
> 
> struct pci_epf_bar only has a single size struct member.
> 
> This means that an EPC driver will only be able to set a single supported
> size. This is perfectly fine, as we do not need the complexity of allowing
> a host to change the size of the BAR. If someone ever wants to support
> resizing a resizable BAR, the pci_epc_set_bar() API can be extended in the
> future.
> 
> With these changes, we allow an EPF driver to configure the size of
> Resizable BARs, rather than forcing them to a 1 MB size.
> 
> Signed-off-by: Niklas Cassel <cassel@kernel.org>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> ---
>  drivers/pci/endpoint/pci-epc-core.c | 4 ++++
>  drivers/pci/endpoint/pci-epf-core.c | 4 ++++
>  include/linux/pci-epc.h             | 4 ++++
>  3 files changed, 12 insertions(+)
> 
> diff --git a/drivers/pci/endpoint/pci-epc-core.c b/drivers/pci/endpoint/pci-epc-core.c
> index 9e9ca5f8e8f8..10dfc716328e 100644
> --- a/drivers/pci/endpoint/pci-epc-core.c
> +++ b/drivers/pci/endpoint/pci-epc-core.c
> @@ -609,6 +609,10 @@ int pci_epc_set_bar(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
>  	if (!epc_features)
>  		return -EINVAL;
>  
> +	if (epc_features->bar[bar].type == BAR_RESIZABLE &&
> +	    (epf_bar->size < SZ_1M || (u64)epf_bar->size > (SZ_128G * 1024)))
> +		return -EINVAL;
> +
>  	if (epc_features->bar[bar].type == BAR_FIXED &&
>  	    (epc_features->bar[bar].fixed_size != epf_bar->size))
>  		return -EINVAL;
> diff --git a/drivers/pci/endpoint/pci-epf-core.c b/drivers/pci/endpoint/pci-epf-core.c
> index 50bc2892a36c..394395c7f8de 100644
> --- a/drivers/pci/endpoint/pci-epf-core.c
> +++ b/drivers/pci/endpoint/pci-epf-core.c
> @@ -274,6 +274,10 @@ void *pci_epf_alloc_space(struct pci_epf *epf, size_t size, enum pci_barno bar,
>  	if (size < 128)
>  		size = 128;
>  
> +	/* According to PCIe base spec, min size for a resizable BAR is 1 MB. */
> +	if (epc_features->bar[bar].type == BAR_RESIZABLE && size < SZ_1M)
> +		size = SZ_1M;
> +
>  	if (epc_features->bar[bar].type == BAR_FIXED && bar_fixed_size) {
>  		if (size > bar_fixed_size) {
>  			dev_err(&epf->dev,
> diff --git a/include/linux/pci-epc.h b/include/linux/pci-epc.h
> index e818e3fdcded..91ce39dc0fd4 100644
> --- a/include/linux/pci-epc.h
> +++ b/include/linux/pci-epc.h
> @@ -188,11 +188,15 @@ struct pci_epc {
>   * enum pci_epc_bar_type - configurability of endpoint BAR
>   * @BAR_PROGRAMMABLE: The BAR mask can be configured by the EPC.
>   * @BAR_FIXED: The BAR mask is fixed by the hardware.
> + * @BAR_RESIZABLE: The BAR implements the PCI-SIG Resizable BAR Capability.
> + *		   NOTE: An EPC driver can currently only set a single supported
> + *		   size.
>   * @BAR_RESERVED: The BAR should not be touched by an EPF driver.
>   */
>  enum pci_epc_bar_type {
>  	BAR_PROGRAMMABLE = 0,
>  	BAR_FIXED,
> +	BAR_RESIZABLE,
>  	BAR_RESERVED,
>  };
>  
> -- 
> 2.48.1
> 

-- 
மணிவண்ணன் சதாசிவம்

