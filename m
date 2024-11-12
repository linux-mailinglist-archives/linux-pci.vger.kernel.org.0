Return-Path: <linux-pci+bounces-16604-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E74319C6587
	for <lists+linux-pci@lfdr.de>; Wed, 13 Nov 2024 00:53:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8A005B329A6
	for <lists+linux-pci@lfdr.de>; Tue, 12 Nov 2024 21:43:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9698B20C460;
	Tue, 12 Nov 2024 21:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zwgf7eGD"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EF7543AA1;
	Tue, 12 Nov 2024 21:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731447819; cv=none; b=tMtvVRKNTTmeDcZyx4jKSa5VP6bmAVerkGD9/OEbTsVP/N2DwoSGzr+NvEzo2DflQar8g/fAz3kkrjFPD/xCTR//XoN281g5PYtsG6Y17sAhZt6E5fSJKdD1+PekKrFfNKdkZ36gtblSny6ECCbJWYYWx1aJUAk1ONxP2snXXAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731447819; c=relaxed/simple;
	bh=TSBvSL3F8utvdtRSv0V0b72Rr2Qwe8DnowxnXL+/4GU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=Rf5kQjLJfgEAIN/XU6oM+X8askCTOT0HnVraWAS0SzShYHXsCOvrwDrYp30OYMvKdBqdvyBKjUb/8QOkbPKPPB0GUpesY/PbtiVAij2S7z29q2ezbQYvTjqZUeqO6+BpYMWNXhuZiTiL1oo9XtHB4RA8mK2591XBfT/53aJzUPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zwgf7eGD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE84EC4CECD;
	Tue, 12 Nov 2024 21:43:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731447819;
	bh=TSBvSL3F8utvdtRSv0V0b72Rr2Qwe8DnowxnXL+/4GU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=Zwgf7eGDinLJJQzHU5fzK0CcK8hMSQrpqCuhZlg5fCb9cZyYhPFFEaf5s1Jioe20y
	 dtIgb9DZHNR3rivnptyX2Q3U9V6ySlrzPyuu2V9GbpfouD2cLKom+s8ZjMocS4Y5/7
	 hlUW9sEc92udhXpwDVyMGoIdLA3/WShXbAxKRuUhIKuf9Y1shUh9VCV61EWCLjHLlD
	 OUyFCvw7gNvZPdYLVoXY5BT84gPmgGkKoepMdRiKP+POu45iD+rN1eexkEVSX2M0A6
	 XxfB/BW2DZZFZds0G7xrv/TpVMQd5k8AKjidTo5cOZHuWn6l8u8X0C8fbo9jFin1pq
	 JNOvJD0KBeA7g==
Date: Tue, 12 Nov 2024 15:43:37 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Jenishkumar Maheshbhai Patel <jpatel2@marvell.com>
Cc: lpieralisi@kernel.org, thomas.petazzoni@bootlin.com, kw@linux.com,
	manivannan.sadhasivam@linaro.org, robh@kernel.org,
	bhelgaas@google.com, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	salee@marvell.com, dingwei@marvell.com
Subject: Re: [PATCH 1/1] PCI: armada8k: Disable LTSSM on link down interrupts
Message-ID: <20241112214337.GA1861873@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241112064241.749493-1-jpatel2@marvell.com>

On Mon, Nov 11, 2024 at 10:42:41PM -0800, Jenishkumar Maheshbhai Patel wrote:
> When a PCI link down condition is detected, the link training state
> machine must be disabled immediately.

Why?

"Immediately" has no meaning here.  Arbitrary delays are possible and
must not break anything.

