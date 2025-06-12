Return-Path: <linux-pci+bounces-29558-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DA32AD7644
	for <lists+linux-pci@lfdr.de>; Thu, 12 Jun 2025 17:34:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 44AC618967CB
	for <lists+linux-pci@lfdr.de>; Thu, 12 Jun 2025 15:32:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A3B52D4B71;
	Thu, 12 Jun 2025 15:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YbhRCPOM"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E99902D4B4D
	for <linux-pci@vger.kernel.org>; Thu, 12 Jun 2025 15:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749741885; cv=none; b=En4J16cY1X0nm3PLtW6cn9wfDDfEd03vUwMeq4OQVww0PvOtfj8q9xe3BBNkAgVZQkt6xzxmDA5L3IQ+9s//5zfoIizXDWHXCoxle3q8hQRQt1WDAcqjCfgpGQdAXTDgkCIwq2VJ7OqoUDbc5+0WBymMM2HWrq2gHn/44/+cUGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749741885; c=relaxed/simple;
	bh=+qF0IDawijRPYP4Y+6qlnAYE0xTB21o1YrLZ1UK9Vm4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=mVTKlO+/4vKSLPlTFN+YRTPNE/08LFmd0TL+bMKwgb8g9hmSaMqRSjdEL2iqIWj5wKOa3WtQpVBJptTfAn1NIyqP0nx0ZN/2f3kDW8cRjNDg85cqr3mWu2YMLqLnl6UMoMtjQYy/ZSZfe1IxG2AQeHrPEz4aLO7E5ND2wIAEEt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YbhRCPOM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F9BAC4CEEA;
	Thu, 12 Jun 2025 15:24:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749741884;
	bh=+qF0IDawijRPYP4Y+6qlnAYE0xTB21o1YrLZ1UK9Vm4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=YbhRCPOMaIrBYDkKLUWGFcgftPCCK1QyqR2V9Jhjmm9wJlFLikoGYH92CG/vPAAN7
	 hZccemg6MV6RplqE73kQqlVrggt+9GuDkJvAc7TalwU1w585Cdo3l0UVzsDN95Cmov
	 9+UnPiICzV0t/Voc5T02ihJQl6OmN3Br0SqKUC+s5zNPCDTZxRlfK35hPy2FfCBR8X
	 e5uEuUwNKajB+nL5bfUYIfzVr1kwIp1xNgytEoMwLMH39SPuRLZ7elKXXCOd9aghsC
	 M/OwMcJdObvQPs9m8YeXBaLLDkWnot0W57WPC6qVYd3HcCk9ieXD8AXLbDvl0Aifl4
	 0NZmOyTA90FRw==
Date: Thu, 12 Jun 2025 10:24:42 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Niklas Cassel <cassel@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Wilfred Mallawa <wilfred.mallawa@wdc.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Laszlo Fiat <laszlo.fiat@proton.me>, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org
Subject: Re: [PATCH 1/4] PCI: dw-rockchip: Do not enumerate bus before
 endpoint devices are ready
Message-ID: <20250612152442.GA908790@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2e23r5i5kmju476fcakodccyqnwanbhtyul5prqpqdgqivy3t6@ci54hfghhbb7>

On Thu, Jun 12, 2025 at 08:33:54PM +0530, Manivannan Sadhasivam wrote:
> On Thu, Jun 12, 2025 at 09:44:47AM -0500, Bjorn Helgaas wrote:
> > On Thu, Jun 12, 2025 at 06:30:37PM +0530, Manivannan Sadhasivam wrote:
> > > On Thu, Jun 12, 2025 at 07:21:08AM -0500, Bjorn Helgaas wrote:
> > > > On Thu, Jun 12, 2025 at 01:40:23PM +0200, Niklas Cassel wrote:
> > > > > On Thu, Jun 12, 2025 at 06:38:27AM -0500, Bjorn Helgaas wrote:
> > > > > > On Thu, Jun 12, 2025 at 01:19:45PM +0200, Niklas Cassel wrote:
> > > > > > > On Wed, Jun 11, 2025 at 04:14:56PM -0500, Bjorn Helgaas wrote:
> > > > > > > > On Wed, Jun 11, 2025 at 12:51:42PM +0200, Niklas Cassel wrote:
> > > > > > > > > Commit ec9fd499b9c6 ("PCI: dw-rockchip: Don't wait for link since we can
> > > > > > > > > detect Link Up") changed so that we no longer call dw_pcie_wait_for_link(),
> > > > > > > > > and instead enumerate the bus directly after receiving the Link Up IRQ.
> > > > > > > > > 
> > > > > > > > > This means that there is no longer any delay between link up and the bus
> > > > > > > > > getting enumerated.
> > > > > > 
> > > > > > > > I think the comment at the PCIE_T_RRS_READY_MS definition should be
> > > > > > > > enough (although it might need to be updated to mention link-up).
> > > > > > > > This delay is going to be a standard piece of every driver, so it
> > > > > > > > won't require special notice.
> > > > > > > 
> > > > > > > Looking at pci.h, we already have a comment mentioning exactly this
> > > > > > > (link-up):
> > > > > > > https://github.com/torvalds/linux/blob/v6.16-rc1/drivers/pci/pci.h#L51-L63
> > > > > > > 
> > > > > > > I will change the patches to use PCIE_RESET_CONFIG_DEVICE_WAIT_MS instead.
> > > > > > 
> > > > > > I'll more closely later, but I think PCIE_T_RRS_READY_MS and
> > > > > > PCIE_RESET_CONFIG_DEVICE_WAIT_MS are duplicates and only one should
> > > > > > exist.  It looks like they got merged at about the same time by
> > > > > > different people, so we didn't notice.
> > > > > 
> > > > > I came to the same conclusion, I will send a patch to remove
> > > > > PCIE_T_RRS_READY_MS and convert the only existing user to use
> > > > > PCIE_RESET_CONFIG_DEVICE_WAIT_MS.
> > > > 
> > > > I think PCIE_T_RRS_READY_MS expresses the purpose of the wait more
> > > > specifically.  It's not that the device is completely ready after
> > > > 100ms; just that it should be able to respond with RRS if it needs
> > > > more time.
> > > 
> > > Yes, but none of the drivers are checking for the RRS status
> > > currently. So using PCIE_T_RRS_READY_MS gives a wrong impression
> > > that the driver is waiting for the RRS status from the device.
> > 
> > There's 100ms immediately after reset or link-up when we can't send
> > config requests because the device may not be able to respond at all.
> > 
> > After 100ms, the device should be able to respond to config requests
> > with SC, UR, RRS, or CA status (sec 2.2.9.1).  If it responds with
> > RRS, the access should be retried either by hardware or (if RRS SV is
> > enabled) by software.  This is the origin of "RRS_READY" -- the device
> > can at least do RRS.
> 
> Yeah, but the usage of 100ms is only valid if RRS SV is enabled by
> the software as per sec 6.6.1:
> 
> "It is strongly recommended that software use 100 ms wait periods
> only if software enables Configuration RRS Software Visibility".

I see that statement but don't understand it.  Do you think it's meant
as an exception to the first two paragraphs that say "software must
wait a minimum of 100 ms" following either "exit from Conventional
Reset" or "after Link training completes"?

I can't imagine that it means "if the Root Port doesn't support RRS SV
or software doesn't enable RRS SV, software needn't wait at all before
issuing config requests."

This whole thing is about whether the Endpoint is ready to respond.
A Root Port property (RRS SV support or enablement) doesn't tell us
anything about the Endpoint.

