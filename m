Return-Path: <linux-pci+bounces-6735-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AEE8C8B45AF
	for <lists+linux-pci@lfdr.de>; Sat, 27 Apr 2024 13:06:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1892B282BC6
	for <lists+linux-pci@lfdr.de>; Sat, 27 Apr 2024 11:06:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B51134644E;
	Sat, 27 Apr 2024 11:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="oJ1I5bvG"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8344C2562E;
	Sat, 27 Apr 2024 11:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714215960; cv=none; b=Rd1MzxyS2x4MvVd3OI8wvR5S3VF5LeLwS4Y4X1QxbunJOmy7xBbTZ2ILZaqcC70273cf912qJY6ncUvS6/JAlk9l2iI8xuWFJFb7Yf+r+SZmhn11kXdLtKWxXVHBfEpo703WRmoRft5M95tAqX+U5ddPMR8JcJzkDJ2AjO8ibIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714215960; c=relaxed/simple;
	bh=3qCkGAh64a6yPFeE5dz090gLNk8Qe+mSWwXm0kPl5uM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A1FTAkaLmU7akP3sGneDjzPUGBKn0gc2LtUdrOfBDJ3qoTrnHDNihZLT4QrQakHjU8wFkVScWB7nORSZSghmNA6fMV0FAwnMv/8+zfL43aWOIH3EruseruBAIBXJIqXQ2Vlu6S/t7BLYxArCJFn95Zje4gyZi8GKsHjiSCE9S2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=oJ1I5bvG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65671C113CE;
	Sat, 27 Apr 2024 11:05:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1714215960;
	bh=3qCkGAh64a6yPFeE5dz090gLNk8Qe+mSWwXm0kPl5uM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oJ1I5bvGDvNW+MP3Bbm9kZ5YSG2e9Oly8mP+AuOrzmp1Lz28Eh+1Sd9ahYi82DY3H
	 +tNDrca1QS3LcHIPa8ixfGZyoXnh3x5a+yB7IXFhcxBrwLdB8TsvlweMnHKWx81bLr
	 kqUN1jagoriDRPdw5X6rgG0Mo7/0DB9KmYYiR4Ow=
Date: Sat, 27 Apr 2024 13:05:50 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Lukas Wunner <lukas@wunner.de>
Cc: Dan Williams <dan.j.williams@intel.com>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
	Marc Herbert <marc.herbert@intel.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-coco@lists.linux.dev, alsa-devel@alsa-project.org
Subject: Re: [PATCH 1/3] sysfs: Fix crash on empty group attributes array
Message-ID: <2024042748-campus-okay-ffff@gregkh>
References: <170863444851.1479840.10249410842428140526.stgit@dwillia2-xfh.jf.intel.com>
 <170863445442.1479840.1818801787239831650.stgit@dwillia2-xfh.jf.intel.com>
 <ZiYrzzk9Me1aksmE@wunner.de>
 <662beb6ad280f_db82d29458@dwillia2-xfh.jf.intel.com.notmuch>
 <Ziv9984CJeQ4muZy@wunner.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ziv9984CJeQ4muZy@wunner.de>

On Fri, Apr 26, 2024 at 09:18:15PM +0200, Lukas Wunner wrote:
> On Fri, Apr 26, 2024 at 10:59:06AM -0700, Dan Williams wrote:
> > Lukas Wunner wrote:
> > > > --- a/fs/sysfs/group.c
> > > > +++ b/fs/sysfs/group.c
> > > > @@ -33,10 +33,10 @@ static void remove_files(struct kernfs_node *parent,
> > > >  
> > > >  static umode_t __first_visible(const struct attribute_group *grp, struct kobject *kobj)
> > > >  {
> > > > -	if (grp->attrs && grp->is_visible)
> > > > +	if (grp->attrs && grp->attrs[0] && grp->is_visible)
> > > >  		return grp->is_visible(kobj, grp->attrs[0], 0);
> > > >  
> > > > -	if (grp->bin_attrs && grp->is_bin_visible)
> > > > +	if (grp->bin_attrs && grp->bin_attrs[0] && grp->is_bin_visible)
> > > >  		return grp->is_bin_visible(kobj, grp->bin_attrs[0], 0);
> > > >  
> > > >  	return 0;
> > > 
> > > I'm wondering why 0 is returned by default and not SYSFS_GROUP_INVISIBLE.
> > > 
> > > An empty attribute list (containing just the NULL sentinel) will now
> > > result in the attribute group being visible as an empty directory.
> > > 
> > > I thought the whole point was to hide such empty directories.
> > > 
> > > Was it a conscious decision to return 0?
> > > Did you expect breakage if SYSFS_GROUP_INVISIBLE is returned?
> > 
> > Yes, the history is here:
> > 
> >     https://lore.kernel.org/all/YwZCPdPl2T+ndzjU@kroah.com/
> > 
> > ...where an initial attempt to hide empty group directories resulted in
> > boot failures. The concern is that there might be user tooling that
> > depends on that empty directory. So the SYSFS_GROUP_INVISIBLE behavior
> > can only be enabled by explicit result from an is_visible() handler.
> > 
> > That way there is no regression potential for legacy cases where the
> > empty directory might matter.
> 
> The problem is that no ->is_visible() or ->is_bin_visible() callback
> is ever invoked for an empty attribute group.  So there is nothing
> that could return SYSFS_GROUP_INVISIBLE.
> 
> It is thus impossible to hide them.
> 
> Even though an attribute group may be declared empty, attributes may
> dynamically be added it to it using sysfs_add_file_to_group().
> 
> Case in point:  I'm declaring an empty attribute group named
> "spdm_signatures_group" in this patch, to which attributes are
> dynamically added:
> 
> https://github.com/l1k/linux/commit/ca420b22af05
> 
> Because it is impossible to hide the group, every PCI device exposes
> it as an empty directory in sysfs, even if it doesn't support CMA
> (PCI device authentication).
> 
> Fortunately the next patch in the series adds a single bin_attribute
> "next_requester_nonce" to the attribute group.  Now I can suddenly
> hide the group on devices incapable of CMA, because an
> ->is_bin_visible() callback is executed:
> 
> https://github.com/l1k/linux/commit/8248bc34630e
> 
> So in this case I'm able to dodge the bullet because the empty
> signatures/ directory for CMA-incapable devices is only briefly
> visible in the series.  Nobody will notice unless they apply
> only a subset of the series.
> 
> But I want to raise awareness that the inability to hide
> empty attribute groups feels awkward.

It does, but that's because we can't break existing systems :)

Documenting this to be more obvious would be great, I'll glady take
changes for that as I agree, the implementation is "tricky" and took me
a long time to review/understand it as well, as it is complex to deal
with (and I thank Dan for getting it all working properly, I had tried
and failed...)

thanks,

greg k-h

