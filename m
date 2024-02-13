Return-Path: <linux-pci+bounces-3404-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CE9185357E
	for <lists+linux-pci@lfdr.de>; Tue, 13 Feb 2024 17:00:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF8041F21BCA
	for <lists+linux-pci@lfdr.de>; Tue, 13 Feb 2024 16:00:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 331985E208;
	Tue, 13 Feb 2024 15:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vENYxF3d"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BF9B5F840;
	Tue, 13 Feb 2024 15:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707839997; cv=none; b=YmbX18FDnub7k3mBz8zWGoVCSHsL9m8xtkXkaJRDUNuCCrO+okc9AyIccX3LD7nfleQEWl6ARFeeEopK+aBVZLwqoCwL8wxWFaYAzLUz+XL2nETN4uP9HItT0sWSj/7ifvfqQNShIve6je8seVEUk7yy9v0mfcPXtcNUdy3OBl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707839997; c=relaxed/simple;
	bh=IQN/0szS2m1FsfIyJtqFxZ+lzN0l5trxoCuVY6IdmG8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=WXksbVTY7LEJXrzDuEugjUKZceatQWRHuj8OmUomQr7vrz2RPTZdR0s5+XV347vWuQSb164WKZNx/g59MXs0PU2btfVrdmTLp35mmaSNoKQMaf/YEIhkpWaLrdW04gKzn6Gbxd1XSSQphGRtiRAdHEhYMcjNKbbRqsSNciU7A6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vENYxF3d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B5A3C433C7;
	Tue, 13 Feb 2024 15:59:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707839996;
	bh=IQN/0szS2m1FsfIyJtqFxZ+lzN0l5trxoCuVY6IdmG8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=vENYxF3dKmqGYVRNgRCZ2GNoFRkAzqdVDE5ytZFSSuLzz4PdksLfNMiVfJqAg5xit
	 1doqBoc6kJQjOZR3DVc75ArD5max8Ox/xTRqwDINi88CjGMjY2J7JFmppxiE7Yl4on
	 o7jXfpNhfr+0xtrwq09J5xX5tOfnzTMtGNH4851/i240HkNP051v4TIVPZSpkRlzeg
	 x6Sv62ZCGzsvRxQuOiF/3kDLP8mxagLfnNY1IGSAu47dmN5XZTHpsrKfP3X7YnqffW
	 8q0Zk45o7NXwz3uNvuS8LEuzMCcKSWBYn0n1jIHLg3kBD9Gnk+td+GghOpl5qH7ZlX
	 UrG0wbbYYb3+A==
Date: Tue, 13 Feb 2024 09:59:54 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Leon Romanovsky <leonro@nvidia.com>
Cc: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Jim Harris <jim.harris@samsung.com>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, Jason Gunthorpe <jgg@nvidia.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	Pierre =?utf-8?Q?Cr=C3=A9gut?= <pierre.cregut@orange.com>
Subject: Re: [PATCH v2 1/2] PCI/IOV: Revert "PCI/IOV: Serialize sysfs
 sriov_numvfs reads vs writes"
Message-ID: <20240213155954.GA1210633@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240213073450.GA52640@unreal>

