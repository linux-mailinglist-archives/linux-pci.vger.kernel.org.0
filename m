Return-Path: <linux-pci+bounces-41144-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E27F2C595D5
	for <lists+linux-pci@lfdr.de>; Thu, 13 Nov 2025 19:06:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9DE1F4EBA80
	for <lists+linux-pci@lfdr.de>; Thu, 13 Nov 2025 17:16:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C027364EAA;
	Thu, 13 Nov 2025 17:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TnNMsgNf"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 303E029BD89;
	Thu, 13 Nov 2025 17:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763053298; cv=none; b=svUX1gQ8irHSTsGKCyQteT7FtrSVQYZfhJheiCkOGFYUdAKD0dPgwKcMr9gXGtKK3Y2OXMFksFwrAZ6eOOA+Vg/g6uBvI5eyQ5RqjhZS0l/+shojpqH+iqtlzV1Ktbf9xtoJYm/0lyCa3PdlcCsqtpizmpoIv2wyoI2yEPnQBBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763053298; c=relaxed/simple;
	bh=5Pf3iqIjYL2e0a3xSKvX0pYCMh3YUQRYnW5d5U0xOH0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=erg/AeFbL1FFV+hGg9FyqUkhNH6KqdyyLVsWX8fbG8WbYFJgCoy2BAfjVu9G2IX43rrJyUWIjD/JBZ5Ddes34DKYomAhAeqL7rTJYLgeuVZoo5pP28B78IE/6CmfRuj70AUJp0JfKjCvvIdPW3fQyTNUz3qUoCUFD2eSTlSIJKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TnNMsgNf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17744C2BC86;
	Thu, 13 Nov 2025 17:01:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763053297;
	bh=5Pf3iqIjYL2e0a3xSKvX0pYCMh3YUQRYnW5d5U0xOH0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TnNMsgNfSNl2UF/eY2MehsNe0e1DkUYDOSOj3qpFLDqN3Vnahe4U/KHjZqld+Ecyj
	 lG2MMwumEGcTUQUHfbdx0yJJAJQso0Pw18QyQ9vdqJbkqA1nU+UP9vMHLWWkILIbRV
	 4wG2OZCiMP+uFUrLhAee6O+L4nqjOEbfk5O5iin1B/KTXtbc5fFKe9Z1xG1lDc1ONN
	 +gqbfNdN9kuCT19sI2SoUj0A9qbdwTYWJfrLzllzZxSE1735VHLVF4k1vcZ0qj+wZq
	 uKzkIIbHVw9Fk2E/xbMfPPDWnWqQXaOh+K2cNx+Mg3pyRcqhUjCenSO/ml+9feQZA8
	 foBQ9MKORSVyA==
Date: Thu, 13 Nov 2025 22:31:27 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>, 
	lpieralisi@kernel.org, kwilczynski@kernel.org, bhelgaas@google.com, will@kernel.org, 
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, robh@kernel.org, 
	linux-arm-msm@vger.kernel.org, zhangsenchuan@eswincomputing.com, vincent.guittot@linaro.org, 
	Frank Li <Frank.li@nxp.com>
Subject: Re: [PATCH v2 3/3] PCI: dwc: Check for the device presence during
 suspend and resume
Message-ID: <6uidenlpio4lsn7cecdubxlojo4slm6g76zteu74jg7xqhnv2y@kmsnhuh3dqiz>
References: <20251107044319.8356-4-manivannan.sadhasivam@oss.qualcomm.com>
 <20251113164013.GA2285612@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251113164013.GA2285612@bhelgaas>

On Thu, Nov 13, 2025 at 10:40:13AM -0600, Bjorn Helgaas wrote:
> [+cc Frank]
> 
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
> 
> This looks racy.  Maybe it's still OK, but I think it would be good to
> include a comment to acknowledge that and explain why either outcome
> is acceptable, e.g., if a user removes a device during suspend, it
> results in a timeout but nothing more terrible.
> 

Ok.

> >  	/*
> >  	 * If L1SS is supported, then do not put the link into L2 as some
> >  	 * devices such as NVMe expect low resume latency.
> > @@ -1162,6 +1166,7 @@ int dw_pcie_suspend_noirq(struct dw_pcie *pci)
> >  	 */
> >  	udelay(1);
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
> I'm not convinced.  Unlike the suspend side, where the race window is
> tiny, here the window is the entire time the system is suspended, and
> at least in laptop usage, there's no reason I would hesitate to plug
> something in while suspended.
> 

In that case, we just need to do:

	/* Ignore errors as there could be no devices connected */
	dw_pcie_wait_for_link()

I wanted to avoid the timeout if we knew that there was no device connected
during suspend.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

