Return-Path: <linux-pci+bounces-24094-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C23EA689CB
	for <lists+linux-pci@lfdr.de>; Wed, 19 Mar 2025 11:39:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D02C93B028A
	for <lists+linux-pci@lfdr.de>; Wed, 19 Mar 2025 10:37:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5169252917;
	Wed, 19 Mar 2025 10:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="THaB1Mxk"
X-Original-To: linux-pci@vger.kernel.org
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D060220E31B;
	Wed, 19 Mar 2025 10:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742380688; cv=none; b=fxNusGijjeIFPbbQ2uoD9dZrQx+hBZWW7t/GkjNNCdex0575WOphaUHuLXPmrsQZSXKipjjlH2T73DtTyi6Gd9QQPDhN3moiaZ+SiyOndIysNfIMYdP/5gN/a/XfupqG8cLbS6+JGhx3pexhrViUVlKnyZfRlgK4K4rRlF9RAnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742380688; c=relaxed/simple;
	bh=+oIZNufj1mq+T+ll5yqNMkYOAPUj49odlNka6Mg6bSU=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nVKzTy4SyT6TXNHN0rVXTd/r1HSNJPl5j0o7s4fITmAQMzeHZN8NukoQD+Dd635CSRmhjcBOGnpty4+LDkN8MOR0VDnjhzO1gxinzLLcNIazWpuUOBvtfuiHO2g2DJr5vVrkaTffdBMCyeINDuzqNOJaQvRCDcf5ECITZrtjdew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=THaB1Mxk; arc=none smtp.client-ip=198.47.23.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 52JAbbc6298165
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 19 Mar 2025 05:37:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1742380657;
	bh=VOJRXhgr4IvDYXXr3sLTtCmEn5aq6QJfPwnK5S28w5g=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=THaB1MxklKFszLt4uo+Kcwpd94AavvnNOGhhcEhJYjf7HeEli37mE7XGxcIM5PddP
	 PhqRLc2PVxBzS/ZtsWybKw5gTZeqC9S9AG3jFOls1SupDnC8/fbBO0qmkOrGa00zwu
	 kGzn+Z1n82sVRFvkRcapG88nFiMezHT3q0am6Mzs=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 52JAbb5l088419
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 19 Mar 2025 05:37:37 -0500
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 19
 Mar 2025 05:37:36 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 19 Mar 2025 05:37:36 -0500
Received: from localhost (uda0492258.dhcp.ti.com [10.24.72.113])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 52JAbZv4021781;
	Wed, 19 Mar 2025 05:37:36 -0500
Date: Wed, 19 Mar 2025 16:07:35 +0530
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
CC: Siddharth Vadapalli <s-vadapalli@ti.com>, <lpieralisi@kernel.org>,
        <kw@linux.com>, <robh@kernel.org>, <bhelgaas@google.com>,
        <vigneshr@ti.com>, <kishon@kernel.org>, <cassel@kernel.org>,
        <wojciech.jasko-EXT@continental-corporation.com>,
        <thomas.richard@bootlin.com>, <bwawrzyn@cisco.com>,
        <linux-pci@vger.kernel.org>, <linux-omap@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <srk@ti.com>
Subject: Re: [PATCH 3/4] PCI: cadence-ep: Introduce cdns_pcie_ep_disable
 helper for cleanup
Message-ID: <20250319103735.a45aa5trofo2c2fc@uda0492258>
References: <20250307103128.3287497-1-s-vadapalli@ti.com>
 <20250307103128.3287497-4-s-vadapalli@ti.com>
 <20250318080304.jsmrxqil6pn74nzh@thinkpad>
 <20250318081239.rvbk3rqud7wcj5pj@uda0492258>
 <20250319103217.aaoxpzk2baqna5vc@thinkpad>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250319103217.aaoxpzk2baqna5vc@thinkpad>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

On Wed, Mar 19, 2025 at 04:02:17PM +0530, Manivannan Sadhasivam wrote:
> On Tue, Mar 18, 2025 at 01:42:39PM +0530, Siddharth Vadapalli wrote:
> > On Tue, Mar 18, 2025 at 01:33:04PM +0530, Manivannan Sadhasivam wrote:
> > 
> > Hello Mani,
> > 
> > > On Fri, Mar 07, 2025 at 04:01:27PM +0530, Siddharth Vadapalli wrote:
> > > > Introduce the helper function cdns_pcie_ep_disable() which will undo the
> > > > configuration performed by cdns_pcie_ep_setup(). Also, export it for use
> > > > by the existing callers of cdns_pcie_ep_setup(), thereby allowing them
> > > > to cleanup on their exit path.
> > > > 
> > > > Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
> > > > ---
> > > >  drivers/pci/controller/cadence/pcie-cadence-ep.c | 10 ++++++++++
> > > >  drivers/pci/controller/cadence/pcie-cadence.h    |  5 +++++
> > > >  2 files changed, 15 insertions(+)
> > > > 
> > > > diff --git a/drivers/pci/controller/cadence/pcie-cadence-ep.c b/drivers/pci/controller/cadence/pcie-cadence-ep.c
> > > > index eeb2afdd223e..85bec57fa5d9 100644
> > > > --- a/drivers/pci/controller/cadence/pcie-cadence-ep.c
> > > > +++ b/drivers/pci/controller/cadence/pcie-cadence-ep.c
> > > > @@ -646,6 +646,16 @@ static const struct pci_epc_ops cdns_pcie_epc_ops = {
> > > >  	.get_features	= cdns_pcie_ep_get_features,
> > > >  };
> > > >  
> > > > +void cdns_pcie_ep_disable(struct cdns_pcie_ep *ep)
> > > > +{
> > > > +	struct device *dev = ep->pcie.dev;
> > > > +	struct pci_epc *epc = to_pci_epc(dev);
> > > > +
> > > 
> > > pci_epc_deinit_notify()
> > 
> > I had initially planned to add this, but I noticed that it is not
> > invoked by dw_pcie_ep_deinit() within
> > drivers/pci/controller/dwc/pcie-designware-ep.c
> > Since cdns_pcie_ep_disable() is similar to dw_pcie_ep_deinit(), I
> > decided to drop it. Current callers of pci_epc_deinit_notify() are:
> > drivers/pci/controller/dwc/pcie-qcom-ep.c
> > drivers/pci/controller/dwc/pcie-tegra194.c
> > while there are many more users of dw_pcie_ep_deinit() that don't invoke
> > pci_epc_deinit_notify().
> > 
> > While I don't intend to justify dropping pci_epc_deinit_notify() in the
> > cleanup path, I wanted to check if this should be added to
> > dw_pcie_ep_deinit() as well. Or is it the case that dw_pcie_ep_deinit()
> > is different from cdns_pcie_ep_disable()? Please let me know.
> > 
> 
> Reason why it was not added to dw_pcie_ep_deinit() because, deinit_notify() is
> supposed to be called while performing the resource cleanup with active refclk.
> 
> Some plaforms (Tegra, Qcom) depend on refclk from host. So if deinit_notify() is
> called when there is no refclk, it will crash the endpoint SoC. But since
> cadence endpoint platforms seem to generate their own refclk, you can call
> deinit_notify() during deinit phase.

Thank you for the clarification. I will add pci_epc_deinit_notify() to
cdns_pcie_ep_disable() in the v2 series.

Regards,
Siddharth.

