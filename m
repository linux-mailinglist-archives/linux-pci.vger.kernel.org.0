Return-Path: <linux-pci+bounces-35197-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BED7B3D3B7
	for <lists+linux-pci@lfdr.de>; Sun, 31 Aug 2025 15:43:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EEF861899004
	for <lists+linux-pci@lfdr.de>; Sun, 31 Aug 2025 13:44:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17FE12144CF;
	Sun, 31 Aug 2025 13:43:48 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout2.hostsharing.net (bmailout2.hostsharing.net [83.223.78.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F194D1D6AA
	for <linux-pci@vger.kernel.org>; Sun, 31 Aug 2025 13:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.78.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756647828; cv=none; b=n4dMV54DTzZgxn5LBdXuHMHXUoV4yMoorJKaUDtXY4KElpLsk1jngT9gybHh+re8xUpXQRfEmRcJ19s/er/FS1Hf50YA6IkxvKoBx/UJWnr02RNX46aEieT5Chn6H24Qx2tzkSgIRxsTH49NlWVREa1y+bxHekundFXTpupKlb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756647828; c=relaxed/simple;
	bh=8L/eQK6LS+QIySnxRZ4qS7iUmHeFu80S7wgbp1wm690=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T+AvVoRtF5WaTUcI4M6cYggrArmFIqtkqtGBvB7AitNiKQSS8MeBIsgg3KQS2xLm2omPwrl/e0a3oYbuS7Sw9zcgYLFoVeE852T8JsOHngbmMpEfaLglaHYbCoAlSa/SFUUKFAksWTHP/acNADpNJN/xwR9rRCPGsoQyEO7NVCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.78.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout2.hostsharing.net (Postfix) with ESMTPS id A84F7201D1B7;
	Sun, 31 Aug 2025 15:43:35 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 9D18954C6B; Sun, 31 Aug 2025 15:43:35 +0200 (CEST)
Date: Sun, 31 Aug 2025 15:43:35 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Keith Busch <kbusch@meta.com>
Cc: linux-pci@vger.kernel.org, Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH] pciehp: sync interrupts for bus resets
Message-ID: <aLRRh_4YhAZjWeEW@wunner.de>
References: <20250827224514.3162098-1-kbusch@meta.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250827224514.3162098-1-kbusch@meta.com>

On Wed, Aug 27, 2025 at 03:45:14PM -0700, Keith Busch wrote:
> Synchronize the interrupt to ensure the reset isn't going to disrupt a
> previously pending handler from igoring the reset's link flap. Back to
> back secondary bus resets create a window when the previous reset
> proceeds with DLLLA, waking the pending pciehp interrupt thread, but the
> subsequent reset tears it down while the irq thread tries to confirm the
> link is active, triggering unexpected re-enumeration.

Help me understand this:

I think what you mean is that pciehp_reset_slot() runs and the
Secondary Bus Reset causes a spurious link change. So pciehp_ist() runs,
waits for the reset to finish with pci_hp_spurious_link_change(),
then calls pciehp_ignore_link_change(), which tests whether the link
is active again by calling pciehp_check_link_active().

And you're saying that at the same time, pciehp_reset_slot() runs,
performs a Secondary Bus Reset, thus brings down the link,
confusing the concurrent pciehp_check_link_active().
Did I understand that correctly?

I don't quite see how this can happen, given pciehp_reset_slot()
acquires ctrl->reset_lock for writing and the same lock is held
for reading for the call to pciehp_check_link_active().

Moreover pciehp_ist() ignores the link flap in the first iteration
(it clears the flags in the local variable "events") and if
pciehp_check_link_active() would indeed fail, then the bits would
only be set in ctrl->pending_events and a rerun of pciehp_ist()
would be triggered.  That second iteration of pciehp_ist() would
then find the PCI_LINK_CHANGED flag set and ignore the link change
(again).

So this should all work fine.

> +++ b/drivers/pci/hotplug/pciehp_hpc.c
> @@ -946,6 +946,7 @@ int pciehp_reset_slot(struct hotplug_slot *hotplug_slot, bool probe)
>  
>  	down_write_nested(&ctrl->reset_lock, ctrl->depth);
>  
> +	synchronize_irq(ctrl->pcie->irq);
>  	pci_hp_ignore_link_change(pdev);
>  
>  	rc = pci_bridge_secondary_bus_reset(ctrl->pcie->port);

This will deadlock because it waits for pciehp_ist() to finish
but pciehp_ist() may wait for ctrl->reset_lock, which is held here.

Thanks,

Lukas

