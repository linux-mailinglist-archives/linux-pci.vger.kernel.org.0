Return-Path: <linux-pci+bounces-12118-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F12DA95CE09
	for <lists+linux-pci@lfdr.de>; Fri, 23 Aug 2024 15:35:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9042281B28
	for <lists+linux-pci@lfdr.de>; Fri, 23 Aug 2024 13:35:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62C7318661A;
	Fri, 23 Aug 2024 13:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="bmnVSmdM";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="iacUFqMS";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="BCeVgrhE";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="uKk/w5XP"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AF8814387B;
	Fri, 23 Aug 2024 13:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724420100; cv=none; b=llMGcBX8PCHcrRLLd/FsGzrHgRfJ3uetETUX/hlEkVnHNYFO5f8GPrJXabaoyzG036RUqG4ezCh8DukZMBrhEx+1Bo5c1i3B01CwkDqd7ZBsoW2vlNLOZumQIwheGApNXPU1zpgnQmyJ+gsuhU7i12iT/1dMg+hDJkNpvjRozKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724420100; c=relaxed/simple;
	bh=O5TwfSRy4VQ5HYkyQCKD0vtCMrL6lFiVndCJVERj1u8=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jJbOnnv3ht5ZQkB7X7ztlj5GzwMrWiYVFPfRyZ0co8tixjacpPud42cbEhjOsXRyaTkKaCJrJxqCoeZkX7JYI7kFJj7Ume4dKbHzXc0WIq0KXjK780gmx3kV+0yQ+tt58kNT5IMD0L0NCbrxtPL+GKzCeXFvrX+UViadn+4iz+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=bmnVSmdM; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=iacUFqMS; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=BCeVgrhE; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=uKk/w5XP; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 9299622618;
	Fri, 23 Aug 2024 13:34:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1724420096; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hLGieBf5ePsScx99YX+rTJKyxnZ84uHErS3dY1fv5l4=;
	b=bmnVSmdMCNRcNiGP66ijcGsD03n7wOuMk8Mhls7DFJgA/jxAxY1LlXV3ubAozl0fAfU7V4
	KCRDwUs7AQ3YyD5O7qe0DzhXW/p/8SgbmW2D/Qf+Nia4IU6ktOHMNf2AcLySZDEeRj8Zpb
	XX+PYYctnSAsoVfXHiixfSEtjoKBfOA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1724420096;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hLGieBf5ePsScx99YX+rTJKyxnZ84uHErS3dY1fv5l4=;
	b=iacUFqMSI2mMYBuhqhv66GXSUNSoYjnJT7cwFZhsqrwRFzcg6GCuk1KzEskuR3NPPziMNO
	+DAnyMKbFvBVdtAQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=BCeVgrhE;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="uKk/w5XP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1724420095; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hLGieBf5ePsScx99YX+rTJKyxnZ84uHErS3dY1fv5l4=;
	b=BCeVgrhEy+apVN95ZhQBITMsreo2/pM2ubttvVDuy1iZzuP4qY5CX3ZwVhyV9UMrUO0p3E
	8nW6AUBKRi0RoIHePpunHG0Xq3iJcMIfZwHZcZ/AEQAk6G5MhuMuVN1KasEONTyS6LrGDz
	odRNcQ9ArRG8MKxO9+jICy8OzPU7yMQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1724420095;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hLGieBf5ePsScx99YX+rTJKyxnZ84uHErS3dY1fv5l4=;
	b=uKk/w5XPo//9lLQ/ouaZCftf+mhD8tIcUI3AauCKaoS4fz6qCg8UDs4QUt1xd+TrHEOCSc
	Za9Y7xOAjctr6RCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 143C61398B;
	Fri, 23 Aug 2024 13:34:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 0OvEA/+PyGZWZwAAD6G6ig
	(envelope-from <tiwai@suse.de>); Fri, 23 Aug 2024 13:34:55 +0000
Date: Fri, 23 Aug 2024 15:35:38 +0200
Message-ID: <874j7bl5ud.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: WangYuli <wangyuli@uniontech.com>
Cc: bhelgaas@google.com,
	siyuli@glenfly.com,
	perex@perex.cz,
	tiwai@suse.com,
	pierre-louis.bossart@linux.intel.com,
	maarten.lankhorst@linux.intel.com,
	peter.ujfalusi@linux.intel.com,
	kai.vehmanen@linux.intel.com,
	rsalvaterra@gmail.com,
	suijingfeng@loongson.cn,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org,
	jasontao@glenfly.com,
	reaperlioc@glenfly.com,
	guanwentao@uniontech.com,
	linux@horizon.com,
	pat-lkml@erley.org,
	alex.williamson@redhat.com
