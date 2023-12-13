Return-Path: <linux-pci+bounces-914-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2A63811FCA
	for <lists+linux-pci@lfdr.de>; Wed, 13 Dec 2023 21:18:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7054AB20E2B
	for <lists+linux-pci@lfdr.de>; Wed, 13 Dec 2023 20:18:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB7807E548;
	Wed, 13 Dec 2023 20:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jszcL0OB"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F71068296
	for <linux-pci@vger.kernel.org>; Wed, 13 Dec 2023 20:18:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6EDAC433C7;
	Wed, 13 Dec 2023 20:18:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702498684;
	bh=zQ1S4ZsayCVxOre3Fmlm8DSd8N9bzd0hQxmkwtpZdN8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jszcL0OBRHI2K36WF830PXaNCQhAa4NqZcfBqK6APFrSHxSmP3STXfehzPB3QMYIp
	 KhEkqChWaNgy/dNxP+klZP1Sm8HsVwStt6t2Pd0ouiCFFErNscOTXF9LCI+/fYnDox
	 BeA9M2X/v6HrVSEKWEepKOR7Q6XHdL5O2NLw/Zg8AgYauvKaphnC5eu2yE8VdlzBh0
	 B5Xir41zHvHmTTZwZnSC8+wg5T6dUULnvJjleTd0Dpae2d37s96R2qv9mfonQHUQB7
	 pgJ9Ia5WBxBu6HmsJNNconO7j2GLXqnEJ7fiTRA+82sXgBp0SAqY91UAzvE9Hj17jL
	 O4PB2IXBEjGKg==
Date: Wed, 13 Dec 2023 12:18:02 -0800
From: Keith Busch <kbusch@kernel.org>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: linux-pci@vger.kernel.org
Subject: Re: vfio memlock question
Message-ID: <ZXoRegCK_r5g9NAN@kbusch-mbp>
References: <ZXkDn-beoRjcRnjq@kbusch-mbp.dhcp.thefacebook.com>
 <20231213102313.1f3955e1.alex.williamson@redhat.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231213102313.1f3955e1.alex.williamson@redhat.com>

On Wed, Dec 13, 2023 at 10:23:13AM -0700, Alex Williamson wrote:
> On Tue, 12 Dec 2023 17:06:39 -0800
> Keith Busch <kbusch@kernel.org> wrote:
> 
> > I was examining an issue where a user process utilizing vfio is hitting
> > the RLIMIT_MEMLOCK limit during a ioctl(VFIO_IOMMU_MAP_DMA) call. The
> > amount of memory, though, should have been well below the memlock limit.
> > 
> > The test maps the same address range to multiple devices. Each time the
> > same address range is mapped to another device, the lock count is
> > increasing, creating a multiplier on the memory lock accounting, which
> > was unexpected to me.
> > 
> > Another strange thing, the /proc/PID/status shows VmLck is indeed
> > increasing toward the limit, but /proc/PID/smaps shows that nothing has
> > been locked.
> > 
> > The mlock() syscall doesn't doubly account for previously locked ranges
> > when asked to lock them again, so I was initially expecting the same
> > behavior with vfio since they subscribe to the same limit.
> > 
> > So a few initial questions:
> > 
> > Is there a reason vfio is doubly accounting for the locked pages for
> > each device they're mapped to?
> > 
> > Is the discrepency on how much memory is locked depending on which
> > source I consult expected?
> 
> Locked page accounting is at the vfio container level and those
> containers are unaware of other containers owned by the same process,
> so unfortunately this is expected.  IOMMUFD resolves this by having
> multiple IO address spaces within the same iommufd context.

Thanks for the reply! Sounds like I need to better familiarize myself
with iommufd. :)
 
> I don't know the reason smaps is not showing what you expect or if it
> should.  Thanks,

It was just unexpected, but not hugely concerning right now. Not sure if
anyone cares, but I think a process could exceed the ulimit by locking
different ranges through vfio and mlock since their accounting is done
differently.

