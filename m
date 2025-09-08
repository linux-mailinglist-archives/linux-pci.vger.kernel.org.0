Return-Path: <linux-pci+bounces-35627-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66186B482FD
	for <lists+linux-pci@lfdr.de>; Mon,  8 Sep 2025 05:48:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2215A17BAA8
	for <lists+linux-pci@lfdr.de>; Mon,  8 Sep 2025 03:48:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED2311D63F0;
	Mon,  8 Sep 2025 03:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P1+HGzm+"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5AF253A7;
	Mon,  8 Sep 2025 03:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757303303; cv=none; b=DAwAo+vUh/QmcpL7Tb1f0jzVAlkoWB4XuOXKhHmMfkICqF1zn69tpDjBYr+ahHrwXx3fwwMfijHlFhutid3B1sFu3MXkla0FGOW01tBuWXdqw+jIkTjy4MjlrRNzeU8NHUPKA+l1BW8Xn6wHxgC7DBcB1hn8K/0qLH726lA3/Ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757303303; c=relaxed/simple;
	bh=/bvacUJmYdkFKY7yQmb93B50LcYoGC9OGq8X6zGppu8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GKRwN+zWdCD3zna2eAqzxZeuYgmwHfXSXtTk4oGF080P+xOI2oIbivxwRr8hr8ln8A3IjvWhpnHfw7MSFJOiACzS2+OOvrUbF1rUqr7MGruBCXpu8nZqGlse1Ok7+7iy8MS9b7Be1c0DmQEK/p6gCtZi5HCnSdNAEWkG8My/DlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P1+HGzm+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13397C4CEF5;
	Mon,  8 Sep 2025 03:48:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757303303;
	bh=/bvacUJmYdkFKY7yQmb93B50LcYoGC9OGq8X6zGppu8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=P1+HGzm+6FBuuHKFwXA2r/dAOfshb4T4epFazWasn8UzvrOmv8DTR4eVO8rHRqv/J
	 40R/S4yyYLU2GG4pXqUTTaZ+/m5ICTzIAa3pZZSdMBrTnJb20lkSUC9j6EY5HUst1m
	 8xBL0M5Ayk+3Lrkj0roIemcPSwVJzRiFaqIeTV8qIJ/Re6gc6jQoeEjTyTMjoNqsOH
	 awn/ZjCBkKavNvo0EevmR9z9StqweRN9sZxfqUfzFBbr17+OzafOeVQmrRB/U19PJ9
	 pIGk3DsienHhrY85UhC3Amf8++fWFZfA/m4Wi41EqHrLCRmkObJr85fHpqnvmyebS5
	 T8x4bPQ3CAB3Q==
Date: Mon, 8 Sep 2025 09:18:15 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: manivannan.sadhasivam@oss.qualcomm.com, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Bartosz Golaszewski <brgl@bgdev.pl>, Saravana Kannan <saravanak@google.com>, 
	linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>, 
	Brian Norris <briannorris@chromium.org>, Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH v2 2/5] PCI/pwrctrl: Move pci_pwrctrl_init() before
 turning ON the supplies
Message-ID: <tv7pahvoblw77jziivp7ulassnfdlpsg2z4xvisumbrueapfgu@iyfzlnjjubkv>
References: <20250903-pci-pwrctrl-perst-v2-2-2d461ed0e061@oss.qualcomm.com>
 <20250907212242.GA1398560@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250907212242.GA1398560@bhelgaas>

On Sun, Sep 07, 2025 at 04:22:42PM GMT, Bjorn Helgaas wrote:
> On Wed, Sep 03, 2025 at 12:43:24PM +0530, Manivannan Sadhasivam via B4 Relay wrote:
> > From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> > 
> > To allow pwrctrl core to parse the generic resources such as PERST# GPIO
> > before turning on the supplies.
> 
> Can we expand this a little bit?  Which function does that parsing,
> for example?  pci_pwrctrl_init() itself doesn't do any of that, so the
> connection isn't obious.
> 

Sure.

Pwrctrl core function pci_pwrctrl_device_set_ready() deasserts PERST# if the
callback is available. Since that requires accessing 'pwrctrl->dev',
pci_pwrctrl_init() that is setting 'pwrctrl->dev' needs to be called earlier.

I will change the description to be more elaborative. It also requires rewording
since the pwrctrl core is not parsing PERST# on its own now.

- Mani

> > Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> > ---
> >  drivers/pci/pwrctrl/pci-pwrctrl-pwrseq.c | 4 ++--
> >  drivers/pci/pwrctrl/slot.c               | 4 ++--
> >  2 files changed, 4 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/pci/pwrctrl/pci-pwrctrl-pwrseq.c b/drivers/pci/pwrctrl/pci-pwrctrl-pwrseq.c
> > index 4e664e7b8dd23f592c0392efbf6728fc5bf9093f..b65955adc7bd44030593e8c49d60db0f39b03d03 100644
> > --- a/drivers/pci/pwrctrl/pci-pwrctrl-pwrseq.c
> > +++ b/drivers/pci/pwrctrl/pci-pwrctrl-pwrseq.c
> > @@ -80,6 +80,8 @@ static int pci_pwrctrl_pwrseq_probe(struct platform_device *pdev)
> >  	if (!data)
> >  		return -ENOMEM;
> >  
> > +	pci_pwrctrl_init(&data->ctx, dev);
> > +
> >  	data->pwrseq = devm_pwrseq_get(dev, pdata->target);
> >  	if (IS_ERR(data->pwrseq))
> >  		return dev_err_probe(dev, PTR_ERR(data->pwrseq),
> > @@ -95,8 +97,6 @@ static int pci_pwrctrl_pwrseq_probe(struct platform_device *pdev)
> >  	if (ret)
> >  		return ret;
> >  
> > -	pci_pwrctrl_init(&data->ctx, dev);
> > -
> >  	ret = devm_pci_pwrctrl_device_set_ready(dev, &data->ctx);
> >  	if (ret)
> >  		return dev_err_probe(dev, ret,
> > diff --git a/drivers/pci/pwrctrl/slot.c b/drivers/pci/pwrctrl/slot.c
> > index 6e138310b45b9f7e930b6814e0a24f7111d25fee..b68406a6b027e4d9f853e86d4340e0ab267b6126 100644
> > --- a/drivers/pci/pwrctrl/slot.c
> > +++ b/drivers/pci/pwrctrl/slot.c
> > @@ -38,6 +38,8 @@ static int pci_pwrctrl_slot_probe(struct platform_device *pdev)
> >  	if (!slot)
> >  		return -ENOMEM;
> >  
> > +	pci_pwrctrl_init(&slot->ctx, dev);
> > +
> >  	ret = of_regulator_bulk_get_all(dev, dev_of_node(dev),
> >  					&slot->supplies);
> >  	if (ret < 0) {
> > @@ -63,8 +65,6 @@ static int pci_pwrctrl_slot_probe(struct platform_device *pdev)
> >  				     "Failed to enable slot clock\n");
> >  	}
> >  
> > -	pci_pwrctrl_init(&slot->ctx, dev);
> > -
> >  	ret = devm_pci_pwrctrl_device_set_ready(dev, &slot->ctx);
> >  	if (ret)
> >  		return dev_err_probe(dev, ret, "Failed to register pwrctrl driver\n");
> > 
> > -- 
> > 2.45.2
> > 
> > 

-- 
மணிவண்ணன் சதாசிவம்

