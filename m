Return-Path: <linux-pci+bounces-9442-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EC07B91CCEA
	for <lists+linux-pci@lfdr.de>; Sat, 29 Jun 2024 15:05:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9698A1F2213D
	for <lists+linux-pci@lfdr.de>; Sat, 29 Jun 2024 13:05:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8102478C73;
	Sat, 29 Jun 2024 13:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Fvx13+dx"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECBA01E4A0
	for <linux-pci@vger.kernel.org>; Sat, 29 Jun 2024 13:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719666335; cv=none; b=KtOyBV6pK8Og0I1rt8bLgvcaeTIncG2qql59tL29+cx9s1DrssL7gzw/T5BUx+hQ4pdy5OK+25i8rcy5J9SRkv7k6JwO/FQUAB4mK7X03a1E313QxkPKoSh0cO8Hjw1Sv9fTqav8teBfiYbCXAOfFOX9z1Cja5iuKYVldEXhwxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719666335; c=relaxed/simple;
	bh=+GloaJVSprqCGpULiUI/O36iec3Yuequ8ZLM2WLDhNA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s82XfQfVU6JJR8nuhPo1KgSs1mBYkGNCdKrC16dIkHL2FN8ml0AK/CBnwy9UFnmFeP1l6fQPpyBV+lfi5gCkqV0+B9fKsLHihCs6aSL9H4M7VfpZwA2v6Hbqne64vx+dbkHdeCgUBwJMxgK1bkhMmAYgpA1v68oECwbxNV+tRso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Fvx13+dx; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1f480624d10so11059275ad.1
        for <linux-pci@vger.kernel.org>; Sat, 29 Jun 2024 06:05:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719666333; x=1720271133; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Hr41jn7CS+JV7JYEOXmHYOhJrr4EACp9o9fXqaxlvEQ=;
        b=Fvx13+dxBbvCO9u8msJoUvEAv1quxljn6PMdinzrtSpow4qFafKr1PgzG9K3+VrK8V
         hx2F1y4oMyaOD/vGaJ/y+uzBBt2w9adBd1UyDtCnvVS4eJEqkqcgrllFGXXTckZj59Ot
         kAM023AAI+GyaE2Ve701KoAEZKJZHJgPi2IOOEhrByPd9MNwZSGjyMNqO6KvKWk/I+sY
         OoAAQ6d+KhFi7pBONQ/5OZ02OZjQA0/aVA7IoFXWA2OpbJIRVvRswRLiNGdZfzCDmBpg
         69oum7A7SHU62W8wWgt0zOlUGPJd1PUq1SufyMQwnZf+ysbOcgRERDd/Q8165ePRjzgG
         RdkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719666333; x=1720271133;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Hr41jn7CS+JV7JYEOXmHYOhJrr4EACp9o9fXqaxlvEQ=;
        b=l+/yxSdQXC9QDJviU6Wd8J3tsOXKDSa+Gk5fpgk9jQf1LxoBM03xEuiRmxk3dGSD8Y
         b23qPYGCq+Nrjm/496jXt05O5MMltl9m1gdBklIZ5n4nbg4i4GGkJFV65fYyIpJLbWQC
         aVO7r3ioJJJSXPBguJyCKWu2rpB548IB3rgjXwYIBrAFloK5oWtd2Qizf3daN0qDXYEg
         MhAiuPkCVwOXZ4PD3J89mvRsA+h5H7vkgMwdW0JdFFy/Zyd2xRf0A9EqdckH+xviRabd
         rLFsVso1EuW+VHYwX8PQYlYhXDN4EFYvcEPmvgRSFEsnfIrIa2cFs9aa9IJklXIdRLlY
         /5Nw==
X-Forwarded-Encrypted: i=1; AJvYcCVZ/sDRyVpm4MH3vviZW7ieJ35hFhl8Sjg6ZKdMl+PE2JsfKJUAK4sSDbXgfTNGZG98bImNc4TTfQ+OYmynRHYFjycHOy+/5gnO
X-Gm-Message-State: AOJu0YxRAPEv+LrhIjugaH4ySwO8CL0w3d+d906SCO4dvm9rClgl16Hf
	TMj6JBks+vNIk/wH7Jyti11lT3HIaRceAszSLxyL5/wsAI137b1aGLvOIojo+A==
X-Google-Smtp-Source: AGHT+IE5aU4sW0gZNOnsBZmQhd5QPQlm2dJswEqAC+AISCYfDs6s10N0soFFT4U1SUdqSjSMRwrfaA==
X-Received: by 2002:a17:903:2349:b0:1f7:23ee:d496 with SMTP id d9443c01a7336-1fadbcb2064mr6324365ad.30.1719666333190;
        Sat, 29 Jun 2024 06:05:33 -0700 (PDT)
Received: from thinkpad ([220.158.156.249])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fac1598576sm31531345ad.278.2024.06.29.06.05.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Jun 2024 06:05:32 -0700 (PDT)
Date: Sat, 29 Jun 2024 18:35:25 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: Richard Zhu <hongxing.zhu@nxp.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	NXP Linux Team <linux-imx@nxp.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-pci@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
	devicetree@vger.kernel.org, Jason Liu <jason.hui.liu@nxp.com>
Subject: Re: [PATCH v6 02/10] PCI: imx6: Fix i.MX8MP PCIe EP's occasional
 failure to trigger MSI
Message-ID: <20240629130525.GC5608@thinkpad>
References: <20240617-pci2_upstream-v6-0-e0821238f997@nxp.com>
 <20240617-pci2_upstream-v6-2-e0821238f997@nxp.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240617-pci2_upstream-v6-2-e0821238f997@nxp.com>

On Mon, Jun 17, 2024 at 04:16:38PM -0400, Frank Li wrote:
> From: Richard Zhu <hongxing.zhu@nxp.com>
> 
> Correct occasional MSI triggering failures in i.MX8MP PCIe EP by apply 64KB
> hardware alignment requirement.
> 
> MSI triggering fail if the outbound MSI memory region (ep->msi_mem) is not
> aligned to 64KB.
> 
> In dw_pcie_ep_init():
> 
> ep->msi_mem = pci_epc_mem_alloc_addr(epc, &ep->msi_mem_phys,
> 				     epc->mem->window.page_size);
> 

So this is an alignment restriction w.r.t iATU. In that case, we should be
passing 'pci_epc_features::align' instead?

- Mani

> Set ep->page_size to match drvdata::epc_features::align since different
> SOCs have different alignment requirements.
> 
> Fixes: 1bd0d43dcf3b ("PCI: imx6: Clean up addr_space retrieval code")
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> Acked-by: Jason Liu <jason.hui.liu@nxp.com>
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
>  drivers/pci/controller/dwc/pci-imx6.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> index 9a71b8aa09b3c..ca9a000c9a96d 100644
> --- a/drivers/pci/controller/dwc/pci-imx6.c
> +++ b/drivers/pci/controller/dwc/pci-imx6.c
> @@ -1118,6 +1118,8 @@ static int imx6_add_pcie_ep(struct imx6_pcie *imx6_pcie,
>  	if (imx6_check_flag(imx6_pcie, IMX6_PCIE_FLAG_SUPPORT_64BIT))
>  		dma_set_mask_and_coherent(dev, DMA_BIT_MASK(64));
>  
> +	ep->page_size = imx6_pcie->drvdata->epc_features->align;
> +
>  	ret = dw_pcie_ep_init(ep);
>  	if (ret) {
>  		dev_err(dev, "failed to initialize endpoint\n");
> 
> -- 
> 2.34.1
> 

-- 
மணிவண்ணன் சதாசிவம்

