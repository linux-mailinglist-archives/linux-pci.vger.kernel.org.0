Return-Path: <linux-pci+bounces-41141-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 74B05C594DF
	for <lists+linux-pci@lfdr.de>; Thu, 13 Nov 2025 18:58:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2C4554FB82C
	for <lists+linux-pci@lfdr.de>; Thu, 13 Nov 2025 17:10:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D073835581E;
	Thu, 13 Nov 2025 16:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SBvcqTPJ"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 983D9352935;
	Thu, 13 Nov 2025 16:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763053004; cv=none; b=PlfOn1KW2axIUgW/jV49h25sC8dbydCJhL/bt4TVRVOscZXKCbVlUgqqpQPmpTX42gYQirWM1GqnYWTPXVpN9mF42F8CGTC4oJNMo7wHKY2ZzQlq8ZJMlkp9NaWH8sMF7ifXtqvXFJ0QLMKgvAEIeNISps+PLmn8aOwfBZnjHgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763053004; c=relaxed/simple;
	bh=jzytsllnjQJ99vmFdu3C51azo2FL03qL04AUDKMdEwI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XjEqgvQD3qelfIMzd1A6Kup/nW/LsHC+/M1AnDn+SB+2i16A8QdGdklxeF5dxe7+uO5bYYiUb2FS34Izlfwef/zUdVdc5viMnTnG5FwonOfYCJkA+IAdqLPquF7EuPIKnAPyXWseuTD2fP1qZFazYHF1w73pxdRnqszS2DOzp6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SBvcqTPJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11B75C4CEFB;
	Thu, 13 Nov 2025 16:56:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763053004;
	bh=jzytsllnjQJ99vmFdu3C51azo2FL03qL04AUDKMdEwI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SBvcqTPJUzuQ8g+vcQkQ4zbB/YI2PFzt7W15NhJUzRbIjFW9/foP3KfLmmEiEIKAJ
	 kTyUAuEJ7Hk2gvaGwq9hIrCkL7JBMGkt2h1Nw3ng+rfodHGoi3CEKB8HNL/Tk39Pds
	 GEd4GpnHoPF4cnDO03L0IlJ+J1rY/uRDL3xm5tXcbRvLe6RyiXS7YU3XnhjInCPMn+
	 WKJMxDjK5BSgQ8wqWgIJ3EbRSnUuGQgMv8cjRHucxD8DNKPku1GXIuoMHqXFOwu8Il
	 YQRONWWEI6lOES86eky6SvP3MIT7cVx+P6QhSR1bw7v2PZraZF0prqNeq8vd5tgs+Z
	 RFfhV/97ccuAg==
Date: Thu, 13 Nov 2025 22:26:29 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Frank Li <Frank.li@nxp.com>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>, 
	lpieralisi@kernel.org, kwilczynski@kernel.org, bhelgaas@google.com, will@kernel.org, 
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, robh@kernel.org, 
	linux-arm-msm@vger.kernel.org, zhangsenchuan@eswincomputing.com, vincent.guittot@linaro.org
Subject: Re: [PATCH v2 3/3] PCI: dwc: Check for the device presence during
 suspend and resume
Message-ID: <pzpyipassbzzsffys5mexxxip7oubwq37a564skb5udkfh363b@3sbkrz7atj3s>
References: <20251107044319.8356-1-manivannan.sadhasivam@oss.qualcomm.com>
 <20251107044319.8356-4-manivannan.sadhasivam@oss.qualcomm.com>
 <aRISPgCZyEZxStIN@lizhi-Precision-Tower-5810>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aRISPgCZyEZxStIN@lizhi-Precision-Tower-5810>

On Mon, Nov 10, 2025 at 11:26:38AM -0500, Frank Li wrote:
> On Fri, Nov 07, 2025 at 10:13:19AM +0530, Manivannan Sadhasivam wrote:
> > If there is no device available under the Root Ports, there is no point in
> > sending PME_Turn_Off and waiting for L2/L3 transition during suspend, it
> > will result in a timeout. Hence, skip those steps if no device is available
> > during suspend.
> >
> > During resume, do not wait for the link up if there was no device connected
> > before suspend. It is very unlikely that a device will get connected while
> > the host system was suspended.
> >
> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> > ---
> >  drivers/pci/controller/dwc/pcie-designware-host.c | 13 +++++++++++++
> >  1 file changed, 13 insertions(+)
> >
> > diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> > index 20c9333bcb1c..5a39e7139ec9 100644
> > --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> > +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> > @@ -20,6 +20,7 @@
> >  #include <linux/platform_device.h>
> >
> >  #include "../../pci.h"
> > +#include "../pci-host-common.h"
> >  #include "pcie-designware.h"
> >
> >  static struct pci_ops dw_pcie_ops;
> > @@ -1129,6 +1130,9 @@ int dw_pcie_suspend_noirq(struct dw_pcie *pci)
> >  	u32 val;
> >  	int ret;
> >
> > +	if (!pci_root_ports_have_device(pci->pp.bridge->bus))
> > +		goto stop_link;
> > +
> >  	/*
> >  	 * If L1SS is supported, then do not put the link into L2 as some
> >  	 * devices such as NVMe expect low resume latency.
> > @@ -1162,6 +1166,7 @@ int dw_pcie_suspend_noirq(struct dw_pcie *pci)
> >  	 */
> >  	udelay(1);
> 
> I think move pme_turn_off() to helper funciton will make code look better
> 

What about the L2 entry timeout?

> 	if (pci_root_ports_have_device()) {
> 		ret = dwc_pme_turn_off();
> 		if (ret)
> 			return ret;
> 	};
> 
> 
> >
> > +stop_link:
> >  	dw_pcie_stop_link(pci);
> >  	if (pci->pp.ops->deinit)
> >  		pci->pp.ops->deinit(&pci->pp);
> > @@ -1195,6 +1200,14 @@ int dw_pcie_resume_noirq(struct dw_pcie *pci)
> >  	if (ret)
> >  		return ret;
> >
> > +	/*
> > +	 * If there was no device before suspend, skip waiting for link up as
> > +	 * it is bound to fail. It is very unlikely that a device will get
> > +	 * connected *during* suspend.
> 
> I think it should use certern term. the a device will not get linkup during
> suspend, if this happen, it is a new hotjoin device after system resume.
> 

Sure.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

