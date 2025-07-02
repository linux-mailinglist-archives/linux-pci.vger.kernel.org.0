Return-Path: <linux-pci+bounces-31276-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8E1EAF5B8B
	for <lists+linux-pci@lfdr.de>; Wed,  2 Jul 2025 16:48:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 048317ADDFF
	for <lists+linux-pci@lfdr.de>; Wed,  2 Jul 2025 14:46:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 279933093CC;
	Wed,  2 Jul 2025 14:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X7haf1sk"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03997309DBB
	for <linux-pci@vger.kernel.org>; Wed,  2 Jul 2025 14:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751467679; cv=none; b=TH0oTeNsuiyg1KCcYyrFZLHYUWquffVNnKAewA/M8m7iW0LZBWje0rBKEiLIFyuTQ0dqHoGSKJT+G+UAtd5zZ8O2ccdyaY9KFJV9ISaRdM6dzK2awmnQwRS1DfPadOy/g3CkmdZ3Tcv4wraDX96xJ01gG0AAQ6RkawTg6YLIBCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751467679; c=relaxed/simple;
	bh=CCm9UWZv/glzj2xIYJyWdi1A8Ak0wnE2/FWyOI6c2zQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E3/B4W0t9TSob2pH9yba6W8nMzs4s0FtL9EkSUApFuSy9kGtG3GwdOKZKEh1+1+1httyNfo3eiZc4cc0ZW1Fy0+D/RjNEDT1lwT20598WR76qU9s3li8KvN2UGsAU9WV/idyPLg6MYMxEevT1DlF86VEIj4YRP+y1xxaYNYtpMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X7haf1sk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3EA5C4CEE7;
	Wed,  2 Jul 2025 14:47:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751467678;
	bh=CCm9UWZv/glzj2xIYJyWdi1A8Ak0wnE2/FWyOI6c2zQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=X7haf1skKuchqSLadlci9KIqQ7o/XZ915bfaO6gRt1z0jN8qf84bXwGZlw1F1oWwa
	 PvbEMqawxFMyR23tvkOgC3436hB9kVOikRS3w0sAftmTeo4QGdPwXLfkfdwNgclJWj
	 Br1A8m7p0NlXLvXMx1T//yJgocdMrORNl/L2YCxsvuXDvwU0XISuIJlf0MkFvD0HpR
	 SENWu1fmvqePUGMlmpv/aqx+U0qSwBhwMc4RbKEvFmqrTxbcBtlR0SZdFYw4CLrBz6
	 RODmnfYRIEdxM6EQ8s9nVL4gFVCgfdOx8mDNlGCcxQ19VFD48n02khy687MmyQxNLp
	 o7m1mOdavEjtg==
Date: Wed, 2 Jul 2025 20:17:44 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Niklas Cassel <cassel@kernel.org>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Jingoo Han <jingoohan1@gmail.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Wilfred Mallawa <wilfred.mallawa@wdc.com>, Damien Le Moal <dlemoal@kernel.org>, 
	Laszlo Fiat <laszlo.fiat@proton.me>, linux-pci@vger.kernel.org
Subject: Re: [PATCH v4 5/7] PCI: dwc: Ensure that dw_pcie_wait_for_link()
 waits 100 ms after link up
Message-ID: <hhyxhxvohmeqzjdu3amabcpf3e4ufi4ps5xd2uia4ea6i2u5oj@sxyjavqyqc7m>
References: <hcjcvo4sokncindwqhhmsx5g25ovj5n5zghemeujw7f4kqiaia@hbefzblsrhqx>
 <20250701163844.GA1836602@bhelgaas>
 <aGT_L_hglVBP6yzB@ryzen>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aGT_L_hglVBP6yzB@ryzen>

On Wed, Jul 02, 2025 at 11:43:11AM GMT, Niklas Cassel wrote:
> On Tue, Jul 01, 2025 at 11:38:44AM -0500, Bjorn Helgaas wrote:
> > > 
> > > No. The PERST# delay should be handled by the glue drivers since
> > > they are the ones controlling the PERST# line. Doing an
> > > unconditional wait for both the cases in DWC core, seems wrong to
> > > me.
> > 
> > It ends up being a little bit weird that the delay is in the DWC core
> > (dw_pcie_wait_for_link()) for ports that support fast links, and in
> > the glue drivers otherwise.  It would be easier to verify and maintain
> > if the delay were always in the DWC core.
> > 
> > If we had a dw_pcie_host_ops callback for PERST# deassertion, the
> > delay could be in the DWC core, but I don't know if there's enough
> > consistency across drivers for that to be practical.
> 
> Currently, there is not much consistency between the glue drivers, so
> adding a DWC core API to assert/deassert PERST# sounds like a good idea
> to me. The callback could even be supplied a struct gpio_desc pointer.
> 

+1 for consolidating the PERST# handling. But just FYI, I'm going to move the
PERST# deassert handling from controller drivers to pwrctrl drivers as once
pwrctrl drivers are used to control the power supplies, they should control
PERST# as well. Currently, this is the missing piece for pwrctrl framework.

Also, we cannot entirely get rid of the PERST# handling in controller drivers,
since they need to assert PERST# before resetting the RC during init.

> Like I mentioned in my previous email:
> https://github.com/torvalds/linux/blob/v6.16-rc4/drivers/pci/controller/dwc/pci-imx6.c#L885
> https://github.com/torvalds/linux/blob/v6.16-rc4/drivers/pci/controller/dwc/pcie-qcom.c#L294
> https://github.com/torvalds/linux/blob/v6.16-rc4/drivers/pci/controller/dwc/pcie-keembay.c#L89
> 
> these drivers seem to have a 100 ms delay after PERST# has been deasserted,
> but there are of course more glue drivers, so a lot of them will not have a
> 100 ms wait _after_ PERST# is deasserted. (All glue drivers seem to have a
> delay between asserting and deasserting PERST#.)
> 
> Right now, e.g. qcom will have a 100 ms delay both after deasserting PERST#
> and after link up. (However, based on the supported link speed, only one of
> the delays should be needed.)
> 
> However, my main concern is not that qcom waits twice, it is those drivers
> that do not have a 100 ms delay after PERST# has been deasserted, because
> before commit 470f10f18b48 ("PCI: Reduce PCIE_LINK_WAIT_SLEEP_MS"), those
> drivers might have been "saved" by the ridiculously long
> PCIE_LINK_WAIT_SLEEP_MS.
> 
> However, now when we sleep less in each iteration when polling for link up,
> those drivers that do not have a 100 ms delay after PERST# has been
> deasserted might actually see regressions, because (the now reduced)
> PCIE_LINK_WAIT_SLEEP_MS time is no longer "saving" them.
> 

Why can't you just add the delay to those drivers now? They can be consolidated
later.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

