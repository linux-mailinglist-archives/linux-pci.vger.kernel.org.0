Return-Path: <linux-pci+bounces-3873-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B443485F999
	for <lists+linux-pci@lfdr.de>; Thu, 22 Feb 2024 14:23:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AEE411C23D0C
	for <lists+linux-pci@lfdr.de>; Thu, 22 Feb 2024 13:23:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEE031332AC;
	Thu, 22 Feb 2024 13:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fitR+8tY"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEED81350D0;
	Thu, 22 Feb 2024 13:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708608174; cv=none; b=U9w4paxxfh1/OmQlkU9lqAuBbg5LlF7lKarBklvqyUEiG0ixy7PeTTTxb1FLa8QBWshxMvxPRGlY4+lMaDDCwe0H3HSWl3ds0XMWEmTf3YBRM06fywkAOujgw5F+NSOvqfJ4bETbr7dM4Jwntpm0fVp8m3jy+g4pF3ck1mNmgtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708608174; c=relaxed/simple;
	bh=XZuH5XQs3rFOSh/JkcNgos2WuaMLrOLVTKBK2NilxT0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qsQEWsCMKkuN/AfLRYq+Sugw+gqCzAOWJAebduW9sLVMpyQK+ltVWP2h88c1iVwn8ejiJsP198z67ddJT60/rZhv/hdIQ1GTM4n24RBDhGdgTy5ISlLkj1v5L+05mNvkoiJDHIJ1nDb2cM1ciIxmXGH8nCLbfRvguTTdb9HiqG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fitR+8tY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB848C433F1;
	Thu, 22 Feb 2024 13:22:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708608174;
	bh=XZuH5XQs3rFOSh/JkcNgos2WuaMLrOLVTKBK2NilxT0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fitR+8tYl2AjN+owEFanUHUQTVby3MiIbPqSFgaJQmQkYCK5oW5FpdpWAhNYl3Kd+
	 9xAE/bJKtycdQwzpxU5VG3yPDLBLK8f4Tu2rDhvQhgg38XTJP3j7jdXnpCHDdsvtH0
	 4wzahV7sllc7OLmZhRnONb+uwSatCQCI8w/LF8Fk=
Date: Thu, 22 Feb 2024 14:22:51 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Dan Williams <dan.j.williams@intel.com>
Cc: linux-coco@lists.linux.dev, linux-pci@vger.kernel.org
Subject: Re: [RFC PATCH 4/5] sysfs: Introduce a mechanism to hide static
 attribute_groups
Message-ID: <2024022227-absolute-condense-44f8@gregkh>
References: <170660662589.224441.11503798303914595072.stgit@dwillia2-xfh.jf.intel.com>
 <170660664848.224441.8152468052311375109.stgit@dwillia2-xfh.jf.intel.com>
 <2024013016-sank-idly-dd6b@gregkh>
 <65b9285a93e42_5cc6f294ac@dwillia2-mobl3.amr.corp.intel.com.notmuch>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <65b9285a93e42_5cc6f294ac@dwillia2-mobl3.amr.corp.intel.com.notmuch>

