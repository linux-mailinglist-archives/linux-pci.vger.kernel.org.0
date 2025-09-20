Return-Path: <linux-pci+bounces-36567-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D74B2B8C0DF
	for <lists+linux-pci@lfdr.de>; Sat, 20 Sep 2025 08:38:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 88F471C06312
	for <lists+linux-pci@lfdr.de>; Sat, 20 Sep 2025 06:38:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DA332D5949;
	Sat, 20 Sep 2025 06:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="WK+XP40l";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="LM3qWjZc";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="WK+XP40l";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="LM3qWjZc"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61926188734
	for <linux-pci@vger.kernel.org>; Sat, 20 Sep 2025 06:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758350280; cv=none; b=LDEPoosZiX0MFLB0mT4MbAMIrF0TP16uHgeapKQRDCmjeVnXkgXDpEGy/IQ2BEB+J5os//AVAVsaYN3FGELYiDHbpFSwBZ2d/3IZ7wLD/NOvjobV45aBWvEwX1DJ69N+UAw98eEPTCWo7wrUiHP5XRxGBVBQCaRHbsKFjddkP6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758350280; c=relaxed/simple;
	bh=VHOmo69n8KM79KB62I0gjPBk041aV+ckk7iDXW979AI=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=c8AVSA6xTliRsak4xKhwEQpi9jCMQyi6P/SGahds7m5dJpeW42vYxZNelD6P2yetYS5O6OhRKvRfAwyPmQGI3OfIVZAXfumsKNX1ufYS6ldCzGboY6Ihgtt8JjyXvvMjNAr8O7SOguaOgHx3ereNipEg71SMovQscnE+w9e38yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=WK+XP40l; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=LM3qWjZc; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=WK+XP40l; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=LM3qWjZc; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 989861F7B8;
	Sat, 20 Sep 2025 06:37:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1758350276; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6qHPxRcM8hvaooqJhNiXQR+BuEOMUHilV83neFMPBkk=;
	b=WK+XP40lSGd23Tmu37/pqNoX+yS5icJUdh//mePmA7LIGQDTFVBecY9/spp5kJqxIaMAAo
	A8hotdn+cWxRO+iNJfo3bYGbE2N+7mBn0O2ag9d6Hz6dmhgpTnkpFIkOTqtyG8D6vpHE1B
	5ILDcHne6pLJC5PMjQD8zQvq33OvlCc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1758350276;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6qHPxRcM8hvaooqJhNiXQR+BuEOMUHilV83neFMPBkk=;
	b=LM3qWjZcrb62Kt6mAlO1WMTpdpg1gAjrG0Q8lKMvi2zihsmbjfpsWxFnvLQU7C6TpE4ywQ
	iRbyuTMFb/NYQmDw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=WK+XP40l;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=LM3qWjZc
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1758350276; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6qHPxRcM8hvaooqJhNiXQR+BuEOMUHilV83neFMPBkk=;
	b=WK+XP40lSGd23Tmu37/pqNoX+yS5icJUdh//mePmA7LIGQDTFVBecY9/spp5kJqxIaMAAo
	A8hotdn+cWxRO+iNJfo3bYGbE2N+7mBn0O2ag9d6Hz6dmhgpTnkpFIkOTqtyG8D6vpHE1B
	5ILDcHne6pLJC5PMjQD8zQvq33OvlCc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1758350276;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6qHPxRcM8hvaooqJhNiXQR+BuEOMUHilV83neFMPBkk=;
	b=LM3qWjZcrb62Kt6mAlO1WMTpdpg1gAjrG0Q8lKMvi2zihsmbjfpsWxFnvLQU7C6TpE4ywQ
	iRbyuTMFb/NYQmDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 55283137D2;
	Sat, 20 Sep 2025 06:37:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id qPZxE8RLzmgVMQAAD6G6ig
	(envelope-from <tiwai@suse.de>); Sat, 20 Sep 2025 06:37:56 +0000
Date: Sat, 20 Sep 2025 08:37:55 +0200
Message-ID: <87y0q97hoc.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux PM <linux-pm@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Linux PCI <linux-pci@vger.kernel.org>,
	Alex Williamson <alex.williamson@redhat.com>,
	Bjorn Helgaas <helgaas@kernel.org>,
	Takashi Iwai <tiwai@suse.de>,
	Zhang Qilong <zhangqilong3@huawei.com>,
	Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v1 0/3] PM: runtime: Auto-cleanup macros for pm_runtime_resume_and_get()
In-Reply-To: <5049058.31r3eYUQgx@rafael.j.wysocki>
References: <5049058.31r3eYUQgx@rafael.j.wysocki>
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
X-Rspamd-Queue-Id: 989861F7B8
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
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_SEVEN(0.00)[9];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim,suse.de:mid,suse.de:email];
	TO_DN_ALL(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	URIBL_BLOCKED(0.00)[suse.de:dkim,suse.de:mid,suse.de:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	DKIM_TRACE(0.00)[suse.de:+]
X-Spam-Score: -3.51

On Fri, 19 Sep 2025 18:34:40 +0200,
Rafael J. Wysocki wrote:
> 
> Hi All,
> 
> This series adds two auto-cleanup macros for runtime PM usage counter
> incrementations carried out by pm_runtime_resume_and_get() ([1/3]),
> converts the only user of the previously introduced DEFINE_FREE()
> macro for pm_runtime_put() to using one of the new macros ([2/3]),
> and drops the DEFINE_FREE() mentioned above ([3/3]).
> 
> The new macros should be somewhat more straightforward to use than
> the existing _FREE and they enforce error handling.

For the series:

Reviewed-by: Takashi Iwai <tiwai@suse.de>


Thanks!

Takashi

