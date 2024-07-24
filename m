Return-Path: <linux-pci+bounces-10722-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D35E93B1E9
	for <lists+linux-pci@lfdr.de>; Wed, 24 Jul 2024 15:47:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0E4F7B2173F
	for <lists+linux-pci@lfdr.de>; Wed, 24 Jul 2024 13:47:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E66E158D86;
	Wed, 24 Jul 2024 13:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="h7tkJN0I"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A207113E020
	for <linux-pci@vger.kernel.org>; Wed, 24 Jul 2024 13:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721828856; cv=none; b=LpRdM9i34DlpBupgkhLQ1htMt32f2nrKE+Iql9JdlK1j8Fgy1anSA2Yc3zYsJUk+dGFqf7DgQ1NvD2mqGdLmO7ZiHiiskGwW2mEv//dM5ZClpGliAw+TFK9lnXa3ZcLYXDTfBbgVQpiEgPGfzs7C5LCugUMWp0QeMrswkHbg3RA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721828856; c=relaxed/simple;
	bh=xjWm/eDlWeqPzKSEQS2S0Ya+3sWJ6iqZgAKGHCaMITE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U5WgU+9kvvSsy3bmwOBUShFdcY+Iuwq4X28YPbf7mdT67ytSPMZJV/mvvtLvHJNRsqAvTTAlcHY9kNtnHtjlCJKTDUUWUt3nfh8NKkMEQzffow4zgTJq3Oq8MWiI9phcDR//Nz7rSpJCWhPTVByhJIeGCOvgrL5jH5tpziKy88s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=h7tkJN0I; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1fc52394c92so18757905ad.1
        for <linux-pci@vger.kernel.org>; Wed, 24 Jul 2024 06:47:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721828854; x=1722433654; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=SjlS3KeN9meLLfSQsSaPi/f/kHzcBW78TFSUcPryCjM=;
        b=h7tkJN0IXAmZSDVDgQOpeqfw+8fvEIc3K1Sbftr9/y0yr79iR+NCNt33saVsG1zH+Z
         fMBSAvmZ+HthOyrGq/J8fiQhuggVeJDZkNx9dZMRxXMSLDVYyn8Rw/h5Sef+QszH30Lg
         6K4XgaDxEe8PlovPdua7+GVEx0iaBo7NRBdqS6ShNyG1ngwkSWKAjmSy2VgKlg/jIXEz
         iWM8hn0W6YrN13X5Zgp//JjFslD0GJK3urRYc+pxE+MjAMPv9sDFvhsReSodr4HZO6iL
         dejcqC8zG9pVucrHnWh1Ejy/FlWkKhe/eaXgMkQioAxsZqCTlkk6V9EMCxX2HfKp97b1
         L6Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721828854; x=1722433654;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SjlS3KeN9meLLfSQsSaPi/f/kHzcBW78TFSUcPryCjM=;
        b=V8eWvKctHIbrpSvGgIBTF7Psn7CjmRJJ7FBbNd+hkE5mL3DTBgmjnhJgHH1ZHWYw4u
         NBJUZuLG/BW+SCm9iufA2Aa+i6+li9DL4V7dAUNGu0i8HYPC+j4z/7C1RfpTkjLCYk5r
         3dAJbxGQVCzbPZlBvZ1TRlnBW5NvXFO1ScbbKKtGJUIZKE2SPouf6SnjNC+jazkd4k/M
         tSWxOPpsnjqw7cVO+OKMJlu411BIz21KV34K9gx+f0i/KH3YJxAoMTodfYPfTn5qfjdp
         havSdaSk7kriniattII2DhipIa0wbaCQMml2ycwWdoxPNqr5nO6FvyStrpKf0/Nyipdo
         DZCw==
X-Gm-Message-State: AOJu0Yxoj/cI37foetor2qCR64JmHMX+TZX1eTH65toC7BOmJ0FC9VH0
	Bj7ICj0NkIwSlpRyyGe1YUZ4p/qTj0UAiNIv3Spn6k1WBLCjiGKQbMMKYLQvNQ==
X-Google-Smtp-Source: AGHT+IGQ1pRozmQ8WsiHI1I3zmEDTN6hvlFln3KcelbKxSnwPg41LAbjogxZsXYR2+UZUvCxUcYACA==
X-Received: by 2002:a17:903:244a:b0:1fc:2ee3:d45a with SMTP id d9443c01a7336-1fdd54f46f3mr24825785ad.8.1721828853831;
        Wed, 24 Jul 2024 06:47:33 -0700 (PDT)
