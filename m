Return-Path: <linux-pci+bounces-6513-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D1678AC8C1
	for <lists+linux-pci@lfdr.de>; Mon, 22 Apr 2024 11:21:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6EB381C20CCD
	for <lists+linux-pci@lfdr.de>; Mon, 22 Apr 2024 09:21:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A63E13A878;
	Mon, 22 Apr 2024 09:20:26 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout2.hostsharing.net (bmailout2.hostsharing.net [83.223.78.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5A00131BAE;
	Mon, 22 Apr 2024 09:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.78.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713777626; cv=none; b=bC+cl7QpBFjrIDxDPMVdEmt+2/FEMRALdM1JNChYQ4KFTVoMFqApSCaBJBlrvil1q0eTvi0V4ktPjRL35rDw3HUwRD35zGLpwc+TEHGBQHI3bSXnWfQHNZagNFGcbOQGjyX/WT+n+oBFm4J9Kkw60TjVZmbcxJ2lADwzuO0sxCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713777626; c=relaxed/simple;
	bh=T5tRASABoyAmF4/TwmiQdb4aSxJ5IjEe6kgVUHlghnY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T1J9NVUEboMegjPA5eL2FD5jIY+vGAjX97VuS6NdsiEX/P21C0H4YOLuuUn7JVByy2iFm2gYBvN14aUnT1+dRbxt9ega9DyQvSwZsVQbONTXO5m2QNYF/UUBbzZ6CIo4FzVjuLxEIiLOgQByikl4Ao9bYElQQESCaQcDG9rbysA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.78.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout2.hostsharing.net (Postfix) with ESMTPS id 2EF4A280108A8;
	Mon, 22 Apr 2024 11:20:16 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 03FB34D34A; Mon, 22 Apr 2024 11:20:15 +0200 (CEST)
Date: Mon, 22 Apr 2024 11:20:15 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Dan Williams <dan.j.williams@intel.com>
Cc: gregkh@linuxfoundation.org,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
	Marc Herbert <marc.herbert@intel.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-coco@lists.linux.dev, alsa-devel@alsa-project.org
Subject: Re: [PATCH 1/3] sysfs: Fix crash on empty group attributes array
Message-ID: <ZiYrzzk9Me1aksmE@wunner.de>
References: <170863444851.1479840.10249410842428140526.stgit@dwillia2-xfh.jf.intel.com>
 <170863445442.1479840.1818801787239831650.stgit@dwillia2-xfh.jf.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <170863445442.1479840.1818801787239831650.stgit@dwillia2-xfh.jf.intel.com>

On Thu, Feb 22, 2024 at 12:40:54PM -0800, Dan Williams wrote:
> It turns out that arch/x86/events/intel/core.c makes use of "empty"
> attributes.
> 
> 	static struct attribute *empty_attrs;
> 
> 	__init int intel_pmu_init(void)
> 	{
> 	        struct attribute **extra_skl_attr = &empty_attrs;
> 	        struct attribute **extra_attr = &empty_attrs;
> 	        struct attribute **td_attr    = &empty_attrs;
> 	        struct attribute **mem_attr   = &empty_attrs;
> 	        struct attribute **tsx_attr   = &empty_attrs;
> 		...
> 
> That breaks the assumption __first_visible() that expects that if
> grp->attrs is set then grp->attrs[0] must also be set and results in
> backtraces like:
> 
>     BUG: kernel NULL pointer dereference, address: 00rnel mode
>     #PF: error_code(0x0000) - not-present ] PREEMPT SMP NOPTI
>     CPU: 1 PID: 1 Comm: swapper/IP: 0010:exra_is_visible+0x14/0x20
>      ? exc_page_fault+0x68/0x190
>      internal_create_groups+0x42/0xa0
>      pmu_dev_alloc+0xc0/0xe0
>      perf_event_sysfs_init+0x580000000000 ]---
>     RIP: 0010:exra_is_visible+0x14/0
> 
> Check for non-empty attributes array before calling is_visible().
[...]
> --- a/fs/sysfs/group.c
> +++ b/fs/sysfs/group.c
> @@ -33,10 +33,10 @@ static void remove_files(struct kernfs_node *parent,
>  
>  static umode_t __first_visible(const struct attribute_group *grp, struct kobject *kobj)
>  {
> -	if (grp->attrs && grp->is_visible)
> +	if (grp->attrs && grp->attrs[0] && grp->is_visible)
>  		return grp->is_visible(kobj, grp->attrs[0], 0);
>  
> -	if (grp->bin_attrs && grp->is_bin_visible)
> +	if (grp->bin_attrs && grp->bin_attrs[0] && grp->is_bin_visible)
>  		return grp->is_bin_visible(kobj, grp->bin_attrs[0], 0);
>  
>  	return 0;

I'm wondering why 0 is returned by default and not SYSFS_GROUP_INVISIBLE.

An empty attribute list (containing just the NULL sentinel) will now
result in the attribute group being visible as an empty directory.

I thought the whole point was to hide such empty directories.

Was it a conscious decision to return 0?
Did you expect breakage if SYSFS_GROUP_INVISIBLE is returned?

Thanks,

Lukas

