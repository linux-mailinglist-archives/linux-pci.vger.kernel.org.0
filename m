Return-Path: <linux-pci+bounces-43298-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A2CECCBE84
	for <lists+linux-pci@lfdr.de>; Thu, 18 Dec 2025 14:03:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 858D5307D35D
	for <lists+linux-pci@lfdr.de>; Thu, 18 Dec 2025 13:00:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9AFF33D6D0;
	Thu, 18 Dec 2025 13:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QR7tTsre"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 893D833D6FE;
	Thu, 18 Dec 2025 13:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766062823; cv=none; b=HdOL612g6+IZ1VnSkUZrZis5ai71G1HYGtKvS9uu5Ca1+dDxTdLhQ7+Vm5FLwC82b2ImUXpVGQjd8u3UJqklUEwlL7ECrPoJe2r6+Iw9/1k0gmRNPSwXcoJaQmlheVnuPC3l/OYXYwt03OLTZsaXUx6lP2+oHd3jWpaSjYI3Lh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766062823; c=relaxed/simple;
	bh=njGgsHcpbqblIeXpde3Af3FW7XJ+KexzcPhyoEDqKcQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XLwvrV6K7SP8XBmgrfOsnpdeCzPnh3VCCKhdYnpTI4Y+60qR98k5WhT53nqRa++Y9RYxbp22bk/pCW8AKhuZmFc3QsLDnq+AJLsseSnlFIXD37fF5h9neu0ieT2fba65Pr0/LrQymzeMFhPUNGnqA2qtHe8qnOi3nEjJlYvd8Ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QR7tTsre; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A4D8C4CEFB;
	Thu, 18 Dec 2025 13:00:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766062822;
	bh=njGgsHcpbqblIeXpde3Af3FW7XJ+KexzcPhyoEDqKcQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QR7tTsre+JR5M/O0Q1sOYMRKe2IKX3ve/7fvgJzHpMj90XGwgeCCDk+wNlY/RrK4P
	 ALWoaz7zShGddgUE470xKIWuZ8le/PhITN3iW6KDcUo1nQZMuLypNVP+AfHW2Uswny
	 uFxvmD9dXXkIE17MMEK9w/yFOAbCRu3MJatmQHt4vaZY8PoWyNNs7/tVke3BapFMUb
	 uwlDIr3jQoulCVPGVfTycdVhBMH0gT+OYqpytMtUUosrn0e916s7tFCS8s0FGGps/p
	 F256KqvZo2nEWw1mvfovfWgNelN9Q928SZtaJbKadULU3ehpRXKtalxqJFMzyrEbW1
	 yQa1ToAYRNkPA==
Date: Thu, 18 Dec 2025 18:30:08 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Cc: manivannan.sadhasivam@oss.qualcomm.com, 
	Jingoo Han <jingoohan1@gmail.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Rob Herring <robh@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
	vincent.guittot@linaro.org, zhangsenchuan@eswincomputing.com
Subject: Re: [PATCH v2 2/2] PCI: dwc: Do not return failure if link is in
 Detect.Quiet/Active states
Message-ID: <bawi2oioatfrmxuwd26xlvytmtuo2mhf3yunbwrzam22y57wvm@3l4hdbzjjske>
References: <20251218-pci-dwc-suspend-rework-v2-0-5a7778c6094a@oss.qualcomm.com>
 <20251218-pci-dwc-suspend-rework-v2-2-5a7778c6094a@oss.qualcomm.com>
 <237606b2-783a-4e11-854b-fed787e2903d@oss.qualcomm.com>
 <isbb3bng27ibc3xddvjvlgbtz7skbbpd4q3a6rdqul7ghmmsyy@ze72f2hs4kb3>
 <c4aedf62-633d-4871-9dfa-af021e9a8e42@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c4aedf62-633d-4871-9dfa-af021e9a8e42@oss.qualcomm.com>

