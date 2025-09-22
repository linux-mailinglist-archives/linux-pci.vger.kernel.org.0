Return-Path: <linux-pci+bounces-36669-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2F82B91692
	for <lists+linux-pci@lfdr.de>; Mon, 22 Sep 2025 15:32:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 177337ACE57
	for <lists+linux-pci@lfdr.de>; Mon, 22 Sep 2025 13:31:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEADB30C619;
	Mon, 22 Sep 2025 13:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="SiD+5Lro";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="pmKAPtHH";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="SiD+5Lro";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="pmKAPtHH"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02AC0309F0A
	for <linux-pci@vger.kernel.org>; Mon, 22 Sep 2025 13:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758547960; cv=none; b=Rf99t1oKAnzqqpWdVeRHIs0rmu6iev47vtu+bGwTcbfyS0pZZVWDl6/vxgndGtuc2mrdc7MQB5wP9QYyayNWF30HcHN+bp+VnTtw3Ufwo9jEPQop+IUP7xI0oG4/ZXcg/0JJ2HJDAQJ/NdaacptxnTSk+r6McyuQSLCyD/ynQUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758547960; c=relaxed/simple;
	bh=msEtCxPw1Q+NQNP/NUwrNhWFN0iB75jLAt8ym53Z4Is=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pXqQttHZ/LyGykA1ZJViJ4lO7Q2YOUiUryxmwJIXQNY/x3ZBss2pdGLZR3otLU55fo8F0yumm42FOrqvNy9LTuMag7YwjpON4fPtMb+H5rVUFtX/MaZY3sCmHHxp/ck9BHRoPycS4+TJ4M9X6sZGOvghlQoUW03xJLix+DtTd3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=SiD+5Lro; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=pmKAPtHH; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=SiD+5Lro; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=pmKAPtHH; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 01E8733772;
	Mon, 22 Sep 2025 13:32:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1758547957; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZhEzsNGYvikcV5pZIDnjqvry8vcm585kM1Qo2pcC4/w=;
	b=SiD+5Lro1DX0jpai6Q1mKi4U8NtLvRpxWqcvNElHwvTAHJFzgIxkKAAa9Zsfr7mnRNWhW4
	kOn16iSbfZHTu7zI0Uwc5WIDyHzlE4YjL5uyBlTJxvZMHFgwM9DGsM0t2IMDZRVi1jHkoi
	yaCOP63VV9W6ffdA/V9HcU6Qw4IZVNg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1758547957;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZhEzsNGYvikcV5pZIDnjqvry8vcm585kM1Qo2pcC4/w=;
	b=pmKAPtHHCCf37ZysvZ9DkkPVVz6nqk6Dx1FTROONTwPqFxTcFcN2o8wjfdpTQIkjR28KMk
	Eud4J2As+FBzoABQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=SiD+5Lro;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=pmKAPtHH
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1758547957; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZhEzsNGYvikcV5pZIDnjqvry8vcm585kM1Qo2pcC4/w=;
	b=SiD+5Lro1DX0jpai6Q1mKi4U8NtLvRpxWqcvNElHwvTAHJFzgIxkKAAa9Zsfr7mnRNWhW4
	kOn16iSbfZHTu7zI0Uwc5WIDyHzlE4YjL5uyBlTJxvZMHFgwM9DGsM0t2IMDZRVi1jHkoi
	yaCOP63VV9W6ffdA/V9HcU6Qw4IZVNg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1758547957;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZhEzsNGYvikcV5pZIDnjqvry8vcm585kM1Qo2pcC4/w=;
	b=pmKAPtHHCCf37ZysvZ9DkkPVVz6nqk6Dx1FTROONTwPqFxTcFcN2o8wjfdpTQIkjR28KMk
	Eud4J2As+FBzoABQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B24D01388C;
	Mon, 22 Sep 2025 13:32:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id n9ndKfRP0WhNewAAD6G6ig
	(envelope-from <tiwai@suse.de>); Mon, 22 Sep 2025 13:32:36 +0000
Date: Mon, 22 Sep 2025 15:32:36 +0200
Message-ID: <87348eobnv.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Takashi Iwai <tiwai@suse.de>,
	Linux PM <linux-pm@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Linux PCI <linux-pci@vger.kernel.org>,
	Alex Williamson <alex.williamson@redhat.com>,
	Bjorn Helgaas <helgaas@kernel.org>,
	Zhang Qilong <zhangqilong3@huawei.com>,
	Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v2 1/3] PM: runtime: Add auto-cleanup macros for "resume and get" operations
In-Reply-To: <CAJZ5v0hSBDg4fD7Gy6yEX31xO-3USJG_jFps71BRJJ2f0Oh90A@mail.gmail.com>
References: <6204724.lOV4Wx5bFT@rafael.j.wysocki>
	<3388279.44csPzL39Z@rafael.j.wysocki>
	<875xdaevab.wl-tiwai@suse.de>
	<CAJZ5v0hSBDg4fD7Gy6yEX31xO-3USJG_jFps71BRJJ2f0Oh90A@mail.gmail.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 01E8733772
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_DN_ALL(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	ARC_NA(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,suse.de:dkim,suse.de:mid,suse.de:email]
X-Spam-Score: -3.51

On Mon, 22 Sep 2025 14:50:32 +0200,
Rafael J. Wysocki wrote:
> 
> On Mon, Sep 22, 2025 at 10:38 AM Takashi Iwai <tiwai@suse.de> wrote:
> >
> > On Sat, 20 Sep 2025 12:54:58 +0200,
> > Rafael J. Wysocki wrote:
> > >
> > > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > >
> > > It is generally useful to be able to automatically drop a device's
> > > runtime PM usage counter incremented by runtime PM operations that
> > > resume a device and bump up its usage counter [1].
> > >
> > > To that end, add DEFINE_CLASS() macros allowing pm_runtime_put()
> > > and pm_runtime_put_autosuspend() to be used for the auto-cleanup in
> > > those cases.
> > >
> > > Simply put, a piece of code like below:
> > >
> > >       pm_runtime_get_sync(dev);
> > >       .....
> > >       pm_runtime_put(dev);
> > >       return 0;
> > >
> > > can be transformed with CLASS() like:
> > >
> > >       CLASS(pm_runtime_get_active, pm)(dev);
> > >       if (IS_ERR(pm))
> > >               return PTR_ERR(pm);
> > >       .....
> > >       return 0;
> > >
> > > (note the new resume error handling).
> >
> > Do we still allow the code without the error check even using CLASS()?
> > Although the error check should be handled, it's not mandatory for
> > now.  That said, the above example could be still in a form like:
> >
> >         CLASS(pm_runtime_get_active, pm)(dev);
> >         .....
> >         return 0;
> >
> > while adding the proper error check is recommended?
> 
> I'd rather not encourage doing this.
> 
> While it may still produce working code in some cases, one needs to
> remember that in case of a runtime resume error it will be running
> without a runtime PM reference it has attempted to acquire.

Fair enough.  Then it'd be also good to mention that in the
description, too.


thanks,

Takashi

