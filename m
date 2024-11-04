Return-Path: <linux-pci+bounces-15954-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E33C89BB5DB
	for <lists+linux-pci@lfdr.de>; Mon,  4 Nov 2024 14:23:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7BA0280A0B
	for <lists+linux-pci@lfdr.de>; Mon,  4 Nov 2024 13:23:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E172128E37;
	Mon,  4 Nov 2024 13:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="qUQ0XOtU";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="bI37hxgQ";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="oH/oeR7u";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="kQM+343q"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EB2B1F942;
	Mon,  4 Nov 2024 13:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730726573; cv=none; b=gfeswtxb6vz4sy2s4MeMpFS5nrs+ZxuW+tf9/gv7mxuBl4++xtmHR2Nn46BgCzDpvqzMLuppu1E3OPj5ZJ9isYbONyaE8MGRa2fTp63A4Uiq5kELJAUeh54buLUI8sb+ro3fjg85nxIcdNaVU9K8LyOGtk8L3hyZEA/RrAUzaIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730726573; c=relaxed/simple;
	bh=jENhgwjHfHLpHVisFsFtPBea2iPPH9L7WxXFlxC/V3Q=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t2mp99Ufwy20cbL67bQso0bAbJWMaR8kxDe0AwNWpkVQwJMnktNuJTTJREN4lPiDCbIvt3UCmILawCRjX92cL7kb4Fp8aLvLr+iQJ0Z24BU4BLMCYMDFNJtcoOge9+bTtuJJQ53JPCV2GpL3ec4jcFse7tRt3snj1MVyifr/DB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=qUQ0XOtU; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=bI37hxgQ; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=oH/oeR7u; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=kQM+343q; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id F287A21DDA;
	Mon,  4 Nov 2024 13:22:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1730726570; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WP+efpquukK7qg3JnxY1hr4qsWnRjhge2MvS9FSY9/c=;
	b=qUQ0XOtUdinGwezHfnWUXA5NDMJ/C+BBx27+prfmP+NIVJcjswH1qjJV9TpuuXlZNKA88I
	6YCoIDe5kYc70gTLKBYPuvF1PZQmYsYKNglP5QGRU2hWwFjx5rWFcz2tJs3Kyl0NDAB72z
	QPu2N3aWpYpb/Sle+cItWfTkjnthl70=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1730726570;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WP+efpquukK7qg3JnxY1hr4qsWnRjhge2MvS9FSY9/c=;
	b=bI37hxgQwD4SwPOJCZaZPz5j73gndAJf0YwYSMDcapUbBwnAfEKqjuIVmr4Um6vpDpRCM8
	tjdcGMhgDHo8xLDw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1730726568; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WP+efpquukK7qg3JnxY1hr4qsWnRjhge2MvS9FSY9/c=;
	b=oH/oeR7usF+voNP+XTXuKI7mw/9d7LgEztFgn6okOXIIE36ss3CeSDxUyaHMMv80zdVNeS
	E4R+1At0xM4LLL1qYRtBRTlULedPj87tWw6vyHnRFRiYjLlIFWdk6vcPdg1rNcqDhPROSO
	UGtQsulyIeNykZxciJFKaT9ijzRpEVg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1730726568;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WP+efpquukK7qg3JnxY1hr4qsWnRjhge2MvS9FSY9/c=;
	b=kQM+343q3q4lySrJ7LeVVMwpXjDtfpRrNtELi1ZezM2yQia6+NTVhuZAzDwXuryIc26SQu
	EQi2qx4bj6J7ryCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BDF941373E;
	Mon,  4 Nov 2024 13:22:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id L7oxLajKKGd0aQAAD6G6ig
	(envelope-from <tiwai@suse.de>); Mon, 04 Nov 2024 13:22:48 +0000
Date: Mon, 04 Nov 2024 14:23:54 +0100
Message-ID: <87r07rb09h.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	linux-sound@vger.kernel.org,
	Philipp Stanner <pstanner@redhat.com>,
	Bjorn Helgaas <helgaas@kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH] ALSA: hda: intel: Switch to pci_alloc_irq_vectors API
In-Reply-To: <11c60429-9435-4666-8e27-77160abef68e@gmail.com>
References: <11c60429-9435-4666-8e27-77160abef68e@gmail.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spam-Level: 
X-Spamd-Result: default: False [-3.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid]
X-Spam-Score: -3.30
X-Spam-Flag: NO

On Thu, 31 Oct 2024 20:41:12 +0100,
Heiner Kallweit wrote:
> 
> Switch from legacy pci_msi_enable()/pci_intx() API to the
> pci_alloc_irq_vectors API.
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>

Applied to for-next branch now.  Thanks.


Takashi

