Return-Path: <linux-pci+bounces-16434-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F0E09C3951
	for <lists+linux-pci@lfdr.de>; Mon, 11 Nov 2024 09:00:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E108BB20BFA
	for <lists+linux-pci@lfdr.de>; Mon, 11 Nov 2024 08:00:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67CC220B22;
	Mon, 11 Nov 2024 08:00:24 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout2.hostsharing.net (bmailout2.hostsharing.net [83.223.78.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 363B48615A
	for <linux-pci@vger.kernel.org>; Mon, 11 Nov 2024 08:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.78.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731312024; cv=none; b=BmBM9xkPmEReDeqHM9glwvphRrhGQ9LYylOMdi6ngQScu78UVz0oYCQ6Q9JBuNvsfEeA+bO2YMcDNXScBtPBYxbQ8QwvNEi10//8ovd49EF5YI3lQhS5OWvTopYTD2MwoVPVqgGZ8Sd8zkpDtg9kID/LjvKJSLg6T/9GYlIBVBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731312024; c=relaxed/simple;
	bh=ZqA7RJSwTgPGenLvVRsdN8qKbkrZjf+HzNfx6nDfdX8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xx5YG2d8s1kCkC/32rnbEQFP5K7GFZuCPuSqV4pukxUDv28b5j8jB554EjIufebeL3/iLqGtX+pJiapLiJH3No2603GV6R6MQFMniTU3Xv8fuqxmO6CaKUSwrUS1UKsHnaqBF18UVaN+0a/fZOVgXyNGawaZndQaqY4ictQbOhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.78.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout2.hostsharing.net (Postfix) with ESMTPS id 04C3728013881;
	Mon, 11 Nov 2024 09:00:19 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id E675A5CCC01; Mon, 11 Nov 2024 09:00:18 +0100 (CET)
Date: Mon, 11 Nov 2024 09:00:18 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Keith Busch <kbusch@meta.com>
Cc: linux-pci@vger.kernel.org, bhelgaas@google.com,
	Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCHv2 1/2] PCI: pciehp: fix concurrent sub-tree removal
 deadlock
Message-ID: <ZzG5koPOn16KQ8uM@wunner.de>
References: <20240612181625.3604512-1-kbusch@meta.com>
 <20240612181625.3604512-2-kbusch@meta.com>
 <Zn0Y-UhMqCo2PCtM@wunner.de>
 <ZzG0W7LGrggNa6Qi@wunner.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZzG0W7LGrggNa6Qi@wunner.de>

On Mon, Nov 11, 2024 at 08:38:03AM +0100, Lukas Wunner wrote:
> Thinking about this some more:
> 
> The problem is pci_lock_rescan_remove() is a single global lock.
> 
> What if we introduce a lock at each bridge or for each pci_bus.
> Before a portion of the hierarchy is removed, all locks in that
> sub-hierarchy are acquired bottom-up.
> 
> I think that should avoid the deadlock.  Thoughts?

I note that you attempted something similar back in July:

https://lore.kernel.org/all/20240722151936.1452299-9-kbusch@meta.com/

However I'd suggest to solve this differently:

Keep the pci_lock_rescan_remove() everywhere, don't add pci_lock_bus()
adjacent to it.

Instead, amend pci_lock_rescan_remove() to walk the sub-hierarchy
bottom-up and acquire all the bus locks.  Obviously you'll have to amend
pci_lock_rescan_remove() to accept a pci_dev which is the bridge atop
the sub-hierarchy.  (Or alternatively, the top-most pci_bus in the
sub-hierarchy.)

Thanks,

Lukas

