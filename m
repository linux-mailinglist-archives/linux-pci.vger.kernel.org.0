Return-Path: <linux-pci+bounces-29896-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B568ADBBAA
	for <lists+linux-pci@lfdr.de>; Mon, 16 Jun 2025 23:05:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CDEF3165E1C
	for <lists+linux-pci@lfdr.de>; Mon, 16 Jun 2025 21:05:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55D4021171B;
	Mon, 16 Jun 2025 21:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UL/gkN/S"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C1831F429C;
	Mon, 16 Jun 2025 21:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750107933; cv=none; b=leHiinfxTGWHuXW2bbwaEK8jq87lRtcO3rC1vHtVJA8YzNCnVFQQphWzOt3k9OJrhtWCud/NSxy86NIjspROcOGDnyyneqSG/B3iJNfJNhDEwzGBxBbz8Tu94vlY9gG+zBqOETyBHHGonA149rFaKgqnKl3eLAn/a563tul5Is4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750107933; c=relaxed/simple;
	bh=0W3oaKucpq4l/BVEw8nroG4LqtFe0etV3ZPi0IaCQ2U=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=XGxc4lAY4WcqmF13o3O0iUcYRKze477lKRW3H00JdwWRR8JIjWRXECga+UQgkFqn0rCIVDwNHCQKf9OyAxM0jd6ka9+U+spDo6YOEXwJIE8BlZfVCW7WEU+vkq3S0SUpDgD9J4sVgWxFISt3qDDagX7TIpPz5TSwfoyN9exgqzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UL/gkN/S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A9B0C4CEEA;
	Mon, 16 Jun 2025 21:05:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750107931;
	bh=0W3oaKucpq4l/BVEw8nroG4LqtFe0etV3ZPi0IaCQ2U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=UL/gkN/SKre6OQ5X/2Uls97pnva5BO/5/U4mQ4utL3gqDmKY/PhDB5FWFIJEFGI/3
	 pWncB5M6cmngqDJw2gTW+ZZKepwp8OnByujelWvg/LikasnF4zwAvLn/li0WJIJ2Gt
	 u4I0aRoXRJJxqqDYYjSqYvDs/S1a5qrvGoxvIwQMxYKQyDdaHnUKHrkrwhzjPytoGF
	 ekraTpUnYjyBalWCoPZ/9509yfkIj7UDA+3K+R/mDsuaQJLvUEgQMP1z+ovzWlVjcy
	 In5HGUVE/B1650hoHh6EHbgtzIKUluNUMwrMA+VIM+4IaTwBuD/VJXpw3HyfxclNEb
	 ubSMnzCQH4ZaQ==
Date: Mon, 16 Jun 2025 16:05:30 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Graham Whyte <grwhyte@linux.microsoft.com>
Cc: Christoph Hellwig <hch@infradead.org>,
	Niklas Cassel <cassel@kernel.org>, linux-pci@vger.kernel.org,
	shyamsaini@linux.microsoft.com, code@tyhicks.com, Okaya@kernel.org,
	bhelgaas@google.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/2] PCI: Reduce FLR delay to 10ms for MSFT devices
Message-ID: <20250616210530.GA1106466@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <56b926e8-4b5c-45a8-882e-7c6be0e2fd26@linux.microsoft.com>

On Mon, Jun 16, 2025 at 12:02:41PM -0700, Graham Whyte wrote:
> On 6/13/2025 8:33 AM, Bjorn Helgaas wrote:
> > On Thu, Jun 12, 2025 at 09:41:45AM -0700, Graham Whyte wrote:
> >> On 6/11/2025 11:31 PM, Christoph Hellwig wrote:
> >>> On Wed, Jun 11, 2025 at 01:08:21PM -0700, Graham Whyte wrote:
> >>>> We can ask our HW engineers to implement function readiness but we need
> >>>> to be able to support exiting products, hence why posting it as a quirk.
> >>>
> >>> Your report sounds like it works perfectly fine, it's just that you
> >>> want to reduce the delay.  For that you'll need to stick to the standard
> >>> methods instead of adding quirks, which are for buggy hardware that does
> >>> not otherwise work.
> >>
> >> Bjorn, what would you recommend as next steps here?
> > 
> > This is a tough call and I don't pretend to have an obvious answer.  I
> > understand the desire to improve performance.  On the other hand, PCI
> > has been successful over the long term because devices adhere to
> > standardized ways of doing things, which makes generic software
> > possible.  Quirks degrade that story, of course, especially when there
> > is an existing standardized solution that isn't being used.  I'm not
> > at all happy about vendors that decide against the standard solution
> > and then ask OS folks to do extra work to compensate.
> 
> Should someone want to implement readiness time reporting down the road,
> they'll need to do the same work as patch 1 in this series (making the
> flr delay a configurable parameter).

Sure.  That's a trivial change.  The problem is the quirk itself.

The Readiness Time Reporting Extended Capability is read-only with no
control bits in it so it requires no actual logic in the device.
Maybe you can just implement that capability with a firmware change on
the device and add the corresponding Linux support for it.

