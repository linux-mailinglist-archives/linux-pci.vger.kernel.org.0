Return-Path: <linux-pci+bounces-29571-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 67295AD7885
	for <lists+linux-pci@lfdr.de>; Thu, 12 Jun 2025 18:51:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D84FD3B2D7A
	for <lists+linux-pci@lfdr.de>; Thu, 12 Jun 2025 16:51:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DF9119F13F;
	Thu, 12 Jun 2025 16:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lle5iPO1"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4745E17AE1D
	for <linux-pci@vger.kernel.org>; Thu, 12 Jun 2025 16:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749747082; cv=none; b=B766fFJSnDSoQbVquYTv/UQNQU6D+lMEyB+QajaIhQNpvQ8EHzMGQYEBBybNAc6nnKOGwfLobEmh0MVNB6hzISbFUEEgm8mhZjTNpmtFCpbncI5CseGXEeqzM0n850ELEdMx91TXTEeBjpl3nSE1gjehOqfxtX326zMbLhB9unY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749747082; c=relaxed/simple;
	bh=l2F/3t+8SIJLEDbXAmzSF5v0PHC967ELWAyFEgyMaJU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b0zSnqMRopCWpAFaTWNpvf4WBVZugb5mrtMiFLJmzM66qsPe+28t4xgrdK/kAg/Pg5bJ9mL5pN3yvYcAOIWqmI+CK1IQl4geahjpgdTcObghACUBu+cv1E5+Gw3gn1htCiBnIK/lQpeAl3N/wbFIF2Uoe58X7sV7awxYT4wIJ/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lle5iPO1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 711E2C4CEEA;
	Thu, 12 Jun 2025 16:51:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749747081;
	bh=l2F/3t+8SIJLEDbXAmzSF5v0PHC967ELWAyFEgyMaJU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lle5iPO1DNjbhLGB4VbOJYvB39anufxlTt++B3y6P+q/9kOzh84ujA9JjxGxoO4kX
	 P40/8Grk4pMEDUtI5Krs4LO8b2d44eg9et83HLw9o+ULE3lz9SLJDqSOiudL2hSM7p
	 LEzmLzuoQxsFsGsVjxxyOlWTByGWcXgfY1XWTGGqWkLPhXLnoxnl3+tvK65OxDUCgl
	 ZwPVFY+G2CUwONVRX6VgfdPzSDe61er5LVkbvNZQh/nriZ69t7QBnhUhVKSMdA7d9K
	 YecY3x5y/FsYk0z6yOEoHI7yflKAs9zuQLMphkpj80Cx4SePw6J9YBlibVT2pyITmM
	 3YU6Vt5qTUNbw==
Date: Thu, 12 Jun 2025 22:21:13 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Niklas Cassel <cassel@kernel.org>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Heiko Stuebner <heiko@sntech.de>, Wilfred Mallawa <wilfred.mallawa@wdc.com>, 
	Damien Le Moal <dlemoal@kernel.org>, Laszlo Fiat <laszlo.fiat@proton.me>, linux-pci@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org
Subject: Re: [PATCH 1/4] PCI: dw-rockchip: Do not enumerate bus before
 endpoint devices are ready
Message-ID: <3sgjqqwpp57dn7wxbd32qmzwaf3tu5jmylklxnf3siwz7ysuxn@y2uoh3clqpgr>
References: <2e23r5i5kmju476fcakodccyqnwanbhtyul5prqpqdgqivy3t6@ci54hfghhbb7>
 <20250612152442.GA908790@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250612152442.GA908790@bhelgaas>

