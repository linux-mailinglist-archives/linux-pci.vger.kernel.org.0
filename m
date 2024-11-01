Return-Path: <linux-pci+bounces-15785-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E8789B8BDD
	for <lists+linux-pci@lfdr.de>; Fri,  1 Nov 2024 08:13:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B6E11F22F98
	for <lists+linux-pci@lfdr.de>; Fri,  1 Nov 2024 07:13:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 723305D8F0;
	Fri,  1 Nov 2024 07:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="f7FB3F0f"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67B231487E9
	for <linux-pci@vger.kernel.org>; Fri,  1 Nov 2024 07:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730445174; cv=none; b=qpDvuxej2lRPOxwEWea2+so3P2BFWrFdDMMn3UKOgWMZrm2MG2RUqBM5aahVdoMelqPnZ4UIvXn+VZWlG7A5sL5iY8D/4JIQufdnXyA9U0HhkT3acxH8qZXaEaSwP2il+sUzdp+W1i5hJx8V3VPdels2c+NRPE8DNfEVfxNuRQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730445174; c=relaxed/simple;
	bh=eHVsQfgGykQyHqfvBMDdE0C5zwL7qwez8C2w/Ws50t4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TNjM6cRtDtQODgZDM8MmqwXLUh4sGcWettNLRerRcirEJNOZTqqnihu7I5ce7wViveo1Wv6MFp65tGZcw4rNW4rtVFNfXa0eDDkgLOkhAsN3lXfJ9eOQkrGIFOiSr68yuH0O706NSjHAXaVuPuSMM4ywne6/Ip7xqNvp4c7oVVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=f7FB3F0f; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-210e5369b7dso17444615ad.3
        for <linux-pci@vger.kernel.org>; Fri, 01 Nov 2024 00:12:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730445172; x=1731049972; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Rv7d+mC3JhUsegkc7THfTQC9kPXa1j+cxuj5IdYLNFA=;
        b=f7FB3F0fHQ58n8lPqUpkT0LeqaTfLrUVNUAUthjQOZQuKPesbkXaypgCgM4y0A8HU1
         O/7RL+2bHPd1s502fJy0cRUqbNfq32l6/v/4NoVn8eOOxZkR53Z8x0XTqPWj1/JjXEfQ
         rXYaTvXvgyQztqhjZ92/SguwPwmvc/u086lG/g3B8Bq7PHiSuWFHaTKhF6rR+L5ZqBzX
         CWHgkhEuXAEEoQijRB4mKbIrdpL6a3TqLoqe43slS96P3cD/F/+OIRQ8DxY1fzWYxTXT
         9XMvkarZxoGALo/Zhh7xeMkw5FomUs3CGMS8pQPxv5IU2iBSdGrfMLp+5vRwtF8rxxA4
         Ddvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730445172; x=1731049972;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Rv7d+mC3JhUsegkc7THfTQC9kPXa1j+cxuj5IdYLNFA=;
        b=SXB3J67APrfJYbWVF1lEFg9VCgwaE5fv44/IBwNH/bNQgst6jWclXccuLOs0HD7Kz6
         Bba0JM0d0AazJhu4p8RfJ+MHkz/s6Dh0VAr6qQAsi8LZbvZVheWPR4zBHRToAR4bGulk
         MSiR7tgedM8vsP4XNhFInlJr1f/9vMOouaj2alcspWZ4Cex0u5M0FfH1JtF1Y0h6bQx3
         L1Jd1JhuUn420YnsLAumf1W162+IvWnkvn7kSgf/A80ifp2WIecqeHOlRU+RmYrJi6Qc
         jgf+cpYtkg5CjUSpNRxZ6pkeY8aGzVenrixcxWq9xgUpDF8tdcm8BNLHr/KsoeztGPvV
         kbrQ==
X-Forwarded-Encrypted: i=1; AJvYcCX1Apsced9uA3ToYOOlvJ4oySsmgPVBPXt8yRMTwDydJFEafb2J2crwO9oTYHkGEE8HTXLQH+kKbdg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0IvIvvlfXK2AarYWlmiRwApHdF7cRpKkuENR7GVR8f14xLlWU
	jEHfG2dalvZTH4q9opnYQS0ONeDzv3kWhyN7V3kU4ACYj4DPiMz5YskEB24IzD9XSuJSkXXgaEw
	=
X-Google-Smtp-Source: AGHT+IGg9ewgHTV+hUOeL9J5WRXJ5B/NIsKl3kpdcwDPdnvXLXa3znUMhE9Ts1t+mbuQHVEGpU+Hpg==
X-Received: by 2002:a17:90b:38cd:b0:2e1:ce67:5d29 with SMTP id 98e67ed59e1d1-2e94c2dd2afmr3320598a91.21.1730445171667;
        Fri, 01 Nov 2024 00:12:51 -0700 (PDT)
Received: from thinkpad ([120.60.51.213])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e92fa262fasm4466089a91.21.2024.11.01.00.12.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Nov 2024 00:12:50 -0700 (PDT)
Date: Fri, 1 Nov 2024 12:42:36 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Niklas Cassel <cassel@kernel.org>
Cc: Jingoo Han <jingoohan1@gmail.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Damien Le Moal <dlemoal@kernel.org>, linux-pci@vger.kernel.org
Subject: Re: [PATCH 1/2] PCI: dwc: ep: Fix dw_pcie_ep_align_addr()
Message-ID: <20241101071236.gddrtufnalhjf42k@thinkpad>
References: <20241017132052.4014605-4-cassel@kernel.org>
 <20241017132052.4014605-5-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241017132052.4014605-5-cassel@kernel.org>

On Thu, Oct 17, 2024 at 03:20:54PM +0200, Niklas Cassel wrote:
> ep->page_size is defined by the EPC drivers.
> Some drivers e.g. pci-imx6.c defines this to 4K for imx95.
> 
> dw_pcie_ep_init() will call pci_epc_mem_init() with ep->page_size.
> pci_epc_mem_init() will call pci_epc_multi_mem_init().
> 
> pci_epc_multi_mem_init() will initialize mem->window.page_size.
> If the provided page_size (ep->page_size) is smaller than PAGE_SIZE,
> it will initialize mem->window.page_size to PAGE_SIZE rather than
> ep->page_size.
> 
> Thus, mem->window.page_size can be larger than ep->page_size, e.g.
> for a platform built with PAGE_SIZE == 64K, while using a EPC driver
> that defines ep->page_size to 4k.
> 
> Therefore, modify dw_pcie_ep_align_addr() to use
> epc->mem->window.page_size rather than ep->page_size.
> 
> Signed-off-by: Niklas Cassel <cassel@kernel.org>

Fixes: a1cd1d901a5c ("PCI: dwc: endpoint: Implement the pci_epc_ops::align_addr() operation")

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> ---
>  drivers/pci/controller/dwc/pcie-designware-ep.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
> index 2d0e7bf17919..20f67fd85e83 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-ep.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
> @@ -276,7 +276,7 @@ static u64 dw_pcie_ep_align_addr(struct pci_epc *epc, u64 pci_addr,
>  	u64 mask = pci->region_align - 1;
>  	size_t ofst = pci_addr & mask;
>  
> -	*pci_size = ALIGN(ofst + *pci_size, ep->page_size);
> +	*pci_size = ALIGN(ofst + *pci_size, epc->mem->window.page_size);
>  	*offset = ofst;
>  
>  	return pci_addr & ~mask;
> -- 
> 2.47.0
> 

-- 
மணிவண்ணன் சதாசிவம்

