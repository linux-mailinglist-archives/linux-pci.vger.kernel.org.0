Return-Path: <linux-pci+bounces-40832-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AD5DC4BB7E
	for <lists+linux-pci@lfdr.de>; Tue, 11 Nov 2025 07:43:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A5C4C1883E60
	for <lists+linux-pci@lfdr.de>; Tue, 11 Nov 2025 06:43:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9275A31A045;
	Tue, 11 Nov 2025 06:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="MJJifpxj";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="XOVf1gy9";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="MJJifpxj";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="XOVf1gy9"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9727E2D0292
	for <linux-pci@vger.kernel.org>; Tue, 11 Nov 2025 06:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762843353; cv=none; b=lIJZ4lu1aJQ/eUB64tB8bzXqMFxuZSvTAXigl+dn7Vy9q2sqx9LFf5r3mLC/SaNLVZA3QOLb9+uPtdwLSX4oGfVQqW8VLPzzThPSzLUtRSqPNYBhLzVDsoDxWEQmImVJLy4dqR3fQpKoApPoEE5HuGrlM8/gpm9+NkfdgMJba7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762843353; c=relaxed/simple;
	bh=ATNN5RmueLox2IC+5BDEXAgaIglCENc+yF4ZTPMaIZg=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ao7amljYXceQ2LdBBeKEMN10zrmnyk4frjAzw2oR+pqVl70SoVGw9GHC1gpYb3g0suCLKZAOz8RLJu8A0+UlJ9cp7qrfjIw/8V12w9mydfXiYMnz7mFp8PPrDAi30wWGBUo1GJT35nMZGLyutRiIYnrbpTdFEZUENbDcJl5o5kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=MJJifpxj; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=XOVf1gy9; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=MJJifpxj; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=XOVf1gy9; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 003E121D96;
	Tue, 11 Nov 2025 06:42:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1762843347; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fnn8buj3dz2cAu1lwnMV3wmGOQAis/X/NnrYyJhRgpI=;
	b=MJJifpxj0d+JjXgZOzmxMDpQDTSyIadrJYsNIbJl+ULZfRSkA1F3QRigpspAqsE+66Rhp4
	Shn7meUxG5KGJZOHhOahRAQKGy6Nb5TLhqjOSRo1AsBLy8kaYN8yBZmHfsJ+Bw3No+qv6Y
	5wW5dT7W11nmHzpKpr6zOoTnHE6LBoQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1762843347;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fnn8buj3dz2cAu1lwnMV3wmGOQAis/X/NnrYyJhRgpI=;
	b=XOVf1gy9U5gZVwTjF3TZLqMUlzKAS6MC5EfTBJRYyS+0eMhaSrKs4ZKyZxOlsKibNkjCP/
	7jvcMdxbfbH3qxAQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1762843347; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fnn8buj3dz2cAu1lwnMV3wmGOQAis/X/NnrYyJhRgpI=;
	b=MJJifpxj0d+JjXgZOzmxMDpQDTSyIadrJYsNIbJl+ULZfRSkA1F3QRigpspAqsE+66Rhp4
	Shn7meUxG5KGJZOHhOahRAQKGy6Nb5TLhqjOSRo1AsBLy8kaYN8yBZmHfsJ+Bw3No+qv6Y
	5wW5dT7W11nmHzpKpr6zOoTnHE6LBoQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1762843347;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fnn8buj3dz2cAu1lwnMV3wmGOQAis/X/NnrYyJhRgpI=;
	b=XOVf1gy9U5gZVwTjF3TZLqMUlzKAS6MC5EfTBJRYyS+0eMhaSrKs4ZKyZxOlsKibNkjCP/
	7jvcMdxbfbH3qxAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EAC3E14805;
	Tue, 11 Nov 2025 06:42:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id OZMhONDaEmkhSgAAD6G6ig
	(envelope-from <tiwai@suse.de>); Tue, 11 Nov 2025 06:42:24 +0000
