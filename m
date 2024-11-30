Return-Path: <linux-pci+bounces-17489-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 666D09DEF4F
	for <lists+linux-pci@lfdr.de>; Sat, 30 Nov 2024 09:23:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2607328191D
	for <lists+linux-pci@lfdr.de>; Sat, 30 Nov 2024 08:23:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E1D72FC52;
	Sat, 30 Nov 2024 08:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="t/UjA+fm"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12F67139D05
	for <linux-pci@vger.kernel.org>; Sat, 30 Nov 2024 08:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732954998; cv=none; b=qWzAG0IJ19RjBVTbJMwK1VL6vCjgKrexxeaOti4oLH9W7z+fGb3KcnLV3EgsHoF6kqQDfWBZXuRmNFUuQFkeA8ki3x7gj6kMEuoZZ/r7PJAucNwt5DO4yhfWlEBTb4L0HAd89X/mCEBFfdyj1X67u/O+V4uEcH4EJ9GNQ4ZiFqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732954998; c=relaxed/simple;
	bh=ByrR8tIF411nep0B5oVqaD2d798WvXZ1DGKPUssEvM4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h5HZ51n3bv3/sLAIK1RXd39doXY1MgSdTcQyL1v///JSnWOO6gILJ9Cti7UFGgddfn1Jc4IKw9aebwWDZXgruZYl1keiLgpCJjy7qljvc8q6jnge6wMTm6DcVEt5/XBBH/4S9iS7Iw4ioI1RW1z42eHpR503Bg2rK7J1lhJion4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=t/UjA+fm; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-724fee568aaso2521834b3a.1
        for <linux-pci@vger.kernel.org>; Sat, 30 Nov 2024 00:23:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732954995; x=1733559795; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Ey9mK2QYcDtPPCKwbACtibTYlsE29O14SbX2DFECs0A=;
        b=t/UjA+fmy+MIwqa5sdxf64uRV+K4RY/hu6PCH7zEMAlm8LGXvoM4+qBoEXYVYjf8Yd
         kyFP2jNFz/mWV2LMqi6g3tROItam0PCpSxhNUyLawoNmzEtfiVRF4k0vIDhMToJug7+g
         HDILaVsF9/4HrTgFRMFraweM55a3jWSFrvWNYVYI9ZIwdttqupixF4enU2IBPJjmlhBS
         Zrzn7tuoBEuBj8oFPflLKiiMjUz/pf5yx8+v+ZVMiLT8WdREJu9LpHNaxQj0yaN3ln97
         fqLfHZgEcalNXqMlOi+kN88/2tFr2TLDGBu+U8lQAbPCnMKOkzR/k1cdvepiYwLBGHYn
         ztMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732954995; x=1733559795;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ey9mK2QYcDtPPCKwbACtibTYlsE29O14SbX2DFECs0A=;
        b=gS6OnoaoglYydvKKNPWVHfm5KUad65UXBEu+tT8a72wM/KIK6u7r3F+GLJN+z8nu/k
         Lfvz4KR5T2bj4uJCO83NceGSqmrpoiDQwkgymSzssb6wP7l/mb83T5owMlJcIU3hT0Vl
         TVoCCxKmUs+7aJlXwVhFGQkGVpNsXwc3bUbtRcyUGwAcyXHZsxMuKYjn/U+0ai/XPyuS
         LL3SftdpzlaQry+Lbl7G7vPmQrNvk1RarG+MNrCMTjx7DPbJkF+XXjw+O68FCVutBCep
         iNMGqI+VBQIqsXD/oFyJuHi2xGC/ni+fBBfdQ5+Sl0JR70MAK1zjq/XgWtPW+jKdBJJT
         /BwA==
X-Forwarded-Encrypted: i=1; AJvYcCWi8eWezNBaAGW/xjIoPR0BitrPtDUYIAIshKZMFlvfOHiuq4bK8WXdyaZnOayUS1vowU6KXUnRAuU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBAx6XJOwTCcqYivyHLjz5C42MNy3BrOysGdBuZ7GME3z8TpHE
	c7It+C/OZeNBgw/4Upj1KmDLGZclG+XfuF8oPtew0rMcSS4v6rJnPbnlWa+kJQ==
X-Gm-Gg: ASbGnct6Zxl3cBqc5k/sImECzuQE2EOzfJhywftLEgGmlzyzZn7cmbyBw0xsm9SMs+G
	2Q/lHEELu1AqPEuedMSNDse5EU5X5xbsAvFqxKQe0PWgS+SJ/7NR1zHLhaTkfDuquuZn0A5gNdQ
	f9SMgxXwPcGl1Lhm3S7eYUdxEr91fJYvoRogH/NLSlhIXqJ23leysDRMpdEMSXK4A3CasUF5/Io
	rv11r8lu1eC2mmR39me5/982EhMMnKh1VIJL956d/SizoY3RtNt3NYW47fR
