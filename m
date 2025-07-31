Return-Path: <linux-pci+bounces-33257-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 59776B17641
	for <lists+linux-pci@lfdr.de>; Thu, 31 Jul 2025 20:53:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 85BC5547430
	for <lists+linux-pci@lfdr.de>; Thu, 31 Jul 2025 18:53:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5D6C2472A4;
	Thu, 31 Jul 2025 18:53:50 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [83.223.95.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63AA3154425;
	Thu, 31 Jul 2025 18:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.95.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753988030; cv=none; b=GZMmyaxZHUqnq5FE5BrvHR6oe9UDxb0qT6P2iSZSd4Eauq0tSeF29Z2q+hsCXnQmBXQiuGiJYzRw6o0wv41XLrkfpeiv45QCp/f9qj6mddkNjSLymlFvrvDNWagnMMSgUUXpAbzTyPlmEBYAKnluuwj7iwREC5sv8SrBnbpS6OQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753988030; c=relaxed/simple;
	bh=N+VGUE9lLwGyq8mJrk7de6+X+V8j2YutT7HVuPVvDgY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BRJeEWKl1+RBbQ3CePJq3cwYxN0eLN8wtxK1/vUVd4qox4NWc45sKfxy9yZ9ByzOmMMHuoEvYHC6eqPNARFoorBqkuOYhkvTPK9+SIrFiZxzwohpjLFKvOgem6x6Up97EP0iLESGH0pC2q9UanaUINrUE9vQfbTQQP6X3NfUlFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.95.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout1.hostsharing.net (Postfix) with ESMTPS id 666E62C0667B;
	Thu, 31 Jul 2025 20:53:44 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 49DD01AF24; Thu, 31 Jul 2025 20:53:44 +0200 (CEST)
Date: Thu, 31 Jul 2025 20:53:44 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Gerd Bayer <gbayer@linux.ibm.com>
Cc: 18255117159@163.com, bhelgaas@google.com, helgaas@kernel.org,
	agordeev@linux.ibm.com, borntraeger@linux.ibm.com,
	ilpo.jarvinen@linux.intel.com, jingoohan1@gmail.com,
	kwilczynski@kernel.org, linux-kernel@vger.kernel.org,
	linux-s390@vger.kernel.org, linux-next@vger.kernel.org,
	linux-pci@vger.kernel.org, lpieralisi@kernel.org, mani@kernel.org,
	robh@kernel.org, schnelle@linux.ibm.com
Subject: Re: [PATCH] PCI: Fix endianness issues in pci_bus_read_config()
Message-ID: <aIu7uO4NOanxMfAO@wunner.de>
References: <4e10bea3aa91ee721bb40e9388e8f72f930908fe.camel@linux.ibm.com>
 <20250731173858.1173442-1-gbayer@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250731173858.1173442-1-gbayer@linux.ibm.com>

On Thu, Jul 31, 2025 at 07:38:58PM +0200, Gerd Bayer wrote:
> Simple pointer-casts to map byte and word reads from PCI config space
> into dwords (i.e. u32) produce unintended results on big-endian systems.
> Add the necessary adjustments under compile-time switch
> CONFIG_CPU_BIG_ENDIAN.
> 
> pci_bus_read_config() was just introduced with
> https://lore.kernel.org/all/20250716161203.83823-2-18255117159@163.com/
> 
> Signed-off-by: Gerd Bayer <gbayer@linux.ibm.com>
> ---
> Sorry to spill this endianness aware code into drivers/pci, feel free to
> suggest a cleaner approach. This has fixed the issues seen on s390 systems

PCI is little-endian.  On big-endian systems, the endianness conversion
of Config Space accesses happens transparently in the struct pci_ops
->read() and ->write() callbacks.  E.g. on s390, zpci_cfg_load() and
zpci_cfg_store() call le64_to_cpu() and cpu_to_le64(), respectively.

We do not want to mess with endianness in the PCI core, so this isn't
a proper fix IMO.

A viable approach might be to turn pci_bus_read_config() into a macro
in include/linux/pci.h which calls the byte/word/dword variant based
on sizeof(*val) or something like that.

But at this point, with the merge window already open, it's probably
better to drop the pci/capability-search topic branch from the pull
request and retry in the next cycle.

> Since this is still sitting in the a pull-request for upstream,
> I'm not sure if this warrants a Fixes: tag.

In cases like this, do include a Fixes tag but no stable designation.

Thanks,

Lukas

