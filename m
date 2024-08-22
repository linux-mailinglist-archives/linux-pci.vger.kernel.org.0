Return-Path: <linux-pci+bounces-12032-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BDF595BD53
	for <lists+linux-pci@lfdr.de>; Thu, 22 Aug 2024 19:31:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34EDA287F57
	for <lists+linux-pci@lfdr.de>; Thu, 22 Aug 2024 17:31:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B50CC1CEAD4;
	Thu, 22 Aug 2024 17:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VY0RjK3p"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 888121D12E4;
	Thu, 22 Aug 2024 17:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724347896; cv=none; b=PZem3yVs54YDUMXozfYZ3Qd7IVIDVFnni+pDCQuyl0J7oeGEDbHTA13ALg+Y85xNLnZOEGK2Q7q1MEOCba7aESfOkIEcbALQzdMv3+xKoClH3vQrj4vPqsv1m/uX9HQBLsLTfFYOF/oThRM2BkD95l4FSCNoF7woxRRlI7IPpbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724347896; c=relaxed/simple;
	bh=+ErfjZ5uE2QjG3DbjCEAl7HlVAjqKO+KHb2nztO5G+I=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=K0BwmoMkXiq7BVBiCNo+TAR3MYz/qkShm/27QkosG/UZnLq+u0ESEjETDNNyWdwP7OEXC1Lsfan5ouZ3q1M4INVWykQ9fCC9DA1rVqkhg4+r8fBRGm5W6rkXcgOvr+IVI++Cf/vTlr0ZBuwg2wK6CLyImJtRm9mM/eAqfeA97h8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VY0RjK3p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6CD3C4AF0F;
	Thu, 22 Aug 2024 17:31:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724347896;
	bh=+ErfjZ5uE2QjG3DbjCEAl7HlVAjqKO+KHb2nztO5G+I=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=VY0RjK3pG8GUCrKZkcbrgSsSfF5Wof6KfWs1lhRagvFQ9Ad+m10dL87+j5mO9yvP0
	 QDtKok8c5tdpB3vhkJO99uMdYhJssyWs35CvBO6NowMe5FYyd7r0+bpDiMXr2ToeVr
	 sPNB0gueIMXpp5/tjTsr5tqqW7MRgVfNHvFHzq2uJ29nRwcbdvdoNoJop1ECHI9HWw
	 3lfMfzvr3hN3ppwpfS/NkBik6m88ZeNaQMbXNRhbiS2gPXX4fcqB9OSpU77lEEMjTE
	 XzEQ5Za31X+K5SDTfISwwpwSMPGQw2qv26D8T6bC/Krw1fkpVqiP8wVOgB9ern33im
	 ymNfz3UjxteHA==
Date: Thu, 22 Aug 2024 12:31:33 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	lpieralisi@kernel.org, robh@kernel.org, bhelgaas@google.com,
	linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: qcom-ep: Do not enable resources during probe()
Message-ID: <20240822173133.GA312907@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240822154025.vfl6mippkz3duimg@thinkpad>

On Thu, Aug 22, 2024 at 09:10:25PM +0530, Manivannan Sadhasivam wrote:
> On Thu, Aug 22, 2024 at 10:16:58AM -0500, Bjorn Helgaas wrote:
> > On Thu, Aug 22, 2024 at 12:18:23PM +0530, Manivannan Sadhasivam wrote:
> > > On Wed, Aug 21, 2024 at 05:56:18PM -0500, Bjorn Helgaas wrote:
> > > ...
> > 
> > > > Although I do have the question of what happens if the RC deasserts
> > > > PERST# before qcom-ep is loaded.  We probably don't execute
> > > > qcom_pcie_perst_deassert() in that case, so how does the init happen?
> > > 
> > > PERST# is a level trigger signal. So even if the host has asserted
> > > it before EP booted, the level will stay low and ep will detect it
> > > while booting.
> > 
> > The PERST# signal itself is definitely level oriented.
> > 
> > I'm still skeptical about the *interrupt* from the PCIe controller
> > being level-triggered, as I mentioned here:
> > https://lore.kernel.org/r/20240815224735.GA57931@bhelgaas
> 
> Sorry, that comment got buried into my inbox. So didn't get a chance
> to respond.
> 
> > tegra194 is also dwc-based and has a similar PERST# interrupt but
> > it's edge-triggered (tegra_pcie_ep_pex_rst_irq()), which I think
> > is a cleaner implementation.  Then you don't have to remember the
> > current state, switch between high and low trigger, worry about
> > races and missing a pulse, etc.
> 
> I did try to mimic what tegra194 did when I wrote the qcom-ep
> driver, but it didn't work. If we use the level triggered interrupt
> as edge, the interrupt will be missed if we do not listen at the
> right time (when PERST# goes from high to low and vice versa).
> 
> I don't know how tegra194 interrupt controller is wired up, but IIUC
> they will need to boot the endpoint first and then host to catch the
> PERST# interrupt.  Otherwise, the endpoint will never see the
> interrupt until host toggles it again.

Having to control the boot ordering of endpoint and host is definitely
problematic.

What is the nature of the crash when we try to enable the PHY when
Refclk is not available?  The endpoint has no control over when the
host asserts/deasserts PERST#.  If PERST# happens to be asserted while
the endpoint is enabling the PHY, and this causes some kind of crash
that the endpoint driver can't easily recover from, that's a serious
robustness problem.

> But there is no point in forcing this ordering and that was the
> reason why I went with the level triggered approach.

