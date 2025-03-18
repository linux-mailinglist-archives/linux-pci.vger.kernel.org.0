Return-Path: <linux-pci+bounces-24018-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C8F7A66D9F
	for <lists+linux-pci@lfdr.de>; Tue, 18 Mar 2025 09:13:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B84F2188D720
	for <lists+linux-pci@lfdr.de>; Tue, 18 Mar 2025 08:13:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED9AE1F099B;
	Tue, 18 Mar 2025 08:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="QYFhh0eO"
X-Original-To: linux-pci@vger.kernel.org
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDBD81E5210;
	Tue, 18 Mar 2025 08:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742285582; cv=none; b=HinrE8EiUs3XFfB/nD0eNhTirLJWMjK4tVXR1j0ei9v5c0sm9NvKjCZNyLN0njIN785+gRE+kdBlDqN9Yo5KEA4aDAFRdpkU5oloFwH20OrPDJ1PZkAiJQyWVXjRLDYRVnkSlX49NnwjI/rvrWCdexCJpcfawHn17ta9mDkjBQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742285582; c=relaxed/simple;
	bh=Jj0WJSIFKW8IrLIMv+z2ATAn6m3tJUDcQC9IJTRzJug=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AFlyv9B4ZQTyvMGUkDzFTz8jkxEP3LilybVl3sA/04xs8PrhF9SaCETDCyfPGT91a1eeNAlrqOwKwTpUq272xZ+Yea6nre++7iqc4dbea27uEbQWfOQoakjR/bKK88zn9SxulcpWsk9o+yeCdv7GEFOiTHimQvYr9ZY+UBoMiUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=QYFhh0eO; arc=none smtp.client-ip=198.47.19.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 52I8CfIN2536216
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Mar 2025 03:12:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1742285561;
	bh=fQnSIng1DzSrN6FKX97JDv8uNpyxw+LXDmkCxypY3C0=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=QYFhh0eObwp/Pp25IOFP6ChAyq3vK36xlhih1MEyi+Jt/F3/mr7cvq3JB2exqIAap
	 19gjPkhzaORM3YXUd+ySm3R7547mArCcDTSfYU2kEn0GdT1aBkkjvQuMS4aYG43WS2
	 cJvLHs3nzrMid4T9zmJ0A5T7q8Lpylm6L7H5BOgA=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 52I8CfHn036264
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 18 Mar 2025 03:12:41 -0500
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 18
 Mar 2025 03:12:41 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 18 Mar 2025 03:12:41 -0500
Received: from localhost (uda0492258.dhcp.ti.com [10.24.72.113])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 52I8Cebp030408;
	Tue, 18 Mar 2025 03:12:40 -0500
Date: Tue, 18 Mar 2025 13:42:39 +0530
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
Message-ID: <20250318081239.rvbk3rqud7wcj5pj@uda0492258>
References: <20250307103128.3287497-1-s-vadapalli@ti.com>
 <20250307103128.3287497-4-s-vadapalli@ti.com>
 <20250318080304.jsmrxqil6pn74nzh@thinkpad>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250318080304.jsmrxqil6pn74nzh@thinkpad>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

On Tue, Mar 18, 2025 at 01:33:04PM +0530, Manivannan Sadhasivam wrote:

Hello Mani,

> On Fri, Mar 07, 2025 at 04:01:27PM +0530, Siddharth Vadapalli wrote:
> > Introduce the helper function cdns_pcie_ep_disable() which will undo the
> > configuration performed by cdns_pcie_ep_setup(). Also, export it for use
> > by the existing callers of cdns_pcie_ep_setup(), thereby allowing them
> > to cleanup on their exit path.
> > 
> > Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
> > ---
> >  drivers/pci/controller/cadence/pcie-cadence-ep.c | 10 ++++++++++
> >  drivers/pci/controller/cadence/pcie-cadence.h    |  5 +++++
> >  2 files changed, 15 insertions(+)
> > 
> > diff --git a/drivers/pci/controller/cadence/pcie-cadence-ep.c b/drivers/pci/controller/cadence/pcie-cadence-ep.c
> > index eeb2afdd223e..85bec57fa5d9 100644
> > --- a/drivers/pci/controller/cadence/pcie-cadence-ep.c
> > +++ b/drivers/pci/controller/cadence/pcie-cadence-ep.c
> > @@ -646,6 +646,16 @@ static const struct pci_epc_ops cdns_pcie_epc_ops = {
> >  	.get_features	= cdns_pcie_ep_get_features,
> >  };
> >  
> > +void cdns_pcie_ep_disable(struct cdns_pcie_ep *ep)
> > +{
> > +	struct device *dev = ep->pcie.dev;
> > +	struct pci_epc *epc = to_pci_epc(dev);
> > +
> 
> pci_epc_deinit_notify()

I had initially planned to add this, but I noticed that it is not
invoked by dw_pcie_ep_deinit() within
drivers/pci/controller/dwc/pcie-designware-ep.c
Since cdns_pcie_ep_disable() is similar to dw_pcie_ep_deinit(), I
decided to drop it. Current callers of pci_epc_deinit_notify() are:
drivers/pci/controller/dwc/pcie-qcom-ep.c
drivers/pci/controller/dwc/pcie-tegra194.c
while there are many more users of dw_pcie_ep_deinit() that don't invoke
pci_epc_deinit_notify().

While I don't intend to justify dropping pci_epc_deinit_notify() in the
cleanup path, I wanted to check if this should be added to
dw_pcie_ep_deinit() as well. Or is it the case that dw_pcie_ep_deinit()
is different from cdns_pcie_ep_disable()? Please let me know.

Regards,
Siddharth.

