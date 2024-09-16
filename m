Return-Path: <linux-pci+bounces-13228-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 992AB979B1F
	for <lists+linux-pci@lfdr.de>; Mon, 16 Sep 2024 08:26:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5BDF12810E9
	for <lists+linux-pci@lfdr.de>; Mon, 16 Sep 2024 06:26:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0115F3D3B3;
	Mon, 16 Sep 2024 06:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="lBhOKjH2";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="nkSzUkkP";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="lBhOKjH2";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="nkSzUkkP"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EE952A1B2;
	Mon, 16 Sep 2024 06:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726468008; cv=none; b=BthSpynWQF8uj8Uyi6JjoA+JeNBWUVCqsa184ubN6K6HLQ+vw+jHkHSQUgY698R2izvSQRcQJnc8N0WA+nfbi8H67xM+JrTHFPkotLa5olCpK9S6o9e+Pe7E1Y7/+9x0ce3Vge/CoTh2Gv1/btsWH/yL93Cxf7iH3cJxmLjhHFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726468008; c=relaxed/simple;
	bh=grflwa4TK+IPDZK5UhhmF8pVmA1iW8ihX+PUkZ3XnTc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c/oj5lo/jKusB06Au2VyzxzyXhiu4IblsFPuY1GzQQdAASrbIWweOyVz43fyWrw4OBFDKIbqTIwLZJzsiwFiawSUw6MvwAAl7+/TjmgTxihKpGuS+/59A33BMmbf0fHO4aX4wOE1JwvFjSUmVevVRJqDTNhbTaoLKNzJgnCukn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=lBhOKjH2; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=nkSzUkkP; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=lBhOKjH2; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=nkSzUkkP; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A33A11F863;
	Mon, 16 Sep 2024 06:26:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1726468005; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0wJPDvWUxfJXVreEgAlweakx6CdgLY82UDZzA3fZ1nQ=;
	b=lBhOKjH2PvalIGzOAYiGDJUvAeSCSZqJa4Rksob+7fOwAIjaZofrfJsJ+PsbwzSzlYrfmU
	oTGt74rrFIoiYNcUgd5SIOh0i9JsrRbqyeP2iDLeDBI+L2UvfJf6ONSlMo+rLhmsJ5RdTM
	QQga3s117CkxW5MvS8JOsptowhwUJvg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1726468005;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0wJPDvWUxfJXVreEgAlweakx6CdgLY82UDZzA3fZ1nQ=;
	b=nkSzUkkP7dEytwSZgbapeIYpbwfw4eie+y9rvzblcr8dGP74ZWlWBHhzab7cNoXfzyVVUW
	s+0R/K+Jafl6BIDg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=lBhOKjH2;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=nkSzUkkP
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1726468005; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0wJPDvWUxfJXVreEgAlweakx6CdgLY82UDZzA3fZ1nQ=;
	b=lBhOKjH2PvalIGzOAYiGDJUvAeSCSZqJa4Rksob+7fOwAIjaZofrfJsJ+PsbwzSzlYrfmU
	oTGt74rrFIoiYNcUgd5SIOh0i9JsrRbqyeP2iDLeDBI+L2UvfJf6ONSlMo+rLhmsJ5RdTM
	QQga3s117CkxW5MvS8JOsptowhwUJvg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1726468005;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0wJPDvWUxfJXVreEgAlweakx6CdgLY82UDZzA3fZ1nQ=;
	b=nkSzUkkP7dEytwSZgbapeIYpbwfw4eie+y9rvzblcr8dGP74ZWlWBHhzab7cNoXfzyVVUW
	s+0R/K+Jafl6BIDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7F069139CE;
	Mon, 16 Sep 2024 06:26:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id SS+ZHKXP52akGgAAD6G6ig
	(envelope-from <dwagner@suse.de>); Mon, 16 Sep 2024 06:26:45 +0000
Date: Mon, 16 Sep 2024 08:26:44 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Daniel Wagner <wagi@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Jason Wang <jasowang@redhat.com>, "Martin K. Petersen" <martin.petersen@oracle.com>, 
	Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
	virtualization@lists.linux.dev, linux-scsi@vger.kernel.org, megaraidlinux.pdl@broadcom.com, 
	mpi3mr-linuxdrv.pdl@broadcom.com, MPT-FusionLinux.pdl@broadcom.com, storagedev@microchip.com, 
	linux-nvme@lists.infradead.org, Ming Lei <ming.lei@redhat.com>
Subject: Re: [PATCH 1/6] blk-mq: introduce blk_mq_hctx_map_queues
Message-ID: <bc6ce1ce-3f66-4299-a922-c69d38489b7b@flourine.local>
References: <20240913162654.GA713813@bhelgaas>
 <0bd0be63-5595-4aae-829f-6b278a5b5e60@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0bd0be63-5595-4aae-829f-6b278a5b5e60@kernel.dk>
X-Rspamd-Queue-Id: A33A11F863
X-Spam-Score: -4.51
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_TWELVE(0.00)[21];
	MISSING_XM_UA(0.00)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Sun, Sep 15, 2024 at 02:32:30PM GMT, Jens Axboe wrote:
> > IMO this doesn't really fit well in drivers/pci since it doesn't add
> > any PCI-specific knowledge or require any PCI core internals, and the
> > parameters are blk-specific.  I don't object to the code, but it seems
> > like it could go somewhere in block/?
> 
> Probably not a bad idea.

Christoph suggested to move these function to matching subsystem. I am
fine either way.

> Unrelated to that topic, but Daniel, all your email gets marked as spam.
> I didn't see your series before this reply. This has been common
> recently for people that haven't kept up with kernel.org changes, please
> check for smtp changes there.

Thanks for letting me know. FWIW, I switch over to use the kernel.org smtp
server and I must miss some important config option.

