Return-Path: <linux-pci+bounces-16752-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1486F9C8989
	for <lists+linux-pci@lfdr.de>; Thu, 14 Nov 2024 13:10:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 867EDB2C767
	for <lists+linux-pci@lfdr.de>; Thu, 14 Nov 2024 12:06:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F25E01F8EEE;
	Thu, 14 Nov 2024 12:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="0VIAq/Z1";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="XzbcY6XL";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="0VIAq/Z1";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="XzbcY6XL"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B68018BC2C;
	Thu, 14 Nov 2024 12:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731586013; cv=none; b=PIr3+L3FUV2KgbBBjcrFWcmiXcS4NpPM3fpD/iaiI3FHAAUHeie81I0/SRfk0ZcZoOtQo4W6pry2+S7hYHqGSFvwJR2TxnMghXVRk5lFS/S1zMVQgklUkwRdhmEqrMYLT1C/5zdRbW+VZCHWFPtVfFr2r8Dzmw0HxeoelUlmPZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731586013; c=relaxed/simple;
	bh=FNcTQoUmRoStCmk8rcMy5T71OIia2xR3uqGNl1es7G4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=thDXmyIbkzAx1rn4/b5v84ZSQM5K5EUd0qdgWW9FjNRL46bUCixVG0IQBxIQzVFkge24rG7HgX8pjp5ZYW1Sn6p/eGw6CXzD7/DbviVutXH2wN2kWHvOrCR5nMpWKSJ4vDFwtWW2T54GrcSJ0sWYEq3jvndxNpyxTbxLU0GI2H0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=0VIAq/Z1; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=XzbcY6XL; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=0VIAq/Z1; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=XzbcY6XL; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A0D551F7D3;
	Thu, 14 Nov 2024 12:06:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1731586010; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=02YKYpUDeKJg3ky6Nqo0pfIc/VYHigZfmBxiRwYrn9U=;
	b=0VIAq/Z1zWsxunVwtmQk8eFXwQ3Wk7OxJVvVmLKA0qLE5Df6BnOCpERT2Ndxrsz5b7cs05
	L1Wpt98+DLywcAIM/G3y2sgPNFLq+U0v0QfS3sRcOG1n9jckxFXaTNQtgoUa/kO5b8oykm
	iLKShhT3wjy0JpRU2PixX45cEu+kbUc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1731586010;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=02YKYpUDeKJg3ky6Nqo0pfIc/VYHigZfmBxiRwYrn9U=;
	b=XzbcY6XLq/bVltPYJ6+zyOzgJiO0RvkBcUV23UCxFGniMN43TmHPgN8rfjsQ8bAGTM7syQ
	808ssY14QUCvEyBQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1731586010; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=02YKYpUDeKJg3ky6Nqo0pfIc/VYHigZfmBxiRwYrn9U=;
	b=0VIAq/Z1zWsxunVwtmQk8eFXwQ3Wk7OxJVvVmLKA0qLE5Df6BnOCpERT2Ndxrsz5b7cs05
	L1Wpt98+DLywcAIM/G3y2sgPNFLq+U0v0QfS3sRcOG1n9jckxFXaTNQtgoUa/kO5b8oykm
	iLKShhT3wjy0JpRU2PixX45cEu+kbUc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1731586010;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=02YKYpUDeKJg3ky6Nqo0pfIc/VYHigZfmBxiRwYrn9U=;
	b=XzbcY6XLq/bVltPYJ6+zyOzgJiO0RvkBcUV23UCxFGniMN43TmHPgN8rfjsQ8bAGTM7syQ
	808ssY14QUCvEyBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 79CE713721;
	Thu, 14 Nov 2024 12:06:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id YoW0HdrnNWfrQgAAD6G6ig
	(envelope-from <dwagner@suse.de>); Thu, 14 Nov 2024 12:06:50 +0000
Date: Thu, 14 Nov 2024 13:06:49 +0100
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
Message-ID: <4bd491e5-fab5-4e94-8719-560b5a4de01e@flourine.local>
References: <20241113-refactor-blk-affinity-helpers-v4-0-dd3baa1e267f@kernel.org>
 <20241113-refactor-blk-affinity-helpers-v4-5-dd3baa1e267f@kernel.org>
 <ZzVZQbZOYhNF08LX@fedora>
 <9fa26099-1922-4b99-883e-bd5f6c58162a@flourine.local>
 <ZzW-9rWvKBxFZU1E@fedora>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZzW-9rWvKBxFZU1E@fedora>
X-Spam-Score: -4.30
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
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

On Thu, Nov 14, 2024 at 05:12:22PM +0800, Ming Lei wrote:
> I feel driver should get higher priority, but in the probe() example,
> call_driver_probe() actually tries bus->probe() first.
> 
> But looks not an issue for this patchset since only hisi_sas_v2_driver(platform_driver)
> defines ->irq_get_affinity(), but the platform_bus_type doesn't have
> the callback.

Oh, I was not aware of this ordering. And after digging this up here:

https://lore.kernel.org/all/20060105142951.13.01@flint.arm.linux.org.uk/

I don't think we it's worthwhile to add the callback to device_driver
just for hisi_sas_v2. So I am going to drop this part again.

> > This brings up another topic I left out in this series.
> > blk_mq_map_queues does almost the same thing except it starts with the
> > mask returned by group_cpus_evenely. If we figure out how this could be
> > combined in a sane way it's possible to cleanup even a bit more. A bunch
> > of drivers do
> > 
> > 		if (i != HCTX_TYPE_POLL && offset)
> > 			blk_mq_hctx_map_queues(map, dev->dev, offset);
> > 		else
> > 			blk_mq_map_queues(map);
> > 
> > IMO it would be nice just to have one blk_mq_map_queues() which handles
> > this correctly for both cases.
> 
> I guess it is doable, and the driver just setup the tag_set->map[], then call
> one generic map_queues API to do everything?

Yes, that is my idea. Just having one function which handles what
blk_mq_map_queues and blk_mq_hctx_map_queues/blk_mq_map_hw_queues
currently do.

