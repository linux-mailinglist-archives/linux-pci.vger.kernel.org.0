Return-Path: <linux-pci+bounces-43621-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 761E8CDB109
	for <lists+linux-pci@lfdr.de>; Wed, 24 Dec 2025 02:16:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7DE21300986F
	for <lists+linux-pci@lfdr.de>; Wed, 24 Dec 2025 01:16:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F3AA261393;
	Wed, 24 Dec 2025 01:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dMqe4mI/"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 298891A2C0B;
	Wed, 24 Dec 2025 01:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766538999; cv=none; b=SOCHPDK1CgLzabiSflVONis634uTOUXDSFr9Lf4RWUWekFL4gcrBxv7Ii/VXH3siudLfHZFifJVWPYeYvkZYGM96Z2xBHpe5xGFt/Ljol2rG8ei/WuSpkOhudhFSpxJEIbtYexgGGv8ptO0+QRjK/LzIGTSVI8h91mRP/NqYod8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766538999; c=relaxed/simple;
	bh=YrVzfIAQJXK7JVD1UChEaUkj/f7EBFUWs/8zVxrjE8I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bqJVgcBdTEhr69qn/YSuRFnOP9uIn7gKhQEC/w5Y9jUUy6s7Ghs6pqjiGtj6ARi0fZVST5npVf63bw1eJkF3+gibhXIwvSiZKX4dvApT9SzbPMhX9iFYyA5quiIYVlSuEgtoqsPxTCmwsvTVc7kHeN54TbfKd/sNnBuLKo3Bj6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dMqe4mI/; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1766538998; x=1798074998;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=YrVzfIAQJXK7JVD1UChEaUkj/f7EBFUWs/8zVxrjE8I=;
  b=dMqe4mI/1Y64+/TN6Gi8h3379yRuU4zQbYBH0esKmaSt8K4eHf/UQhlb
   qzz/pKCpCNx0DXAHVKRKg7M1fkAJYrnrNPe0pKjoTN/X9U50ApGwo2Ukv
   6ODMl/gkYkFeHfNmpJ+MJFCtgUBzbAmDbkDCKxvhBx+RBwNVG4h0gTlAN
   fOyonhVUuxgSzXFqt023VJUvJ1r2lO/bTBvyFHfl0T8xdTB3JWvMY0C+C
   EUfSIEgElBxJJiDpkxL8iTXHurZmTm5ckdHSQbdVah1/VabQpUnVwjqt2
   mwvdizYFGTmw0jYZw5+sVHbPtN2XURL8OoJcZ3fe6ka8bQ8k5OD4j+LND
   Q==;
X-CSE-ConnectionGUID: DST/knylRwyr44MbHRe9iw==
X-CSE-MsgGUID: tmambNbyQTGzBvq+otRnIw==
X-IronPort-AV: E=McAfee;i="6800,10657,11651"; a="79106877"
X-IronPort-AV: E=Sophos;i="6.21,172,1763452800"; 
   d="scan'208";a="79106877"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Dec 2025 17:16:37 -0800
X-CSE-ConnectionGUID: LIDZ/DQaRfS0Q7tAhXcR2A==
X-CSE-MsgGUID: I+si5+QxSBCaxd62vmIuKQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,172,1763452800"; 
   d="scan'208";a="199046901"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by orviesa006.jf.intel.com with ESMTP; 23 Dec 2025 17:16:35 -0800
Date: Wed, 24 Dec 2025 09:00:06 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-coco@lists.linux.dev, linux-pci@vger.kernel.org,
	dan.j.williams@intel.com, yilun.xu@intel.com,
	baolu.lu@linux.intel.com, zhenzhong.duan@intel.com,
	linux-kernel@vger.kernel.org, yi1.lai@intel.com
Subject: Re: [PATCH] PCI/IDE: Fix duplicate stream symlink names for TSM
 class devices
Message-ID: <aUs7FgdSQVUB1eux@yilunxu-OptiPlex-7050>
References: <20251223085601.2607455-1-yilun.xu@linux.intel.com>
 <20251223173157.GA4025076@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251223173157.GA4025076@bhelgaas>

On Tue, Dec 23, 2025 at 11:31:57AM -0600, Bjorn Helgaas wrote:
> On Tue, Dec 23, 2025 at 04:56:01PM +0800, Xu Yilun wrote:
> > The symlink name streamH.R.E is unique within a specific host bridge but
> > not across the system. Error occurs e.g. when creating the first stream
> > on a second host bridge:
> > 
> > [ 1244.034755] sysfs: cannot create duplicate filename '/devices/faux/tdx_host/tsm/tsm0/stream0.0.0'
> 
> Drop timestamp because it's no relevant.  Indent quoted material two
> spaces.

Yes.

