Return-Path: <linux-pci+bounces-11065-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 702109434DE
	for <lists+linux-pci@lfdr.de>; Wed, 31 Jul 2024 19:18:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B13C2B228DC
	for <lists+linux-pci@lfdr.de>; Wed, 31 Jul 2024 17:17:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF2331BD002;
	Wed, 31 Jul 2024 17:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BI6qvEDl"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF3CC17BA3
	for <linux-pci@vger.kernel.org>; Wed, 31 Jul 2024 17:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722446269; cv=none; b=jFLG6wVAiuZ2GI2Z6T0s71zUWWMP0nQShMTa5L5lQ/Xskw07kfx2eWzq/TpwlsxDJd7GuktO7pcf0vz5Chc7bWLBFZsvpQwz5oe1dYZJyS59YAXCwhWSB79rXTriSW01Y1lVzV/GmkXhH3J/LIc+bnTXPaVcFQVahSRtkOTBT4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722446269; c=relaxed/simple;
	bh=qqFSJ9OEV8R3ldQ+ymwEUFQE22TigC4D1YQrC9zM0q4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rtsZnU27mVEQI8S6QBAXRmGKmSKj4YF9S/hPJuZ926cc81WFeH4xjCAc0NI7Po9UwnXgGl+0KSeL7lX65wPbeExKvADBq0JDfqizPi7k2YvaHT5iPIEK1NZoGxuELGoBoLDp5UR80w5Uizozkrb3CFiG60lAD0yC7TQNACWFeq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=BI6qvEDl; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2cb4c584029so4018942a91.3
        for <linux-pci@vger.kernel.org>; Wed, 31 Jul 2024 10:17:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1722446266; x=1723051066; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=93I7/mpjJrW9Hk747Ikod8e9PCRBdG2PcvJTDKja1ck=;
        b=BI6qvEDlEhG4wxIEnc4FmXwW56Ca5t4BpSomyoUej+dukMBuq7lOWMS0Yvyw6UIyEv
         IibW5+2zv22Ithch7yu3ChK+olJq4inkfy+jjf3CN5Z/cj2/OYh3fLxHzp+NrmhR5Acg
         I1lDNK6psVfy1+szuQtDkohV4krp7c65QM8jEghqtQIa5FtIZ88SI7gjZy+eeBoLHFzj
         tCEejRslIsn83kX6Nccv+v6Ntx++82o01aoAgeaddrjj6k8BzonWQKyevdcCOhPDikBU
         EfFwf263plGGxkdNDlcfTB8ZujXUEBbmeuFCZ1nH4Z9UAPskwQjpF6EB0riBS9ab1n4h
         Fu7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722446266; x=1723051066;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=93I7/mpjJrW9Hk747Ikod8e9PCRBdG2PcvJTDKja1ck=;
        b=IqxdfttPfSQjREjlLfr6rLhH8aB726awzOmcCkcks0BsMvRKyLroL6a8zbTSbwTj8l
         mz6sPQaonLRoAessR2SAv0l9OjmtVe1giE82VZL4xIN5j2ijq5H3gf0fvq+SawIr63G/
         KhSFtS+M/LQUoQO7IBXmCT5dIzVxpxmygmAXG85mU/m7rNz3Xqc7aTyzM9DgSguDmYCD
         9vUWJom4uYa5B5mQs+ZwyorFKCG2NdGJ02Qma8F+oM1WFANvuvM6yn7e81OdiItGB3w6
         Iu5xP6mGBCSvX0+tD+P9sGpHQ8l+XGFsMN953iBcgF8zSFb2ZmWN1fZtYG/KI6w9644n
         v3Vw==
X-Forwarded-Encrypted: i=1; AJvYcCXHtPKfUm6PRO4P7rxopF6g5jltMkKeFqhH0oq5nOAjKgLbfO3w9xpRhmH6HuHSepSGxMPpw647k6hoUd1z/tXmzVa0dTx6gKtZ
X-Gm-Message-State: AOJu0Yyh9ukMFRuOB0vX4nsIj9XwO74Fxt0eYg1TTt/iQYXx+a7GiZfV
	QZYKhzfbPFn3VImuxuzH4MKqxWv+zS2GEQQyvQz+aYz9+DKcKkZU5b4rWbXPWQ==
X-Google-Smtp-Source: AGHT+IG4FqwSZSRESde3hln86aG8gEacOfLEQW9XssktZoDgSMe2O7ZcLfILEVYz3vRrBGR2S4MyBA==
X-Received: by 2002:a17:90a:5602:b0:2c9:7e9c:9637 with SMTP id 98e67ed59e1d1-2cf7e1d72ecmr15361575a91.13.1722446266047;
        Wed, 31 Jul 2024 10:17:46 -0700 (PDT)
