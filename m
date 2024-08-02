Return-Path: <linux-pci+bounces-11197-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B98094620F
	for <lists+linux-pci@lfdr.de>; Fri,  2 Aug 2024 18:51:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1EAE6B21597
	for <lists+linux-pci@lfdr.de>; Fri,  2 Aug 2024 16:51:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC79B14EC57;
	Fri,  2 Aug 2024 16:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TYQ1nyix"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ACBA13633D;
	Fri,  2 Aug 2024 16:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722617495; cv=none; b=eh1zLN4CxUQRkZsaI9Cu7vPzTinoob0QXbrNkII8cdH/lCoGBWX87OCO9tvUsu3bkczpJlp5NZZiQ6Olhuy5aHXpccjVe+bJLFDslhKP/SCfcxCaBMgFigmCKhksY9/5wL/nWPJsYqxXxKNvlmMuAYap9Cea1O6wXTDzlfuyQ/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722617495; c=relaxed/simple;
	bh=5S6CP6s9amxeYSZLoxkka5ubEMMyec6E2rfOz2sp6Qc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=SHW1y3of9VtoW9qvXzQBxQ7xYtSC3ws6qmYaH2XZfLKkU5mgG9d200dU/ufcol9YBFMeJqKcTcdkpl3eUzLhlYUBNx4e2iGp++ZiDuNWsv+cvZWETHYj/kPNbcpUVax3T8kjq8U2CCHnqy7XHofTUuPYQYL6hSzvik/HjLyIp6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TYQ1nyix; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6497C32782;
	Fri,  2 Aug 2024 16:51:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722617495;
	bh=5S6CP6s9amxeYSZLoxkka5ubEMMyec6E2rfOz2sp6Qc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=TYQ1nyixuz4bMlRn+8t/e2ScXXfP30bHOCTuUmCfUUIIFXHcs1VK67dVIAh+T3rUR
	 zle4vWVHdvsAeTMUDy2Ln72juKUZ5++pnwN+MkeScr7IWOwIxOdu73o7g5TYch3vp8
	 ON7DriQ+fb5d1jAxdbsr5Cd7ASMHc70J6WUOpoqshYmedqem8fhy26E+WdvyVbqUw5
	 opRT41cPjK2E1M7ybwO8ZbWK7LKu6brychCFO8/xZEF56Ndlyh0fcFofIfjRs4/pOS
	 +ApBZsZX+a9G5pn/ZhZmHeXuUA6gZEdD/PPrfRh1H5rcJrq+GhD0YoZUwRNG7fFZv+
	 KSISE1g7c8IeA==
Date: Fri, 2 Aug 2024 11:51:33 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>, linux-pci@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	Konrad Dybcio <konrad.dybcio@linaro.org>
Subject: Re: [PATCH v3 06/13] PCI: qcom-ep: Modify 'global_irq' and
 'perst_irq' IRQ device names
Message-ID: <20240802165133.GA153963@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240802074319.GA57846@thinkpad>

On Fri, Aug 02, 2024 at 01:13:19PM +0530, Manivannan Sadhasivam wrote:
> On Thu, Aug 01, 2024 at 12:23:08PM -0500, Bjorn Helgaas wrote:
> > On Wed, Jul 31, 2024 at 04:20:09PM +0530, Manivannan Sadhasivam via B4 Relay wrote:
> > > From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > > 
> > > Currently, the IRQ device name for both of these IRQs doesn't have Qcom
> > > specific prefix and PCIe domain number. This causes 2 issues:
> > > 
> > > 1. Pollutes the global IRQ namespace since 'global' is a common name.
> > > 2. When more than one EP controller instance is present in the SoC, naming
> > > conflict will occur.
> > > 
> > > Hence, add 'qcom_pcie_ep_' prefix and PCIe domain number suffix to the IRQ
> > > names to uniquely identify the IRQs and also to fix the above mentioned
> > > issues.
> > > 
> > > Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> > > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > > ---
> > >  drivers/pci/controller/dwc/pcie-qcom-ep.c | 16 ++++++++++++++--
> > >  1 file changed, 14 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/drivers/pci/controller/dwc/pcie-qcom-ep.c b/drivers/pci/controller/dwc/pcie-qcom-ep.c
> > > index 0bb0a056dd8f..d0a27fa6fdc8 100644
> > > --- a/drivers/pci/controller/dwc/pcie-qcom-ep.c
> > > +++ b/drivers/pci/controller/dwc/pcie-qcom-ep.c
> > > @@ -711,8 +711,15 @@ static irqreturn_t qcom_pcie_ep_perst_irq_thread(int irq, void *data)
> > >  static int qcom_pcie_ep_enable_irq_resources(struct platform_device *pdev,
> > >  					     struct qcom_pcie_ep *pcie_ep)
> > >  {
> > > +	struct device *dev = pcie_ep->pci.dev;
> > > +	char *name;
> > >  	int ret;
> > >  
> > > +	name = devm_kasprintf(dev, GFP_KERNEL, "qcom_pcie_ep_global_irq%d",
> > > +			      pcie_ep->pci.ep.epc->domain_nr);
> > > +	if (!name)
> > > +		return -ENOMEM;
> > 
> > I assume this is what shows up in /proc/interrupts?
> 
> Yes.
> 
> > I always wonder
> > why it doesn't include dev_name().  A few drivers do that, but
> > apparently it's not universally desirable.  It's sort of annoying
> > that, e.g., we get a bunch of "aerdrv" interrupts with no clue which
> > device they relate to.
> 
> dev_name() can be big at times. I wouldn't recommend to include it
> unless there are no other ways to differentiate between IRQs.
> Luckily PCIe has the domain number that we can use to differentiate
> these IRQs.

/proc/interrupts is 159 characters wide even on my puny 8 CPU laptop,
so I don't think width is a strong argument, and having to use
per-device heuristics (instance number like dmarX, idma64.X, nvmeXqY,
domain number, etc) to find the related device is ... well, a hassle.

But like I said, obviously devm_request_threaded_irq() *could* have
been implemented to include dev_name() internally but wasn't, so I
acknowledge there must be good reasons not to, and I'm fine with this
patch as-is since it continues the existing practice.

> > >  	pcie_ep->global_irq = platform_get_irq_byname(pdev, "global");
> > >  	if (pcie_ep->global_irq < 0)
> > >  		return pcie_ep->global_irq;
> > > @@ -720,18 +727,23 @@ static int qcom_pcie_ep_enable_irq_resources(struct platform_device *pdev,
> > >  	ret = devm_request_threaded_irq(&pdev->dev, pcie_ep->global_irq, NULL,
> > >  					qcom_pcie_ep_global_irq_thread,
> > >  					IRQF_ONESHOT,
> > > -					"global_irq", pcie_ep);
> > > +					name, pcie_ep);

