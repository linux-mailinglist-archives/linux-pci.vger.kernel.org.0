Return-Path: <linux-pci+bounces-16575-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 35F899C5DD4
	for <lists+linux-pci@lfdr.de>; Tue, 12 Nov 2024 17:56:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E23E61F2186B
	for <lists+linux-pci@lfdr.de>; Tue, 12 Nov 2024 16:56:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 163D62076AE;
	Tue, 12 Nov 2024 16:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="YPpko2qb"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAE3820EA35;
	Tue, 12 Nov 2024 16:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731430431; cv=none; b=GgmjNDFhSNMHcnVBRP4z26fwrgMPUgKoVe0OBmTysRpufAqedHiTXvXxlL7WOOAbNKjyFokol4SC9yOGig1LRNThNb5SvnXZsELkB9iX6/Ib0wmUKSO7taMJeBAe6so+/Hx7KkhxJhgkhIsj+Wlo/La34hTXJnlE4MML9aajrB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731430431; c=relaxed/simple;
	bh=ODw1HrrVUx4XDdn+NA3ZiM07EdzE1pUd7SlEHngh474=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ld58Ybm/MAHieV267qpQSdC8nH1xbEtDduRvA4FZTQnDFY1AaRHLd0cMtHCSp2VZp4N4HPGVjd0drzkHsUceKTSJncr5+C1/7gcopjtmeQiOJDYf3z41gdpHOFMQKZqL6RrqEE6hiWuDxTcu2hdtcB4USdWPbGClW6hkp4AZGgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=YPpko2qb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71BF8C4CECD;
	Tue, 12 Nov 2024 16:53:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1731430430;
	bh=ODw1HrrVUx4XDdn+NA3ZiM07EdzE1pUd7SlEHngh474=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YPpko2qbSkx3B/Yke7goINBZ5S4Gf38HLGrkUd18K0+NDW5TDc2VM8SjUAEi81sCE
	 VWJR7e47xV/EaMi8Ut+FCVeSu/Se2MCM1NoE5AuqTmi3OjltsAR34taDLR9bK7barr
	 x0PRbnboZ7eYnBg6m7u87Mtvx+l0Csa6qtyBnsc0=
Date: Tue, 12 Nov 2024 17:53:47 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Daniel Wagner <dwagner@suse.de>
Cc: Daniel Wagner <wagi@kernel.org>, Jens Axboe <axboe@kernel.dk>,
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
Subject: Re: [PATCH v3 4/8] blk-mp: introduce blk_mq_hctx_map_queues
Message-ID: <2024111212-rash-suffocate-dc13@gregkh>
References: <20241112-refactor-blk-affinity-helpers-v3-0-573bfca0cbd8@kernel.org>
 <20241112-refactor-blk-affinity-helpers-v3-4-573bfca0cbd8@kernel.org>
 <2024111202-parish-prowess-78bc@gregkh>
 <c8c671c1-267a-4aa7-a64b-51a461176ad3@flourine.local>
 <2024111215-jury-unlighted-3953@gregkh>
 <5967d256-037e-4ac8-a509-c6955b03db05@flourine.local>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5967d256-037e-4ac8-a509-c6955b03db05@flourine.local>

On Tue, Nov 12, 2024 at 05:15:31PM +0100, Daniel Wagner wrote:
> On Tue, Nov 12, 2024 at 04:42:40PM +0100, Greg Kroah-Hartman wrote:
> > On Tue, Nov 12, 2024 at 04:33:09PM +0100, Daniel Wagner wrote:
> > > On Tue, Nov 12, 2024 at 02:58:43PM +0100, Greg Kroah-Hartman wrote:
> > > > > +void blk_mq_hctx_map_queues(struct blk_mq_queue_map *qmap,
> > > > > +			    struct device *dev, unsigned int offset)
> > > > > +
> > > > > +{
> > > > > +	const struct cpumask *mask;
> > > > > +	unsigned int queue, cpu;
> > > > > +
> > > > > +	if (!dev->bus->irq_get_affinity)
> > > > > +		goto fallback;
> > > > 
> > > > I think this is better than hard-coding it, but are you sure that the
> > > > bus will always be bound to the device here so that you have a valid
> > > > bus-> pointer?
> > > 
> > > No, I just assumed the bus pointer is always valid. If it is possible to
> > > have a device without a bus, than I'll better extend the condition to
> > > 
> > > 	if (!dev->bus || !dev->bus->irq_get_affinity)
> > >         	goto fallback;
> > 
> > I don't know if it's possible as I don't know what codepaths are calling
> > this, it was hard to unwind.  But you should check "just to be safe" :)
> 
> The main path to map_queues is via the probe functions. There are some
> more paths like when updating a tagset after the number of queues but
> that is all after the probe function.
> 
> nvme_probe
>   nvme_alloc_admin_tag_set
>     blk_mq_alloc_tag_set
>        blk_mq_update_queue_map
>           set->ops->map_queues
> 	     blk_mq_htcx_map_queues
>   nvme_alloc_io_tag_set
>     blk_mq_alloc_tag_set
>       blk_mq_update_queue_map
>         set->ops->map_queues
>           blk_mq_htcx_map_queues
> 
> virtscsi_probe, hisi_sas_v3_probe, ...
>   scsi_add_host
>     scsi_add_host_with_dma
>       scsi_mq_setup_tags
>          blk_mq_alloc_tag_set
>            blk_mq_update_queue_map
>              set->ops->map_queues
>                blk_mq_htcx_map_queues
> 
> virtblk_probe
>   blk_mq_alloc_tag_set
>     blk_mq_update_queue_map
>       set->ops->map_queues
>         blk_mq_htcx_map_queues
> 
> Does this help?

Ok, that seems fine.  Worst case, you crash and it's obvious that it
needs to be checked in the future :)

thanks,

greg k-h