Received: from thinkpad ([120.60.66.23])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2cfdc4e3e1fsm1593361a91.56.2024.07.31.10.17.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jul 2024 10:17:45 -0700 (PDT)
Date: Wed, 31 Jul 2024 22:47:28 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Mayank Rana <quic_mrana@quicinc.com>
Cc: will@kernel.org, lpieralisi@kernel.org, kw@linux.com, robh@kernel.org,
	bhelgaas@google.com, jingoohan1@gmail.com, cassel@kernel.org,
	yoshihiro.shimoda.uh@renesas.com, s-vadapalli@ti.com,
	u.kleine-koenig@pengutronix.de, dlemoal@kernel.org,
	amishin@t-argos.ru, thierry.reding@gmail.com, jonathanh@nvidia.com,
	Frank.Li@nxp.com, ilpo.jarvinen@linux.intel.com, vidyas@nvidia.com,
	marek.vasut+renesas@gmail.com, krzk+dt@kernel.org,
	conor+dt@kernel.org, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	quic_ramkri@quicinc.com, quic_nkela@quicinc.com,
	quic_shazhuss@quicinc.com, quic_msarkar@quicinc.com,
	quic_nitegupt@quicinc.com
Subject: Re: [PATCH V222/7] PCI: dwc: Add msi_ops to allow DBI based MSI
 register access
Message-ID: <20240731171728.GC2983@thinkpad>
References: <1721067215-5832-1-git-send-email-quic_mrana@quicinc.com>
 <1721067215-5832-3-git-send-email-quic_mrana@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1721067215-5832-3-git-send-email-quic_mrana@quicinc.com>

On Mon, Jul 15, 2024 at 11:13:30AM -0700, Mayank Rana wrote:
> PCIe ECAM driver do not have dw_pcie data structure populated and DBI
> access related APIs. Hence add msi_ops as part of dw_msi structure to
> allow populating DBI based MSI register access.
> 
> Signed-off-by: Mayank Rana <quic_mrana@quicinc.com>
> ---
>  drivers/pci/controller/dwc/pcie-designware-host.c | 20 ++++++++++++-
>  drivers/pci/controller/dwc/pcie-designware-msi.c  | 36 +++++++++++++----------
>  drivers/pci/controller/dwc/pcie-designware-msi.h  | 10 +++++--
>  3 files changed, 47 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> index 3dcf88a..7a1eb1f 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> @@ -47,6 +47,16 @@ static void dw_pcie_host_request_msg_tlp_res(struct dw_pcie_rp *pp)
>  	}
>  }
>  
> +static u32 dw_pcie_readl_msi_dbi(void *pci, u32 reg)
> +{
> +	return dw_pcie_readl_dbi((struct dw_pcie *)pci, reg);
> +}
> +
> +static void dw_pcie_writel_msi_dbi(void *pci, u32 reg, u32 val)
> +{
> +	dw_pcie_writel_dbi((struct dw_pcie *)pci, reg, val);
> +}
> +

There is nothing MSI specific in dw_pcie_{writel/readl}_msi_dbi(). This just
writes/reads the registers. So this should be called as dw_pcie_write_reg()/
dw_pcie_write_reg().

