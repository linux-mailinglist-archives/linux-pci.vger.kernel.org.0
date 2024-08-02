Return-Path: <linux-pci+bounces-11178-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F4B5945967
	for <lists+linux-pci@lfdr.de>; Fri,  2 Aug 2024 10:01:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B39B2B21882
	for <lists+linux-pci@lfdr.de>; Fri,  2 Aug 2024 08:01:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 696937EF04;
	Fri,  2 Aug 2024 08:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="gV+dy6Hb";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="OBpPn8MH";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="gV+dy6Hb";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="OBpPn8MH"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85FE61EB4B6;
	Fri,  2 Aug 2024 08:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722585688; cv=none; b=qZ26qQ2vdPystPMXSfynNlLMK1EGF4MdSQ1ptkak65prsW0Qb8Bj7kCwyRb3bZUkVCPjrIANvMOKYHja9XyvuSxqdNzLneKaQGDXQZ9dl5DHSZO6hAnf0z0RpFKL+0XJyf5m9sbvxORqva0zldNCimF/MD8pbsqa+jm/UfONi6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722585688; c=relaxed/simple;
	bh=+RPF19zxpzjlvYCTbY+grIfPZrP90fYFntEOY8xsHMs=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hSZr+tyc8gjXpT50cNqMsM6N2FxDJvJ/pETJnO/+1CTNK2yqEDKuk9LmrpUuSruvdumlKp3kLO95nYWDjN0C7fI3rTkux255h9h1PUW6ku8KT8UneW1TZxgSdMP9hmKG76d61xdQwwW93d0WYV9GlhH0R13VgMlKEiBaxMHvpdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=gV+dy6Hb; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=OBpPn8MH; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=gV+dy6Hb; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=OBpPn8MH; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id AF21F2193C;
	Fri,  2 Aug 2024 08:01:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1722585684; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4BS7F6/VnwHnr5d6vmx7l+U580Ch90URY4uXrae65JM=;
	b=gV+dy6HbW8R3P7OG9uh6RP1bjX0DVZqjFjhTbWkrR9S7VP8Web/ce6ZKRSbjfDx72JBVOi
	O+1JsszkXDGvbjaVYtwmNaGEGnMe453X7lcUhXPk+FnD3wZY6wl/dUwH++bAS4lBwq+p4y
	H0/A+sRM7ZNvSD5SVj4y83dWMpROtws=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1722585684;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4BS7F6/VnwHnr5d6vmx7l+U580Ch90URY4uXrae65JM=;
	b=OBpPn8MHCWvKZ7UJR8thx66+D8gmFu9DOUBW6ku1tH5yANcLOexdH1xlHzpMr2HdCc7xco
	vOrWI2InCG9uByCg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=gV+dy6Hb;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=OBpPn8MH
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1722585684; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4BS7F6/VnwHnr5d6vmx7l+U580Ch90URY4uXrae65JM=;
	b=gV+dy6HbW8R3P7OG9uh6RP1bjX0DVZqjFjhTbWkrR9S7VP8Web/ce6ZKRSbjfDx72JBVOi
	O+1JsszkXDGvbjaVYtwmNaGEGnMe453X7lcUhXPk+FnD3wZY6wl/dUwH++bAS4lBwq+p4y
	H0/A+sRM7ZNvSD5SVj4y83dWMpROtws=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1722585684;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4BS7F6/VnwHnr5d6vmx7l+U580Ch90URY4uXrae65JM=;
	b=OBpPn8MHCWvKZ7UJR8thx66+D8gmFu9DOUBW6ku1tH5yANcLOexdH1xlHzpMr2HdCc7xco
	vOrWI2InCG9uByCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7C3351388E;
	Fri,  2 Aug 2024 08:01:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Wo4KHVOSrGazDwAAD6G6ig
	(envelope-from <tiwai@suse.de>); Fri, 02 Aug 2024 08:01:23 +0000
