Return-Path: <linux-pci+bounces-14503-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 670EE99D625
	for <lists+linux-pci@lfdr.de>; Mon, 14 Oct 2024 20:08:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E051A1F25E8A
	for <lists+linux-pci@lfdr.de>; Mon, 14 Oct 2024 18:08:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78CDA1C7B77;
	Mon, 14 Oct 2024 18:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EKLdoYvB"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 515951C7617;
	Mon, 14 Oct 2024 18:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728929324; cv=none; b=VdvdLP/xCagBNyPVlStZyhQO4Yx88JDgrfc/Yf3qw2GJd6zdqhKe8LzeZQfNRNcDe/GRDY1ddW4smTaM+uqJMX2h38C1He3CIAPkO5001vPyTKWIY63Gpfdb4oomWoWXONIp/J69bEVWFExfAsdtpi0eOmFcMl5wb1r/jclMuko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728929324; c=relaxed/simple;
	bh=ukToEOBdztdbDqRT5/hmmyOQ+APOBBzbWQpb5VB9xfE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=qtslLjxOr7V3BDYWFq8zlLMlMObdr/SzCHXxO6bhYD+uYNgfPJySZjYNlG6nFyQmch7MrmwKnXwxOmAst1/vgyIbYbQ1BSO1avG9dIfGxC7HOd7LbDDFNoqswAbnc84mx5FoiDguOr9dRuxqHaXE6VXVamXtFjr43rHy3iklsos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EKLdoYvB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA585C4CEC3;
	Mon, 14 Oct 2024 18:08:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728929324;
	bh=ukToEOBdztdbDqRT5/hmmyOQ+APOBBzbWQpb5VB9xfE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=EKLdoYvBaRjZ9DdOlSvlPbIpz7DQOaaFth5l4Ii5pilHR9ckRwCLZtip/4GyQW1P4
	 j5IMA1BH5v/5Y99q1PIFlLLtla3as1wfx0KMG2CUd04sXs1QbZx7MdW0deck65YAtz
	 a6mlEd5B1NUHF7Y1eawUSGH0eXKq11a3u80B9XaRUbcE2RQfLg9RI0rE52lkc790Vs
	 PTg7WSFGyW5EFAinrK8xKpluk3UYp0Tt2OaUvPzv668e3UVnJW6W/h57SsIAI7gwP+
	 SqZoYpJVGEfKK82bgHqjTfEP9BSDhAyHSbVWd2nInTO+1q7q5m7oke3s6xFRuwxp9U
	 FPsGunrk7ye6w==
Date: Mon, 14 Oct 2024 13:08:41 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Mayank Rana <quic_mrana@quicinc.com>, kevin.xie@starfivetech.com,
	lpieralisi@kernel.org, kw@linux.com, robh@kernel.org,
	bhelgaas@google.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, quic_krichai@quicinc.com,
	Marek Szyprowski <m.szyprowski@samsung.com>
Subject: Re: [PATCH v3] PCI: starfive: Enable PCIe controller's runtime PM
 before probing host bridge
Message-ID: <20241014180841.GA613986@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241014174817.i4yrjozmfbdrm3md@thinkpad>

On Mon, Oct 14, 2024 at 11:18:17PM +0530, Manivannan Sadhasivam wrote:
> On Mon, Oct 14, 2024 at 12:23:21PM -0500, Bjorn Helgaas wrote:
> > On Mon, Oct 14, 2024 at 09:26:07AM -0700, Mayank Rana wrote:
> > > PCIe controller device (i.e. PCIe starfive device) is parent to PCIe host
> > > bridge device. To enable runtime PM of PCIe host bridge device (child
> > > device), it is must to enable parent device's runtime PM to avoid seeing
> > > the below warning from PM core:
> > > 
> > > pcie-starfive 940000000.pcie: Enabling runtime PM for inactive device
> > > with active children
> > > 
> > > Fix this issue by enabling starfive pcie controller device's runtime PM
> > > before calling pci_host_probe() in plda_pcie_host_init().
> > > 
> > > Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
> > > Signed-off-by: Mayank Rana <quic_mrana@quicinc.com>
> > > Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > 
> > I want this in the same series as Krishna's patch to turn on runtime
> > PM of host bridges.  That's how I know they need to be applied in
> > order.  If they're not in the same series, they're likely to be
> > applied out of order.
> 
> There is no harm in applying this patch on its own. It fixes a legit
> issue of enabling the parent runtime PM before the child as required
> by the PM core. Rest of the controller drivers follow the same
> pattern.
> 
> I fail to understand why you want this to be combined with Krishna's
> patch. That patch is only a trigger, but even without that patch the
> issue still exists (not user visible ofc).

I don't want it *combined* with Krishna's patch.

I want this applied *before* Krishna's patch because if we apply
Krishna's patch first, we have some interval where we report the
"Enabling runtime PM for inactive device with active children" error.

Bjorn