>  int dw_pcie_host_init(struct dw_pcie_rp *pp)
>  {
>  	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> @@ -55,6 +65,7 @@ int dw_pcie_host_init(struct dw_pcie_rp *pp)
>  	struct platform_device *pdev = to_platform_device(dev);
>  	struct resource_entry *win;
>  	struct pci_host_bridge *bridge;
> +	struct dw_msi_ops *msi_ops;
>  	struct resource *res;
>  	bool has_msi_ctrl;
>  	int ret;
> @@ -124,7 +135,14 @@ int dw_pcie_host_init(struct dw_pcie_rp *pp)
>  			if (ret < 0)
>  				goto err_deinit_host;
>  		} else if (has_msi_ctrl) {
> -			pp->msi = dw_pcie_msi_host_init(pdev, pp, pp->num_vectors);
> +			msi_ops = devm_kzalloc(dev, sizeof(*msi_ops), GFP_KERNEL);
> +			if (msi_ops == NULL)
> +				goto err_deinit_host;
> +
> +			msi_ops->pp = pci;

Stuffing private data inside ops structure looks weird. Also the fact that
allocating memory for ops...

> +			msi_ops->readl_msi = dw_pcie_readl_msi_dbi,
> +			msi_ops->writel_msi = dw_pcie_writel_msi_dbi,

Same for the callback name.

> +			pp->msi = dw_pcie_msi_host_init(pdev, msi_ops, pp->num_vectors);
>  			if (IS_ERR(pp->msi)) {
>  				ret = PTR_ERR(pp->msi);
>  				goto err_deinit_host;
> diff --git a/drivers/pci/controller/dwc/pcie-designware-msi.c b/drivers/pci/controller/dwc/pcie-designware-msi.c
> index 39fe5be..dbfffce 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-msi.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-msi.c
> @@ -44,6 +44,16 @@ static struct msi_domain_info dw_pcie_msi_domain_info = {
>  	.chip	= &dw_pcie_msi_irq_chip,
>  };
>  
> +static u32 dw_msi_readl(struct dw_msi *msi, u32 reg)
> +{
> +	return msi->msi_ops->readl_msi(msi->msi_ops->pp, reg);
> +}
> +
> +static void dw_msi_writel(struct dw_msi *msi, u32 reg, u32 val)
> +{
> +	msi->msi_ops->writel_msi(msi->msi_ops->pp, reg, val);
> +}
> +

These could be:

dw_msi_read_reg()
dw_msi_write_reg()

- Mani

>  /* MSI int handler */
>  irqreturn_t dw_handle_msi_irq(struct dw_msi *msi)
>  {
> @@ -51,13 +61,11 @@ irqreturn_t dw_handle_msi_irq(struct dw_msi *msi)
>  	unsigned long val;
>  	u32 status, num_ctrls;
>  	irqreturn_t ret = IRQ_NONE;
> -	struct dw_pcie *pci = to_dw_pcie_from_pp(msi->pp);
>  
>  	num_ctrls = msi->num_vectors / MAX_MSI_IRQS_PER_CTRL;
>  
>  	for (i = 0; i < num_ctrls; i++) {
> -		status = dw_pcie_readl_dbi(pci, PCIE_MSI_INTR0_STATUS +
> -					   (i * MSI_REG_CTRL_BLOCK_SIZE));
> +		status = dw_msi_readl(msi, PCIE_MSI_INTR0_STATUS + (i * MSI_REG_CTRL_BLOCK_SIZE));
>  		if (!status)
>  			continue;
>  
> @@ -115,7 +123,6 @@ static int dw_pci_msi_set_affinity(struct irq_data *d,
>  static void dw_pci_bottom_mask(struct irq_data *d)
>  {
>  	struct dw_msi *msi = irq_data_get_irq_chip_data(d);
> -	struct dw_pcie *pci = to_dw_pcie_from_pp(msi->pp);
>  	unsigned int res, bit, ctrl;
>  	unsigned long flags;
>  
> @@ -126,7 +133,7 @@ static void dw_pci_bottom_mask(struct irq_data *d)
>  	bit = d->hwirq % MAX_MSI_IRQS_PER_CTRL;
>  
>  	msi->irq_mask[ctrl] |= BIT(bit);
> -	dw_pcie_writel_dbi(pci, PCIE_MSI_INTR0_MASK + res, msi->irq_mask[ctrl]);
> +	dw_msi_writel(msi, PCIE_MSI_INTR0_MASK + res, msi->irq_mask[ctrl]);
>  
>  	raw_spin_unlock_irqrestore(&msi->lock, flags);
>  }
> @@ -134,7 +141,6 @@ static void dw_pci_bottom_mask(struct irq_data *d)
>  static void dw_pci_bottom_unmask(struct irq_data *d)
>  {
>  	struct dw_msi *msi = irq_data_get_irq_chip_data(d);
> -	struct dw_pcie *pci = to_dw_pcie_from_pp(msi->pp);
>  	unsigned int res, bit, ctrl;
>  	unsigned long flags;
>  
> @@ -145,7 +151,7 @@ static void dw_pci_bottom_unmask(struct irq_data *d)
>  	bit = d->hwirq % MAX_MSI_IRQS_PER_CTRL;
>  
>  	msi->irq_mask[ctrl] &= ~BIT(bit);
> -	dw_pcie_writel_dbi(pci, PCIE_MSI_INTR0_MASK + res, msi->irq_mask[ctrl]);
> +	dw_msi_writel(msi, PCIE_MSI_INTR0_MASK + res, msi->irq_mask[ctrl]);
>  
>  	raw_spin_unlock_irqrestore(&msi->lock, flags);
>  }
> @@ -153,14 +159,13 @@ static void dw_pci_bottom_unmask(struct irq_data *d)
>  static void dw_pci_bottom_ack(struct irq_data *d)
>  {
>  	struct dw_msi *msi  = irq_data_get_irq_chip_data(d);
> -	struct dw_pcie *pci = to_dw_pcie_from_pp(msi->pp);
>  	unsigned int res, bit, ctrl;
>  
>  	ctrl = d->hwirq / MAX_MSI_IRQS_PER_CTRL;
>  	res = ctrl * MSI_REG_CTRL_BLOCK_SIZE;
>  	bit = d->hwirq % MAX_MSI_IRQS_PER_CTRL;
>  
> -	dw_pcie_writel_dbi(pci, PCIE_MSI_INTR0_STATUS + res, BIT(bit));
> +	dw_msi_writel(msi, PCIE_MSI_INTR0_STATUS + res, BIT(bit));
>  }
>  
>  static struct irq_chip dw_pci_msi_bottom_irq_chip = {
> @@ -262,7 +267,6 @@ void dw_pcie_free_msi(struct dw_msi *msi)
>  
>  void dw_pcie_msi_init(struct dw_msi *msi)
>  {
> -	struct dw_pcie *pci = to_dw_pcie_from_pp(msi->pp);
>  	u32 ctrl, num_ctrls;
>  	u64 msi_target;
>  
> @@ -273,16 +277,16 @@ void dw_pcie_msi_init(struct dw_msi *msi)
>  	num_ctrls = msi->num_vectors / MAX_MSI_IRQS_PER_CTRL;
>  	/* Initialize IRQ Status array */
>  	for (ctrl = 0; ctrl < num_ctrls; ctrl++) {
> -		dw_pcie_writel_dbi(pci, PCIE_MSI_INTR0_MASK +
> +		dw_msi_writel(msi, PCIE_MSI_INTR0_MASK +
>  				(ctrl * MSI_REG_CTRL_BLOCK_SIZE),
>  				msi->irq_mask[ctrl]);
> -		dw_pcie_writel_dbi(pci, PCIE_MSI_INTR0_ENABLE +
> +		dw_msi_writel(msi, PCIE_MSI_INTR0_ENABLE +
>  				(ctrl * MSI_REG_CTRL_BLOCK_SIZE), ~0);
>  	}
>  
>  	/* Program the msi_data */
> -	dw_pcie_writel_dbi(pci, PCIE_MSI_ADDR_LO, lower_32_bits(msi_target));
> -	dw_pcie_writel_dbi(pci, PCIE_MSI_ADDR_HI, upper_32_bits(msi_target));
> +	dw_msi_writel(msi, PCIE_MSI_ADDR_LO, lower_32_bits(msi_target));
> +	dw_msi_writel(msi, PCIE_MSI_ADDR_HI, upper_32_bits(msi_target));
>  }
>  
>  static int dw_pcie_parse_split_msi_irq(struct dw_msi *msi, struct platform_device *pdev)
> @@ -324,7 +328,7 @@ static int dw_pcie_parse_split_msi_irq(struct dw_msi *msi, struct platform_devic
>  }
>  
>  struct dw_msi *dw_pcie_msi_host_init(struct platform_device *pdev,
> -				void *pp, u32 num_vectors)
> +				struct dw_msi_ops *ops, u32 num_vectors)
>  {
>  	struct device *dev = &pdev->dev;
>  	u64 *msi_vaddr = NULL;
> @@ -341,7 +345,7 @@ struct dw_msi *dw_pcie_msi_host_init(struct platform_device *pdev,
>  
>  	raw_spin_lock_init(&msi->lock);
>  	msi->dev = dev;
> -	msi->pp = pp;
> +	msi->msi_ops = ops;
>  	msi->has_msi_ctrl = true;
>  	msi->num_vectors = num_vectors;
>  
> diff --git a/drivers/pci/controller/dwc/pcie-designware-msi.h b/drivers/pci/controller/dwc/pcie-designware-msi.h
> index 633156e..cf5c612 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-msi.h
> +++ b/drivers/pci/controller/dwc/pcie-designware-msi.h
> @@ -18,8 +18,15 @@
>  #define MSI_REG_CTRL_BLOCK_SIZE		12
>  #define MSI_DEF_NUM_VECTORS		32
>  
> +struct dw_msi_ops {
> +	void	*pp;
> +	u32	(*readl_msi)(void *pp, u32 reg);
> +	void	(*writel_msi)(void *pp, u32 reg, u32 val);
> +};
> +
>  struct dw_msi {
>  	struct device		*dev;
> +	struct dw_msi_ops	*msi_ops;
>  	struct irq_domain	*irq_domain;
>  	struct irq_domain	*msi_domain;
>  	struct irq_chip		*msi_irq_chip;
> @@ -31,11 +38,10 @@ struct dw_msi {
>  	DECLARE_BITMAP(msi_irq_in_use, MAX_MSI_IRQS);
>  	bool                    has_msi_ctrl;
>  	void			*private_data;
> -	void			*pp;
>  };
>  
>  struct dw_msi *dw_pcie_msi_host_init(struct platform_device *pdev,
> -			void *pp, u32 num_vectors);
> +			struct dw_msi_ops *ops, u32 num_vectors);
>  int dw_pcie_allocate_domains(struct dw_msi *msi);
>  void dw_pcie_msi_init(struct dw_msi *msi);
>  void dw_pcie_free_msi(struct dw_msi *msi);
> -- 
> 2.7.4
> 

-- 
மணிவண்ணன் சதாசிவம்

