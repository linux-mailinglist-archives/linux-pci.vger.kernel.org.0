Return-Path: <linux-pci+bounces-14188-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA6B8998425
	for <lists+linux-pci@lfdr.de>; Thu, 10 Oct 2024 12:49:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1FC35B21156
	for <lists+linux-pci@lfdr.de>; Thu, 10 Oct 2024 10:49:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D439F1BF33F;
	Thu, 10 Oct 2024 10:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SHcoR2pJ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33BE31BDAA0
	for <linux-pci@vger.kernel.org>; Thu, 10 Oct 2024 10:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728557380; cv=none; b=GNwvvL2f6EZI0zz+YvEBfJLr2FMrwogyqSjq0Runc6uzRziMJmQa3PyQ6QqOpJTWOkmpN4dw5dTMN5MtJLzbFQA4HoWI9AATORCZ9nNde6dZ+htG6wGWl3JmUxv4kw52+TxuQHQ9QRF9E2Af9jDXzyYLB6X1QJDyN2wNTGFvcgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728557380; c=relaxed/simple;
	bh=oO3tyzxv/m02jBIBiVnGB06EetPG6C+FIiSeRhzrB7Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CQxpSQfJ9NleDPYpz0uFXXHnDY6f0cxfpJ63mAeC7Y+tQWWZ3AjK2ICGdZ6n8/ceSxdQhGBjKKCzK3xzUV3VZHoABlLGVY0q6NcbAK1fdnFO+bhypLRhSlW1WAhl90KSHGvvTuK0ZjVyoDr+t9ufKlgdZM2cSiLbprjlyfe9t54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=SHcoR2pJ; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-20b93887decso6718465ad.3
        for <linux-pci@vger.kernel.org>; Thu, 10 Oct 2024 03:49:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728557378; x=1729162178; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=8OP7rFv1ItxJzUjX6NY8zwJJLoQ3wPQcZ92A8zcOhBU=;
        b=SHcoR2pJ79VgN5Q0158H7p7uydq+REKpm55XoaRwpG1vGBx9OeDJHzxMM/fVzG2z4t
         J6xoGg1MCftsVJ37SbXmoWi0qL9G4DQyV2ngtxCE8r8sVKt/fIWGmNTE5o8k9ScB4vOo
         pvYfO5sUTcTw1gOX4ZQ1aYJiLOzAPBr2JIMZKyI3YRiYcdrYncUUMfIO9cBy7wXK+cBn
         hJJ21SNtr9efvfJhBCkrbwy66yEJ/l/url454TExwWCXewW4v0zd1+b4we68uxM8Umed
         lSfoJxz7nSHmVJtWddjRv2fCszwpDGYnmXMBRCvfMwDZDxofgloSVzG144t4NzFxQJ3f
         OLsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728557378; x=1729162178;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8OP7rFv1ItxJzUjX6NY8zwJJLoQ3wPQcZ92A8zcOhBU=;
        b=c9VM4JsH+VJ6DhMy2FN0fPB9hMaQz6n093GI8BzlpzpaOzafX3ca0tg2KPm3ABEojD
         VHZ5OCA6p8zSUHtp2yxhpQa5TQQJMwTVHX0y8jRpVB20HpHtGSPmn6/JjihXRHSwm5nf
         QanX13VII1AjI70UKxeTVHvyUYoPQ0KZtre/2XO2r/LMIkiFyyqrWAmDdIkqsM25rxrS
         sEQAcHSXrc3jc7dg2tW+Vr/GjqskwMv1NGnuEMuKhrOd8Yn4q+kFLDyj2SLG0JagVjYi
         UDmNWxbxK2EFiB8G3BjqYaPDu3eIDbVQUxUZsq0gK+PPhOxBROtJowGJ5S1WN0+vX4/e
         LpAg==
X-Forwarded-Encrypted: i=1; AJvYcCUUgI57RAr+AgKgOkvLVeiA3FBUYwEb5WQAWs1YQ/om2KFUiF+mgG4Tdxvia8xmUge84YELT5Bzrc8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+hAigakXnibCwyWi2lC/mtPRv2QXtZAre588WPvSm7xkHi+XF
	vqzl5fnFkNUdHX7NnJsrzZC7RzH1zpkHrdEcKdoHiPpdvasfMaqdgkyBk/5p9A==
X-Google-Smtp-Source: AGHT+IGJjVtOiKbr25esMOTIqockU31uxYYocHnt+AMIt4sX47lPwC3evjefw2bFIO7rvf8rBony3w==
X-Received: by 2002:a17:902:e842:b0:208:d856:dbb7 with SMTP id d9443c01a7336-20c6377c6b9mr76048285ad.39.1728557378381;
        Thu, 10 Oct 2024 03:49:38 -0700 (PDT)
