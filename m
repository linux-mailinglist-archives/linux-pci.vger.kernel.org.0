Return-Path: <linux-pci+bounces-14391-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB5F299B497
	for <lists+linux-pci@lfdr.de>; Sat, 12 Oct 2024 13:55:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 651B5285F9B
	for <lists+linux-pci@lfdr.de>; Sat, 12 Oct 2024 11:55:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82C6219CCF3;
	Sat, 12 Oct 2024 11:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yOe69ida"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DACAE19C555
	for <linux-pci@vger.kernel.org>; Sat, 12 Oct 2024 11:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728733698; cv=none; b=mbwdbishAWssripgtoktAFnS0tv80n5kZMuWo1BioGLyRMkHDSgbLaAYuZfqr+UbcVTjQPOog23XZgkLlBdq12of6XumH4ZFqZbC672lf9GXUEi46n+m3zdGS4Uvr/5IYlDJQCTgXPOjyAy7JQ4i4HhOgOkexb1ww9GVDPII2e8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728733698; c=relaxed/simple;
	bh=qVwG2RSR835HXq5XryhkyQxd/lB7TEdqDtSRYgGl208=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HtOzY3eUzmK6Im8hVIZn4+YU2ggGdP51zWN99G6OEcWkCIlimXINXC1pSuD+WehRIzUTdMqT+GadsL3FgOYS+/njwOk2jXaQ7uRAOcEAXwCX80yxPk9HuESnhtqM6E57wJW6gWirtBLhH6CIStTbgSxpGpwl8xNqy4DaVGLbpLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=yOe69ida; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-20cbca51687so6166465ad.1
        for <linux-pci@vger.kernel.org>; Sat, 12 Oct 2024 04:48:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728733696; x=1729338496; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+EEpWFKJUddhftyxFCOSqrA46DullTuk6NjokvdvDWo=;
        b=yOe69idaLWYCNjBNBRN0AiZJFatNaILrK8ZN/SxLvtnIps20kByBFQBxoFfNHHWCh6
         LsG4Fb5wmI77E2RXXd4FWwx0mrH0iG56Tr1XDByf2xxZnnIygwY2A9yr+DUOf3O4btJI
         ovCv2sBA1YMya2EDRv8Nn8IB9FBz10Ul/oXsJVx2qRuOMYITov0B0PQO7jnFLDsuSAto
         YYiBlpi5Tm43QibChImNSNxggwpox0DHY0YbfUFapUVdRwHJOewsL1zQ7GahMxE9Z4ZZ
         A1FhUgi+HPO1UqxA/F5ThrZk0QtcsLTXQ5hjsIgbhdYYB17Gx/ClNtxW2gC211Qt17x5
         xUpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728733696; x=1729338496;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+EEpWFKJUddhftyxFCOSqrA46DullTuk6NjokvdvDWo=;
        b=kGKYeDCDFJjS4Z8AGLz3N2y4iPB3wo4IWnAblFzaj934kHBz0NG6s5RapqRVNeq/Mc
         SwJuVhRMfjuOC5eJfzix3IRIuKDbYkq16zSwV19ZB2UqDRLww/ON7eMKCnzOdwX6G193
         f+COoTjj3gjDw2CjHM2MoSjZz7nKLqOvRgLAxu0KHudOKph7ovJ87QbSUHMJnySvaWr3
         Op1l48xzkBgR8QQ1gBO+zQg0pn3YQ8lOLmqqfJwIfPz9I+PeJLE+ZqWKrx25mD3sxsO9
         E6N1YCiTXDFbAmR9uiBYkR7lySfUOxtD9QgEpJdbMli2e5nOdnqNdDwD0C84aX/prGtg
         Wxgw==
X-Forwarded-Encrypted: i=1; AJvYcCWnHX7s2OvFE2cavZHz6WEWOyuPVDYXOk+oMNFJAbyFjWbImhCykOkdqfL61PsOXRgvzym8aaIREcc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzrfiuRPxaUVolcMWu69zmoxnJ7lfY9gwsasIZL5s+7xTx2hWwX
	zekRgMj1o2LCtt7HjV9JyUNpuD9mJAVZkN9mhBrZeBgsAD4LmzTShlBpXfPhJg==
