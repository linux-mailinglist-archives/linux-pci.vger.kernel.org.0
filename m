Return-Path: <linux-pci+bounces-2554-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8289C83C971
	for <lists+linux-pci@lfdr.de>; Thu, 25 Jan 2024 18:10:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15964297A9F
	for <lists+linux-pci@lfdr.de>; Thu, 25 Jan 2024 17:10:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBDB71350D7;
	Thu, 25 Jan 2024 17:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="W6CwLYRN"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D4E56EB7A
	for <linux-pci@vger.kernel.org>; Thu, 25 Jan 2024 17:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706202119; cv=none; b=rqu20C/FfqTlY4sUSO8farUKv9qa3VuQAvNOEMbPBaFTHMUcIodgMYa9vZ8ymOngGsG9/YFXaHlnAFU/8xkMKfJwHOAPVac2a2tP7mnAB29eyLjM2qmllbLEtSRhATpHWeZqx2361AElaQ1DDlQEzGSkMeotsYnXodf4iAGKhj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706202119; c=relaxed/simple;
	bh=g+A65fGfskKQH9Olk03pVdb4e1j3dPQoCyD997ZWJgE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cSFsUWJvtjBeGWoP+rvQNKe08PBafDhGIWehrOa/rYA0iPI5ZCCTSO/pcxSvMwQzOoBmkwbqC8xU3C/YffKDs3mg8Guq6A9eBrGASRMHwkiKQfKTs6x3hsKD20veime8vGNA2K6gBv+Vx+K595V9yuRLJyjuvcWblX7qjm0GX4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=W6CwLYRN; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-6da202aa138so5257245b3a.2
        for <linux-pci@vger.kernel.org>; Thu, 25 Jan 2024 09:01:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706202117; x=1706806917; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=hNUGAijkiBn2m1KWCCQ0pdE5DEqWOTLIASi/EziKQ0M=;
        b=W6CwLYRNRbpV0G4vgIoxhlftPoeDGNuLh2KOatFhdccD4YTqrjO8W040klqO33W9KO
         8g0ATOl5jt0UTK6Ym1rb/syChvQ+/8K7sxphVBBTpU4kqEca+VPfL6Hcgh2yIX5pjypc
         8DuOqZsGnLzg5HPzMAcxQ6/jdYTBH8jKbxr7aQcdAECSKnIU2VAn2Zy/02UKxB/cUx0X
         FxFpvQQbpVfjv7uWZ260jzIEuUDrO2WTZBd5jYoEIiOiKSw/FwAsxse/V7eyAetC4xtp
         fHzLD1/Ba84qO1E+BwVRdE6QbyFCUccVAWSIpTDWbcdGqem/b2oXL3emkBcXiXJNfqTq
         1owA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706202117; x=1706806917;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hNUGAijkiBn2m1KWCCQ0pdE5DEqWOTLIASi/EziKQ0M=;
        b=B6qq+S5G2Yxs+YRMGvrbKx9wf4ThCMEHVlrm957Z0lnwQyurpk5vNAlcknkCuN8ZVU
         JBVlQ5KVilWoBK/fbBKlbysFBbDWDn0m5m6AdUxQHZA5l1RiMUF2QYds1E0VcmdNJ5L8
         /Bn3IfQoEqB0kf9ik+pwtRLCbKlTQv6uUBUES+qiqBe9LRWpdtSgf9xoFWf7fcN6tVLN
         hcRgNjJxIUbXgsrHAGQy4XUIpcApkMNevIJlWkXoZ/ohD9mcT3K0gTid56mGKrbEqctB
         7fi5TraRd93pA7hgVYWzbom+ZJZRkKQXi4sBVeb2EfmUSUnDGkV55bTfXpsNGu20PVkG
         DsoA==
X-Gm-Message-State: AOJu0YyXbl9Ilv/lo09kkVpucO7ZyVR40Wo4hROI6Mkt3EG+0E/NHD+k
	jPIt2zb5RH9H3Y7pBfiysp5kspOzQssSlk7WoE+s5/mVKTTXrphlpIIt3Aw52Q==
X-Google-Smtp-Source: AGHT+IHNC2N6sAzrkV5IrqGK2misl0inXYlISAdTzYmDq5SX2WFTyUaDtBxDc9N/JXNBVqNx2Y/lvw==
X-Received: by 2002:a62:e70a:0:b0:6dd:d0af:e44e with SMTP id s10-20020a62e70a000000b006ddd0afe44emr927947pfh.54.1706202117542;
        Thu, 25 Jan 2024 09:01:57 -0800 (PST)
Received: from thinkpad ([117.217.187.68])
        by smtp.gmail.com with ESMTPSA id r21-20020aa78b95000000b006ddb0dde293sm2984182pfd.65.2024.01.25.09.01.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jan 2024 09:01:56 -0800 (PST)
Date: Thu, 25 Jan 2024 22:31:49 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Niklas Cassel <niklas.cassel@wdc.com>,
	Jingoo Han <jingoohan1@gmail.com>,
	Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH v4 1/2] PCI: dwc: Fix a 64bit bug in
 dw_pcie_ep_raise_msix_irq()
Message-ID: <20240125170149.GA6390@thinkpad>
References: <888c23ff-1ee4-4795-8c24-7631c6c37da6@moroto.mountain>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <888c23ff-1ee4-4795-8c24-7631c6c37da6@moroto.mountain>

On Wed, Jan 24, 2024 at 06:01:42PM +0300, Dan Carpenter wrote:
> The "msg_addr" variable is u64.  However, the "aligned_offset" is an
> unsigned int.  This means that when the code does:
> 
>         msg_addr &= ~aligned_offset;
> 
> it will unintentionally zero out the high 32 bits.  Use ALIGN_DOWN()
> to do the alignment instead.
> 
> Cc: stable@vger.kernel.org
> Fixes: 2217fffcd63f ("PCI: dwc: endpoint: Fix dw_pcie_ep_raise_msix_irq() alignment support")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> Reviewed-by: Niklas Cassel <cassel@kernel.org>
> ---
> v4: Add stable and r-b from Niklas
> v3: Use ALIGN_DOWN()
> v2: fix typo in commit message
> 
>  drivers/pci/controller/dwc/pcie-designware-ep.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
> index 5befed2dc02b..51679c6702cf 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-ep.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
> @@ -551,7 +551,7 @@ int dw_pcie_ep_raise_msix_irq(struct dw_pcie_ep *ep, u8 func_no,
>  	}
>  
>  	aligned_offset = msg_addr & (epc->mem->window.page_size - 1);
> -	msg_addr &= ~aligned_offset;
> +	msg_addr = ALIGN_DOWN(msg_addr, epc->mem->window.page_size);
>  	ret = dw_pcie_ep_map_addr(epc, func_no, 0, ep->msi_mem_phys, msg_addr,
>  				  epc->mem->window.page_size);
>  	if (ret)
> -- 
> 2.43.0
> 

-- 
மணிவண்ணன் சதாசிவம்

