Return-Path: <linux-pci+bounces-41146-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D595C594F1
	for <lists+linux-pci@lfdr.de>; Thu, 13 Nov 2025 19:00:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B43B850808A
	for <lists+linux-pci@lfdr.de>; Thu, 13 Nov 2025 17:23:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C858E2D73B2;
	Thu, 13 Nov 2025 17:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SKsY10Lu"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99D5629E0E5;
	Thu, 13 Nov 2025 17:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763054572; cv=none; b=mm13JgoFCM2LXoZ8vfTtHSJQ6iYefEW2/oS0139P3BY4gwwBquJmrbN4dd/frqkkQrLmPU4uYRiwZPavJBLDcxgbHoCTJRtMzMrJPCCJFlNkw0WKoNAlwA2Filrg+3McgCyD6c2uHgyZ8+aP79fShfiM9ZOhn1wXEv13BJ8H4dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763054572; c=relaxed/simple;
	bh=e8yo/Z7TSasynCjYpy8uIS8ubYj77xNchCdhFaFEfiI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=qzxtd3DCNNqYwHeDx/69XGOuzV0AAqG5M1IPKgrOUPLXjX5l2WijcpWZqJNHVKOgOb0GmmpzoE5xkj4fcX3Lw8adZJgJc2eVPOImLk1RED6fFwkROXdMooJ6D3Ez3qC1MGlc9BzBiVvKKuX0fCvXEbnkJjLrP/RayBstDPrv1jQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SKsY10Lu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB614C19422;
	Thu, 13 Nov 2025 17:22:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763054572;
	bh=e8yo/Z7TSasynCjYpy8uIS8ubYj77xNchCdhFaFEfiI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=SKsY10Lu/yHxBKeQ0HKqoWu1CFUlAKN0OX0fjA3NHrzL+YUOsHOi3jLvlR8t0SzCT
	 LVWI4TGYLZCKNNz4b3RD2bp0mNZJHmolRnJBVQqunV6e5M1H8UvPGgv4omNbfWEF4I
	 dgCUBW81c5/o3SzflOVDlEJiunEBFeGC4kzTEUAbnbZb0eyCt8pTfcK5tTADzIbvHJ
	 dBYn4sri9xxVqLnECbWa2Mmmb4yChHFy8fj2xWsWQ7h7M9sYKHn1Vvqx1YCSrrt6WN
	 FX02WKn1U8qLBs/gGn1RPL0Y/ZDe/NGMfp6MeBx16nRu7WB6TswO6eH+h/zbQhh4eU
	 gi2bL1SatI0KA==
Date: Thu, 13 Nov 2025 11:22:50 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
	lpieralisi@kernel.org, kwilczynski@kernel.org, bhelgaas@google.com,
	will@kernel.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, robh@kernel.org,
	linux-arm-msm@vger.kernel.org, zhangsenchuan@eswincomputing.com,
	vincent.guittot@linaro.org
Subject: Re: [PATCH v2 2/3] PCI: qcom: Check for the presence of a device
 instead of Link up during suspend
Message-ID: <20251113172250.GA2291436@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <zgj3ubyb234ig6ndz6ov5q3szvuxnd3jkz2rjglbad4ksri6nl@ov7boxuar4va>

On Thu, Nov 13, 2025 at 10:24:17PM +0530, Manivannan Sadhasivam wrote:
> On Thu, Nov 13, 2025 at 10:41:47AM -0600, Bjorn Helgaas wrote:
> > On Fri, Nov 07, 2025 at 10:13:18AM +0530, Manivannan Sadhasivam wrote:
> > > The suspend handler checks for the PCIe Link up to decide when to turn off
> > > the controller resources. But this check is racy as the PCIe Link can go
> > > down just after this check.
> > > 
> > > So use the newly introduced API, pci_root_ports_have_device() that checks
> > > for the presence of a device under any of the Root Ports to replace the
> > > Link up check.
> > 
> > Why is pci_root_ports_have_device() itself not racy?
> 
> Because it is very uncommon for the 'pci_dev' to go away during the
> host controller suspend. It might still be possible in edge cases,
> but very common as the link down. I can reword it.

I guess it's better to acknowledge replacing one race with another
than it would be to suggest that this *removes* a race.

But I don't understand the point of this.  Is
pci_root_ports_have_device() *less* racy than the
qcom_pcie_suspend_noirq() check?  Why would that be?

I'm kind of skeptical about adding pci_root_ports_have_device() at
all.  It seems like it just encourages racy behavior in drivers.

> > > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> > > ---
> > >  drivers/pci/controller/dwc/pcie-qcom.c | 6 ++++--
> > >  1 file changed, 4 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> > > index 805edbbfe7eb..b2b89e2e4916 100644
> > > --- a/drivers/pci/controller/dwc/pcie-qcom.c
> > > +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> > > @@ -2018,6 +2018,7 @@ static int qcom_pcie_probe(struct platform_device *pdev)
> > >  static int qcom_pcie_suspend_noirq(struct device *dev)
> > >  {
> > >  	struct qcom_pcie *pcie;
> > > +	struct dw_pcie_rp *pp;
> > >  	int ret = 0;
> > >  
> > >  	pcie = dev_get_drvdata(dev);
> > > @@ -2053,8 +2054,9 @@ static int qcom_pcie_suspend_noirq(struct device *dev)
> > >  	 * powerdown state. This will affect the lifetime of the storage devices
> > >  	 * like NVMe.
> > >  	 */
> > > -	if (!dw_pcie_link_up(pcie->pci)) {
> > > -		qcom_pcie_host_deinit(&pcie->pci->pp);
> > > +	pp = &pcie->pci->pp;
> > > +	if (!pci_root_ports_have_device(pp->bridge->bus)) {
> > > +		qcom_pcie_host_deinit(pp);
> > >  		pcie->suspended = true;
> > >  	}
> > >  
> > > -- 
> > > 2.48.1
> > > 
> 
> -- 
> மணிவண்ணன் சதாசிவம்

