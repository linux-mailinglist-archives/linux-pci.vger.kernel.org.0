Return-Path: <linux-pci+bounces-32487-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B5696B09A8D
	for <lists+linux-pci@lfdr.de>; Fri, 18 Jul 2025 06:36:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 45E761C27410
	for <lists+linux-pci@lfdr.de>; Fri, 18 Jul 2025 04:36:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49CE717CA17;
	Fri, 18 Jul 2025 04:36:08 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [83.223.95.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9824454652;
	Fri, 18 Jul 2025 04:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.95.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752813368; cv=none; b=MJxOJfgdNhF71wOIAEDNgrEQ4jQVbqKYh7B6Gl0HFate8F+p5tWGeGkva2XAiCQtrKz6F9r916SZVdUS5D70+r1+7GvOosviNhcpE2KLREt80lYBqwSwNPVnG0uFDuBSgZK0J+lAHi4/q1YTtCU2jwvC1TCIGHv5yfK8o1EDHw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752813368; c=relaxed/simple;
	bh=OCvzMXewvZYmsB/PrwXjME0Oz26B60Zrx0g7fjev9g8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VOgzdIhkckje00ZudADO+m8DKBj1pjPr5uCvVSbwqVK6EyFAS3Qv0pUq4i1OLPfev2oDX0ls3MNlPTvnPrU7/nVCMHMz9FhFIzpY+6RVyIsE2dmTFlK86kJsdK5lXPMZQdEfqRRq560c0fXsFU7u175nleWB0apm9BRanW2YeJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.95.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout1.hostsharing.net (Postfix) with ESMTPS id 0FD6A2C00E8D;
	Fri, 18 Jul 2025 06:35:57 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id DA630435C47; Fri, 18 Jul 2025 06:35:56 +0200 (CEST)
Date: Fri, 18 Jul 2025 06:35:56 +0200
From: Lukas Wunner <lukas@wunner.de>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-kernel@vger.kernel.org, Keith Busch <kbusch@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Parav Pandit <parav@nvidia.com>, virtualization@lists.linux.dev,
	stefanha@redhat.com, alok.a.tiwari@oracle.com,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH RFC v5 1/5] pci: report surprise removal event
Message-ID: <aHnPLIe-0ScYDfej@wunner.de>
References: <cover.1752094439.git.mst@redhat.com>
 <fba3d235e38c1c6fcef2a30ed083ad9e25b20fa3.1752094439.git.mst@redhat.com>
 <aHSfeNhpocI4nmQk@wunner.de>
 <20250717091025-mutt-send-email-mst@kernel.org>
 <aHlZE18kPuHuDtTT@wunner.de>
 <20250717193122-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250717193122-mutt-send-email-mst@kernel.org>

On Thu, Jul 17, 2025 at 07:31:57PM -0400, Michael S. Tsirkin wrote:
> On Thu, Jul 17, 2025 at 10:12:03PM +0200, Lukas Wunner wrote:
> > pciehp_handle_presence_or_link_change() is called from pciehp_ist(),
> > the IRQ thread.  During safe removal the IRQ thread is busy in
> > pciehp_unconfigure_device() and waiting for the driver to unbind
> > from devices being safe-removed.
> 
> Confused. I thought safe removal happens in the userspace thread
> that wrote into sysfs?

No, the userspace thread synthesizes a DISABLE_SLOT event,
calls irq_wake_thread(), then waits for the IRQ thread to
finish handling that event.  See pciehp_sysfs_disable_slot().

Until 2018 we indeed brought down the slot in the userspace
thread, but that required locking between the workqueue fed
by the interrupt handler on the one hand and the userspace
thread on the other hand.  It was difficult to reason about
the code.

We had bug reports about slots flapping the link or presence
bits on slot bringdown that we could easily address by handling
everything in the IRQ thread, see 3943af9d01e9.  The same was
reported for slot bringup and addressed by 6c35a1ac3da6.

This wouldn't have been possible with the architecture prior
to 2018, at least not this easily.

Thanks,

Lukas