Subject: Re: [PATCH v2] PCI: Add function 0 DMA alias quirk for Glenfly arise chip
In-Reply-To: <CA2BBD087345B6D1+20240823095708.3237375-1-wangyuli@uniontech.com>
References: <CA2BBD087345B6D1+20240823095708.3237375-1-wangyuli@uniontech.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Rspamd-Queue-Id: 9299622618
X-Spam-Level: 
X-Spamd-Result: default: False [-5.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	DWL_DNSWL_MED(-2.00)[suse.de:dkim];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[20];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_CC(0.00)[google.com,glenfly.com,perex.cz,suse.com,linux.intel.com,gmail.com,loongson.cn,vger.kernel.org,uniontech.com,horizon.com,erley.org,redhat.com];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:email,suse.de:dkim,suse.de:mid,glenfly.com:email,uniontech.com:email]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -5.51
X-Spam-Flag: NO

On Fri, 23 Aug 2024 11:57:08 +0200,
WangYuli wrote:
> 
> Add DMA support for audio function of Glenfly arise chip,
> which uses request id of function 0.
> 
> Link: https://lore.kernel.org/all/20240822185617.GA344785@bhelgaas/
> Signed-off-by: SiyuLi <siyuli@glenfly.com>
> Signed-off-by: WangYuli <wangyuli@uniontech.com>

For the sound part:

Reviewed-by: Takashi Iwai <tiwai@suse.de>


thanks,

Takashi

> ---
>  drivers/pci/quirks.c      | 6 ++++++
>  include/linux/pci_ids.h   | 4 ++++
>  sound/pci/hda/hda_intel.c | 2 +-
>  3 files changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index dd75c7646bb7..7aad5311326d 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -4259,6 +4259,12 @@ static void quirk_dma_func0_alias(struct pci_dev *dev)
>  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_RICOH, 0xe832, quirk_dma_func0_alias);
>  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_RICOH, 0xe476, quirk_dma_func0_alias);
>  
> +/*
> + * Some Glenfly chips use function 0 as the PCIe requester ID for DMA too.
> + */
> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_GLENFLY, 0x3D40, quirk_dma_func0_alias);
> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_GLENFLY, 0x3D41, quirk_dma_func0_alias);
> +
>  static void quirk_dma_func1_alias(struct pci_dev *dev)
>  {
>  	if (PCI_FUNC(dev->devfn) != 1)
> diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
> index e388c8b1cbc2..536465196d09 100644
> --- a/include/linux/pci_ids.h
> +++ b/include/linux/pci_ids.h
> @@ -2661,6 +2661,10 @@
>  #define PCI_DEVICE_ID_DCI_PCCOM8	0x0002
>  #define PCI_DEVICE_ID_DCI_PCCOM2	0x0004
>  
> +#define PCI_VENDOR_ID_GLENFLY	    0x6766
> +#define PCI_DEVICE_ID_GLENFLY_ARISE10C0_AUDIO	 0x3D40
> +#define PCI_DEVICE_ID_GLENFLY_ARISE1020_AUDIO	 0x3D41
> +
>  #define PCI_VENDOR_ID_INTEL		0x8086
>  #define PCI_DEVICE_ID_INTEL_EESSC	0x0008
>  #define PCI_DEVICE_ID_INTEL_HDA_CML_LP	0x02c8
> diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
> index b33602e64d17..e8958a464647 100644
> --- a/sound/pci/hda/hda_intel.c
> +++ b/sound/pci/hda/hda_intel.c
> @@ -2671,7 +2671,7 @@ static const struct pci_device_id azx_ids[] = {
>  	  .driver_data = AZX_DRIVER_ATIHDMI_NS | AZX_DCAPS_PRESET_ATI_HDMI_NS |
>  	  AZX_DCAPS_PM_RUNTIME },
>  	/* GLENFLY */
> -	{ PCI_DEVICE(0x6766, PCI_ANY_ID),
> +	{ PCI_DEVICE(PCI_VENDOR_ID_GLENFLY, PCI_ANY_ID),
>  	  .class = PCI_CLASS_MULTIMEDIA_HD_AUDIO << 8,
>  	  .class_mask = 0xffffff,
>  	  .driver_data = AZX_DRIVER_GFHDMI | AZX_DCAPS_POSFIX_LPIB |
> -- 
> 2.43.4
> 