On Tue, Jan 30, 2024 at 08:48:26AM -0800, Dan Williams wrote:
> Greg KH wrote:
> > On Tue, Jan 30, 2024 at 01:24:08AM -0800, Dan Williams wrote:
> > > Add a mechanism for named attribute_groups to hide their directory at
> > > sysfs_update_group() time, or otherwise skip emitting the group
> > > directory when the group is first registered. It piggybacks on
> > > is_visible() in a similar manner as SYSFS_PREALLOC, i.e. special flags
> > > in the upper bits of the returned mode. To use it, specify a symbol
> > > prefix to DEFINE_SYSFS_GROUP_VISIBLE(), and then pass that same prefix
> > > to SYSFS_GROUP_VISIBLE() when assigning the @is_visible() callback:
> > > 
> > > 	DEFINE_SYSFS_GROUP_VISIBLE($prefix)
> > > 
> > > 	struct attribute_group $prefix_group = {
> > > 		.name = $name,
> > > 		.is_visible = SYSFS_GROUP_VISIBLE($prefix),
> > > 	};
> > > 
> > > SYSFS_GROUP_VISIBLE() expects a definition of $prefix_group_visible()
> > > and $prefix_attr_visible(), where $prefix_group_visible() just returns
> > > true / false and $prefix_attr_visible() behaves as normal.
> > > 
> > > The motivation for this capability is to centralize PCI device
> > > authentication in the PCI core with a named sysfs group while keeping
> > > that group hidden for devices and platforms that do not meet the
> > > requirements. In a PCI topology, most devices will not support
> > > authentication, a small subset will support just PCI CMA (Component
> > > Measurement and Authentication), a smaller subset will support PCI CMA +
> > > PCIe IDE (Link Integrity and Encryption), and only next generation
> > > server hosts will start to include a platform TSM (TEE Security
> > > Manager).
> > > 
> > > Without this capability the alternatives are:
> > > 
> > > * Check if all attributes are invisible and if so, hide the directory.
> > >   Beyond trouble getting this to work [1], this is an ABI change for
> > >   scenarios if userspace happens to depend on group visibility absent any
> > >   attributes. I.e. this new capability avoids regression since it does
> > >   not retroactively apply to existing cases.
> > > 
> > > * Publish an empty /sys/bus/pci/devices/$pdev/tsm/ directory for all PCI
> > >   devices (i.e. for the case when TSM platform support is present, but
> > >   device support is absent). Unfortunate that this will be a vestigial
> > >   empty directory in the vast majority of cases.
> > > 
> > > * Reintroduce usage of runtime calls to sysfs_{create,remove}_group()
> > >   in the PCI core. Bjorn has already indicated that he does not want to
> > >   see any growth of pci_sysfs_init() [2].
> > > 
> > > * Drop the named group and simulate a directory by prefixing all
> > >   TSM-related attributes with "tsm_". Unfortunate to not use the naming
> > >   capability of a sysfs group as intended.
> > > 
> > > In comparison, there is a small potential for regression if for some
> > > reason an @is_visible() callback had dependencies on how many times it
> > > was called. Additionally, it is no longer an error to update a group
> > > that does not have its directory already present, and it is no longer a
> > > WARN() to remove a group that was never visible.
> > > 
> > > Link: https://lore.kernel.org/all/2024012321-envious-procedure-4a58@gregkh/ [1]
> > > Link: https://lore.kernel.org/linux-pci/20231019200110.GA1410324@bhelgaas/ [2]
> > > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> > > ---
> > >  fs/sysfs/group.c      |   45 ++++++++++++++++++++++++++++-------
> > >  include/linux/sysfs.h |   63 ++++++++++++++++++++++++++++++++++++++++---------
> > >  2 files changed, 87 insertions(+), 21 deletions(-)
> > 
> > You beat me to this again :)
> 
> Pardon the spam, was just showing it in context of the patchset I was
> developing.
> 
> > I have tested this patch, and it looks good, I'll send out my series
> > that uses it for a different subsystem as well.
> > 
> > I guess I can take this as a static tag for others to pull from for this
> > rc development cycle?
> 
> That works for me. Thanks Greg!

This is now here for anyone else to pull from, I've put it into my
driver-core-next branch as well:


The following changes since commit b401b621758e46812da61fa58a67c3fd8d91de0d:

  Linux 6.8-rc5 (2024-02-18 12:56:25 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git tags/sysfs_hidden_attribute_groups-6.9-rc1

for you to fetch changes up to 70317fd24b419091aa0a6dc3ea3ec7bb50c37c32:

  sysfs: Introduce a mechanism to hide static attribute_groups (2024-02-20 10:20:21 +0100)

----------------------------------------------------------------
sysfs_hidden_attribute_groups persistent tag to pull from

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Dan Williams (1):
      sysfs: Introduce a mechanism to hide static attribute_groups

 fs/sysfs/group.c      | 45 ++++++++++++++++++++++++++++--------
 include/linux/sysfs.h | 63 +++++++++++++++++++++++++++++++++++++++++----------
 2 files changed, 87 insertions(+), 21 deletions(-)

