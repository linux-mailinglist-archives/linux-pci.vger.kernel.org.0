Return-Path: <linux-pci+bounces-30206-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 97B0FAE0B3D
	for <lists+linux-pci@lfdr.de>; Thu, 19 Jun 2025 18:19:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 42F7017B57C
	for <lists+linux-pci@lfdr.de>; Thu, 19 Jun 2025 16:19:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D48EA235046;
	Thu, 19 Jun 2025 16:19:51 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [83.223.95.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA260239E7D;
	Thu, 19 Jun 2025 16:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.95.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750349991; cv=none; b=qATvF6axyKRZOWlF49t04KkXeeZEv4i+pYmyYALorJ/2P5sct83hUN5yWsJs2mbxiXfbUc/CSiyqrD/dTh4NSY7dZCsUyxjIy8YQ6ThbUlFlb1sukppbjTpsXKH62K04MPn5p+aiIMFL1yI0FLUYd+d01Wirws+kP5pMgSqFZ5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750349991; c=relaxed/simple;
	bh=EUvMuvXUhJYrW9Y8cQdOQbSD/AS5RCELa0gsBZlGw14=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YoVFl4lVYd02i5XhyPPY++LrfueEg4gpBmPNeVRKi2c1cNaQHI3a9qHI+x/qzdCqh05zqksChKbwCtlSEqQcv/BID/75JX32KfoLsdKb6KRWPX9jZigVih5lqCLBg/K6KqwZeJYsPqprRQePj5zXzKcCxTaCdvUECNAw0iIfTFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.95.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout1.hostsharing.net (Postfix) with ESMTPS id 51B602C06674;
	Thu, 19 Jun 2025 18:19:41 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 3CB193A0855; Thu, 19 Jun 2025 18:19:41 +0200 (CEST)
Date: Thu, 19 Jun 2025 18:19:41 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Raju Rangoju <Raju.Rangoju@amd.com>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, Sanath S <Sanath.S@amd.com>
Subject: Re: [PATCH] PCI: pciehp: fix circular lock dependency b/w
 pci_rescan_remove_lock and reset_lock
Message-ID: <aFQ4ncPNdmUgyw63@wunner.de>
References: <20250619154610.902892-1-Raju.Rangoju@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250619154610.902892-1-Raju.Rangoju@amd.com>

On Thu, Jun 19, 2025 at 09:16:10PM +0530, Raju Rangoju wrote:
> Resolves a circular locking dependency issue between
> pci_rescan_remove_lock() and ctrl->reset_lock() in the PCI hotplug
> subsystem, specifically in the pciehp_unconfigure_device() function.

This seems to be a false-positive because the two stacktraces are identical
but pciehp_ist() is single-threaded.  There is only ever a single instance
of pciehp_ist() running per hotplug port, so two instances running on
separate CPUs can never happen.

Previous reports of the same false-positive lockdep splat, only they
refer to pciehp_configure_device() instead of pciehp_unconfigure_device():

https://lore.kernel.org/r/20231015093722.GA11283@wunner.de/
https://lore.kernel.org/r/ZzJm6QrQyT48jGuN@wunner.de/

Thanks,

Lukas

