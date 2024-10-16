Return-Path: <linux-pci+bounces-14667-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F79F9A0FBF
	for <lists+linux-pci@lfdr.de>; Wed, 16 Oct 2024 18:31:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 57E081C22F16
	for <lists+linux-pci@lfdr.de>; Wed, 16 Oct 2024 16:31:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 916C020FAA1;
	Wed, 16 Oct 2024 16:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="F1mo07G8"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC22D15E5CA
	for <linux-pci@vger.kernel.org>; Wed, 16 Oct 2024 16:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729096257; cv=none; b=N+Do2f6T0q2qLFemkv49fDpBxkolzH1RPKUM1wVMcKYBoetYZUpbcwyzMKDLJ2fX1gAi1Y6uXK53N4tQgsMBBeEdJmUhQS6uzIQdCmzH/8szWpRyT9o74TdkLta5GKU2uGRPsa6udK75FpbFQXzdyklXrEKMfwwzsyBP/zlJGtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729096257; c=relaxed/simple;
	bh=MKAnr/2Q82ZADLI5hHxGhkQxcOf9u0POgMfK0Uvq9Rc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qerwOoVQzt6mOTqGoWePOBV0X8mkEub5aYhp8yjrtDPYQWMNOxzhUaY4CM2ySoQGV+EAbKj+Fm+rJxblsmpB8nVwoFnqbgaEGCDgct4wd1u9dI6v1Kt3y8sjRQBhZ5M/M/9OiwIkkz76095PQyLOPAD2ruPvb9mrxYB6bDp3yi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=F1mo07G8; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-20ce65c8e13so31106125ad.1
        for <linux-pci@vger.kernel.org>; Wed, 16 Oct 2024 09:30:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729096255; x=1729701055; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=w1JpalZao1FAiSnNYqqR1QlbTh/p7BhdQfpV1CtBo4Y=;
        b=F1mo07G8Y5NctqiNoK03GEj/Os2tfgAJOhD9t8aqqFrau8V8KP/xRuIhYcGrv0THKu
         xnJ2Mny+U3zThp82oVmm/KSjrfS85kDehE6zCSDQLGOI+vpJCtiLWfn6cf8oCdFL6GRA
         7ckvjska+8ceIc91xEWS7QPK206+AKOVfyJlYp5S+uuKe5Sgq/cTgxnvFGYcOCRK1Q6t
         hO8yycRBEMQCkvwcZ+NrX9vTDXWkqg/h6II+RZVZe+9iKob84pvAK1L3cn1yi+5E35vJ
         MwgLyAWmMOOjWi9REsUFl6svx7znwmxYa8FQ6blpRH19TFTwrS2OfVlHzfOpgQjSJiiU
         F5yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729096255; x=1729701055;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=w1JpalZao1FAiSnNYqqR1QlbTh/p7BhdQfpV1CtBo4Y=;
        b=TvcUf/SBAVBZFDnvDVvBt7DfhSKrL6C4IbC13W++vy4ExjV54GcRvet5vLCaNazgGk
         HhaJpgicGHt17uegg65BNd8fa9d+ZNqcSdZyKZiF48E+ZHEc/ncr2GhGplRln3VKn1TD
         xWikXWQjISIkU7VY3bFUeCvyJvm5oVa+tFELvvLQKm7NpA/ZkZ3g5mgefYZvCqhg1jjj
         QfZEcJLDagSIABXEY+Ur/NFf0hYY5imcvHzcMOvF4Og2e4tjnfymENVHPm7H7rY/at5z
         TC8P3ndQZak9Der9dWt475pOxbUy1xsII4A3gAkqZy60BP5HakVNheJS+AJmrsULDEEr
         FrWw==
X-Forwarded-Encrypted: i=1; AJvYcCUIb901uJ81YfxjP+HUyRNpWooDen6D7xR6y0YYkSA8SY4kDnuIyhngd4thjLKuzT3OG5Vlpxqitgk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHy+wwMI1Vtic8LaCXyzimhJ7pqzi+aFwPcmB2yUujNuCOoagz
	TDgewUSK8p1S+fTf99AGrHK2+ZYXwnOujS5pUCiTj73oVnUh1TkIUgzwR9T0NQ==
X-Google-Smtp-Source: AGHT+IGHK4ewRGobVVHCTks84umbiO17JsQQk8+zWB1eVe+KrP7G4LzPkVQBP5GzFcrDWJytbCLOMA==
X-Received: by 2002:a17:902:d552:b0:20b:7ed8:3978 with SMTP id d9443c01a7336-20ca147e967mr276086305ad.26.1729096253566;
        Wed, 16 Oct 2024 09:30:53 -0700 (PDT)
Received: from thinkpad ([220.158.156.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20d18060da5sm30566075ad.287.2024.10.16.09.30.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2024 09:30:52 -0700 (PDT)
Date: Wed, 16 Oct 2024 22:00:46 +0530
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
Message-ID: <20241016163046.ctkz2dmc6ebi46ty@thinkpad>
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

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

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

