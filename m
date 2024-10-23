Return-Path: <linux-pci+bounces-15147-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E5E49AD413
	for <lists+linux-pci@lfdr.de>; Wed, 23 Oct 2024 20:36:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0EB451F2206B
	for <lists+linux-pci@lfdr.de>; Wed, 23 Oct 2024 18:36:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B86CC1CFEC7;
	Wed, 23 Oct 2024 18:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cpu7Z75U"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9056312DD88;
	Wed, 23 Oct 2024 18:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729708589; cv=none; b=cL6647UK64rbuSqP2emUnGurAqoET05b3RhUtyjX7a5RDKScEmvaYppYjDvUcLCF7FdXC7qLDri5P66WBWo6eT5uYVznyoA3wuQkNspcodjstdG14vsXBgPFY6ooCBbSnRj7LQU4jyxrkafven3ukbuHJngYEpSCr3jwcAvR4nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729708589; c=relaxed/simple;
	bh=wP2zKX+Yi3XkHbWYph2Q2mbPtt5NoD7csZeMs65BdxM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=nSyxv8pQ/gIG8PYO95WgrBzbKfLxSvxvN+j78T06F6rPx+ZuZAciaW0yVQVLDQZlnlDJOLrYcDMd6sVDrcfEzEOWpOryRosTUiOJFBGmNTrBDRGECtQGTnAOgMkhEdsQ736TYCJVf5YYQXBKAsG+y5a8u8hExoip28kcTW3Z6tI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cpu7Z75U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4842DC4CEC7;
	Wed, 23 Oct 2024 18:36:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729708589;
	bh=wP2zKX+Yi3XkHbWYph2Q2mbPtt5NoD7csZeMs65BdxM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=Cpu7Z75UkYjaj8MZlmR4fUdhPL9I1jTPfoTKmA2lRgKkddH9ojtpMTHORLH7VYFDR
	 0EnERYsuEabHN7fH0ZRtHU6TsDrVVHc0GsN62/ZPLSBaKEWR4UHBdogoqSJ6xCfeBk
	 tOjINTKERqAqyauW7149Z0qMjFRECtqzjx3lW2yoMuXoXO+K8Brn9yh5yM++PWj9X+
	 LkahFtEycvr6VastrUqVIfAu3Qs9Y121p/lPFYDAlCyIp+Lq11XuoZLl/QeBl1ilxg
	 Px8gwENw/B2yUnEvqEvvBZCIgSEQ6Olamx8C4MYCgQZHNEXNu3OKSaZ7igkSZMbr8V
	 n8ZNutwsxOMYw==
Date: Wed, 23 Oct 2024 13:36:26 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Johan Hovold <johan@kernel.org>
Subject: Re: [PATCH v2] PCI/pwrctl: pwrseq: abandon QCom WCN probe on
 pre-pwrseq device-trees
Message-ID: <20241023183626.GA923877@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241007092447.18616-1-brgl@bgdev.pl>

On Mon, Oct 07, 2024 at 11:24:46AM +0200, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> Old device trees for some platforms already define wifi nodes for the WCN
> family of chips since before power sequencing was added upstream.
> 
> These nodes don't consume the regulator outputs from the PMU and if we
> allow this driver to bind to one of such "incomplete" nodes, we'll see
> a kernel log error about the infinite probe deferral.
> 
> Let's extend the driver by adding a platform data struct matched against
> the compatible. This struct will now contain the pwrseq target string as
> well as a validation function called right after entering probe(). For
> Qualcomm WCN models, we'll check the existence of the regulator supply
> property that indicates the DT is already using power sequencing and
> return -ENODEV if it's not there, indicating to the driver model that
> the device should not be bound to the pwrctl driver.
> 
> Fixes: 6140d185a43d ("PCI/pwrctl: Add a PCI power control driver for power sequenced devices")
> Reported-by: Johan Hovold <johan@kernel.org>
> Closes: https://lore.kernel.org/all/Zv565olMDDGHyYVt@hovoldconsulting.com/
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Applied to pci/for-linus for v6.12, thanks.

It would help me out to have a hint in the posting that this is
intended for the current release, since by default everything is for
the "next" release.

