Return-Path: <linux-pci+bounces-16639-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF1589C6F70
	for <lists+linux-pci@lfdr.de>; Wed, 13 Nov 2024 13:46:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C2740B234E1
	for <lists+linux-pci@lfdr.de>; Wed, 13 Nov 2024 12:37:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35D5F1DEFE0;
	Wed, 13 Nov 2024 12:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="x6Hpvg+b";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="H+jakr0R";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="x6Hpvg+b";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="H+jakr0R"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99D174C81;
	Wed, 13 Nov 2024 12:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731501421; cv=none; b=D4oo6O7h8Us3OgiFAspbSiRgs88zYfmTNNCGjKOAHPPNI38sLGq6SW55kAoC31BQ7Jor4wKYBCWjBK20vPcIVAcaVxOROrCvwLj3VThpXcQX7IBIOtSWKsFaV5hwK1eQMSJHQD2g4ksJyUUeyb0QqX0jD3nNWaAMXs2xIvF6BCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731501421; c=relaxed/simple;
	bh=18H6NJme3tzBH2IZVv/wJF8kQRj5I/k5ony15utzEWk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rz5J0oN+jxeaOBnlYj60WqM7tp4P40kaCqbtONFNYoHJ6gc2qcfOUeRFrKmJUvePQ2mWq7HfHqA3kg8FZ2l9aF5eIncaoFmybKBiz8d6EkP4BZYfK3TLIgbDQ1y6LiLMqJNiZ0wVago8f5+JWPWuVEIiPXOOIQWM97d33xIl1os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=x6Hpvg+b; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=H+jakr0R; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=x6Hpvg+b; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=H+jakr0R; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id C596E21133;
	Wed, 13 Nov 2024 12:36:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1731501416; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OwZyjST0MC2BE1Uhwog1+2weLgBQ8NK4rlxEdf5P7lU=;
	b=x6Hpvg+bnpaEDcXzXshd05wx1g65KA0JAHTzWCKmfGtymmFhqrO8IbVOfmr8mtsZa7qs9R
	FOHi2SSLS6XIfEgvSJr4L71aE2k13Ry6bqSbdTgR8X6XMsVeIumRyqy9GEhrlWjW46ul2a
	cjVGBeyhOsJ+SBPxuBt6ydqkeqE1ynQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1731501416;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OwZyjST0MC2BE1Uhwog1+2weLgBQ8NK4rlxEdf5P7lU=;
	b=H+jakr0RcjllL8izGR9jTCON1XXq+u5x2wPmJHAmjtMb+r7Gyff6WddEB0fMF92Wh3NKTc
	9OXiBDSeD2rJx/Dw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=x6Hpvg+b;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=H+jakr0R
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1731501416; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OwZyjST0MC2BE1Uhwog1+2weLgBQ8NK4rlxEdf5P7lU=;
	b=x6Hpvg+bnpaEDcXzXshd05wx1g65KA0JAHTzWCKmfGtymmFhqrO8IbVOfmr8mtsZa7qs9R
	FOHi2SSLS6XIfEgvSJr4L71aE2k13Ry6bqSbdTgR8X6XMsVeIumRyqy9GEhrlWjW46ul2a
	cjVGBeyhOsJ+SBPxuBt6ydqkeqE1ynQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1731501416;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OwZyjST0MC2BE1Uhwog1+2weLgBQ8NK4rlxEdf5P7lU=;
	b=H+jakr0RcjllL8izGR9jTCON1XXq+u5x2wPmJHAmjtMb+r7Gyff6WddEB0fMF92Wh3NKTc
	9OXiBDSeD2rJx/Dw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A225813A6E;
	Wed, 13 Nov 2024 12:36:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id cagvJWidNGdbLgAAD6G6ig
	(envelope-from <dwagner@suse.de>); Wed, 13 Nov 2024 12:36:56 +0000
Date: Wed, 13 Nov 2024 13:36:55 +0100
From: Daniel Wagner <dwagner@suse.de>
To: John Garry <john.g.garry@oracle.com>
Cc: Daniel Wagner <wagi@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
	Bjorn Helgaas <bhelgaas@google.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, "Martin K. Petersen" <martin.petersen@oracle.com>, 
	Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pci@vger.kernel.org, virtualization@lists.linux.dev, linux-scsi@vger.kernel.org, 
	megaraidlinux.pdl@broadcom.com, mpi3mr-linuxdrv.pdl@broadcom.com, 
	MPT-FusionLinux.pdl@broadcom.com, storagedev@microchip.com, linux-nvme@lists.infradead.org
Subject: Re: [PATCH v3 1/8] driver core: bus: add irq_get_affinity callback
 to bus_type
Message-ID: <2d85aa5e-037a-45c3-9f2d-e46b2159b697@flourine.local>
References: <20241112-refactor-blk-affinity-helpers-v3-0-573bfca0cbd8@kernel.org>
 <20241112-refactor-blk-affinity-helpers-v3-1-573bfca0cbd8@kernel.org>
 <76da6c05-4f28-41cc-a48e-da2ae16c64c4@oracle.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <76da6c05-4f28-41cc-a48e-da2ae16c64c4@oracle.com>
X-Rspamd-Queue-Id: C596E21133
X-Spam-Level: 
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.51
X-Spam-Flag: NO

On Wed, Nov 13, 2024 at 10:16:32AM +0000, John Garry wrote:
> On 12/11/2024 13:26, Daniel Wagner wrote:
> > Introducing a callback in struct bus_type so that a subsystem
> > can hook up the getters directly. This approach avoids exposing
> > random getters in any subsystems APIs.
> > 
> > Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> > Signed-off-by: Daniel Wagner <wagi@kernel.org>
> > ---
> >   include/linux/device/bus.h | 3 +++
> >   1 file changed, 3 insertions(+)
> > 
> > diff --git a/include/linux/device/bus.h b/include/linux/device/bus.h
> > index cdc4757217f9bb4b36b5c3b8a48bab45737e44c5..b18658bce2c3819fc1cbeb38fb98391d56ec3317 100644
> > --- a/include/linux/device/bus.h
> > +++ b/include/linux/device/bus.h
> > @@ -48,6 +48,7 @@ struct fwnode_handle;
> >    *		will never get called until they do.
> >    * @remove:	Called when a device removed from this bus.
> 
> My impression is that this would be better suited to "struct device_driver",
> but I assume that there is a good reason to add to "struct bus_type".

I think the main reason to put it here is that most of the drivers are
happy with the getter on bus level and don't need special treatment. We
don't have to touch all the drivers to hookup a common getter, nor do we
have to install a default handler when the driver doesn't specify one.
Having the callback in struct bus_driver avoids this. Though Christoph
suggested it, so I can only guess.

But you bring up a good point, if we had also an irq_get_affinity
callback in struct device_driver it would be possible for the
hisi_sas v2 driver to provide a getter and blk_mq_hctx_map_queues could
do:

	for (queue = 0; queue < qmap->nr_queues; queue++) {
		if (dev->driver->irq_get_affinity)
			mask = dev->driver->irq_get_affinity;
		else if (dev->bus->irq_get_affinity)
			mask = dev->bus->irq_get_affinity(dev, queue + offset);
		if (!mask)
			goto fallback;

		for_each_cpu(cpu, mask)
			qmap->mq_map[cpu] = qmap->queue_offset + queue;
	}

and with this in place the open coded version in hisi_sas v2 can also be
replaced. If no one objects, I go ahead and add the callback to struct
device_driver.

