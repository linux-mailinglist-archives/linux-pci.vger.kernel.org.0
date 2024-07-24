Return-Path: <linux-pci+bounces-10724-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 04A8093B1FF
	for <lists+linux-pci@lfdr.de>; Wed, 24 Jul 2024 15:53:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 64A01B22637
	for <lists+linux-pci@lfdr.de>; Wed, 24 Jul 2024 13:53:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2DB8158DC4;
	Wed, 24 Jul 2024 13:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XxzOCPBp"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B427156677
	for <linux-pci@vger.kernel.org>; Wed, 24 Jul 2024 13:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721829193; cv=none; b=FE43d8HQ9KS+e5gHI2jWXdcq/0yUjjpoKBegiqhuB45CRStGQr295ypp2y0KKptM5PXSHk6T2oPSs5AycMNTsB4hLwnkkVSq8YIuVi6qSdeu4LytXizzyYMUGiOw3u017k4TQnZG7P30Z0nxtAfPYELdzcv23DUAqaGJiCAi7mQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721829193; c=relaxed/simple;
	bh=K1Gm5FrXTgsaeMhym9PMm5RXH1m2mr4z+ndq5toTgcY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NRc0KtjD5AwVLn1vlBsuCfzqU28S9VAPqvl1y0R9xgtP2r/rbxaIIPJWkB4mfE+W1N9vHhZl2zYATjBOqwySB10/ifcQ5Dbx8Yq/taqgIYU4stEbBctw6X2hEjRhvdNfbFA9R7JGU7Fmjnlwbe051Zcm0wwpPG5T2/iKrJF5a+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XxzOCPBp; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1fc56fd4de1so6664635ad.0
        for <linux-pci@vger.kernel.org>; Wed, 24 Jul 2024 06:53:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721829190; x=1722433990; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=SoDYcqz8sG/AIs+jpcWHgqP0knrGMe57oRo4EDfUESM=;
        b=XxzOCPBpG8Wgq/2R5cpX4MUYvnbw881wHIeGDt9rbt+HTNxOhp5qlMdOUS8iT7DTXK
         htPo//OnC6tfGQfTc5uxm/VBnKjPuqYMautfqI6WrlIURY2YCtfnCpju96wuP7+coqjj
         Z9nyWpL2qGeuBzYjGcbX42dMu68oiJQsraCpI2LmjPf+/3KrxOLak67HQs8jrEdwd63J
         uZ3eJuVkM3enOLKBwAwkz+QY9qDLrTIeuUYqzaVgrJvUL324vyxs4ckUCH0KvnfHXT9l
         fAxugJC3mPrdQ4yiCjV6KZ81cnITJ8gJ9rO9nmXrJLppw4H9/Og+5LwwsDNLvRoL+WPD
         2haA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721829190; x=1722433990;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SoDYcqz8sG/AIs+jpcWHgqP0knrGMe57oRo4EDfUESM=;
        b=E5a9MtE4fL1NLEY9xFt1QwyxNwCN9u1D+32LOx2NPy8d4gPYBFU6K0UOZdwbvKwE1U
         y/QISKVL+WUOIo1K/R3GwR61tFaWYW5/m2NEojZreOygR71BaGZMdtewXTQyjoWoDMmI
         rTGdWwTxZx1qDWc/B9IWNpRaRKw9s5dBonItsgpFX1uonCIqQ48aUSuLFGAbJg13alrc
         3Y3lmP9sV0s4AdLDi1+Zl7OAgRBQe3+TaR4TFu4iqUQH5KtA66LQ/t5LRLnHeJfjHYvL
         sZt/kbuuLWYTGFok95JEM66iCo7DOtLIE+FrOhBKWlg9kOu7hyTelbUst3If97uifGJ1
         2uWg==
X-Forwarded-Encrypted: i=1; AJvYcCWRbV16Sr2PPPvg5YYBxKEwUrNt7sFt0OkERKNRqGCffdydMq0ybxCwFQf3QT9Bf0PMHGJJkeKkdF8Ovm8U28AugkjPNGvXPtZh
X-Gm-Message-State: AOJu0YwA8gS9a9FxvhHg5yLdVwa0n7WeuOBORkBBUjDujghHvMZfSeeZ
	N/pyjqEQk/BvMPEnVNALA1itjKJHVczqOusRDE9UvB7tdAheOB4Q/O+60CUjyg==
