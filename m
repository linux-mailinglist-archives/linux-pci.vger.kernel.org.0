Return-Path: <linux-pci+bounces-16753-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D0F09C8993
	for <lists+linux-pci@lfdr.de>; Thu, 14 Nov 2024 13:12:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D8A081F23BB9
	for <lists+linux-pci@lfdr.de>; Thu, 14 Nov 2024 12:12:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A7B91F9A9A;
	Thu, 14 Nov 2024 12:11:55 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8EDF1F9A9D;
	Thu, 14 Nov 2024 12:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731586315; cv=none; b=DUMYKEaqz5As/EPLst4W/pyy6m8Y9hy71Ak9eXGgnqiaSxtgOaof4oMpMqKV5RpVsM6u8DmC0T5M7gwKXaonu9ZZzb9QgNC3MrfIm5lCUQlybYhj3zdowPUPo+tALqgB/CtsoFS6AZzK1EZUps0aIloqoQh7G/U5RpB2nYeerbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731586315; c=relaxed/simple;
	bh=PWFtEIgkc0mzcM/xXRLuGdPlrM4paLHdMvN0eRuZ+bk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kOfNZY38FodMPbLBIy4L/36L8qLMGCsxh2ox7+RTZ/khJFkzrffMAg9Bmr1y7/j30SD3RpdnhjI9elEV/rgreYLZnO+rJMv4baE6W9aYBHctlOPW0yfb3hrtafHa0d+YIMSTyGsY92PMi8JPuvABMl8qwqjCTej4KjtjYQcwmxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 47A2568C7B; Thu, 14 Nov 2024 13:11:47 +0100 (CET)
Date: Thu, 14 Nov 2024 13:11:47 +0100
From: Christoph Hellwig <hch@lst.de>
To: Daniel Wagner <dwagner@suse.de>
Cc: Ming Lei <ming.lei@redhat.com>, Daniel Wagner <wagi@kernel.org>,
	Jens Axboe <axboe@kernel.dk>, Bjorn Helgaas <bhelgaas@google.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	John Garry <john.g.garry@oracle.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Hannes Reinecke <hare@suse.de>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	virtualization@lists.linux.dev, linux-scsi@vger.kernel.org,
	megaraidlinux.pdl@broadcom.com, mpi3mr-linuxdrv.pdl@broadcom.com,
	MPT-FusionLinux.pdl@broadcom.com, storagedev@microchip.com,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH v4 05/10] blk-mq: introduce blk_mq_hctx_map_queues
Message-ID: <20241114121147.GA3074@lst.de>
References: <20241113-refactor-blk-affinity-helpers-v4-0-dd3baa1e267f@kernel.org> <20241113-refactor-blk-affinity-helpers-v4-5-dd3baa1e267f@kernel.org> <ZzVZQbZOYhNF08LX@fedora> <9fa26099-1922-4b99-883e-bd5f6c58162a@flourine.local> <ZzW-9rWvKBxFZU1E@fedora> <4bd491e5-fab5-4e94-8719-560b5a4de01e@flourine.local>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4bd491e5-fab5-4e94-8719-560b5a4de01e@flourine.local>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, Nov 14, 2024 at 01:06:49PM +0100, Daniel Wagner wrote:
> Oh, I was not aware of this ordering. And after digging this up here:
> 
> https://lore.kernel.org/all/20060105142951.13.01@flint.arm.linux.org.uk/
> 
> I don't think we it's worthwhile to add the callback to device_driver
> just for hisi_sas_v2. So I am going to drop this part again.

Yes, I don't really see how querying driver specific information like
this from code called by the driver make much sense. 


