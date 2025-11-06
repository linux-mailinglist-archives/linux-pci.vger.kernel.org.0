Return-Path: <linux-pci+bounces-40499-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A6DE0C3ADAA
	for <lists+linux-pci@lfdr.de>; Thu, 06 Nov 2025 13:19:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 77EFB502C56
	for <lists+linux-pci@lfdr.de>; Thu,  6 Nov 2025 12:13:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30697328B69;
	Thu,  6 Nov 2025 12:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fjaKjb41"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0523D32863F;
	Thu,  6 Nov 2025 12:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762430972; cv=none; b=LcZWLw6A3sveHgcPoV+uaoxYy92JVK8OA6o671ZVQE3QffAM/OXl5ajK0ZlTutsPqHxuv4nWWcZij3p4ORTgMQKru2sop9p2N+fTZc4PqwdIftfRUphn4UBPqxFA8YtrkJceJDWq7EHCP0J2Rr0NbUDnInU4d3wnRggryeSYuQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762430972; c=relaxed/simple;
	bh=6UnFr4hh3EtUTMnSIA/kP+rQ8k3iR84NhofiJ1UKTGQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g57ZeFNqglb8XZj9ANmypY+ApIQajKMpY779FHeIPcJwR+FX9ELtZJr28MxRUcrYZzG/X8t46qdOQxPcl/6WM/o678mFljzEh92lfrZfwv0ripEM8LE4511ajgHQ2NkdYdF8bmJBuVKVVOvoL9CR/SN8b2u1xHSmFdma6YdMqhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fjaKjb41; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 121CDC4CEFB;
	Thu,  6 Nov 2025 12:09:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762430971;
	bh=6UnFr4hh3EtUTMnSIA/kP+rQ8k3iR84NhofiJ1UKTGQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fjaKjb41Z2nWugw5iBQYIn5zwzqrBcuQPaR0phuDHReDKXvf0c5h6pZwplIJFb92O
	 JdNJB4DaKyzYCiQgG1iUaJpu7Qh3gntqNw/1IccGtmH43iX97AQoAx0Izem/w25stI
	 XQkIsGynApZ1bv+GG3zMzkVaLcMNE0UJ1n7B6oMMWc6hF48CvS9K6Ay0LUCxJ2hjDq
	 wEq/kDBR12RQ2xlo3XEeE36buP26KzFSEWJKeb4TR5DQHRhDuevLW9gy5U0qAzPE5q
	 LdW1+I53RbF8Z22pCSmYKZFAW5JZbzEqapzOUQZCoEr0d8TJAndZyMh81A+9cM9/Is
	 wfKMzPMEbG8Fg==
Date: Thu, 6 Nov 2025 17:39:21 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: zhangsenchuan <zhangsenchuan@eswincomputing.com>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>, 
	lpieralisi@kernel.org, kwilczynski@kernel.org, bhelgaas@google.com, will@kernel.org, 
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, robh@kernel.org, 
	linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 3/3] PCI: dwc: Skip PME_Turn_Off and L2/L3 transition if
 no device is available
Message-ID: <mznt4mfn7z2l5bctdnuul3murx4ykibd2n4dgtavowb3xmhluk@kqxn3uexz7l5>
References: <20251106061326.8241-1-manivannan.sadhasivam@oss.qualcomm.com>
 <20251106061326.8241-4-manivannan.sadhasivam@oss.qualcomm.com>
 <3d960043.c46.19a589e8637.Coremail.zhangsenchuan@eswincomputing.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3d960043.c46.19a589e8637.Coremail.zhangsenchuan@eswincomputing.com>

On Thu, Nov 06, 2025 at 06:02:55PM +0800, zhangsenchuan wrote:
> 
> 
> 
> > -----Original Messages-----
> > From: "Manivannan Sadhasivam" <manivannan.sadhasivam@oss.qualcomm.com>
> > Send time:Thursday, 06/11/2025 14:13:26
> > To: lpieralisi@kernel.org, kwilczynski@kernel.org, mani@kernel.org, bhelgaas@google.com
> > Cc: will@kernel.org, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, robh@kernel.org, linux-arm-msm@vger.kernel.org, zhangsenchuan@eswincomputing.com, "Manivannan Sadhasivam" <manivannan.sadhasivam@oss.qualcomm.com>
> > Subject: [PATCH 3/3] PCI: dwc: Skip PME_Turn_Off and L2/L3 transition if no device is available
> > 
> > If there is no device available under the Root Ports, there is no point in
> > sending PME_Turn_Off and waiting for L2/L3 transition, it will result in a
> > timeout.
> > 
> > Hence, skip those steps if no device is available during suspend. The
> > resume flow remains unchanged.
> > 
> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> > ---
> >  drivers/pci/controller/dwc/pcie-designware-host.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> > 
> > diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> > index 20c9333bcb1c..b6b8139e91e3 100644
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
> >  
> > +stop_link:
> >  	dw_pcie_stop_link(pci);
> >  	if (pci->pp.ops->deinit)
> >  		pci->pp.ops->deinit(&pci->pp);
> > -- 
> > 2.48.1
> 
> hi, Manivannan
> 
> I'd like your advice on a few things.
> 
> If there is no device available under the Root Ports, the dw_pcie_wait_for_link
> function in dw_pcie_resume_noirq still need to wait for the link_up? Otherwise
> linkup will TIMEDOUT. At this time, when the resume function return, -ETIMEDOUT 
> returned which will raise "PM: failed to resume noirq: error -110".
> 

I thought about it, but was worried that if there was no device inserted before
suspend, but if one gets inserted during suspend (before resume), then the link
up failure will get un-noticed if the link doesn't come up for the new device
and we skip the timeout.

But thinking more, it occurs to me that it will be a very rare case. So I'll
skip returning timeout from dw_pcie_wait_for_link() if there were no devices
before suspend. However, I do think that the dw_pcie_wait_for_link() should not
be skipped even if there were no devices earlier.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

