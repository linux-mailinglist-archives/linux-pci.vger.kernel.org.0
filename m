Return-Path: <linux-pci+bounces-16589-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DC709C6374
	for <lists+linux-pci@lfdr.de>; Tue, 12 Nov 2024 22:32:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 32541B2B586
	for <lists+linux-pci@lfdr.de>; Tue, 12 Nov 2024 18:25:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57D042161FE;
	Tue, 12 Nov 2024 18:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="elNpQcgX";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="upHQI7Dt";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="elNpQcgX";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="upHQI7Dt"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABB0C20EA5B;
	Tue, 12 Nov 2024 18:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731435946; cv=none; b=PRG2B4PVRYP4R+IAMMi8HIC5qLQMQ/bXL+zOKjs2/KEk1KG6PANEAFWV9bfniqZw+dUCsGD5s8kbvoJ5XFknz10doKnmt7ocVqhnw6dVs26mtjCeXN9Ho10ZRDENBpDUaQehdefE3jS6+gTvwWehTySfIGcbOwkuU1cicy+1WWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731435946; c=relaxed/simple;
	bh=SI3LsDcyGw/407Mz5RJai+Quoq3UgIX/1kn5EwodWv4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rn8qBXba9BHwcfu8/KMBuXjXayCjL3YW/2e6lLSt3uFlzjmOi9B07zJfz1fnZaR3BD8ZnmC0qGVSHhrDG7KGPVyQum85c40Bh+E6Yxn0kjWxva3DSaL0mga2BmK4KHyWyCdF+58120xnybZGsw14o/NPtMawjuQqJ3GqNiX3ks0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=elNpQcgX; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=upHQI7Dt; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=elNpQcgX; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=upHQI7Dt; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E13B11F74A;
	Tue, 12 Nov 2024 18:25:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1731435942; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SI3LsDcyGw/407Mz5RJai+Quoq3UgIX/1kn5EwodWv4=;
	b=elNpQcgXmLRkPqJA301k3uLorPvi2Xxojc5xDYob+0TUKXa9+5i9pXw7v9f9Zz424NDXq9
	5i4DovSowO0VFzLB7DDPd6uOeS1ljK89W2FM8wH3lhL0ZmdrTinvQdKY91T5UzbYV9P5bd
	IeJm7qrejOX9KQo1Ppaho3NMP9MRJy4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1731435942;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SI3LsDcyGw/407Mz5RJai+Quoq3UgIX/1kn5EwodWv4=;
	b=upHQI7DtYNeYGXVigZl7tWevH/muN1LRM9QDvL7HEu2k4yEALj0/HYUSUECpBe7xXJ6LZJ
	XLXEwCmwQNtyUuBg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1731435942; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SI3LsDcyGw/407Mz5RJai+Quoq3UgIX/1kn5EwodWv4=;
	b=elNpQcgXmLRkPqJA301k3uLorPvi2Xxojc5xDYob+0TUKXa9+5i9pXw7v9f9Zz424NDXq9
	5i4DovSowO0VFzLB7DDPd6uOeS1ljK89W2FM8wH3lhL0ZmdrTinvQdKY91T5UzbYV9P5bd
	IeJm7qrejOX9KQo1Ppaho3NMP9MRJy4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1731435942;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SI3LsDcyGw/407Mz5RJai+Quoq3UgIX/1kn5EwodWv4=;
	b=upHQI7DtYNeYGXVigZl7tWevH/muN1LRM9QDvL7HEu2k4yEALj0/HYUSUECpBe7xXJ6LZJ
	XLXEwCmwQNtyUuBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B355613301;
	Tue, 12 Nov 2024 18:25:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id gYx9KaadM2dmQQAAD6G6ig
	(envelope-from <dwagner@suse.de>); Tue, 12 Nov 2024 18:25:42 +0000
Date: Tue, 12 Nov 2024 19:25:42 +0100
From: Daniel Wagner <dwagner@suse.de>
To: Daniel Wagner <wagi@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, Bjorn Helgaas <bhelgaas@google.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, 
	"Martin K. Petersen" <martin.petersen@oracle.com>, Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>, 
	Sagi Grimberg <sagi@grimberg.me>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
	virtualization@lists.linux.dev, linux-scsi@vger.kernel.org, megaraidlinux.pdl@broadcom.com, 
	mpi3mr-linuxdrv.pdl@broadcom.com, MPT-FusionLinux.pdl@broadcom.com, storagedev@microchip.com, 
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH v3 4/8] blk-mp: introduce blk_mq_hctx_map_queues
Message-ID: <07662901-1100-4d03-9033-26ea16cfc54e@flourine.local>
References: <20241112-refactor-blk-affinity-helpers-v3-0-573bfca0cbd8@kernel.org>
 <20241112-refactor-blk-affinity-helpers-v3-4-573bfca0cbd8@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241112-refactor-blk-affinity-helpers-v3-4-573bfca0cbd8@kernel.org>
X-Spam-Score: -4.30
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.992];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_DN_SOME(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 

The subject prefix has obviously a typo, should start with 'blk-mq:'

