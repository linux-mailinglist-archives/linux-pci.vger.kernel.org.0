Return-Path: <linux-pci+bounces-16655-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E4FAA9C71D5
	for <lists+linux-pci@lfdr.de>; Wed, 13 Nov 2024 15:00:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 52F34B36B5C
	for <lists+linux-pci@lfdr.de>; Wed, 13 Nov 2024 13:57:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 914D020606E;
	Wed, 13 Nov 2024 13:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="GTnOZNgK"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47D221FF610;
	Wed, 13 Nov 2024 13:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731506068; cv=none; b=AIkRlxnhgsHeG7b122wXzHZvmVjmKtYan4J+VwRTY7ivVCUUamU2TqlWTogGbqNzCCDDhgOxVjRI/y9mNr0diXYfZGWmgs+RYk54ysF+tvl6pwYntNm6edLXwBqEbkPoUr5PH1OcKt6aaESF0w4CkUpN2f0VDpaERAaupYy4CGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731506068; c=relaxed/simple;
	bh=3B/JCdh4iX3172gc1ZApZTKHI0NdrBjDEoJdyOuJKVg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PGLn0AXO4JoHZL5f/WSTWYpmMHplXfI3BX/VG6MAqWblHDM4R98ulxuMhGUyaFWOS0xAsDL1qvpewoP6wo4w14zWoh8g0tqdxgYyJZGIacnMCUVXypxdtuD1XclJd2l81qmksgDIE9/NMkAS+gX9enhqr7efXX7aKviR0L9bHS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=GTnOZNgK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D5DDC4CEC3;
	Wed, 13 Nov 2024 13:54:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1731506066;
	bh=3B/JCdh4iX3172gc1ZApZTKHI0NdrBjDEoJdyOuJKVg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GTnOZNgKse/6G382NfGAX65+kCSYHKUzAxz0956dUBqo8v40DlGKgyR586nlN3IJw
	 ofuXXUrwDQCp6V46XTbPsSv3ex0dB+Jo9L1ITVX0d2b4pwAhhbQ3/s/gAyosdw64y+
	 sgZN9gs5iFNYdC0rf0Gt40QH65rx3mjQHbcDeOu0=
Date: Wed, 13 Nov 2024 14:54:23 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: John Garry <john.g.garry@oracle.com>
Cc: Daniel Wagner <dwagner@suse.de>, Daniel Wagner <wagi@kernel.org>,
	Jens Axboe <axboe@kernel.dk>, Bjorn Helgaas <bhelgaas@google.com>,
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
Message-ID: <2024111323-darkening-sappy-23fa@gregkh>
References: <20241112-refactor-blk-affinity-helpers-v3-0-573bfca0cbd8@kernel.org>
 <20241112-refactor-blk-affinity-helpers-v3-1-573bfca0cbd8@kernel.org>
 <76da6c05-4f28-41cc-a48e-da2ae16c64c4@oracle.com>
 <2d85aa5e-037a-45c3-9f2d-e46b2159b697@flourine.local>
 <bed15207-c3d8-4e0b-b356-4880f5a4fdff@oracle.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bed15207-c3d8-4e0b-b356-4880f5a4fdff@oracle.com>

On Wed, Nov 13, 2024 at 01:44:02PM +0000, John Garry wrote:
> On 13/11/2024 12:36, Daniel Wagner wrote:
> > > > @@ -48,6 +48,7 @@ struct fwnode_handle;
> > > >     *		will never get called until they do.
> > > >     * @remove:	Called when a device removed from this bus.
> > > My impression is that this would be better suited to "struct device_driver",
> > > but I assume that there is a good reason to add to "struct bus_type".
> > I think the main reason to put it here is that most of the drivers are
> > happy with the getter on bus level and don't need special treatment. We
> > don't have to touch all the drivers to hookup a common getter, nor do we
> > have to install a default handler when the driver doesn't specify one.
> > Having the callback in struct bus_driver avoids this. Though Christoph
> > suggested it, so I can only guess.
> > 
> > But you bring up a good point, if we had also an irq_get_affinity
> > callback in struct device_driver it would be possible for the
> > hisi_sas v2 driver to provide a getter and blk_mq_hctx_map_queues could
> > do:
> > 
> > 	for (queue = 0; queue < qmap->nr_queues; queue++) {
> > 		if (dev->driver->irq_get_affinity)
> > 			mask = dev->driver->irq_get_affinity;
> > 		else if (dev->bus->irq_get_affinity)
> > 			mask = dev->bus->irq_get_affinity(dev, queue + offset);
> > 		if (!mask)
> > 			goto fallback;
> > 
> > 		for_each_cpu(cpu, mask)
> > 			qmap->mq_map[cpu] = qmap->queue_offset + queue;
> > 	}
> > 
> > and with this in place the open coded version in hisi_sas v2 can also be
> > replaced.
> 
> Yeah, I think that it could be plugged in like:
> 
> diff --git a/drivers/scsi/hisi_sas/hisi_sas_v2_hw.c
> b/drivers/scsi/hisi_sas/hisi_sas_v2_hw.c
> index 342d75f12051..5172af77a3f0 100644
> --- a/drivers/scsi/hisi_sas/hisi_sas_v2_hw.c
> +++ b/drivers/scsi/hisi_sas/hisi_sas_v2_hw.c
> @@ -3636,6 +3636,7 @@ static struct platform_driver hisi_sas_v2_driver = {
>                .name = DRV_NAME,
>                .of_match_table = sas_v2_of_match,
>                .acpi_match_table = ACPI_PTR(sas_v2_acpi_match),
> +               .irq_get_affinity_mask = hisi_sas_v2_get_affinity_mask,
>        },
> };
> 
> 
> > If no one objects, I go ahead and add the callback to struct
> > device_driver.
> 
> I'd wait for Christoph and Greg to both agree. I was just wondering why we
> use bus_type.

bus types are good to set it at a bus level so you don't have to
explicitly set it at each-and-every-driver.  Depends on what you want
this to be, if it is a "all drivers of this bus type will have the same
callback" then put it on the bus.  otherwise if you are going to
mix/match on a same bus, then put it in the driver structure.

hope this helps,

greg k-h

