Return-Path: <linux-pci+bounces-14671-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C571D9A103A
	for <lists+linux-pci@lfdr.de>; Wed, 16 Oct 2024 18:59:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0DC27B23076
	for <lists+linux-pci@lfdr.de>; Wed, 16 Oct 2024 16:59:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C24620C031;
	Wed, 16 Oct 2024 16:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oXT/DaDL"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BE0E21262A
	for <linux-pci@vger.kernel.org>; Wed, 16 Oct 2024 16:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729097977; cv=none; b=OoOTd2EzzFoYuVancG7GwSJ8nEQgRqciXQoKOfzYrI2rd54QuJCk+0Z7g5CSeiunG8dFt5V6fHSJGHnlRnQzMsCWn4KjDhOWIIQbvuG2Y9cn86VModuaxTh6ZzLzU9zwi2jXBV1UnvVJr24dqmKnx+ytBTQE+l/Sgwf8Ohhcamc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729097977; c=relaxed/simple;
	bh=AKcige/JQY8TGrt3Mfed7RIT5Ww9iXLZUi4P87zoswA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MlsSowS3KgqLu+IEHURaojK/zXgOfgEQRGlRLHf8QxSL3MGdrNZt7Z6h+u9TGYi7YVcfVg+735/xWjU9ibqQamGZyjW3ye0rm82/L7wY1zD9gwy9lY5/mNz0IcXtHzycBWBi1CRYRtfDhq7X2G5U1WAK+YyA+tsxpgC+xYBFZO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=oXT/DaDL; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-71e579abb99so2974314b3a.2
        for <linux-pci@vger.kernel.org>; Wed, 16 Oct 2024 09:59:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729097976; x=1729702776; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9/LZ3Zn5XyWr1MU4satRczAmPXhQsZyogJP/83WgHT0=;
        b=oXT/DaDLQTbdKyHehYvrgr5lNmm80tdurum8fRszf+slNjN34EEopOcCii/pRKOjV4
         9yvFPTW5ZHCGu8Zw08wfFED9n+fPrdmbOQCQZfbAHb6sXKRw7UmEr/ybTuqNIJ5C0ujX
         zkAUBV6DYZA/5WVc719typ7pZXzTM9GRM18uPxSxsaL0sK+zri0lw1N5wxK9RHxigvlR
         rfI9IJx9w6/Wms2WgLkEMFYrmGop+kGWn/nrsHXittwCYbqZPcgI8j+5gLKUcnWNP071
         5+M/2cnwar8M4bF2HjFLXE7yuue4Yq0Y7ROeWx8/3QM8UXLcfjR4l5hY8yvXCavmnMnK
         FWoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729097976; x=1729702776;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9/LZ3Zn5XyWr1MU4satRczAmPXhQsZyogJP/83WgHT0=;
        b=Ms+jKADKVO35p+6r4bc2juJ23/alQIhqi85Q7vgIf1Dyj7k/yTsu8oUG/T42lL+Eb5
         EEG86wD+781GlTXxT9SZQdianTEsElWp92kA69Z5HwVsVsi7w4zpEToGyMR1R4rqq+yP
         30oim9tTho0CWewj7+OxLvb7RbS6MMSw7vmOdwooUbT0X6euAHPCfcCKb2X4GICk36Hh
         /htBgkMyqi+7Qjqrh5BDjZaHEcvBE8cZY43oK3dgZT7+lwZ6w5x6p6lthRTXy0DCwRfE
         TBcLDJ224SmXBIr74bwihRGx6tLiZOD1n02W+E7UtAnKo7QMKJwAczc2nudrHqOqPmIG
         gIcQ==
X-Forwarded-Encrypted: i=1; AJvYcCWVe0cqEXkK7IEe4EyCM1d39AQiMSo8CkgdZCoF5TpjXzL7SJhuT0mN5vtQ7WCwvkNL2snae5F8a64=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlWZPiMfVejuLT6Xl3Sg+my7I0X9+MbGHPKpzqh0RNKcY/q0Fo
	8gYew2yQofYqFr4m6u73iBJjVpjkUNdEhjAzop4O3nNdN6gwrRh8j/FqQMrFig==
X-Google-Smtp-Source: AGHT+IGaLAtQabvUDeO+3j2Q4gvgcJ2hoUUgUTrT6qVHDMC5UbCskjCgqs3pgV7Ua73JvBhNlF8VNg==
X-Received: by 2002:a05:6a00:b86:b0:71e:6ef2:6c11 with SMTP id d2e1a72fcca58-71e7da266c8mr7276457b3a.9.1729097975775;
        Wed, 16 Oct 2024 09:59:35 -0700 (PDT)