Date: Tue, 11 Nov 2025 07:42:24 +0100
Message-ID: <87jyzx2hpr.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Corey Minyard <corey@minyard.net>,	Christian =?ISO-8859-1?Q?K=F6nig?=
 <christian.koenig@amd.com>,	"Dr. David Alan Gilbert" <linux@treblig.org>,
	Alex Deucher <alexander.deucher@amd.com>,	Thomas Zimmermann
 <tzimmermann@suse.de>,	Dmitry Baryshkov
 <dmitry.baryshkov@oss.qualcomm.com>,	Rob Clark
 <robin.clark@oss.qualcomm.com>,	Matthew Brost <matthew.brost@intel.com>,
	Hans Verkuil <hverkuil@kernel.org>,	Laurent Pinchart
 <laurent.pinchart+renesas@ideasonboard.com>,	Ulf Hansson
 <ulf.hansson@linaro.org>,	Vitaly Lifshits <vitaly.lifshits@intel.com>,
	Manivannan Sadhasivam <mani@kernel.org>,	Niklas Cassel <cassel@kernel.org>,
	Calvin Owens <calvin@wbinvd.org>,	Sagi Maimon <maimon.sagi@gmail.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,	Karan Tilak Kumar
 <kartilak@cisco.com>,	Casey Schaufler <casey@schaufler-ca.com>,	Steven
 Rostedt <rostedt@goodmis.org>,	Petr Mladek <pmladek@suse.com>,	Max
 Kellermann <max.kellermann@ionos.com>,	Takashi Iwai <tiwai@suse.de>,
	linux-doc@vger.kernel.org,	linux-kernel@vger.kernel.org,
	openipmi-developer@lists.sourceforge.net,	linux-media@vger.kernel.org,
	dri-devel@lists.freedesktop.org,	linaro-mm-sig@lists.linaro.org,
	amd-gfx@lists.freedesktop.org,	linux-arm-msm@vger.kernel.org,
	freedreno@lists.freedesktop.org,	intel-xe@lists.freedesktop.org,
	linux-mmc@vger.kernel.org,	netdev@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org,	linux-pci@vger.kernel.org,
	linux-s390@vger.kernel.org,	linux-scsi@vger.kernel.org,
	linux-staging@lists.linux.dev,	ceph-devel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,	linux-sound@vger.kernel.org,	Rasmus
 Villemoes <linux@rasmusvillemoes.dk>,	Sergey Senozhatsky
 <senozhatsky@chromium.org>,	Jonathan Corbet <corbet@lwn.net>,	Sumit Semwal
 <sumit.semwal@linaro.org>,	Gustavo Padovan <gustavo@padovan.org>,	David
 Airlie <airlied@gmail.com>,	Simona Vetter <simona@ffwll.ch>,	Maarten
 Lankhorst <maarten.lankhorst@linux.intel.com>,	Maxime Ripard
 <mripard@kernel.org>,	Dmitry Baryshkov <lumag@kernel.org>,	Abhinav Kumar
 <abhinav.kumar@linux.dev>,	Jessica Zhang <jesszhan0024@gmail.com>,	Sean
 Paul <sean@poorly.run>,	Marijn Suijten <marijn.suijten@somainline.org>,
	Konrad Dybcio <konradybcio@kernel.org>,	Lucas De Marchi
 <lucas.demarchi@intel.com>,	Thomas =?ISO-8859-1?Q?Hellstr=F6m?=
 <thomas.hellstrom@linux.intel.com>,	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,	Vladimir Oltean
 <olteanv@gmail.com>,	Andrew Lunn <andrew@lunn.ch>,	"David S. Miller"
 <davem@davemloft.net>,	Eric Dumazet <edumazet@google.com>,	Jakub Kicinski
 <kuba@kernel.org>,	Paolo Abeni <pabeni@redhat.com>,	Tony Nguyen
 <anthony.l.nguyen@intel.com>,	Przemek Kitszel
 <przemyslaw.kitszel@intel.com>,	Krzysztof =?ISO-8859-2?Q?Wilczy=F1ski?=
 <kwilczynski@kernel.org>,	Kishon Vijay Abraham I <kishon@kernel.org>,	Bjorn
 Helgaas <bhelgaas@google.com>,	Rodolfo Giometti <giometti@enneenne.com>,
	Jonathan Lemon <jonathan.lemon@gmail.com>,	Vadim Fedorenko
 <vadim.fedorenko@linux.dev>,	Richard Cochran <richardcochran@gmail.com>,
	Stefan Haberland <sth@linux.ibm.com>,	Jan Hoeppner
 <hoeppner@linux.ibm.com>,	Heiko Carstens <hca@linux.ibm.com>,	Vasily Gorbik
 <gor@linux.ibm.com>,	Alexander Gordeev <agordeev@linux.ibm.com>,	Christian
 Borntraeger <borntraeger@linux.ibm.com>,	Sven Schnelle
 <svens@linux.ibm.com>,	Satish Kharat <satishkh@cisco.com>,	Sesidhar Baddela
 <sebaddel@cisco.com>,	"James E.J. Bottomley"
 <James.Bottomley@HansenPartnership.com>,	Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>,	Xiubo Li <xiubli@redhat.com>,	Ilya Dryomov
 <idryomov@gmail.com>,	Masami Hiramatsu <mhiramat@kernel.org>,	Mathieu
 Desnoyers <mathieu.desnoyers@efficios.com>,	Andrew Morton
 <akpm@linux-foundation.org>,	Jaroslav Kysela <perex@perex.cz>,	Takashi Iwai
 <tiwai@suse.com>
