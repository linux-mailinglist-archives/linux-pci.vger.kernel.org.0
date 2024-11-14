Return-Path: <linux-pci+bounces-16731-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A53CB9C83A8
	for <lists+linux-pci@lfdr.de>; Thu, 14 Nov 2024 08:06:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 292261F235E8
	for <lists+linux-pci@lfdr.de>; Thu, 14 Nov 2024 07:06:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2631B1E8857;
	Thu, 14 Nov 2024 07:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="WVugLPoF";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="O925Po6W";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="WVugLPoF";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="O925Po6W"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E9801EBA11;
	Thu, 14 Nov 2024 07:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731568004; cv=none; b=UuTWzbv00uxiC/JbZP+MQEkcwjcORJlZgJHRaRDu4M0Tb2a6NTTRRy68J+PHti88dEhH0PLV2eJVeV49czCQxKcCNaJ9cd/KRZtnGDvvlXSemTZguwCo53qazjmkljjlici4b4NS9XIMplnrDWWupIxsujikUTquMTkfdsbsOkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731568004; c=relaxed/simple;
	bh=/SG7Ig4cUtBXYK/1m515uXG2/KXqSgjybFUN+smF5KM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r4N0HZm1tz/Q6gfCYLLBvkKYy6l+NP1VInVy5gedfzIv1+ilgynKZxn9V3G50Ml1E2qrR8PMpzc2Z9UIQ2b4XecFMujDaaQkvzUzNVFL3MVqMzn+p4eAfSfrov7BoWHupPnzIVk2rNXnwItpxbqCwDp2IeVZ0bM88DnZJx7cC3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=WVugLPoF; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=O925Po6W; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=WVugLPoF; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=O925Po6W; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 04DDB1F80A;
	Thu, 14 Nov 2024 07:06:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1731568000; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3uC3SxsQS0t7XBZ9iU9FybgeRCb0qSAicxdaj6FRoik=;
	b=WVugLPoFqQF1PdX/f38YjvPeYR176YqYihc/KyBjVIRxGOeaSfqdNsYHAbNpTzWZyKThIi
	Gb8amy6LBGoNgb4EA2NEOGvSN/tlee8qByuWakHUZDbBjOuui/g1bnEdscfi83JLk2Np8Y
	7mYHPior5SMInEd9Jyvb+q7Ln9zrK1M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1731568000;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3uC3SxsQS0t7XBZ9iU9FybgeRCb0qSAicxdaj6FRoik=;
	b=O925Po6WR2sVDfKkLBuXExNrBw2ibF87FCrLCbz6CHP/rKVRAU4t/w0yQxtLXKchaknQPq
	PcvSu8c4UP150DCA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=WVugLPoF;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=O925Po6W
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1731568000; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3uC3SxsQS0t7XBZ9iU9FybgeRCb0qSAicxdaj6FRoik=;
	b=WVugLPoFqQF1PdX/f38YjvPeYR176YqYihc/KyBjVIRxGOeaSfqdNsYHAbNpTzWZyKThIi
	Gb8amy6LBGoNgb4EA2NEOGvSN/tlee8qByuWakHUZDbBjOuui/g1bnEdscfi83JLk2Np8Y
	7mYHPior5SMInEd9Jyvb+q7Ln9zrK1M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1731568000;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3uC3SxsQS0t7XBZ9iU9FybgeRCb0qSAicxdaj6FRoik=;
	b=O925Po6WR2sVDfKkLBuXExNrBw2ibF87FCrLCbz6CHP/rKVRAU4t/w0yQxtLXKchaknQPq
	PcvSu8c4UP150DCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D4C4313794;
	Thu, 14 Nov 2024 07:06:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Pg/rM3+hNWfoXAAAD6G6ig
	(envelope-from <dwagner@suse.de>); Thu, 14 Nov 2024 07:06:39 +0000
Date: Thu, 14 Nov 2024 08:06:39 +0100
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
Subject: Re: [PATCH v4 02/10] driver core: add irq_get_affinity callback
 device_driver
Message-ID: <d441a856-3c81-4db2-a904-5167d26aaf53@flourine.local>
References: <20241113-refactor-blk-affinity-helpers-v4-0-dd3baa1e267f@kernel.org>
 <20241113-refactor-blk-affinity-helpers-v4-2-dd3baa1e267f@kernel.org>
 <ZzVX92YaqVpW9cPw@fedora>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZzVX92YaqVpW9cPw@fedora>
X-Rspamd-Queue-Id: 04DDB1F80A
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
	RCPT_COUNT_TWELVE(0.00)[25];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Thu, Nov 14, 2024 at 09:52:55AM +0800, Ming Lei wrote:
> On Wed, Nov 13, 2024 at 03:26:16PM +0100, Daniel Wagner wrote:
> > Introducing a callback in struct device_driver so that a device driver
> > can hook up the getters directly. This approach avoids exposing random
> > getters in drivers.
> > 
> > Signed-off-by: Daniel Wagner <wagi@kernel.org>
> > ---
> >  include/linux/device/driver.h | 3 +++
> >  1 file changed, 3 insertions(+)
> > 
> > diff --git a/include/linux/device/driver.h b/include/linux/device/driver.h
> > index 5c04b8e3833b995f9fd4d65b8732b3dfce2eba7e..0d1aee423f6c076ae102bdd0536233c259947fac 100644
> > --- a/include/linux/device/driver.h
> > +++ b/include/linux/device/driver.h
> > @@ -74,6 +74,7 @@ enum probe_type {
> >   * @suspend:	Called to put the device to sleep mode. Usually to a
> >   *		low power state.
> >   * @resume:	Called to bring a device from sleep mode.
> > + * @irq_get_affinity:	Get IRQ affinity mask for the device.
> >   * @groups:	Default attributes that get created by the driver core
> >   *		automatically.
> >   * @dev_groups:	Additional attributes attached to device instance once
> > @@ -112,6 +113,8 @@ struct device_driver {
> >  	void (*shutdown) (struct device *dev);
> >  	int (*suspend) (struct device *dev, pm_message_t state);
> >  	int (*resume) (struct device *dev);
> > +	const struct cpumask *(*irq_get_affinity)(struct device *dev,
> > +			unsigned int irq_vec);
> >  	const struct attribute_group **groups;
> >  	const struct attribute_group **dev_groups;
> 
> The patch looks fine, but if you put 1, 2 and 5 into single patch,
> it will become much easier to review, anyway:

1 and 2 makes sense to merge. Christoph asked me to split 5 out 1 as it
mixed different things together

https://lore.kernel.org/linux-nvme/20241112044736.GA8883@lst.de/

