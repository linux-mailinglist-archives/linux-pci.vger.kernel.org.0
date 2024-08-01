Return-Path: <linux-pci+bounces-11139-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0983C945359
	for <lists+linux-pci@lfdr.de>; Thu,  1 Aug 2024 21:26:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B12C1C22886
	for <lists+linux-pci@lfdr.de>; Thu,  1 Aug 2024 19:26:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A375C1494A4;
	Thu,  1 Aug 2024 19:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D6NIROKx"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 808E814A4C8;
	Thu,  1 Aug 2024 19:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722540352; cv=none; b=dOILYgv0wSBMYvKcia8nMbcFFXFUaca7ndCWjoYXaRBUgt3Wt17csJlHXRgjRLjc+MrPv/4N2ZRLvp6tVc9a70J6ymPTIsXFYWQOiH47us5ZO2I/cB9HB3gc8gT0sq2LO7zMSmZ0MkU8i1i0jNWnDqRuazjlE/ZboNK1j0EECl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722540352; c=relaxed/simple;
	bh=cU39jujCdmex9bpGlFXkLRQPjBhcGd9q1gPjCWRGd0g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oRhJww8THJyziQSLaXsKrOSmVAaQiaAB5hXdWP+PtdBHuUiSvecq+55tLy2WuCodMxOkF70N3zdv4UVmdtRkby1vLFPr5ZmAvy9nKK18hGq6fbIK3Jz4r99ZwPQeeWkSDYIudRDcOFpORvESPAKKPmRB8nKkhXJtGl+9AYoFnUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D6NIROKx; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-52f01613acbso2841830e87.1;
        Thu, 01 Aug 2024 12:25:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722540348; x=1723145148; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cidrkhLGUiPZTc8U8YS3BVSfOeWIBNfQ0TV+XmUHKgg=;
        b=D6NIROKx51wfrocECWyZzN55PZDcmlOtr7engUV67/Ky1W79ife0OpxrEFOkhOlxIG
         TkbbFOVN1HT5sOaDRY8iwoHJoPO3WXazkQx1Yk984p51lZGVHyKggTK1dPjlt9ICWKHd
         JuJt8HDXlRqThIkpX1aZnjSm79Gim77cmxvJfqhuOd1Ct3or2isNUDZoLdVvfwdNcAI+
         lHl5wsvLfJFVeeh5xc0JrbhLEz4oWIHolGSz+xVowiXIWk1xUZvTUslQUleFTm0l6LBE
         yDh9vkQV98+elNZx6kZwvJC8AjBwBc7Vt2QLrsfYyNXl+pfpzolNmU+YL3n1cR5buwXb
         0Oyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722540348; x=1723145148;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cidrkhLGUiPZTc8U8YS3BVSfOeWIBNfQ0TV+XmUHKgg=;
        b=sqYz/RmjVc+jQx+77TdbFZf0hu5cn+2gchRYM+z6WkCaj/x9+Rv4yiekxKzPEvp/oy
         dU8UUjoTfOgBVMACYhbY/nBzCTP834Qkgh3TH3FCNgDuf21bXbpR2DFumhowr3H0+5Dn
         HzcelIIDNQT2mh0MGfVOfkfa6N8K092LCjZakZ4I60lZxQZQNlQeeHMwSnEZTdKn/tsO
         ijdoBjfbIYXll2lDKRg5pR2b6ZrtqA7wwUcgPEBcAmLVz1XamiIaAW9/i3VgOPbV79SV
         M4EwfE4bvRcxk7Jfb89MVttY3vBQI+J3BkvrAidhe5QcvxPUzq8vYLabOT8TlJc5xt1b
         7Dlg==
X-Forwarded-Encrypted: i=1; AJvYcCV7x4mAnTtuqh3cAODfqMI4lh8dnE1/7MwGmxtMoKuk17jH5c5trV/SXNu3z+xii3hFLEW270kPPikMUsbzyiumt98qPxZMOZ8iyoL8HBV6haT8WmmRiiRlTDLn2SEC6DPdY6BLW5sG0qqJ9iftsrMn1OgmyA30RTB2xvrhf/wrgiITCCc99Q==
X-Gm-Message-State: AOJu0Yx+lYeanEsF53GoGOu1g2ZvxaLsSoO7GZvC8MoWtfPu7/0wYxha
	RaI8MbB99OAdujDn8Jnq+AOq9NstSw8cC+rHOyWqGVnor2Gv1AOu
X-Google-Smtp-Source: AGHT+IGCA/ERDtKy8U4QriTd5rJAi8FLks5bqwQeFfPiYwMB2uLG+sVI7oDh3dauIIRaGt1xxpPafw==
X-Received: by 2002:a05:6512:32c6:b0:52b:c233:113b with SMTP id 2adb3069b0e04-530b8d17bc4mr717812e87.15.1722540348004;
        Thu, 01 Aug 2024 12:25:48 -0700 (PDT)
Received: from mobilestation ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-530bba10f7dsm35678e87.112.2024.08.01.12.25.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Aug 2024 12:25:47 -0700 (PDT)
Date: Thu, 1 Aug 2024 22:25:44 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: Prudhvi Yarlagadda <quic_pyarlaga@quicinc.com>
Cc: jingoohan1@gmail.com, manivannan.sadhasivam@linaro.org, 
	lpieralisi@kernel.org, kw@linux.com, robh@kernel.org, bhelgaas@google.com, 
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	quic_mrana@quicinc.com
Subject: Re: [PATCH v3 1/2] PCI: dwc: Add dbi_phys_addr and atu_phys_addr to
 struct dw_pcie
Message-ID: <vbq3ma3xanu4budrrt7iwk7bh7evgmlgckpohqksuamf3odbee@mvox7krdugg3>
References: <20240724022719.2868490-1-quic_pyarlaga@quicinc.com>
 <20240724022719.2868490-2-quic_pyarlaga@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240724022719.2868490-2-quic_pyarlaga@quicinc.com>

On Tue, Jul 23, 2024 at 07:27:18PM -0700, Prudhvi Yarlagadda wrote:
> Both DBI and ATU physical base addresses are needed by pcie_qcom.c
> driver to program the location of DBI and ATU blocks in Qualcomm
> PCIe Controller specific PARF hardware block.
> 
> Signed-off-by: Prudhvi Yarlagadda <quic_pyarlaga@quicinc.com>
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

What's the point in adding these fields to the generic DW PCIe private
data if they are going to be used in the Qcom glue driver only?

What about moving them to the qcom_pcie structure and initializing the
fields in some place of the pcie-qcom.c driver?

-Serge(y)

>  	size_t			atu_size;
>  	u32			num_ib_windows;
>  	u32			num_ob_windows;
> -- 
> 2.25.1
> 
> 

