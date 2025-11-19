Return-Path: <linux-pci+bounces-41662-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id B8EBCC701A2
	for <lists+linux-pci@lfdr.de>; Wed, 19 Nov 2025 17:33:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id CA1123A84CE
	for <lists+linux-pci@lfdr.de>; Wed, 19 Nov 2025 16:15:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0CD3341063;
	Wed, 19 Nov 2025 16:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="knLlq1Qz"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B30DF34104D;
	Wed, 19 Nov 2025 16:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763568925; cv=none; b=bcxD7eH395lNI/oxdUrlcG8zbRmQ6VigwOMrdWHRqP7K9KyCksJXU0HzBXElndR1lRpakwaJAzSOxfqxUQTVSk4aoZfne7FQhQHVqntNy087VWQyA5gFS/cjEEp7/uZEpn1PYtv1mAyEPuy+HIkHpnlL9/ySbQfoHI9ltQa9uZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763568925; c=relaxed/simple;
	bh=6lz8gKys/60L5ZU/p0UYz+zBQaopcOtiRIrovtQVc1k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lQd+4UZODOUEBFq6XvWmgOUAgMcB9WQMTu6cezYAEeHLuE2LFLeq/avhaS/6IltXJ3T5NeGWIvqCtkeRxCFoW46aHOz3T9ClaX+HcHtz1K5TSGgf6dq5EPuwfR5DIWWsiji8z7gU10ENlFvSCddF/8te8gIfqM9tUi1yiebAM+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=knLlq1Qz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61823C4CEF5;
	Wed, 19 Nov 2025 16:15:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763568925;
	bh=6lz8gKys/60L5ZU/p0UYz+zBQaopcOtiRIrovtQVc1k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=knLlq1QzIHH1/o5Zk1yyHBVpHJgmw1IaI7+EExfpJKNdImPnXqgX1/2nEGYzWJIyo
	 RleD1IIIEhDOeAJingLhaBB9H22KYd1TUfV1kepYqMDyFYQNgNLdr0RcAaY+LSbR4I
	 E9kKuhMG0uCov85YO2kTaQg+visqtOsGXECRHdI1WbZIqJV62ATOK8HRsI3RvGj/ZD
	 Ei+j+ZIit1uNXd4R9C0kSkl1Wey3f1Wfi5uGg6HvTopgPyRfNWJMg9dIlqBrbNZUUU
	 lIYoVzGGeMGKmSab9OrDQu7Kfv9OfpkN5fVXQeQepwC1yqqoNNccI6wDoP7qGT+Wsj
	 wmx9UFfnMcStg==
Date: Wed, 19 Nov 2025 21:45:12 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: zhangsenchuan <zhangsenchuan@eswincomputing.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, 
	Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>, lpieralisi@kernel.org, kwilczynski@kernel.org, 
	bhelgaas@google.com, will@kernel.org, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, robh@kernel.org, linux-arm-msm@vger.kernel.org, 
	vincent.guittot@linaro.org
Subject: Re: [PATCH v2 2/3] PCI: qcom: Check for the presence of a device
 instead of Link up during suspend
Message-ID: <e7plmtwtkkd4ymrt2hkztcqdx4ugfjk64oksjyf6lpi2oui53d@vhuo5occyref>
References: <zgj3ubyb234ig6ndz6ov5q3szvuxnd3jkz2rjglbad4ksri6nl@ov7boxuar4va>
 <20251113172250.GA2291436@bhelgaas>
 <qu3gnvl7t7ehpxhkchz6ragjoeafktwr4dtstattthfv3jezd7@zrfwrlr2vzx5>
 <7b8d757a.542.19a9b23bda4.Coremail.zhangsenchuan@eswincomputing.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7b8d757a.542.19a9b23bda4.Coremail.zhangsenchuan@eswincomputing.com>