On Thu, Jun 12, 2025 at 10:24:42AM -0500, Bjorn Helgaas wrote:
> On Thu, Jun 12, 2025 at 08:33:54PM +0530, Manivannan Sadhasivam wrote:
> > On Thu, Jun 12, 2025 at 09:44:47AM -0500, Bjorn Helgaas wrote:
> > > On Thu, Jun 12, 2025 at 06:30:37PM +0530, Manivannan Sadhasivam wrote:
> > > > On Thu, Jun 12, 2025 at 07:21:08AM -0500, Bjorn Helgaas wrote:
> > > > > On Thu, Jun 12, 2025 at 01:40:23PM +0200, Niklas Cassel wrote:
> > > > > > On Thu, Jun 12, 2025 at 06:38:27AM -0500, Bjorn Helgaas wrote:
> > > > > > > On Thu, Jun 12, 2025 at 01:19:45PM +0200, Niklas Cassel wrote:
> > > > > > > > On Wed, Jun 11, 2025 at 04:14:56PM -0500, Bjorn Helgaas wrote:
> > > > > > > > > On Wed, Jun 11, 2025 at 12:51:42PM +0200, Niklas Cassel wrote:
> > > > > > > > > > Commit ec9fd499b9c6 ("PCI: dw-rockchip: Don't wait for link since we can
> > > > > > > > > > detect Link Up") changed so that we no longer call dw_pcie_wait_for_link(),
> > > > > > > > > > and instead enumerate the bus directly after receiving the Link Up IRQ.
> > > > > > > > > > 
> > > > > > > > > > This means that there is no longer any delay between link up and the bus
> > > > > > > > > > getting enumerated.
> > > > > > > 
> > > > > > > > > I think the comment at the PCIE_T_RRS_READY_MS definition should be
> > > > > > > > > enough (although it might need to be updated to mention link-up).
> > > > > > > > > This delay is going to be a standard piece of every driver, so it
> > > > > > > > > won't require special notice.
> > > > > > > > 
> > > > > > > > Looking at pci.h, we already have a comment mentioning exactly this
> > > > > > > > (link-up):
> > > > > > > > https://github.com/torvalds/linux/blob/v6.16-rc1/drivers/pci/pci.h#L51-L63
> > > > > > > > 
> > > > > > > > I will change the patches to use PCIE_RESET_CONFIG_DEVICE_WAIT_MS instead.
> > > > > > > 
> > > > > > > I'll more closely later, but I think PCIE_T_RRS_READY_MS and
> > > > > > > PCIE_RESET_CONFIG_DEVICE_WAIT_MS are duplicates and only one should
> > > > > > > exist.  It looks like they got merged at about the same time by
> > > > > > > different people, so we didn't notice.
> > > > > > 
> > > > > > I came to the same conclusion, I will send a patch to remove
> > > > > > PCIE_T_RRS_READY_MS and convert the only existing user to use
> > > > > > PCIE_RESET_CONFIG_DEVICE_WAIT_MS.
> > > > > 
> > > > > I think PCIE_T_RRS_READY_MS expresses the purpose of the wait more
> > > > > specifically.  It's not that the device is completely ready after
> > > > > 100ms; just that it should be able to respond with RRS if it needs
> > > > > more time.
> > > > 
> > > > Yes, but none of the drivers are checking for the RRS status
> > > > currently. So using PCIE_T_RRS_READY_MS gives a wrong impression
> > > > that the driver is waiting for the RRS status from the device.
> > > 
> > > There's 100ms immediately after reset or link-up when we can't send
> > > config requests because the device may not be able to respond at all.
> > > 
> > > After 100ms, the device should be able to respond to config requests
> > > with SC, UR, RRS, or CA status (sec 2.2.9.1).  If it responds with
> > > RRS, the access should be retried either by hardware or (if RRS SV is
> > > enabled) by software.  This is the origin of "RRS_READY" -- the device
> > > can at least do RRS.
> > 
> > Yeah, but the usage of 100ms is only valid if RRS SV is enabled by
> > the software as per sec 6.6.1:
> > 
> > "It is strongly recommended that software use 100 ms wait periods
> > only if software enables Configuration RRS Software Visibility".
> 
> I see that statement but don't understand it.  Do you think it's meant
> as an exception to the first two paragraphs that say "software must
> wait a minimum of 100 ms" following either "exit from Conventional
> Reset" or "after Link training completes"?
> 

Maybe yes.

> I can't imagine that it means "if the Root Port doesn't support RRS SV
> or software doesn't enable RRS SV, software needn't wait at all before
> issuing config requests."
> 

Yeah, it cannot be.

> This whole thing is about whether the Endpoint is ready to respond.
> A Root Port property (RRS SV support or enablement) doesn't tell us
> anything about the Endpoint.

I think we should just leave the RRS for good :) I was having a feeling that the
RRS define we have didn't fit the purpose of waiting for the device to be ready
post link up. Hence, I looked it up in the spec and spotted the above statement,
just to confuse you and myself.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