X-Google-Smtp-Source: AGHT+IEevzG/vRxDLEDST9WWoqNiJfyVNndxBjogGzADGjYE/6vBufeiKYVrM7etFIzouaRIIo/thw==
X-Received: by 2002:a05:6a00:2301:b0:724:63f1:a520 with SMTP id d2e1a72fcca58-7253014a0d1mr20309929b3a.18.1732954995303;
        Sat, 30 Nov 2024 00:23:15 -0800 (PST)
Received: from thinkpad ([120.60.57.102])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7254176121asm4686980b3a.39.2024.11.30.00.23.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Nov 2024 00:23:14 -0800 (PST)
Date: Sat, 30 Nov 2024 13:53:05 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Niklas Cassel <cassel@kernel.org>
Cc: Jingoo Han <jingoohan1@gmail.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Damien Le Moal <dlemoal@kernel.org>, Frank Li <Frank.Li@nxp.com>,
	Jesper Nilsson <jesper.nilsson@axis.com>, stable@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH v5 1/6] PCI: dwc: ep: iATU registers must be written
 after the BAR_MASK
Message-ID: <20241130082305.camrgbzloeev4pei@thinkpad>
References: <20241127103016.3481128-8-cassel@kernel.org>
 <20241127103016.3481128-9-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241127103016.3481128-9-cassel@kernel.org>

On Wed, Nov 27, 2024 at 11:30:17AM +0100, Niklas Cassel wrote:
> The DWC Databook description for the LWR_TARGET_RW and LWR_TARGET_HW fields
> in the IATU_LWR_TARGET_ADDR_OFF_INBOUND_i registers state that:
> "Field size depends on log2(BAR_MASK+1) in BAR match mode."
> 
> I.e. only the upper bits are writable, and the number of writable bits is
> dependent on the configured BAR_MASK.
> 
> If we do not write the BAR_MASK before writing the iATU registers, we are
> relying the reset value of the BAR_MASK being larger than the requested
> size of the first set_bar() call. The reset value of the BAR_MASK is SoC
> dependent.
> 
> Thus, if the first set_bar() call requests a size that is larger than the
> reset value of the BAR_MASK, the iATU will try to write to read-only bits,
> which will cause the iATU to end up redirecting to a physical address that
> is different from the address that was intended.
> 
> Thus, we should always write the iATU registers after writing the BAR_MASK.
> 
> Cc: stable@vger.kernel.org
> Fixes: f8aed6ec624f ("PCI: dwc: designware: Add EP mode support")
> Signed-off-by: Niklas Cassel <cassel@kernel.org>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> ---
>  .../pci/controller/dwc/pcie-designware-ep.c   | 28 ++++++++++---------
>  1 file changed, 15 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
> index f3ac7d46a855..bad588ef69a4 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-ep.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
> @@ -222,19 +222,10 @@ static int dw_pcie_ep_set_bar(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
>  	if ((flags & PCI_BASE_ADDRESS_MEM_TYPE_64) && (bar & 1))
>  		return -EINVAL;
>  
> -	reg = PCI_BASE_ADDRESS_0 + (4 * bar);
> -
> -	if (!(flags & PCI_BASE_ADDRESS_SPACE))
> -		type = PCIE_ATU_TYPE_MEM;
> -	else
> -		type = PCIE_ATU_TYPE_IO;
> -
> -	ret = dw_pcie_ep_inbound_atu(ep, func_no, type, epf_bar->phys_addr, bar);
> -	if (ret)
> -		return ret;
> -
>  	if (ep->epf_bar[bar])
> -		return 0;
> +		goto config_atu;
> +
> +	reg = PCI_BASE_ADDRESS_0 + (4 * bar);
>  
>  	dw_pcie_dbi_ro_wr_en(pci);
>  
> @@ -246,9 +237,20 @@ static int dw_pcie_ep_set_bar(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
>  		dw_pcie_ep_writel_dbi(ep, func_no, reg + 4, 0);
>  	}
>  
> -	ep->epf_bar[bar] = epf_bar;
>  	dw_pcie_dbi_ro_wr_dis(pci);
>  
> +config_atu:
> +	if (!(flags & PCI_BASE_ADDRESS_SPACE))
> +		type = PCIE_ATU_TYPE_MEM;
> +	else
> +		type = PCIE_ATU_TYPE_IO;
> +
> +	ret = dw_pcie_ep_inbound_atu(ep, func_no, type, epf_bar->phys_addr, bar);
> +	if (ret)
> +		return ret;
> +
> +	ep->epf_bar[bar] = epf_bar;
> +
>  	return 0;
>  }
>  
> -- 
> 2.47.0
> 

-- 
மணிவண்ணன் சதாசிவம்

