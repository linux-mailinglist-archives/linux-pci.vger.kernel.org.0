Return-Path: <linux-pci+bounces-16736-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 742779C8457
	for <lists+linux-pci@lfdr.de>; Thu, 14 Nov 2024 08:54:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A1E91F222E6
	for <lists+linux-pci@lfdr.de>; Thu, 14 Nov 2024 07:54:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DE331F4718;
	Thu, 14 Nov 2024 07:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="GiE9vj8x";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="kwNAhIDy";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="GiE9vj8x";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="kwNAhIDy"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C10441CAAC;
	Thu, 14 Nov 2024 07:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731570890; cv=none; b=E1Ef8GLXFtIcEMS0J4MnV8G1X0gLxbmITMYT624aLOOHHnwrdOq41WPjUsEoAXjZCVnIgNCswDsuMjHTxRSFd09U1TSLofy0vuQmMCiv13Mbutm9flxrbEs5EKACqzkU1xkzZ/d8Q9jlDnJr095dCxdGdp5Msyk4e6XYOxkcjKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731570890; c=relaxed/simple;
	bh=qpHPqvyCCYzqYEOCriYI3vUcZNTa6fXXadKZM0uAwWE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dgMyxhMdTkgXut0TUTsPC9tYGJYOme/Mgvde74unbHbbTwkMR4hThXxaZi43JhzEbxYA/g82KbNa1hzNY63CW0nDxLvTaQh02ztIkrgYm5W0lzoZrePPyZyagDAJpAfrrkHABVjgU/DxbcFezl9NpIQnfYQedcMBDadKY/eJlAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=GiE9vj8x; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=kwNAhIDy; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=GiE9vj8x; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=kwNAhIDy; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 184CF2195D;
	Thu, 14 Nov 2024 07:54:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1731570887; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=q1M4KBBuOBQeKqCrAK5JFelRyjsClhaHzFF8BcJuDmI=;
	b=GiE9vj8x1O1N5ASVREAFOUMEMISoo31skDN+DgSWv9F2Fov+Dl7ZwEGzVuLgSeDUImvPzB
	nD/flv8/De3SgoqQTqvBuesuFSaBX0SreRUJR/RgCtacsNzS7MJB35cynn5tyUxX/ZSsVn
	srR7BEEzrPNRRZlmDxCKW2rW8chD8E0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1731570887;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=q1M4KBBuOBQeKqCrAK5JFelRyjsClhaHzFF8BcJuDmI=;
	b=kwNAhIDyRojzPQtx06qL5++OAHC3R3V5i01m97PIeo0DP0kPGjdHi3kKGaBh4sYavHIgvv
	rVEHds2mLLEUvEBg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1731570887; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=q1M4KBBuOBQeKqCrAK5JFelRyjsClhaHzFF8BcJuDmI=;
	b=GiE9vj8x1O1N5ASVREAFOUMEMISoo31skDN+DgSWv9F2Fov+Dl7ZwEGzVuLgSeDUImvPzB
	nD/flv8/De3SgoqQTqvBuesuFSaBX0SreRUJR/RgCtacsNzS7MJB35cynn5tyUxX/ZSsVn
	srR7BEEzrPNRRZlmDxCKW2rW8chD8E0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1731570887;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=q1M4KBBuOBQeKqCrAK5JFelRyjsClhaHzFF8BcJuDmI=;
	b=kwNAhIDyRojzPQtx06qL5++OAHC3R3V5i01m97PIeo0DP0kPGjdHi3kKGaBh4sYavHIgvv
	rVEHds2mLLEUvEBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E8BD513794;
	Thu, 14 Nov 2024 07:54:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id o2HIOMasNWfVawAAD6G6ig
	(envelope-from <dwagner@suse.de>); Thu, 14 Nov 2024 07:54:46 +0000
Date: Thu, 14 Nov 2024 08:54:46 +0100
From: Daniel Wagner <dwagner@suse.de>
To: Ming Lei <ming.lei@redhat.com>
Cc: Daniel Wagner <wagi@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
	Bjorn Helgaas <bhelgaas@google.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, "Martin K. Petersen" <martin.petersen@oracle.com>, 
	Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
	John Garry <john.g.garry@oracle.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Hannes Reinecke <hare@suse.de>, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pci@vger.kernel.org, virtualization@lists.linux.dev, linux-scsi@vger.kernel.org, 
	megaraidlinux.pdl@broadcom.com, mpi3mr-linuxdrv.pdl@broadcom.com, 
	MPT-FusionLinux.pdl@broadcom.com, storagedev@microchip.com, linux-nvme@lists.infradead.org
Subject: Re: [PATCH v4 05/10] blk-mq: introduce blk_mq_hctx_map_queues
Message-ID: <9fa26099-1922-4b99-883e-bd5f6c58162a@flourine.local>
References: <20241113-refactor-blk-affinity-helpers-v4-0-dd3baa1e267f@kernel.org>
 <20241113-refactor-blk-affinity-helpers-v4-5-dd3baa1e267f@kernel.org>
 <ZzVZQbZOYhNF08LX@fedora>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZzVZQbZOYhNF08LX@fedora>
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[25];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_DN_SOME(0.00)[]
X-Spam-Score: -4.30
X-Spam-Flag: NO

On Thu, Nov 14, 2024 at 09:58:25AM +0800, Ming Lei wrote:
> > +void blk_mq_hctx_map_queues(struct blk_mq_queue_map *qmap,
> 
> Some drivers may not know hctx at all, maybe blk_mq_map_hw_queues()?

I am not really attach to the name, I am fine with renaming it to
blk_mq_map_hw_queues.

> > +	if (dev->driver->irq_get_affinity)
> > +		irq_get_affinity = dev->driver->irq_get_affinity;
> > +	else if (dev->bus->irq_get_affinity)
> > +		irq_get_affinity = dev->bus->irq_get_affinity;
> 
> It is one generic API, I think both 'dev->driver' and
> 'dev->bus' should be validated here.

What do you have in mind here if we get two masks? What should the
operation be: AND, OR?

This brings up another topic I left out in this series.
blk_mq_map_queues does almost the same thing except it starts with the
mask returned by group_cpus_evenely. If we figure out how this could be
combined in a sane way it's possible to cleanup even a bit more. A bunch
of drivers do

		if (i != HCTX_TYPE_POLL && offset)
			blk_mq_hctx_map_queues(map, dev->dev, offset);
		else
			blk_mq_map_queues(map);

IMO it would be nice just to have one blk_mq_map_queues() which handles
this correctly for both cases.

