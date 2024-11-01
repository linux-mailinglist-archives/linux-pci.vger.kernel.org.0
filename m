Return-Path: <linux-pci+bounces-15789-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C0EC99B8D3F
	for <lists+linux-pci@lfdr.de>; Fri,  1 Nov 2024 09:43:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 45F4F1F23904
	for <lists+linux-pci@lfdr.de>; Fri,  1 Nov 2024 08:43:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CAB6156C76;
	Fri,  1 Nov 2024 08:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="MdMraDhU";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="8iHmJWNZ";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ATB2F7j7";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="upmLlQlf"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AC63156C70;
	Fri,  1 Nov 2024 08:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730450597; cv=none; b=AYm99H+AwUrw/eXfOvyAaZ53tA/N/LWMhrbRjqgWh9acVLFeiuCbQo9ZEZnkQXo6w8mqt0F2V/cZNkez1LSJTUxOnu/sQgyxuFCC/5tj8mrnRkHci9CJpDuXRoL54Hb3HQBWvbCfmvjz/5ZWA8fwgD7+LKqsXCrICBEB8p1H0iM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730450597; c=relaxed/simple;
	bh=r4uTEtNDCsi9pVchlXsh3DPNGJNZ7XFPRnuIFO7ryuo=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dlRXQ0KcKzjTL/xAdmqTN6X2ilQhzKXmYw32IZ1XKOkHR67cnWFmICiDdpnMWboxRQn5DHdhOttiyDGOq4OdPJplu2X1+JwvNbn1MuQvQC9ZG9al73IAp81AnFv32tem/dzDCWJzYtPsq9F9K/JmhROsKS7vO8leAEilmUGtBGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=MdMraDhU; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=8iHmJWNZ; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ATB2F7j7; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=upmLlQlf; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 16C4B21BEB;
	Fri,  1 Nov 2024 08:43:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1730450593; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZffON8jA5hVLu8EkFapSxEadCZRFvwdwBRN6Qtasndo=;
	b=MdMraDhUnbQn6lC94/NmwQCFmjMO3KcS/CnUqm2Aff1vUUf/oyQhCijNuHOlbQdKezE4vE
	tx5TcERWIRHMTRWry/dLfEXMZ3JmEqUl9vbuwmouaQDg1sEwtio/WpWACBJZoCG1vbq4LS
	AXHY8HoaDRmX2Wr5bdQyAmDatkHdYt4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1730450593;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZffON8jA5hVLu8EkFapSxEadCZRFvwdwBRN6Qtasndo=;
	b=8iHmJWNZQNqkxZgtoW62zZZaGccMNaXDVNm1GBI8n+ZvYb4fb0OhcAI59a+csp81FKOhfo
	+I+UqfYNayagZUCw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1730450592; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZffON8jA5hVLu8EkFapSxEadCZRFvwdwBRN6Qtasndo=;
	b=ATB2F7j7f51iJGKW1D8/EGZ1LB0mNrHmLQs7SziD7vcuCBGXFwcYM9T6G7m6+sb8ZzNTjM
	WRtO+VsIZ5WSjuELppgZAy9WpNeCF4cxBrwVsb1F+9yWRKQUMa4ZyrsFV8rwESqV9nduEb
	ZMMVQZxC38XKBpMOYjgejG4PB/fZ90w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1730450592;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZffON8jA5hVLu8EkFapSxEadCZRFvwdwBRN6Qtasndo=;
	b=upmLlQlfBOfAH9CLkf5lZpuhAxLNHpSWYG9Y2LQjWy2j7tB2zt2cfIAM/bdvk6xMTcoY6+
	C9tajtNa92N8e6Aw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D046413722;
	Fri,  1 Nov 2024 08:43:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id GxEEMZ+UJGfhLgAAD6G6ig
	(envelope-from <tiwai@suse.de>); Fri, 01 Nov 2024 08:43:11 +0000
Date: Fri, 01 Nov 2024 09:44:16 +0100
Message-ID: <87bjyzuyvz.wl-tiwai@suse.de>
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
	BAYES_HAM(-3.00)[100.00%];
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

So, this change looks conflicting with the pcim_intx() cleanup patch
set from Philipp.  I think we can take this one and drop the
corresponding one from Philipp's patch set.

Bjorn, Philipp, does it sound OK?


thanks,

Takashi

> ---
>  sound/pci/hda/hda_intel.c | 21 ++++++++++++---------
>  1 file changed, 12 insertions(+), 9 deletions(-)
> 
> diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
> index 9fc5e6c5d..fc329b6a7 100644
> --- a/sound/pci/hda/hda_intel.c
> +++ b/sound/pci/hda/hda_intel.c
> @@ -773,6 +773,14 @@ static void azx_clear_irq_pending(struct azx *chip)
>  static int azx_acquire_irq(struct azx *chip, int do_disconnect)
>  {
>  	struct hdac_bus *bus = azx_bus(chip);
> +	int ret;
> +
> +	if (!chip->msi || pci_alloc_irq_vectors(chip->pci, 1, 1, PCI_IRQ_MSI) < 0) {
> +		ret = pci_alloc_irq_vectors(chip->pci, 1, 1, PCI_IRQ_INTX);
> +		if (ret < 0)
> +			return ret;
> +		chip->msi = 0;
> +	}
>  
>  	if (request_irq(chip->pci->irq, azx_interrupt,
>  			chip->msi ? 0 : IRQF_SHARED,
> @@ -786,7 +794,6 @@ static int azx_acquire_irq(struct azx *chip, int do_disconnect)
>  	}
>  	bus->irq = chip->pci->irq;
>  	chip->card->sync_irq = bus->irq;
> -	pci_intx(chip->pci, !chip->msi);
>  	return 0;
>  }
>  
> @@ -1879,13 +1886,9 @@ static int azx_first_init(struct azx *chip)
>  		chip->gts_present = true;
>  #endif
>  
> -	if (chip->msi) {
> -		if (chip->driver_caps & AZX_DCAPS_NO_MSI64) {
> -			dev_dbg(card->dev, "Disabling 64bit MSI\n");
> -			pci->no_64bit_msi = true;
> -		}
> -		if (pci_enable_msi(pci) < 0)
> -			chip->msi = 0;
> +	if (chip->msi && chip->driver_caps & AZX_DCAPS_NO_MSI64) {
> +		dev_dbg(card->dev, "Disabling 64bit MSI\n");
> +		pci->no_64bit_msi = true;
>  	}
>  
>  	pci_set_master(pci);
> @@ -2037,7 +2040,7 @@ static int disable_msi_reset_irq(struct azx *chip)
>  	free_irq(bus->irq, chip);
>  	bus->irq = -1;
>  	chip->card->sync_irq = -1;
> -	pci_disable_msi(chip->pci);
> +	pci_free_irq_vectors(chip->pci);
>  	chip->msi = 0;
>  	err = azx_acquire_irq(chip, 1);
>  	if (err < 0)
> -- 
> 2.47.0
> 

