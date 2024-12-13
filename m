Return-Path: <linux-pci+bounces-18364-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ED249F084A
	for <lists+linux-pci@lfdr.de>; Fri, 13 Dec 2024 10:43:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9AC2B188BF2B
	for <lists+linux-pci@lfdr.de>; Fri, 13 Dec 2024 09:43:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6002619CD08;
	Fri, 13 Dec 2024 09:43:19 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout2.hostsharing.net (bmailout2.hostsharing.net [83.223.78.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFA3E18FDDF
	for <linux-pci@vger.kernel.org>; Fri, 13 Dec 2024 09:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.78.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734082999; cv=none; b=N9Q45IN+5xxkZPsjqnGAYok8MnETkP9Zxkd1PDAxpWkKC40KlxPOL2Xxd7M8STkg2640u3d05fPrs3JpzWHahtJ0HcF6DnRtyFGWvP/gPx2ChOjIS385fwBIsJ0verbAVFX1p12slCctPYfTWSGmYe3m+nAhK9GkAbT2bZcnJjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734082999; c=relaxed/simple;
	bh=6V6yQpo1xVEwDuMeeyPoH1NaHsKY/c17dicrXil+38E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f4ACr2vRl4tZmRnjuGPJIVqRah815PAIr7FrgmLmOzrxJ1v+R8T7FZaZYJKc82EP6SQ7mwHXi/LrknXGBEMCUpRkzAkTsA8C5YTqh/1vYWA8i7Jfw8q2FWTFAax+kjp4BZSrYIgOHkmUdRE5mK95UHk3JbLHhPyQiQ1nOWFAeQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.78.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout2.hostsharing.net (Postfix) with ESMTPS id C54D72800B1AC;
	Fri, 13 Dec 2024 10:43:14 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id B31444ADD5; Fri, 13 Dec 2024 10:43:14 +0100 (CET)
Date: Fri, 13 Dec 2024 10:43:14 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Niklas Schnelle <niks@kernel.org>
Cc: Niklas Schnelle <schnelle@linux.ibm.com>,
	Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
	Ilpo Jarvinen <ilpo.jarvinen@linux.intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	"Maciej W. Rozycki" <macro@orcam.me.uk>
Subject: Re: [PATCH for-linus] PCI: Honor Max Link Speed when determining
 supported speeds
Message-ID: <Z1wBshMqWp9Ea8gN@wunner.de>
References: <20241212161103.GA3345227@bhelgaas>
 <efafe0d864af49d2f496fc6543f619958630869f.camel@linux.ibm.com>
 <0b01d64fa7f6f62d49f39447c5175b44a1011fd5.camel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0b01d64fa7f6f62d49f39447c5175b44a1011fd5.camel@kernel.org>

On Thu, Dec 12, 2024 at 08:40:07PM +0100, Niklas Schnelle wrote:
> > > On Thu, Dec 12, 2024 at 09:56:16AM +0100, Lukas Wunner wrote:
> > > > The Supported Link Speeds Vector in the Link Capabilities 2 Register
> > > > indicates the *supported* link speeds.  The Max Link Speed field in
> > > > the Link Capabilities Register indicates the *maximum* of those speeds.
> > > > 
> > > > Niklas reports that the Intel JHL7540 "Titan Ridge 2018" Thunderbolt
> > > > controller supports 2.5-8 GT/s speeds, but indicates 2.5 GT/s as maximum.
> > > > Ilpo recalls seeing this inconsistency on more devices.
> > > > 
> > > > pcie_get_supported_speeds() neglects to honor the Max Link Speed field
> > > > and will thus incorrectly deem higher speeds as supported.  Fix it.
> 
> Ok, gave this a test and as somewhat suspected this patch alone doesn't
> fix my boot hang nor do I get more output (also tried Lukas suggestion
> with early_printk).

Hm, that's kind of a bummer because while we know how to work around
your boot hang (by disabling bwctrl altogether), we don't really know
the root cause.

The bwctrl IRQ handler runs in hardirq context, so if it ends up in an
infinite loop for some reason or keeps waiting for a spinlock, that
might indeed cause a boot hang.  Not that I'm seeing in the code where
that might occur.  Nevertheless you can try adding "threadirqs" to the
kernel command line to force all IRQ handlers into threads.
Alternatively, enable CONFIG_PREEMPT_RT to also turn spinlocks into
sleeping locks.  Maybe this turns the boot hang into a hung task splat
and thus helps identify the root cause.

Thanks,

Lukas

