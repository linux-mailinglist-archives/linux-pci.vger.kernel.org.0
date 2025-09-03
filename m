Return-Path: <linux-pci+bounces-35394-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 58C6FB426A2
	for <lists+linux-pci@lfdr.de>; Wed,  3 Sep 2025 18:20:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB4991BA5872
	for <lists+linux-pci@lfdr.de>; Wed,  3 Sep 2025 16:20:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70F2D2C0F7A;
	Wed,  3 Sep 2025 16:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AUYWc7rV"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D4C52C0F63
	for <linux-pci@vger.kernel.org>; Wed,  3 Sep 2025 16:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756916370; cv=none; b=eTdoK/CL9E7Tpr+9A2e6OqDpEmgTKsbK2fPovQOf2YH4RijEX2gVLS4KEXNwPky2iG59UX84fZ1Asrcz3fneplCtUoqmfziSbs8v+U6GkKIJG95yW+ETZuHeEANe8cHkVn+oFcbe7f9zLMufgeSTbom7bbLltrelNweyPLYH2Hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756916370; c=relaxed/simple;
	bh=b8Mo/ybkdZO5CdV6tnrnTeqgFF1wt8BFYu6BkCI3GMc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PI5zamthBuwAsNcS22Wdfv2xxsM1WoTgxLjgL0GChVmCS73hdP0ACB3vAJeGMQgKxYzhdbbaYfzcN0gBaiXelnSvtFt4eFNWX3xygF4YDTrTSf3BG2vs472C84eCeG4znvRrT6lC9LWjiklUAT/a+YeeeoJ99pZF9Mkdh94s57E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AUYWc7rV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFB60C4CEE7;
	Wed,  3 Sep 2025 16:19:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756916369;
	bh=b8Mo/ybkdZO5CdV6tnrnTeqgFF1wt8BFYu6BkCI3GMc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AUYWc7rVKp06qYj3GwQe849qqiBgag3F3gDUVCqRcasGSAQ0EjnqTsX3bj8D3guOY
	 U37dskMjKFOeStxOBv00+jJ5S2Ca0wtdVSVUvQquySQCJ9OXiE5VYvfMWLTZLVmwPf
	 uueZ9Ki/2VYWSbhH1M+gTNge6rr/pgh0cSVuEnbFFFIL+hk1lzex/76cBHS55fgWsE
	 ZCShtsQGbUrE4nyTaO1d6hFTFcnsEOEcpha3CpjMhnYL5A3kM/VE1bXCPSzpUx7PLx
	 782J4RofvYLgIs778omh3Ccz/kBuzedfFGPGWUx77A3zYCHEsRTOZoykAFWTPmUC8V
	 r0uVUni/0CJzg==
Date: Wed, 3 Sep 2025 10:19:28 -0600
From: Keith Busch <kbusch@kernel.org>
To: Lukas Wunner <lukas@wunner.de>
Cc: Keith Busch <kbusch@meta.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH] pciehp: sync interrupts for bus resets
Message-ID: <aLhqkO8Uaohghm97@kbusch-mbp>
References: <20250827224514.3162098-1-kbusch@meta.com>
 <aLRRh_4YhAZjWeEW@wunner.de>
 <aLcwb0TA0rMtu2kI@kbusch-mbp>
 <aLf6jkqAYkM3GBvt@wunner.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aLf6jkqAYkM3GBvt@wunner.de>

On Wed, Sep 03, 2025 at 10:21:34AM +0200, Lukas Wunner wrote:
> On Tue, Sep 02, 2025 at 11:59:11AM -0600, Keith Busch wrote:
> > Hm, I think you're right. We are definitely seeing pciehp requeue itself
> > with the link/presence events that we want to be ignored, so we're
> > getting re-enumeration when we didn't expect it. I thought the
> > back-to-back resets that we're causing vfio to initiate was the problem,
> > but maybe not. I think the switch and/or end device we're using have
> > some unusual link timings that defeats the pciehp ignore logic.
> 
> pci_bridge_secondary_bus_reset() calls pci_bridge_wait_for_secondary_bus()
> to await Link Up.  So unless the link flaps afterwards, this should be
> fine.
> 
> Another possibility is that the pciehp_device_replaced() check triggers,
> e.g. because the Endpoint's Device Serial Number or other data in Config
> Space changed after the second reset.

That can happen because we're using switches that insert a fake
"placeholder" device when a link is down.
 
> Maybe you can instrument the code with a few printk()'s to see what's
> going on.

But it looks like we're more frequently seeing the link not active.
Here's the existing messages printed:


[ 7904.749658] vfio-pci 0000:05:00.0: disabling bus mastering
[ 7904.756595] vfio-pci 0000:05:00.0: reset via bus
[ 7904.759975] pcieport 0000:02:02.0: waiting 100 ms for downstream link, after activation
[ 7905.908987] vfio-pci 0000:05:00.0: ready 0ms after bus reset
[ 7905.909003] pcieport 0000:02:02.0: pciehp: Slot(314): Link Down/Up ignored
[ 7906.847973] vfio-pci 0000:05:00.0: resetting
[ 7906.856312] vfio-pci 0000:05:00.0: reset via bus
[ 7906.862967] pcieport 0000:02:02.0: waiting 100 ms for downstream link, after activation
[ 7909.915925] pcieport 0000:02:02.0: Data Link Layer Link Active not set in 100 msec
[ 7909.915953] pcieport 0000:02:02.0: pciehp: Slot(314): Link Down/Up ignored
[ 7909.915977] pcieport 0000:02:02.0: pciehp: Slot(314): Link Down
[ 7909.915978] pcieport 0000:02:02.0: pciehp: Slot(314): Card not present
[ 7909.918934] pcieport 0000:02:02.0: waiting 100 ms for downstream link, after activation
[ 7911.923899] vfio-pci 0000:05:00.0: disconnected; not waiting
[ 7911.923905] vfio-pci 0000:05:00.0: bus failed with -25

