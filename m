Return-Path: <linux-pci+bounces-9350-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3646391A0C1
	for <lists+linux-pci@lfdr.de>; Thu, 27 Jun 2024 09:47:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E29DF2828EF
	for <lists+linux-pci@lfdr.de>; Thu, 27 Jun 2024 07:47:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2657836134;
	Thu, 27 Jun 2024 07:47:17 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [83.223.95.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7B5F6D1A8
	for <linux-pci@vger.kernel.org>; Thu, 27 Jun 2024 07:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.95.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719474437; cv=none; b=fSfopA000I8MUHR7z8oZepIgehCL5f27oPEFjhZAY9A+1M2rvRPjt65+mkcSHE9GnoO6vh1ClVkVmG7NczUy1I0X1bItlPxDxB9YF+rKypQNccf3t2paE3ptAupZ8xM1uCnkubM3BscEof737NIVVQH2b063S82zsJ8DbSOhF14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719474437; c=relaxed/simple;
	bh=dqUHvzjKpmjpcHZ4Rt7LIoCJfhyRwmYSVQoQTmBSo68=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hdlq/TNarKyxCj1ZOYnTYG1qtxk2i5mfHkO9S7g0l5nGMIEbxZ4bu03vYLJZMfGj+FkSGUS2nw+Qs+liuDHcmBwVsTA3rCcG7TzFFSWlkX++M66bOFhH/ePvZrJoaEi+JVD6gFMcmEF6EPltN3AEKK7PnxMATcyhUAh1HuEJC1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.95.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout1.hostsharing.net (Postfix) with ESMTPS id 9858E3000A463;
	Thu, 27 Jun 2024 09:47:05 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 7ABF517C6AA; Thu, 27 Jun 2024 09:47:05 +0200 (CEST)
Date: Thu, 27 Jun 2024 09:47:05 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Keith Busch <kbusch@meta.com>
Cc: linux-pci@vger.kernel.org, bhelgaas@google.com,
	Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCHv2 1/2] PCI: pciehp: fix concurrent sub-tree removal
 deadlock
Message-ID: <Zn0Y-UhMqCo2PCtM@wunner.de>
References: <20240612181625.3604512-1-kbusch@meta.com>
 <20240612181625.3604512-2-kbusch@meta.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240612181625.3604512-2-kbusch@meta.com>

On Wed, Jun 12, 2024 at 11:16:24AM -0700, Keith Busch wrote:
> PCIe hotplug events modify the topology in their IRQ thread once it can
> acquire the global pci_rescan_remove_lock.
> 
> If a different removal event happens to acquire that lock first, and
> that removal event is for the parent device of the bridge processing the
> other hotplug event, then we are deadlocked: the parent removal will
> wait indefinitely on the child's IRQ thread because the parent is
> holding the global lock the child thread needs to make forward progress.

Yes, that's a known problem.  I submitted a fix for it in 2018:

https://lore.kernel.org/all/4c882e25194ba8282b78fe963fec8faae7cf23eb.1529173804.git.lukas@wunner.de/

The patch I proposed was similar to yours, but was smaller and
confined to pciehp_pci.c.  It was part of a larger series and
when respinning that series I dropped the patch, which is the
reason it never got applied.  I explained the rationale for
dropping it in this message:

https://lore.kernel.org/all/20180906162634.ylyp3ydwujf5wuxx@wunner.de/

Basically all these proposals (both mine and yours) are not great
because they add another layer of duct tape without tackling the
underlying problem -- that pci_lock_rescan_remove() is way too
coarse-grained and needs to be replaced by finer-grained locking.
That however is a complex task that we haven't made significant
forward progress on in the last couple of years.  Something else
always seemed more important.

So I don't really know what to say.  I recognize it's a problem
but I'm hesitant to endorse a duct tape fix. :(

In the second link above I mentioned that my approach doesn't solve
another race discovered by Xiongfeng Wang.  pciehp has been refactored
considerably since then, so I'm not sure if that particular issue
still exists...

Thanks,

Lukas

