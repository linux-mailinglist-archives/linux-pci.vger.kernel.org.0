Return-Path: <linux-pci+bounces-20917-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94FBCA2C9DF
	for <lists+linux-pci@lfdr.de>; Fri,  7 Feb 2025 18:11:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E4091621FE
	for <lists+linux-pci@lfdr.de>; Fri,  7 Feb 2025 17:11:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6736318DB0C;
	Fri,  7 Feb 2025 17:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BMMRa0tg"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B82D318DB3A
	for <linux-pci@vger.kernel.org>; Fri,  7 Feb 2025 17:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738948306; cv=none; b=eZl8vXL66pbvQQmVHm/3mo5sb+4DXGfMSCeQACkdywp63XXEJzLV6fmZscjqkW6Jk+KMfS3x7NxGQ2OMkPXV/ppE5sOgQzKPQzx8tjhB17uNP65Qyz5yzq3Et5clpvj4Wmoupg4p0c22X2EFWKdelJv2yE2GBWi1Kxu7R5UHxU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738948306; c=relaxed/simple;
	bh=3oqMFK9uVk8Im6p2fViZxYDLyfCXJ/tL1uHJc+oNhVE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bItKyHefSdhXC4REENyexOajcj+PxIv0tkIUBrbYYjDXl6QIgqjq8pJLm8NP1hEtNZ4a3PBY+PuQ8l6I8fTMslqQeQ/4aU7NL3CuvGl+RamLBVhbqRLur8DBlCn2lt9emTYrB7kaWfRSgAZ3c20H/ZTmX1FQjeJ2cSXmxPp2sr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=BMMRa0tg; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2fa40c0bab2so99823a91.0
        for <linux-pci@vger.kernel.org>; Fri, 07 Feb 2025 09:11:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1738948304; x=1739553104; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ZLSQYabb/lSxt6fjBtaqzp3dajokNagRpgNUe0b1zuo=;
        b=BMMRa0tgAdYR3dP/wUBVb2espgM/SPBbElNKaJkRXItX/1ltu4Q51NrBRZVDuZrTmF
         9J5MD5UUKyQNEmC7GNKhoq6YwMR5jhxgcLejbewnSEmaufQmgul7afqjHOtPq2vVW278
         /FK31n9U2ZG6zcwVuRLW45LaW5zJLST4AJYOLGB3xe8qmg1OSj6kIPzhMTLyZ7QAZGnb
         9MkBMMcqe58EXmwGipvZWNeRy+/rRuU40fXe2SskmIjnO8kZFjHef/QzrXyKnw9A5hcc
         iXIpYx+Gr4Xw1AWpFpg2MmY+YBds5zkjCcYTIgc7QoOJwhl3FVWlEIic7/7oGQ9KUxHc
         n/cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738948304; x=1739553104;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZLSQYabb/lSxt6fjBtaqzp3dajokNagRpgNUe0b1zuo=;
        b=w0ZMGx49/nwZ/w+IRF+PxgulMHew83y9B0TkNlcln/UmrnXA+kEowQn8eSbTOMgOPK
         7ueYiydVUb69gPqx3Do9Fo/yLG4Znd946yeSoQbk0DEzpMolw5RD+7ie6v6Kh0wlTjp2
         xhCLK4kExlTOIgt4JE9M+hw3SWYmsvH+vbqrfavqbg+WTbwl5g4Fp4HiRWTVZefonA4g
         v4ZkRjDndIsA4KPJP2qIuifziVgSQT535xRh4HiUQXScNV92iUsPcbRgQ8r5XkcPT2GR
         oS/a917ZS+TN6H9hlSJCRoY5810GgKcYLnp6UXjIV+5RbDVXoYNBczi2N2MCwa3nv21l
         YFGw==
X-Forwarded-Encrypted: i=1; AJvYcCXXBk/x46IqLlojPL9ghlg/4dCOPkxNS9klEtR7ZrSjeyoGP6E6GbMjbt2KvKVfCaLkRfKpWErHkoE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8yaNsh+Yf0g9WQMwJ+lPMEOsG9GD/WacfTf+JtSZqAab3kRZw
	DeBKKVME/Q/UoziF7jukWvu+dEirHfjmyrGoqp2YVC2rFpLD2O/fwg4yzF1W/w==
