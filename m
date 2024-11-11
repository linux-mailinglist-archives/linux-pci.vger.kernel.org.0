Return-Path: <linux-pci+bounces-16473-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C76A29C46B4
	for <lists+linux-pci@lfdr.de>; Mon, 11 Nov 2024 21:24:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F4371F26AA5
	for <lists+linux-pci@lfdr.de>; Mon, 11 Nov 2024 20:24:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1392A1A76DA;
	Mon, 11 Nov 2024 20:20:07 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout2.hostsharing.net (bmailout2.hostsharing.net [83.223.78.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC2BF199238;
	Mon, 11 Nov 2024 20:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.78.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731356407; cv=none; b=CeV5frgeuf5MqOlunf1bhwQ4zRsSSvjIMm7YCFtaaJTLC0W/f32y69r0z0yIKaEaXYWhSTIOJpFvCUuDxLecZqAY3S1yIJ2sDeqh+WC+/4ABZQOkzUbCkoWlAIhmQYu8o1pKPHo9yAqV/AuLfuNbSAagbh/wvbjsguSI3sPeWic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731356407; c=relaxed/simple;
	bh=D2ab2YM8vmaSyptZkkkHd1LRPeWi6Ng0ReSBwZvF19o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U2NdFoR9fzIvmMMbfJJxySj2LyDBDLnGz7LG1H1Y1X0W1OtC6cn1m0T2m943/88SP9I7qoKS2QkpKPngVQZSlxQZKQ17vyn0AujQwv8FQOHrQnQBHJoGMKrUREmm3hE7mKPNG8jri0lRQrbI1YXscVvK2GzuL1/F7TF9iZxY/5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.78.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout2.hostsharing.net (Postfix) with ESMTPS id C36622800B4B7;
	Mon, 11 Nov 2024 21:19:53 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 95F152B3794; Mon, 11 Nov 2024 21:19:53 +0100 (CET)
Date: Mon, 11 Nov 2024 21:19:53 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Sebastian Ott <sebott@redhat.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: lockdep warning in pciehp
Message-ID: <ZzJm6QrQyT48jGuN@wunner.de>
References: <f9f13728-ade8-c5b9-0cc3-2fb23db2f051@redhat.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f9f13728-ade8-c5b9-0cc3-2fb23db2f051@redhat.com>

On Mon, Nov 11, 2024 at 06:58:40PM +0100, Sebastian Ott wrote:
> I stumbled over this lockdep splat during pci hotplug:
> [   26.016648] ======================================================
> [   26.019646] WARNING: possible circular locking dependency detected
> [   26.022785] 6.12.0-rc6+ #176 Not tainted
> [   26.024776] ------------------------------------------------------
> [   26.027909] irq/50-pciehp/57 is trying to acquire lock:
> [   26.030559] ffff0000c02ad700 (&ctrl->reset_lock){.+.+}-{3:3}, at: pciehp_configure_device+0xe4/0x1a0
> [   26.035423] [   26.035423] but task is already holding lock:
> [   26.038505] ffff800082f819f8 (pci_rescan_remove_lock){+.+.}-{3:3}, at: pci_lock_rescan_remove+0x24/0x38
> [   26.043512] [   26.043512] which lock already depends on the new lock.
[...]
> I don't think that this could actually happen since this is only called by a
> single irq thread

Correct, it's a false positive, see this earlier analysis from Oct 2023:

https://lore.kernel.org/all/20231015093722.GA11283@wunner.de/


> but this splat is kinda annoying and
> pciehp_configure_device() doesn't seem to do much that
> needs the reset_lock. How about this?
> ---->8
> [PATCH] pciehp: fix lockdep warning
> 
> Call pciehp_configure_device() without reset_lock being held to
> fix the following lockdep warning. The only action that seems to
> require the reset_lock is writing to ctrl->dsn, so move that to
> the caller that holds the lock.

The point is to prevent a slot reset while the bus is being enumerated.
It's not just for reading the Device Serial Number.  So unfortunately
it's not that simple.

Thanks,

Lukas

