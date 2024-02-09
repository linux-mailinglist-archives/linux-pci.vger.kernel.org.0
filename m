Return-Path: <linux-pci+bounces-3265-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 854FE84EE61
	for <lists+linux-pci@lfdr.de>; Fri,  9 Feb 2024 01:30:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A0661F2615D
	for <lists+linux-pci@lfdr.de>; Fri,  9 Feb 2024 00:30:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7D06EA4;
	Fri,  9 Feb 2024 00:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BE2272xX"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5DF57EB;
	Fri,  9 Feb 2024 00:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707438604; cv=none; b=SYFYMGGEBkjAJV0eA9eWmlF8yllSw9pDXDPzQLIHi85bhUiaUZB7Cm6p7loQFXsNArx1PQ9PlhyZWQBUkDeD83kv4mPI0mJGbzI81RpARcx9VvG3QcEOfKfHj7mxGxuhca48ZYLjXXXslJ0abCDOM6dGp3Im0+2h97iS7BLvLTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707438604; c=relaxed/simple;
	bh=ki+VI0cEAqIxqVlA0tJv8U8Ivrs1tQoNS0S9Sat9+w0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=pfuSlKOIB5b6pzJRfrXr2pxNMXjMpIEOYr90Lfc/AqyfYVlSEaeqMhgxLBSvkQuwTGif4bJKbzUcRv0Nu1N1e6UJxJkc3qwflCQQFnDwblg5qefkPgpP6D2CYJdJxvrw0EMlMhKJ4rQsDWrS4uNG4F9f/xPl/G/PeSLFnDvA6KY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BE2272xX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25567C433C7;
	Fri,  9 Feb 2024 00:30:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707438604;
	bh=ki+VI0cEAqIxqVlA0tJv8U8Ivrs1tQoNS0S9Sat9+w0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=BE2272xXHpzW3QF6jE9vpimJSV0JslHugs6bIEc/CVJTifZ3gpoclfNym3Yc9+CyP
	 To72flHKgKoG5cQpEA9SJX4BTw0oCvb5+Tx7FqOodAy61Qs0npHyFwF4pNocAaurZX
	 2wy0nsKbIApYjpPchq3nYLsbMFaRt53nTsHIb2pfAXbfNH9PO/FHJ6p13n3YRM406y
	 JkyJqEDXp2oU6I/6dO+nmDRb7I+Y3S/Ekfaln0kGx1KZTheoEJBr9dPmARWDfwFlZg
	 8csdqq/InaAExvpNHFnogJ4yO1fC0tw/QQakEHV7Li5kl0eBaDvNojpznXAXVakVMp
	 IVKR2GDbyUwcg==
Date: Thu, 8 Feb 2024 18:30:02 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Jim Harris <jim.harris@samsung.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Leon Romanovsky <leonro@nvidia.com>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	Pierre =?utf-8?Q?Cr=C3=A9gut?= <pierre.cregut@orange.com>
Subject: Re: [PATCH 0/2] pci/iov: avoid device_lock() when reading
 sriov_numvfs
Message-ID: <20240209003002.GA984052@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <170311143880.2826.17853753430536108145.stgit@bgt-140510-bm01.eng.stellus.in>

[+cc Pierre, author of 35ff867b7657 ("PCI/IOV: Serialize sysfs
sriov_numvfs reads vs writes")]

On Wed, Dec 20, 2023 at 10:58:12PM +0000, Jim Harris wrote:
> If SR-IOV enabled device is held by vfio, and device is removed,
> vfio will hold device lock and notify userspace of the removal. If
> userspace reads sriov_numvfs sysfs entry, that thread will be
> blocked since sriov_numvfs_show() also tries to acquire the device
> lock. If that same thread is responsible for releasing the device to
> vfio, it results in a deadlock.
>  
> One patch was proposed to add a separate mutex, specifically for
> struct pci_sriov, to synchronize access to sriov_numvfs in the sysfs
> paths (replacing use of the device_lock()). Leon instead suggested
> just reverting the commit 35ff867b765 which introduced device_lock()
> in the store path. This also led to a small fix around ordering on
> the kobject_uevent() when sriov_numvfs is updated.
> 
> Ref: https://lore.kernel.org/linux-pci/ZXJI5+f8bUelVXqu@ubuntu/ 

1) Cc author of the commit being reverted (Pierre) so he has a chance
to chime in and make sure the proposed fix works for him as well.

2) The revert commit log needs to justify the revert, not merely say
what the proper way is.  The Ref: above suggests that the current code
(pre-revert) leads to a deadlock in some cases, so the revert commit
log should detail that.

It's ideal if we never regress, not even between the revert and the
second patch, so it's possible that they should be squashed into a
single patch.  But if you keep it as two patches, it's trivial for me
to squash them if we decide that's best.

3) Follow subject line convention for drivers/pci (use "git log
--oneline drivers/pci" to learn it).

I did 1) here and could do 3) for you, but it would be better if you
could update and repost the series with 2) updated.

In the meantime you may notice that I pushed these on a
pci/virtualization just to get the 0-day bot to build test it.  I
propose to replace that branch with an updated series, since the code
changes themselves probably will stay the same.

> ---
> 
> Jim Harris (2):
>       Revert "PCI/IOV: Serialize sysfs sriov_numvfs reads vs writes"
>       pci/iov: fix kobject_uevent() ordering in sriov_enable()
> 
> 
>  drivers/pci/iov.c |   10 ++--------
>  1 file changed, 2 insertions(+), 8 deletions(-)
> 
> --