Subject: Re: [PATCH v1 02/23] ALSA: seq: Switch to use %ptSp
In-Reply-To: <20251110184727.666591-3-andriy.shevchenko@linux.intel.com>
References: <20251110184727.666591-1-andriy.shevchenko@linux.intel.com>
	<20251110184727.666591-3-andriy.shevchenko@linux.intel.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spam-Level: 
X-Spamd-Result: default: False [-1.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[renesas];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[minyard.net,amd.com,treblig.org,suse.de,oss.qualcomm.com,intel.com,kernel.org,ideasonboard.com,linaro.org,wbinvd.org,gmail.com,oracle.com,cisco.com,schaufler-ca.com,goodmis.org,suse.com,ionos.com,vger.kernel.org,lists.sourceforge.net,lists.freedesktop.org,lists.linaro.org,lists.osuosl.org,lists.linux.dev,rasmusvillemoes.dk,chromium.org,lwn.net,padovan.org,ffwll.ch,linux.intel.com,linux.dev,poorly.run,somainline.org,lunn.ch,davemloft.net,google.com,redhat.com,enneenne.com,linux.ibm.com,HansenPartnership.com,linuxfoundation.org,efficios.com,linux-foundation.org,perex.cz];
	R_RATELIMIT(0.00)[to_ip_from(RLmdkd3ei8pyzuqshpsr74qwzu)];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCPT_COUNT_GT_50(0.00)[96];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Score: -1.80

On Mon, 10 Nov 2025 19:40:21 +0100,
Andy Shevchenko wrote:
> 
> Use %ptSp instead of open coded variants to print content of
> struct timespec64 in human readable format.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  sound/core/seq/seq_queue.c | 2 +-
>  sound/core/seq/seq_timer.c | 6 +++---
>  2 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/sound/core/seq/seq_queue.c b/sound/core/seq/seq_queue.c
> index f5c0e401c8ae..f6e86cbf38bc 100644
> --- a/sound/core/seq/seq_queue.c
> +++ b/sound/core/seq/seq_queue.c
> @@ -699,7 +699,7 @@ void snd_seq_info_queues_read(struct snd_info_entry *entry,
>  		snd_iprintf(buffer, "current tempo      : %d\n", tmr->tempo);
>  		snd_iprintf(buffer, "tempo base         : %d ns\n", tmr->tempo_base);
>  		snd_iprintf(buffer, "current BPM        : %d\n", bpm);
> -		snd_iprintf(buffer, "current time       : %d.%09d s\n", tmr->cur_time.tv_sec, tmr->cur_time.tv_nsec);
> +		snd_iprintf(buffer, "current time       : %ptSp s\n", &tmr->cur_time);
>  		snd_iprintf(buffer, "current tick       : %d\n", tmr->tick.cur_tick);
>  		snd_iprintf(buffer, "\n");
>  	}

tmr->cur_time isn't struct timespec64, but it's struct
tmr->snd_seq_real_time.


thanks,

Takashi

