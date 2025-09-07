Return-Path: <linux-pci+bounces-35619-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F087B48033
	for <lists+linux-pci@lfdr.de>; Sun,  7 Sep 2025 23:22:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F96D3AACEC
	for <lists+linux-pci@lfdr.de>; Sun,  7 Sep 2025 21:22:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 918D61E379B;
	Sun,  7 Sep 2025 21:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oEL+PdIo"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CC01315D34;
	Sun,  7 Sep 2025 21:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757280164; cv=none; b=LWHRQAIoaWwZJwD7fgNxnOKAYmbxjcCc3YnQxwQmr9F493HXuuqbq+4QFyt62xvVnv7f17sQk0vXyHqsOWrZgXCpxZV1T4dVHpbBIzqCwe2YaWqIRAXq6i+hLEUGWW6ytrPTS1bVa4YOGjbFQXJHTtMcQPobdcHzbh3m3jx51wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757280164; c=relaxed/simple;
	bh=t9HIVRPnwgJW2cubUjvw5PGKnZO96ShQ03t+AzJLGDg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=m87HFGeIWLHp58qgZhTDdNsQgVNIdjmkUaRSKrGLnO/TMj3Ced3wwHKSfizSa6IV6KiRZMQRgOShEu0rBWqEYfVLJieJHMgDEySn5ZxxBH+nP5NGOqJaEm8whEcs6vOINNWxev2L2EKjVcOaF3aYqjeerZuRCm15CvZxucq2e10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oEL+PdIo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F3E9C4CEF0;
	Sun,  7 Sep 2025 21:22:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757280163;
	bh=t9HIVRPnwgJW2cubUjvw5PGKnZO96ShQ03t+AzJLGDg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=oEL+PdIo2ehovjG6K6MjFoPtnNHxLOudO98iwpAaeQSV+TtWoXlwy+AZz4uL92/c/
	 G1NMp6FEc66BopbtJuIClunNCnsJy48N7fJojMzjO4GxdOaO1aJ0+aL9GlPIyUxXig
	 YWPR9/kfmdINrFvauBKjBRswhU43QckK8DTZMAFWt0Is2c/JMWXXPkYSHtNutAE/IU
	 jdTE9xm9SdYHuXvwvSP7L9WqwBVKfjqSWtv+waQvjuBzXqLKq+kykmOYhacL3OD16g
	 FS08JYob7byXo2NbR0BgZkOFJq3B4tiLFTZw9hJPVUU0ZNKQvwfp6kO7wHnGYhqSBn
	 mZ7XS3TWVcYbw==
Date: Sun, 7 Sep 2025 16:22:42 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: manivannan.sadhasivam@oss.qualcomm.com
Cc: Manivannan Sadhasivam <mani@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Saravana Kannan <saravanak@google.com>, linux-pci@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
	Brian Norris <briannorris@chromium.org>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH v2 2/5] PCI/pwrctrl: Move pci_pwrctrl_init() before
 turning ON the supplies
Message-ID: <20250907212242.GA1398560@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250903-pci-pwrctrl-perst-v2-2-2d461ed0e061@oss.qualcomm.com>

On Wed, Sep 03, 2025 at 12:43:24PM +0530, Manivannan Sadhasivam via B4 Relay wrote:
> From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> 
> To allow pwrctrl core to parse the generic resources such as PERST# GPIO
> before turning on the supplies.

Can we expand this a little bit?  Which function does that parsing,
for example?  pci_pwrctrl_init() itself doesn't do any of that, so the
connection isn't obious.

> Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> ---
>  drivers/pci/pwrctrl/pci-pwrctrl-pwrseq.c | 4 ++--
>  drivers/pci/pwrctrl/slot.c               | 4 ++--
>  2 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/pci/pwrctrl/pci-pwrctrl-pwrseq.c b/drivers/pci/pwrctrl/pci-pwrctrl-pwrseq.c
> index 4e664e7b8dd23f592c0392efbf6728fc5bf9093f..b65955adc7bd44030593e8c49d60db0f39b03d03 100644
> --- a/drivers/pci/pwrctrl/pci-pwrctrl-pwrseq.c
> +++ b/drivers/pci/pwrctrl/pci-pwrctrl-pwrseq.c
> @@ -80,6 +80,8 @@ static int pci_pwrctrl_pwrseq_probe(struct platform_device *pdev)
>  	if (!data)
>  		return -ENOMEM;
>  
> +	pci_pwrctrl_init(&data->ctx, dev);
> +
>  	data->pwrseq = devm_pwrseq_get(dev, pdata->target);
>  	if (IS_ERR(data->pwrseq))
>  		return dev_err_probe(dev, PTR_ERR(data->pwrseq),
> @@ -95,8 +97,6 @@ static int pci_pwrctrl_pwrseq_probe(struct platform_device *pdev)
>  	if (ret)
>  		return ret;
>  
> -	pci_pwrctrl_init(&data->ctx, dev);
> -
>  	ret = devm_pci_pwrctrl_device_set_ready(dev, &data->ctx);
>  	if (ret)
>  		return dev_err_probe(dev, ret,
> diff --git a/drivers/pci/pwrctrl/slot.c b/drivers/pci/pwrctrl/slot.c
> index 6e138310b45b9f7e930b6814e0a24f7111d25fee..b68406a6b027e4d9f853e86d4340e0ab267b6126 100644
> --- a/drivers/pci/pwrctrl/slot.c
> +++ b/drivers/pci/pwrctrl/slot.c
> @@ -38,6 +38,8 @@ static int pci_pwrctrl_slot_probe(struct platform_device *pdev)
>  	if (!slot)
>  		return -ENOMEM;
>  
> +	pci_pwrctrl_init(&slot->ctx, dev);
> +
>  	ret = of_regulator_bulk_get_all(dev, dev_of_node(dev),
>  					&slot->supplies);
>  	if (ret < 0) {
> @@ -63,8 +65,6 @@ static int pci_pwrctrl_slot_probe(struct platform_device *pdev)
>  				     "Failed to enable slot clock\n");
>  	}
>  
> -	pci_pwrctrl_init(&slot->ctx, dev);
> -
>  	ret = devm_pci_pwrctrl_device_set_ready(dev, &slot->ctx);
>  	if (ret)
>  		return dev_err_probe(dev, ret, "Failed to register pwrctrl driver\n");
> 
> -- 
> 2.45.2
> 
> 

