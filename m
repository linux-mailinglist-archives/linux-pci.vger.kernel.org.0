Return-Path: <linux-pci+bounces-11978-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CA8FF95A7F7
	for <lists+linux-pci@lfdr.de>; Thu, 22 Aug 2024 00:56:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 66C351F23431
	for <lists+linux-pci@lfdr.de>; Wed, 21 Aug 2024 22:56:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98F88170A2A;
	Wed, 21 Aug 2024 22:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eZ1gLvI5"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BE98168497;
	Wed, 21 Aug 2024 22:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724280981; cv=none; b=JNkIYbk1EhdmOzFVv8lv21M8HbQ0GxINrQB1MAkp3YZakY7/fp/qeBxa65AVj5UAgqlCyh3vdv/MK4B4QiGM+ksk0jZfli8z9MPp9uYVK35airs1FzaEP2RMz29qMmb0n0fPnyc99ar1+FcXW2ylCEtGxP+/r9jgN5J4rrIEdq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724280981; c=relaxed/simple;
	bh=QS2Ib4T21p6k4K9gt4wWAlkpn73A3GjnZGc6t988xho=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=q0m2h7iCS3L4UzEC7gVG73O6hA7nB6VP6cYkyCBjTRDotqW90uzUkIU8W69Vhso2RKtPHOdNQNzwmMQzRS1j5Y7vw4jhs1l1tRmZ+DWvjgVynhfhSqKPFMyDmPsFazA7TOYsRiazGseByaj94zVXvvx4ZtEY2IbrZ5xcG2NnyyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eZ1gLvI5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1421C32781;
	Wed, 21 Aug 2024 22:56:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724280981;
	bh=QS2Ib4T21p6k4K9gt4wWAlkpn73A3GjnZGc6t988xho=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=eZ1gLvI5JC54qmUhnGBj8jKiVmWN/YEnnyb3xUIyTUOtOukjBz0zLmf7+R58AahbH
	 ul044o/DW/Z5qWaUkssXvdFJcknqnVCjqwDOfFYsHAhKS37r/8nOFRlz07ekI9E9bN
	 ymx5M0wF42nmRbDBZcg6WUv1tsCwht+sECMOKzYVQugDwAZX//Ky+ry3uJPLUnvbp4
	 +2aI4dmV4xfExhYwBBIkmjiktvB4hfR0l2lNMtSijR2DdR3hlFXPlHYKC2Y9HVYom9
	 doKP9S2aWRZhgdNkg9OwPQ6pSNmVOabs2NKUCzFXk32Qmy3veDZUjJoCZ1OdOZjxei
	 HgQnVAXNymISw==
Date: Wed, 21 Aug 2024 17:56:18 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	lpieralisi@kernel.org, robh@kernel.org, bhelgaas@google.com,
	linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: qcom-ep: Do not enable resources during probe()
Message-ID: <20240821225618.GA270826@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240813202547.GC1922056@rocinante>

On Wed, Aug 14, 2024 at 05:25:47AM +0900, Krzysztof Wilczyński wrote:
> > Starting from commit 869bc5253406 ("PCI: dwc: ep: Fix DBI access failure
> > for drivers requiring refclk from host"), all the hardware register access
> > (like DBI) were moved to dw_pcie_ep_init_registers() which gets called only
> > in qcom_pcie_perst_deassert() i.e., only after the endpoint received refclk
> > from host.
> > 
> > So there is no need to enable the endpoint resources (like clk, regulators,
> > PHY) during probe(). Hence, remove the call to qcom_pcie_enable_resources()
> > helper from probe(). This was added earlier because dw_pcie_ep_init() was
> > doing DBI access, which is not done now.
> > 
> > While at it, let's also call dw_pcie_ep_deinit() in err path to deinit the
> > EP controller in the case of failure.
> 
> Applied to controller/qcom, thank you!
> 
> [1/1] PCI: qcom-ep: Do not enable resources during probe()
>       https://git.kernel.org/pci/pci/c/cd0b3e13ec30

I think we do need this, but I dropped it for now pending a commit log
that says "we're fixing a crash" and explains how.

The current log says "869bc5253406 moved hardware register access like
DBI to dw_pcie_ep_init_registers()", but 869bc5253406 actually moved a
bunch of register accesses from dw_pcie_ep_init() to
dw_pcie_ep_init_complete(), and a subsequent patch renamed
dw_pcie_ep_init_complete() to dw_pcie_ep_init_registers().  I did
eventually figure out the rename, but it took a while to make that
leap.

It also says dw_pcie_ep_init_registers() is called only from
qcom_pcie_perst_deassert(), but obviously all drivers call it.  I
think what you meant is that on qcom and tegra194,
dw_pcie_ep_init_registers() isn't called from .probe(); it's called
later because they require refclk to access the registers, so qcom and
tegra194 call it after PERST# is deasserted, because then refclk is
available.

Trying to understand the 869bc5253406 reference: I guess the
point is that the dw_pcie_ep_init_registers() work depends on
qcom_pcie_enable_resources(), and before 869bc5253406, that work was
done by qcom_pcie_ep_probe() calling dw_pcie_ep_init(), so it had to
call qcom_pcie_enable_resources() first.

But after 869bc5253406, dw_pcie_ep_init_registers() is done in
qcom_pcie_perst_deassert(), which already calls
qcom_pcie_enable_resources().  So qcom_pcie_ep_probe() no longer needs
to call qcom_pcie_enable_resources().

As far as the *crash*, phy_power_on() has been called from
qcom_pcie_ep_probe() since the very beginning in f55fee56a631 ("PCI:
qcom-ep: Add Qualcomm PCIe Endpoint controller driver").  But
apparently on some new platforms phy_power_on() depends on refclk and
(I assume) it causes a crash when done from qcom_pcie_ep_probe().

So I would think the commit log should look something like this:

  PCI: qcom-ep: Postpone PHY power-on until refclk available

  qcom_pcie_enable_resources() is called by qcom_pcie_ep_probe() and
  powers on PHYs.  On new platforms like X, Y, Z, this depends on
  refclk from the RC, which may not be available at the time of
  qcom_pcie_ep_probe(), so this causes a crash in the qcom-ep driver.

  qcom_pcie_enable_resources() is already called by
  qcom_pcie_perst_deassert() when PERST# is deasserted, and refclk is
  available at that time.

  Remove the unnecessary call from qcom_pcie_ep_probe() to prevent the
  crash on X, Y, Z.

Although I do have the question of what happens if the RC deasserts
PERST# before qcom-ep is loaded.  We probably don't execute
qcom_pcie_perst_deassert() in that case, so how does the init happen?

Bjorn

