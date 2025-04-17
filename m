Return-Path: <linux-pci+bounces-26125-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A307A9230A
	for <lists+linux-pci@lfdr.de>; Thu, 17 Apr 2025 18:52:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4246E3AB433
	for <lists+linux-pci@lfdr.de>; Thu, 17 Apr 2025 16:52:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FAB725485C;
	Thu, 17 Apr 2025 16:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gTtyo+yR"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46E00254842;
	Thu, 17 Apr 2025 16:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744908741; cv=none; b=ll5YgHTb1UFAPzoZTXQRt6pGMZu7cJMTypa52MUi/uyTGnmKq1Uz28Hx/M7SE+GEcz3mG+B/KuGhQdEm3b7lTtuGaVRl5cVQz8qf8O1dCwRX8VDDcZP2mvGV+XStgp50S7CW+xI2LDu+VdrDNY+sNhqcK4iueu2qempTWgEUq6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744908741; c=relaxed/simple;
	bh=Us5KGJ06EpniB9Lq8EokWDK/QvSzQfAUWxcm5rSlsLM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=If3BpVRThPQODIEJnNDll/eJNgOojDXTPwQsXXH9QLiH378hFRla9OXJFSik3uiqfaiUec1cgqjXz3lp8+DU1bT9Yw/wylcbUyQXTfKUavEmRuiN+r+BcpdayUNOiLNS4QrujNCFi3pawqll8PSo8OPXwkjgrgrdXd0TdEWSTyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gTtyo+yR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E678C4CEE4;
	Thu, 17 Apr 2025 16:52:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744908740;
	bh=Us5KGJ06EpniB9Lq8EokWDK/QvSzQfAUWxcm5rSlsLM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=gTtyo+yR7ipvHNpFgGtC0rJ0C7obiBFQy/2hOweKNa78SHw1xMChSfPjq0ku5R4Dl
	 nZEmNhITeZNFbB3imQka3GltevciNGZiW8rZ3V4JEEc/0nHvCs8LuNkERn1W2hDgr4
	 ssR6qKGmmp2I6O8rN6RX6Rvfwc/mbeG/nUZkveU6BgZrJS9UqZ3xOp+c13Lu8NUQGF
	 JCqnk7FL8fUP6vdlxy3NfIPIphVafLJuL915uDh1At6Y8muC1rdff7+XPkhOnDs2JT
	 0cxb5bW7V45t7oz0hjkE77COfGnkywwEaVQqFIEHJ5yxGD24ThUFE1yhd5M7AkIviY
	 cCaIg9TeuBhrA==
Date: Thu, 17 Apr 2025 11:52:19 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Niklas Cassel <cassel@kernel.org>
Cc: Hans Zhang <18255117159@163.com>, Shawn Lin <shawn.lin@rock-chips.com>,
	lpieralisi@kernel.org, kw@linux.com, bhelgaas@google.com,
	heiko@sntech.de, manivannan.sadhasivam@linaro.org, robh@kernel.org,
	jingoohan1@gmail.com, thomas.richard@bootlin.com,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org
Subject: Re: [PATCH] PCI: dw-rockchip: Configure max payload size on host init
Message-ID: <20250417165219.GA115235@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aAC-VTqJpCqcz6NK@ryzen>

On Thu, Apr 17, 2025 at 10:39:49AM +0200, Niklas Cassel wrote:
> On Thu, Apr 17, 2025 at 04:07:51PM +0800, Hans Zhang wrote:
> > On 2025/4/17 15:48, Niklas Cassel wrote:
> > 
> > Hi Niklas and Shawn,
> > 
> > Thank you very much for your discussion and reply.
> > 
> > I tested it on RK3588 and our platform. By setting pci=pcie_bus_safe, the
> > maximum MPS will be automatically matched in the end.
> > 
> > So is my patch no longer needed? For RK3588, does the customer have to
> > configure CONFIG_PCIE_BUS_SAFE or pci=pcie_bus_safe?
> > 
> > Also, for pci-meson.c, can the meson_set_max_payload be deleted?
> 
> I think the only reason why this works is because
> pcie_bus_configure_settings(), in the case of
> pcie_bus_config == PCIE_BUS_SAFE, will walk the bus and set MPS in
> the bridge to the lowest of the downstream devices:
> https://github.com/torvalds/linux/blob/v6.15-rc2/drivers/pci/probe.c#L2994-L2999
> 
> So Hans, if you look at lspci for the other RCs/bridges that don't
> have any downstream devices connected, do they also show DevCtl.MPS 256B
> or do they still show 128B ?
> 
> One could argue that for all policies (execept for maybe PCIE_BUS_TUNE_OFF),
> pcie_bus_configure_settings() should start off by initializing DevCtl.MPS to
> DevCap.MPS (for the bridge itself), and after that pcie_bus_configure_settings()
> can override it depending on policy, e.g. set MPS to 128B in case of
> pcie_bus_config == PCIE_BUS_PEER2PEER, or walk the bus in case of
> pcie_bus_config == PCIE_BUS_SAFE.
> 
> That way, we should be able to remove the setting for pci-meson.c as well.

Thanks, I came here to say basically the same thing.  Ideally I think
the generic code in pcie_bus_configure_settings() should be able to
increase MPS or decrease it such that neither meson_set_max_payload()
nor rockchip_pcie_set_max_payload() is required.

However, the requirement to pick a Kconfig setting makes it a mess.  I
would love to get rid of those Kconfig symbols.  I don't like the
command-line parameters either, but it would definitely be an
improvement if we could nuke the Kconfig symbols and rely on the
command-line parameters.

It's also a problem when devices are hot-added after the hierarchy has
already been set up because the new device might not work correctly in
the existing config.

It's a hard problem to solve.

For new platforms without an install base, maybe it would be easier to
rely on the command-line parameters since there aren't a bunch of
users that would have to change the Kconfig.

Bjorn