X-Google-Smtp-Source: AGHT+IFFPxrQt8uON9gVFHJ21KohOzvk4hWhiZ36fLTUZwD0hGGSIwcHfilZWVD/RiIM3eqeIckOMw==
X-Received: by 2002:a17:903:244e:b0:20b:b238:9d02 with SMTP id d9443c01a7336-20cbb21e84bmr47310715ad.33.1728733696061;
        Sat, 12 Oct 2024 04:48:16 -0700 (PDT)
Received: from thinkpad ([220.158.156.122])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20c8c212e9csm36106715ad.188.2024.10.12.04.48.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Oct 2024 04:48:15 -0700 (PDT)
Date: Sat, 12 Oct 2024 17:18:10 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Rob Herring <robh@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Jingoo Han <jingoohan1@gmail.com>, linux-pci@vger.kernel.org,
	Rick Wertenbroek <rick.wertenbroek@gmail.com>,
	Niklas Cassel <cassel@kernel.org>
Subject: Re: [PATCH v6 4/6] PCI: endpoint: Update documentation
Message-ID: <20241012114810.kd2ws7sqfis22syh@thinkpad>
References: <20241012113246.95634-1-dlemoal@kernel.org>
 <20241012113246.95634-5-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241012113246.95634-5-dlemoal@kernel.org>

On Sat, Oct 12, 2024 at 08:32:44PM +0900, Damien Le Moal wrote:
> Document the new functions pci_epc_mem_map() and pci_epc_mem_unmap().
> Also add the documentation for the functions pci_epc_map_addr() and
> pci_epc_unmap_addr() that were missing.
> 
> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> Reviewed-by: Niklas Cassel <cassel@kernel.org>
> ---
>  Documentation/PCI/endpoint/pci-endpoint.rst | 29 +++++++++++++++++++++
>  1 file changed, 29 insertions(+)
> 
> diff --git a/Documentation/PCI/endpoint/pci-endpoint.rst b/Documentation/PCI/endpoint/pci-endpoint.rst
> index 21507e3cc238..35f82f2d45f5 100644
> --- a/Documentation/PCI/endpoint/pci-endpoint.rst
> +++ b/Documentation/PCI/endpoint/pci-endpoint.rst
> @@ -117,6 +117,35 @@ by the PCI endpoint function driver.
>     The PCI endpoint function driver should use pci_epc_mem_free_addr() to
>     free the memory space allocated using pci_epc_mem_alloc_addr().
>  
> +* pci_epc_map_addr()
> +
> +  A PCI endpoint function driver should use pci_epc_map_addr() to map to a RC
> +  PCI address the CPU address of local memory obtained with
> +  pci_epc_mem_alloc_addr().
> +
> +* pci_epc_unmap_addr()
> +
> +  A PCI endpoint function driver should use pci_epc_unmap_addr() to unmap the
> +  CPU address of local memory mapped to a RC address with pci_epc_map_addr().
> +
> +* pci_epc_mem_map()
> +
> +  A PCI endpoint controller may impose constraints on the RC PCI addresses that
> +  can be mapped. The function pci_epc_mem_map() allows endpoint function
> +  drivers to allocate and map controller memory while handling such
> +  constraints. This function will determine the size of the memory that must be
> +  allocated with pci_epc_mem_alloc_addr() for successfully mapping a RC PCI
> +  address range. This function will also indicate the size of the PCI address
> +  range that was actually mapped, which can be less than the requested size, as
> +  well as the offset into the allocated memory to use for accessing the mapped
> +  RC PCI address range.
> +
> +* pci_epc_mem_unmap()
> +
> +  A PCI endpoint function driver can use pci_epc_mem_unmap() to unmap and free
> +  controller memory that was allocated and mapped using pci_epc_mem_map().
> +
> +
>  Other EPC APIs
>  ~~~~~~~~~~~~~~
>  
> -- 
> 2.47.0
> 

-- 
மணிவண்ணன் சதாசிவம்

