Return-Path: <linux-pci+bounces-20835-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0A84A2B35A
	for <lists+linux-pci@lfdr.de>; Thu,  6 Feb 2025 21:25:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E92687A1511
	for <lists+linux-pci@lfdr.de>; Thu,  6 Feb 2025 20:24:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23A411A9B46;
	Thu,  6 Feb 2025 20:25:46 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout2.hostsharing.net (bmailout2.hostsharing.net [83.223.78.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B742188CB1
	for <linux-pci@vger.kernel.org>; Thu,  6 Feb 2025 20:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.78.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738873546; cv=none; b=RWdIPMAjLAbGMYNlL8vioNxnTR1rnMypXSfyPGq2zPMlzwqIgNRY0O9HgZaBdDcKrVaLpuoM56/QZ5SzR2ALDrk7Fyjt1VeHIb4OddKHQsyewXmqqM/j8BOUcJN9/ZRx2AXmGFglxds/yzP6Q1lmtzcKHzGdLURwmF9PPQiZJpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738873546; c=relaxed/simple;
	bh=yqjjZE0K6jF61WGyF9hAfsJgba5wnoVx/ByF0LeijIw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kUUejaTHWoc5/SnXE39NWwzC508CQjR7gsCiekcoeJNvjiPvkE3tnnpL1/3CXL8NcXjU5vEP4ARsx+bR9LsFd+qMwer6LtqfFhxdaaKzhnYx7HnytUN25ChOgyWzeMbRRnD8ugiGhvKqe1h0vNaWBrgBxDvAsjb7XidCVuBJ0qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.78.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout2.hostsharing.net (Postfix) with ESMTPS id 4BA182800BB57;
	Thu,  6 Feb 2025 21:25:33 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 2E0223EB816; Thu,  6 Feb 2025 21:25:33 +0100 (CET)
Date: Thu, 6 Feb 2025 21:25:33 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Karolina Stolarek <karolina.stolarek@oracle.com>
Cc: Jon Pan-Doh <pandoh@google.com>, Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org,
	Martin Petersen <martin.petersen@oracle.com>,
	Ben Fuller <ben.fuller@oracle.com>,
	Drew Walton <drewwalton@microsoft.com>,
	Anil Agrawal <anilagrawal@meta.com>,
	Tony Luck <tony.luck@intel.com>
Subject: Re: [PATCH 5/8] PCI/AER: Introduce ratelimit for AER IRQs
Message-ID: <Z6UavQr5UCDSDyMk@wunner.de>
References: <20250115074301.3514927-1-pandoh@google.com>
 <20250115074301.3514927-6-pandoh@google.com>
 <Z5SVN8tt-xtCAHph@wunner.de>
 <29d3d0c4-656a-403b-841d-e3b61bbe594d@oracle.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <29d3d0c4-656a-403b-841d-e3b61bbe594d@oracle.com>

On Thu, Feb 06, 2025 at 02:56:20PM +0100, Karolina Stolarek wrote:
> On 25/01/2025 08:39, Lukas Wunner wrote:
> > Masking errors at the register level feels overzealous,
> > in particular because it also disables logging via tracepoints.
> > 
> > Is there a concrete device that necessitates this change?
> 
> I faced issues with excessive Correctable Errors reporting with Samsung
> PM1733 NVMe (a couple of thousand errors per hour), which were still
> polluting the logs even after introducing a ratelimit

I'd suggest to add a "u32 aer_cor_mask" to "struct pci_dev" in the
"#ifdef CONFIG_PCIEAER" section.

Then add a "DECLARE_PCI_FIXUP_HEADER()" macro in drivers/pci/quirks.c
for the Samsung PM1733 which calls a new function which sets exactly the
error bits you're seeing to aer_cor_mask.  This should be #ifdef'ed to
CONFIG_PCIEAER as well.

Finally, amend aer.c to set the bits in aer_cor_mask in the
PCI_ERR_COR_MASK register on probe.


> > If there is, consider adding a quirk for this particular device
> > which masks specific errors, but doesn't affect other devices.
> 
> There were many other reports of Correctable Error floods, as signaled in
> the cover letter, so it's hard to pinpoint the specific driver that should
> mask these errors.

If a specific device frequently signals the same errors,
I think that's a bug of that device and if the vendor doesn't
provide a firmware update, quiescing the errors through a quirk
is a plausible solution.

Of course if this is widespread, it becomes a maintenance nightmare
and then the quirk approach is not a viable option.  I cannot say
whether that's the case.  So far there's a report for one specific
product (the Samsung drive) and hinting that the problem may be
widespread.  It's difficult to make a recommendation without
precise data.

Thanks,

Lukas