> ---
> v1 -> v2:
> - make the fix more generic, add a platform data struct matched against
>   the compatible and use it to store a device-specific validation
>   callback
> 
>  drivers/pci/pwrctl/pci-pwrctl-pwrseq.c | 55 +++++++++++++++++++++++---
>  1 file changed, 50 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/pci/pwrctl/pci-pwrctl-pwrseq.c b/drivers/pci/pwrctl/pci-pwrctl-pwrseq.c
> index a23a4312574b..e331a73a1b0c 100644
> --- a/drivers/pci/pwrctl/pci-pwrctl-pwrseq.c
> +++ b/drivers/pci/pwrctl/pci-pwrctl-pwrseq.c
> @@ -6,9 +6,9 @@
>  #include <linux/device.h>
>  #include <linux/mod_devicetable.h>
>  #include <linux/module.h>
> -#include <linux/of.h>
>  #include <linux/pci-pwrctl.h>
>  #include <linux/platform_device.h>
> +#include <linux/property.h>
>  #include <linux/pwrseq/consumer.h>
>  #include <linux/slab.h>
>  #include <linux/types.h>
> @@ -18,6 +18,40 @@ struct pci_pwrctl_pwrseq_data {
>  	struct pwrseq_desc *pwrseq;
>  };
>  
> +struct pci_pwrctl_pwrseq_pdata {
> +	const char *target;
> +	/*
> +	 * Called before doing anything else to perform device-specific
> +	 * verification between requesting the power sequencing handle.
> +	 */
> +	int (*validate_device)(struct device *dev);
> +};
> +
> +static int pci_pwrctl_pwrseq_qcm_wcn_validate_device(struct device *dev)
> +{
> +	/*
> +	 * Old device trees for some platforms already define wifi nodes for
> +	 * the WCN family of chips since before power sequencing was added
> +	 * upstream.
> +	 *
> +	 * These nodes don't consume the regulator outputs from the PMU and
> +	 * if we allow this driver to bind to one of such "incomplete" nodes,
> +	 * we'll see a kernel log error about the indefinite probe deferral.
> +	 *
> +	 * Let's check the existence of the regulator supply that exists on all
> +	 * WCN models before moving forward.
> +	 */
> +	if (!device_property_present(dev, "vddaon-supply"))
> +		return -ENODEV;
> +
> +	return 0;
> +}
> +
> +static const struct pci_pwrctl_pwrseq_pdata pci_pwrctl_pwrseq_qcom_wcn_pdata = {
> +	.target = "wlan",
> +	.validate_device = pci_pwrctl_pwrseq_qcm_wcn_validate_device,
> +};
> +
>  static void devm_pci_pwrctl_pwrseq_power_off(void *data)
>  {
>  	struct pwrseq_desc *pwrseq = data;
> @@ -27,15 +61,26 @@ static void devm_pci_pwrctl_pwrseq_power_off(void *data)
>  
>  static int pci_pwrctl_pwrseq_probe(struct platform_device *pdev)
>  {
> +	const struct pci_pwrctl_pwrseq_pdata *pdata;
>  	struct pci_pwrctl_pwrseq_data *data;
>  	struct device *dev = &pdev->dev;
>  	int ret;
>  
> +	pdata = device_get_match_data(dev);
> +	if (!pdata || !pdata->target)
> +		return -EINVAL;
> +
> +	if (pdata->validate_device) {
> +		ret = pdata->validate_device(dev);
> +		if (ret)
> +			return ret;
> +	}
> +
>  	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
>  	if (!data)
>  		return -ENOMEM;
>  
> -	data->pwrseq = devm_pwrseq_get(dev, of_device_get_match_data(dev));
> +	data->pwrseq = devm_pwrseq_get(dev, pdata->target);
>  	if (IS_ERR(data->pwrseq))
>  		return dev_err_probe(dev, PTR_ERR(data->pwrseq),
>  				     "Failed to get the power sequencer\n");
> @@ -64,17 +109,17 @@ static const struct of_device_id pci_pwrctl_pwrseq_of_match[] = {
>  	{
>  		/* ATH11K in QCA6390 package. */
>  		.compatible = "pci17cb,1101",
> -		.data = "wlan",
> +		.data = &pci_pwrctl_pwrseq_qcom_wcn_pdata,
>  	},
>  	{
>  		/* ATH11K in WCN6855 package. */
>  		.compatible = "pci17cb,1103",
> -		.data = "wlan",
> +		.data = &pci_pwrctl_pwrseq_qcom_wcn_pdata,
>  	},
>  	{
>  		/* ATH12K in WCN7850 package. */
>  		.compatible = "pci17cb,1107",
> -		.data = "wlan",
> +		.data = &pci_pwrctl_pwrseq_qcom_wcn_pdata,
>  	},
>  	{ }
>  };
> -- 
> 2.30.2
> 

