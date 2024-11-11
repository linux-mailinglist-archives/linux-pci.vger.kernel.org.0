Return-Path: <linux-pci+bounces-16433-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DE759C3914
	for <lists+linux-pci@lfdr.de>; Mon, 11 Nov 2024 08:38:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E4A7E1F21C1B
	for <lists+linux-pci@lfdr.de>; Mon, 11 Nov 2024 07:38:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6B06152517;
	Mon, 11 Nov 2024 07:38:15 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [176.9.242.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40C24E545
	for <linux-pci@vger.kernel.org>; Mon, 11 Nov 2024 07:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=176.9.242.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731310695; cv=none; b=q2LGxC+VB/SyzrthVnOyMuiQXKXK7bvn4sJTKr4LCFXxcdrasMxFBU0gh5FTvbkId85LVhMlwDSOOWwTCkhaLWRp10mmNR8EiLwO52Z4p+DDkTCzSoHJsFKDu+/ftA4biEnUWfyW1DWiOePjE3ekQSiYcXWQ7UDx+WvqP4sL82w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731310695; c=relaxed/simple;
	bh=UO/O99ikgykQsW4GjDY/rfrWpaUQNXiSt7vW+VoYEoU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XhupDHEgIp6Gv+39mywwdTGo1u/wX8W3+7HuN4MOPB4t6bD+xQXytK11+MNVZ52y0zzt9avs9gcM9WzM+1MRFZZrBYAsDYplG7dBckmLKN69KY2QMSpvGO3skLL8YclZCzPUXxkgXvhjByJAs/NviKLiQF292pYe/pXeeVM7rZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=176.9.242.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout3.hostsharing.net (Postfix) with ESMTPS id D3290101955E1;
	Mon, 11 Nov 2024 08:38:03 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 90735DEE43; Mon, 11 Nov 2024 08:38:03 +0100 (CET)
Date: Mon, 11 Nov 2024 08:38:03 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Keith Busch <kbusch@meta.com>
Cc: linux-pci@vger.kernel.org, bhelgaas@google.com,
	Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCHv2 1/2] PCI: pciehp: fix concurrent sub-tree removal
 deadlock
Message-ID: <ZzG0W7LGrggNa6Qi@wunner.de>
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

Thinking about this some more:

The problem is pci_lock_rescan_remove() is a single global lock.

What if we introduce a lock at each bridge or for each pci_bus.
Before a portion of the hierarchy is removed, all locks in that
sub-hierarchy are acquired bottom-up.

I think that should avoid the deadlock.  Thoughts?

Thanks,

Lukas

