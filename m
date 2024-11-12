Return-Path: <linux-pci+bounces-16555-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0466E9C5BED
	for <lists+linux-pci@lfdr.de>; Tue, 12 Nov 2024 16:33:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7DF8281DBE
	for <lists+linux-pci@lfdr.de>; Tue, 12 Nov 2024 15:33:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8497A201007;
	Tue, 12 Nov 2024 15:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="f0NvnLrE";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="1JvtkDuT";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="hpDFdJxD";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="BZoZbY2J"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D121E200CB9;
	Tue, 12 Nov 2024 15:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731425594; cv=none; b=UpVXNK4Qp1yinLS0FuOAIaBUY0G+A+hakdaAVEqxgJyz0CFjS9fVmTBRAbdosDhnL9C0JV8qFtagjk/L4rtBXeJLPxcYn9bumI4pbcU0ANIXmqoiX0v/bQihjRpqKXlBmfJyhqFRUBZuTu2v1/FESIk6/Wt91v1qDIDxANitn5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731425594; c=relaxed/simple;
	bh=Cx5/EBwhKNt/XPcsIVyrN/2gbpE0N9V8YptGSC04Bqg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DdP5Qy+9L+Z6BLGwG0qn5vS2DPqJDr/7sD7X8AZDnakg+KDj8p561499tIK0Vh2ZXvTwA2vMcgM1vU2Y+CbweVWzCQ2dF+zwmI91VhYyBAncxgUaMVIJ/nkDzD3cTi+WYjPMZJ5zk4K10NxwogJ6bPBdihzFpy16e7ExXawwLaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=f0NvnLrE; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=1JvtkDuT; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=hpDFdJxD; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=BZoZbY2J; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 00C0921264;
	Tue, 12 Nov 2024 15:33:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1731425591; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DAkZqT3tNn4mcCgcObWd3Ub6xGiLu7hrctM4Rq1ElA0=;
	b=f0NvnLrErEahw7ahsZfdQmC0GiVV6+LO6vqelxZ2ftKRu4seUqwwytgh+726l9TRHxawpT
	eKIG/aWwB6ykIrTRAgGtlpPUwjqOhsNzwu4Qdj6+r8EWofdMiPUcSxmn8zBTf5r7hTNYLE
	p1cmx8GdJrEvVHEKAdaaB6iPVNB0NQw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1731425591;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DAkZqT3tNn4mcCgcObWd3Ub6xGiLu7hrctM4Rq1ElA0=;
	b=1JvtkDuTeB8JxyYw5xAbPBD8guJ57YeS4OP4m7MaJlOzvDND3TKg6kkuRr59Kw1Xbkp/x8
	Sbln7Dt7KyEdcPAw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=hpDFdJxD;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=BZoZbY2J
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1731425590; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DAkZqT3tNn4mcCgcObWd3Ub6xGiLu7hrctM4Rq1ElA0=;
	b=hpDFdJxDsY9GHAjOmLZ3Mh2dcdth54QmUx8ReB0Ae+cAqlwaeCXAt055ts540wFiRElTpR
	Y4EljyxN4WfvzvedkyoH29w4QyNptZJvdzijQ5NoUFSuJoMCqBIuJFniui4bvOmkIltP6F
	6FH5DBdmzhWZFxia44Ij/gzycUFJeQo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1731425590;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DAkZqT3tNn4mcCgcObWd3Ub6xGiLu7hrctM4Rq1ElA0=;
	b=BZoZbY2JFZQS5LyKsdVgHYuDFwbOupwlWTBgqTt3e5qtvOouK8CG6uCfjFtedZHe98aV73
	nVu7m6+LWmkDt7Bg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D264813721;
	Tue, 12 Nov 2024 15:33:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id uT4wMTV1M2ddEAAAD6G6ig
	(envelope-from <dwagner@suse.de>); Tue, 12 Nov 2024 15:33:09 +0000
Date: Tue, 12 Nov 2024 16:33:09 +0100
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
Message-ID: <c8c671c1-267a-4aa7-a64b-51a461176ad3@flourine.local>
References: <20241112-refactor-blk-affinity-helpers-v3-0-573bfca0cbd8@kernel.org>
 <20241112-refactor-blk-affinity-helpers-v3-4-573bfca0cbd8@kernel.org>
 <2024111202-parish-prowess-78bc@gregkh>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024111202-parish-prowess-78bc@gregkh>
X-Rspamd-Queue-Id: 00C0921264
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
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[22];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	MISSING_XM_UA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Tue, Nov 12, 2024 at 02:58:43PM +0100, Greg Kroah-Hartman wrote:
> > +void blk_mq_hctx_map_queues(struct blk_mq_queue_map *qmap,
> > +			    struct device *dev, unsigned int offset)
> > +
> > +{
> > +	const struct cpumask *mask;
> > +	unsigned int queue, cpu;
> > +
> > +	if (!dev->bus->irq_get_affinity)
> > +		goto fallback;
> 
> I think this is better than hard-coding it, but are you sure that the
> bus will always be bound to the device here so that you have a valid
> bus-> pointer?

No, I just assumed the bus pointer is always valid. If it is possible to
have a device without a bus, than I'll better extend the condition to

	if (!dev->bus || !dev->bus->irq_get_affinity)
        	goto fallback;

