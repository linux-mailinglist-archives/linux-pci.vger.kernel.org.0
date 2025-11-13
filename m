Return-Path: <linux-pci+bounces-41140-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 56813C594EE
	for <lists+linux-pci@lfdr.de>; Thu, 13 Nov 2025 19:00:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 73551543B55
	for <lists+linux-pci@lfdr.de>; Thu, 13 Nov 2025 17:08:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C55D235C19F;
	Thu, 13 Nov 2025 16:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FPgbhtBP"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9779E35A93A;
	Thu, 13 Nov 2025 16:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763052871; cv=none; b=c25SrypPFkdhGt+wY+3REvF2+wrsm4uvfFId+LxM0src2uOXCu3vgqTWbvVz0HJ9T/CS9FMrEg+ODs4mkCTL+N4x5kQnCHC5Pt4wZPcJSh+Hh+ZMUqa1hNcTOO7ht2V+Py22zWQQqiB21jRtuPJG+S9Xdy7WVytudf2xhFxagKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763052871; c=relaxed/simple;
	bh=JeYwUKQwr+IxDDxKQu8g9ocn8mWOdn0gU01do0ot+ko=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AXnC7aWB1rxHlyQeiV7KQwfXBy+50dfmvdFsme5N0y0MHdoZhvQ0o+SsbnEijp9af4GOxYKSRhdVpTn7CX4UqvZRgbRumzIaVWkSCIsECNt2IOSwS1YiUJ2HOCJpypLlXrGxvOYfnwjxIBrQEaJdMWA7t6c2MNtDYcTLu+hh1vU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FPgbhtBP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CE99C2BCB0;
	Thu, 13 Nov 2025 16:54:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763052871;
	bh=JeYwUKQwr+IxDDxKQu8g9ocn8mWOdn0gU01do0ot+ko=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FPgbhtBPBhmd8fJ30cqe+m5IyWwl2+bMJVFYPd92SUN7dvpR/dqTg76gV7EeC5H4m
	 w4ttkfWQKT9y0COmfsoOBEx+r8z6mdih6SKJTLo2BVtKownAru28UaU2OMXXALWzLr
	 M2swxQcd1+yMmE2Efw4XT9sNtlfDjfuTsFLLojS20RkZ1+Q2rvZG9HfdAgOgI7q0wf
	 b8ydMinQpt37LzSWN8iJrCWV/MkKnowdcL8o6Hf18eseU8gkhaRESUoF6emJDhxlF1
	 4X0SFfBCqJHq5Gp34FJFqOP5jnB3TP3JDB3C69YQnbLl2H4lvomTJkWa3a6WCpDFRU
	 cwVNHeJPyPqwg==
Date: Thu, 13 Nov 2025 22:24:17 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>, 
	lpieralisi@kernel.org, kwilczynski@kernel.org, bhelgaas@google.com, will@kernel.org, 
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, robh@kernel.org, 
	linux-arm-msm@vger.kernel.org, zhangsenchuan@eswincomputing.com, vincent.guittot@linaro.org
Subject: Re: [PATCH v2 2/3] PCI: qcom: Check for the presence of a device
 instead of Link up during suspend
Message-ID: <zgj3ubyb234ig6ndz6ov5q3szvuxnd3jkz2rjglbad4ksri6nl@ov7boxuar4va>
References: <20251107044319.8356-3-manivannan.sadhasivam@oss.qualcomm.com>
 <20251113164147.GA2285894@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251113164147.GA2285894@bhelgaas>

On Thu, Nov 13, 2025 at 10:41:47AM -0600, Bjorn Helgaas wrote:
> On Fri, Nov 07, 2025 at 10:13:18AM +0530, Manivannan Sadhasivam wrote:
> > The suspend handler checks for the PCIe Link up to decide when to turn off
> > the controller resources. But this check is racy as the PCIe Link can go
> > down just after this check.
> > 
> > So use the newly introduced API, pci_root_ports_have_device() that checks
> > for the presence of a device under any of the Root Ports to replace the
> > Link up check.
> 
> Why is pci_root_ports_have_device() itself not racy?
> 

Because it is very uncommon for the 'pci_dev' to go away during the host
controller suspend. It might still be possible in edge cases, but very common as
the link down. I can reword it.

- Mani

> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> > ---
> >  drivers/pci/controller/dwc/pcie-qcom.c | 6 ++++--
> >  1 file changed, 4 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> > index 805edbbfe7eb..b2b89e2e4916 100644
> > --- a/drivers/pci/controller/dwc/pcie-qcom.c
> > +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> > @@ -2018,6 +2018,7 @@ static int qcom_pcie_probe(struct platform_device *pdev)
> >  static int qcom_pcie_suspend_noirq(struct device *dev)
> >  {
> >  	struct qcom_pcie *pcie;
> > +	struct dw_pcie_rp *pp;
> >  	int ret = 0;
> >  
> >  	pcie = dev_get_drvdata(dev);
> > @@ -2053,8 +2054,9 @@ static int qcom_pcie_suspend_noirq(struct device *dev)
> >  	 * powerdown state. This will affect the lifetime of the storage devices
> >  	 * like NVMe.
> >  	 */
> > -	if (!dw_pcie_link_up(pcie->pci)) {
> > -		qcom_pcie_host_deinit(&pcie->pci->pp);
> > +	pp = &pcie->pci->pp;
> > +	if (!pci_root_ports_have_device(pp->bridge->bus)) {
> > +		qcom_pcie_host_deinit(pp);
> >  		pcie->suspended = true;
> >  	}
> >  
> > -- 
> > 2.48.1
> > 

-- 
மணிவண்ணன் சதாசிவம்

