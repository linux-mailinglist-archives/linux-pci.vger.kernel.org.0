Return-Path: <linux-pci+bounces-10224-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30BFC93018B
	for <lists+linux-pci@lfdr.de>; Fri, 12 Jul 2024 23:22:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A03CCB21E56
	for <lists+linux-pci@lfdr.de>; Fri, 12 Jul 2024 21:22:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 517B6481C4;
	Fri, 12 Jul 2024 21:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DySCCANj"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 258014E1B3;
	Fri, 12 Jul 2024 21:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720819320; cv=none; b=E59BofArBntIx1FyLxoLlbC1beH/vPBgvkSxxO0FAfDdl6rAGGWyrXxzddFNESEww3veDWSR8Go7bpgBksQpNgFEoHzFJrHCHC66B12tg0lrdPp9NxV6TS9HFQcnX24GtPWYVtIIUyXftaSaMdli35/GYLZsuD8pdWtn3ve/gao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720819320; c=relaxed/simple;
	bh=1R6ZX7cZ3pXxqRSrZRDKYLvh6AiHVFa4qAE7L37CZiE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=E/SYYwDVYE7Rov7OzuVXwRyR3HYarmER3M/dK+Iz4kpq3jN7r6yqW8aYGylfQJB6LjsoLdlWtANjvlxnBkXyx8bfKNE9utivLr6S6Q3hIzLa7czDvWX7ESJeFVzbcBMt/bF2SXW6pxeJ6Fc2TJOV5j3fHFCosOEh9vEQi233dCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DySCCANj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85D54C32782;
	Fri, 12 Jul 2024 21:21:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720819319;
	bh=1R6ZX7cZ3pXxqRSrZRDKYLvh6AiHVFa4qAE7L37CZiE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=DySCCANjC6vYHAdezVU3WoGOyLvO1pLxK5RMvUbC52znmNzc9/RzHtFOvzm+L+F3c
	 RYAyK8p8/Qc60ft6up2kR6YPRBLHfwe+EcAr5uDpVM1HB4jYIP1naQd2jFXw3Dbz3b
	 EkjgfN4PBzmMDOIzMn59IBpJuFsft6f8shaYCYBufNX5NsIXBWDuvs2RwzH4URxI32
	 9QCkBARkepXwkrxREyZAjZGi8I+UDJ3H3vsasxuqYIUtvT7uMQwiTOBZvWeNy4f6G7
	 TnUEfiMUpHuGZH/kb3IfD2OrsZLqbGPCeMLmzSHYjfLGd/LA+/7GJBXPArO6NR4Vrt
	 jOnUoZW2+2R5w==
Date: Fri, 12 Jul 2024 16:21:57 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Ido Schimmel <idosch@nvidia.com>
Cc: Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Petr Machata <petrm@nvidia.com>, mlxsw@nvidia.com,
	linux-pci@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH net-next 3/3] mlxsw: pci: Lock configuration space of
 upstream bridge during reset
Message-ID: <20240712212157.GA339030@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZoVjPb_OwbKh7kHu@shredder.lan>

[+cc Dan]

On Wed, Jul 03, 2024 at 05:42:05PM +0300, Ido Schimmel wrote:
> On Tue, Jul 02, 2024 at 09:35:50AM +0200, Przemek Kitszel wrote:
> > On 7/1/24 18:41, Petr Machata wrote:
> > > From: Ido Schimmel <idosch@nvidia.com>
> > > 
> > > The driver triggers a "Secondary Bus Reset" (SBR) by calling
> > > __pci_reset_function_locked() which asserts the SBR bit in the "Bridge
> > > Control Register" in the configuration space of the upstream bridge for
> > > 2ms. This is done without locking the configuration space of the
> > > upstream bridge port, allowing user space to access it concurrently.
> > 
> > This means your patch is a bugfix.
> > 
> > > Linux 6.11 will start warning about such unlocked resets [1][2]:
> > > 
> > > pcieport 0000:00:01.0: unlocked secondary bus reset via: pci_reset_bus_function+0x51c/0x6a0
> > > 
> > > Avoid the warning by locking the configuration space of the upstream
> > > bridge prior to the reset and unlocking it afterwards.
> > 
> > You are not avoiding the warning but protecting concurrent access,
> > please add a Fixes tag.
> 
> The patch that added the missing lock in PCI core was posted without a
> Fixes tag and merged as part of the 6.10 PR. See commit 7e89efc6e9e4
> ("PCI: Lock upstream bridge for pci_reset_function()").
> 
> I don't see a good reason for root to poke in the configuration space of
> the upstream bridge during SBR, but AFAICT the worst that can happen is
> that reset will fail and while it is a bug, it is not a regression.
> 
> Bjorn, do you see a reason to post this as a fix?

Sorry, I was on vacation and missed this when I returned.

mlxsw is one of the few users of __pci_reset_function_locked().
Others are liquidio (octeon), VFIO, and Xen.

You need __pci_reset_function_locked() if you're already holding the
device mutex, i.e., device_lock(&pdev->dev).  I looked at the
mlxsw_pci_reset_at_pci_disable() path, and didn't see where it holds
that device lock, but I probably missed it.

The usual pci_reset_function() path, which would be preferable if you
can use it, does basically this:

  pci_dev_lock(bridge)
    device_lock(&bridge->dev)
    pci_cfg_access_lock(bridge)
  pci_dev_lock(pdev)
    device_lock(&pdev->dev)
    pci_cfg_access_lock(pdev)
  pci_dev_save_and_disable(dev)
  __pci_reset_function_locked(pdev)

This patch adds pci_cfg_access_lock(bridge), but doesn't acquire the
device_lock for the bridge.

It looks like you always reset the device at mlxsw_pci_probe()-time,
which is quite unusual in the first place, but I suppose there's some
good reason for it.

If you can use pci_reset_function() directly (or avoid the reset
altogether), it would be far preferable and would avoid potential
issues like the warning here.

Bjorn

> > > [1] https://lore.kernel.org/all/171711746953.1628941.4692125082286867825.stgit@dwillia2-xfh.jf.intel.com/
> > > [2] https://lore.kernel.org/all/20240531213150.GA610983@bhelgaas/
> > > 
> > > Cc: linux-pci@vger.kernel.org
> > > Signed-off-by: Ido Schimmel <idosch@nvidia.com>
> > > Signed-off-by: Petr Machata <petrm@nvidia.com>

