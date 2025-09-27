Return-Path: <linux-pci+bounces-37157-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 04AA6BA5A79
	for <lists+linux-pci@lfdr.de>; Sat, 27 Sep 2025 09:55:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 92EAB4E02D7
	for <lists+linux-pci@lfdr.de>; Sat, 27 Sep 2025 07:55:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E96B2D2483;
	Sat, 27 Sep 2025 07:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="TFvjg9f+";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="jdh0rg52";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="eI+F+hRe";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="2lTe017r"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E74802D2494
	for <linux-pci@vger.kernel.org>; Sat, 27 Sep 2025 07:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758959714; cv=none; b=AsHraJqheB1v0ezowAQSZXUtHz7V1XeQsDXYPt17KVn4Wb6XfCPJasZHeBehjLm3iwFCFtIgQrCdrBWzDkpH785Eu/BSB9eJQ1kPQI3+ZWHj51pIQUPcYrcFSbMfY6N+TZXUPnPgNb2MfYTdtVN4k5p3VK4slVvqvVucknzgIec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758959714; c=relaxed/simple;
	bh=5xKwV3f3A/yfwlo0VWMkjY5for0VtGHR+cnrcypU8t4=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=taOkjbji+g8/2bWP+IsMVjHsU4jWXpoM65QIvhTRGW+kNT0ueRnuL1aaYGieOJ1attOreRl4n4SWK09pyKN6glgkcRmIn1s+bjpzhYzTCLmOsDQAJf6jkVzz9Dp3q84CiVNfpiTdZ8rBzsFlknMe06k1Uky0snQbBbU3wWfJgwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=TFvjg9f+; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=jdh0rg52; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=eI+F+hRe; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=2lTe017r; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id CD1AB261CC;
	Sat, 27 Sep 2025 07:55:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1758959711; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Gocbu/f+cw03Lh3Qw7tbrnavs60OWwuBzS7Bc1LX318=;
	b=TFvjg9f+9UVqyGnt3u8hCCGnyA3U0giQ70k38j2aRsiO5U6MHG5tZa36cPlDbZkOT2hfx3
	EY7DVIWupVsFgv6s7zruUQFsNjgu3BgHWS0V16VaqCumJ2IWPU/hPLwCvrlkw9axfHBaFc
	hiyzOLkI1uVKYp3sriLM7jEp24+C2Qs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1758959711;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Gocbu/f+cw03Lh3Qw7tbrnavs60OWwuBzS7Bc1LX318=;
	b=jdh0rg52Q7c98+6bUFFA2qxQwSEB44A5n6vpQh+nAmbfqPur5otpFqC8MPkFtn2fc/R+5z
	1R1YZRj87NuRP3Aw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=eI+F+hRe;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=2lTe017r
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1758959710; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Gocbu/f+cw03Lh3Qw7tbrnavs60OWwuBzS7Bc1LX318=;
	b=eI+F+hReACQH9YLH8RWkWgkKkiQTtkqAXKnd5w1a4EEjLj84utesmfB/B9ZeKP/gAkT7V5
	rco9TLftdC2/BF87cPXlDhZryC2lVwQ42gb/J34nOc4+Ff60koGaA8QyciVuqIkuwH986w
	16qypGt1tXsuFr3yOPYwIQF3WC7TLwY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1758959710;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Gocbu/f+cw03Lh3Qw7tbrnavs60OWwuBzS7Bc1LX318=;
	b=2lTe017rn6gta6mSmKYWZpP+DK5ixcAdWqD4DmGEprwl6TIvMp4SYtqfRNWq2YjmCkVSE7
	EQo6wOeGjZumklAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7856713782;
	Sat, 27 Sep 2025 07:55:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Lh4HHF6Y12h9MQAAD6G6ig
	(envelope-from <tiwai@suse.de>); Sat, 27 Sep 2025 07:55:10 +0000
Date: Sat, 27 Sep 2025 09:55:10 +0200
Message-ID: <87ecrsba8x.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux PM <linux-pm@vger.kernel.org>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Takashi Iwai <tiwai@suse.de>,
	LKML <linux-kernel@vger.kernel.org>,
	Linux PCI <linux-pci@vger.kernel.org>,
	Alex Williamson <alex.williamson@redhat.com>,
	Bjorn Helgaas <helgaas@kernel.org>,
	Zhang Qilong <zhangqilong3@huawei.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Frank Li <Frank.Li@nxp.com>,
	Dhruva Gole <d-gole@ti.com>
Subject: Re: [PATCH v4 0/3] PM: runtime: Auto-cleanup macros for runtime PM
In-Reply-To: <6196611.lOV4Wx5bFT@rafael.j.wysocki>
References: <6196611.lOV4Wx5bFT@rafael.j.wysocki>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spamd-Result: default: False [-3.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:mid,suse.de:dkim,suse.de:email];
	TO_DN_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+]
X-Spam-Flag: NO
X-Spam-Level: 
X-Rspamd-Queue-Id: CD1AB261CC
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.51

On Fri, 26 Sep 2025 17:40:29 +0200,
Rafael J. Wysocki wrote:
> 
> Hi All,
> 
> This supersedes
> 
> https://lore.kernel.org/linux-pm/12763087.O9o76ZdvQC@rafael.j.wysocki/
> 
> which was an update of
> 
> https://lore.kernel.org/linux-pm/6204724.lOV4Wx5bFT@rafael.j.wysocki/
> 
> that superseded both
> 
> https://lore.kernel.org/linux-pm/5049058.31r3eYUQgx@rafael.j.wysocki/
> 
> and
> 
> https://lore.kernel.org/linux-pm/20250919163147.4743-1-tiwai@suse.de/
> 
> It follows the Jonathan's suggestion to use ACQUIRE()/ACQUIRE_ERR()
> instead af raw CLASS() to make the code somewhat cleaner.

ACQUIRE() version looks simpler and more suitable, indeed.

Reviewed-by: Takashi Iwai <tiwai@suse.de>


Thanks!

Takashi

