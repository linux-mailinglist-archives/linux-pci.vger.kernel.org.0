Return-Path: <linux-pci+bounces-16671-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E61189C7462
	for <lists+linux-pci@lfdr.de>; Wed, 13 Nov 2024 15:34:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB528287490
	for <lists+linux-pci@lfdr.de>; Wed, 13 Nov 2024 14:34:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B737F1632E4;
	Wed, 13 Nov 2024 14:30:52 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1455381AA;
	Wed, 13 Nov 2024 14:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731508252; cv=none; b=SK1fw/cF/26VEtj/Tkgo9EmHscX6eC7DL62S+EJtdgUJeKVzXQhnf7+EPc6jfJk7loR4kj5pUxRE4e2c6ro3/MFkf7YNwkhZm4kbn4elGhgclwut8aKYpw/okmG4OiMRIYS5qDi73l/cwKYMrzRhJzIR96RHW9JF8taw9BMmQCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731508252; c=relaxed/simple;
	bh=ZfjbghJSvVTLjJH8eDY6fgXNlZmBxkdlyNnBXN+eGSE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TttJB8gtmw/+k+qJ5fktE7hKPHDoFq+rJwVQz1p+TzM3AfuQH3I4xArGizaRLvixa9y/lp2MIfw54xIUoB7o3KojxLHFrcvOzuDn8spDe5F6cKOb6cds95Q+uwrr6KhmJ+fKIURNOGMVZS99cwS7by+NgsrC1k7v2npVnlUkBgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id C525C68C4E; Wed, 13 Nov 2024 15:30:39 +0100 (CET)
Date: Wed, 13 Nov 2024 15:30:39 +0100
From: Christoph Hellwig <hch@lst.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: John Garry <john.g.garry@oracle.com>, Daniel Wagner <dwagner@suse.de>,
	Daniel Wagner <wagi@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	virtualization@lists.linux.dev, linux-scsi@vger.kernel.org,
	megaraidlinux.pdl@broadcom.com, mpi3mr-linuxdrv.pdl@broadcom.com,
	MPT-FusionLinux.pdl@broadcom.com, storagedev@microchip.com,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH v3 1/8] driver core: bus: add irq_get_affinity callback
 to bus_type
Message-ID: <20241113143039.GA20331@lst.de>
References: <20241112-refactor-blk-affinity-helpers-v3-0-573bfca0cbd8@kernel.org> <20241112-refactor-blk-affinity-helpers-v3-1-573bfca0cbd8@kernel.org> <76da6c05-4f28-41cc-a48e-da2ae16c64c4@oracle.com> <2d85aa5e-037a-45c3-9f2d-e46b2159b697@flourine.local> <bed15207-c3d8-4e0b-b356-4880f5a4fdff@oracle.com> <2024111323-darkening-sappy-23fa@gregkh>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024111323-darkening-sappy-23fa@gregkh>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Nov 13, 2024 at 02:54:23PM +0100, Greg Kroah-Hartman wrote:
> bus types are good to set it at a bus level so you don't have to
> explicitly set it at each-and-every-driver.  Depends on what you want
> this to be, if it is a "all drivers of this bus type will have the same
> callback" then put it on the bus.  otherwise if you are going to
> mix/match on a same bus, then put it in the driver structure.

... and that is exactly the case here.  The driver itself has no business
being involved.

