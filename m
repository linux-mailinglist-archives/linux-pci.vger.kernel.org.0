Return-Path: <linux-pci+bounces-129-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 969FC7F47E6
	for <lists+linux-pci@lfdr.de>; Wed, 22 Nov 2023 14:39:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 418BD2813C2
	for <lists+linux-pci@lfdr.de>; Wed, 22 Nov 2023 13:39:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88ED756448;
	Wed, 22 Nov 2023 13:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FmTokHJK"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5F1A19D
	for <linux-pci@vger.kernel.org>; Wed, 22 Nov 2023 05:38:53 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-507a29c7eefso9527669e87.1
        for <linux-pci@vger.kernel.org>; Wed, 22 Nov 2023 05:38:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700660332; x=1701265132; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AJKFyf49CtfI/jiMmLVLBnwRxT/9EcFNiow+NCdZjw0=;
        b=FmTokHJKy4uDBl4Oy51EH2CPGq4kbElq9Lerpj5QujWVrK1b37HvQ5rdkCO2YxYTeV
         3LTJUVMBWn5i75U5hgKXPZGweoPmzUtOc/ybHWDnJQ/l8gjeIF9eCO6ePTG6LVlN/WS2
         axdvha7BnUbyHCNF8XG+Z4Ge292fOssVXQK7qErbFQqxSbyzi7aC9L3kGxo1rOzpWkh9
         IpvOR/H1TFdWA2ACbmRJ0W65Et/8+VBO66p96NiieE4ZXiRyCunPBjQRQC0dR0BZpNpD
         bwwt8zfcdjK6KBmR85jWU4nP1n7TC1XUJ3uBtakFtRZ2rDkKY8BBPhhH2Dw5bObISQ8Y
         hvew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700660332; x=1701265132;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AJKFyf49CtfI/jiMmLVLBnwRxT/9EcFNiow+NCdZjw0=;
        b=Z1hdHiWb1vOQMbkBCUL6lWXNWefNYtftQ00Q1wg7Zo+U7rpfc6PnONq4pbV+w/jHFJ
         iePLOPBqJLOt05FaPaPmOJQGwpUSVz1fhMkZ1mQ6BWTAcDzvntAm1MofEg531YChN9YE
         YK1Rs8J+EGyDz2ZL7QjPLD9QseHnw/Zczhwbp/e7KbO5b0tUu6n7MOC1faYwmJ94HIX3
         +7MmX3pHIJX3Z9PVYQo/pfS9YJ43GXnEnFlYWCGyOEgEBOxwnsaCi4b6Ewl5dwBsFOD/
         KxATCy0ASLMxLmUmEbrGuDNgnlEwxT5092t+uJXf1cErdIYTpFodxcXXJrFdHcsZIt/w
         H2Xg==
X-Gm-Message-State: AOJu0YxUytzEfvcWhpPQn+TEHi9C0FgZ/oBJqMt+wFPwML9DSnO2sw6Q
	hrBnzb6DNd351wxsw/RC6725V0P0VQQ=
X-Google-Smtp-Source: AGHT+IFQ5E2dBq/5V648976rXI1Kgy+SeRspc8kYNwW3o1z1Wwt9fvX72P1LYktjTdimfLchITc2SQ==
X-Received: by 2002:a19:f611:0:b0:508:268b:b087 with SMTP id x17-20020a19f611000000b00508268bb087mr1668827lfe.26.1700660331668;
        Wed, 22 Nov 2023 05:38:51 -0800 (PST)
Received: from mobilestation ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id k15-20020ac24f0f000000b0050aa31e8d75sm1649581lfr.71.2023.11.22.05.38.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Nov 2023 05:38:51 -0800 (PST)
Date: Wed, 22 Nov 2023 16:38:48 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Kishon Vijay Abraham I <kishon@kernel.org>, Manivannan Sadhasivami <manivannan.sadhasivam@linaro.org>, 
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: Re: [PATCH v4 09/16] PCI: dwc: Rename dw_pcie_ep_raise_legacy_irq()
Message-ID: <igncoh5pyjv7ks7prqwqwmjdm353x5w66qsblqar5zvptudqtn@urxywl6gn6fc>
References: <20231122060406.14695-1-dlemoal@kernel.org>
 <20231122060406.14695-10-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231122060406.14695-10-dlemoal@kernel.org>