Received: from thinkpad ([220.158.156.184])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20c8bad33d6sm7438735ad.33.2024.10.10.03.49.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2024 03:49:38 -0700 (PDT)
Date: Thu, 10 Oct 2024 16:19:32 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>, linux-pci@vger.kernel.org,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	Rick Wertenbroek <rick.wertenbroek@gmail.com>,
	Wilfred Mallawa <wilfred.mallawa@wdc.com>,
	Niklas Cassel <cassel@kernel.org>
Subject: Re: [PATCH v3 12/12] PCI: rockchip-ep: Handle PERST# signal in
 endpoint mode
Message-ID: <20241010104932.gfrunorhpnhan5wp@thinkpad>
References: <20241007041218.157516-1-dlemoal@kernel.org>
 <20241007041218.157516-13-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241007041218.157516-13-dlemoal@kernel.org>

On Mon, Oct 07, 2024 at 01:12:18PM +0900, Damien Le Moal wrote:
> Currently, the Rockchip PCIe endpoint controller driver does not handle
> PERST# signal, which prevents detecting when link training should
> actually be started or if the host reset the device. This however can
> be supported using the controller ep_gpio, set as an input GPIO for
> endpoint mode.
> 
> Modify the endpoint rockchip driver to get the ep_gpio and its
> associated interrupt which is serviced using a threaded IRQ with the
> function rockchip_pcie_ep_perst_irq_thread() as handler.
> 
> This handler function notifies a link down event corresponding to the RC
> side asserting the PERST# signal using pci_epc_linkdown() when the gpio
> is high. Once the gpio value goes down, corresponding to the RC
> de-asserting the PERST# signal, link training is started. The polarity
> of the gpio interrupt trigger is changed from high to low after the RC
> asserted PERST#, and conversely changed from low to high after the RC
> de-asserts PERST#.
> 
> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>

Just minor nits below. Overall LGTM.

> ---
>  drivers/pci/controller/pcie-rockchip-ep.c | 118 +++++++++++++++++++++-
>  drivers/pci/controller/pcie-rockchip.c    |  12 +--
>  2 files changed, 122 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/pci/controller/pcie-rockchip-ep.c b/drivers/pci/controller/pcie-rockchip-ep.c
> index af50432525b4..c70a64c37a56 100644
> --- a/drivers/pci/controller/pcie-rockchip-ep.c
> +++ b/drivers/pci/controller/pcie-rockchip-ep.c
> @@ -18,6 +18,7 @@
>  #include <linux/sizes.h>
>  #include <linux/workqueue.h>
>  #include <linux/iopoll.h>
> +#include <linux/gpio/consumer.h>

Please sort the includes.

