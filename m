Return-Path: <linux-pci+bounces-16556-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AA1C9C5E9C
	for <lists+linux-pci@lfdr.de>; Tue, 12 Nov 2024 18:18:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7BC12B2A4E9
	for <lists+linux-pci@lfdr.de>; Tue, 12 Nov 2024 15:42:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D2D6201262;
	Tue, 12 Nov 2024 15:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="N2ajiGJc"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C6B38821;
	Tue, 12 Nov 2024 15:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731426164; cv=none; b=a17XCrygIwjuJOXYalJ2Vdu1jLNN6+g0zm+Pz1VufunQXrKOLC1728vf61A44UZ6jmJLd2pg7b+0wrAwnrz01v8JT5bppdNL4wFfdOIhGR4j3BorHKhbEFczlcRfsM/pmSU7fPQ13cYM1MbMaNpHpOTXfIBkhXBDHjoKSBRFV94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731426164; c=relaxed/simple;
	bh=tdd3NZ+GHcRdJCaOdNApZtNodQGwtd707HfpjA9pncQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ta+VUzbZ0sk12HECdTCy/EDci2RQD9U499nLR6zIe/x7u+sMIvzxjxowcxIpgFEi/DzoHYOyS7Ei3/z+CGYPzXFAzeOL8boOWc28XXBPO6QRea4e2TDSPvtTw+OZ+1PVChXncVJhjCPTTIGIUsNC6Hj/pQsD/dCBMh5KrDWCa4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=N2ajiGJc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FB60C4CECD;
	Tue, 12 Nov 2024 15:42:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1731426163;
	bh=tdd3NZ+GHcRdJCaOdNApZtNodQGwtd707HfpjA9pncQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=N2ajiGJcJzz74Ud6lZK2wFDlIGZ3O4eOdH0hr+de2c5HOW9+GPcsdPg4Jbk0ecMJQ
	 HzLiG2lJ6uDpGxNxfgvBAi+DEzcVf6ABtx+BALpCkjWI8ANBXGooww4MqSAjDxv7sH
	 72AS1Q9Q40HtYbXDSbYWO7kVyWeZFH8BKQ9eINvE=
Date: Tue, 12 Nov 2024 16:42:40 +0100
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
Message-ID: <2024111215-jury-unlighted-3953@gregkh>
References: <20241112-refactor-blk-affinity-helpers-v3-0-573bfca0cbd8@kernel.org>
 <20241112-refactor-blk-affinity-helpers-v3-4-573bfca0cbd8@kernel.org>
 <2024111202-parish-prowess-78bc@gregkh>
 <c8c671c1-267a-4aa7-a64b-51a461176ad3@flourine.local>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c8c671c1-267a-4aa7-a64b-51a461176ad3@flourine.local>

On Tue, Nov 12, 2024 at 04:33:09PM +0100, Daniel Wagner wrote:
> On Tue, Nov 12, 2024 at 02:58:43PM +0100, Greg Kroah-Hartman wrote:
> > > +void blk_mq_hctx_map_queues(struct blk_mq_queue_map *qmap,
> > > +			    struct device *dev, unsigned int offset)
> > > +
> > > +{
> > > +	const struct cpumask *mask;
> > > +	unsigned int queue, cpu;
> > > +
> > > +	if (!dev->bus->irq_get_affinity)
> > > +		goto fallback;
> > 
> > I think this is better than hard-coding it, but are you sure that the
> > bus will always be bound to the device here so that you have a valid
> > bus-> pointer?
> 
> No, I just assumed the bus pointer is always valid. If it is possible to
> have a device without a bus, than I'll better extend the condition to
> 
> 	if (!dev->bus || !dev->bus->irq_get_affinity)
>         	goto fallback;

I don't know if it's possible as I don't know what codepaths are calling
this, it was hard to unwind.  But you should check "just to be safe" :)

thanks,

greg k-h

