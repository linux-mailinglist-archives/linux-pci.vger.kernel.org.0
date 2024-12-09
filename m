Return-Path: <linux-pci+bounces-17912-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 491A79E8EEA
	for <lists+linux-pci@lfdr.de>; Mon,  9 Dec 2024 10:42:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F4149285C4F
	for <lists+linux-pci@lfdr.de>; Mon,  9 Dec 2024 09:42:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0367215F69;
	Mon,  9 Dec 2024 09:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ROVWqHs3";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="K6/il/9y";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ROVWqHs3";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="K6/il/9y"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34C6B215F46;
	Mon,  9 Dec 2024 09:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733737349; cv=none; b=FtGP0gwo/qm/k65O32EFwNkI93A78BfBTVR90fjOtgyt/pZbChUKO6BC6zSICml6iCmwFrfgXxz1useF6yk4C/iy/4aAGrGgwAp/sl1GlPabsL3UGCa8F1TlhcSWIVItW57Wll6wQPIsS06evuL4qjuOrybooWKiom2GU7EB2MU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733737349; c=relaxed/simple;
	bh=TooB5ni57/2YrNXSMLpKon190oxwv49KB61DTNETEbw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hhViAZCgywikRdAk6teDBdrs+OrWEqpJUirNcDo3ukFZPNL2qyZRoX4jMWXGwgC4hsGrWbXUdr/+jBW6ug5rGazJ8+C51ecdj9fnriLm1nmGf7nAQEFL6tCyH3AtcwEu7Q/Z610ebSGMUHY9yik5Nu4GxRCsElF/5BkZDdkPoeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ROVWqHs3; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=K6/il/9y; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ROVWqHs3; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=K6/il/9y; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 599A521102;
	Mon,  9 Dec 2024 09:42:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1733737346; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aIQwvsrIpYgv5MvzeEnVZPBMhP+QewiM6EWPCOSuTVg=;
	b=ROVWqHs3eX2jxddbAJcSeaVF9VPcdDPjibTWlDoJ51YYPKFll2L+vbTCLNEJd033bkDwv4
	IbhMu5XKOkZ+zqmISMMqx2BSu2MekIgmLn6icB+0+/yp9f29+jMwYPQYr8VkXe7LEw1z7I
	R37xBp1fgRVBnDjV9+iChjbPZ8RimWE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1733737346;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aIQwvsrIpYgv5MvzeEnVZPBMhP+QewiM6EWPCOSuTVg=;
	b=K6/il/9y2rYJNgrfcwHFshevRCOQUhZccARRG5++Eu3DQVGGe+zawpPvgOjUnpSE4T5x28
	u+SXh3r8qV4vmkDQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1733737346; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aIQwvsrIpYgv5MvzeEnVZPBMhP+QewiM6EWPCOSuTVg=;
	b=ROVWqHs3eX2jxddbAJcSeaVF9VPcdDPjibTWlDoJ51YYPKFll2L+vbTCLNEJd033bkDwv4
	IbhMu5XKOkZ+zqmISMMqx2BSu2MekIgmLn6icB+0+/yp9f29+jMwYPQYr8VkXe7LEw1z7I
	R37xBp1fgRVBnDjV9+iChjbPZ8RimWE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1733737346;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aIQwvsrIpYgv5MvzeEnVZPBMhP+QewiM6EWPCOSuTVg=;
	b=K6/il/9y2rYJNgrfcwHFshevRCOQUhZccARRG5++Eu3DQVGGe+zawpPvgOjUnpSE4T5x28
	u+SXh3r8qV4vmkDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 46E32138D2;
	Mon,  9 Dec 2024 09:42:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id hEOVEIK7VmeOJQAAD6G6ig
	(envelope-from <dwagner@suse.de>); Mon, 09 Dec 2024 09:42:26 +0000
Date: Mon, 9 Dec 2024 10:42:17 +0100
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
Message-ID: <c5f7f562-c8b0-422b-bb51-744ecba7ecee@flourine.local>
References: <20241202-refactor-blk-affinity-helpers-v6-0-27211e9c2cd5@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241202-refactor-blk-affinity-helpers-v6-0-27211e9c2cd5@kernel.org>
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
	RCPT_COUNT_TWELVE(0.00)[24];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_DN_SOME(0.00)[]
X-Spam-Score: -4.30
X-Spam-Flag: NO

Hi Jens,

On Mon, Dec 02, 2024 at 03:00:08PM +0100, Daniel Wagner wrote:
> I've rebased and retested the series on top of for-6.14/block and updated
> the docummentation as requested by John.
> 
> Original cover letter:
> 
> These patches were part of 'honor isolcpus configuration' [1] series. To
> simplify the review process I decided to send this as separate series
> because I think it's a nice cleanup independent of the isolcpus feature.
> 
> Signed-off-by: Daniel Wagner <wagi@kernel.org>

I've based this work on top of your tree as I think it should go your
tree. If this should go via different tree, let me know which one.

And in case the series didn't hit your inbox, I really don't know what I
am doing wrong. I've switched over to use b4 and korg for sending the
patches and on my side all looks good and the mails also appear on lore
completely normal.

Thanks,
Daniel

