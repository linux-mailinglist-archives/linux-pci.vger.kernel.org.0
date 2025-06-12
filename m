Return-Path: <linux-pci+bounces-29538-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 78BA8AD6F37
	for <lists+linux-pci@lfdr.de>; Thu, 12 Jun 2025 13:39:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 439553A1B06
	for <lists+linux-pci@lfdr.de>; Thu, 12 Jun 2025 11:38:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31CC51DB346;
	Thu, 12 Jun 2025 11:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GrH18u1G"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D88A2F4337
	for <linux-pci@vger.kernel.org>; Thu, 12 Jun 2025 11:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749728309; cv=none; b=RSbFRdEVES01Ts9ZCcFKMs5RTdVPIXMG2sHBJ9sx7Z7WUZBiOUToCkFAvyUr9Toxfa1O9/bPfSp8vrOYj+2huYH0eqTUQPGsUlkd0Djx5wjvy/VSXwMiE/6gp6rh40utS45CCYxM4QGrrsSe/jO3BuUFDteN+4RScPBzCVbrgXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749728309; c=relaxed/simple;
	bh=dvltVZQeoJH8CB+yRsJHbwu0+yuikY9e90OT10169d0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=d/M7ZyYWle9rxQT0b61p3HGG9O+VM7VTfGTL5dBop68T+DoSn9R3JkFT4TmB54feQQcae0xm3EutjIOLAXPNs/gPmlcHeC0rvy1Ebjv25Iw06sMW0lHVvLjUexKZvlCgACuZ48xvV7MIS06sKawFW6FbTXA6USz9HC0ldSQ3QbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GrH18u1G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 847A9C4CEEA;
	Thu, 12 Jun 2025 11:38:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749728308;
	bh=dvltVZQeoJH8CB+yRsJHbwu0+yuikY9e90OT10169d0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=GrH18u1GPneQW7cOB0tVsoOuu1hgWVJxGhLrjZbuYvHScNf5YSmVvlriPaUHQ90Zd
	 HWZQt0e3K1zO6F785Ejp9okiBIFHvw2yknOeeF68PnN7BN2ymVXjbPwHHo2BIB50X2
	 0goe6kd+q+kuiFZT+WMjVRsCX/krBul9Z6Zp+yDz69fH+aAwNXQBz3eGuTXt+l0Wb8
	 bAiFz0TOsEAFlSqL1h8+M+zH6IFC8lJCUJz4cuClf1hTJVPjclFLg9Li4FtvNq3g/1
	 04xDN99xb2kcnW+QLV6y4YaN21OZtLGukX/Gr6A77ocX7daz8VKRaJA3tjcb5J+PE0
	 MqmItp9DXUg7w==
Date: Thu, 12 Jun 2025 06:38:27 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Niklas Cassel <cassel@kernel.org>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Wilfred Mallawa <wilfred.mallawa@wdc.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Laszlo Fiat <laszlo.fiat@proton.me>, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org
Subject: Re: [PATCH 1/4] PCI: dw-rockchip: Do not enumerate bus before
 endpoint devices are ready
Message-ID: <20250612113827.GA894522@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aEq30a7vJmKyYWYT@ryzen>

On Thu, Jun 12, 2025 at 01:19:45PM +0200, Niklas Cassel wrote:
> On Wed, Jun 11, 2025 at 04:14:56PM -0500, Bjorn Helgaas wrote:
> > On Wed, Jun 11, 2025 at 12:51:42PM +0200, Niklas Cassel wrote:
> > > Commit ec9fd499b9c6 ("PCI: dw-rockchip: Don't wait for link since we can
> > > detect Link Up") changed so that we no longer call dw_pcie_wait_for_link(),
> > > and instead enumerate the bus directly after receiving the Link Up IRQ.
> > > 
> > > This means that there is no longer any delay between link up and the bus
> > > getting enumerated.

> > I think the comment at the PCIE_T_RRS_READY_MS definition should be
> > enough (although it might need to be updated to mention link-up).
> > This delay is going to be a standard piece of every driver, so it
> > won't require special notice.
> 
> Looking at pci.h, we already have a comment mentioning exactly this
> (link-up):
> https://github.com/torvalds/linux/blob/v6.16-rc1/drivers/pci/pci.h#L51-L63
> 
> I will change the patches to use PCIE_RESET_CONFIG_DEVICE_WAIT_MS instead.

I'll more closely later, but I think PCIE_T_RRS_READY_MS and
PCIE_RESET_CONFIG_DEVICE_WAIT_MS are duplicates and only one should
exist.  It looks like they got merged at about the same time by
different people, so we didn't notice.

Bjorn

