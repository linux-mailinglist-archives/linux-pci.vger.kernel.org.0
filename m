Return-Path: <linux-pci+bounces-22101-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4031A40990
	for <lists+linux-pci@lfdr.de>; Sat, 22 Feb 2025 16:50:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA26B179529
	for <lists+linux-pci@lfdr.de>; Sat, 22 Feb 2025 15:50:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1977B1B2182;
	Sat, 22 Feb 2025 15:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gFJ0jk6X"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 650C369D2B
	for <linux-pci@vger.kernel.org>; Sat, 22 Feb 2025 15:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740239413; cv=none; b=cx9+LjG4Qnt6LzcHXmG3JaIJtHkym7UMtNUwOjRWNfrnei+aN+lknt+XOjLj8d0L4CwWGa5CfQmBDTCnhgyglQx9LBduSMFyCrFdD+s24gEMIIzgfnLhd/is2FQKxP2JvdubSU7eNJDLR3wI/r7ypO8eD37ahi5NIYim1AOup8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740239413; c=relaxed/simple;
	bh=1hpeWZysEpnbmv/Qa+kUHIvswI0haie2WS/olaDd6fw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mXHbb6hA6YMFZxEzrvMyAYjsGxQgqVjeHfMnStkBUhmB+At8xsw/+IBYXj4ZFy9YOjVNdc3kTK8GZeQQfqxzqtClgUttpHZMR6N3FvZG3pRT/o4U65US8wBbqES4ktGRLBx6XhG4IbX9fzMoOLqk7KM/YfWX+QiWTY9lGHLf6vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gFJ0jk6X; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-21c2f1b610dso89297585ad.0
        for <linux-pci@vger.kernel.org>; Sat, 22 Feb 2025 07:50:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740239409; x=1740844209; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=vJ3wqK4igQCOC0XiRx/DV/Z8Rz76i6tDy5rb8z4/PkI=;
        b=gFJ0jk6XUeVPm6bKehULwu22+f8Q7HWPBrnDnM+FPeHWdV7c3qQ/AFUlAQJwYCaZNN
         FWKfRwYXTE6yl+wESjsOgTUa7w+n4U4qugq8/rD0dFpWCQAwmwq8hOuCQiU/aifbM/JK
         SqKiIbRwhqk//zBI9s9Fank1DE9GuIpda9EOlp/nq5rc+x0O2Il3pKLEC+o0QD2/QGWF
         3PCWKwic1jOvL95AieqLzTH2cX7dzQV2iUQpctbcG3U1pXD+2Shz2hv9qUxqaUPMCm7W
         D895B0ialIN+KaLLOq2F9BwCsAw4+w5Pu8rFht8GZWelWkNrO7L6/IW0sokCMX5N3jSz
         fPsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740239409; x=1740844209;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vJ3wqK4igQCOC0XiRx/DV/Z8Rz76i6tDy5rb8z4/PkI=;
        b=McB+dqz00SPb+uG5j3Hw5NksjG2yIFlOac6MqkA9IVBqBgRX8C6JCVPnQzKj+TLzGP
         jDBc1WnZHlTu2dT/E9hhwWld2na1b0RbpfGGiDMFh5Ru3Vy6K3BfWNIOns6XfmGkEmcR
         v8eWdjI110Lmtht/upbon2DMXRVejlKEAJvXErsDXamu7k6An7gI+61RTMvOjwILyQld
         xcgvaFig5NAtxuojwGrkGtZ45YKOqeI3kZuFrVydUMLYpU4eJNSqH4BBZvDx8vEJpA9a
         rJZUjhI2O8shj0u7mPzZuayd+6p6GwGpfy70RTW5G1uoIcMrhK7BhXY518c/Q1EKV5Nr
         hPEg==
X-Forwarded-Encrypted: i=1; AJvYcCXpYNZ2CJgxVcirJBd9WYt1hpi7mvjIgKRcwtQ+bd8rrWSZdjmB7WDaWqel6A/C5gTdfVEBFAhbkh0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKAWS+8pTRVJ4mtzhlLnow7vZ2nu7sdT6Edo78kd79B2wHW/xa
	xRHxDtXXX3I2G4eJAiFtUSzG2KV/F9TeO7wpX/ZjQG5En8fxkaGYFOYoy/UCBw==
X-Gm-Gg: ASbGncs8ibRi/cT4ykxvzKcYf7ixF2S2qYtBL2Bv6rrK4dTedL3uYkZQIfQb4vUWbmq
	R0Z58NU6HD+xZaZCDAkMO12/J8L0xHcZYRc26lkA/UbGdeS+wLsjQZhxirhCCkfnQbZ2oRY7KUQ
	wqCPkAaPVUZKzc/a1ia9oP4cPZthQNiooyKPdHGgIeGTv2zVmqDWVXyWQRs1hyDuLMoPntQkcrU
	6c39l+G/zywzG+gz574cdTBCgB+Q4uTxZGYB//EDQAQICDPjxMRb9kt0rcpUhR9NGmHT0SvKKu0
	JsDUPVmrBu1JQfs0WDPjrEmUN2ugvFWCmnKbqQ==
