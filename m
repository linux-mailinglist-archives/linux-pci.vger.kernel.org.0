Return-Path: <linux-pci+bounces-43293-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 44E42CCBD4E
	for <lists+linux-pci@lfdr.de>; Thu, 18 Dec 2025 13:46:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 436463014DD9
	for <lists+linux-pci@lfdr.de>; Thu, 18 Dec 2025 12:46:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F2FB223DC0;
	Thu, 18 Dec 2025 12:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dPRd5jsT"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D97DD1DDC2B;
	Thu, 18 Dec 2025 12:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766061983; cv=none; b=nO52rw21a+rhbW9YkUdHBBRarpyQWfbwv8XyINLCXdPiHXdc1w5za1lhK+Ml+9pRNw9S9LBVJdUNyejno8mXkxlNryudsp234i9B0GHw+mHpwa+COSeVBueY1+yXlYi+ICyMdVWWwixXyeRhJCoMyKCZrqpTTmIf64Q2nGF9OZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766061983; c=relaxed/simple;
	bh=iow2/HnVfO+41VJ8cE5N73L+Q2vciDTFEl5afojOiP0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K17HqbyEzSVVuyjbYC16pFFSxxY3ms8cfBqDvcY0PnCtvr5+6TXXA8HXfkGTXbajA53VE4yLbaIJCO7U50JW7IqVsn/e7dJ9cqg9g8/Xt++AyiljR7mSCuUB4KweereuwtPuEgYFoFaC4I77SRIvUyogEsbXne4xIYWTV137jUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dPRd5jsT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 941DAC4CEFB;
	Thu, 18 Dec 2025 12:46:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766061982;
	bh=iow2/HnVfO+41VJ8cE5N73L+Q2vciDTFEl5afojOiP0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dPRd5jsTNOzzArdV6Yme+h5t1JRQjl3T0+omekN4KkwmmAmJwCkBzZAT5deHFeDn2
	 kY14iyynLJ59VE1EDVF5SYMn5EuOfkFW6JwgSWtOn47+cwBWuJNsDSF8lXkSha4tN9
	 gByeMFnTbf5GAD00wAbUo2JHNJ9GBpABmvOlpoRaLX9wLVydOXKkUdIZb7xg62b8O9
	 IOHEVEU/+Ptfe/4N+1eUoERrqtM6KUlcruBofI8lluICmceM7IXcS9qHG9jal7eMTQ
	 GBfmFrNoVe7asz4S46vFcqFBMyW2cMbRgWkaL2eQfkYHvL1uDviu4GIBXT+1YIFkpG
	 xiIVNEr+cmYmA==
Date: Thu, 18 Dec 2025 18:16:07 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Cc: manivannan.sadhasivam@oss.qualcomm.com, 
	Jingoo Han <jingoohan1@gmail.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Rob Herring <robh@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
	vincent.guittot@linaro.org, zhangsenchuan@eswincomputing.com
Subject: Re: [PATCH v2 2/2] PCI: dwc: Do not return failure if link is in
 Detect.Quiet/Active states
Message-ID: <isbb3bng27ibc3xddvjvlgbtz7skbbpd4q3a6rdqul7ghmmsyy@ze72f2hs4kb3>
References: <20251218-pci-dwc-suspend-rework-v2-0-5a7778c6094a@oss.qualcomm.com>
 <20251218-pci-dwc-suspend-rework-v2-2-5a7778c6094a@oss.qualcomm.com>
 <237606b2-783a-4e11-854b-fed787e2903d@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <237606b2-783a-4e11-854b-fed787e2903d@oss.qualcomm.com>

On Thu, Dec 18, 2025 at 05:57:30PM +0530, Krishna Chaitanya Chundru wrote:
> 
> 
> On 12/18/2025 5:34 PM, Manivannan Sadhasivam via B4 Relay wrote:
> > From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> > 
> > dw_pcie_wait_for_link() API waits for the link to be up and returns failure
> > if the link is not up within the 1 second interval. But if there was no
> > device connected to the bus, then the link up failure would be expected.
> > In that case, the callers might want to skip the failure in a hope that the
> > link will be up later when a device gets connected.
> > 
> > One of the callers, dw_pcie_host_init() is currently skipping the failure
> > irrespective of the link state, in an assumption that the link may come up
> > later. But this assumption is wrong, since LTSSM states other than
> > Detect.Quiet and Detect.Active during link training phase are considered to
> > be fatal and the link needs to be retrained.
> > 
> > So to avoid callers making wrong assumptions, skip returning failure from
> > dw_pcie_wait_for_link() only if the link is in Detect.Quiet or
> > Detect.Active states after timeout and also check the return value of the
> > API in dw_pcie_host_init().
> > 
> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> > ---
> >   drivers/pci/controller/dwc/pcie-designware-host.c |  8 +++++---
> >   drivers/pci/controller/dwc/pcie-designware.c      | 12 +++++++++++-
> >   2 files changed, 16 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> > index 43d091128ef7..ef6d9ae6eddb 100644
> > --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> > +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> > @@ -670,9 +670,11 @@ int dw_pcie_host_init(struct dw_pcie_rp *pp)
> >   	 * If there is no Link Up IRQ, we should not bypass the delay
> >   	 * because that would require users to manually rescan for devices.
> >   	 */
> > -	if (!pp->use_linkup_irq)
> > -		/* Ignore errors, the link may come up later */
> > -		dw_pcie_wait_for_link(pci);
> > +	if (!pp->use_linkup_irq) {
> > +		ret = dw_pcie_wait_for_link(pci);
> > +		if (ret)
> > +			goto err_stop_link;
> > +	}
> >   	ret = pci_host_probe(bridge);
> >   	if (ret)
> > diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
> > index 75fc8b767fcc..b58baf26ce58 100644
> > --- a/drivers/pci/controller/dwc/pcie-designware.c
> > +++ b/drivers/pci/controller/dwc/pcie-designware.c
> > @@ -641,7 +641,7 @@ void dw_pcie_disable_atu(struct dw_pcie *pci, u32 dir, int index)
> >   int dw_pcie_wait_for_link(struct dw_pcie *pci)
> >   {
> > -	u32 offset, val;
> > +	u32 offset, val, ltssm;
> >   	int retries;
> >   	/* Check if the link is up or not */
> > @@ -653,6 +653,16 @@ int dw_pcie_wait_for_link(struct dw_pcie *pci)
> >   	}
> >   	if (retries >= PCIE_LINK_WAIT_MAX_RETRIES) {
> > +		/*
> > +		 * If the link is in Detect.Quiet or Detect.Active state, it
> > +		 * indicates that no device is detected. So return success to
> > +		 * allow the device to show up later.
> > +		 */
> > +		ltssm = dw_pcie_get_ltssm(pci);
> > +		if (ltssm == DW_PCIE_LTSSM_DETECT_QUIET ||
> > +		    ltssm == DW_PCIE_LTSSM_DETECT_ACT)
> > +			return 0;
> > +
> >   		dev_info(pci->dev, "Phy link never came up\n");
> Can you move this print above, as this print is useful for the user to know
> that, link is not up yet.
> 

If the device is not connected to the bus, what information does this log
provide to the user?

- Mani

-- 
மணிவண்ணன் சதாசிவம்

