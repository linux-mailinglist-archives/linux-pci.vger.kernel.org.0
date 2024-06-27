Return-Path: <linux-pci+bounces-9379-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4994791AA02
	for <lists+linux-pci@lfdr.de>; Thu, 27 Jun 2024 16:55:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 768101C23FF7
	for <lists+linux-pci@lfdr.de>; Thu, 27 Jun 2024 14:55:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 098FA195803;
	Thu, 27 Jun 2024 14:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gvcc6PrI"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA0D21514EE
	for <linux-pci@vger.kernel.org>; Thu, 27 Jun 2024 14:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719500146; cv=none; b=j8j2cOc1q9yYb2/a3Z0z53fT7sraSQcU171/fTKtaXqcF420Y2Z10+uWpeTZSr7uZ6372uByaYc6ekcWIjk6wM1hX5bk7KkvjuTQ+eGhd/HE7yaq5kxQavEEHC31LxUDk9vqzFIHAtYyeOeYP7PN1lBDDgTl+nZgSWbu1SDr96c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719500146; c=relaxed/simple;
	bh=oAJ3G/NymMd89Wzu3iXXqTRu20T+1tRy/Z2aawC8HPM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VHdsy1meUWaP0uA9X3OGyisjwO5ccPFJwCo2WLlEC1DHs922MQMNDVzgDltZTqPHrYwW+Zo50C79za0FS1ro+WRGVCuqiGeK8QqPV+ZlLat8grFzgTMblIyquI12kj9SQ6F1sQogKXN4oo/mZQ9rQQMiqYkkh0RO2w7vGqhiruk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gvcc6PrI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1F35C2BBFC;
	Thu, 27 Jun 2024 14:55:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719500146;
	bh=oAJ3G/NymMd89Wzu3iXXqTRu20T+1tRy/Z2aawC8HPM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gvcc6PrIzV8e956LSo6j1rJOg9HrFZLkw5e4XU+OtJsiKEKYTXRkmUf+VdD7tsvoN
	 RSePn6t3gwH4d8flrMPJFSqB1+5eXxVWiLOfEoB0aqaLYgw9OUfIjdaIVtNdlW41r3
	 YRphNBOQTEkgLCwO+Mqm4YH5zq5GZz31jfabGR2nahuBTMBCrH6AQk7niTKfSI3pTQ
	 EIsXmgy2MHaCkn8PHWORIQq8NECM7u+/lXaPC7bPTw3L1cSVZUFZ5zzkTyIHKR3EHC
	 MYM6RgPwS+SreG6Hn/84k8ISUoUwWcQIwIYdtnkRQ1+/0mPjyFQf1y/WZd9eyk/zci
	 c+q0+65Qp0+aA==
Date: Thu, 27 Jun 2024 08:55:43 -0600
From: Keith Busch <kbusch@kernel.org>
To: Lukas Wunner <lukas@wunner.de>
Cc: Keith Busch <kbusch@meta.com>, linux-pci@vger.kernel.org,
	bhelgaas@google.com
Subject: Re: [PATCHv2 1/2] PCI: pciehp: fix concurrent sub-tree removal
 deadlock
Message-ID: <Zn19b3oPiDF9UnPx@kbusch-mbp>
References: <20240612181625.3604512-1-kbusch@meta.com>
 <20240612181625.3604512-2-kbusch@meta.com>
 <Zn0Y-UhMqCo2PCtM@wunner.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zn0Y-UhMqCo2PCtM@wunner.de>

On Thu, Jun 27, 2024 at 09:47:05AM +0200, Lukas Wunner wrote:
> On Wed, Jun 12, 2024 at 11:16:24AM -0700, Keith Busch wrote:
> > PCIe hotplug events modify the topology in their IRQ thread once it can
> > acquire the global pci_rescan_remove_lock.
> > 
> > If a different removal event happens to acquire that lock first, and
> > that removal event is for the parent device of the bridge processing the
> > other hotplug event, then we are deadlocked: the parent removal will
> > wait indefinitely on the child's IRQ thread because the parent is
> > holding the global lock the child thread needs to make forward progress.
> 
> Yes, that's a known problem.  I submitted a fix for it in 2018:
> 
> https://lore.kernel.org/all/4c882e25194ba8282b78fe963fec8faae7cf23eb.1529173804.git.lukas@wunner.de/
> 
> The patch I proposed was similar to yours, but was smaller and
> confined to pciehp_pci.c.  It was part of a larger series and
> when respinning that series I dropped the patch, which is the
> reason it never got applied.  I explained the rationale for
> dropping it in this message:
> 
> https://lore.kernel.org/all/20180906162634.ylyp3ydwujf5wuxx@wunner.de/
> 
> Basically all these proposals (both mine and yours) are not great
> because they add another layer of duct tape without tackling the
> underlying problem -- that pci_lock_rescan_remove() is way too
> coarse-grained and needs to be replaced by finer-grained locking.
> That however is a complex task that we haven't made significant
> forward progress on in the last couple of years.  Something else
> always seemed more important.
> 
> So I don't really know what to say.  I recognize it's a problem
> but I'm hesitant to endorse a duct tape fix. :(
> 
> In the second link above I mentioned that my approach doesn't solve
> another race discovered by Xiongfeng Wang.  pciehp has been refactored
> considerably since then, so I'm not sure if that particular issue
> still exists...

Thanks for comments. I agree the current locking scheme is the real
problem here. But I would still selfishly take a duct tape solution at
this point! :) There's so many direct pci_lock_rescan_remove() users
with hardware I don't have, it may be difficult to properly test a
significant change to the locking.

The sysfs race appears to still exist today. My patch wouldn't help with
that either.