On Wed, Nov 22, 2023 at 03:03:59PM +0900, Damien Le Moal wrote:
> Rename the function dw_pcie_ep_raise_legacy_irq() of the Designware
> endpoint controller driver to dw_pcie_ep_raise_intx_irq() to match the
> name of the PCI_IRQ_INTX macro.
> 
> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>

Looks good. Thanks for cleaning this up.
Reviewed-by: Serge Semin <fancer.lancer@gmail.com>

-Serge(y) 

> ---
>  drivers/pci/controller/dwc/pci-imx6.c             | 2 +-
>  drivers/pci/controller/dwc/pci-layerscape-ep.c    | 2 +-
>  drivers/pci/controller/dwc/pcie-designware-ep.c   | 6 +++---
>  drivers/pci/controller/dwc/pcie-designware-plat.c | 2 +-
>  drivers/pci/controller/dwc/pcie-designware.h      | 4 ++--
>  drivers/pci/controller/dwc/pcie-qcom-ep.c         | 2 +-
>  drivers/pci/controller/dwc/pcie-rcar-gen4.c       | 2 +-
>  7 files changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> index a5365ab8897e..f117ec286a76 100644
> --- a/drivers/pci/controller/dwc/pci-imx6.c
> +++ b/drivers/pci/controller/dwc/pci-imx6.c
> @@ -1064,7 +1064,7 @@ static int imx6_pcie_ep_raise_irq(struct dw_pcie_ep *ep, u8 func_no,
>  
>  	switch (type) {
>  	case PCI_IRQ_INTX:
> -		return dw_pcie_ep_raise_legacy_irq(ep, func_no);
> +		return dw_pcie_ep_raise_intx_irq(ep, func_no);
>  	case PCI_IRQ_MSI:
>  		return dw_pcie_ep_raise_msi_irq(ep, func_no, interrupt_num);
>  	case PCI_IRQ_MSIX:
> diff --git a/drivers/pci/controller/dwc/pci-layerscape-ep.c b/drivers/pci/controller/dwc/pci-layerscape-ep.c
> index 5f78a9415286..9e7beb3ba09b 100644
> --- a/drivers/pci/controller/dwc/pci-layerscape-ep.c
> +++ b/drivers/pci/controller/dwc/pci-layerscape-ep.c
> @@ -172,7 +172,7 @@ static int ls_pcie_ep_raise_irq(struct dw_pcie_ep *ep, u8 func_no,
>  
>  	switch (type) {
>  	case PCI_IRQ_INTX:
> -		return dw_pcie_ep_raise_legacy_irq(ep, func_no);
> +		return dw_pcie_ep_raise_intx_irq(ep, func_no);
>  	case PCI_IRQ_MSI:
>  		return dw_pcie_ep_raise_msi_irq(ep, func_no, interrupt_num);
>  	case PCI_IRQ_MSIX:
> diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
> index 87759c899fab..d8850b59094b 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-ep.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
> @@ -496,16 +496,16 @@ static const struct pci_epc_ops epc_ops = {
>  	.get_features		= dw_pcie_ep_get_features,
>  };
>  
> -int dw_pcie_ep_raise_legacy_irq(struct dw_pcie_ep *ep, u8 func_no)
> +int dw_pcie_ep_raise_intx_irq(struct dw_pcie_ep *ep, u8 func_no)
>  {
>  	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
>  	struct device *dev = pci->dev;
>  
> -	dev_err(dev, "EP cannot trigger legacy IRQs\n");
> +	dev_err(dev, "EP cannot raise INTX IRQs\n");
>  
>  	return -EINVAL;
>  }
> -EXPORT_SYMBOL_GPL(dw_pcie_ep_raise_legacy_irq);
> +EXPORT_SYMBOL_GPL(dw_pcie_ep_raise_intx_irq);
>  
>  int dw_pcie_ep_raise_msi_irq(struct dw_pcie_ep *ep, u8 func_no,
>  			     u8 interrupt_num)
> diff --git a/drivers/pci/controller/dwc/pcie-designware-plat.c b/drivers/pci/controller/dwc/pcie-designware-plat.c
> index c83968aa0149..27047e4c402a 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-plat.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-plat.c
> @@ -48,7 +48,7 @@ static int dw_plat_pcie_ep_raise_irq(struct dw_pcie_ep *ep, u8 func_no,
>  
>  	switch (type) {
>  	case PCI_IRQ_INTX:
> -		return dw_pcie_ep_raise_legacy_irq(ep, func_no);
> +		return dw_pcie_ep_raise_intx_irq(ep, func_no);
>  	case PCI_IRQ_MSI:
>  		return dw_pcie_ep_raise_msi_irq(ep, func_no, interrupt_num);
>  	case PCI_IRQ_MSIX:
> diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
> index ffb9a62f3179..d55b28f3f156 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.h
> +++ b/drivers/pci/controller/dwc/pcie-designware.h
> @@ -580,7 +580,7 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep);
>  int dw_pcie_ep_init_complete(struct dw_pcie_ep *ep);
>  void dw_pcie_ep_init_notify(struct dw_pcie_ep *ep);
>  void dw_pcie_ep_exit(struct dw_pcie_ep *ep);
> -int dw_pcie_ep_raise_legacy_irq(struct dw_pcie_ep *ep, u8 func_no);
> +int dw_pcie_ep_raise_intx_irq(struct dw_pcie_ep *ep, u8 func_no);
>  int dw_pcie_ep_raise_msi_irq(struct dw_pcie_ep *ep, u8 func_no,
>  			     u8 interrupt_num);
>  int dw_pcie_ep_raise_msix_irq(struct dw_pcie_ep *ep, u8 func_no,
> @@ -613,7 +613,7 @@ static inline void dw_pcie_ep_exit(struct dw_pcie_ep *ep)
>  {
>  }
>  
> -static inline int dw_pcie_ep_raise_legacy_irq(struct dw_pcie_ep *ep, u8 func_no)
> +static inline int dw_pcie_ep_raise_intx_irq(struct dw_pcie_ep *ep, u8 func_no)
>  {
>  	return 0;
>  }
> diff --git a/drivers/pci/controller/dwc/pcie-qcom-ep.c b/drivers/pci/controller/dwc/pcie-qcom-ep.c
> index 2e5ab5fef310..71860e59cfce 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom-ep.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom-ep.c
> @@ -732,7 +732,7 @@ static int qcom_pcie_ep_raise_irq(struct dw_pcie_ep *ep, u8 func_no,
>  
>  	switch (type) {
>  	case PCI_IRQ_INTX:
> -		return dw_pcie_ep_raise_legacy_irq(ep, func_no);
> +		return dw_pcie_ep_raise_intx_irq(ep, func_no);
>  	case PCI_IRQ_MSI:
>  		return dw_pcie_ep_raise_msi_irq(ep, func_no, interrupt_num);
>  	default:
> diff --git a/drivers/pci/controller/dwc/pcie-rcar-gen4.c b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
> index 25354a82674d..6be20359d9fe 100644
> --- a/drivers/pci/controller/dwc/pcie-rcar-gen4.c
> +++ b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
> @@ -368,7 +368,7 @@ static int rcar_gen4_pcie_ep_raise_irq(struct dw_pcie_ep *ep, u8 func_no,
>  
>  	switch (type) {
>  	case PCI_IRQ_INTX:
> -		return dw_pcie_ep_raise_legacy_irq(ep, func_no);
> +		return dw_pcie_ep_raise_intx_irq(ep, func_no);
>  	case PCI_IRQ_MSI:
>  		return dw_pcie_ep_raise_msi_irq(ep, func_no, interrupt_num);
>  	default:
> -- 
> 2.42.0
> 

