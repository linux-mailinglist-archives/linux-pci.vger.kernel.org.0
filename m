Return-Path: <linux-pci+bounces-13777-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C2BF998F5A3
	for <lists+linux-pci@lfdr.de>; Thu,  3 Oct 2024 19:59:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5864EB20E4D
	for <lists+linux-pci@lfdr.de>; Thu,  3 Oct 2024 17:59:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D938E1A76CA;
	Thu,  3 Oct 2024 17:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mu4mVvzY"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B36E81A7274
	for <linux-pci@vger.kernel.org>; Thu,  3 Oct 2024 17:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727978380; cv=none; b=abQWqwXAxOKh3aNUo7NthY1Obp477Xs7wmvk6qjmb8cucH5y1z2N4ZSWP2hVIgu/qmRMB0wOSXAbzBoGe2ClK8DT6xKwZXkQg55t7Sm57VHjAMEJVTb04Mrf+euMSZRfZMJ/ZNf1YhOqn9wiefUC5UX0LhpZIn8pFhSB3auXYNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727978380; c=relaxed/simple;
	bh=bILHip/fH9uVCtmD4Z6LxxkbDiQBpqP4fbmDBHcivNE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N44fhfiDROtuAfhzjhs/eT2cCZQ8zQ0atdJhoT6gGEZyYgaJ0MKn5dLj2AP3i1xawBcNC2YwsnZfmmn7yPVeNItWlMNMTOcxMeSIxNQuVM3iOhzNyCE7+wfsxv7Pbuxxup22w0TKEB+SnryfqOjFhxeWfI44cP4W6lV1q52gzpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mu4mVvzY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4FF7C4CECC;
	Thu,  3 Oct 2024 17:59:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727978380;
	bh=bILHip/fH9uVCtmD4Z6LxxkbDiQBpqP4fbmDBHcivNE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mu4mVvzYRpF1If8vstA58ZvJOtbYCwQmnod2RBLCdZ6tNEQhqi7B5iLGjyooTqSiA
	 KbJODfNynuzy11QyifKJZ4k0byzgWvLBXBAA1fBffyjqQN7dkYop/v0FWwdr3rp4dK
	 Gse/6mRQKD4L9cKJgttdiGmlwUIER4gKSc0b+WZE4+IZRIvWGfDC7zIgWFmUOVZnoS
	 JvKF3bhh9SEujIkus9nY8M1bvUuxcJ1hRGxfyfvoine/aGj4mY+bPQcUy8t0jo3CJh
	 7f06ODH0/3LFdSv54Z/5MuCewYJcDfaLv521XsTKBvECA2qS/KBsfTwV2qH/8EVERL
	 3XtdrK5uPVfOw==
Date: Thu, 3 Oct 2024 11:59:37 -0600
From: Keith Busch <kbusch@kernel.org>
To: Davidlohr Bueso <dave@stgolabs.net>
Cc: Keith Busch <kbusch@meta.com>, linux-pci@vger.kernel.org,
	bhelgaas@google.com, Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCHv2 2/5] pci: make pci_destroy_dev concurrent safe
Message-ID: <Zv7bifNNSJXXJgAn@kbusch-mbp>
References: <20240827192826.710031-1-kbusch@meta.com>
 <20240827192826.710031-3-kbusch@meta.com>
 <20241003023354.txfw7w4ud247h5va@offworld>
 <Zv6wG5qF74J237w2@kbusch-mbp>
 <20241003170416.kfbdpd7xkneh5sgc@offworld>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241003170416.kfbdpd7xkneh5sgc@offworld>

On Thu, Oct 03, 2024 at 10:04:16AM -0700, Davidlohr Bueso wrote:
> Well the thing is it is crashing on me, as reported. I was able to reproduce
> the deadlock with rescan_remove_lock on a switched CXL topology (via sysfs
> remove/rescan parent/child). This is why I tested your full pci-bus-locking-2024-09-09
> branch hoping the last patch would fix it, but still cannot confirm because
> of that nil ptr deref.

You might need something different than anything in that series if you
are doing concurrent sysfs access during removal. This is what I wrote
up for that issue:

  https://lore.kernel.org/linux-pci/20240719185513.3376321-1-kbusch@meta.com/T/#u

The last reply from GregKH was against this proposal, but I briefly
spoke with him a couple weeks ago and I think he may accept this if I
resubmit.

