Return-Path: <linux-pci+bounces-40498-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 6714DC3AC22
	for <lists+linux-pci@lfdr.de>; Thu, 06 Nov 2025 13:03:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C55764FF796
	for <lists+linux-pci@lfdr.de>; Thu,  6 Nov 2025 11:57:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C336309EEC;
	Thu,  6 Nov 2025 11:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qTYUyF6O"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D141F3054CC;
	Thu,  6 Nov 2025 11:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762430249; cv=none; b=lyMEXIzzhxNsZwceQemEtVk7BdFbi6c1cnWx6Uspbx8cCRKPXNjnN6w4BR1UFBvmN9U1n0w8qr+vimTnr+keKpnk9erIoEAhcXZfHzmf43nHXYGNgrP6mgrrFm+h9EqBF/eBjmmWY/VeAo5peJvUnsFGBbrhqUDNXr28koo+CDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762430249; c=relaxed/simple;
	bh=thdjpoj+CQFQEDmVxt2Zs5fZKs/cKk6AVQwlozuvWJY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nhLhlF2jH0jr7n5VcE/ug1xA+6CIBwUZuQFJy9x2v9++4o8xe6/mCjBAn4HRVGYvg2jkEXW4ypye+A7k5i0PERRtYMBp9i8WUyeIDFdd/hWx2km8G6wbgzU09kfIHtK8VK2DtM9J7Be4OBgrOcLyDDZEe5U2hpfTY3V0IPPJJO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qTYUyF6O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8622BC116C6;
	Thu,  6 Nov 2025 11:57:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762430249;
	bh=thdjpoj+CQFQEDmVxt2Zs5fZKs/cKk6AVQwlozuvWJY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qTYUyF6O26+Q2CDV23JgJxKhSKSTHh2mAVe95GYqtnQJhu+HcdHdcJ7fGaAyR11Ty
	 60/9bUkMq8qpusH7uMNiqf6f5xq4BjOAMO8wPiC2HWIRA3kEH9I0ynn4S9KjGOaf5B
	 XHlE5wBiXGw4YpwwBuuBDlfHbqVcGiySeCZIDA9zJfF6YVg/2jsZEpV6BXMy8ClUhj
	 i0Gl0mRj5MEQdiu56W/06HxyJUjFR786LW/nZp+YgSMcxmuiUwiWGKG9GQs0L6AbnQ
	 IXvrpJd4oZNOtSNBt85SOBWqXCeoLcBi5uG8g8OhhAY0Oo3xxryhLzIcyrgAXLEasC
	 /RCDto9TluJ/A==
Date: Thu, 6 Nov 2025 17:27:16 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: zhangsenchuan <zhangsenchuan@eswincomputing.com>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>, 
	lpieralisi@kernel.org, kwilczynski@kernel.org, bhelgaas@google.com, will@kernel.org, 
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, robh@kernel.org, 
	linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 2/3] PCI: qcom: Check for the presence of a device
 instead of Link up during suspend
Message-ID: <nhjlanhzndhlbtfohnkypwuzpw6nw43cysjmoam3qv4rrs22hr@ic3hgtfoeb6e>
References: <20251106061326.8241-1-manivannan.sadhasivam@oss.qualcomm.com>
 <20251106061326.8241-3-manivannan.sadhasivam@oss.qualcomm.com>
 <35086b08.c4e.19a58a7d6bc.Coremail.zhangsenchuan@eswincomputing.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <35086b08.c4e.19a58a7d6bc.Coremail.zhangsenchuan@eswincomputing.com>

On Thu, Nov 06, 2025 at 06:13:05PM +0800, zhangsenchuan wrote:
> 
> 
> 
> > -----Original Messages-----
> > From: "Manivannan Sadhasivam" <manivannan.sadhasivam@oss.qualcomm.com>
> > Send time:Thursday, 06/11/2025 14:13:25
> > To: lpieralisi@kernel.org, kwilczynski@kernel.org, mani@kernel.org, bhelgaas@google.com
> > Cc: will@kernel.org, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, robh@kernel.org, linux-arm-msm@vger.kernel.org, zhangsenchuan@eswincomputing.com, "Manivannan Sadhasivam" <manivannan.sadhasivam@oss.qualcomm.com>
> > Subject: [PATCH 2/3] PCI: qcom: Check for the presence of a device instead of Link up during suspend
> > 
> > The suspend handler checks for the PCIe Link up to decide when to turn off
> > the controller resources. But this check is racy as the PCIe Link can go
> > down just after this check.
> > 
> > So use the newly introduced API, pci_root_ports_have_device() that checks
> > for the presence of a device under any of the Root Ports to replace the
> > Link up check.
> > 
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
> 
> I'm a little confused.
> The pci_root_ports_have_device function can help check if there is any device 
> available under the Root Ports, if there is a device available, the resource 
> cannot be released, is it also necessary to release resources when entering 
> the L2/L3 state?
> 

It is upto the controller driver to decide. Once the link enters L2/L3, the
device will be in D3Cold state. So the controller can just disable all PCIe
resources to save power.

But it is not possible to transition all PCIe devices to D3Cold during suspend,
for instance NVMe. I'm hoping to fix it too in the coming days.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

