Return-Path: <linux-pci+bounces-28848-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 808BCACC35B
	for <lists+linux-pci@lfdr.de>; Tue,  3 Jun 2025 11:42:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9AE23A3D21
	for <lists+linux-pci@lfdr.de>; Tue,  3 Jun 2025 09:42:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E7872820AB;
	Tue,  3 Jun 2025 09:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BR841ixi"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BE4F27FD7A;
	Tue,  3 Jun 2025 09:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748943763; cv=none; b=gR3amBfStcsP+wf8jg2mz8Udyzjbars1+O1JRJkzn3uPKT9+S1Tz409tSJtWCrAf02kZ21r0ibCfxu6xzRnwngOW01mBlu53s8fZ/FZWEHIt2SHYtftmD6zEzaFEcJh4s/Jl98MlGe5z/B/wwd8P6FwyjVFPy3oG1zRBXVM0HP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748943763; c=relaxed/simple;
	bh=kcKdMQutOEKgdmq7s01p3u7WAiPjAfl0BL1BiOFHomo=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=IgRPJFayT25LL96qiEFstiUE3Vxu6xJrn8oS1/pjeJJ4BtVtxQCzkjEz6x+iQGrYjklTyNEPcpkibpPOycDkaHcKGEBFcZbsDTT+TglOW64gqrLEuHnyVI4ehZaXjed6ztDXj7VtJ0+S7NnQXJSzeys014sEp1XOrZs0FTmC0nE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BR841ixi; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748943762; x=1780479762;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=kcKdMQutOEKgdmq7s01p3u7WAiPjAfl0BL1BiOFHomo=;
  b=BR841ixisZ7jvhFZ2n7+dHj8sOyvdTOnapxMVEI+u5jXiMRbqCj+xcV7
   A+jby5rLo4zquTzHFAPXOj9XCIuTkSK/dO3fovoOTfrBE14Vesh5gOJ5s
   uv5ewBMzxPJyzG39dt9eBR5zSkHh9SDQG0moF43/RqyKOh7lwEIEb+jtw
   O/ZNakXuXPd6G/Th/de+M0tM08DfC6//Jjcxea0R7GKNAfhP5qxkZgUhE
   7Wx/NcA7vmxOtMngiqAY4kbIIzY58xX4QW8D/ugMnW4B3de5ouU58T+ZD
   tfA09lf4eNNX74LnWLwsEZ3UEjOA6RhX+8dszM+uih15yLUjp+H/ehvz7
   w==;
X-CSE-ConnectionGUID: C/rIUyQzQDKu18FGHwli9A==
X-CSE-MsgGUID: Ms3707WsQi+dHPauflmfjg==
X-IronPort-AV: E=McAfee;i="6700,10204,11451"; a="50893338"
X-IronPort-AV: E=Sophos;i="6.16,205,1744095600"; 
   d="scan'208";a="50893338"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2025 02:42:41 -0700
X-CSE-ConnectionGUID: +ZfSINAUTeWbfXcmTHC2wg==
X-CSE-MsgGUID: 2RPOSoCgS3mDxMKlAqjW6w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,205,1744095600"; 
   d="scan'208";a="167988022"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.141])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2025 02:42:36 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 3 Jun 2025 12:42:33 +0300 (EEST)
To: Hans Zhang <18255117159@163.com>
cc: lpieralisi@kernel.org, bhelgaas@google.com, 
    manivannan.sadhasivam@linaro.org, kw@linux.com, cassel@kernel.org, 
    robh@kernel.org, jingoohan1@gmail.com, linux-pci@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v12 4/6] PCI: dwc: Use common PCI host bridge APIs for
 finding the capabilities
In-Reply-To: <20250514161258.93844-5-18255117159@163.com>
Message-ID: <4f23df8e-bebe-149c-a638-be7208c8c71a@linux.intel.com>
References: <20250514161258.93844-1-18255117159@163.com> <20250514161258.93844-5-18255117159@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Thu, 15 May 2025, Hans Zhang wrote:

