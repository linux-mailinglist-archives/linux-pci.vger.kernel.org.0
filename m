Return-Path: <linux-pci+bounces-3461-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 101488550BC
	for <lists+linux-pci@lfdr.de>; Wed, 14 Feb 2024 18:50:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3BA041C20CC5
	for <lists+linux-pci@lfdr.de>; Wed, 14 Feb 2024 17:50:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDBA584FCB;
	Wed, 14 Feb 2024 17:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N7n3CDH4"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A48A522071;
	Wed, 14 Feb 2024 17:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707933003; cv=none; b=UjFS1fY8UXtXf+ZCLxOndqBCnxSP64IuDgGrPUnFSKkzlW/+OZn+bfVia9XRg2F/osZQR7e/f+ylX3gDuTgHjfg5dXz0q6ireINrbGb0ZgIYs95+f+Px1mdvotVPDnjE4ZC0hINXip6X1kuoYYweE7KuxnmvCRkCwHmeIvO5QAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707933003; c=relaxed/simple;
	bh=oj/fOhBRrwmBBdzihjmYlwouK8T9IegrEutJE4Gmtzg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=pOK2gNjhqnK5/BLLMxJUbXlXVodBFJA8rxEcprv7W19z81oWm7li98H4r4lNb+Pas+IQfQZMtbvT2t12KwJQmRaBnZ5TGhhMRDrV/QgOF1mbLjxF4Jxgkyk69v9UopNPxee/gsp9+2DPRM9zFNMHbphiSsSHnmeqZzBuqSLCqp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N7n3CDH4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D65D2C433F1;
	Wed, 14 Feb 2024 17:50:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707933003;
	bh=oj/fOhBRrwmBBdzihjmYlwouK8T9IegrEutJE4Gmtzg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=N7n3CDH46Et28iqoO8YRWPU253Sc2hOUcTwnIfzEL54bBW8YKyqIFcLZZg8BwQxBm
	 KcPv5HrgMNegOsCr0HafjVQ9T4Vvv7qjeICfnW4mP4KIPc/KMRZgb/8EYB0md8t3cV
	 /EMsiNaCnikCnfi/0ICvLtyhL6hdPzwCpumLJfDIm8+2RZOgHPuiayUVLS5j6BCpUK
	 eg5Sgh9Rm3HQk4KxPMjd4QH6dZGXd4PsClJQyPTZHnqARHx8AQe/OorTA6QxOFMYnc
	 +AGgoc2RHQ9yfZVagsVppMbKJ8y2XQRU4FlAHOeVbHmo+q/DBybEv+xJoNBc6IKRi6
	 TY9F6JxQcaKiw==
Date: Wed, 14 Feb 2024 11:50:00 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Jim Harris <jim.harris@samsung.com>
Cc: Leon Romanovsky <leonro@nvidia.com>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	Pierre =?utf-8?Q?Cr=C3=A9gut?= <pierre.cregut@orange.com>
Subject: Re: [PATCH v2 1/2] PCI/IOV: Revert "PCI/IOV: Serialize sysfs
 sriov_numvfs reads vs writes"
Message-ID: <20240214175000.GA1260022@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zczyhya/+454IaQM@ubuntu>

On Wed, Feb 14, 2024 at 05:04:08PM +0000, Jim Harris wrote:
> On Wed, Feb 14, 2024 at 09:16:18AM +0200, Leon Romanovsky wrote:
> > On Tue, Feb 13, 2024 at 01:45:56PM -0600, Bjorn Helgaas wrote:
> > > On Tue, Feb 13, 2024 at 07:46:02PM +0200, Leon Romanovsky wrote:
> > > > On Tue, Feb 13, 2024 at 09:59:54AM -0600, Bjorn Helgaas wrote:
> > > > ...
> > > 
> > > > > I guess that means that if we apply this revert, the problem Pierre
> > > > > reported will return.  Obviously the deadlock is more important than
> > > > > the inconsistency Pierre observed, but from the user's point of view
> > > > > this will look like a regression.
> > > > > 
> > > > > Maybe listening to netlink and then looking at sysfs isn't the
> > > > > "correct" way to do this, but I don't want to just casually break
> > > > > existing user code.  If we do contemplate doing the revert, at the
> > > > > very least we should include specific details about what the user code
> > > > > *should* do instead, at the level of the actual commands to use
> > > > > instead of "ip monitor dev; cat ${path}/device/sriov_numvfs".
> > > > 
> > > > udevadm monitor will do the trick.
> > > > 
> > > > Another possible solution is to refactor the code to make sure that
> > > > .probe on VFs happens only after sriov_numvfs is updated.
> > > 
> > > I like the idea of refactoring it so as to preserve the existing
> > > ordering while also fixing the deadlock.
> > 
> > I think something like this will be enough (not tested). It will et the number of VFs
> > before we make VFs visible to probe:
> 
> I'll push a v3, replacing the second patch with this one instead. Although
> based on this discussion it seems we're moving towards squashing the revert
> with Leon's suggested patch. Bjorn, I'll assume you're still OK with just
> squashing these on your end.

Yep.

> I would like some input on how to actually test this though.
> Presumably we see some event on device PF and we want to make sure
> if we read PF/device/sriov_numvfs that we see the updated value. But
> the only type of event I think we can expect is the PF's
> sriov_numvfs CHANGE event.
> 
> Is there any way for VFs to be created outside of writing to the
> sriov_numvfs sysfs file? My understanding is some older
> devices/drivers will auto-create VFs when the PF is initialized, but
> it wasn't clear from the bug report whether that was part of the
> configuration here. Pierre, do you have any recollection on this?
> 
> Or maybe testing for this case just means compile and verify with
> udevadm monitor that we see the CHANGE event before any of the VFs
> are actually created...

I just want to make sure that Pierre's existing code continues to work
unchanged.

Ideally we could revert 35ff867b7657 ("PCI/IOV: Serialize sysfs
sriov_numvfs reads vs writes"), reproduce the problem with the shell
script attached to https://bugzilla.kernel.org/show_bug.cgi?id=202991
(I assume Pierre used a /sys/.../sriov_numvfs write to trigger the
change).

Then we could verify that with 35ff867b7657 still reverted but the
change below added, the problem is no longer reproducible.

> > diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
> > index aaa33e8dc4c9..0cdfaae80594 100644
> > --- a/drivers/pci/iov.c
> > +++ b/drivers/pci/iov.c
> > @@ -679,12 +679,14 @@ static int sriov_enable(struct pci_dev *dev, int nr_virtfn)
> >  	msleep(100);
> >  	pci_cfg_access_unlock(dev);
> >  
> > +	iov->num_VFs = nr_virtfn;
> >  	rc = sriov_add_vfs(dev, initial);
> > -	if (rc)
> > +	if (rc) {
> > +		iov->num_VFs = 0;
> >  		goto err_pcibios;
> > +	}
> >  
> >  	kobject_uevent(&dev->dev.kobj, KOBJ_CHANGE);
> > -	iov->num_VFs = nr_virtfn;
> >  
> >  	return 0;
> >  

