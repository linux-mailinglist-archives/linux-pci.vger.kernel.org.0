Return-Path: <linux-pci+bounces-40926-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E1CCC4ED7C
	for <lists+linux-pci@lfdr.de>; Tue, 11 Nov 2025 16:48:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AB7524F1198
	for <lists+linux-pci@lfdr.de>; Tue, 11 Nov 2025 15:44:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F234365A1E;
	Tue, 11 Nov 2025 15:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HzG6rQ3X"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E983F2E6CA4;
	Tue, 11 Nov 2025 15:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762875887; cv=none; b=M3jKdUJqxCQxvEYWpNMycBGOrCkf2jSpHyux6DvyLGUsVE5jxSL+1/7HJh9hjZHeNN6UdS+gPRieQyxbDCRpsh34zS53Ogb+u4g6XH0eBXQm7ozSj8mP4ADSS/QbpQN5MLnLAxUkXs/V3og5/RNYG3Uq9vU66jw27aB5gY2iMqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762875887; c=relaxed/simple;
	bh=kEIGVMJBVgHNfIsiqOwArbHxxwlSOP5asagz3P1dOYM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=PHmRPSa7RF1wg6Xb8GGTuR23HYT+xOe+ZN4l8tkppd0BOKwLoZAYbWTbBdJef1fiRBYibIN4rLr5Vn1psH+O063IOCBVAzHEwxzMda0QdQ1f3je7sUHOU/0EgDjYHZDmM4w87GnpF27NXxXmpMry5NoUNPCXGtFrq/8ti+G4QN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HzG6rQ3X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9780C4CEF5;
	Tue, 11 Nov 2025 15:44:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762875886;
	bh=kEIGVMJBVgHNfIsiqOwArbHxxwlSOP5asagz3P1dOYM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=HzG6rQ3XnpbNRMYPZqf6GW3qRv66U2ogE5HBMLFcHTastXLV865vpAqesAjiTw0xW
	 vuoYR5fSX/oc0NdvRHNDpqRQ+65k1MKSmY1klwOIFU+PNl0hzHhQXHn2hZWHDWMO2r
	 mX7AX9TNL5UHcfOgNWcU+h0F2A8piJLgOJPWlZvK8n+KG3evkRQ1AKGMUOCN9h5FNI
	 e+6FBekHbauDgnPHF0EgKlFZiJhDCy5L57NdDJbtRWoz1G6Fm6EJT/KwMrilkusw3l
	 V8xVkucrNjEElXKevi5q0jxAzK41WFn+5tsOO7TRqF376loU+B9V09Fzf4ZmgqjoE3
	 j/I3ZOlpGG+2w==
Date: Tue, 11 Nov 2025 09:44:45 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Lukas Wunner <lukas@wunner.de>
Cc: linux-pci@vger.kernel.org, Christian Zigotzky <chzigotzky@xenosoft.de>,
	Manivannan Sadhasivam <mani@kernel.org>,
	mad skateman <madskateman@gmail.com>,
	"R . T . Dickinson" <rtd2@xtra.co.nz>,
	Darren Stevens <darren@stevens-zone.net>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	luigi burdo <intermediadc@hotmail.com>, Al <al@datazap.net>,
	Roland <rol7and@gmx.com>, Hongxing Zhu <hongxing.zhu@nxp.com>,
	hypexed@yahoo.com.au, linuxppc-dev@lists.ozlabs.org,
	debian-powerpc@lists.debian.org, linux-kernel@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v2 0/4] PCI/ASPM: Allow quirks to avoid L0s and L1
Message-ID: <20251111154445.GA2175922@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aRMC9z93mI5BKbW0@wunner.de>

On Tue, Nov 11, 2025 at 10:33:43AM +0100, Lukas Wunner wrote:
> On Mon, Nov 10, 2025 at 04:22:24PM -0600, Bjorn Helgaas wrote:
> > We enabled ASPM too aggressively in v6.18-rc1.  f3ac2ff14834 ("PCI/ASPM:
> > Enable all ClockPM and ASPM states for devicetree platforms") enabled ASPM
> > L0s, L1, and (if advertised) L1 PM Substates.
> > 
> > df5192d9bb0e ("PCI/ASPM: Enable only L0s and L1 for devicetree platforms")
> > (v6.18-rc3) backed off and omitted Clock PM and L1 Substates because we
> > don't have good infrastructure to discover CLKREQ# support, and L1
> > Substates may require device-specific configuration.
> > 
> > L0s and L1 are generically discoverable and should not require
> > device-specific support, but some devices advertise them even though they
> > don't work correctly.  This series is a way to add quirks avoid L0s and L1
> > in this case.
> 
> Reviewed-by: Lukas Wunner <lukas@wunner.de>

Thanks!

> I note that a number of drivers call pci_disable_link_state() or
> pci_disable_link_state_locked() to disable ASPM on probe.
> Can we convert (all of) these to quirks which use the new helper
> introduced here?
> 
> I think that would be useful because it would disable ASPM even if
> the driver isn't available and thus avoid e.g. AER messages caused
> by ASPM issues.
> 
> pcie_aspm_init_link_state() also contains the following code comment:
> 
> 	/*
> 	 * At this stage drivers haven't had an opportunity to change the
> 	 * link policy setting. Enabling ASPM on broken hardware can cripple
> 	 * it even before the driver has had a chance to disable ASPM, so
> 	 * default to a safe level right now. If we're enabling ASPM beyond
> 	 * the BIOS's expectation, we'll do so once pci_enable_device() is
> 	 * called.
> 	 */
> 
> If we'd mask out incorrect or non-working L0s/L1 capabilities for all
> devices early during enumeration via quirks, we wouldn't have to go
> through these contortions of setting up deeper ASPM states only at
> device enable time.

I definitely agree.  I forgot to follow up on all of those cases.
There aren't that many of them, but it looks like probably too many to
address for v6.18, and I *think* it's safe to wait and deal with them
for v6.19.

Bjorn