> Use the PCI core is now exposing generic macros for the host bridges to
> search for the PCIe capabilities, make use of them in the DWC driver.
> 
> Signed-off-by: Hans Zhang <18255117159@163.com>
> ---
> Changes since v11:
> - Resolve compilation errors. s/dw_pcie_read_dbi/dw_pcie_read*_dbi
> 
> Changes since v10:
> - None
> 
> Changes since v9:
> - Resolved [v9 4/6] compilation error.
>   The latest 6.15 rc1 merge __dw_pcie_find_vsec_capability, which uses 
>   dw_pcie_find_next_ext_capability.
> 
> Changes since v8:
> - None
> 
> Changes since v7:
> - Resolve compilation errors.
> 
> Changes since v6:
> https://lore.kernel.org/linux-pci/20250323164852.430546-3-18255117159@163.com/
> 
> - The patch commit message were modified.
> 
> Changes since v5:
> https://lore.kernel.org/linux-pci/20250321163803.391056-3-18255117159@163.com/
> 
> - Kconfig add "select PCI_HOST_HELPERS"
> ---
>  drivers/pci/controller/dwc/pcie-designware.c | 81 ++++----------------
>  1 file changed, 14 insertions(+), 67 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
> index 97d76d3dc066..7939411a24eb 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.c
> +++ b/drivers/pci/controller/dwc/pcie-designware.c
> @@ -205,83 +205,30 @@ void dw_pcie_version_detect(struct dw_pcie *pci)
>  		pci->type = ver;
>  }
>  
> -/*
> - * These interfaces resemble the pci_find_*capability() interfaces, but these
> - * are for configuring host controllers, which are bridges *to* PCI devices but
> - * are not PCI devices themselves.
> - */
> -static u8 __dw_pcie_find_next_cap(struct dw_pcie *pci, u8 cap_ptr,
> -				  u8 cap)
> +static int dw_pcie_read_cfg(void *priv, int where, int size, u32 *val)
>  {
> -	u8 cap_id, next_cap_ptr;
> -	u16 reg;
> -
> -	if (!cap_ptr)
> -		return 0;
> +	struct dw_pcie *pci = priv;
>  
> -	reg = dw_pcie_readw_dbi(pci, cap_ptr);
> -	cap_id = (reg & 0x00ff);
> -
> -	if (cap_id > PCI_CAP_ID_MAX)
> -		return 0;
> -
> -	if (cap_id == cap)
> -		return cap_ptr;
> +	if (size == 4)
> +		*val = dw_pcie_readl_dbi(pci, where);
> +	else if (size == 2)
> +		*val = dw_pcie_readw_dbi(pci, where);
> +	else if (size == 1)
> +		*val = dw_pcie_readb_dbi(pci, where);

Maybe here as well return error if the given size is invalid.
>  
> -	next_cap_ptr = (reg & 0xff00) >> 8;
> -	return __dw_pcie_find_next_cap(pci, next_cap_ptr, cap);
> +	return PCIBIOS_SUCCESSFUL;
>  }
>  
>  u8 dw_pcie_find_capability(struct dw_pcie *pci, u8 cap)
>  {
> -	u8 next_cap_ptr;
> -	u16 reg;
> -
> -	reg = dw_pcie_readw_dbi(pci, PCI_CAPABILITY_LIST);
> -	next_cap_ptr = (reg & 0x00ff);
> -
> -	return __dw_pcie_find_next_cap(pci, next_cap_ptr, cap);
> +	return PCI_FIND_NEXT_CAP_TTL(dw_pcie_read_cfg, PCI_CAPABILITY_LIST, cap,
> +				     pci);
>  }
>  EXPORT_SYMBOL_GPL(dw_pcie_find_capability);
>  
> -static u16 dw_pcie_find_next_ext_capability(struct dw_pcie *pci, u16 start,
> -					    u8 cap)
> -{
> -	u32 header;
> -	int ttl;
> -	int pos = PCI_CFG_SPACE_SIZE;
> -
> -	/* minimum 8 bytes per capability */
> -	ttl = (PCI_CFG_SPACE_EXP_SIZE - PCI_CFG_SPACE_SIZE) / 8;
> -
> -	if (start)
> -		pos = start;
> -
> -	header = dw_pcie_readl_dbi(pci, pos);
> -	/*
> -	 * If we have no capabilities, this is indicated by cap ID,
> -	 * cap version and next pointer all being 0.
> -	 */
> -	if (header == 0)
> -		return 0;
> -
> -	while (ttl-- > 0) {
> -		if (PCI_EXT_CAP_ID(header) == cap && pos != start)
> -			return pos;
> -
> -		pos = PCI_EXT_CAP_NEXT(header);
> -		if (pos < PCI_CFG_SPACE_SIZE)
> -			break;
> -
> -		header = dw_pcie_readl_dbi(pci, pos);
> -	}
> -
> -	return 0;
> -}
> -
>  u16 dw_pcie_find_ext_capability(struct dw_pcie *pci, u8 cap)
>  {
> -	return dw_pcie_find_next_ext_capability(pci, 0, cap);
> +	return PCI_FIND_NEXT_EXT_CAPABILITY(dw_pcie_read_cfg, 0, cap, pci);
>  }
>  EXPORT_SYMBOL_GPL(dw_pcie_find_ext_capability);
>  
> @@ -294,8 +241,8 @@ static u16 __dw_pcie_find_vsec_capability(struct dw_pcie *pci, u16 vendor_id,
>  	if (vendor_id != dw_pcie_readw_dbi(pci, PCI_VENDOR_ID))
>  		return 0;
>  
> -	while ((vsec = dw_pcie_find_next_ext_capability(pci, vsec,
> -						       PCI_EXT_CAP_ID_VNDR))) {
> +	while ((vsec = PCI_FIND_NEXT_EXT_CAPABILITY(
> +			dw_pcie_read_cfg, vsec, PCI_EXT_CAP_ID_VNDR, pci))) {

Start the arguments from the first line and align the continuations to (.

>  		header = dw_pcie_readl_dbi(pci, vsec + PCI_VNDR_HEADER);
>  		if (PCI_VNDR_HEADER_ID(header) == vsec_id)
>  			return vsec;
> 

-- 
 i.


