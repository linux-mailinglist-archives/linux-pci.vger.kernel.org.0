Return-Path: <linux-pci+bounces-12727-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 535D096B6AB
	for <lists+linux-pci@lfdr.de>; Wed,  4 Sep 2024 11:30:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 860A81C21C42
	for <lists+linux-pci@lfdr.de>; Wed,  4 Sep 2024 09:30:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 250EF1CEAA8;
	Wed,  4 Sep 2024 09:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b3P4OZcS"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E90C31CCB55;
	Wed,  4 Sep 2024 09:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725442192; cv=none; b=pvdcFwRiDRJVqGWmnn42oPX8jTr+NwL5HtI3FIWyU60SCIWl9qW48Nu4cUwA4BVZW6UuaGDk+UBl5nxepqUgKVutHgtNB0sqK4FdYaMevvATZyOaHcMBux0hZa02DO3xaVvWi7WDOLpRYqRLn5PPuT55wNzIp/1iTp2cpZZLtLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725442192; c=relaxed/simple;
	bh=54V5tRrYnwlqE+z9YtX9ph4B2JFbbRsCj+benJAsYwI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PawGwwAAkFxn3uR40uUajnZk2AmgTcH9PElZ0WT1DqkcJ8jsnlZwlYUbApLBTTnHcLDz3Sj7D8alZAp62C1dWaqv1n0kucSdC5VOGLaJAIVB9QL+9sUXhDgdGLQa9yybwif93n/zPf+llej2d87iy541wutzEwBFz2YuM6jXeg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b3P4OZcS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 661DEC4CEC9;
	Wed,  4 Sep 2024 09:29:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725442191;
	bh=54V5tRrYnwlqE+z9YtX9ph4B2JFbbRsCj+benJAsYwI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=b3P4OZcSIc7hjw+laxcYBj+S8AnEW9jJSxdE8ThEa6t1hCN6DSSGfvwYqDFZxKRD2
	 jjoK8Eho5TznssDQUROcxeeOPU/BYAK1KB9nsO5nWLdbE0zifFTZeDJbpvrSKkI7Ss
	 yNzW+rC+VdhAGS0blclB2qCJ/ZNJdJs7QRmpl3QoyzYapQUzyBMcimMWH+3gVEs0mC
	 tWq/GAFlNri3UTqQ1kUFD+YDplxEPSxKwe7vnzYS0q+0hfW8cDQtXg3NLIESmF8J0h
	 vYuOzh4mgE4E7nAPCt0AlmaYz4oKSY0zR0HcQS4/Nq1F/wfzj9LdxdhaHg0hadtoA4
	 PIw5M+ypS+nxw==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1slmL2-000000001tc-18qO;
	Wed, 04 Sep 2024 11:30:08 +0200
Date: Wed, 4 Sep 2024 11:30:08 +0200
From: Johan Hovold <johan@kernel.org>
To: manivannan.sadhasivam@linaro.org
Cc: Richard Zhu <hongxing.zhu@nxp.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Jingoo Han <jingoohan1@gmail.com>,
	Chuanhua Lei <lchuanhua@maxlinear.com>,
	Marek Vasut <marek.vasut+renesas@gmail.com>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	abel.vesa@linaro.org, johan+linaro@kernel.org,
	Shashank Babu Chinta Venkata <quic_schintav@quicinc.com>
Subject: Re: [PATCH v6 2/4] PCI: dwc: Always cache the maximum link speed
 value in dw_pcie::max_link_speed
Message-ID: <ZtgooHdex5gXh0tP@hovoldconsulting.com>
References: <20240904-pci-qcom-gen4-stability-v6-0-ec39f7ae3f62@linaro.org>
 <20240904-pci-qcom-gen4-stability-v6-2-ec39f7ae3f62@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240904-pci-qcom-gen4-stability-v6-2-ec39f7ae3f62@linaro.org>

On Wed, Sep 04, 2024 at 12:41:58PM +0530, Manivannan Sadhasivam via B4 Relay wrote:
> From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> 
> Currently, dw_pcie::max_link_speed has a valid value only if the controller
> driver restricts the maximum link speed in the driver or if the platform
> does so in the devicetree using the 'max-link-speed' property.
> 
> But having the maximum supported link speed of the platform would be
> helpful for the vendor drivers to configure any link specific settings.
> So in the case of non-valid value in dw_pcie::max_link_speed, just cache
> the hardware default value from Link Capability register.
> 
> While at it, let's also remove the 'max_link_speed' argument to the
> dw_pcie_link_set_max_speed() function since the value can be retrieved
> within the function.
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  drivers/pci/controller/dwc/pcie-designware.c | 18 ++++++++++++++----
>  1 file changed, 14 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
> index 86c49ba097c6..0704853daa85 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.c
> +++ b/drivers/pci/controller/dwc/pcie-designware.c
> @@ -687,16 +687,27 @@ void dw_pcie_upconfig_setup(struct dw_pcie *pci)
>  }
>  EXPORT_SYMBOL_GPL(dw_pcie_upconfig_setup);
>  
> -static void dw_pcie_link_set_max_speed(struct dw_pcie *pci, u32 max_link_speed)
> +static void dw_pcie_link_set_max_speed(struct dw_pcie *pci)
>  {
>  	u32 cap, ctrl2, link_speed;
>  	u8 offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
>  
>  	cap = dw_pcie_readl_dbi(pci, offset + PCI_EXP_LNKCAP);
> +
> +	/*
> +	 * Even if the platform doesn't want to limit the maximum link speed,
> +	 * just cache the hardware default value so that the vendor drivers can
> +	 * use it to do any link specific configuration.
> +	 */
> +	if (pci->max_link_speed < 0) {

This should be 

	if (pci->max_link_speed < 1) {

but the patch works as-is because of the default case in the switch
below which falls back to PCI_EXP_LNKCAP_SLS.

> +		pci->max_link_speed = FIELD_GET(PCI_EXP_LNKCAP_SLS, cap);
> +		return;
> +	}
> +
>  	ctrl2 = dw_pcie_readl_dbi(pci, offset + PCI_EXP_LNKCTL2);
>  	ctrl2 &= ~PCI_EXP_LNKCTL2_TLS;
>  
> -	switch (pcie_link_speed[max_link_speed]) {
> +	switch (pcie_link_speed[pci->max_link_speed]) {
>  	case PCIE_SPEED_2_5GT:
>  		link_speed = PCI_EXP_LNKCTL2_TLS_2_5GT;
>  		break;

> @@ -1058,8 +1069,7 @@ void dw_pcie_setup(struct dw_pcie *pci)
>  {
>  	u32 val;
>  
> -	if (pci->max_link_speed > 0)
> -		dw_pcie_link_set_max_speed(pci, pci->max_link_speed);
> +	dw_pcie_link_set_max_speed(pci);

With the above fixed:

Reviewed-by: Johan Hovold <johan+linaro@kernel.org>

