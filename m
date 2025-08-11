Return-Path: <linux-pci+bounces-33806-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C22FCB218F0
	for <lists+linux-pci@lfdr.de>; Tue, 12 Aug 2025 01:04:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EDA651907880
	for <lists+linux-pci@lfdr.de>; Mon, 11 Aug 2025 23:05:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14804224B01;
	Mon, 11 Aug 2025 23:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rLOSb5gl"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4CC72153C1
	for <linux-pci@vger.kernel.org>; Mon, 11 Aug 2025 23:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754953488; cv=none; b=MgwpvHamIcwiB9t+CBNhCkJ0786zreYJgtQVRCk0Fjq+mHhfX+GuO4TWcdUe6B/sR9cLp3h8+wOmyrOiiAJMTBAV7uBugWjBI29Ywvat+yGvFnlqxdKUhG38Ud8L4Dr8FoJvi5FrYpuT2mHrkGlqaj+lZNr0IqZWii5P4r9Awjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754953488; c=relaxed/simple;
	bh=Xz1BXAk+n2fZc9AO1iQhgIfGEa9CsiWGTwnfgaApFlk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=krCYRZhu9hRE7GpR+1kaO5Hw6MtCvDj0ADAo9aBwqA4Mc/AgSN9XCbwyH67Sb8ddIGN89sgy/CjyQJ+659q12R8jorq3Qr68LR9sC6KG+p4OWA4PpiEIzi72hhTIs1mcPCSqzjSUXJZdPwJfRFCXYrPgC/O7XKl5saNvWAR6w7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rLOSb5gl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F417C4CEED;
	Mon, 11 Aug 2025 23:04:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754953487;
	bh=Xz1BXAk+n2fZc9AO1iQhgIfGEa9CsiWGTwnfgaApFlk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=rLOSb5gl8JeLuMF5QLAbp7xgmAVO+0g3R4SKbCngB6DkXun8TkhX3uEiIcfqASFTz
	 K20xWhKntoWMmYkr4slEl3ipcL1LAh1WRaxPwBX1dMw/SSDouBBda+Oj5VIhfIv2Oo
	 Se1Ts7h42guJ3CHiMpcc4fhL3yN1968S7ndGGB7NfZiX+CGEgin91qWkOYieC+FppA
	 wf8KkvlyZiILo8TqXMmxDZmFHF5USDkL6AyBNZJbz3jlxRuG/gBuuhyj/TaqNU9GOZ
	 0q6WCiMOJw2jeDYCaTr1MVeCkzUgt5kx5JitGzVxRsR2nBcubdkX1/2uD50vGjARFs
	 2UIv6JsLhmEfg==
Date: Mon, 11 Aug 2025 18:04:45 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Hui Wang <hui.wang@canonical.com>
Cc: linux-pci@vger.kernel.org, bhelgaas@google.com,
	raphael.norwitz@nutanix.com, alay.shah@nutanix.com,
	suresh.gumpula@nutanix.com, ilpo.jarvinen@linux.intel.com,
	Nirmal Patel <nirmal.patel@linux.intel.com>,
	Jonathan Derrick <jonathan.derrick@linux.dev>,
	Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>,
	Ville =?utf-8?B?U3lyasOkbMOk?= <ville.syrjala@linux.intel.com>
Subject: Re: [PATCH] PCI: Disable RRS polling for Intel SSDPE2KX020T8 nvme
Message-ID: <20250811230445.GA168752@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <16f95861-6e71-49e4-b8f5-6d874e7db700@canonical.com>

On Fri, Aug 08, 2025 at 10:23:45AM +0800, Hui Wang wrote:
> Hi Bjorn,
> 
> Any progress on this issue, do we have a fix for this now? The
> ubuntu users are waiting for a fix :-).

Not yet, but thanks for the reminder.  Keep bugging me!

PCIe r7.0, sec 2.3.1, makes it clear that devices are permitted to
return RRS after FLR:

  ◦ For Configuration Requests only, if Device Readiness Status is not
    supported, following reset it is permitted for a Function to
    terminate the request and indicate that it is temporarily unable
    to process the Request, but will be able to process the Request in
    the future - in this case, the Request Retry Status (RRS)
    Completion Status must be used (see § Section 6.6). Valid reset
    conditions after which a device/Function is permitted to return
    RRS in response to a Configuration Request are:

    ▪ FLRs

    ...

But I am a little bit concerned because sec 2.3.2, which talks about
how a Root Complex handles that RRS and the RRS Software Visiblity
feature, says (note the "system reset" period):

  Root Complex handling of a Completion with Request Retry Status for
  a Configuration Request is implementation specific, except for the
  period following SYSTEM RESET (see § Section 6.6). For Root
  Complexes that support Configuration RRS Software Visibility, the
  following rules apply:

    ◦ If Configuration RRS Software Visibility is enabled:

      ▪ For a Configuration Read Request that includes both bytes of
	the Vendor ID field of a device Function's Configuration Space
	Header, the Root Complex must complete the Request to the host
	by returning a read-data value of 0001h for the Vendor ID
	field and all 1's for any additional bytes included in the
	request.

So I'm worried that the Software Visibility feature might work after
*system reset*, but not necessarily after an FLR.  That might make
sense because I don't think the RC can tell when we are doing an FLR
to a device.

It seems that after FLR, most RCs *do* make RRS visible via SV.  But
if we can't rely on that, I don't know how we're supposed to learn
when a device becomes ready.

Bjorn

> On 7/3/25 08:05, Hui Wang wrote:
> > On 7/2/25 17:43, Hui Wang wrote:
> > > On 7/2/25 07:23, Bjorn Helgaas wrote:
> > > > On Tue, Jun 24, 2025 at 08:58:57AM +0800, Hui Wang wrote:
> > > > > Sorry for late response, I was OOO the past week.
> > > > > 
> > > > > This is the log after applied your patch:
> > > > > https://bugs.launchpad.net/ubuntu/+source/linux/+bug/2111521/comments/61
> > > > > 
> > > > > Looks like the "retry" makes the nvme work.
> > > >
> > > > Thank you!  It seems like we get 0xffffffff (probably PCIe
> > > > error) for a long time after we think the device should be
> > > > able to respond with RRS.
> > > > 
> > > > I always thought the spec required that after the delays, a
> > > > device should respond with RRS if it's not ready, but now I
> > > > guess I'm not 100% sure.  Maybe it's allowed to just do
> > > > nothing, which would lead to the Root Port timing out and
> > > > logging an Unsupported Request error.
> > > > 
> > > > Can I trouble you to try the patch below?  I think we might
> > > > have to start explicitly checking for that error.  That
> > > > probably would require some setup to enable the error, check
> > > > for it, and clear it.  I hacked in some of that here, but
> > > > ultimately some of it should go elsewhere.
> ...

