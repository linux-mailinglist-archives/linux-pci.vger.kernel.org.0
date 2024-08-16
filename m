Return-Path: <linux-pci+bounces-11759-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B5E0E954872
	for <lists+linux-pci@lfdr.de>; Fri, 16 Aug 2024 14:02:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2A888B2126D
	for <lists+linux-pci@lfdr.de>; Fri, 16 Aug 2024 12:02:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56A2B156F44;
	Fri, 16 Aug 2024 12:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P2RSKImg"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C235156C62;
	Fri, 16 Aug 2024 12:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723809737; cv=none; b=SUiCf26YyCS0gx+VclLdsHd9N6mXiys8/bQm6fPvXUqOYg7Np2gEWo7tqOi1hcKmYVki0z3Pe97NGjg66Pv9ChsWIpRDiQ6XDtcHgZExmEyoTXx0PweHb1HLOt74JrfUTMTurqxG5E+Ti0DJ/6vcGmRN+I87zQjEaTE97u4teS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723809737; c=relaxed/simple;
	bh=NAmwEWrgEf+Xp0/OzBzRsBFn/oVvGfylhZy2WMC9EQ4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=nxRgFpD4HQkg86qa7hOYsnukq/ig4LYMMwFzdhC6oZxpPkeOdNdYpmvTmnYKcvrJUZfOUsbG21XFf3/6VflqC3LGnvYt6Q46dKXvH7SGOkCiWJSU7/bKj+siLaijUThBglKvKqc0FTkCw6i3uMFIc/cJK9fRmXDwyFN2W1QTzCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P2RSKImg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98B79C32782;
	Fri, 16 Aug 2024 12:02:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723809736;
	bh=NAmwEWrgEf+Xp0/OzBzRsBFn/oVvGfylhZy2WMC9EQ4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=P2RSKImg22nJX7hkwvDhXT7+YEwoUOIAeY9XxL1yg0atED+iYid176F7wK2trLE55
	 KcxP5X1g99/tgPUO/T+Dr2SloE2Q5RxiY4yX7l8U+6Q/975KOppck+xXN10q7rBgbI
	 xU5M7Eivqe42ATTqfzhdCrzbEsk1rpAoq3FrSH1TK+qvW5P5h8RqJ/yR0rjeP77us0
	 cnJ5iU7QICiQkFxQnSftt/jFcrPsEaWDBARXX8BBMcBkiZJRnxSbHUbH97WZdoBJQV
	 jtRhZG/tXxm50JUoVZHS8RzlYG+YRuW7SAvp8zLLNBc9SboEbCREaIeq6R0kJglJqy
	 RyGIsIAQ/LxEg==
Date: Fri, 16 Aug 2024 07:02:14 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: lpieralisi@kernel.org, kw@linux.com, robh@kernel.org,
	bhelgaas@google.com, linux-arm-msm@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: qcom-ep: Do not enable resources during probe()
Message-ID: <20240816120214.GA65249@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240816053757.GF2331@thinkpad>

On Fri, Aug 16, 2024 at 11:07:57AM +0530, Manivannan Sadhasivam wrote:
> On Thu, Aug 15, 2024 at 01:15:57PM -0500, Bjorn Helgaas wrote:
> > On Sat, Jul 27, 2024 at 02:36:04PM +0530, Manivannan Sadhasivam wrote:
> > > Starting from commit 869bc5253406 ("PCI: dwc: ep: Fix DBI access failure
> > > for drivers requiring refclk from host"), all the hardware register access
> > > (like DBI) were moved to dw_pcie_ep_init_registers() which gets called only
> > > in qcom_pcie_perst_deassert() i.e., only after the endpoint received refclk
> > > from host.
> > > 
> > > So there is no need to enable the endpoint resources (like clk, regulators,
> > > PHY) during probe(). Hence, remove the call to qcom_pcie_enable_resources()
> > > helper from probe(). This was added earlier because dw_pcie_ep_init() was
> > > doing DBI access, which is not done now.
> > > 
> > > While at it, let's also call dw_pcie_ep_deinit() in err path to deinit the
> > > EP controller in the case of failure.
> > 
> > Is this v6.11 material?  If so, we need a little more justification
> > than "no need to enable".
> 
> That's why I asked to merge the comment from Dmitry:
> 
> "...moreover his makes PCIe EP fail on some of the platforms as powering on PHY
> requires refclk from the RC side, which is not enabled at the probe time."

The patch was posted and described basically as a cleanup of something
that was unnecessary but not harmful, which is not post-merge window
material.

If it is in fact a critical fix, that needs to be the central point of
the commit log, not something tacked on with "moreover" or
"additionally".  And we need something like a Fixes: tag so we know
when the problem was introduced and where to backport this.

Bjorn

