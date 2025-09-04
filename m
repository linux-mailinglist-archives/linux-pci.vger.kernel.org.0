Return-Path: <linux-pci+bounces-35440-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A09DAB436BA
	for <lists+linux-pci@lfdr.de>; Thu,  4 Sep 2025 11:13:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1573D1BC475D
	for <lists+linux-pci@lfdr.de>; Thu,  4 Sep 2025 09:13:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01AFE2E11C9;
	Thu,  4 Sep 2025 09:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="D9rxwAfY"
X-Original-To: linux-pci@vger.kernel.org
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C821D2DFA5C;
	Thu,  4 Sep 2025 09:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756977191; cv=none; b=PtdEwkbCNr9YA/R07nSd0/ee73tiaxZndSCSCLGYIU0E875CgHYc1GfTwrJ13HGotTGEZ9Zqp9OMTUoxZV2ornhxfSqf0W5pQFk1D5BzOlugex01ZKly6u0uQNiK3y1AC+2sJ/RGD381JBxQkVcicoyVwGRkDwGFPf5/NF/mplM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756977191; c=relaxed/simple;
	bh=ajRMAuu+hpz6WMa0YxOA/IekyX/4DAV89P21uWHYgcY=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gHUEm0eacwAElDNSi7daAKJ3eFZ5z0Et4HgPEj6BXEU901Qhkf8Sf9jWqNtx5PcgRaZZv+kqpN6ACV1M10V2FgPP7FzsjLFhgRM9eeVxy4nkfx7jBAtuZxxZld/XCgD0aqTdLXI3LY48NvSmfa0GncQlT9eSHeOPxMXnJRRb44E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=D9rxwAfY; arc=none smtp.client-ip=198.47.23.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh01.itg.ti.com ([10.180.77.71])
	by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTP id 5849Cl9c3476356;
	Thu, 4 Sep 2025 04:12:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1756977167;
	bh=6cfOekzhoclFCm+LWn+5CpA0OPOwnIdUmFfLhBpoTmE=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=D9rxwAfYltIFcAjtwe3bCFvCgZ08dx1fMKFRi0gaqhHkw3fM8rXENUuxsFRPU72SZ
	 dNOUlIPIwIuvWOUuJfaGzNYv2H/9hKPHLxjJM86KROHOAanxXkFPqzIU648hxMkpa9
	 9pXujYPsqyB+tebuOepQbiHsPKgrQZb2owLu4u1g=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
	by lelvem-sh01.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 5849ClU93707400
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Thu, 4 Sep 2025 04:12:47 -0500
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Thu, 4
 Sep 2025 04:12:47 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Thu, 4 Sep 2025 04:12:47 -0500
Received: from localhost (uda0492258.dhcp.ti.com [172.24.231.84])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5849CjkL3027798;
	Thu, 4 Sep 2025 04:12:46 -0500
Date: Thu, 4 Sep 2025 14:42:45 +0530
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: Jiri Slaby <jirislaby@kernel.org>
CC: Siddharth Vadapalli <s-vadapalli@ti.com>, <lpieralisi@kernel.org>,
        <kwilczynski@kernel.org>, <mani@kernel.org>, <robh@kernel.org>,
        <bhelgaas@google.com>, <jingoohan1@gmail.com>, <fan.ni@samsung.com>,
        <quic_wenbyao@quicinc.com>, <namcao@linutronix.de>,
        <mayank.rana@oss.qualcomm.com>, <thippeswamy.havalige@amd.com>,
        <quic_schintav@quicinc.com>, <shradha.t@samsung.com>,
        <inochiama@gmail.com>, <cassel@kernel.org>, <kishon@kernel.org>,
        <18255117159@163.com>, <rongqianfeng@vivo.com>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <srk@ti.com>
Subject: Re: [PATCH 09/11] PCI: keystone: Switch to devm_request_irq() for
 "ks-pcie-error-irq" IRQ
Message-ID: <249d79be-deed-4277-96c3-845bafcec37a@ti.com>
References: <20250903124505.365913-1-s-vadapalli@ti.com>
 <20250903124505.365913-10-s-vadapalli@ti.com>
 <3d3a4b52-e343-42f3-9d69-94c259812143@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <3d3a4b52-e343-42f3-9d69-94c259812143@kernel.org>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

On Thu, Sep 04, 2025 at 09:24:01AM +0200, Jiri Slaby wrote:
> On 03. 09. 25, 14:44, Siddharth Vadapalli wrote:
> > In preparation for enabling loadable module support for the driver,
> > there is motivation to switch to devm_request_irq() to simplify the
> > cleanup on driver removal. Additionally, since the interrupt handler
> > associated with the "ks-pcie-error-irq" namely "ks_pcie_handle_error_irq()
> > is only printing the error and is clearing the interrupt, there is no
> > necessity to prefer devm_request_threaded_irq() over devm_request_irq().
> > Hence, switch from request_irq() to devm_request_irq().
> > 
> > Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
> > ---
> >   drivers/pci/controller/dwc/pci-keystone.c | 4 ++--
> >   1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/pci/controller/dwc/pci-keystone.c b/drivers/pci/controller/dwc/pci-keystone.c
> > index bb93559f6468..02f9a6d0e4a8 100644
> > --- a/drivers/pci/controller/dwc/pci-keystone.c
> > +++ b/drivers/pci/controller/dwc/pci-keystone.c
> > @@ -1277,8 +1277,8 @@ static int ks_pcie_probe(struct platform_device *pdev)
> >   	if (irq < 0)
> >   		return irq;
> > -	ret = request_irq(irq, ks_pcie_err_irq_handler, IRQF_SHARED,
> > -			  "ks-pcie-error-irq", ks_pcie);
> > +	ret = devm_request_irq(dev, irq, ks_pcie_err_irq_handler, IRQF_SHARED,
> > +			       "ks-pcie-error-irq", ks_pcie);
> >   	if (ret < 0) {
> >   		dev_err(dev, "failed to request error IRQ %d\n",
> >   			irq);
> 
> Ugh, so you are not removing any free_irq() from anywhere?
> 
> <me checking>
> 
> Because there is none...
> 
> So you are actually fixing an IRQ leak in case something later fails -- I
> guess this needs Fixes and Cc stable tags, right?

Yes! While working on this series and unloading the module, I had seen
the issue and narrowed it down to the absence of a free_irq() in the
driver's .remove callback. Since the driver cannot be unloaded prior to
this series (driver can only be built-in), I had felt that a separate
fix may not be required for adding the missing free_irq() in the .remove
callback. However, after you pointed it out now, I realize that there
are other places during the driver's probe where we may exit in the
event of an error, without freeing the interrupt. Thank you for noticing
this. The commit to be fixed is:
0790eb175ee0 PCI: keystone: Cleanup error_irq configuration
Link to the commit is:
https://github.com/torvalds/linux/commit/0790eb175ee0
I will include the Fixes tag for the above commit and also Cc stable when
I post the v2 series. I will wait for feedback on the remaining patches
in the series before posting the v2 series.

Regards,
Siddharth.