Received: from thinkpad ([103.244.168.26])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fd6f44f4c4sm94151845ad.224.2024.07.24.06.47.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jul 2024 06:47:33 -0700 (PDT)
Date: Wed, 24 Jul 2024 19:17:21 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: linux-pci@vger.kernel.org,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>,
	Aleksandr Mishin <amishin@t-argos.ru>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Anup Patel <apatel@ventanamicro.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Daire McNamara <daire.mcnamara@microchip.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
	Jianjun Wang <jianjun.wang@mediatek.com>,
	Jim Quinlan <jim2101024@gmail.com>,
	Jingoo Han <jingoohan1@gmail.com>,
	Jisheng Zhang <Jisheng.Zhang@synaptics.com>,
	Jon Hunter <jonathanh@nvidia.com>,
	Jonathan Derrick <jonathan.derrick@linux.dev>,
	Joyce Ooi <joyce.ooi@intel.com>,
	Karthikeyan Mitran <m.karthikeyan@mobiveil.co.in>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Koichiro Den <den@valinux.co.jp>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Marc Zyngier <maz@kernel.org>, Michal Simek <michal.simek@amd.com>,
	Nicolas Saenz Julienne <nsaenz@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	Nipun Gupta <nipun.gupta@amd.com>,
	Nirmal Patel <nirmal.patel@linux.intel.com>,
	Rob Herring <robh@kernel.org>, Ryder Lee <ryder.lee@mediatek.com>,
	Shivamurthy Shastri <shivamurthy.shastri@linutronix.de>,
	Siddharth Vadapalli <s-vadapalli@ti.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	linux-renesas-soc@vger.kernel.org,
	linux-rpi-kernel@lists.infradead.org, linux-tegra@vger.kernel.org
Subject: Re: [PATCH v4 05/15] PCI: dwc: Silence set affinity failed warning
Message-ID: <20240724134721.GC3349@thinkpad>
References: <20240723132958.41320-1-marek.vasut+renesas@mailbox.org>
 <20240723132958.41320-6-marek.vasut+renesas@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240723132958.41320-6-marek.vasut+renesas@mailbox.org>

