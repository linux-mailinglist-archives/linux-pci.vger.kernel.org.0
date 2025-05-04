Return-Path: <linux-pci+bounces-27120-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 35692AA88CC
	for <lists+linux-pci@lfdr.de>; Sun,  4 May 2025 19:53:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58D143AB358
	for <lists+linux-pci@lfdr.de>; Sun,  4 May 2025 17:53:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1C27246769;
	Sun,  4 May 2025 17:53:35 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [83.223.95.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B1E92472AB
	for <linux-pci@vger.kernel.org>; Sun,  4 May 2025 17:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.95.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746381215; cv=none; b=Eb8DGPfbrDnuPx96Lg+eLD/40bUGF3bKeTBGzqFAAgEPQZq+Yt2Gpd921CZ5fK72yUF5Sh2F7uygZgDOnuBDBVNeUppaXew0fcHIPgNxK1NbMRPVD5IiD50+Dd98BuBhrSoGo0426idQPQdD71t2xLQtYT6sfz4Sohp+CrBjvuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746381215; c=relaxed/simple;
	bh=pniVu1P5iJy73ny5Um9OofaWz9IGs2WhrOEqq+uJ6uM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kXv/n1ouAZBAT5dl4NRcSrGFxpHXDHf3G0gS2LFG44Abmj8G22e5qRBI1giGzq5y1WDbU7rP+UdC0mcDUrE4+bfFQ0ZzBqiEteUGBSGQeJkLvSy1aa5HWfQziu00IeBkVmtdVS7GrSwgtgeSJ8j9CBgsECdqCwWpqh3sv/gbniE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.95.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout1.hostsharing.net (Postfix) with ESMTPS id 7BBD42C06843;
	Sun,  4 May 2025 19:53:17 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 6656F6FEE6; Sun,  4 May 2025 19:53:24 +0200 (CEST)
Date: Sun, 4 May 2025 19:53:24 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Moshe Shemesh <moshe@nvidia.com>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Dave Jiang <dave.jiang@intel.com>, Keith Busch <kbusch@kernel.org>,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: Fix missing update in pci_slot_unlock() after
 locking changes
Message-ID: <aBeplBA5FLjjXktu@wunner.de>
References: <1746376292-1827952-1-git-send-email-moshe@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1746376292-1827952-1-git-send-email-moshe@nvidia.com>

On Sun, May 04, 2025 at 07:31:32PM +0300, Moshe Shemesh wrote:
> The cited patch updated pci_slot_lock(), pci_slot_trylock(),
> pci_bus_lock(), and pci_bus_trylock() recursive locking, and adjusted
> pci_bus_unlock() accordingly. However, it missed updating
> pci_slot_unlock(), which may lead to attempting to unlock the
> subordinate bridge's device lock twice.
> 
> Fixes: a4e772898f8b ("PCI: Add missing bridge lock to pci_bus_lock()")
> Signed-off-by: Moshe Shemesh <moshe@nvidia.com>

Ilpo already submitted an identical patch on April 30:

https://lore.kernel.org/r/20250430083526.4276-1-ilpo.jarvinen@linux.intel.com/