>  
>  #include "pcie-rockchip.h"
>  
> @@ -50,6 +51,9 @@ struct rockchip_pcie_ep {
>  	u64			irq_pci_addr;
>  	u8			irq_pci_fn;
>  	u8			irq_pending;
> +	int			perst_irq;
> +	bool			perst_asserted;
> +	bool			link_up;
>  	struct delayed_work	link_training;
>  };
>  
> @@ -462,13 +466,17 @@ static int rockchip_pcie_ep_start(struct pci_epc *epc)
>  
>  	rockchip_pcie_write(rockchip, cfg, PCIE_CORE_PHY_FUNC_CFG);
>  
> +	if (rockchip->ep_gpio)
> +		enable_irq(ep->perst_irq);
> +
>  	/* Enable configuration and start link training */
>  	rockchip_pcie_write(rockchip,
>  			    PCIE_CLIENT_LINK_TRAIN_ENABLE |
>  			    PCIE_CLIENT_CONF_ENABLE,
>  			    PCIE_CLIENT_CONFIG);
>  
> -	schedule_delayed_work(&ep->link_training, 0);
> +	if (!rockchip->ep_gpio)
> +		schedule_delayed_work(&ep->link_training, 0);
>  
>  	return 0;
>  }
> @@ -478,6 +486,11 @@ static void rockchip_pcie_ep_stop(struct pci_epc *epc)
>  	struct rockchip_pcie_ep *ep = epc_get_drvdata(epc);
>  	struct rockchip_pcie *rockchip = &ep->rockchip;
>  
> +	if (rockchip->ep_gpio) {
> +		ep->perst_asserted = true;
> +		disable_irq(ep->perst_irq);
> +	}
> +
>  	cancel_delayed_work_sync(&ep->link_training);
>  
>  	/* Stop link training and disable configuration */
> @@ -540,6 +553,13 @@ static void rockchip_pcie_ep_link_training(struct work_struct *work)
>  	if (!rockchip_pcie_ep_link_up(rockchip))
>  		goto again;
>  
> +	/*
> +	 * If PERST was asserted while polling the link, do not notify
> +	 * the function.
> +	 */
> +	if (ep->perst_asserted)
> +		return;
> +
>  	val = rockchip_pcie_read(rockchip, PCIE_CLIENT_BASIC_STATUS0);
>  	dev_info(dev,
>  		 "Link UP (Negociated speed: %sGT/s, width: x%lu)\n",
> @@ -549,6 +569,7 @@ static void rockchip_pcie_ep_link_training(struct work_struct *work)
>  
>  	/* Notify the function */
>  	pci_epc_linkup(ep->epc);
> +	ep->link_up = true;
>  
>  	return;
>  
> @@ -556,6 +577,94 @@ static void rockchip_pcie_ep_link_training(struct work_struct *work)
>  	schedule_delayed_work(&ep->link_training, msecs_to_jiffies(5));
>  }
>  
> +static void rockchip_pcie_ep_perst_assert(struct rockchip_pcie_ep *ep)
> +{
> +	struct rockchip_pcie *rockchip = &ep->rockchip;
> +	struct device *dev = rockchip->dev;
> +
> +	dev_dbg(dev, "PERST asserted, link down\n");
> +
> +	if (ep->perst_asserted)
> +		return;
> +
> +	ep->perst_asserted = true;
> +
> +	cancel_delayed_work_sync(&ep->link_training);
> +
> +	if (ep->link_up) {
> +		pci_epc_linkdown(ep->epc);
> +		ep->link_up = false;
> +	}
> +}
> +
> +static void rockchip_pcie_ep_perst_deassert(struct rockchip_pcie_ep *ep)
> +{
> +	struct rockchip_pcie *rockchip = &ep->rockchip;
> +	struct device *dev = rockchip->dev;
> +
> +	dev_dbg(dev, "PERST de-asserted, starting link training\n");
> +
> +	if (!ep->perst_asserted)
> +		return;
> +
> +	ep->perst_asserted = false;
> +
> +	/* Enable link re-training */
> +	rockchip_pcie_ep_retrain_link(rockchip);
> +

I hope that no registers are getting reset post PERST# assert.

> +	/* Start link training */
> +	schedule_delayed_work(&ep->link_training, 0);
> +}
> +
> +static irqreturn_t rockchip_pcie_ep_perst_irq_thread(int irq, void *data)
> +{
> +	struct pci_epc *epc = data;
> +	struct rockchip_pcie_ep *ep = epc_get_drvdata(epc);
> +	struct rockchip_pcie *rockchip = &ep->rockchip;
> +	u32 perst = gpiod_get_value(rockchip->ep_gpio);
> +
> +	if (perst)
> +		rockchip_pcie_ep_perst_assert(ep);
> +	else
> +		rockchip_pcie_ep_perst_deassert(ep);
> +
> +	irq_set_irq_type(ep->perst_irq,
> +			 (perst ? IRQF_TRIGGER_HIGH : IRQF_TRIGGER_LOW));
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static int rockchip_pcie_ep_setup_irq(struct pci_epc *epc)
> +{
> +	struct rockchip_pcie_ep *ep = epc_get_drvdata(epc);
> +	struct rockchip_pcie *rockchip = &ep->rockchip;
> +	struct device *dev = rockchip->dev;
> +	int ret;
> +
> +	if (!rockchip->ep_gpio)
> +		return 0;
> +
> +	/* PCIe reset interrupt */
> +	ep->perst_irq = gpiod_to_irq(rockchip->ep_gpio);
> +	if (ep->perst_irq < 0) {
> +		dev_err(dev, "No corresponding IRQ for PERST GPIO\n");
> +		return ep->perst_irq;
> +	}
> +
> +	ep->perst_asserted = true;

How come?

> +	irq_set_status_flags(ep->perst_irq, IRQ_NOAUTOEN);
> +	ret = devm_request_threaded_irq(dev, ep->perst_irq, NULL,
> +					rockchip_pcie_ep_perst_irq_thread,
> +					IRQF_TRIGGER_HIGH | IRQF_ONESHOT,
> +					"pcie-ep-perst", epc);
> +	if (ret) {
> +		dev_err(dev, "Request PERST GPIO IRQ failed %d\n", ret);
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
>  static const struct pci_epc_features rockchip_pcie_epc_features = {
>  	.linkup_notifier = true,
>  	.msi_capable = true,
> @@ -719,6 +828,7 @@ static int rockchip_pcie_ep_probe(struct platform_device *pdev)
>  	rockchip->is_rc = false;
>  	rockchip->dev = dev;
>  	INIT_DELAYED_WORK(&ep->link_training, rockchip_pcie_ep_link_training);
> +	ep->link_up = false;

'false' is the default state, isn't it?

- Mani

-- 
மணிவண்ணன் சதாசிவம்