Received: from thinkpad ([220.158.156.88])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71e773a2fbbsm3318397b3a.69.2024.10.16.09.59.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2024 09:59:35 -0700 (PDT)
Date: Wed, 16 Oct 2024 22:29:30 +0530
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
Subject: Re: [PATCH v2] PCI: endpoint: Improve pci_epc_ops::align_addr()
 interface
Message-ID: <20241016165930.djlddcgx7uhrpowd@thinkpad>
References: <20241015090712.112674-1-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241015090712.112674-1-dlemoal@kernel.org>

On Tue, Oct 15, 2024 at 06:07:12PM +0900, Damien Le Moal wrote:
> The PCI endpoint controller operation interface for the align_addr()
> operation uses the phys_addr_t type for the PCI address argument and
> return a value using this type. This is not ideal as PCI addresses are
> bus addresses, not regular memory physical addresses. Replace the use of
> phys_addr_t for this operation with the generic u64 type. To be
> consistent with this change the Designware driver implementation of this
> operation (function dw_pcie_ep_align_addr()) as well as the type of PCI
> address fields of struct pci_epc_map are also changed.
> 
> Fixes: e98c99e2ccad ("PCI: endpoint: Introduce pci_epc_mem_map()/unmap()")
> Fixes: cb6b7158fdf5 ("PCI: dwc: endpoint: Implement the pci_epc_ops::align_addr() operation")
> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>

I thought of applying it, but then decided to squash it with the offending
patches.

- Mani

> ---
> Changes from v1:
>  - Also updated the type of the pci_addr and map_pci_addr fields of
>    struct pci_epc_map.
> 
>  drivers/pci/controller/dwc/pcie-designware-ep.c | 6 +++---
>  include/linux/pci-epc.h                         | 8 ++++----
>  2 files changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
> index 0ada60487c25..df1460ed63d9 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-ep.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
> @@ -268,12 +268,12 @@ static int dw_pcie_find_index(struct dw_pcie_ep *ep, phys_addr_t addr,
>  	return -EINVAL;
>  }
>  
> -static phys_addr_t dw_pcie_ep_align_addr(struct pci_epc *epc,
> -			phys_addr_t pci_addr, size_t *pci_size, size_t *offset)
> +static u64 dw_pcie_ep_align_addr(struct pci_epc *epc, u64 pci_addr,
> +				 size_t *pci_size, size_t *offset)
>  {
>  	struct dw_pcie_ep *ep = epc_get_drvdata(epc);
>  	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
> -	phys_addr_t mask = pci->region_align - 1;
> +	u64 mask = pci->region_align - 1;
>  	size_t ofst = pci_addr & mask;
>  
>  	*pci_size = ALIGN(ofst + *pci_size, ep->page_size);
> diff --git a/include/linux/pci-epc.h b/include/linux/pci-epc.h
> index f4b8dc37e447..de8cc3658220 100644
> --- a/include/linux/pci-epc.h
> +++ b/include/linux/pci-epc.h
> @@ -49,10 +49,10 @@ pci_epc_interface_string(enum pci_epc_interface_type type)
>   * @virt_addr: virtual address at which @pci_addr is mapped
>   */
>  struct pci_epc_map {
> -	phys_addr_t	pci_addr;
> +	u64		pci_addr;
>  	size_t		pci_size;
>  
> -	phys_addr_t	map_pci_addr;
> +	u64		map_pci_addr;
>  	size_t		map_size;
>  
>  	phys_addr_t	phys_base;
> @@ -93,8 +93,8 @@ struct pci_epc_ops {
>  			   struct pci_epf_bar *epf_bar);
>  	void	(*clear_bar)(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
>  			     struct pci_epf_bar *epf_bar);
> -	phys_addr_t (*align_addr)(struct pci_epc *epc, phys_addr_t pci_addr,
> -				  size_t *size, size_t *offset);
> +	u64	(*align_addr)(struct pci_epc *epc, u64 pci_addr, size_t *size,
> +			      size_t *offset);
>  	int	(*map_addr)(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
>  			    phys_addr_t addr, u64 pci_addr, size_t size);
>  	void	(*unmap_addr)(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
> -- 
> 2.47.0
> 

-- 
மணிவண்ணன் சதாசிவம்