> Signed-off-by: Jenishkumar Maheshbhai Patel <jpatel2@marvell.com>
> ---
>  drivers/pci/controller/dwc/pcie-armada8k.c | 38 ++++++++++++++++++++++
>  1 file changed, 38 insertions(+)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-armada8k.c b/drivers/pci/controller/dwc/pcie-armada8k.c
> index b5c599ccaacf..07775539b321 100644
> --- a/drivers/pci/controller/dwc/pcie-armada8k.c
> +++ b/drivers/pci/controller/dwc/pcie-armada8k.c
> @@ -53,6 +53,10 @@ struct armada8k_pcie {
>  #define PCIE_INT_C_ASSERT_MASK		BIT(11)
>  #define PCIE_INT_D_ASSERT_MASK		BIT(12)
>  
> +#define PCIE_GLOBAL_INT_CAUSE2_REG	(PCIE_VENDOR_REGS_OFFSET + 0x24)
> +#define PCIE_GLOBAL_INT_MASK2_REG	(PCIE_VENDOR_REGS_OFFSET + 0x28)
> +#define PCIE_INT2_PHY_RST_LINK_DOWN	BIT(1)
> +
>  #define PCIE_ARCACHE_TRC_REG		(PCIE_VENDOR_REGS_OFFSET + 0x50)
>  #define PCIE_AWCACHE_TRC_REG		(PCIE_VENDOR_REGS_OFFSET + 0x54)
>  #define PCIE_ARUSER_REG			(PCIE_VENDOR_REGS_OFFSET + 0x5C)
> @@ -204,6 +208,11 @@ static int armada8k_pcie_host_init(struct dw_pcie_rp *pp)
>  	       PCIE_INT_C_ASSERT_MASK | PCIE_INT_D_ASSERT_MASK;
>  	dw_pcie_writel_dbi(pci, PCIE_GLOBAL_INT_MASK1_REG, reg);
>  
> +	/* Also enable link down interrupts */
> +	reg = dw_pcie_readl_dbi(pci, PCIE_GLOBAL_INT_MASK2_REG);
> +	reg |= PCIE_INT2_PHY_RST_LINK_DOWN;
> +	dw_pcie_writel_dbi(pci, PCIE_GLOBAL_INT_MASK2_REG, reg);
> +
>  	return 0;
>  }
>  
> @@ -221,6 +230,35 @@ static irqreturn_t armada8k_pcie_irq_handler(int irq, void *arg)
>  	val = dw_pcie_readl_dbi(pci, PCIE_GLOBAL_INT_CAUSE1_REG);
>  	dw_pcie_writel_dbi(pci, PCIE_GLOBAL_INT_CAUSE1_REG, val);
>  
> +	val = dw_pcie_readl_dbi(pci, PCIE_GLOBAL_INT_CAUSE2_REG);
> +
> +	if (PCIE_INT2_PHY_RST_LINK_DOWN & val) {
> +		u32 ctrl_reg = dw_pcie_readl_dbi(pci, PCIE_GLOBAL_CONTROL_REG);

Add blank line.

> +		/*
> +		 * The link went down. Disable LTSSM immediately. This
> +		 * unlocks the root complex config registers. Downstream
> +		 * device accesses will return all-Fs
> +		 */
> +		ctrl_reg &= ~(PCIE_APP_LTSSM_EN);
> +		dw_pcie_writel_dbi(pci, PCIE_GLOBAL_CONTROL_REG, ctrl_reg);

And here.

> +		/*
> +		 * Mask link down interrupts. They can be re-enabled once
> +		 * the link is retrained.
> +		 */
> +		ctrl_reg = dw_pcie_readl_dbi(pci, PCIE_GLOBAL_INT_MASK2_REG);
> +		ctrl_reg &= ~PCIE_INT2_PHY_RST_LINK_DOWN;
> +		dw_pcie_writel_dbi(pci, PCIE_GLOBAL_INT_MASK2_REG, ctrl_reg);

And here.  Follow existing coding style in this file.

> +		/*
> +		 * At this point a worker thread can be triggered to
> +		 * initiate a link retrain. If link retrains were
> +		 * possible, that is.
> +		 */
> +		dev_dbg(pci->dev, "%s: link went down\n", __func__);
> +	}
> +
> +	/* Now clear the second interrupt cause. */
> +	dw_pcie_writel_dbi(pci, PCIE_GLOBAL_INT_CAUSE2_REG, val);
> +
>  	return IRQ_HANDLED;
>  }
>  
> -- 
> 2.25.1
> 

