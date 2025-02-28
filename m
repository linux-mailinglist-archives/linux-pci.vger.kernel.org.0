Return-Path: <linux-pci+bounces-22617-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E615A491FE
	for <lists+linux-pci@lfdr.de>; Fri, 28 Feb 2025 08:14:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 21D2116F53E
	for <lists+linux-pci@lfdr.de>; Fri, 28 Feb 2025 07:14:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A9321C5F2F;
	Fri, 28 Feb 2025 07:14:16 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout2.hostsharing.net (bmailout2.hostsharing.net [83.223.78.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECCDA1C5496;
	Fri, 28 Feb 2025 07:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.78.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740726856; cv=none; b=NlwlTWKSKa22Iq6n3UvB0Z7/E/hxMLX8i0OHvDLjCdypFfbbDBI/PNzwVLZRt3rVkSwFQGEp2y6s5BmkJoO42Tx0gM5/6R7jeJ5hA3nWvZ5TjuLAYp4phQcXRt1+kaQ+uPEvZiR436yqeJDLhM4yMjK4llfaFD1ya/OyQZXIsug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740726856; c=relaxed/simple;
	bh=StuzEqVA/KF2H1BBO4p86yNKqTmdpTRhdbvVEeXDUNs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SQ/wdvvh0Lh5+BA/TuXKEs+gRyXXX+DOZgO7ee/oIVBCJC3x0OzCAb+k2s2ZQ1iHNPE9W7YdTQ1A3Ir9gHWBnrJ261QnTiVLzTaJX5Jk1CqvXg01GDY3tSUUKPQcoZlnIrTVyn6D7wW/EmGkU6pPgR79OdP4aWrq1CNR7xen4p4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.78.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout2.hostsharing.net (Postfix) with ESMTPS id 975BD280237A3;
	Fri, 28 Feb 2025 08:14:04 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 7EFEE6501C4; Fri, 28 Feb 2025 08:14:04 +0100 (CET)
Date: Fri, 28 Feb 2025 08:14:04 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Feng Tang <feng.tang@linux.alibaba.com>
Cc: rafael@kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Liguang Zhang <zhangliguang@linux.alibaba.com>,
	Guanghui Feng <guanghuifeng@linux.alibaba.com>,
	Markus Elfring <Markus.Elfring@web.de>, lkp@intel.com,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	ilpo.jarvinen@linux.intel.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/4] PCI/portdrv: Add necessary wait for disabling
 hotplug events
Message-ID: <Z8FiPOgKFTt8T0ym@wunner.de>
References: <20250224034500.23024-1-feng.tang@linux.alibaba.com>
 <20250224034500.23024-3-feng.tang@linux.alibaba.com>
 <Z7y2e-EJLijQsp8D@wunner.de>
 <Z70zyhZe6OrxNNT3@U-2FWC9VHC-2323.local>
 <Z71Ap7kpV4rfhFDU@wunner.de>
 <Z71KHDbgrPFaoPO7@U-2FWC9VHC-2323.local>
 <Z8FXyVyMyAe4_bI3@U-2FWC9VHC-2323.local>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z8FXyVyMyAe4_bI3@U-2FWC9VHC-2323.local>

On Fri, Feb 28, 2025 at 02:29:29PM +0800, Feng Tang wrote:
> On Tue, Feb 25, 2025 at 12:42:04PM +0800, Feng Tang wrote:
> > > > There might be some misunderstaning here :), I responded in
> > > > https://lore.kernel.org/lkml/Z6LRAozZm1UfgjqT@U-2FWC9VHC-2323.local/
> > > > that your suggestion could solve our issue.
> > > 
> > > Well, could you test it please?
> > 
> We just tried the patch on the hardware and initial 5.10 kernel, and
> the problem cannot be reproduced, as the first PCIe hotplug command
> of disabling CCIE and HPIE was not issued.

Good!

> Should I post a new version patch with your suggestion?

Yes, please.

> Also I would like to separate this patch from the patch dealing the
> nomsi irq storm issue. How do you think?

Makes sense to me.

The problem with the nomsi irq storm is really that if the platform
(i.e. BIOS) doesn't grant OSPM control of hotplug, OSPM (i.e. the kernel)
cannot modify hotplug registers because the assumption is that the
platform controls them.  If the platform doesn't actually handle
hotplug, but keeps the interrupts enabled, that's basically a bug
of the specific platform.

I think the kernel community's stance in such situations is that the
BIOS vendor should provide an update with a fix.  In some cases
that's not posible because the product is no longer supported,
or the vendor doesn't care about Linux issues because it only
supports Windows or macOS.  In those cases, we deal with these
problems with a quirk.  E.g. on x86 we often use a DMI quirk to
recognize affected hardware and the quirk would then disable the
hotplug interrupts.

Thanks,

Lukas

