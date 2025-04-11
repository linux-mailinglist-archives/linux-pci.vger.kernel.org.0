Return-Path: <linux-pci+bounces-25689-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D5E9A8663C
	for <lists+linux-pci@lfdr.de>; Fri, 11 Apr 2025 21:24:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 337BC17DF7D
	for <lists+linux-pci@lfdr.de>; Fri, 11 Apr 2025 19:23:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB14A27934C;
	Fri, 11 Apr 2025 19:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xff.cz header.i=@xff.cz header.b="cCQXklNI"
X-Original-To: linux-pci@vger.kernel.org
Received: from vps.xff.cz (vps.xff.cz [195.181.215.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DB39233153;
	Fri, 11 Apr 2025 19:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.181.215.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744399428; cv=none; b=kMEoehLTsSaXa/rT2I7btVZ4IihST8ne950VKGQulyW8jOZcVmW/Nt4TJikpdFrzTTZ6Ix+sd3XWOgsZhyEBg3nYox1XzIgGbphQ2+CLn39NnpNQOT+icNCbRkKNJoESE4j8bfqYGB6Is7KhgKJUIzWcjlkbLND8SpQji8Ut/4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744399428; c=relaxed/simple;
	bh=FaakOh3rl4xSloWBhvpXgR9xn/hmIsKrKnH7eP/Pphc=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZRP/15yJ6smTtVlUT/nzOmwEqh16wdr35BoZYIMu5EQh4ZUkkGXhetm6iOCAVj9vTpyUamPyThz83S5q6DcD+IDxuOC0EhLNaWxxJD9BJC8lTDukY7nLrZ9P0bZAf6htxpz3OvXi/kkSB7SjhL7iHjSd09sizAiUfnq9/1ItZTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xff.cz; spf=pass smtp.mailfrom=xff.cz; dkim=pass (1024-bit key) header.d=xff.cz header.i=@xff.cz header.b=cCQXklNI; arc=none smtp.client-ip=195.181.215.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xff.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xff.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xff.cz; s=mail;
	t=1744399421; bh=FaakOh3rl4xSloWBhvpXgR9xn/hmIsKrKnH7eP/Pphc=;
	h=Date:From:To:Subject:X-My-GPG-KeyId:References:From;
	b=cCQXklNI+OnK65shRjSZCYrIZU39jsqjyRDuSJ3nCVzfOXULVK5nYxMLC8yQLmlJU
	 OkHaGs1z4FAjwaBuJue+237RkZ/NXSVYMHQ0EHyMJqvuGp16uw6fBipiTFMcY6Y1iD
	 odcxWAKGYUow9GgNLrg91dc7qdtTL+Xx3yJbwzv0=
Date: Fri, 11 Apr 2025 21:23:40 +0200
From: =?utf-8?Q?Ond=C5=99ej?= Jirman <megi@xff.cz>
To: Shay Drory <shayd@nvidia.com>, bhelgaas@google.com, 
	linux-pci@vger.kernel.org, leonro@nvidia.com, linux-kernel@vger.kernel.org, 
	Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH v2] PCI: Fix NULL dereference in SR-IOV VF creation error
 path - REGRESSION
Message-ID: <hrcsm2bo4ysqj2ggejndlou32cdc7yiknnm5nrlcoz4d64wall@7te4dfqsoe3y>
Mail-Followup-To: =?utf-8?Q?Ond=C5=99ej?= Jirman <megi@xff.cz>, 
	Shay Drory <shayd@nvidia.com>, bhelgaas@google.com, linux-pci@vger.kernel.org, 
	leonro@nvidia.com, linux-kernel@vger.kernel.org, Keith Busch <kbusch@kernel.org>
X-My-GPG-KeyId: EBFBDDE11FB918D44D1F56C1F9F0A873BE9777ED
 <https://xff.cz/key.txt>
References: <20250310084524.599225-1-shayd@nvidia.com>
 <dnkcl7j75mpnaaeuatug6rkwr3b3ibljpsol7nxwtquw7rwag2@5edfct5npe4a>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dnkcl7j75mpnaaeuatug6rkwr3b3ibljpsol7nxwtquw7rwag2@5edfct5npe4a>

On Fri, Apr 11, 2025 at 02:44:11PM +0200, megi xff wrote:
> Hello Shay,
> 
> On Mon, Mar 10, 2025 at 10:45:24AM +0200, Shay Drory wrote:
> > Add proper cleanup when virtfn setup fails to prevent NULL pointer
> > dereference during device removal. The kernel oops[1] occurred due to
> > Incorrect error handling flow when pci_setup_device() fails.
> > 
> > Fix it by introducing pci_iov_scan_device() which handle virtfn
> > allocation and setup properly, instead of invoking
> > pci_stop_and_remove_bus_device() whenever pci_setup_device is failed.
> > This prevents accessing partially initialized virtfn devices during
> > removal.
> 
> I've found a regression on QuartzPro64 board with NVMe connected to
> PCIe port no longer probing on boot and bisected it down to this
> commit.
> 
> When reverting this commit on top of torvalds/master the issue is also
> fixed.
> 
> From what I see in the diff of before/after of kernel log messages:
> 
>   https://xff.cz/dl/tmp/revert.log.patch
> 
>   (- before revert, + after revert)
> 
> It looks like this patch moves the discovery of the SSD up in the 
> timeline:
> 
> -pci 0000:01:00.0: [15b7:501a] type 00 class 0x010802 PCIe Endpoint
> -pci 0000:01:00.0: BAR 0 [mem 0x00000000-0x00003fff 64bit]
> -pci 0000:01:00.0: BAR 4 [mem 0x00000000-0x000000ff 64bit]
> 
> And later prevents this from happening somehow:
> 
> +pcieport 0000:00:00.0: bridge window [mem 0xf0200000-0xf02fffff]: assigned
> +pci 0000:01:00.0: BAR 0 [mem 0xf0200000-0xf0203fff 64bit]: assigned
> +pci 0000:01:00.0: BAR 4 [mem 0xf0204000-0xf02040ff 64bit]: assigned
> 
> I'm using pci=realloc kenel parameter with this board.
> 
> Full kernel logs of before revert and after revert:
> 
>   https://xff.cz/dl/tmp/revert.log    (post revert)
>   https://xff.cz/dl/tmp/pre-revert.log
> 
> Why would this patch change the probe order so much and maybe break
> pci=realloc?

By further experimentation I figured the real culprit that affects the
order of the initialization and breaks NVMe on QuartzPro64 and
Orange Pi 5+ are these two commits (mainly the first one, but build
fails without reverting the other, too):

2499f53484314 "PCI: Rework optional resource handling"
96336ec702643 "PCI: Perform reset_resource() and build fail list in sync"

Reverting this one just "fixed" the QuartzPro64 (but breakage and
order of probing remained same on Orange Pi 5+). Reverting the above
two commits fixed both boards at once.

"PCI: Rework optional resource handling" also makes more sense as a
culprit for changes seen in the log, I guess.

Kind regards,
	o.

> Kind regards,
>         o.  
> 
> > [1]
> > BUG: kernel NULL pointer dereference, address: 00000000000000d0
> > PGD 0 P4D 0
> > Oops: Oops: 0000 [#1] SMP
> > CPU: 22 UID: 0 PID: 1151 Comm: bash Not tainted 6.13.0+ #1
> > Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.13.0-0-gf21b5a4aeb02-prebuilt.qemu.org 04/01/2014
> > RIP: 0010:device_del+0x3d/0x3d0
> > Call Trace:
> >  <TASK>
> >  ? __die+0x20/0x60
> >  ? page_fault_oops+0x150/0x3e0
> >  ? exc_page_fault+0x74/0x130
> >  ? asm_exc_page_fault+0x22/0x30
> >  ? device_del+0x3d/0x3d0
> >  pci_remove_bus_device+0x7c/0x100
> >  pci_iov_add_virtfn+0xfa/0x200
> >  sriov_enable+0x208/0x420
> >  mlx5_core_sriov_configure+0x6a/0x160 [mlx5_core]
> >  sriov_numvfs_store+0xae/0x1a0
> >  kernfs_fop_write_iter+0x109/0x1a0
> >  vfs_write+0x2c0/0x3e0
> >  ksys_write+0x62/0xd0
> >  do_syscall_64+0x4c/0x100
> >  entry_SYSCALL_64_after_hwframe+0x4b/0x53
> > 
> > Fixes: e3f30d563a38 ("PCI: Make pci_destroy_dev() concurrent safe")
> > CC: Keith Busch <kbusch@kernel.org>
> > Change-Id: I7cee1123c90ce184661470dcafab45cec919bc72
> > Signed-off-by: Shay Drory <shayd@nvidia.com>
> > 
> > ---
> > changes from v1:
> > - add pci_iov_scan_device() helper (Bjorn)
> > ---
> >  drivers/pci/iov.c | 47 +++++++++++++++++++++++++++++++++--------------
> >  1 file changed, 33 insertions(+), 14 deletions(-)
> > 
> > diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
> > index 9e4770cdd4d5..9f08df0e7208 100644
> > --- a/drivers/pci/iov.c
> > +++ b/drivers/pci/iov.c
> > @@ -285,23 +285,16 @@ const struct attribute_group sriov_vf_dev_attr_group = {
> >  	.is_visible = sriov_vf_attrs_are_visible,
> >  };
> >  
> > -int pci_iov_add_virtfn(struct pci_dev *dev, int id)
> > +static struct pci_dev *pci_iov_scan_device(struct pci_dev *dev, int id,
> > +					   struct pci_bus *bus)
> >  {
> > -	int i;
> > -	int rc = -ENOMEM;
> > -	u64 size;
> > -	struct pci_dev *virtfn;
> > -	struct resource *res;
> >  	struct pci_sriov *iov = dev->sriov;
> > -	struct pci_bus *bus;
> > -
> > -	bus = virtfn_add_bus(dev->bus, pci_iov_virtfn_bus(dev, id));
> > -	if (!bus)
> > -		goto failed;
> > +	struct pci_dev *virtfn;
> > +	int rc = -ENOMEM;
> >  
> >  	virtfn = pci_alloc_dev(bus);
> >  	if (!virtfn)
> > -		goto failed0;
> > +		return ERR_PTR(rc);
> >  
> >  	virtfn->devfn = pci_iov_virtfn_devfn(dev, id);
> >  	virtfn->vendor = dev->vendor;
> > @@ -314,8 +307,34 @@ int pci_iov_add_virtfn(struct pci_dev *dev, int id)
> >  		pci_read_vf_config_common(virtfn);
> >  
> >  	rc = pci_setup_device(virtfn);
> > -	if (rc)
> > -		goto failed1;
> > +	if (rc) {
> > +		pci_dev_put(dev);
> > +		pci_bus_put(virtfn->bus);
> > +		kfree(virtfn);
> > +		return ERR_PTR(rc);
> > +	}
> > +
> > +	return virtfn;
> > +}
> > +
> > +int pci_iov_add_virtfn(struct pci_dev *dev, int id)
> > +{
> > +	int i;
> > +	int rc = -ENOMEM;
> > +	u64 size;
> > +	struct pci_dev *virtfn;
> > +	struct resource *res;
> > +	struct pci_bus *bus;
> > +
> > +	bus = virtfn_add_bus(dev->bus, pci_iov_virtfn_bus(dev, id));
> > +	if (!bus)
> > +		goto failed;
> > +
> > +	virtfn = pci_iov_scan_device(dev, id, bus);
> > +	if (IS_ERR(virtfn)) {
> > +		rc = PTR_ERR(virtfn);
> > +		goto failed0;
> > +	}
> >  
> >  	virtfn->dev.parent = dev->dev.parent;
> >  	virtfn->multifunction = 0;
> > -- 
> > 2.38.1
> > 

