Return-Path: <linux-pci+bounces-16502-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC1809C4F24
	for <lists+linux-pci@lfdr.de>; Tue, 12 Nov 2024 08:08:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 951A32836C8
	for <lists+linux-pci@lfdr.de>; Tue, 12 Nov 2024 07:08:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1952620A5FA;
	Tue, 12 Nov 2024 07:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="sbMKW/ZZ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="CekAcoEJ";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="sbMKW/ZZ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="CekAcoEJ"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62A5320896D;
	Tue, 12 Nov 2024 07:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731395315; cv=none; b=hLSCk3GvzqdE0ddtuVZ0PBML/fyhSMKHgrut9TKwWsiXA1ddjvAzsDDk8m0/iMfkxDPQf5TrSJW9jh/Pja/dextU1yrmgt2khskDZy9U+fpLHptqDvMjLevwTw7rWFAgrr/KAMReSp0tw0+TIihXCJW8h2I5msIn9Ktzur+ztro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731395315; c=relaxed/simple;
	bh=vrQYPnvPkwnOGVbKZeFE2tdUgKOwZZe9NQSjPF85vu8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ciVcMeObFQTNKBP7pCyAgP2NLEeBmT1ZTQ2WpbpLzZdcc9Rv8RxueWvauX51d7yjclioEWqh5LApFiLLzKN7jIYojAzsp/8KWBHdcbkufbIidiy4Cnh1e1nPDS7PzvbFeAhUBVaFhBT0pc769hw3VW0dn8maZnQ/CGCe97Qo3QQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=sbMKW/ZZ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=CekAcoEJ; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=sbMKW/ZZ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=CekAcoEJ; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 60AA91F392;
	Tue, 12 Nov 2024 07:08:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1731395311; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RvwaZ5tqmJV+DDeMh7qgM/mceOFWLKmoe02o8C9+SaY=;
	b=sbMKW/ZZt9DlH5SA+y/EXiSb5IMFILZ160su4hZf18CA0gzi77/hYrwEn0Bkt/MM2Hi5jC
	dLWyfclPAPs+zHVAxEmnMUvTND+9YH4vIyvjm9b8qbDE/I2JY2gVe7H+diSd/yNyztF+tA
	hX3RfYk35x+0KwAlTtmiJD6SbwKByY0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1731395311;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RvwaZ5tqmJV+DDeMh7qgM/mceOFWLKmoe02o8C9+SaY=;
	b=CekAcoEJOUJ9J7pCi6NFhTQ/VeSvse/ODooMi1PugFpm2y4rQkrXI7Ong18HECFFbWoYWJ
	gkqyJ76PrFfcOyCw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="sbMKW/ZZ";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=CekAcoEJ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1731395311; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RvwaZ5tqmJV+DDeMh7qgM/mceOFWLKmoe02o8C9+SaY=;
	b=sbMKW/ZZt9DlH5SA+y/EXiSb5IMFILZ160su4hZf18CA0gzi77/hYrwEn0Bkt/MM2Hi5jC
	dLWyfclPAPs+zHVAxEmnMUvTND+9YH4vIyvjm9b8qbDE/I2JY2gVe7H+diSd/yNyztF+tA
	hX3RfYk35x+0KwAlTtmiJD6SbwKByY0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1731395311;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RvwaZ5tqmJV+DDeMh7qgM/mceOFWLKmoe02o8C9+SaY=;
	b=CekAcoEJOUJ9J7pCi6NFhTQ/VeSvse/ODooMi1PugFpm2y4rQkrXI7Ong18HECFFbWoYWJ
	gkqyJ76PrFfcOyCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3C7C013301;
	Tue, 12 Nov 2024 07:08:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id dpcTDO/+MmdYcAAAD6G6ig
	(envelope-from <dwagner@suse.de>); Tue, 12 Nov 2024 07:08:31 +0000
Date: Tue, 12 Nov 2024 08:08:30 +0100
From: Daniel Wagner <dwagner@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: Daniel Wagner <wagi@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
	Bjorn Helgaas <bhelgaas@google.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Jason Wang <jasowang@redhat.com>, "Martin K. Petersen" <martin.petersen@oracle.com>, 
	Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, virtualization@lists.linux.dev, 
	linux-scsi@vger.kernel.org, megaraidlinux.pdl@broadcom.com, mpi3mr-linuxdrv.pdl@broadcom.com, 
	MPT-FusionLinux.pdl@broadcom.com, storagedev@microchip.com, linux-nvme@lists.infradead.org
Subject: Re: [PATCH v2 1/6] blk-mq: introduce blk_mq_hctx_map_queues
Message-ID: <54e689a5-cb34-4039-a79e-92034ec8e2d7@flourine.local>
References: <20241111-refactor-blk-affinity-helpers-v2-0-f360ddad231a@kernel.org>
 <20241111-refactor-blk-affinity-helpers-v2-1-f360ddad231a@kernel.org>
 <20241112044736.GA8883@lst.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241112044736.GA8883@lst.de>
X-Rspamd-Queue-Id: 60AA91F392
X-Spam-Score: -4.51
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
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

On Tue, Nov 12, 2024 at 05:47:36AM +0100, Christoph Hellwig wrote:
> This seems to mix up a few different things:
> 
>  1) adding a new bus operation
>  2) implementations of that operation for PCI and virtio
>  3) a block layer consumer of the operation
> 
> all these really should be separate per-subsystem patches.
> 
> You'll also need to Cc the driver model maintainers.

Ok, will do.

> > +void blk_mq_hctx_map_queues(struct blk_mq_queue_map *qmap,
> > +			    struct device *dev, unsigned int offset,
> > +			    get_queue_affinity_fn *get_irq_affinity)
> > +{
> > +	const struct cpumask *mask = NULL;
> > +	unsigned int queue, cpu;
> > +
> > +	for (queue = 0; queue < qmap->nr_queues; queue++) {
> > +		if (get_irq_affinity)
> > +			mask = get_irq_affinity(dev, queue + offset);
> > +		else if (dev->bus->irq_get_affinity)
> > +			mask = dev->bus->irq_get_affinity(dev, queue + offset);
> > +
> > +		if (!mask)
> > +			goto fallback;
> > +
> > +		for_each_cpu(cpu, mask)
> > +			qmap->mq_map[cpu] = qmap->queue_offset + queue;
> > +	}
> 
> This does different things with a NULL argument vs not.  Please split it
> into two separate helpers.  The non-NULL case is only uses in hisi_sas,
> so it might be worth just open coding it there as well.

I'd like to avoid the open coding case, because this will make the
following patches to support the isolated cpu  patches more complex.
Having a central place where the all the mask operation are, makes it a
bit simpler streamlined. But then I could open code that part as well.

> > +static const struct cpumask *pci_device_irq_get_affinity(struct device *dev,
> > +					unsigned int irq_vec)
> > +{
> > +	struct pci_dev *pdev = to_pci_dev(dev);
> > +
> > +	return pci_irq_get_affinity(pdev, irq_vec);
> 
> Nit: this could be shortened to:
> 
> 	return pci_irq_get_affinity(to_pci_dev(dev), irq_vec);

Ok.

Thanks,
Daniel

