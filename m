Return-Path: <linux-pci+bounces-18581-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 74A549F45E8
	for <lists+linux-pci@lfdr.de>; Tue, 17 Dec 2024 09:21:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 19924188F46B
	for <lists+linux-pci@lfdr.de>; Tue, 17 Dec 2024 08:21:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5E161D3194;
	Tue, 17 Dec 2024 08:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="qVwW87h9";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="3iwiwvyj";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="qVwW87h9";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="3iwiwvyj"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C5B8155393;
	Tue, 17 Dec 2024 08:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734423708; cv=none; b=dUZbGu/jBwQqCqJFNUpS7ww6TJaHjv7YAjfDOP3235EHnlR2NOMivvYxlIcZln5KW11b0LyA7ik7yCYMuxDastr+APFOf8uhqW769KBf4M+CVGEOhzdkOKnBTgJ8SgIrh5JYTouBvyO9b8lZRdsjhV5IJXnBQeqZpPUIED7dr7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734423708; c=relaxed/simple;
	bh=F5S4FhtmltsBwBx86PvuD+lMhYGZK3Hqs0mfpw44AcI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d6JHPuOMMPzOah1f7Hv9Rq7w8MsLGBGLLONCcT1OWpYTWYnvUufnjcmWrI/a7Hebuv2jxqch8eQvg2EQkoT/+SJNQxsGWcPlJEHODICms033cREFzCTYlI/tC+b4ZrScMA1c/hFOmZNCp4jwZ9aNCAR7KR6cGDK1CwKVFTPUPME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=qVwW87h9; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=3iwiwvyj; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=qVwW87h9; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=3iwiwvyj; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 3BE1821120;
	Tue, 17 Dec 2024 08:21:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1734423705; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=K0ccd5T/w72yfTNgA1rqqzypkLFYQGNqOiIvNG54Ot8=;
	b=qVwW87h9IIRltr8VdEQKJhEHFuizPMnxm0At6YVF3qu+QiNzXpcpWmb0c3EcfdTqfazSpW
	rFjbHnPZBb4MqKFKk758sazgfQJW8bw7GPrJyefEfU9FE6uZ8mWdlPQf4HhNdTPtmIdJIo
	uIfhHPGBVf6Z3CqFuQIL2ayxRKzFaB8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1734423705;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=K0ccd5T/w72yfTNgA1rqqzypkLFYQGNqOiIvNG54Ot8=;
	b=3iwiwvyjFkJl+c1TbcwB8Pfq8gRzCBQ6bjAAAmtXFrCrO4FldFK7xQD1+gf7kU35PPhUF4
	vs35Wg5oVgtVd3DA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1734423705; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=K0ccd5T/w72yfTNgA1rqqzypkLFYQGNqOiIvNG54Ot8=;
	b=qVwW87h9IIRltr8VdEQKJhEHFuizPMnxm0At6YVF3qu+QiNzXpcpWmb0c3EcfdTqfazSpW
	rFjbHnPZBb4MqKFKk758sazgfQJW8bw7GPrJyefEfU9FE6uZ8mWdlPQf4HhNdTPtmIdJIo
	uIfhHPGBVf6Z3CqFuQIL2ayxRKzFaB8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1734423705;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=K0ccd5T/w72yfTNgA1rqqzypkLFYQGNqOiIvNG54Ot8=;
	b=3iwiwvyjFkJl+c1TbcwB8Pfq8gRzCBQ6bjAAAmtXFrCrO4FldFK7xQD1+gf7kU35PPhUF4
	vs35Wg5oVgtVd3DA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 19E3213A3C;
	Tue, 17 Dec 2024 08:21:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id mA8iBJk0YWe4GQAAD6G6ig
	(envelope-from <dwagner@suse.de>); Tue, 17 Dec 2024 08:21:45 +0000
Date: Tue, 17 Dec 2024 09:21:44 +0100
From: Daniel Wagner <dwagner@suse.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Bjorn Helgaas <bhelgaas@google.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, 
	"Martin K. Petersen" <martin.petersen@oracle.com>, Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>, 
	Sagi Grimberg <sagi@grimberg.me>, John Garry <john.g.garry@oracle.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Hannes Reinecke <hare@suse.de>, Ming Lei <ming.lei@redhat.com>, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
	virtualization@lists.linux.dev, linux-scsi@vger.kernel.org, megaraidlinux.pdl@broadcom.com, 
	mpi3mr-linuxdrv.pdl@broadcom.com, MPT-FusionLinux.pdl@broadcom.com, storagedev@microchip.com, 
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH v6 0/8] blk: refactor queue affinity helpers
Message-ID: <632d25c7-ac46-4a1a-b2bc-14258a88216c@flourine.local>
References: <20241202-refactor-blk-affinity-helpers-v6-0-27211e9c2cd5@kernel.org>
 <c5f7f562-c8b0-422b-bb51-744ecba7ecee@flourine.local>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c5f7f562-c8b0-422b-bb51-744ecba7ecee@flourine.local>
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[24];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -4.30
X-Spam-Flag: NO

Hi Jens,

On Mon, Dec 09, 2024 at 10:42:26AM +0100, Daniel Wagner wrote:
> On Mon, Dec 02, 2024 at 03:00:08PM +0100, Daniel Wagner wrote:
> > I've rebased and retested the series on top of for-6.14/block and updated
> > the docummentation as requested by John.
> > 
> > Original cover letter:
> > 
> > These patches were part of 'honor isolcpus configuration' [1] series. To
> > simplify the review process I decided to send this as separate series
> > because I think it's a nice cleanup independent of the isolcpus feature.
> > 
> > Signed-off-by: Daniel Wagner <wagi@kernel.org>
> 
> I've based this work on top of your tree as I think it should go your
> tree. If this should go via different tree, let me know which one.
> 
> And in case the series didn't hit your inbox, I really don't know what I
> am doing wrong. I've switched over to use b4 and korg for sending the
> patches and on my side all looks good and the mails also appear on lore
> completely normal.

Any chance to get this merged?

Thanks,
Daniel