Date: Fri, 02 Aug 2024 10:02:00 +0200
Message-ID: <87ed77ic93.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Philipp Stanner <pstanner@redhat.com>
Cc: Jonathan Corbet <corbet@lwn.net>,	Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,	Giovanni Cabiddu
 <giovanni.cabiddu@intel.com>,	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,	Boris Brezillon
 <bbrezillon@kernel.org>,	Arnaud Ebalard <arno@natisbad.org>,	Srujana Challa
 <schalla@marvell.com>,	Alexander Shishkin
 <alexander.shishkin@linux.intel.com>,	Miri Korenblit
 <miriam.rachel.korenblit@intel.com>,	Kalle Valo <kvalo@kernel.org>,	Serge
 Semin <fancer.lancer@gmail.com>,	Jon Mason <jdmason@kudzu.us>,	Dave Jiang
 <dave.jiang@intel.com>,	Allen Hubbe <allenbh@gmail.com>,	Bjorn Helgaas
 <bhelgaas@google.com>,	Kevin Cernekee <cernekee@gmail.com>,	Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>,	Jiri Slaby
 <jirislaby@kernel.org>,	Jaroslav Kysela <perex@perex.cz>,	Takashi Iwai
 <tiwai@suse.com>,	Mark Brown <broonie@kernel.org>,	David Lechner
 <dlechner@baylibre.com>,	Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?=
 <u.kleine-koenig@pengutronix.de>,	Jonathan Cameron
 <Jonathan.Cameron@huawei.com>,	Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>,	Jie Wang <jie.wang@intel.com>,	Adam
 Guerin <adam.guerin@intel.com>,	Shashank Gupta <shashank.gupta@intel.com>,
	Damian Muszynski <damian.muszynski@intel.com>,	Nithin Dabilpuram
 <ndabilpuram@marvell.com>,	Bharat Bhushan <bbhushan2@marvell.com>,	Johannes
 Berg <johannes.berg@intel.com>,	Gregory Greenman
 <gregory.greenman@intel.com>,	Emmanuel Grumbach
 <emmanuel.grumbach@intel.com>,	Yedidya Benshimol
 <yedidya.ben.shimol@intel.com>,	Breno Leitao <leitao@debian.org>,	Ilpo
 =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,	John Ogness
 <john.ogness@linutronix.de>,	Thomas Gleixner <tglx@linutronix.de>,
	linux-doc@vger.kernel.org,	linux-kernel@vger.kernel.org,
	linux-ide@vger.kernel.org,	qat-linux@intel.com,
	linux-crypto@vger.kernel.org,	linux-wireless@vger.kernel.org,
	ntb@lists.linux.dev,	linux-pci@vger.kernel.org,
	linux-serial@vger.kernel.org,	linux-sound@vger.kernel.org
Subject: Re: [PATCH 09/10] ALSA: korg1212: Replace deprecated PCI functions
In-Reply-To: <20240801174608.50592-10-pstanner@redhat.com>
References: <20240801174608.50592-1-pstanner@redhat.com>
	<20240801174608.50592-10-pstanner@redhat.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: AF21F2193C
X-Spam-Score: -1.81
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-1.81 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[lwn.net,kernel.org,intel.com,gondor.apana.org.au,davemloft.net,natisbad.org,marvell.com,linux.intel.com,gmail.com,kudzu.us,google.com,linuxfoundation.org,perex.cz,suse.com,baylibre.com,pengutronix.de,huawei.com,debian.org,linutronix.de,vger.kernel.org,lists.linux.dev];
	ARC_NA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	R_RATELIMIT(0.00)[to_ip_from(RLp4wjbahqp9imfp3xd18ktmsn)];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	DWL_DNSWL_BLOCKED(0.00)[suse.de:dkim];
	RCPT_COUNT_GT_50(0.00)[52];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:dkim]

On Thu, 01 Aug 2024 19:46:07 +0200,
Philipp Stanner wrote:
> 
> pcim_iomap_table() and pcim_iomap_regions_request_all() have been
> deprecated by the PCI subsystem in commit e354bb84a4c1 ("PCI: Deprecate
> pcim_iomap_table(), pcim_iomap_regions_request_all()").
> 
> Replace these functions with their successors, pcim_iomap() and
> pcim_request_all_regions()
> 
> Signed-off-by: Philipp Stanner <pstanner@redhat.com>

Reviewed-by: Takashi Iwai <tiwai@suse.de>

And feel free to take my ack to v2 if the further change will be only
about the description, too :)


thanks,

Takashi


> ---
>  sound/pci/korg1212/korg1212.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/sound/pci/korg1212/korg1212.c b/sound/pci/korg1212/korg1212.c
> index 5c2cac201a28..b5428ac34d3b 100644
> --- a/sound/pci/korg1212/korg1212.c
> +++ b/sound/pci/korg1212/korg1212.c
> @@ -2106,7 +2106,7 @@ static int snd_korg1212_create(struct snd_card *card, struct pci_dev *pci)
>          for (i=0; i<kAudioChannels; i++)
>                  korg1212->volumePhase[i] = 0;
>  
> -	err = pcim_iomap_regions_request_all(pci, 1 << 0, "korg1212");
> +	err = pcim_request_all_regions(pci, "korg1212");
>  	if (err < 0)
>  		return err;
>  
> @@ -2128,7 +2128,9 @@ static int snd_korg1212_create(struct snd_card *card, struct pci_dev *pci)
>  		   korg1212->iomem2, iomem2_size,
>  		   stateName[korg1212->cardState]);
>  
> -	korg1212->iobase = pcim_iomap_table(pci)[0];
> +	korg1212->iobase = pcim_iomap(pci, 0, 0);
> +	if (!korg1212->iobase)
> +		return -ENOMEM;
>  
>  	err = devm_request_irq(&pci->dev, pci->irq, snd_korg1212_interrupt,
>                            IRQF_SHARED,
> -- 
> 2.45.2
> 

