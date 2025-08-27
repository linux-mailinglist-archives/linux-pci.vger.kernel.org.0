Return-Path: <linux-pci+bounces-34940-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12D3BB38A7E
	for <lists+linux-pci@lfdr.de>; Wed, 27 Aug 2025 21:51:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3A1F3AE5BF
	for <lists+linux-pci@lfdr.de>; Wed, 27 Aug 2025 19:51:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB1EE2F0C78;
	Wed, 27 Aug 2025 19:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ReEA9Zq0"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F58A2F0C68;
	Wed, 27 Aug 2025 19:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756324291; cv=none; b=aSCTBp/aGDFq5yq9r1h/9xEj9f3z8MtuAtFPhtrTllpgPfJNczUbc1hEZB5fZBbrsIwo/swhHI3aBtJ/In88m52HZqs6Lo/oxX++tBVzh6KA9IiMNDMwii5zkNfCTjfqKMs/XLy2qGSdhvua7qsm+OM2ySWs8UgaEie8t9CfLtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756324291; c=relaxed/simple;
	bh=82UQhmrO9VqhrHSeeXILn7KguxmPjIRuFSlL2METmeU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=iDmS5kOG342N3eLIOMMsL9WkM9O+bw3jEaSUNRu7v9hmoL2ylYqwdZI9bFUDZU9x2duta8Ge6UWiyeSiiXVYBvD6XHLYBfkK9VOrm/WUVvWi4E2kCboTS1SmXgNPnvNHgOb+LoPMVyGzde2sd18Nn2ZaEhZtvYBWPAaAmchW2Xg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ReEA9Zq0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D37A8C4CEEB;
	Wed, 27 Aug 2025 19:51:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756324291;
	bh=82UQhmrO9VqhrHSeeXILn7KguxmPjIRuFSlL2METmeU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=ReEA9Zq0Smzl/tR6X+fDiY+pBpWtoFzbZr1nfb1oZG4/+EmVMCd0G3WyGmYIK4nqc
	 7nTrHMJWX+X3HvE++wluC81vgLGj/qJvrPE5MlnuBUNnnoC31GThxaxIMXp9HS44Py
	 mNmky4320th2VrLIuiTmEqvzA+M0pKvg/2Wpidim6vYVvu0eg0e6sgkU5/xqPH1HXx
	 Q2GS+MGpAfl9Ohb9VnlGFM+dDA+gjP5wYGjxP7gMat5wPBTojJvAA9BsaRNcNzpuqB
	 qZrq0Jdwjoaun1PfljnL1a/vMx/Cm479mTM1epNynST9NbkpHUlLQqIh08QzfsazZh
	 z1EGRTdYirA/Q==
Date: Wed, 27 Aug 2025 14:51:29 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Cc: Alex Deucher <alexander.deucher@amd.com>,
	Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	D Scott Phillips <scott@os.amperecomputing.com>,
	Rio Liu <rio@r26.me>, Tudor Ambarus <tudor.ambarus@linaro.org>,
	Markus Elfring <Markus.Elfring@web.de>,
	LKML <linux-kernel@vger.kernel.org>, stable@vger.kernel.org
Subject: Re: [PATCH v3 3/3] PCI: Fix failure detection during resource resize
Message-ID: <20250827195129.GA898951@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a821c043-a07f-5727-938a-c32a7efb671a@linux.intel.com>

