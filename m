Return-Path: <linux-pci+bounces-30293-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 51F4BAE2964
	for <lists+linux-pci@lfdr.de>; Sat, 21 Jun 2025 16:05:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE35F1893D62
	for <lists+linux-pci@lfdr.de>; Sat, 21 Jun 2025 14:05:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DAE2134A8;
	Sat, 21 Jun 2025 14:05:34 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout2.hostsharing.net (bmailout2.hostsharing.net [83.223.78.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC1357482
	for <linux-pci@vger.kernel.org>; Sat, 21 Jun 2025 14:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.78.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750514734; cv=none; b=nauVqulwjtJXgtc/JHVrq9Ac2iTHGq4AOF/Rt7wib27MIM49v+U/5stcw5pGBG6buUxL/s+in6W63V/MMGmTjNDwbv5hjhFM6rvcTrP4+5xbm8uwNEAiV3YU4vXZYWDpjPpTEiTlOqDqrkwADmDVaSypabxYVfsIwu6mjhuBK5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750514734; c=relaxed/simple;
	bh=eqG8RVVbrby9TM71/kk2fZ4UV6XaCXIFbMLhZziIj4w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tB2+q3srxJf9XMQJu0YERBgiTjDtOVs3vCieZepvrt9g9GvWHVY3izgUwcioZdJiH+9Ht8gJwmyxR9qfi/54cC61ah+kKMh1HSvrOeCUijGmM63oWoWosxmqfQps/XgHrsTbJIty63WRVUjxWI43OgQsKElFX36/S5an+tOuHwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.78.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout2.hostsharing.net (Postfix) with ESMTPS id 31A862020E77;
	Sat, 21 Jun 2025 16:05:24 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 1CE0C3A4BF3; Sat, 21 Jun 2025 16:05:24 +0200 (CEST)
Date: Sat, 21 Jun 2025 16:05:24 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Ben Hutchings <ben@decadent.org.uk>
Cc: David Airlie <airlied@redhat.com>, Bjorn Helgaas <helgaas@kernel.org>,
	Joerg Roedel <joro@8bytes.org>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Andi Kleen <ak@linux.intel.com>, Ahmed Salem <x0rw3ll@gmail.com>,
	Borislav Petkov <bp@alien8.de>, dri-devel@lists.freedesktop.org,
	iommu@lists.linux.dev, linux-pci@vger.kernel.org
Subject: Re: [PATCH] agp/amd64: Bind to unsupported devices only if AGP is
 present
Message-ID: <aFa8JJaRP-FUyy6Y@wunner.de>
References: <f8ff40f35a9a5836d1371f60e85c09c5735e3c5e.1750497201.git.lukas@wunner.de>
 <b73fbb3e3f03d842f36e6ba2e6a8ad0bb4b904fd.camel@decadent.org.uk>
 <aFalrV1500saBto5@wunner.de>
 <279f63810875f2168c591aab0f30f8284d12fe02.camel@decadent.org.uk>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <279f63810875f2168c591aab0f30f8284d12fe02.camel@decadent.org.uk>

On Sat, Jun 21, 2025 at 03:51:44PM +0200, Ben Hutchings wrote:
> On Sat, 2025-06-21 at 14:29 +0200, Lukas Wunner wrote:
> > On Sat, Jun 21, 2025 at 02:07:40PM +0200, Ben Hutchings wrote:
> > > On Sat, 2025-06-21 at 11:40 +0200, Lukas Wunner wrote:
> > > > Since commit 172efbb40333 ("AGP: Try unsupported AGP chipsets on x86-64 by
> > > > default"), the AGP driver for AMD Opteron/Athlon64 CPUs attempts to bind
> > > > to any PCI device.
> > > > 
> > > > On modern CPUs exposing an AMD IOMMU, this results in a message with
> > > > KERN_CRIT severity:
> > > > 
> > > >   pci 0000:00:00.2: Resources present before probing
> > > > 
> > > > The driver used to bind only to devices exposing the AGP Capability, but
> > > > that restriction was removed by commit 6fd024893911 ("amd64-agp: Probe
> > > > unknown AGP devices the right way").
> > > 
> > > That didn't remove any restriction as the probe function still started
> > > by checking for an AGP capability.  The change I made was that the
> > > driver would actually bind to devices with the AGP capability instead of
> > > starting to use them without binding.
> > 
> > The message above would not be emitted without your change.
> > 
> > The check for the AGP capability in agp_amd64_probe() is too late
> > to prevent the message.  That's because the message is emitted
> > before ->probe() is even called.
> 
> I understand that.  But I don't feel that the explanation above
> accurately described the history here.

So please propose a more accurate explanation.

Thanks,

Lukas

