Return-Path: <linux-pci+bounces-32089-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E6A7B04931
	for <lists+linux-pci@lfdr.de>; Mon, 14 Jul 2025 23:14:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 22B4F7A1868
	for <lists+linux-pci@lfdr.de>; Mon, 14 Jul 2025 21:12:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FFC625BEE6;
	Mon, 14 Jul 2025 21:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f30IaH/z"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2530584A35;
	Mon, 14 Jul 2025 21:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752527633; cv=none; b=ishoDlRPbsWDSnQSPPifvpkt+m0dLAT7GEIGLnz805M981eQfNbkJiMhuIN2MsXsVP53h9xZxv9FpFlUctDjkYqm0sC414O8U8VlxhIJruy2ym0ESdOpAanK0i+ed++AyiU6tE+KvhaxWgPOuI91iTVd8JVvCezGoRGK80wQU3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752527633; c=relaxed/simple;
	bh=RH5VCLwAWlWBmOSsR0cysAUK/YQSE5t54vxJQKfpuFc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=SgylLvRaBKYS7r+xIbWhESrez2p9eM3rn3Gj9VJrkxKtw1BTy3keoFGOXC3vphrNN6sTRiDu/4KvDs2opYOneWdnSE5GPQZMx6LBo1qprLouWvWi9ShhnAR/4MN6dharikcjXvH45stNSFPwZoHhaoWbu3sMf8+B0JLAGxVIx7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f30IaH/z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABEEEC4CEED;
	Mon, 14 Jul 2025 21:13:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752527632;
	bh=RH5VCLwAWlWBmOSsR0cysAUK/YQSE5t54vxJQKfpuFc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=f30IaH/z17Fw92A0VCsXbmmuzAvlNNAulx48l6Abn6QLQyvO+VZr+wpfzUQbLccKR
	 IHqUCGl6JdiSfB03MegRbpmwkj5Dt2CJs4unfxtjTZFzBo1dbGV8lroSpw86ZdB3l/
	 hY1LGW7icvy4cbgqIjECU9gcQJaXxfhqBPLzGVnBazrwSsJMOcRYwSvxAuPT1mUBG0
	 mXvfOnW+J+rcuCJE+MB8kcqa40lcBR4c174osXdJBYY40BKO2zfEr1lUrw6Py79O+T
	 HRYGONZxRGLYoxN1tDACvbdwnVaDyUwCnkcEDKDz4LBhkH9QC1iOQomaZj+sT8lZ5L
	 dv3LhFdU2FcSQ==
Date: Mon, 14 Jul 2025 16:13:51 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-kernel@vger.kernel.org, Lukas Wunner <lukas@wunner.de>,
	Keith Busch <kbusch@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Parav Pandit <parav@nvidia.com>, virtualization@lists.linux.dev,
	stefanha@redhat.com, alok.a.tiwari@oracle.com,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH RFC v5 1/5] pci: report surprise removal event
Message-ID: <20250714211351.GA2418892@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250714022128-mutt-send-email-mst@kernel.org>

On Mon, Jul 14, 2025 at 02:26:19AM -0400, Michael S. Tsirkin wrote:
> On Wed, Jul 09, 2025 at 06:38:20PM -0500, Bjorn Helgaas wrote:
> > On Wed, Jul 09, 2025 at 04:55:26PM -0400, Michael S. Tsirkin wrote:
> > > At the moment, in case of a surprise removal, the regular remove
> > > callback is invoked, exclusively.  This works well, because mostly, the
> > > cleanup would be the same.
> > > 
> > > However, there's a race: imagine device removal was initiated by a user
> > > action, such as driver unbind, and it in turn initiated some cleanup and
> > > is now waiting for an interrupt from the device. If the device is now
> > > surprise-removed, that never arrives and the remove callback hangs
> > > forever.
> > > 
> > > For example, this was reported for virtio-blk:
> > > 
> > > 	1. the graceful removal is ongoing in the remove() callback, where disk
> > > 	   deletion del_gendisk() is ongoing, which waits for the requests +to
> > > 	   complete,
> > > 
> > > 	2. Now few requests are yet to complete, and surprise removal started.
> > > 
> > > 	At this point, virtio block driver will not get notified by the driver
> > > 	core layer, because it is likely serializing remove() happening by
> > > 	+user/driver unload and PCI hotplug driver-initiated device removal.  So
> > > 	vblk driver doesn't know that device is removed, block layer is waiting
> > > 	for requests completions to arrive which it never gets.  So
> > > 	del_gendisk() gets stuck.
> > > 
> > > Drivers can artificially add timeouts to handle that, but it can be
> > > flaky.
> > > 
> > > Instead, let's add a way for the driver to be notified about the
> > > disconnect. It can then do any necessary cleanup, knowing that the
> > > device is inactive.
> > 
> > This relies on somebody (typically pciehp, I guess) calling
> > pci_dev_set_disconnected() when a surprise remove happens.
> > 
> > Do you think it would be practical for the driver's .remove() method
> > to recognize that the device may stop responding at any point, even if
> > no hotplug driver is present to call pci_dev_set_disconnected()?
> > 
> > Waiting forever for an interrupt seems kind of vulnerable in general.
> > Maybe "artificially adding timeouts" is alluding to *not* waiting
> > forever for interrupts?  That doesn't seem artificial to me because
> > it's just a fact of life that devices can disappear at arbitrary
> > times.
> > 
> > It seems a little fragile to me to depend on some other part of the
> > system to notice the surprise removal and tell you about it or
> > schedule your work function.  I think it would be more robust for the
> > driver to check directly, i.e., assume writes to the device may be
> > lost, check for PCI_POSSIBLE_ERROR() after reads from the device, and
> > never wait for an interrupt without a timeout.
> 
> virtio is ... kind of special, in that users already take it for
> granted that having a device as long as they want to respond
> still does not lead to errors and data loss.
> 
> Makes it a bit harder as our timeout would have to
> check for presence and retry, we can't just fail as a
> normal hardware device does.

Sorry, I don't know enough about virtio to follow what you said about 
"having a device as long as they want to respond".

We started with a graceful remove.  That must mean the user no longer
needs the device.

> And there's the overhead thing - poking at the device a lot
> puts a high load on the host.

Checking for PCI_POSSIBLE_ERROR() doesn't touch the device.  If you
did a config read already, and the result happened to be ~0, *then* we
have the problem of figuring out whether the actual data from the
device was ~0, or if the read failed and the Root Complex synthesized
the ~0.  In many cases a driver knows that ~0 is not a possible
register value.  Otherwise it might have to read another register that
is known not to be ~0.

Bjorn