On Tue, Feb 13, 2024 at 09:34:50AM +0200, Leon Romanovsky wrote:
> On Mon, Feb 12, 2024 at 02:27:14PM -0600, Bjorn Helgaas wrote:
> > On Sun, Feb 11, 2024 at 10:48:44AM +0200, Leon Romanovsky wrote:
> > > On Fri, Feb 09, 2024 at 07:20:28PM -0800, Kuppuswamy Sathyanarayanan wrote:
> > > > On 2/9/24 3:52 PM, Jim Harris wrote:
> > > > > If an SR-IOV enabled device is held by vfio, and the device
> > > > > is removed, vfio will hold device lock and notify userspace
> > > > > of the removal. If userspace reads the sriov_numvfs sysfs
> > > > > entry, that thread will be blocked since sriov_numvfs_show()
> > > > > also tries to acquire the device lock. If that same thread
> > > > > is responsible for releasing the device to vfio, it results
> > > > > in a deadlock.
> > > > >
> > > > > The proper way to detect a change to the num_VFs value is to
> > > > > listen for a sysfs event, not to add a device_lock() on the
> > > > > attribute _show() in the kernel.
> > 
> > The lock was not about detecting a change; Pierre did this:
> > 
> >   ip monitor dev ${DEVICE} | grep --line-buffered "^${id}:" | while read line; do \
> >     cat ${path}/device/sriov_numvfs; \
> > 
> > which I assume works by listening for sysfs events.  
> 
> It is not, "ip monitor ..." listens to netlink events emitted by
> netdev core and not sysfs events. Sysfs events are not involved in
> this case.

Thanks for correcting my hasty assumption!

> > The problem was that after the event occurred, the sriov_numvfs
> > read got a stale value (see https://bugzilla.kernel.org/show_bug.cgi?id=202991).
> 
> Yes, and it is outcome of such cross-subsytem involvement, which
> is racy by definition. Someone can come with even simpler example of why
> locking sysfs read and write is not a good idea. 
> 
> For example, let's consider the following scenario with two CPUs and
> locks on sysfs read and write:
> 
>  CPU1					CPU2
>  echo 1 > ${path}/device/sriov_numvfs
> 		 context_switch ->
>  					cat ${path}/device/sriov_numvfs
> 					lock
> 					return 0
> 					unlock
> 		context_switch <-
>  lock
>  set 1
>  unlock
> 
>  CPU1					CPU2
>  echo 1 > ${path}/device/sriov_numvfs
>  lock
>  set 1
>  unlock
> 		 context_switch ->
>  					cat ${path}/device/sriov_numvfs
> 					lock
> 					return 1
> 					unlock
> 
> So same scenario will return different values if user doesn't protect
> such case with external to the kernel lock.
> 
> But if we return back to Pierre report and if you want to provide
> completely bullet proof solution to solve cross-subsystem interaction,
> you will need to prohibit device probe till sriov_numvfs update is completed.
> However, it is overkill for something that is not a real issue.

Pierre wanted to detect the configuration change and learn the new
num_vfs, which seems like a reasonable thing to do.  Is there a way to
do both via netlink or some other mechanism?

> > So I would drop this sentence because I don't think it accurately
> > reflects the reason for 35ff867b7657.
> > 
> > > > Since you are reverting a commit that synchronizes SysFS read
> > > > /write, please add some comments about why it is not an
> > > > issue anymore.
> > > 
> > > It was never an issue, the idea that sysfs read and write should be
> > > serialized by kernel is not correct by definition. 
> > 
> > I think it *was* an issue.  The behavior Pierre observed at was
> > clearly wrong, 
> 
> I disagree with this sentence. 
> 
> > and we added 35ff867b7657 ("PCI/IOV: Serialize sysfs
> > sriov_numvfs reads vs writes") to resolve it.
> > 
> > We should try to avoid reintroducing the problem, so I think we should
> > probably squash these two patches and describe it as a deadlock fix
> > instead of dismissing 35ff867b7657 as being based on false premises.
> > 
> > It would be awesome if you had time to verify that these patches also
> > resolve the problem you saw, Pierre.
> 
> They won't resolve his problem, because he is not listening to sysfs
> events, but rely on something from netdev side.

I guess that means that if we apply this revert, the problem Pierre
reported will return.  Obviously the deadlock is more important than
the inconsistency Pierre observed, but from the user's point of view
this will look like a regression.

Maybe listening to netlink and then looking at sysfs isn't the
"correct" way to do this, but I don't want to just casually break
existing user code.  If we do contemplate doing the revert, at the
very least we should include specific details about what the user code
*should* do instead, at the level of the actual commands to use
instead of "ip monitor dev; cat ${path}/device/sriov_numvfs".

Bjorn