X-Gm-Gg: ASbGncuftRpQJuuzIv1c+DeBwsB84ewJ9oUwWLCk1BMiGOiNdkr5vmJIL2lYIxgnyaB
	BHPtSvRz4hBghfZjtYcWil3dlV0spuf8aehRr78kpHlXzObtNCyB5AdSUyrPaV6fMayTd2kVbha
	Zqjp2j7RkbjJ9FL5fAdpqo2qYAyDqZ55qEF9mm8cx0sLqUJT51UJWZzhOMz6PioZFNUY2sVUsML
	xxWgy7tf7elAnmAQCbHkpwVCXCLkaxuQrxtWYbnNo5Z+xymGPWDzhiyaX5fwXmWSt8uGepILZdE
	+7NnAfdJkCh8L00EoOZwn4TiRg==
X-Google-Smtp-Source: AGHT+IFtcomA6DEgyFHtU/vkPC/XD5zQT3e5gfj40oA9PVVdGW4FaLDWXXz6aAFVD/jXpdRoCbUUNg==
X-Received: by 2002:a17:90b:23d0:b0:2fa:13f7:960 with SMTP id 98e67ed59e1d1-2fa2406a099mr5927820a91.13.1738948303969;
        Fri, 07 Feb 2025 09:11:43 -0800 (PST)
Received: from thinkpad ([120.60.76.168])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21f3683d8desm32895195ad.155.2025.02.07.09.11.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Feb 2025 09:11:43 -0800 (PST)
Date: Fri, 7 Feb 2025 22:41:39 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Niklas Cassel <cassel@kernel.org>
Cc: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Siddharth Vadapalli <s-vadapalli@ti.com>,
	Udit Kumar <u-kumar1@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH v4 2/7] PCI: endpoint: Add pci_epc_bar_size_to_rebar_cap()
Message-ID: <20250207171139.v2xtqgaglfgfsk6j@thinkpad>
References: <20250131182949.465530-9-cassel@kernel.org>
 <20250131182949.465530-11-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250131182949.465530-11-cassel@kernel.org>

On Fri, Jan 31, 2025 at 07:29:51PM +0100, Niklas Cassel wrote:
> Add a helper function to convert a size to the representation used by the
> Resizable BAR Capability Register.
> 
> Signed-off-by: Niklas Cassel <cassel@kernel.org>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

One nit below.

> ---
>  drivers/pci/endpoint/pci-epc-core.c | 27 +++++++++++++++++++++++++++
>  include/linux/pci-epc.h             |  1 +
>  2 files changed, 28 insertions(+)
> 
> diff --git a/drivers/pci/endpoint/pci-epc-core.c b/drivers/pci/endpoint/pci-epc-core.c
> index 10dfc716328e..5d6aef956b13 100644
> --- a/drivers/pci/endpoint/pci-epc-core.c
> +++ b/drivers/pci/endpoint/pci-epc-core.c
> @@ -638,6 +638,33 @@ int pci_epc_set_bar(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
>  }
>  EXPORT_SYMBOL_GPL(pci_epc_set_bar);
>  
> +/**
> + * pci_epc_bar_size_to_rebar_cap() - convert a size to the representation used
> + *				     by the Resizable BAR Capability Register
> + * @size: the size to convert
> + * @cap: where to store the result
> + *
> + * Returns 0 on success and a negative error code in case of error.
> + */
> +int pci_epc_bar_size_to_rebar_cap(size_t size, u32 *cap)
> +{
> +	/*
> +	 * According to PCIe base spec, min size for a resizable BAR is 1 MB,
> +	 * thus disallow a requested BAR size smaller than 1 MB.
> +	 * Disallow a requested BAR size larger than 128 TB.
> +	 */
> +	if (size < SZ_1M || (u64)size > (SZ_128G * 1024))

You could've used (SZ_1T * 128). But no need to respin just for this.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

