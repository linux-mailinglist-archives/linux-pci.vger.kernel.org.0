Return-Path: <linux-pci+bounces-39133-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 421A0C00921
	for <lists+linux-pci@lfdr.de>; Thu, 23 Oct 2025 12:48:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D67164E3379
	for <lists+linux-pci@lfdr.de>; Thu, 23 Oct 2025 10:48:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49913304BB3;
	Thu, 23 Oct 2025 10:48:51 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout2.hostsharing.net (bmailout2.hostsharing.net [83.223.78.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CEAD305976;
	Thu, 23 Oct 2025 10:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.78.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761216531; cv=none; b=f4zisOxSEnfGntuC9QByn6qatQLNkgFq1ehV3vD5TeDoIxDAELULpIkLqPA8Wp5U51jyj/yalYLjmedZlFW8m/efL/A4xcLRLIZLE1qq5GVpaefokZNjDaql089W9YjS3sJVgHWKEMwvMmyfkkH8lXlFLumY5NTTUmySv75Selk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761216531; c=relaxed/simple;
	bh=VAJLIHvhq9TGk4g9+TgP+hMqcTQmsvrkNo/JZVVF4xk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MzRlwHEusnTJGjhknFOtfRhWplMeThLC1JtRfDOE0iEbx/phOLREfUZHVW6IGltcpzrroJkyyF0i67FR2cu+13zsFYsa8/O0a+23E6chWfqcNZN9BNlO2q0dWF/YKDDRoPoBv1csFH9/3wiNnfixRBDAk9zo32YPiDHYb1y14sQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.78.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout2.hostsharing.net (Postfix) with ESMTPS id D164A200C2C2;
	Thu, 23 Oct 2025 12:48:45 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id C07944A12; Thu, 23 Oct 2025 12:48:45 +0200 (CEST)
Date: Thu, 23 Oct 2025 12:48:45 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Shuai Xue <xueshuai@linux.alibaba.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, bhelgaas@google.com,
	kbusch@kernel.org, sathyanarayanan.kuppuswamy@linux.intel.com,
	mahesh@linux.ibm.com, oohall@gmail.com, Jonathan.Cameron@huawei.com,
	terry.bowman@amd.com, tianruidong@linux.alibaba.com
Subject: Re: [PATCH v6 3/5] PCI/AER: Report fatal errors of RCiEP and EP if
 link recoverd
Message-ID: <aPoIDW_Yt90VgHL8@wunner.de>
References: <20251015024159.56414-1-xueshuai@linux.alibaba.com>
 <20251015024159.56414-4-xueshuai@linux.alibaba.com>
 <aPYKe1UKKkR7qrt1@wunner.de>
 <6d7143a3-196f-49f8-8e71-a5abc81ae84b@linux.alibaba.com>
 <aPY--DJnNam9ejpT@wunner.de>
 <43390d36-147f-482c-b31a-d02c2624061f@linux.alibaba.com>
 <aPZGNP79kJO74W4J@wunner.de>
 <30fe11dd-3f21-4a61-adb0-74e39087c84c@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <30fe11dd-3f21-4a61-adb0-74e39087c84c@linux.alibaba.com>

On Mon, Oct 20, 2025 at 11:20:58PM +0800, Shuai Xue wrote:
> 2025/10/20 22:24, Lukas Wunner:
> > On Mon, Oct 20, 2025 at 10:17:10PM +0800, Shuai Xue wrote:
> > > > >     .slot_reset()
> > > > >       => pci_restore_state()
> > > > >         => pci_aer_clear_status()
> > > > 
> > > > This was added in 2015 by b07461a8e45b.  The commit claims that
> > > > the errors are stale and can be ignored.  It turns out they cannot.
> > > > 
> > > > So maybe pci_restore_state() should print information about the
> > > > errors before clearing them?
> > > 
> > > While that could work, we would lose the error severity information at
> > 
> > Wait, we've got that saved in pci_cap_saved_state, so we could restore
> > the severity register, report leftover errors, then clear those errors?
> 
> You're right that the severity register is also sticky, so we could
> retrieve error severity directly from AER registers.
> 
> However, I have concerns about implementing this approach:
[...]
> 3. Architectural consistency: As you noted earlier, "pci_restore_state()
> is only supposed to restore state, as the name implies, and not clear
> errors." Adding error reporting to this function would further violate
> this principle - we'd be making it do even more than just restore state.
> 
> Would you prefer I implement this broader change, or shall we proceed
> with the targeted helper function approach for now? The helper function
> solves the immediate problem while keeping the changes focused on the
> AER recovery path.

My opinion is that b07461a8e45b was wrong and that reported errors
should not be silently ignored.  What I'd prefer is that if
pci_restore_state() discovers unreported errors, it asks the AER driver
to report them.

We've already got a helper to do that:  aer_recover_queue()
It queues up an entry in AER's kfifo and asks AER to report it.

So far the function is only used by GHES.  GHES allocates the
aer_regs argument from ghes_estatus_pool using gen_pool_alloc().
Consequently aer_recover_work_func() uses ghes_estatus_pool_region_free()
to free the allocation.  That prevents using aer_recover_queue()
for anything else than GHES.  It would first be necessary to
refactor aer_recover_queue() + aer_recover_work_func() such that
it can cope with arbitrary allocations (e.g. kmalloc()).

Thanks,

Lukas

