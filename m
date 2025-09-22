Return-Path: <linux-pci+bounces-36639-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 90E66B8F93D
	for <lists+linux-pci@lfdr.de>; Mon, 22 Sep 2025 10:39:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 390B3189F8EB
	for <lists+linux-pci@lfdr.de>; Mon, 22 Sep 2025 08:39:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0855265632;
	Mon, 22 Sep 2025 08:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="kwPAuYCZ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="qnJmSgp5";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="kwPAuYCZ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="qnJmSgp5"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 148F121ABB9
	for <linux-pci@vger.kernel.org>; Mon, 22 Sep 2025 08:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758530336; cv=none; b=ZeDXeCbZr60j7HoOoL3wsYDVQ4VhYvABVH5I36iT9maI+rdnMB0/hAMV5FpX/RWHWM/U8+pDbrz5kGVTO0YEb/okiUnsnW77A/fppwReDZ8gUFnuig5Z1jmVILvoguwf3u7d/koMsOWbSJbUrb3Dqvhz29zxK6vU2VtGrNdl3XM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758530336; c=relaxed/simple;
	bh=2OnJidlSmxP67bMZGfBWh2+IXg580m43RoHwSsKkm5s=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H4UjmMbF82CeNOWhpN8hkJmD6/WWuAskTGulGp5hysP5iJ4lWmNuYhmwka44u7iPeBqxCUukcGdHQIPtU7SxQH+yuybg06alKCv41aVVBtKjPwho61EUv1z9KbYpGfNqoDVHkd8Qy2XkcIo1RolraHeCLxsDhNyjo8n1rntv0nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=kwPAuYCZ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=qnJmSgp5; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=kwPAuYCZ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=qnJmSgp5; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 5BABF2267A;
	Mon, 22 Sep 2025 08:38:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1758530333; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3FBFwzwbywcqa4BZPwtgXazqmPvTlx9lbITwaYdKPx4=;
	b=kwPAuYCZ0QEQPt9Zyh34nC5mUxNcc10e2+eggmiFrSPYeFQ4K+7wXaS7kkPkCjXTLnqtPN
	+59tl4DIOhgJAGsgxicY1v1MgrJPHF3bZk2njkBZutKkrk7kEaMx3psVvQB1lhFZ0AmIO1
	gzMxuQs+vFRSIchTdS2cFFFTXpuV7w4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1758530333;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3FBFwzwbywcqa4BZPwtgXazqmPvTlx9lbITwaYdKPx4=;
	b=qnJmSgp5ho1CiZHwwUETXf+X3e81NdY1ohQChby5qkDK91JPcj+76CEiNhJiEbJegooAi4
	ETLckbB8hcjvZODw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=kwPAuYCZ;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=qnJmSgp5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1758530333; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3FBFwzwbywcqa4BZPwtgXazqmPvTlx9lbITwaYdKPx4=;
	b=kwPAuYCZ0QEQPt9Zyh34nC5mUxNcc10e2+eggmiFrSPYeFQ4K+7wXaS7kkPkCjXTLnqtPN
	+59tl4DIOhgJAGsgxicY1v1MgrJPHF3bZk2njkBZutKkrk7kEaMx3psVvQB1lhFZ0AmIO1
	gzMxuQs+vFRSIchTdS2cFFFTXpuV7w4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1758530333;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3FBFwzwbywcqa4BZPwtgXazqmPvTlx9lbITwaYdKPx4=;
	b=qnJmSgp5ho1CiZHwwUETXf+X3e81NdY1ohQChby5qkDK91JPcj+76CEiNhJiEbJegooAi4
	ETLckbB8hcjvZODw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1CADF1388C;
	Mon, 22 Sep 2025 08:38:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id PR6fBR0L0WhHFwAAD6G6ig
	(envelope-from <tiwai@suse.de>); Mon, 22 Sep 2025 08:38:53 +0000
Date: Mon, 22 Sep 2025 10:38:52 +0200
Message-ID: <875xdaevab.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux PM <linux-pm@vger.kernel.org>,
	Takashi Iwai <tiwai@suse.de>,
	LKML <linux-kernel@vger.kernel.org>,
	Linux PCI <linux-pci@vger.kernel.org>,
	Alex Williamson <alex.williamson@redhat.com>,
	Bjorn Helgaas <helgaas@kernel.org>,
	Zhang Qilong <zhangqilong3@huawei.com>,
	Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v2 1/3] PM: runtime: Add auto-cleanup macros for "resume and get" operations
In-Reply-To: <3388279.44csPzL39Z@rafael.j.wysocki>
References: <6204724.lOV4Wx5bFT@rafael.j.wysocki>
	<3388279.44csPzL39Z@rafael.j.wysocki>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 5BABF2267A
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,suse.de:dkim,suse.de:mid];
	TO_DN_ALL(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Spam-Score: -3.51

On Sat, 20 Sep 2025 12:54:58 +0200,
Rafael J. Wysocki wrote:
> 
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> It is generally useful to be able to automatically drop a device's
> runtime PM usage counter incremented by runtime PM operations that
> resume a device and bump up its usage counter [1].
> 
> To that end, add DEFINE_CLASS() macros allowing pm_runtime_put()
> and pm_runtime_put_autosuspend() to be used for the auto-cleanup in
> those cases.
> 
> Simply put, a piece of code like below:
> 
> 	pm_runtime_get_sync(dev);
> 	.....
> 	pm_runtime_put(dev);
> 	return 0;
> 
> can be transformed with CLASS() like:
> 
> 	CLASS(pm_runtime_get_active, pm)(dev);
> 	if (IS_ERR(pm))
> 		return PTR_ERR(pm);
> 	.....
> 	return 0;
> 
> (note the new resume error handling).

Do we still allow the code without the error check even using CLASS()?
Although the error check should be handled, it's not mandatory for
now.  That said, the above example could be still in a form like:

	CLASS(pm_runtime_get_active, pm)(dev);
	.....
	return 0;

while adding the proper error check is recommended?


thanks,

Takashi

