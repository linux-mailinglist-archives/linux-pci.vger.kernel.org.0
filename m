Return-Path: <linux-pci+bounces-13668-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C959598AD3E
	for <lists+linux-pci@lfdr.de>; Mon, 30 Sep 2024 21:50:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 60813B23153
	for <lists+linux-pci@lfdr.de>; Mon, 30 Sep 2024 19:50:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2A1D199234;
	Mon, 30 Sep 2024 19:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JBKzLd1J"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C92014F9D9
	for <linux-pci@vger.kernel.org>; Mon, 30 Sep 2024 19:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727725811; cv=none; b=BJO5BfW5TEgaSAdoPry7uuxj/49DsWUOufF3ADfRLaf7CdZZ9cyOC57MgwHOI8yeb2zBQaEZXpSp/EFLQ0/YTIGFSCv+QLkQm8t40FJqKIEj/EpcQUps10RevLDwfu8IeYMEYXPKkNLdyWhwllrBWlE8qchZghGP3likAPckNfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727725811; c=relaxed/simple;
	bh=9SA453tPLrQRjXTURT3F9tHPTSbY1zUIImzF4+TO3uA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=gWJZGdiwcIrBtmTlwVOzMTTYfs8CkszBblLTLGQ71pBrXTBznF4t9MJvpXXWnUZe1YXVzXeZKsgRDSJTGOnVTlxsN3MBxa7pGDbdTMMhDNV5z4GOow+NWApPonUeRnVAdrs9Km8/qjuAaIDl+sirzQ2RooLt7zCHP3rlEPeTBXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JBKzLd1J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E285BC4CEC7;
	Mon, 30 Sep 2024 19:50:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727725811;
	bh=9SA453tPLrQRjXTURT3F9tHPTSbY1zUIImzF4+TO3uA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=JBKzLd1JCuhkntJtb/uwV/yuzRABss8YWOzCSKbxtkkxbYCB9C5MaGA9lgb4RQv7Z
	 7Bcr/syxyZ/qp+uSwL1cYyINHa+krJWGKN3QEGrtxng7P3tGi8nBUDgzfs2C3ZubGY
	 V9KJ7fCkNHypLJJjU63lu+nhz+CpACrXA0cF0zpyvMdiW9BBUy1YlVlbUMdz1LDbPR
	 YophY4BVkdfypHJJZybuLkvLl++gvMeCCo5vnh8+ss4rOlfyZ8p6rHzs7LJ2CqShDu
	 wN98I29E/lj9+ioU+8+jxfLTpFS5M0zl9MtE/WILWjHwru43/g83wh2sARloglpT7K
	 iILeg3CdpAllg==
Date: Mon, 30 Sep 2024 14:50:09 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Ville =?utf-8?B?U3lyasOkbMOk?= <ville.syrjala@linux.intel.com>
Cc: intel-gfx@lists.freedesktop.org, Bjorn Helgaas <bhelgaas@google.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH 1/6] PCI/PM: Respect pci_dev->skip_bus_pm in the
 .poweroff() path
Message-ID: <20240930195009.GA188032@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZvWFxLZwRWL3DCeX@intel.com>

On Thu, Sep 26, 2024 at 07:03:16PM +0300, Ville Syrjälä wrote:
> On Wed, Sep 25, 2024 at 02:28:42PM -0500, Bjorn Helgaas wrote:
> > On Wed, Sep 25, 2024 at 05:45:21PM +0300, Ville Syrjala wrote:
> > > From: Ville Syrjälä <ville.syrjala@linux.intel.com>
> > > 
> > > On some older laptops i915 needs to leave the GPU in
> > > D0 when hibernating the system, or else the BIOS
> > > hangs somewhere. Currently that is achieved by calling
> > > pci_save_state() ahead of time, which then skips the
> > > whole pci_prepare_to_sleep() stuff.

> > If there's a general requirement to leave all devices in D0 when
> > hibernating, it would be nice to have have some documentation like an
> > ACPI spec reference.
> 
> No, IIRC the ACPI spec even says that you must (or at least
> should) put devices into D3. But the buggy BIOS on some old
> laptops keels over when you do that. Hence we need this quirk.

Can we include a reference to this part of the ACPI spec and some
details on which laptops have this issue?

I'm a little bit wary of changing the PCI core in a generic-looking
way on the basis of some unspecified buggy old BIOS.  That feels like
something we're likely to break in the future.

> > Or if this is some i915-specific thing, maybe a pointer to history
> > like a lore or bugzilla reference.
> 
> The two relevant commits I can find are:
> 
> commit 54875571bbfd ("drm/i915: apply the PCI_D0/D3 hibernation
> workaround everywhere on pre GEN6")
> commit ab3be73fa7b4 ("drm/i915: gen4: work around hang during
> hibernation")

Thanks, this feels like important history to include somewhere.

> > IIUC this is a cleanup that doesn't fix any known problem?  The
> > overall diffstat doesn't make it look like a simplification, although
> > it might certainly be cleaner somehow:
> 
> My main concern is that using pci_save_state() might cause the pci
> code to deviate from the normal path in more ways than just skipping
> the D0->D3 transition. And then we might end up constantly chasing
> after driver/pci changes in order to match its behaviour.
> 
> Not to mention that having the pci_save_state() in the driver code
> is clearly confusing a bunch of our developers.

I'm all in favor of removing pci_save_state() from drivers when
possible.  I take it that this doesn't fix a functional issue.

Bjorn