X-Google-Smtp-Source: AGHT+IEmx7G7fByPz1gtOcoNPb6KHFdsEYyRBjys2M9fZj/hXEBf+Bn4FE+Hw7+Xaaw5KQegbGX9Vg==
X-Received: by 2002:a17:903:230b:b0:1fb:9b91:d7d9 with SMTP id d9443c01a7336-1fdd6e80b55mr35063315ad.26.1721829190540;
        Wed, 24 Jul 2024 06:53:10 -0700 (PDT)
Received: from thinkpad ([103.244.168.26])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fd6f290eedsm94532535ad.93.2024.07.24.06.53.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jul 2024 06:53:10 -0700 (PDT)
Date: Wed, 24 Jul 2024 19:23:05 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Prudhvi Yarlagadda <quic_pyarlaga@quicinc.com>
Cc: jingoohan1@gmail.com, lpieralisi@kernel.org, kw@linux.com,
	robh@kernel.org, bhelgaas@google.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	quic_mrana@quicinc.com
Subject: Re: [PATCH v3 1/2] PCI: dwc: Add dbi_phys_addr and atu_phys_addr to
 struct dw_pcie
Message-ID: <20240724135305.GE3349@thinkpad>
References: <20240724022719.2868490-1-quic_pyarlaga@quicinc.com>
 <20240724022719.2868490-2-quic_pyarlaga@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240724022719.2868490-2-quic_pyarlaga@quicinc.com>

On Tue, Jul 23, 2024 at 07:27:18PM -0700, Prudhvi Yarlagadda wrote:

Subject could be modified as below:

PCI: dwc: Cache DBI and iATU physical addresses in 'struct dw_pcie_ops'

> Both DBI and ATU physical base addresses are needed by pcie_qcom.c
> driver to program the location of DBI and ATU blocks in Qualcomm
> PCIe Controller specific PARF hardware block.
> 
> Signed-off-by: Prudhvi Yarlagadda <quic_pyarlaga@quicinc.com>

Suggested-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> Reviewed-by: Mayank Rana <quic_mrana@quicinc.com>
> ---
>  drivers/pci/controller/dwc/pcie-designware.c | 2 ++
>  drivers/pci/controller/dwc/pcie-designware.h | 2 ++
>  2 files changed, 4 insertions(+)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
> index 1b5aba1f0c92..bc3a5d6b0177 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.c
> +++ b/drivers/pci/controller/dwc/pcie-designware.c
> @@ -112,6 +112,7 @@ int dw_pcie_get_resources(struct dw_pcie *pci)
>  		pci->dbi_base = devm_pci_remap_cfg_resource(pci->dev, res);
>  		if (IS_ERR(pci->dbi_base))
>  			return PTR_ERR(pci->dbi_base);
> +		pci->dbi_phys_addr = res->start;
>  	}
>  
>  	/* DBI2 is mainly useful for the endpoint controller */
> @@ -134,6 +135,7 @@ int dw_pcie_get_resources(struct dw_pcie *pci)
>  			pci->atu_base = devm_ioremap_resource(pci->dev, res);
>  			if (IS_ERR(pci->atu_base))
>  				return PTR_ERR(pci->atu_base);
> +			pci->atu_phys_addr = res->start;
>  		} else {
>  			pci->atu_base = pci->dbi_base + DEFAULT_DBI_ATU_OFFSET;
>  		}
> diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
> index 53c4c8f399c8..efc72989330c 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.h
> +++ b/drivers/pci/controller/dwc/pcie-designware.h
> @@ -407,8 +407,10 @@ struct dw_pcie_ops {
>  struct dw_pcie {
>  	struct device		*dev;
>  	void __iomem		*dbi_base;
> +	phys_addr_t		dbi_phys_addr;
>  	void __iomem		*dbi_base2;
>  	void __iomem		*atu_base;
> +	phys_addr_t		atu_phys_addr;
>  	size_t			atu_size;
>  	u32			num_ib_windows;
>  	u32			num_ob_windows;
> -- 
> 2.25.1
> 

-- 
மணிவண்ணன் சதாசிவம்