On Tue, Aug 26, 2025 at 03:51:25PM +0300, Ilpo Järvinen wrote:
> Adding Alex & Christian as they might be able to shed light on the amdgpu 
> side, but I think the problem still starts from 
> pci_reassign_bridge_resources().
> 
> On Mon, 25 Aug 2025, Bjorn Helgaas wrote:
> > On Fri, Aug 22, 2025 at 03:33:59PM +0300, Ilpo Järvinen wrote:
> > > Since the commit 96336ec70264 ("PCI: Perform reset_resource() and build
> > > fail list in sync") the failed list is always built and returned to let
> > > the caller decide what to do with the failures. The caller may want to
> > > retry resource fitting and assignment and before that can happen, the
> > > resources should be restored to their original state (a reset
> > > effectively clears the struct resource), which requires returning them
> > > on the failed list so that the original state remains stored in the
> > > associated struct pci_dev_resource.
> > > 
> > > Resource resizing is different from the ordinary resource fitting and
> > > assignment in that it only considers part of the resources. This means
> > > failures for other resource types are not relevant at all and should be
> > > ignored. As resize doesn't unassign such unrelated resources, those
> > > resource ending up into the failed list implies assignment of that
> > > resource must have failed before resize too. The check in
> > > pci_reassign_bridge_resources() to decide if the whole assignment is
> > > successful, however, is based on list emptiness which will cause false
> > > negatives when the failed list has resources with an unrelated type.
> > > 
> > > If the failed list is not empty, call pci_required_resource_failed()
> > > and extend it to be able to filter on specific resource types too (if
> > > provided).
> > > 
> > > Calling pci_required_resource_failed() at this point is slightly
> > > problematic because the resource itself is reset when the failed list
> > > is constructed in __assign_resources_sorted(). As a result,
> > > pci_resource_is_optional() does not have access to the original
> > > resource flags. This could be worked around by restoring and
> > > re-reseting the resource around the call to pci_resource_is_optional(),
> > > however, it shouldn't cause issue as resource resizing is meant for
> > > 64-bit prefetchable resources according to Christian König (see the
> > > Link which unfortunately doesn't point directly to Christian's reply
> > > because lore didn't store that email at all).
> > > 
> > > Fixes: 96336ec70264 ("PCI: Perform reset_resource() and build fail list in sync")
> > > Link: https://lore.kernel.org/all/c5d1b5d8-8669-5572-75a7-0b480f581ac1@linux.intel.com/
> > > Reported-by: D Scott Phillips <scott@os.amperecomputing.com>
> > > Closes: https://lore.kernel.org/all/86plf0lgit.fsf@scott-ph-mail.amperecomputing.com/
> > 
> > I'm trying to connect this fix with the Asynchronous SError Interrupt
> > crash that Scott reported here.  From the call trace:
> > 
> >   ...
> >   arm64_serror_panic+0x6c/0x90
> >   do_serror+0x58/0x60
> >   el1h_64_error_handler+0x38/0x60
> >   el1h_64_error+0x84/0x88
> >   _raw_spin_lock_irqsave+0x34/0xb0 (P)
> >   amdgpu_ih_process+0xf0/0x150 [amdgpu]
> >   amdgpu_irq_handler+0x34/0xa0 [amdgpu]
> >   __handle_irq_event_percpu+0x60/0x248
> >   handle_irq_event+0x4c/0xc0
> >   handle_fasteoi_irq+0xa0/0x1c8
> >   handle_irq_desc+0x3c/0x68
> >   generic_handle_domain_irq+0x24/0x40
> >   __gic_handle_irq_from_irqson.isra.0+0x15c/0x260
> >   gic_handle_irq+0x28/0x80
> >   call_on_irq_stack+0x24/0x30
> >   do_interrupt_handler+0x88/0xa0
> >   el1_interrupt+0x44/0xd0
> >   el1h_64_irq_handler+0x18/0x28
> >   el1h_64_irq+0x84/0x88
> >   amdgpu_device_rreg.part.0+0x4c/0x190 [amdgpu] (P)
> >   amdgpu_device_rreg+0x24/0x40 [amdgpu]
> > 
> > I guess something happened in amdgpu_device_rreg() that caused an
> > interrupt, maybe a bogus virtual address for a register?
> ...

> > And then amdgpu_ih_process() did something that caused the SError?  Or
> > since it seems to be asynchronous, maybe the amdgpu_ih_process()
> > connection is coincidental and the SError was a consequence of
> > something else?
> > 
> > I'd like to have a bread crumb here in the commit log that connects
> > this fix with something a user might see, but I don't know what that
> > would look like.
> 
> I'm sorry I don't know the answer, the amdgpu code is too unfamiliar 
> territory, maybe Alex or Christian has some idea and can pinpoint us to 
> what to look at.

Do we know what the PCIe controller is here?  Is there a public
datasheet for it?

I've seen other issues that make me wonder if some controllers work
like this:

  - PCIe error occurs on read or write transaction

  - PCIe write dropped or read completed by the controller
    synthesizing ~0 data to CPU

  - PCIe controller signals Asynchronous SError as a result of the
    error

But I guess even if the above happens, I can't explain why the PCIe
error would occur in the first place.  Scott didn't mention anything
like an FLR.  But maybe if we actually got as far as programming
something bogus in a BAR, a read might get no response (or two
responses).

I would assume there should be something logged in the AER Capability,
but I don't think we've looked at that yet.  The AER interrupt is also
asynchronous, so not surprising that this panic could happen before
handling it.

Bjorn