X-Google-Smtp-Source: AGHT+IEJQ2V/GwDSolR7/AIWwxX1kGsMIADbNySqjquMv9M9JtoGte9bIrz19Lg5BA/rFwDl48i32Q==
X-Received: by 2002:a05:6a00:4b4f:b0:732:622f:ec39 with SMTP id d2e1a72fcca58-73426c7c77cmr10283282b3a.1.1740239409596;
        Sat, 22 Feb 2025 07:50:09 -0800 (PST)
Received: from thinkpad ([120.60.135.149])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7324273e30dsm18021060b3a.99.2025.02.22.07.50.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Feb 2025 07:50:09 -0800 (PST)
Date: Sat, 22 Feb 2025 21:20:02 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Niklas Cassel <cassel@kernel.org>
Cc: Jingoo Han <jingoohan1@gmail.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Shawn Lin <shawn.lin@rock-chips.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH 1/2] PCI: dwc: ep: Remove superfluous function
 dw_pcie_ep_find_ext_capability()
Message-ID: <20250222155002.lnig57ku6treeznz@thinkpad>
References: <20250221202646.395252-3-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250221202646.395252-3-cassel@kernel.org>

On Fri, Feb 21, 2025 at 09:26:47PM +0100, Niklas Cassel wrote:
> Remove the superfluous function dw_pcie_ep_find_ext_capability(), as it is
> virtually identical to dw_pcie_find_ext_capability().
> 
> Signed-off-by: Niklas Cassel <cassel@kernel.org>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> ---
>  .../pci/controller/dwc/pcie-designware-ep.c   | 24 +++----------------
>  1 file changed, 3 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
> index f9d7f3f989ad..20f2436c7091 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-ep.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
> @@ -102,24 +102,6 @@ static u8 dw_pcie_ep_find_capability(struct dw_pcie_ep *ep, u8 func_no, u8 cap)
>  	return __dw_pcie_ep_find_next_cap(ep, func_no, next_cap_ptr, cap);
>  }
>  
> -static unsigned int dw_pcie_ep_find_ext_capability(struct dw_pcie *pci, int cap)
> -{
> -	u32 header;
> -	int pos = PCI_CFG_SPACE_SIZE;
> -
> -	while (pos) {
> -		header = dw_pcie_readl_dbi(pci, pos);
> -		if (PCI_EXT_CAP_ID(header) == cap)
> -			return pos;
> -
> -		pos = PCI_EXT_CAP_NEXT(header);
> -		if (!pos)
> -			break;
> -	}
> -
> -	return 0;
> -}
> -
>  static int dw_pcie_ep_write_header(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
>  				   struct pci_epf_header *hdr)
>  {
> @@ -230,7 +212,7 @@ static unsigned int dw_pcie_ep_get_rebar_offset(struct dw_pcie *pci,
>  	unsigned int offset, nbars;
>  	int i;
>  
> -	offset = dw_pcie_ep_find_ext_capability(pci, PCI_EXT_CAP_ID_REBAR);
> +	offset = dw_pcie_find_ext_capability(pci, PCI_EXT_CAP_ID_REBAR);
>  	if (!offset)
>  		return offset;
>  
> @@ -847,7 +829,7 @@ static void dw_pcie_ep_init_non_sticky_registers(struct dw_pcie *pci)
>  	enum pci_barno bar;
>  	u32 reg, i, val;
>  
> -	offset = dw_pcie_ep_find_ext_capability(pci, PCI_EXT_CAP_ID_REBAR);
> +	offset = dw_pcie_find_ext_capability(pci, PCI_EXT_CAP_ID_REBAR);
>  
>  	dw_pcie_dbi_ro_wr_en(pci);
>  
> @@ -970,7 +952,7 @@ int dw_pcie_ep_init_registers(struct dw_pcie_ep *ep)
>  	if (ep->ops->init)
>  		ep->ops->init(ep);
>  
> -	ptm_cap_base = dw_pcie_ep_find_ext_capability(pci, PCI_EXT_CAP_ID_PTM);
> +	ptm_cap_base = dw_pcie_find_ext_capability(pci, PCI_EXT_CAP_ID_PTM);
>  
>  	/*
>  	 * PTM responder capability can be disabled only after disabling
> -- 
> 2.48.1
> 

-- 
மணிவண்ணன் சதாசிவம்