On Tue, Jul 23, 2024 at 03:27:05PM +0200, Marek Vasut wrote:
> Use newly introduced MSI_FLAG_NO_AFFINITY, which keeps .irq_set_affinity unset
> and allows migrate_one_irq() code in cpuhotplug.c to exit right away, without
> printing "IRQ...: set affinity failed(-22)" warning.
> 
> Remove .irq_set_affinity implementation which only return -EINVAL from this
> controller driver.
> 
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> ---
> Cc: "Krzysztof Wilczyński" <kw@linux.com>
> Cc: "Pali Rohár" <pali@kernel.org>
> Cc: "Uwe Kleine-König" <u.kleine-koenig@pengutronix.de>
> Cc: Aleksandr Mishin <amishin@t-argos.ru>
> Cc: Anna-Maria Behnsen <anna-maria@linutronix.de>
> Cc: Anup Patel <apatel@ventanamicro.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
> Cc: Daire McNamara <daire.mcnamara@microchip.com>
> Cc: Damien Le Moal <dlemoal@kernel.org>
> Cc: Florian Fainelli <florian.fainelli@broadcom.com>
> Cc: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> Cc: Jianjun Wang <jianjun.wang@mediatek.com>
> Cc: Jim Quinlan <jim2101024@gmail.com>
> Cc: Jingoo Han <jingoohan1@gmail.com>
> Cc: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
> Cc: Jon Hunter <jonathanh@nvidia.com>
> Cc: Jonathan Derrick <jonathan.derrick@linux.dev>
> Cc: Jonathan Hunter <jonathanh@nvidia.com>
> Cc: Joyce Ooi <joyce.ooi@intel.com>
> Cc: Karthikeyan Mitran <m.karthikeyan@mobiveil.co.in>
> Cc: Kishon Vijay Abraham I <kishon@kernel.org>
> Cc: Koichiro Den <den@valinux.co.jp>
> Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>
> Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> Cc: Marc Zyngier <maz@kernel.org>
> Cc: Michal Simek <michal.simek@amd.com>
> Cc: Nicolas Saenz Julienne <nsaenz@kernel.org>
> Cc: Niklas Cassel <cassel@kernel.org>
> Cc: Nipun Gupta <nipun.gupta@amd.com>
> Cc: Nirmal Patel <nirmal.patel@linux.intel.com>
> Cc: Rob Herring <robh@kernel.org>
> Cc: Ryder Lee <ryder.lee@mediatek.com>
> Cc: Shivamurthy Shastri <shivamurthy.shastri@linutronix.de>
> Cc: Siddharth Vadapalli <s-vadapalli@ti.com>
> Cc: Thierry Reding <thierry.reding@gmail.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
> Cc: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-mediatek@lists.infradead.org
> Cc: linux-pci@vger.kernel.org
> Cc: linux-renesas-soc@vger.kernel.org
> Cc: linux-rpi-kernel@lists.infradead.org
> Cc: linux-tegra@vger.kernel.org
> ---
> V4: - New patch
> ---
>  drivers/pci/controller/dwc/pci-keystone.c         |  7 -------
>  drivers/pci/controller/dwc/pcie-designware-host.c | 12 +++---------
>  2 files changed, 3 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pci-keystone.c b/drivers/pci/controller/dwc/pci-keystone.c
> index 52c6420ae2003..ce9d9e0a52609 100644
> --- a/drivers/pci/controller/dwc/pci-keystone.c
> +++ b/drivers/pci/controller/dwc/pci-keystone.c
> @@ -189,12 +189,6 @@ static void ks_pcie_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
>  		(int)data->hwirq, msg->address_hi, msg->address_lo);
>  }
>  
> -static int ks_pcie_msi_set_affinity(struct irq_data *irq_data,
> -				    const struct cpumask *mask, bool force)
> -{
> -	return -EINVAL;
> -}
> -
>  static void ks_pcie_msi_mask(struct irq_data *data)
>  {
>  	struct dw_pcie_rp *pp = irq_data_get_irq_chip_data(data);
> @@ -247,7 +241,6 @@ static struct irq_chip ks_pcie_msi_irq_chip = {
>  	.name = "KEYSTONE-PCI-MSI",
>  	.irq_ack = ks_pcie_msi_irq_ack,
>  	.irq_compose_msi_msg = ks_pcie_compose_msi_msg,
> -	.irq_set_affinity = ks_pcie_msi_set_affinity,
>  	.irq_mask = ks_pcie_msi_mask,
>  	.irq_unmask = ks_pcie_msi_unmask,
>  };
> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> index a0822d5371bc5..3e41865c72904 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> @@ -48,8 +48,9 @@ static struct irq_chip dw_pcie_msi_irq_chip = {
>  };
>  
>  static struct msi_domain_info dw_pcie_msi_domain_info = {
> -	.flags	= (MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_USE_DEF_CHIP_OPS |
> -		   MSI_FLAG_PCI_MSIX | MSI_FLAG_MULTI_PCI_MSI),
> +	.flags	= MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_USE_DEF_CHIP_OPS |
> +		  MSI_FLAG_NO_AFFINITY | MSI_FLAG_PCI_MSIX |
> +		  MSI_FLAG_MULTI_PCI_MSI,
>  	.chip	= &dw_pcie_msi_irq_chip,
>  };
>  
> @@ -116,12 +117,6 @@ static void dw_pci_setup_msi_msg(struct irq_data *d, struct msi_msg *msg)
>  		(int)d->hwirq, msg->address_hi, msg->address_lo);
>  }
>  
> -static int dw_pci_msi_set_affinity(struct irq_data *d,
> -				   const struct cpumask *mask, bool force)
> -{
> -	return -EINVAL;
> -}
> -
>  static void dw_pci_bottom_mask(struct irq_data *d)
>  {
>  	struct dw_pcie_rp *pp = irq_data_get_irq_chip_data(d);
> @@ -177,7 +172,6 @@ static struct irq_chip dw_pci_msi_bottom_irq_chip = {
>  	.name = "DWPCI-MSI",
>  	.irq_ack = dw_pci_bottom_ack,
>  	.irq_compose_msi_msg = dw_pci_setup_msi_msg,
> -	.irq_set_affinity = dw_pci_msi_set_affinity,
>  	.irq_mask = dw_pci_bottom_mask,
>  	.irq_unmask = dw_pci_bottom_unmask,
>  };
> -- 
> 2.43.0
> 

-- 
மணிவண்ணன் சதாசிவம்