On Wed, Nov 19, 2025 at 04:03:22PM +0800, zhangsenchuan wrote:
> 
> 
> 
> > -----Original Messages-----
> > From: "Manivannan Sadhasivam" <mani@kernel.org>
> > Send time:Tuesday, 18/11/2025 01:37:01
> > To: "Bjorn Helgaas" <helgaas@kernel.org>
> > Cc: "Manivannan Sadhasivam" <manivannan.sadhasivam@oss.qualcomm.com>, lpieralisi@kernel.org, kwilczynski@kernel.org, bhelgaas@google.com, will@kernel.org, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, robh@kernel.org, linux-arm-msm@vger.kernel.org, zhangsenchuan@eswincomputing.com, vincent.guittot@linaro.org
> > Subject: Re: [PATCH v2 2/3] PCI: qcom: Check for the presence of a device instead of Link up during suspend
> > 
> > On Thu, Nov 13, 2025 at 11:22:50AM -0600, Bjorn Helgaas wrote:
> > > On Thu, Nov 13, 2025 at 10:24:17PM +0530, Manivannan Sadhasivam wrote:
> > > > On Thu, Nov 13, 2025 at 10:41:47AM -0600, Bjorn Helgaas wrote:
> > > > > On Fri, Nov 07, 2025 at 10:13:18AM +0530, Manivannan Sadhasivam wrote:
> > > > > > The suspend handler checks for the PCIe Link up to decide when to turn off
> > > > > > the controller resources. But this check is racy as the PCIe Link can go
> > > > > > down just after this check.
> > > > > > 
> > > > > > So use the newly introduced API, pci_root_ports_have_device() that checks
> > > > > > for the presence of a device under any of the Root Ports to replace the
> > > > > > Link up check.
> > > > > 
> > > > > Why is pci_root_ports_have_device() itself not racy?
> > > > 
> > > > Because it is very uncommon for the 'pci_dev' to go away during the
> > > > host controller suspend. It might still be possible in edge cases,
> > > > but very common as the link down. I can reword it.
> > > 
> > > I guess it's better to acknowledge replacing one race with another
> > > than it would be to suggest that this *removes* a race.
> > > 
> > 
> > Ok.
> > 
> > > But I don't understand the point of this.  Is
> > > pci_root_ports_have_device() *less* racy than the
> > > qcom_pcie_suspend_noirq() check?  Why would that be?
> > > 
> > 
> > The check is supposed to perform deinit only if there are no devices connected
> > to the slot. And the reason to skip the deinit was mostly due to driver behavior
> > like NVMe driver, which expects the device to be in D0 even during system
> > suspend on non-x86 platforms.
> > 
> > Since the check is for the existence of the device nevertheless, I thought,
> > making use of pci_root_ports_have_device() serves the purpose instead of
> > checking the data link layer status.
> > 
> > > I'm kind of skeptical about adding pci_root_ports_have_device() at
> > > all.  It seems like it just encourages racy behavior in drivers.
> > > 
> > 
> > I agree that though it is not very common, but with async suspend, it is
> > possible that 'pci_dev' may get removed during controller suspend.
> > 
> > So I've dropped this series from controller/dwc until we conclude.
> > 
> 
> Hi, Mani
> 
> I see that this series from controller/dwc has been temporarily removed. 
> Do I need to wait for a conclusion later before submitting the code, or
> do I need to continue submitting the pcie v6 patch based on the latest 
> 6.18-rc6 branch?
> 

I'm coming up with a new version of the patch, but you do not need to wait for
it.

- Mani

> Kind regards,
> Senchuan Zhang
> 
> > 
> > > > > > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> > > > > > ---
> > > > > >  drivers/pci/controller/dwc/pcie-qcom.c | 6 ++++--
> > > > > >  1 file changed, 4 insertions(+), 2 deletions(-)
> > > > > > 
> > > > > > diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> > > > > > index 805edbbfe7eb..b2b89e2e4916 100644
> > > > > > --- a/drivers/pci/controller/dwc/pcie-qcom.c
> > > > > > +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> > > > > > @@ -2018,6 +2018,7 @@ static int qcom_pcie_probe(struct platform_device *pdev)
> > > > > >  static int qcom_pcie_suspend_noirq(struct device *dev)
> > > > > >  {
> > > > > >  	struct qcom_pcie *pcie;
> > > > > > +	struct dw_pcie_rp *pp;
> > > > > >  	int ret = 0;
> > > > > >  
> > > > > >  	pcie = dev_get_drvdata(dev);
> > > > > > @@ -2053,8 +2054,9 @@ static int qcom_pcie_suspend_noirq(struct device *dev)
> > > > > >  	 * powerdown state. This will affect the lifetime of the storage devices
> > > > > >  	 * like NVMe.
> > > > > >  	 */
> > > > > > -	if (!dw_pcie_link_up(pcie->pci)) {
> > > > > > -		qcom_pcie_host_deinit(&pcie->pci->pp);
> > > > > > +	pp = &pcie->pci->pp;
> > > > > > +	if (!pci_root_ports_have_device(pp->bridge->bus)) {
> > > > > > +		qcom_pcie_host_deinit(pp);
> > > > > >  		pcie->suspended = true;
> > > > > >  	}
> > > > > >  
> > > > > > -- 
> > > > > > 2.48.1
> > > > > > 
> > > > 
> > > > -- 
> 

-- 
மணிவண்ணன் சதாசிவம்

