Return-Path: <linux-pci+bounces-14696-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F2D4F9A13BD
	for <lists+linux-pci@lfdr.de>; Wed, 16 Oct 2024 22:24:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3066C1C21D47
	for <lists+linux-pci@lfdr.de>; Wed, 16 Oct 2024 20:24:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FDDA1C4A14;
	Wed, 16 Oct 2024 20:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E6O1YOQN"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 661C621E3C2;
	Wed, 16 Oct 2024 20:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729110282; cv=none; b=Jw65XUMSHfMrU+AEHaW3mxLsmf2Haq4p2n8RI6QnFJz25w6pQBIMA0qbaj7SLptKRZID9aJ/4oEifj+CHqfh2FPWaw9JCoXKnNzNtEJ+xCaNgbBzUXPBANMsCnVd1fJLp+EvciT6h/C+lQvhVYjB5PrZ0HOCKqQOQdOhDfpZUOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729110282; c=relaxed/simple;
	bh=aKejDMrbg3JrgJcCRaZkQcxW33nEC6VauF27lMVLaMU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=n2fuVPIeVsEu2gEo6tiSn3q52dkjTm5CLH7cywQYNmscZr6aIV6VQvJ5RB0oPVzOn0ZI/DNKW4xZtGTUTgB7nmwvl0UMs30gmlKYgv0C0V8ORocpnXY2Unyu7F6XvtcntNDZgU3pkbp8VslKqXtoOUwayiChzcal59f9YVLdWew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E6O1YOQN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1FFBC4CECD;
	Wed, 16 Oct 2024 20:24:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729110282;
	bh=aKejDMrbg3JrgJcCRaZkQcxW33nEC6VauF27lMVLaMU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=E6O1YOQNSQhSn3CcQ9OnX/bFvfAQYDAyt6P37WxLX7MXcoOaNRDxWRWexXEYJZmVm
	 GtQ0z7c05OFhm+28lASj0vnKt03dgqisGhVvIcqapRYDrRWsu86oLy1dbb2cqHNzq9
	 sBYBKfs+mubG8SZcmRZoM8YQ8U6mzugOcCUWuBM8dMLryq/c7A1brT1ykeVF8o2zd0
	 mU/Kv2Z8VTaY9m4dFJxmPWqUE84FwftMMGFYkqwkjaxO6IIQaC0gE4Pl2aEygUVjZA
	 V/Wc3aVYp5UcWG8tAqKMV43kEV0YwMFP+/TNuC1wGgHnQWhUh9P1+mIekScLwar1YD
	 7Cmw86BmfrFLw==
Date: Wed, 16 Oct 2024 15:24:40 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Mayank Rana <quic_mrana@quicinc.com>, kevin.xie@starfivetech.com,
	lpieralisi@kernel.org, kw@linux.com, robh@kernel.org,
	bhelgaas@google.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, quic_krichai@quicinc.com,
	Marek Szyprowski <m.szyprowski@samsung.com>
Subject: Re: [PATCH v3] PCI: starfive: Enable PCIe controller's runtime PM
 before probing host bridge
Message-ID: <20241016202440.GA647226@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241015043901.gys454ykv7lgwtvm@thinkpad>

On Tue, Oct 15, 2024 at 10:09:01AM +0530, Manivannan Sadhasivam wrote:
> On Mon, Oct 14, 2024 at 01:08:41PM -0500, Bjorn Helgaas wrote:
> > On Mon, Oct 14, 2024 at 11:18:17PM +0530, Manivannan Sadhasivam wrote:
> > > On Mon, Oct 14, 2024 at 12:23:21PM -0500, Bjorn Helgaas wrote:
> > > > On Mon, Oct 14, 2024 at 09:26:07AM -0700, Mayank Rana wrote:
> > > > > PCIe controller device (i.e. PCIe starfive device) is parent to PCIe host
> > > > > bridge device. To enable runtime PM of PCIe host bridge device (child
> > > > > device), it is must to enable parent device's runtime PM to avoid seeing
> > > > > the below warning from PM core:
> > > > > 
> > > > > pcie-starfive 940000000.pcie: Enabling runtime PM for inactive device
> > > > > with active children
> > > > > 
> > > > > Fix this issue by enabling starfive pcie controller device's runtime PM
> > > > > before calling pci_host_probe() in plda_pcie_host_init().
> > > > > 
> > > > > Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
> > > > > Signed-off-by: Mayank Rana <quic_mrana@quicinc.com>
> > > > > Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > > > 
> > > > I want this in the same series as Krishna's patch to turn on runtime
> > > > PM of host bridges.  That's how I know they need to be applied in
> > > > order.  If they're not in the same series, they're likely to be
> > > > applied out of order.
> > > 
> > > There is no harm in applying this patch on its own. It fixes a legit
> > > issue of enabling the parent runtime PM before the child as required
> > > by the PM core. Rest of the controller drivers follow the same
> > > pattern.
> > > 
> > > I fail to understand why you want this to be combined with Krishna's
> > > patch. That patch is only a trigger, but even without that patch the
> > > issue still exists (not user visible ofc).
> > 
> > I don't want it *combined* with Krishna's patch.
> > 
> > I want this applied *before* Krishna's patch because if we apply
> > Krishna's patch first, we have some interval where we report the
> > "Enabling runtime PM for inactive device with active children" error.
> 
> No, I was asking why can't this be applied *first* and then
> Kirshna's patch? Why do you want this to be again resent in a
> separate series?

It can certainly be applied first.  It's just that when they're posted
separately, even with a comment in the email discussion to say "please
apply A before B", it's extra work for whoever merges them and it
makes it more likely to make mistakes like applying them in the wrong
order, or one without the other, or putting them on separate branches.

The usual way to say "B depends on A" is to post them together in a
series with A followed by B.

Bjorn

