Return-Path: <linux-pci+bounces-29539-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EE1ECAD6F3A
	for <lists+linux-pci@lfdr.de>; Thu, 12 Jun 2025 13:40:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F0D8D1898646
	for <lists+linux-pci@lfdr.de>; Thu, 12 Jun 2025 11:40:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A26B2F4321;
	Thu, 12 Jun 2025 11:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D46JWsak"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E97F92F430B
	for <linux-pci@vger.kernel.org>; Thu, 12 Jun 2025 11:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749728429; cv=none; b=DTh9Pfg2NBl0EcdNk44IPFPcULLcGxrIuZzYfpavWn55aMOtO6dwIZGMqIyilmaH8yqf4Afh5ori2x3SbLfY27jKrOaGwuGvguDIyNYud7gL8Uv2jQ1R5Lag/d/Ma+03wVTI9hvrH7sg5I6jkbgqybXg8f7WmiMe7NNY5brK2lo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749728429; c=relaxed/simple;
	bh=eP6kQwyfpfqMWt9WSHDrI/JTr30d77aJcDyT3/Xn1/I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a8NwZ7CKwCSADRisPSts14vq9u+1WgJU2MIKamrpvLCztUNKvE9zejOBpO721RJHEiQ1KB8LHnQroZn3he32I9tIlXVuJIcIKToF5u1EvF04SE7eTu8BdrxudqKk7IoIbAuQ8/ZE/gZfE0dBtEjR7DGVtynT5nyPdTzSSeq7148=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D46JWsak; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6783C4CEEA;
	Thu, 12 Jun 2025 11:40:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749728428;
	bh=eP6kQwyfpfqMWt9WSHDrI/JTr30d77aJcDyT3/Xn1/I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=D46JWsakhRB5k/BPS9uJJunPPFbQ930TCx8CYfMB9003RqEMmtJ5B64IFBas1iBwu
	 /4MMzXuy3gcjbfwxuRN1REHLQjet6gnn3zam2RSYu94JY6jQoOMoTjCgC/cGTRVENw
	 Jk96kMZL8U6IRhu1kUBOgXcvvJwKKML0uMwA4RGb6oOqOyc6LaI4K8mGVLtc5RZSfn
	 fP8++qibyKX6FfBf6IkgzDNOL/YbFflMphTM+nU5r8hnwGBFB5ZAFIMmFbKMp6aNxw
	 4Z3ZtmApILBsclnJq/GP5zWsYByLTUfVOBE7IGAlczKybny3okkzk82aCgDLNvzwmX
	 GNZ/SVcjjhUMg==
Date: Thu, 12 Jun 2025 13:40:23 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Bjorn Helgaas <helgaas@kernel.org>
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
Message-ID: <aEq8pxE45PmeXN_W@ryzen>
References: <aEq30a7vJmKyYWYT@ryzen>
 <20250612113827.GA894522@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250612113827.GA894522@bhelgaas>

On Thu, Jun 12, 2025 at 06:38:27AM -0500, Bjorn Helgaas wrote:
> On Thu, Jun 12, 2025 at 01:19:45PM +0200, Niklas Cassel wrote:
> > On Wed, Jun 11, 2025 at 04:14:56PM -0500, Bjorn Helgaas wrote:
> > > On Wed, Jun 11, 2025 at 12:51:42PM +0200, Niklas Cassel wrote:
> > > > Commit ec9fd499b9c6 ("PCI: dw-rockchip: Don't wait for link since we can
> > > > detect Link Up") changed so that we no longer call dw_pcie_wait_for_link(),
> > > > and instead enumerate the bus directly after receiving the Link Up IRQ.
> > > > 
> > > > This means that there is no longer any delay between link up and the bus
> > > > getting enumerated.
> 
> > > I think the comment at the PCIE_T_RRS_READY_MS definition should be
> > > enough (although it might need to be updated to mention link-up).
> > > This delay is going to be a standard piece of every driver, so it
> > > won't require special notice.
> > 
> > Looking at pci.h, we already have a comment mentioning exactly this
> > (link-up):
> > https://github.com/torvalds/linux/blob/v6.16-rc1/drivers/pci/pci.h#L51-L63
> > 
> > I will change the patches to use PCIE_RESET_CONFIG_DEVICE_WAIT_MS instead.
> 
> I'll more closely later, but I think PCIE_T_RRS_READY_MS and
> PCIE_RESET_CONFIG_DEVICE_WAIT_MS are duplicates and only one should
> exist.  It looks like they got merged at about the same time by
> different people, so we didn't notice.

I came to the same conclusion, I will send a patch to remove
PCIE_T_RRS_READY_MS and convert the only existing user to use
PCIE_RESET_CONFIG_DEVICE_WAIT_MS.


Kind regards,
Niklas

