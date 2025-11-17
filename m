Return-Path: <linux-pci+bounces-41439-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 19F81C65969
	for <lists+linux-pci@lfdr.de>; Mon, 17 Nov 2025 18:46:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 19D75350E8E
	for <lists+linux-pci@lfdr.de>; Mon, 17 Nov 2025 17:37:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B40A12F8BFC;
	Mon, 17 Nov 2025 17:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y1uxPfuE"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8336529D268;
	Mon, 17 Nov 2025 17:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763401038; cv=none; b=himJruErd7nyZYD1Vh2sYgbdPwhEHCafWtZ8Ut07X2raRtjpq0BOAclpqQqQ+e9AlzPjs9miO3AVQm/cE7VvhjPg2qn5GH30B0BM8L+PxnmLapRc2grwLOxtnuXBDxdIdPCIGfhPoy8PjNqKpdMXnAI57Pi6o2oG1D89GrD/cF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763401038; c=relaxed/simple;
	bh=xaJwj4w/55f9caNeZTmSEHP8i/cA6sqKW7e+HMlLTUc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kD8jAttRUZ2u3WOGkrLA0QbegrNVuEGsUjjQEOHcbUJCIczM4Zh4iWL+PX/zkZpD4YERV4P9PhHSiW4dsgw70MbeJIqY7SjiLtZRSTRuPynEAIKItuc8re5i5zTcuHZIW3OuxHUfLZ6lQwFY3IkEcYgGMtkLBgfCe3BsSbDV+rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y1uxPfuE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F9F1C19425;
	Mon, 17 Nov 2025 17:37:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763401036;
	bh=xaJwj4w/55f9caNeZTmSEHP8i/cA6sqKW7e+HMlLTUc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Y1uxPfuE5W2Lm/R/zsthGPD9m29er72tTcgxXt6CxtX7xUJWghvu2YLLYdILO7x7V
	 zytxGct0hN5EVmcT57L5q3nD3rvpA0e6FSaWTR1sup2uAL/nhb3zbD9Urem3xmAMNk
	 p/w8bjzMZH8H5LI+ZtXvHS1BrlYlUMRwVVP9deSlhY+M9PXkzP7nUYFhyAlEXfmO+4
	 0RrGiLb/17Y4rSqtN6htu9i0jr2VPJ5q18/TkoNehFfheycq4zaGiGCr5L/BqyFkdr
	 7ikWzQ/RbpbYWO+yF8J7BgB8PADlMQEWoyZcoGTyiIxyih17StZXwBAa1jf6sIfg9l
	 0gOF2Ju/ewVLw==
Date: Mon, 17 Nov 2025 23:07:01 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>, 
	lpieralisi@kernel.org, kwilczynski@kernel.org, bhelgaas@google.com, will@kernel.org, 
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, robh@kernel.org, 
	linux-arm-msm@vger.kernel.org, zhangsenchuan@eswincomputing.com, vincent.guittot@linaro.org
Subject: Re: [PATCH v2 2/3] PCI: qcom: Check for the presence of a device
 instead of Link up during suspend
Message-ID: <qu3gnvl7t7ehpxhkchz6ragjoeafktwr4dtstattthfv3jezd7@zrfwrlr2vzx5>
References: <zgj3ubyb234ig6ndz6ov5q3szvuxnd3jkz2rjglbad4ksri6nl@ov7boxuar4va>
 <20251113172250.GA2291436@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251113172250.GA2291436@bhelgaas>

On Thu, Nov 13, 2025 at 11:22:50AM -0600, Bjorn Helgaas wrote:
> On Thu, Nov 13, 2025 at 10:24:17PM +0530, Manivannan Sadhasivam wrote:
> > On Thu, Nov 13, 2025 at 10:41:47AM -0600, Bjorn Helgaas wrote:
> > > On Fri, Nov 07, 2025 at 10:13:18AM +0530, Manivannan Sadhasivam wrote:
> > > > The suspend handler checks for the PCIe Link up to decide when to turn off
> > > > the controller resources. But this check is racy as the PCIe Link can go
> > > > down just after this check.
> > > > 
> > > > So use the newly introduced API, pci_root_ports_have_device() that checks
> > > > for the presence of a device under any of the Root Ports to replace the
> > > > Link up check.
> > > 
> > > Why is pci_root_ports_have_device() itself not racy?
> > 
> > Because it is very uncommon for the 'pci_dev' to go away during the
> > host controller suspend. It might still be possible in edge cases,
> > but very common as the link down. I can reword it.
> 
> I guess it's better to acknowledge replacing one race with another
> than it would be to suggest that this *removes* a race.
> 

Ok.

> But I don't understand the point of this.  Is
> pci_root_ports_have_device() *less* racy than the
> qcom_pcie_suspend_noirq() check?  Why would that be?
> 

The check is supposed to perform deinit only if there are no devices connected
to the slot. And the reason to skip the deinit was mostly due to driver behavior
like NVMe driver, which expects the device to be in D0 even during system
suspend on non-x86 platforms.

Since the check is for the existence of the device nevertheless, I thought,
making use of pci_root_ports_have_device() serves the purpose instead of
checking the data link layer status.

> I'm kind of skeptical about adding pci_root_ports_have_device() at
> all.  It seems like it just encourages racy behavior in drivers.
> 

I agree that though it is not very common, but with async suspend, it is
possible that 'pci_dev' may get removed during controller suspend.

So I've dropped this series from controller/dwc until we conclude.

- Mani

> > > > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> > > > ---
> > > >  drivers/pci/controller/dwc/pcie-qcom.c | 6 ++++--
> > > >  1 file changed, 4 insertions(+), 2 deletions(-)
> > > > 
> > > > diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> > > > index 805edbbfe7eb..b2b89e2e4916 100644
> > > > --- a/drivers/pci/controller/dwc/pcie-qcom.c
> > > > +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> > > > @@ -2018,6 +2018,7 @@ static int qcom_pcie_probe(struct platform_device *pdev)
> > > >  static int qcom_pcie_suspend_noirq(struct device *dev)
> > > >  {
> > > >  	struct qcom_pcie *pcie;
> > > > +	struct dw_pcie_rp *pp;
> > > >  	int ret = 0;
> > > >  
> > > >  	pcie = dev_get_drvdata(dev);
> > > > @@ -2053,8 +2054,9 @@ static int qcom_pcie_suspend_noirq(struct device *dev)
> > > >  	 * powerdown state. This will affect the lifetime of the storage devices
> > > >  	 * like NVMe.
> > > >  	 */
> > > > -	if (!dw_pcie_link_up(pcie->pci)) {
> > > > -		qcom_pcie_host_deinit(&pcie->pci->pp);
> > > > +	pp = &pcie->pci->pp;
> > > > +	if (!pci_root_ports_have_device(pp->bridge->bus)) {
> > > > +		qcom_pcie_host_deinit(pp);
> > > >  		pcie->suspended = true;
> > > >  	}
> > > >  
> > > > -- 
> > > > 2.48.1
> > > > 
> > 
> > -- 
> > மணிவண்ணன் சதாசிவம்

-- 
மணிவண்ணன் சதாசிவம்

