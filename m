Return-Path: <linux-pci+bounces-29546-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D5F6AD7024
	for <lists+linux-pci@lfdr.de>; Thu, 12 Jun 2025 14:22:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50D293B2DB4
	for <lists+linux-pci@lfdr.de>; Thu, 12 Jun 2025 12:21:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 128452222A6;
	Thu, 12 Jun 2025 12:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EZYd79dX"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1924221F1E
	for <linux-pci@vger.kernel.org>; Thu, 12 Jun 2025 12:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749730872; cv=none; b=HvG4SvgWDtpblDGmjz2QPdQm3tIM27OF/3G1W9kDZBhiqj/nJH/3uPpEqE9tjCNY4BFA9+93KbfPlNausg/bWKozpIbGy0y2K3xzlAJOTop4xpKpDoKD7YeIwGkDpfiyTddmvSamJaKkiTTqRFaBoI3ULjam+nZzISh70V+BrjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749730872; c=relaxed/simple;
	bh=D3EDhHkJNow/VmK8m96vIDUE8UN6sG5L/6g1o10X+JI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=gY16RrGAd2gEDGs0tM9qQxSoAN9RzXwLPAJ05ANpZdwLx6JJfBwOMJ8QzJI/dTzQmhPCjf8DEnu7xY2ZdJvtRONCZFHm5dJmZ+xfp1nISxf70lSS0kEqL5TY+VRgrPoLGIyLkPlx7LfN0Un/3pbck2b05PLSRxC6QIdwV3zR/Ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EZYd79dX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D670C4CEEA;
	Thu, 12 Jun 2025 12:21:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749730871;
	bh=D3EDhHkJNow/VmK8m96vIDUE8UN6sG5L/6g1o10X+JI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=EZYd79dXpn+rewjaoeCT6WVWmMUeWHAfPEgwrs0weSKOwymAkyOOZkP9nObwIVXjf
	 JWsNj3tcCWvNNpHuivmR841FN+4nGpV/sgoMN7nrW/vxH3tlZB11GLISU1A+KU00u+
	 mIDxMcDikVKp1EGWBNNHFOTGbEHFZghNYR12M+EAM2TGLfIun+FqtKyY/3BiAz/9oX
	 JfABq1y9IiijojH4qHtL5SQuz5OooIvteGg93ijYA9DSL5TmjlUFa1Pq4QiigBKbrW
	 pJb8h79uxLdzoH1QTJJrzedSJo8zZfaSoHUz4q0cjmJCjeR9KYP385fOpLAvOtRJG7
	 eT35UGvi6pQVg==
Date: Thu, 12 Jun 2025 07:21:08 -0500
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
Message-ID: <20250612122108.GA901642@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aEq8pxE45PmeXN_W@ryzen>

On Thu, Jun 12, 2025 at 01:40:23PM +0200, Niklas Cassel wrote:
> On Thu, Jun 12, 2025 at 06:38:27AM -0500, Bjorn Helgaas wrote:
> > On Thu, Jun 12, 2025 at 01:19:45PM +0200, Niklas Cassel wrote:
> > > On Wed, Jun 11, 2025 at 04:14:56PM -0500, Bjorn Helgaas wrote:
> > > > On Wed, Jun 11, 2025 at 12:51:42PM +0200, Niklas Cassel wrote:
> > > > > Commit ec9fd499b9c6 ("PCI: dw-rockchip: Don't wait for link since we can
> > > > > detect Link Up") changed so that we no longer call dw_pcie_wait_for_link(),
> > > > > and instead enumerate the bus directly after receiving the Link Up IRQ.
> > > > > 
> > > > > This means that there is no longer any delay between link up and the bus
> > > > > getting enumerated.
> > 
> > > > I think the comment at the PCIE_T_RRS_READY_MS definition should be
> > > > enough (although it might need to be updated to mention link-up).
> > > > This delay is going to be a standard piece of every driver, so it
> > > > won't require special notice.
> > > 
> > > Looking at pci.h, we already have a comment mentioning exactly this
> > > (link-up):
> > > https://github.com/torvalds/linux/blob/v6.16-rc1/drivers/pci/pci.h#L51-L63
> > > 
> > > I will change the patches to use PCIE_RESET_CONFIG_DEVICE_WAIT_MS instead.
> > 
> > I'll more closely later, but I think PCIE_T_RRS_READY_MS and
> > PCIE_RESET_CONFIG_DEVICE_WAIT_MS are duplicates and only one should
> > exist.  It looks like they got merged at about the same time by
> > different people, so we didn't notice.
> 
> I came to the same conclusion, I will send a patch to remove
> PCIE_T_RRS_READY_MS and convert the only existing user to use
> PCIE_RESET_CONFIG_DEVICE_WAIT_MS.

I think PCIE_T_RRS_READY_MS expresses the purpose of the wait more
specifically.  It's not that the device is completely ready after
100ms; just that it should be able to respond with RRS if it needs
more time.

