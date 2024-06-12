Return-Path: <linux-pci+bounces-8692-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DFF3905CFA
	for <lists+linux-pci@lfdr.de>; Wed, 12 Jun 2024 22:42:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 140411C2200E
	for <lists+linux-pci@lfdr.de>; Wed, 12 Jun 2024 20:42:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A573784DF4;
	Wed, 12 Jun 2024 20:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yhg4Jx7m"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E15384D39;
	Wed, 12 Jun 2024 20:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718224957; cv=none; b=Aef8EF0ILV9XuDPw4NbDM9n3Cr+RAaLFK4Vr/OzZzTRR5zexckuf3YftNjdhYjHua5Ex2BtQWNuEFwKfg9onBIsVdsNmd30TltiGleE+zWxx42kor1zyu5nzfobTsdKVDV5BNMk2DWNGcbYXvzj/htDmwy02FgabihIaP83KkPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718224957; c=relaxed/simple;
	bh=ROAG1n+s9+Sfvh8VDDnGQMJgUbbS6fHotKmxBlMQ33Y=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=AiwGzj4xudFAy6K61hXEoqPm6hnhzsl7BujX3uZQd7feAgstlGAhU3kahF5ZYR80szriOC85XKZXaui5a+Q2DBiLvgnlG31SLwbNQcXrhc6Rkr5qE+wDSnzoftmYT3yHpl2pPAKzvIaVFKPCIZYwkwz1nD7vhFuP0NE5zkRaA/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yhg4Jx7m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3D54C116B1;
	Wed, 12 Jun 2024 20:42:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718224957;
	bh=ROAG1n+s9+Sfvh8VDDnGQMJgUbbS6fHotKmxBlMQ33Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=Yhg4Jx7mXQtKoJwbeqymT+AC/jzOi5DPUWQvL+ZBMforcPV0Wld2wZfY7NMcSVP72
	 0u91JxxSnSU1u2V1l5c17bzxUy/X6hSDV8ozaaKVj6soNVAxv1Nn6wdwfZYNKQRY/+
	 kOZIXUjRnTDdBGuQOi1gsg2UpnjYl3G8BzUWhst/0JV04Qv2Dp52Z2Gx/hQ/29Iq2i
	 KA40SffByyHxxDWrmoXw6XqB8gIlV3KYO6xmt5lkF//tnyI7Ca0X9+jDZ//5DCyIJs
	 wVsQZ34h0IL8SQGbQlLbZ9vCynj6ECEUUioFyKCUTd9eKq61e8mN/KN6nU6sNCD9DA
	 oJFDFPeoJf1bw==
Date: Wed, 12 Jun 2024 15:42:35 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Philipp Stanner <pstanner@redhat.com>
Cc: Hans de Goede <hdegoede@redhat.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Sam Ravnborg <sam@ravnborg.org>, dakr@redhat.com,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH v8 03/13] PCI: Reimplement plural devres functions
Message-ID: <20240612204235.GA1037175@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ec1be501811dc2ac082ec71349bde45145749d3c.camel@redhat.com>

On Wed, Jun 12, 2024 at 10:51:40AM +0200, Philipp Stanner wrote:
> On Tue, 2024-06-11 at 16:44 -0500, Bjorn Helgaas wrote:
> > I'm trying to merge these into pci/next, but I'm having a hard time
> > writing the merge commit log.  I want a one-sentence description of
> > each patch that tells me what the benefit of the patch is.  Usually
> > the subject line is a good start.
> > 
> > "Reimplement plural devres functions" is kind of vague and doesn't
> > quite motivate this patch, and I'm having a hard time extracting the
> > relevant details from the commit log below.
> 
> I would say that the summary would be something along the lines:
> "Set ground layer for devres simplification and extension"
> 
> because this patch simplifies the existing functions and adds
> infrastructure that can later be used to deprecate the bloated existing
> functions, remove the hybrid mechanism and add pcim_iomap_range().

I think something concrete like "Add partial-BAR devres support" would
give people a hint about what to look for.

This patch contains quite a bit more than that, and if it were
possible, it might be nice to split the rest to a different patch, but
I'm not sure it's even possible and I just want to get this series out
the door.

If the commit log includes the partial-BAR idea and the specific
functions added, I think that will hold together.  And then it makes
sense for why the "plural" functions would be implemented on top of
the "singular" ones.

> > > Implement a set of singular functions 
> > 
> > What is this set of functions?  My guess is below.
> > 
> > > that use devres as it's intended and
> > > use those singular functions to reimplement the plural functions.
> > 
> > What does "as it's intended" mean?  Too nebulous to fit here.
> 
> Well, the idea behind devres is that you allocate a device resource
> _for each_ object you want to be freed / deinitialized automatically.
> One devres object per driver / subsystem object, one devres callback
> per cleanup job for the driver / subsystem.
> 
> What PCI devres did instead was to use just ONE devres object _for
> everything_ and then it had to implement all sorts of checks to check
> which sub-resource this master resource is actually about:
> 
> (from devres.c)
> static void pcim_release(struct device *gendev, void *res)
> {
> 	struct pci_dev *dev = to_pci_dev(gendev);
> 	struct pci_devres *this = res;
> 	int i;
> 
> 	for (i = 0; i < DEVICE_COUNT_RESOURCE; i++)
> 		if (this->region_mask & (1 << i))
> 			pci_release_region(dev, i);
> 
> 	if (this->mwi)
> 		pci_clear_mwi(dev);
> 
> 	if (this->restore_intx)
> 		pci_intx(dev, this->orig_intx);
> 
> 	if (this->enabled && !this->pinned)
> 		pci_disable_device(dev);
> }
> 
> 
> So one could dare to say that devres was partially re-implemented on
> top of devres.
> 
> The for-loop and the if-conditions constitute that "re-implementation".
> No one has any clue why it has been done that way, because it provides
> 0 upsides and would have been far easier to implement by just letting
> devres do its job.
> 
> Would you like to see the above details in the commit message?

No.  Just remove the "use devres as it's intended" since that's not
needed to motivate this patch.  I think we need fewer and
more-specific words.

Bjorn