> 
> > Fix this by adding host bridge name into symlink name for TSM class
> > devices. It should be OK to change the uAPI to
> > /sys/class/tsm/tsmN/pciDDDD:BB:streamH.R.E since it's new and has few
> > users.
> 
> Looks like this adds "pciDDDD:BB:" to one name, which is described
> here and in the Documentation/ABI change.
> 
> > Internally in the IDE library, store the full name in struct pci_ide
> > so TSM symlinks can use it directly, while PCI host bridge symlinks
> > can skip the host bridge name to keep concise.
> 
> And shortens this name, but no example or doc update?  Or maybe the
> shortening just strips the "pciDDDD:BB" to preserve the existing names
> somewhere else?

The later. The shortening is the internal code change, aims to preserve
the existing name /sys/devices/pciDDDD:BB/streamH.R.E, which is
described in:

  Documentation/ABI/testing/sysfs-devices-pci-host-bridge

  What:		pciDDDD:BB/streamH.R.E

I don't want repeat the host bridge name in host bridge context.

> 
> I'm just confused about which symlinks are changing (adding
> "pciDDDD:BB") and which are being kept concise (either by staying the
> same or being shortened).

I should have clearly listed the changed & preserved symlinks. Will
improve in v2.

Thanks,
Yilun

> 
> > Fixes: a4438f06b1db ("PCI/TSM: Report active IDE streams")
> > Reported-by: Yi Lai <yi1.lai@intel.com>
> > Signed-off-by: Xu Yilun <yilun.xu@linux.intel.com>
> > ---
> >  Documentation/ABI/testing/sysfs-class-tsm |  2 +-
> >  drivers/pci/ide.c                         | 12 +++++++++---
> >  2 files changed, 10 insertions(+), 4 deletions(-)
> > 
> > diff --git a/Documentation/ABI/testing/sysfs-class-tsm b/Documentation/ABI/testing/sysfs-class-tsm
> > index 6fc1a5ac6da1..eff71e42c60e 100644
> > --- a/Documentation/ABI/testing/sysfs-class-tsm
> > +++ b/Documentation/ABI/testing/sysfs-class-tsm
> > @@ -8,7 +8,7 @@ Description:
> >  		link encryption and other device-security features coordinated
> >  		through a platform tsm.
> >  
> > -What:		/sys/class/tsm/tsmN/streamH.R.E
> > +What:		/sys/class/tsm/tsmN/pciDDDD:BB:streamH.R.E
> >  Contact:	linux-pci@vger.kernel.org
> >  Description:
> >  		(RO) When a host bridge has established a secure connection via
> > diff --git a/drivers/pci/ide.c b/drivers/pci/ide.c
> > index f0ef474e1a0d..db1c7423bf39 100644
> > --- a/drivers/pci/ide.c
> > +++ b/drivers/pci/ide.c
> > @@ -425,6 +425,7 @@ int pci_ide_stream_register(struct pci_ide *ide)
> >  	struct pci_host_bridge *hb = pci_find_host_bridge(pdev->bus);
> >  	struct pci_ide_stream_id __sid;
> >  	u8 ep_stream, rp_stream;
> > +	const char *short_name;
> >  	int rc;
> >  
> >  	if (ide->stream_id < 0 || ide->stream_id > U8_MAX) {
> > @@ -441,13 +442,16 @@ int pci_ide_stream_register(struct pci_ide *ide)
> >  
> >  	ep_stream = ide->partner[PCI_IDE_EP].stream_index;
> >  	rp_stream = ide->partner[PCI_IDE_RP].stream_index;
> > -	const char *name __free(kfree) = kasprintf(GFP_KERNEL, "stream%d.%d.%d",
> > +	const char *name __free(kfree) = kasprintf(GFP_KERNEL, "%s:stream%d.%d.%d",
> > +						   dev_name(&hb->dev),
> >  						   ide->host_bridge_stream,
> >  						   rp_stream, ep_stream);
> >  	if (!name)
> >  		return -ENOMEM;
> >  
> > -	rc = sysfs_create_link(&hb->dev.kobj, &pdev->dev.kobj, name);
> > +	/* Skip host bridge name in the host bridge context */
> > +	short_name = name + strlen(dev_name(&hb->dev)) + 1;
> > +	rc = sysfs_create_link(&hb->dev.kobj, &pdev->dev.kobj, short_name);
> >  	if (rc)
> >  		return rc;
> >  
> > @@ -471,8 +475,10 @@ void pci_ide_stream_unregister(struct pci_ide *ide)
> >  {
> >  	struct pci_dev *pdev = ide->pdev;
> >  	struct pci_host_bridge *hb = pci_find_host_bridge(pdev->bus);
> > +	const char *short_name;
> >  
> > -	sysfs_remove_link(&hb->dev.kobj, ide->name);
> > +	short_name = ide->name + strlen(dev_name(&hb->dev)) + 1;
> > +	sysfs_remove_link(&hb->dev.kobj, short_name);
> >  	kfree(ide->name);
> >  	ida_free(&hb->ide_stream_ids_ida, ide->stream_id);
> >  	ide->name = NULL;
> > 
> > base-commit: 8f0b4cce4481fb22653697cced8d0d04027cb1e8
> > -- 
> > 2.25.1
> > 

