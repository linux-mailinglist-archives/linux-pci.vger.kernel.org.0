Return-Path: <linux-pci+bounces-40616-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F06EC42B49
	for <lists+linux-pci@lfdr.de>; Sat, 08 Nov 2025 11:25:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DBFDF4E17B7
	for <lists+linux-pci@lfdr.de>; Sat,  8 Nov 2025 10:25:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AAF32FC03C;
	Sat,  8 Nov 2025 10:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HsES8Grr"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F08C32FC024;
	Sat,  8 Nov 2025 10:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762597546; cv=none; b=PwPsac+iy6m4Nam7poeynM46WBVIRyIZ0tC13YPkDD3GFP1ssjgOJjScOh0yegJJIAbFJL6KgCOgP2H9HkE8bK4E2VZUn7mMbEonNXMp6PEWKX9aA0xDr1fRcNOh9TJ4IKCP353ypqRn0xmfm4et/YIEAvnLgQEoiROZg7vcKsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762597546; c=relaxed/simple;
	bh=/lzpp2hutG7w6lHjA7gdUitoqzyXLEMEeC1cme6g5ck=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KWdiTzzYKc4d+lKtzwDpkfhogtMaeO1EmYs5gQXMWAKTnU5bf/Dgv33qrG2PhCq24vh3vQcRkubbEZfc2K9Xpo410KciqTcfIN9LKKXWCx0CBsMHiRtJpzSAVEmTJAAvyM9mB1SJGcmvzoy0/+DAEquPMrs7D8HcuJKCjteU5Nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HsES8Grr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C587BC2BC86;
	Sat,  8 Nov 2025 10:25:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762597545;
	bh=/lzpp2hutG7w6lHjA7gdUitoqzyXLEMEeC1cme6g5ck=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HsES8GrraJijftiyIl+hnn48eHbZTQtnCEKLc+kLEBOQu3KRpaHZ9QoyL5D32KRhp
	 Q93acu1mUliZC+KbuyxX8t1mJF1bv0Jijotyd8WQQNiP4qCnZOrlEnjM88J86MJk3c
	 f/cudPUpxYOugpsFimF5kzj01qp0ZwhVYmGMTWWP+CusMyozO76qXKSEzFHTB33n7r
	 VRl0Ffb4Fug0epgg6+TUPa7D0sAn0rAcCBL2YmA0jj/EbCUfDuxXX+oI8FbWhxAXga
	 nARORZO+o2EEpwyB1500dH2nXW+YZAwn2Z9+qYtz0+WjYisE3t8z1Z3WZbE23OyaIb
	 GbSKFC0o26brA==
Date: Sat, 8 Nov 2025 15:55:36 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: zhangsenchuan <zhangsenchuan@eswincomputing.com>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>, 
	lpieralisi@kernel.org, kwilczynski@kernel.org, bhelgaas@google.com, will@kernel.org, 
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, robh@kernel.org, 
	linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 2/3] PCI: qcom: Check for the presence of a device
 instead of Link up during suspend
Message-ID: <fnayczbumpynzvhafv3ryozlg2qwsxsyzpn5p44kc4o3hy7uux@lp5qgsd6ajtw>
References: <20251106061326.8241-1-manivannan.sadhasivam@oss.qualcomm.com>
 <20251106061326.8241-3-manivannan.sadhasivam@oss.qualcomm.com>
 <35086b08.c4e.19a58a7d6bc.Coremail.zhangsenchuan@eswincomputing.com>
 <nhjlanhzndhlbtfohnkypwuzpw6nw43cysjmoam3qv4rrs22hr@ic3hgtfoeb6e>
 <311e1152.cc3.19a5cff7033.Coremail.zhangsenchuan@eswincomputing.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <311e1152.cc3.19a5cff7033.Coremail.zhangsenchuan@eswincomputing.com>

On Fri, Nov 07, 2025 at 02:27:15PM +0800, zhangsenchuan wrote:
> 
> 
> 
> > -----Original Messages-----
> > From: "Manivannan Sadhasivam" <mani@kernel.org>
> > Send time:Thursday, 06/11/2025 19:57:16
> > To: zhangsenchuan <zhangsenchuan@eswincomputing.com>
> > Cc: "Manivannan Sadhasivam" <manivannan.sadhasivam@oss.qualcomm.com>, lpieralisi@kernel.org, kwilczynski@kernel.org, bhelgaas@google.com, will@kernel.org, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, robh@kernel.org, linux-arm-msm@vger.kernel.org
> > Subject: Re: [PATCH 2/3] PCI: qcom: Check for the presence of a device instead of Link up during suspend
> > 
> > On Thu, Nov 06, 2025 at 06:13:05PM +0800, zhangsenchuan wrote:
> > > 
> > > 
> > > 
> > > > -----Original Messages-----
> > > > From: "Manivannan Sadhasivam" <manivannan.sadhasivam@oss.qualcomm.com>
> > > > Send time:Thursday, 06/11/2025 14:13:25
> > > > To: lpieralisi@kernel.org, kwilczynski@kernel.org, mani@kernel.org, bhelgaas@google.com
> > > > Cc: will@kernel.org, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, robh@kernel.org, linux-arm-msm@vger.kernel.org, zhangsenchuan@eswincomputing.com, "Manivannan Sadhasivam" <manivannan.sadhasivam@oss.qualcomm.com>
> > > > Subject: [PATCH 2/3] PCI: qcom: Check for the presence of a device instead of Link up during suspend
> > > > 
> > > > The suspend handler checks for the PCIe Link up to decide when to turn off
> > > > the controller resources. But this check is racy as the PCIe Link can go
> > > > down just after this check.
> > > > 
> > > > So use the newly introduced API, pci_root_ports_have_device() that checks
> > > > for the presence of a device under any of the Root Ports to replace the
> > > > Link up check.
> > > > 
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
> > > 
> > > I'm a little confused.
> > > The pci_root_ports_have_device function can help check if there is any device 
> > > available under the Root Ports, if there is a device available, the resource 
> > > cannot be released, is it also necessary to release resources when entering 
> > > the L2/L3 state?
> > > 
> > 
> > It is upto the controller driver to decide. Once the link enters L2/L3, the
> > device will be in D3Cold state. So the controller can just disable all PCIe
> > resources to save power.
> > 
> > But it is not possible to transition all PCIe devices to D3Cold during suspend,
> > for instance NVMe. I'm hoping to fix it too in the coming days.
> > 
> Hi, Manivannan
> 
> Thank you for your explanation.
> 
> By the way, in v5 patch, I removed the dw_pcie_link_up judgment, and currently
> resources are directly released.
> At present, i have completed the pcie v5 patch without adding the 
> pci_root_ports_have_device function. Do I need to wait for you to merge it 
> before sending the V5 patch?
> 

I've merged my series to pci/controller/dwc branch. You can use this branch as a
base for your v5.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

