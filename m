Return-Path: <linux-pci+bounces-10811-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A544F93CA2F
	for <lists+linux-pci@lfdr.de>; Thu, 25 Jul 2024 23:29:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6092F283023
	for <lists+linux-pci@lfdr.de>; Thu, 25 Jul 2024 21:29:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85F7113D601;
	Thu, 25 Jul 2024 21:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I7uSG0EQ"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 558215C8FC;
	Thu, 25 Jul 2024 21:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721942957; cv=none; b=uCiYQejkKDeNFwGrnC6E5rgZVdv0Vcfsp0AFhMgvOoujLtBildh27yLBwnBDro71RPyXyRCcd7hRvWRjKUBZx/U129F2MOSVL8ZjcHkXz8H6tiz1qc64u9cHN931IuBrRAmBs10ayJSoA6+kY62T90CHVx84EGnivFygQxHMldY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721942957; c=relaxed/simple;
	bh=lnN5uNt25R6rIIaIjMOOnVgIMOYI1FYNCbwGHt7UT+Y=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=FLZ7wM27uWFpC6J4NnxqjfV7Q2W0zLtp5nFAcVp2dHNjFKHzqmj5jM37XvyayrkUWgUqZAQCwLDLoLVgRhla8f5m/Kj/9LN7HnQ0hAfshnEUHLyExMQb8jOEVZRd5m4y108fW5CjcprmV+vAokZdQ8ARHQV6Mh94MP+N5+fJ9YU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I7uSG0EQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 999D0C116B1;
	Thu, 25 Jul 2024 21:29:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721942956;
	bh=lnN5uNt25R6rIIaIjMOOnVgIMOYI1FYNCbwGHt7UT+Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=I7uSG0EQKSCpqnl8k630y+G2a/d+iURlIhmmLhzu5a12ewKrdwMpdyAWqYfCPjlZx
	 C5pFEjRpNNHjOmFpyF9hJGWNtcLWMd3G3c/4/r/CCUFV6oiyNVBv9bJEDZe9WtSoZ1
	 AeXaGs03fedb7Zx2BVuHvYTkNMT/yS4GMDOXsJeWumnsoZJVO4BoIwF7tvCkxYtpQi
	 TsPHWrgb4zpkYveRsySqJ9mdoBgojGr9OA3iqIekQ/e+lpQFiQkTEiSRsT5qGqkPde
	 OYndUBteZH7p9W6PExNJcy767hejpsRouA+QwhvE3wd6ZLbPS8w+MhpKB7mxWlSsp4
	 rR3fe24a/uC4A==
Date: Thu, 25 Jul 2024 16:29:15 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Wei Huang <wei.huang2@amd.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, netdev@vger.kernel.org,
	Jonathan.Cameron@huawei.com, corbet@lwn.net, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	alex.williamson@redhat.com, gospo@broadcom.com,
	michael.chan@broadcom.com, ajit.khaparde@broadcom.com,
	somnath.kotur@broadcom.com, andrew.gospodarek@broadcom.com,
	manoj.panicker2@amd.com, Eric.VanTassell@amd.com,
	vadim.fedorenko@linux.dev, horms@kernel.org, bagasdotme@gmail.com,
	bhelgaas@google.com
Subject: Re: [PATCH V3 03/10] PCI/TPH: Add pci=notph to prevent use of TPH
Message-ID: <20240725212915.GA860294@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <28b953c3-ef66-4bd2-a024-ec860399ffbf@amd.com>

On Wed, Jul 24, 2024 at 03:05:59PM -0500, Wei Huang wrote:
> 
> 
> On 7/23/24 17:41, Bjorn Helgaas wrote:
> > On Wed, Jul 17, 2024 at 03:55:04PM -0500, Wei Huang wrote:
> >> TLP headers with incorrect steering tags (e.g. caused by buggy driver)
> >> can potentially cause issues when the system hardware consumes the tags.
> > 
> > Hmm.  What kind of issues?  Crash?  Data corruption?  Poor
> > performance?
> 
> Not crash or functionality errors. Usually it is QoS related because of
> resource competition. AMD has

Looks like you had more to say here?

I *assume* that both the PH hint and the Steering Tags are only
*hints* and there's no excuse for hardware to corrupt anything (e.g.,
by omitting cache maintenance) even if the hint turns out to be wrong.
If that's the case, I assume "can potentially cause issues" really
just means "might lead to lower performance".  That's what I want to
clarify and confirm.

> >> Provide a kernel option, with related helper functions, to completely
> >> prevent TPH from being enabled.
> > 
> > Also would be nice to have a hint about the difference between "notph"
> > and "nostmode".  Maybe that goes in the "nostmode" patch?  I'm not
> > super clear on all the differences here.
> 
> I can combine them. Here is the combination and it meaning based on TPH
> Control Register values:
> 
> Requestor Enable | ST Mode | Meaning
> ---------------------------------------------------------------
> 00               | xx      | TPH disabled (i.e. notph)
> 01               | 00      | TPH enabled, NO ST Mode (i.e. nostmode)
> 01 or 11         | 01      | Interrupt Vector mode
> 01 or 11         | 10      | Device specific mode
> 
> If you have any other thoughts on how to approach these modes, please
> let me know.

IIRC, there's no interface in this series that reall does anything
with TPH per se; drivers would only use the ST-related things.

If that's the case, maybe "pci=notph" isn't needed yet.

Bjorn

