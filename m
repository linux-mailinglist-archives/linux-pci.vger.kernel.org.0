Return-Path: <linux-pci+bounces-17530-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E7CAF9E056C
	for <lists+linux-pci@lfdr.de>; Mon,  2 Dec 2024 15:47:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 11284B30509
	for <lists+linux-pci@lfdr.de>; Mon,  2 Dec 2024 13:49:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CF631FF7C9;
	Mon,  2 Dec 2024 13:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="zSnEGhJM";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="SVggcK2d";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="zSnEGhJM";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="SVggcK2d"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8065AAD5E;
	Mon,  2 Dec 2024 13:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733147346; cv=none; b=fHTI97Vi58/z+zI0yDtINEJbIA9xS2ZYEhyDl0tElHA08w9rzv9QGvu99v2cVMES3gm4geFst+/QxgHTRKpEo81x2II5PEavsh5qV3mrXhJStedhhdlWe3GWTXsAyk6MctFq0GaIymy4arWeskWCAE750lVT0G6T3/sGkQ7TdAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733147346; c=relaxed/simple;
	bh=Ah5hWMdfPFzst6CBjRABiissd/71Qcp2TxJFwtVPowE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EtPdsBjTAF5vz9m86450CrUcK57BYQDdgTWuZDcc8VsWQOggH7GlaqrJepeJnr1l/Rv+rRv+3TUrB7TYkjWPxGed/7HXZBxGO2PLNLiC0L3XBSgY64AJhbRMHLRPiaXfpN2SiyNTuBwVRPKUNertjhXPPV2aiu9Q0MaG9IerApc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=zSnEGhJM; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=SVggcK2d; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=zSnEGhJM; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=SVggcK2d; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 57201211CF;
	Mon,  2 Dec 2024 13:49:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1733147342; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9qx7nVrFeR9OVdYomOaMq/GvODW8JLvzaL2rbW3wAPU=;
	b=zSnEGhJMpzAV7OPerK/ECYunLFUvgXM1b9Cj1v+CMbAyPWhC6r9BRXGm9I36SC8/QOGB9N
	X4DjAEO5M9Vzy4XTjE3SWfhNNbXnYt8JHI0M8G1gnlD9f2GW1I1qjh+LYSqcdujkfmDaO9
	NboozgDQOZdNyLFrVqIs+qwi7ABoUvY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1733147342;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9qx7nVrFeR9OVdYomOaMq/GvODW8JLvzaL2rbW3wAPU=;
	b=SVggcK2dh8P33y3NX+FkAluNvDieRYd5y8E3ZgL18r4zVEz4jPqzVqmweaLt0CDetRTb6Z
	rmcbXOcAxo9d0KCw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1733147342; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9qx7nVrFeR9OVdYomOaMq/GvODW8JLvzaL2rbW3wAPU=;
	b=zSnEGhJMpzAV7OPerK/ECYunLFUvgXM1b9Cj1v+CMbAyPWhC6r9BRXGm9I36SC8/QOGB9N
	X4DjAEO5M9Vzy4XTjE3SWfhNNbXnYt8JHI0M8G1gnlD9f2GW1I1qjh+LYSqcdujkfmDaO9
	NboozgDQOZdNyLFrVqIs+qwi7ABoUvY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1733147342;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9qx7nVrFeR9OVdYomOaMq/GvODW8JLvzaL2rbW3wAPU=;
	b=SVggcK2dh8P33y3NX+FkAluNvDieRYd5y8E3ZgL18r4zVEz4jPqzVqmweaLt0CDetRTb6Z
	rmcbXOcAxo9d0KCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 45906139C2;
	Mon,  2 Dec 2024 13:49:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ekEDEM66TWf9EQAAD6G6ig
	(envelope-from <dwagner@suse.de>); Mon, 02 Dec 2024 13:49:02 +0000
Date: Mon, 2 Dec 2024 14:48:53 +0100
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
Subject: Re: [PATCH v5 4/8] blk-mq: introduce blk_mq_map_hw_queues
Message-ID: <95035ac7-8707-4a69-8425-86a47841c15d@flourine.local>
References: <20241115-refactor-blk-affinity-helpers-v5-0-c472afd84d9f@kernel.org>
 <20241115-refactor-blk-affinity-helpers-v5-4-c472afd84d9f@kernel.org>
 <8b303ed8-f819-4fa2-b447-8d8f4a42b380@oracle.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8b303ed8-f819-4fa2-b447-8d8f4a42b380@oracle.com>
X-Spam-Score: -4.30
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[25];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Level: 

On Thu, Nov 21, 2024 at 09:08:02AM +0000, John Garry wrote:
> > +/**
> > + * blk_mq_map_hw_queues - Create CPU to hardware queue mapping
> > + * @qmap:	CPU to hardware queue map.
> > + * @dev:	The device to map queues.
> > + * @offset:	Queue offset to use for the device.
> 
> supernit: maybe no '.'

np. I've followed the style of the function right above. Dropped them.

> is there still a blank line at the bottom of the file?

It ends with (vim):

	}
	EXPORT_SYMBOL_GPL(blk_mq_map_hw_queues);
	~

I hope that is what it supposed to be.

Daniel

