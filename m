Return-Path: <linux-pci+bounces-35364-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 318C1B41849
	for <lists+linux-pci@lfdr.de>; Wed,  3 Sep 2025 10:22:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D08431BA3AE0
	for <lists+linux-pci@lfdr.de>; Wed,  3 Sep 2025 08:22:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEC0F2E7631;
	Wed,  3 Sep 2025 08:21:43 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [83.223.95.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 806642EAB73
	for <linux-pci@vger.kernel.org>; Wed,  3 Sep 2025 08:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.95.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756887703; cv=none; b=bP/R7rYZYwqJYN4keaxAt6oPQV24ju42kMTfRpQj/xucQ64HKteQ1x8omSQZ8m3GLdmXnsCvPuFd9IH1OplEE6UhP4ShDnR6FjKPj1M7TgSo1qIOTNsvHyZqPAekCSn5RdDY4WUma/CIgq0kkRJ7G0u4BvuFsyo1TBB+OxR/mJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756887703; c=relaxed/simple;
	bh=AMqpeFkQSXX7APuN6GdRTr+0NKId9OwkJUHtgIzCfEI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jyAgiDoG6YkuLo16fe83rNBQcdfK56rBsleh48w+XRZ88rCM6JS0ng7JsgPOmctKAn0D85wICn2dMs4ptyiwZDd8R5/fJ9XF35EwKR9cv23cr0AMKZubHQLwLFJOjOqej5lZ3ySK+xad70XSZ8mufLF6UxvmU2Cb35jS3wVZGTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.95.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout1.hostsharing.net (Postfix) with ESMTPS id 7BD6C2C06654;
	Wed,  3 Sep 2025 10:21:34 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 73A3854C7B; Wed,  3 Sep 2025 10:21:34 +0200 (CEST)
Date: Wed, 3 Sep 2025 10:21:34 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Keith Busch <kbusch@kernel.org>
Cc: Keith Busch <kbusch@meta.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH] pciehp: sync interrupts for bus resets
Message-ID: <aLf6jkqAYkM3GBvt@wunner.de>
References: <20250827224514.3162098-1-kbusch@meta.com>
 <aLRRh_4YhAZjWeEW@wunner.de>
 <aLcwb0TA0rMtu2kI@kbusch-mbp>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aLcwb0TA0rMtu2kI@kbusch-mbp>

On Tue, Sep 02, 2025 at 11:59:11AM -0600, Keith Busch wrote:
> Hm, I think you're right. We are definitely seeing pciehp requeue itself
> with the link/presence events that we want to be ignored, so we're
> getting re-enumeration when we didn't expect it. I thought the
> back-to-back resets that we're causing vfio to initiate was the problem,
> but maybe not. I think the switch and/or end device we're using have
> some unusual link timings that defeats the pciehp ignore logic.

pci_bridge_secondary_bus_reset() calls pci_bridge_wait_for_secondary_bus()
to await Link Up.  So unless the link flaps afterwards, this should be
fine.

Another possibility is that the pciehp_device_replaced() check triggers,
e.g. because the Endpoint's Device Serial Number or other data in Config
Space changed after the second reset.

Maybe you can instrument the code with a few printk()'s to see what's
going on.

Thanks,

Lukas

