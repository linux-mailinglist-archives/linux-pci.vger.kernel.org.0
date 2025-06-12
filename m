Return-Path: <linux-pci+bounces-29554-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 064D2AD7461
	for <lists+linux-pci@lfdr.de>; Thu, 12 Jun 2025 16:46:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8ABC617B76C
	for <lists+linux-pci@lfdr.de>; Thu, 12 Jun 2025 14:45:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A54481A0BE0;
	Thu, 12 Jun 2025 14:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hM3LZUyq"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 806642AEFD
	for <linux-pci@vger.kernel.org>; Thu, 12 Jun 2025 14:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749739489; cv=none; b=ezCZ70PvVI85AzegXqYsELIKAsBR+0TI8W5bp9TbJo2ZB3QLEEIuSEf5qWBctmKdLq1hzg7sVbuGUf6u8/7mOy+NM2DYDwIknWdw5wkWrTGn0EnzX50Lj0Mua0vfvV52wI9fmyPAuFwEuWojeEluRAR1arOylxEecMufLwQ2LzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749739489; c=relaxed/simple;
	bh=/4XAl/Uym603PEnwuhOtlVJIOWql+o3h2l1QrsNj3KQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=l92WlrychLbKJy3sOkREX2k8VBMAGf90fHcDRpLkQk6EDzMEeUc9/6Qr5+ELsMSDIqdexywBGQP8y9Jvynl69A+aRElwQRtArEq+hutIC2U6LBF6ku7qcSbVpaQNYwstY0vpogdqF+Yw8W6J/dIgeyiczgzdWE5FcZJ0DEdouMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hM3LZUyq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0464AC4CEEA;
	Thu, 12 Jun 2025 14:44:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749739489;
	bh=/4XAl/Uym603PEnwuhOtlVJIOWql+o3h2l1QrsNj3KQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=hM3LZUyqdFmUQDcojGiU7qlxGb7eJMZYGxrQ0r6PyBGGVQFKLR3Wc0VYzGZlk1BrL
	 a8xnYgg0vrFigcsWghZSOOgaxhhuEiGiqx+cFiHLUWn7f2T1o7BgLyK1iHgsNLhwWm
	 jXXa8hBJDs7T7KZsyqnYzzeU41lTdsQxzZdGIDR80vkGOSX+Cyr3d8WrPK3Z9prAeT
	 wiOTS/M/cPKN5d6Xf0oiiaCpZGD6MyQg+PEkKPwi/TaTy9dKqCMtBxX2ehWdBjFSNT
	 ocM23lbDvW+AM3EKrIRJJvyECpHwPyyueW2bUjjFyBTJcnaU6etL4a1Z6qYlMuDKkh
	 XHdw6xrCyPF7A==
Date: Thu, 12 Jun 2025 09:44:47 -0500
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
Message-ID: <20250612144447.GA903908@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <apkamrd6ty2km7mjwz4mpe2xhewxgd3crmeqdmnj7wn6jl4emv@3nwrt43u2ons>

On Thu, Jun 12, 2025 at 06:30:37PM +0530, Manivannan Sadhasivam wrote:
> On Thu, Jun 12, 2025 at 07:21:08AM -0500, Bjorn Helgaas wrote:
> > On Thu, Jun 12, 2025 at 01:40:23PM +0200, Niklas Cassel wrote:
> > > On Thu, Jun 12, 2025 at 06:38:27AM -0500, Bjorn Helgaas wrote:
> > > > On Thu, Jun 12, 2025 at 01:19:45PM +0200, Niklas Cassel wrote:
> > > > > On Wed, Jun 11, 2025 at 04:14:56PM -0500, Bjorn Helgaas wrote:
> > > > > > On Wed, Jun 11, 2025 at 12:51:42PM +0200, Niklas Cassel wrote:
> > > > > > > Commit ec9fd499b9c6 ("PCI: dw-rockchip: Don't wait for link since we can
> > > > > > > detect Link Up") changed so that we no longer call dw_pcie_wait_for_link(),
> > > > > > > and instead enumerate the bus directly after receiving the Link Up IRQ.
> > > > > > > 
> > > > > > > This means that there is no longer any delay between link up and the bus
> > > > > > > getting enumerated.
> > > > 
> > > > > > I think the comment at the PCIE_T_RRS_READY_MS definition should be
> > > > > > enough (although it might need to be updated to mention link-up).
> > > > > > This delay is going to be a standard piece of every driver, so it
> > > > > > won't require special notice.
> > > > > 
> > > > > Looking at pci.h, we already have a comment mentioning exactly this
> > > > > (link-up):
> > > > > https://github.com/torvalds/linux/blob/v6.16-rc1/drivers/pci/pci.h#L51-L63
> > > > > 
> > > > > I will change the patches to use PCIE_RESET_CONFIG_DEVICE_WAIT_MS instead.
> > > > 
> > > > I'll more closely later, but I think PCIE_T_RRS_READY_MS and
> > > > PCIE_RESET_CONFIG_DEVICE_WAIT_MS are duplicates and only one should
> > > > exist.  It looks like they got merged at about the same time by
> > > > different people, so we didn't notice.
> > > 
> > > I came to the same conclusion, I will send a patch to remove
> > > PCIE_T_RRS_READY_MS and convert the only existing user to use
> > > PCIE_RESET_CONFIG_DEVICE_WAIT_MS.
> > 
> > I think PCIE_T_RRS_READY_MS expresses the purpose of the wait more
> > specifically.  It's not that the device is completely ready after
> > 100ms; just that it should be able to respond with RRS if it needs
> > more time.
> 
> Yes, but none of the drivers are checking for the RRS status
> currently. So using PCIE_T_RRS_READY_MS gives a wrong impression
> that the driver is waiting for the RRS status from the device.

There's 100ms immediately after reset or link-up when we can't send
config requests because the device may not be able to respond at all.

After 100ms, the device should be able to respond to config requests
with SC, UR, RRS, or CA status (sec 2.2.9.1).  If it responds with
RRS, the access should be retried either by hardware or (if RRS SV is
enabled) by software.  This is the origin of "RRS_READY" -- the device
can at least do RRS.

"CONFIG_READY" would make sense except that it would be confused with
the spec's usage of "Configuration Ready" (unfortunately not formally
defined).  The PCIe r6.0, sec 6.22 implementation note says devices
may take up to 1 second to become Configuration Ready, and that when a
device is Configuration Ready, system software can proceed without
further delay to configure the device.

"PCIE_RESET_CONFIG_DEVICE_WAIT_MS" seems a little long to me (we might
not need "DEVICE"), but it does include "CONFIG" which is definitely
relevant.  "PCIE_RESET_CONFIG_WAIT_MS"?

Bjorn

