Return-Path: <linux-pci+bounces-8546-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5805890258B
	for <lists+linux-pci@lfdr.de>; Mon, 10 Jun 2024 17:26:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F38C1C217A6
	for <lists+linux-pci@lfdr.de>; Mon, 10 Jun 2024 15:26:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E504E14E2FA;
	Mon, 10 Jun 2024 15:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o+q7mSUP"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0AFC14E2EF
	for <linux-pci@vger.kernel.org>; Mon, 10 Jun 2024 15:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718032836; cv=none; b=nQC6da9M/3yIVwd5+TcsmPvOnNqgYro5BHibjDQxgzFPh77MS7hQzpUS3/3OXyZQ5RW2ssdvXXdNA9692d79p7nh/aptIP9qkBpffMz+RrQpBLHFZ2XTTTkMQ3lfSvOXbtugGMMnn8QJAmNZpEJYzQGI9gJ1z9TnkftpQaLMpU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718032836; c=relaxed/simple;
	bh=H1gqH7Ir38kno9os44sB3RU3bEy4jn0JZDszmPY07AE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=qz3CEW45FVOZGvGSWXzfDTBmjfOcvZFrn9ZSB1iq5KwQnXGxe0PYBpWbxlvPx3LNgGdWcJIEUkWJAE9XrbC6NjJrmWE68uUctDfH8onRYXohnAyVZmal6rydrRXNflSEIkB3CnW9QgypfIalCqJ7fynAqyOATn5iXhBGLoAJ5PU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o+q7mSUP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 260D8C2BBFC;
	Mon, 10 Jun 2024 15:20:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718032836;
	bh=H1gqH7Ir38kno9os44sB3RU3bEy4jn0JZDszmPY07AE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=o+q7mSUPz05Uup2xV2g/bHUxvx1+bEVWfXyabJrwTmx0fI3Ecfn53EbZEaCQkBkx6
	 eFHuBElP2Vk/kloYb9F+tEZ06e3FqiEfOqmI3QTmQrtdi3Piy91MVINNdL1IEFzcls
	 e2b2VjebwjEWdk8Z8c2km/a1nUKNxy5GfY8ayr+22v7OT/XsJj6IfhKNwpWjE+zJzh
	 +SOL/JoyMDKKFRvRpALTaPU4hu98qLCBfr8Ykg8DKQGCIfDos3Bn2cLuE0dYBvZtE7
	 0zSTquCwwjFvs0H1KIwDlBHmFh+NfyHZmmSTr/pRIp4YF1sIvrddNCKDawPI6xQLVw
	 QTkCg4UCtjBjg==
Date: Mon, 10 Jun 2024 10:20:34 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org, geoff@hostfission.com
Subject: Re: [PATCH] PCI: Release unused bridge resources during resize
Message-ID: <20240610152034.GA943788@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240607170156.3e59f580.alex.williamson@redhat.com>

On Fri, Jun 07, 2024 at 05:01:56PM -0600, Alex Williamson wrote:
> On Fri, 7 Jun 2024 17:33:20 -0500
> Bjorn Helgaas <helgaas@kernel.org> wrote:
> 
> > On Tue, May 07, 2024 at 03:31:23PM -0600, Alex Williamson wrote:
> > > Resizing BARs can be blocked when a device in the bridge hierarchy
> > > itself consumes resources from the resized range.  This scenario is
> > > common with Intel Arc DG2 GPUs where the following is a typical
> > > topology:
> > > 
> > >  +-[0000:5d]-+-00.0-[5e-61]----00.0-[5f-61]--+-01.0-[60]----00.0  Intel Corporation DG2 [Arc A380]
> > >                                              \-04.0-[61]----00.0  Intel Corporation DG2 Audio Controller
> ...

> > > pci 0000:60:00.0: BAR 2 [mem 0xbfe0000000-0xbfefffffff 64bit pref]: releasing
> > > pcieport 0000:5f:01.0: bridge window [mem 0xbfe0000000-0xbfefffffff 64bit pref]: releasing
> > > pci 0000:5e:00.0: bridge window [mem 0xbfe0000000-0xbfefffffff 64bit pref]: releasing
> > > pci 0000:5e:00.0: BAR 0 [mem 0xbff0000000-0xbff07fffff 64bit pref]: releasing
> > > pcieport 0000:5d:00.0: bridge window [mem 0xbfe0000000-0xbff07fffff 64bit pref]: releasing
> > > pcieport 0000:5d:00.0: bridge window [mem 0xb000000000-0xb2ffffffff 64bit pref]: assigned
> > > pci 0000:5e:00.0: bridge window [mem 0xb000000000-0xb1ffffffff 64bit pref]: assigned
> > > pci 0000:5e:00.0: BAR 0 [mem 0xb200000000-0xb2007fffff 64bit pref]: assigned

It didn't occur to me before, but don't we have a potential issue here
because we relocated 5e:00.0 BAR 0 from 0xbff0000000 to 0xb200000000
without notifying any code that might be using it?

I'm worried about vendor-specific perf/EDAC/etc drivers that can't
claim the the bridge using pci_register_driver() because the pcieport
driver is in the way.  I think some of those drivers go behind the
back of the driver model to locate their device and ioremap the BAR
direction.

Bjorn

