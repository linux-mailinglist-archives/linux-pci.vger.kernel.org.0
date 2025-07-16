Return-Path: <linux-pci+bounces-32334-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DF94B07FA4
	for <lists+linux-pci@lfdr.de>; Wed, 16 Jul 2025 23:30:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7E7AA7B6ECA
	for <lists+linux-pci@lfdr.de>; Wed, 16 Jul 2025 21:29:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C66E2E972C;
	Wed, 16 Jul 2025 21:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NBpfZuE+"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 612E62E92B7;
	Wed, 16 Jul 2025 21:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752701449; cv=none; b=iAXPbFMu7mBxi08DmhIvJ2LfVY4l1VGVfk7uMXZVbnEVKtz9HvcCHgYo2eE+yP4UJNZOkvIuv+L17MAtoeDriaZsN6axlQtFUe8BHntlAphRKVT2+yOKZjlkFM7Kzh5io796QMk7k7FdU1T7uK4454JeqOIUFetxNzvaXyItjVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752701449; c=relaxed/simple;
	bh=BSLPBj7eWsQAUCWWMBF2EIBNVs39iTAgC8ZhnuDmoAY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=dic9nXW049mt8Xslas8o42354LVSdj2WcNDM+riZpotqNtOWYyqJm7O4HDDfIOyUOwNTAbrHIIcAygygYYQh28S+wjDJi7GhLMhAvrrDOruaAJ8f48f4eI+nDmWClv+Ct8LSJCSS1C2kELEA8Ifa0mpgZY1CzIf35yUp055+I3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NBpfZuE+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB341C4CEE7;
	Wed, 16 Jul 2025 21:30:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752701449;
	bh=BSLPBj7eWsQAUCWWMBF2EIBNVs39iTAgC8ZhnuDmoAY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=NBpfZuE+SSOciTziOy3Z1TLjySQniSDIUsjoNZCB5YzUGu0ccWbQJ8rvWBPr4E6Mj
	 DM6JCmaxBoeU2iChEt/I+M64kpbg7Zj5e7Ow+b2ejqp/lG0twVwg/z3tpZ8yjzdSqI
	 u9Ge8kTczqT02NjqFsC3UPO5fferSr1G60JVyX/KP4+xSD/vShyt9JS+pj7PLnjR8d
	 3Q5InsjktbI5ffC9kCYlNg/f2Xh4jWXWcMMJB7NC7AKgsKbJwhgnhy7WVoEMghEL9L
	 9uR3esYUpnREdGwbQWKyNRSY3fylCNWrKsuFpBqqpVUuC7gZW4KC7vnpb8kknHsjxL
	 DQTV4c0/m1Nlw==
Date: Wed, 16 Jul 2025 16:30:47 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Frank Li <Frank.li@nxp.com>
Cc: Brian Norris <briannorris@chromium.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Minghuan Lian <minghuan.Lian@nxp.com>,
	Mingkai Hu <mingkai.hu@nxp.com>, Roy Zang <roy.zang@nxp.com>,
	Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
	Rob Herring <robh+dt@kernel.org>, imx@lists.linux.dev,
	linux-pci@vger.kernel.org
Subject: Re: Does dwc/pci-layerscape.c support AER?
Message-ID: <20250716213047.GA2558388@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aHgYMmjZzpVSAf0c@lizhi-Precision-Tower-5810>

On Wed, Jul 16, 2025 at 05:22:58PM -0400, Frank Li wrote:
> On Wed, Jul 16, 2025 at 03:42:07PM -0500, Bjorn Helgaas wrote:
> > On Wed, Jul 16, 2025 at 10:25:57AM -0700, Brian Norris wrote:
> > > On Wed, Jul 16, 2025 at 09:35:38PM +0530, Manivannan Sadhasivam wrote:
> > > > On Wed, Jul 16, 2025 at 08:20:38AM GMT, Brian Norris wrote:
> > > > > On Wed, Jul 16, 2025 at 12:47:10PM +0530, Manivannan Sadhasivam wrote:
> > > > > > On Wed, Jul 02, 2025 at 04:44:48PM GMT, Brian Norris wrote:
> > > > > > > On Wed, Jul 02, 2025 at 07:09:42PM -0400, Frank Li wrote:
> > > > > > > OTOH, I do also believe there are SoCs where DWC PCIe is
> > > > > > > available, but there is no external MSI controller, and so
> > > > > > > that same problem still may exist. I may even have such SoCs
> > > > > > > available...
> > > > > >
> > > > > > Yes, pretty much all Qcom SoCs without GIC-v3 ITS suffer from
> > > > > > this limitation.  And the same should be true for other
> > > > > > vendors also.
> > > > > >
> > > > > > Interestingly, the Qcom SoCs route the AER/PME via 'global'
> > > > > > SPI interrupt, which is only handled by the controller driver.
> > > > > > This is similar to the 'aer' SPI interrupt in layerscape
> > > > > > platforms.
> > > > >
> > > > > Yeah, I have some SoCs like this as well. But I also believe
> > > > > that I have INTx available, and that even when MSI doesn't work
> > > > > for AER/PME, INTx might.
> > > > >
> > > > > Do Qcom SoCs route INTx?
> > > >
> > > > Yes, they do. But currently, we can only use it by booting with
> > > > pcie_pme=nomsi cmdline parameter.
> >
> > Ugh.  I think these controllers might be out of spec (or maybe we're
> > not configuring MSI/MSI-X correctly for them).  Per PCIe r7.0, sec
> > 6.1.4.3:
> >
> >   While enabled for MSI or MSI-X operation, a Function is prohibited
> >   from using INTx interrupts (if implemented) to request service (MSI,
> >   MSI-X, and INTx are mutually exclusive).
> >
> > If the controller advertises MSI or MSI-X, I think we will enable it
> > and expect AER, PME, hotplug, etc. to use it.
> 
> I think it is controller implement problem, which route AER irq to
> INTx or other irq line in SOC. Consider many users have similar
> issues, can you add workaround or quirk for this type
> implementation.

I think the spec allows the AER interrupt to be routed to INTx, but
only if the Root Port doesn't advertise MSI or MSI-X support or the OS
decides not to enable MSI/MSI-X.

Since there's no generic way to say "MSI/MSI-X works on this Root
Port, but only for certain interrupts, not including AER," there's no
way for Linux to figure out that it shouldn't enable MSI/MSI-X.

*Somebody* can add some kind of quirk for this; not me because I don't
have the hardware.  It needs to be generic so the same solution works
for all these devices.

Bjorn

