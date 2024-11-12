Return-Path: <linux-pci+bounces-16566-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ED829C5F00
	for <lists+linux-pci@lfdr.de>; Tue, 12 Nov 2024 18:32:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4095AB2CB9C
	for <lists+linux-pci@lfdr.de>; Tue, 12 Nov 2024 16:15:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B27EA2038A7;
	Tue, 12 Nov 2024 16:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="u3cWQ+wM";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Vq25pLCB";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="u3cWQ+wM";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Vq25pLCB"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4E92200B84;
	Tue, 12 Nov 2024 16:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731428135; cv=none; b=enWez5u7taXM6CZi0l5Z3WrHLchUCUXJ3mfuI2E7w6YBx+jnk2Z1rYsu5UClRF9tyKf3Wrsm5H7RGcgseT76XvOLvfrWNF7lhVO7AXER4DJfQP1D0YKuo++s79tB1BQtBN7rYqlPamxjIamohbvrxyFgyxlNEmsbC1N5zs38i0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731428135; c=relaxed/simple;
	bh=FF32yP9KdVfRXMndbaibFOS0cSrXZc8DWTEIL7tpkb0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uPaBsPVdM82mNycU+YqkfXKFcQNDZx8ihHlybvCL8uWqDGOlgwElo1bkk6x5svENJfpdOT8rFpSixoPoa/JgDq19UM8LtJciCjE9pY/b3rmLaZpCS3xaI6kL2w/UIzpggQc/2V22jP0KpAx/0yxBrcpF+L/kfTAo45F9sus7A3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=u3cWQ+wM; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Vq25pLCB; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=u3cWQ+wM; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Vq25pLCB; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 0CFB61F451;
	Tue, 12 Nov 2024 16:15:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1731428132; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zPpDV4VXC/O5LDmKqzdbg/wDQnAvo0nuoIGwwECCHkw=;
	b=u3cWQ+wMMzAJP2k50djmt7ul83n2pp3ULngZXQJrgOPferHT/zAjDf5sKR3BKNgjqIlg3S
	M+lBeQTR6jkT80Vd1vaHM/5KjtEAa/DIdsKeTWkfvO7r/SmCcvpWJeuvLDh4X40hUYmW/2
	/z8wG0vkcNSLPHUK9NJK8pfwjA4ZmVg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1731428132;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zPpDV4VXC/O5LDmKqzdbg/wDQnAvo0nuoIGwwECCHkw=;
	b=Vq25pLCB8TEXXhq7TDInKAnh0I12FTfGKkf/m4FzXhXeiANtYeVEJWqoJIux3sK73MS32c
	LrbEGMqGoC+sh8Aw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=u3cWQ+wM;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=Vq25pLCB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1731428132; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zPpDV4VXC/O5LDmKqzdbg/wDQnAvo0nuoIGwwECCHkw=;
	b=u3cWQ+wMMzAJP2k50djmt7ul83n2pp3ULngZXQJrgOPferHT/zAjDf5sKR3BKNgjqIlg3S
	M+lBeQTR6jkT80Vd1vaHM/5KjtEAa/DIdsKeTWkfvO7r/SmCcvpWJeuvLDh4X40hUYmW/2
	/z8wG0vkcNSLPHUK9NJK8pfwjA4ZmVg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1731428132;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zPpDV4VXC/O5LDmKqzdbg/wDQnAvo0nuoIGwwECCHkw=;
	b=Vq25pLCB8TEXXhq7TDInKAnh0I12FTfGKkf/m4FzXhXeiANtYeVEJWqoJIux3sK73MS32c
	LrbEGMqGoC+sh8Aw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DC27013721;
	Tue, 12 Nov 2024 16:15:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id JJNjMyN/M2eAHAAAD6G6ig
	(envelope-from <dwagner@suse.de>); Tue, 12 Nov 2024 16:15:31 +0000
Date: Tue, 12 Nov 2024 17:15:31 +0100
From: Daniel Wagner <dwagner@suse.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Daniel Wagner <wagi@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
	Bjorn Helgaas <bhelgaas@google.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, "Martin K. Petersen" <martin.petersen@oracle.com>, 
	Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
	virtualization@lists.linux.dev, linux-scsi@vger.kernel.org, megaraidlinux.pdl@broadcom.com, 
	mpi3mr-linuxdrv.pdl@broadcom.com, MPT-FusionLinux.pdl@broadcom.com, storagedev@microchip.com, 
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH v3 4/8] blk-mp: introduce blk_mq_hctx_map_queues
Message-ID: <5967d256-037e-4ac8-a509-c6955b03db05@flourine.local>
References: <20241112-refactor-blk-affinity-helpers-v3-0-573bfca0cbd8@kernel.org>
 <20241112-refactor-blk-affinity-helpers-v3-4-573bfca0cbd8@kernel.org>
 <2024111202-parish-prowess-78bc@gregkh>
 <c8c671c1-267a-4aa7-a64b-51a461176ad3@flourine.local>
 <2024111215-jury-unlighted-3953@gregkh>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024111215-jury-unlighted-3953@gregkh>
X-Rspamd-Queue-Id: 0CFB61F451
X-Spam-Score: -4.51
X-Rspamd-Action: no action
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
	RCPT_COUNT_TWELVE(0.00)[22];
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
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Tue, Nov 12, 2024 at 04:42:40PM +0100, Greg Kroah-Hartman wrote:
> On Tue, Nov 12, 2024 at 04:33:09PM +0100, Daniel Wagner wrote:
> > On Tue, Nov 12, 2024 at 02:58:43PM +0100, Greg Kroah-Hartman wrote:
> > > > +void blk_mq_hctx_map_queues(struct blk_mq_queue_map *qmap,
> > > > +			    struct device *dev, unsigned int offset)
> > > > +
> > > > +{
> > > > +	const struct cpumask *mask;
> > > > +	unsigned int queue, cpu;
> > > > +
> > > > +	if (!dev->bus->irq_get_affinity)
> > > > +		goto fallback;
> > > 
> > > I think this is better than hard-coding it, but are you sure that the
> > > bus will always be bound to the device here so that you have a valid
> > > bus-> pointer?
> > 
> > No, I just assumed the bus pointer is always valid. If it is possible to
> > have a device without a bus, than I'll better extend the condition to
> > 
> > 	if (!dev->bus || !dev->bus->irq_get_affinity)
> >         	goto fallback;
> 
> I don't know if it's possible as I don't know what codepaths are calling
> this, it was hard to unwind.  But you should check "just to be safe" :)

The main path to map_queues is via the probe functions. There are some
more paths like when updating a tagset after the number of queues but
that is all after the probe function.

nvme_probe
  nvme_alloc_admin_tag_set
    blk_mq_alloc_tag_set
       blk_mq_update_queue_map
          set->ops->map_queues
	     blk_mq_htcx_map_queues
  nvme_alloc_io_tag_set
    blk_mq_alloc_tag_set
      blk_mq_update_queue_map
        set->ops->map_queues
          blk_mq_htcx_map_queues

virtscsi_probe, hisi_sas_v3_probe, ...
  scsi_add_host
    scsi_add_host_with_dma
      scsi_mq_setup_tags
         blk_mq_alloc_tag_set
           blk_mq_update_queue_map
             set->ops->map_queues
               blk_mq_htcx_map_queues

virtblk_probe
  blk_mq_alloc_tag_set
    blk_mq_update_queue_map
      set->ops->map_queues
        blk_mq_htcx_map_queues

Does this help?