On Thu, Dec 18, 2025 at 06:26:12PM +0530, Krishna Chaitanya Chundru wrote:
> 
> 
> On 12/18/2025 6:16 PM, Manivannan Sadhasivam wrote:
> > On Thu, Dec 18, 2025 at 05:57:30PM +0530, Krishna Chaitanya Chundru wrote:
> > > 
> > > On 12/18/2025 5:34 PM, Manivannan Sadhasivam via B4 Relay wrote:
> > > > From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> > > > 
> > > > dw_pcie_wait_for_link() API waits for the link to be up and returns failure
> > > > if the link is not up within the 1 second interval. But if there was no
> > > > device connected to the bus, then the link up failure would be expected.
> > > > In that case, the callers might want to skip the failure in a hope that the
> > > > link will be up later when a device gets connected.
> > > > 
> > > > One of the callers, dw_pcie_host_init() is currently skipping the failure
> > > > irrespective of the link state, in an assumption that the link may come up
> > > > later. But this assumption is wrong, since LTSSM states other than
> > > > Detect.Quiet and Detect.Active during link training phase are considered to
> > > > be fatal and the link needs to be retrained.
> > > > 
> > > > So to avoid callers making wrong assumptions, skip returning failure from
> > > > dw_pcie_wait_for_link() only if the link is in Detect.Quiet or
> > > > Detect.Active states after timeout and also check the return value of the
> > > > API in dw_pcie_host_init().
> > > > 
> > > > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> > > > ---
> > > >    drivers/pci/controller/dwc/pcie-designware-host.c |  8 +++++---
> > > >    drivers/pci/controller/dwc/pcie-designware.c      | 12 +++++++++++-
> > > >    2 files changed, 16 insertions(+), 4 deletions(-)
> > > > 
> > > > diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> > > > index 43d091128ef7..ef6d9ae6eddb 100644
> > > > --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> > > > +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> > > > @@ -670,9 +670,11 @@ int dw_pcie_host_init(struct dw_pcie_rp *pp)
> > > >    	 * If there is no Link Up IRQ, we should not bypass the delay
> > > >    	 * because that would require users to manually rescan for devices.
> > > >    	 */
> > > > -	if (!pp->use_linkup_irq)
> > > > -		/* Ignore errors, the link may come up later */
> > > > -		dw_pcie_wait_for_link(pci);
> > > > +	if (!pp->use_linkup_irq) {
> > > > +		ret = dw_pcie_wait_for_link(pci);
> > > > +		if (ret)
> > > > +			goto err_stop_link;
> > > > +	}
> > > >    	ret = pci_host_probe(bridge);
> > > >    	if (ret)
> > > > diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
> > > > index 75fc8b767fcc..b58baf26ce58 100644
> > > > --- a/drivers/pci/controller/dwc/pcie-designware.c
> > > > +++ b/drivers/pci/controller/dwc/pcie-designware.c
> > > > @@ -641,7 +641,7 @@ void dw_pcie_disable_atu(struct dw_pcie *pci, u32 dir, int index)
> > > >    int dw_pcie_wait_for_link(struct dw_pcie *pci)
> > > >    {
> > > > -	u32 offset, val;
> > > > +	u32 offset, val, ltssm;
> > > >    	int retries;
> > > >    	/* Check if the link is up or not */
> > > > @@ -653,6 +653,16 @@ int dw_pcie_wait_for_link(struct dw_pcie *pci)
> > > >    	}
> > > >    	if (retries >= PCIE_LINK_WAIT_MAX_RETRIES) {
> > > > +		/*
> > > > +		 * If the link is in Detect.Quiet or Detect.Active state, it
> > > > +		 * indicates that no device is detected. So return success to
> > > > +		 * allow the device to show up later.
> > > > +		 */
> > > > +		ltssm = dw_pcie_get_ltssm(pci);
> > > > +		if (ltssm == DW_PCIE_LTSSM_DETECT_QUIET ||
> > > > +		    ltssm == DW_PCIE_LTSSM_DETECT_ACT)
> > > > +			return 0;
> > > > +
> > > >    		dev_info(pci->dev, "Phy link never came up\n");
> > > Can you move this print above, as this print is useful for the user to know
> > > that, link is not up yet.
> > > 
> > If the device is not connected to the bus, what information does this log
> > provide to the user?
> Not every user is aware that device is not connected, at-least this log will
> give info
> that there is no device connected.
> 

Users won't grep the dmesg log to check whether the device is connected to the
bus or not. They will use lspci.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

