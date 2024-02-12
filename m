Return-Path: <linux-pci+bounces-3367-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AF21851EA2
	for <lists+linux-pci@lfdr.de>; Mon, 12 Feb 2024 21:27:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 66D17B26A09
	for <lists+linux-pci@lfdr.de>; Mon, 12 Feb 2024 20:27:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F036C481D5;
	Mon, 12 Feb 2024 20:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XhINWtyy"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C70AB482C0;
	Mon, 12 Feb 2024 20:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707769636; cv=none; b=oTeMoDMXO6FcDhtbvk81vUnDxCYzsrbITe9tuhv+tOo5+bcH8/fodtz1f1ogxEJQTz+T671Ob2ToKAtGf4SxRCmLyeI3U7EpILnATbEKomGSebbP9PAMxmHSHBsPOHW8ClkjB9I6BcAE0NmPsYiPaULzbCYY6qW+A3+f+fp9c4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707769636; c=relaxed/simple;
	bh=pWDQCMLUflAad9f8MUqSo1m1Bx83z4sgVK5qLQvTnNs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=tlSuF4KmbDxR/5kv47hLbGW5CmDvMmP+nIV3/nCThwP8Hj5ZOHE8bdHiqeCxGmH7g5Ad69MzMsRWNviQuwW4oNrzCRv1PI4l+rvGGYVrV6ENDAjUHfzQIy/1wtY8gypwBU1m4dXCYh49crIwJTVjK9HQkgJNBrQ6qV4mCnS8U3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XhINWtyy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2247FC433C7;
	Mon, 12 Feb 2024 20:27:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707769636;
	bh=pWDQCMLUflAad9f8MUqSo1m1Bx83z4sgVK5qLQvTnNs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=XhINWtyyG5izYAPM6w22Bfzpl14vWfSd/4cQmzY7gVGFGapkVp8U7T3lQkxHvy+q8
	 NIqy9EovCPqzr2RUW1H2uogAHdUz6IpNNJz0ZddA6i5WgpDITLF2DMxFMNVrl6MiEu
	 2Kq4b6z9CPtNBjuBAsa5hQ0X66n+eVqeCxBrRGJnpkXwg3KPhH2EFlsluY6zS9SWiD
	 iPxr9BUhvNiVV6kGs2h2RiIYn05Sj54aalF4Xohq6cnNwSfkGl4B80O+ZJz9UV0A8l
	 7ZyaKuMjWctK+5+WzAypZm1TSrn8pgX15xDNhsFnq8nSQu3oz3dBQ4brokGOTs3ya7
	 /PPdLeK8MufYg==
Date: Mon, 12 Feb 2024 14:27:14 -0600
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
Message-ID: <20240212202714.GA1142983@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240211084844.GA805332@unreal>

On Sun, Feb 11, 2024 at 10:48:44AM +0200, Leon Romanovsky wrote:
> On Fri, Feb 09, 2024 at 07:20:28PM -0800, Kuppuswamy Sathyanarayanan wrote:
> > On 2/9/24 3:52 PM, Jim Harris wrote:
> > > If an SR-IOV enabled device is held by vfio, and the device is removed,
> > > vfio will hold device lock and notify userspace of the removal. If
> > > userspace reads the sriov_numvfs sysfs entry, that thread will be blocked
> > > since sriov_numvfs_show() also tries to acquire the device lock. If that
> > > same thread is responsible for releasing the device to vfio, it results in
> > > a deadlock.
> > >
> > > The proper way to detect a change to the num_VFs value is to listen for a
> > > sysfs event, not to add a device_lock() on the attribute _show() in the
> > > kernel.

The lock was not about detecting a change; Pierre did this:

  ip monitor dev ${DEVICE} | grep --line-buffered "^${id}:" | while read line; do \
    cat ${path}/device/sriov_numvfs; \

which I assume works by listening for sysfs events.  The problem was
that after the event occurred, the sriov_numvfs read got a stale value
(see https://bugzilla.kernel.org/show_bug.cgi?id=202991).

So I would drop this sentence because I don't think it accurately
reflects the reason for 35ff867b7657.

> > Since you are reverting a commit that synchronizes SysFS read
> > /write, please add some comments about why it is not an
> > issue anymore.
> 
> It was never an issue, the idea that sysfs read and write should be
> serialized by kernel is not correct by definition. 

I think it *was* an issue.  The behavior Pierre observed at was
clearly wrong, and we added 35ff867b7657 ("PCI/IOV: Serialize sysfs
sriov_numvfs reads vs writes") to resolve it.

We should try to avoid reintroducing the problem, so I think we should
probably squash these two patches and describe it as a deadlock fix
instead of dismissing 35ff867b7657 as being based on false premises.

It would be awesome if you had time to verify that these patches also
resolve the problem you saw, Pierre.

I think we should also add:

  Fixes: 35ff867b7657 ("PCI/IOV: Serialize sysfs sriov_numvfs reads vs writes")

as a trigger for backporting this to kernels that include
35ff867b7657.

Bjorn

> > > This reverts commit 35ff867b76576e32f34c698ccd11343f7d616204.
> > > Revert had a small conflict, the sprintf() is now changed to sysfs_emit().
> > >
> > > Link: https://lore.kernel.org/linux-pci/ZXJI5+f8bUelVXqu@ubuntu/
> > > Suggested-by: Leon Romanovsky <leonro@nvidia.com>
> > > Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
> > > Signed-off-by: Jim Harris <jim.harris@samsung.com>
> > > ---
> > >  drivers/pci/iov.c |    8 +-------
> > >  1 file changed, 1 insertion(+), 7 deletions(-)
> > >
> > > diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
> > > index aaa33e8dc4c9..0ca20cd518d5 100644
> > > --- a/drivers/pci/iov.c
> > > +++ b/drivers/pci/iov.c
> > > @@ -395,14 +395,8 @@ static ssize_t sriov_numvfs_show(struct device *dev,
> > >  				 char *buf)
> > >  {
> > >  	struct pci_dev *pdev = to_pci_dev(dev);
> > > -	u16 num_vfs;
> > > -
> > > -	/* Serialize vs sriov_numvfs_store() so readers see valid num_VFs */
> > > -	device_lock(&pdev->dev);
> > > -	num_vfs = pdev->sriov->num_VFs;
> > > -	device_unlock(&pdev->dev);
> > >  
> > > -	return sysfs_emit(buf, "%u\n", num_vfs);
> > > +	return sysfs_emit(buf, "%u\n", pdev->sriov->num_VFs);
> > >  }
> > >  
> > >  /*
> > >
> > -- 
> > Sathyanarayanan Kuppuswamy
> > Linux Kernel Developer
> > 

