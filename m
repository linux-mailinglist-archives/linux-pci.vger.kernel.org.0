Return-Path: <linux-pci+bounces-6698-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A35258B3FFD
	for <lists+linux-pci@lfdr.de>; Fri, 26 Apr 2024 21:18:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 05441B2325D
	for <lists+linux-pci@lfdr.de>; Fri, 26 Apr 2024 19:18:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 303BE1170F;
	Fri, 26 Apr 2024 19:18:26 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [176.9.242.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8AC2BE4A;
	Fri, 26 Apr 2024 19:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=176.9.242.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714159106; cv=none; b=bSis19HSW+PVP5izWhiktSN2HfAIUdXWvzh5h8ysMS+8+BwPzCklP7RhFdqcC8a2vvTismMTUKOvy+1jDZiRloL32PNd5zBXBFwmlMVlh6D0fjo6aUGaZhrfCgMGxDTex8TcRHzV3CxyQt9xRt+AE6gBFlHw8UqyQ/66yB9GSkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714159106; c=relaxed/simple;
	bh=438/ZQiq5iRawfVdd1FY58I+HIjcB9icOdPfLvQJQ6M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eN5hYqBi+kyfOUwj1TTlehb6uObbdDJeuZgpK+Rimk6a3vGxVsSk4M5C3Nxz18IrxNAM1HKYFL88KFP1Dxk9OU9oFTU9URpTlBbtFPEwkKOTLuMwES35eoOUpflhaB9BU0GSvozgINKNFhlwrJ7sP32KenMxo7pZCZ1y8Lx3VRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=176.9.242.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout3.hostsharing.net (Postfix) with ESMTPS id AE71E100FC294;
	Fri, 26 Apr 2024 21:18:15 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 5EEC3AF872; Fri, 26 Apr 2024 21:18:15 +0200 (CEST)
Date: Fri, 26 Apr 2024 21:18:15 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Dan Williams <dan.j.williams@intel.com>
Cc: gregkh@linuxfoundation.org,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
	Marc Herbert <marc.herbert@intel.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-coco@lists.linux.dev, alsa-devel@alsa-project.org
Subject: Re: [PATCH 1/3] sysfs: Fix crash on empty group attributes array
Message-ID: <Ziv9984CJeQ4muZy@wunner.de>
References: <170863444851.1479840.10249410842428140526.stgit@dwillia2-xfh.jf.intel.com>
 <170863445442.1479840.1818801787239831650.stgit@dwillia2-xfh.jf.intel.com>
 <ZiYrzzk9Me1aksmE@wunner.de>
 <662beb6ad280f_db82d29458@dwillia2-xfh.jf.intel.com.notmuch>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <662beb6ad280f_db82d29458@dwillia2-xfh.jf.intel.com.notmuch>

On Fri, Apr 26, 2024 at 10:59:06AM -0700, Dan Williams wrote:
> Lukas Wunner wrote:
> > > --- a/fs/sysfs/group.c
> > > +++ b/fs/sysfs/group.c
> > > @@ -33,10 +33,10 @@ static void remove_files(struct kernfs_node *parent,
> > >  
> > >  static umode_t __first_visible(const struct attribute_group *grp, struct kobject *kobj)
> > >  {
> > > -	if (grp->attrs && grp->is_visible)
> > > +	if (grp->attrs && grp->attrs[0] && grp->is_visible)
> > >  		return grp->is_visible(kobj, grp->attrs[0], 0);
> > >  
> > > -	if (grp->bin_attrs && grp->is_bin_visible)
> > > +	if (grp->bin_attrs && grp->bin_attrs[0] && grp->is_bin_visible)
> > >  		return grp->is_bin_visible(kobj, grp->bin_attrs[0], 0);
> > >  
> > >  	return 0;
> > 
> > I'm wondering why 0 is returned by default and not SYSFS_GROUP_INVISIBLE.
> > 
> > An empty attribute list (containing just the NULL sentinel) will now
> > result in the attribute group being visible as an empty directory.
> > 
> > I thought the whole point was to hide such empty directories.
> > 
> > Was it a conscious decision to return 0?
> > Did you expect breakage if SYSFS_GROUP_INVISIBLE is returned?
> 
> Yes, the history is here:
> 
>     https://lore.kernel.org/all/YwZCPdPl2T+ndzjU@kroah.com/
> 
> ...where an initial attempt to hide empty group directories resulted in
> boot failures. The concern is that there might be user tooling that
> depends on that empty directory. So the SYSFS_GROUP_INVISIBLE behavior
> can only be enabled by explicit result from an is_visible() handler.
> 
> That way there is no regression potential for legacy cases where the
> empty directory might matter.

The problem is that no ->is_visible() or ->is_bin_visible() callback
is ever invoked for an empty attribute group.  So there is nothing
that could return SYSFS_GROUP_INVISIBLE.

It is thus impossible to hide them.

Even though an attribute group may be declared empty, attributes may
dynamically be added it to it using sysfs_add_file_to_group().

Case in point:  I'm declaring an empty attribute group named
"spdm_signatures_group" in this patch, to which attributes are
dynamically added:

https://github.com/l1k/linux/commit/ca420b22af05

Because it is impossible to hide the group, every PCI device exposes
it as an empty directory in sysfs, even if it doesn't support CMA
(PCI device authentication).

Fortunately the next patch in the series adds a single bin_attribute
"next_requester_nonce" to the attribute group.  Now I can suddenly
hide the group on devices incapable of CMA, because an
->is_bin_visible() callback is executed:

https://github.com/l1k/linux/commit/8248bc34630e

So in this case I'm able to dodge the bullet because the empty
signatures/ directory for CMA-incapable devices is only briefly
visible in the series.  Nobody will notice unless they apply
only a subset of the series.

But I want to raise awareness that the inability to hide
empty attribute groups feels awkward.

Thanks,

Lukas

