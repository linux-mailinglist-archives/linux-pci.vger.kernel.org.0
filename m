Return-Path: <linux-pci+bounces-17150-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 776359D4A23
	for <lists+linux-pci@lfdr.de>; Thu, 21 Nov 2024 10:44:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31C1F282760
	for <lists+linux-pci@lfdr.de>; Thu, 21 Nov 2024 09:44:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDE11126C05;
	Thu, 21 Nov 2024 09:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="hiJpjGUm";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="p09axkX1";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="deNrSzzs";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="4ylzFtLw"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D581C1BE84B;
	Thu, 21 Nov 2024 09:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732182278; cv=none; b=tus2UNEUF7pxsuCGsuTvnxwTITkNKPczPzv9HG+hiob2KzsTsO0mVnMsJBSDrwDbjCmtJQPPVm8bD3ewsWLNrYz1S2wtT7CFhM15uRhBRTg4CCc9hAZcvQ9ZGHeqcOMRwNkOGA9F1aKdcTsfRhgt0uaGlJTyKRi7o/zc6E5gHp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732182278; c=relaxed/simple;
	bh=CWXEmTiuxTm1gnZyIlscNfEmNCI3QzblDQH3eyHM5nA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=idTy7atuFuVCwtZGZ30Nsox2uEo1XDMBFxr7kh9jR50P8RvFg0j/maN4z/aXYqYw5QLZ8AF/LwOode/J+6m1r4puRbPrgDrh9hNYJluz5xdA6XRsyiNWUfCeGeKQCinLlsPhfs2W6eP+y/o1UNIgp7fTCytA28OCETAPcUyAQTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=hiJpjGUm; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=p09axkX1; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=deNrSzzs; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=4ylzFtLw; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id DB6DA211CA;
	Thu, 21 Nov 2024 09:44:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1732182274; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Bqjqjo6BeiVlXwbN7PTqQaBDzTD5jQsIbQrGvlF++tQ=;
	b=hiJpjGUm8ogVrODQNPmQIO5MB3ah7hl2QrKIV86gMUAbYwhKDQyYipSUm1C/SmkrBxrHAR
	KAYw1tNwQJ3QjttQOuzGyHR2RRwL7+OmkVHQUldV/2FvXCgSau+/TCasp45nlJX7lUwDUk
	f4DpIGpHzi03I0eod6QBIJvg8J3+1EY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1732182274;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Bqjqjo6BeiVlXwbN7PTqQaBDzTD5jQsIbQrGvlF++tQ=;
	b=p09axkX1mUAAWJ72FOOLxepeR/y01fTuv2w3A7qiqBL6qN0WuKtMgpGIdbfu0u+qYD7t7H
	J1SmAKMd84rsJIAQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=deNrSzzs;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=4ylzFtLw
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1732182272; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Bqjqjo6BeiVlXwbN7PTqQaBDzTD5jQsIbQrGvlF++tQ=;
	b=deNrSzzszLXj7e2zlJNVCUm8l0E5oaKmQiZWmlo4h3ADER+hm8NpTcv514HN50obLbFUnb
	yA7OMixvGzU69SI3zoJGcdhJOGJ8ytzV4aDaurv6V2ckSDwrJoSxlYPnfIYM1xKW2LOAiz
	5468b3aUrdAn7GlH9Fp3KEWiHsSBRCY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1732182272;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Bqjqjo6BeiVlXwbN7PTqQaBDzTD5jQsIbQrGvlF++tQ=;
	b=4ylzFtLwSW2Q2dhX0IypXlzfPNdeRVmQ85OClmNaqdRg6RC+vW+g0fNc9MSyAs6sAQyYGu
	4XdPA31qqKF9zCDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B74DC13927;
	Thu, 21 Nov 2024 09:44:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id +eS3LAABP2e5XQAAD6G6ig
	(envelope-from <dwagner@suse.de>); Thu, 21 Nov 2024 09:44:32 +0000
Date: Thu, 21 Nov 2024 10:44:32 +0100
From: Daniel Wagner <dwagner@suse.de>
To: John Garry <john.g.garry@oracle.com>
Cc: Daniel Wagner <wagi@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
	Bjorn Helgaas <bhelgaas@google.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, "Martin K. Petersen" <martin.petersen@oracle.com>, 
	Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Hannes Reinecke <hare@suse.de>, Ming Lei <ming.lei@redhat.com>, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
	virtualization@lists.linux.dev, linux-scsi@vger.kernel.org, megaraidlinux.pdl@broadcom.com, 
	mpi3mr-linuxdrv.pdl@broadcom.com, MPT-FusionLinux.pdl@broadcom.com, storagedev@microchip.com, 
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH v5 3/8] virtio: hookup irq_get_affinity callback
Message-ID: <ffe464b8-5991-49f0-9053-4f0a52af4fe7@flourine.local>
References: <20241115-refactor-blk-affinity-helpers-v5-0-c472afd84d9f@kernel.org>
 <20241115-refactor-blk-affinity-helpers-v5-3-c472afd84d9f@kernel.org>
 <eae15480-403a-45c8-a8d0-4a34339d6b36@oracle.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eae15480-403a-45c8-a8d0-4a34339d6b36@oracle.com>
X-Rspamd-Queue-Id: DB6DA211CA
X-Spam-Score: -4.51
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[25];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,flourine.local:mid,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Thu, Nov 21, 2024 at 09:01:49AM +0000, John Garry wrote:
> > --- a/drivers/virtio/virtio.c
> > +++ b/drivers/virtio/virtio.c
> > @@ -377,6 +377,24 @@ static void virtio_dev_remove(struct device *_d)
> >   	of_node_put(dev->dev.of_node);
> >   }
> > +/**
> 
> nit: does this really need to be kerneldoc, as it is static?

No, it's not necessary, I didn't know what the rules for static
functions are. I'll update it accordingly.

