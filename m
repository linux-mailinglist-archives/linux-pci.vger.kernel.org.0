Return-Path: <linux-pci+bounces-36566-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D048EB8C0D6
	for <lists+linux-pci@lfdr.de>; Sat, 20 Sep 2025 08:36:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F3CE7C2D5A
	for <lists+linux-pci@lfdr.de>; Sat, 20 Sep 2025 06:36:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00EBA2D5928;
	Sat, 20 Sep 2025 06:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="rKyUb6gU";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="aUJqzXjH";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="rKyUb6gU";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="aUJqzXjH"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C05F2309B3
	for <linux-pci@vger.kernel.org>; Sat, 20 Sep 2025 06:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758350191; cv=none; b=I/6iJUBai4FyUGrlmmWmzwO9it9Xe7Ag8zs+Oz/bpxgYGAjtmi1Y4oUEkN588o3vXXh1jZIc3aJ7Fb0XyUnibTzBeV9HRJS3H0ed4ovlEocbt8RNJ7lirQw77zuNhjzGW3HrMQ53y2wCf/XtdP3Oh3ZiH0aaazUt9zf6+i9SBUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758350191; c=relaxed/simple;
	bh=zodCu95U8zYzOJSozI8ENyGXCYFJ+j01AIF1bTh4ChM=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ex0geFToCc1A/UbTkl1OneRHTExZB9ZzgcI73ci/c8TGhtKJoyK2q4c6wFt4rn7Gk8iaZhj21/KkWzQGJDSbGBE1x6tHlp+BYi9A4eQN9/Ae3m0NscS3AEyFWtrBGYVFGy1ROnIYuHtGznXOK43kENtZGPHAV7Kle66roc7GI1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=rKyUb6gU; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=aUJqzXjH; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=rKyUb6gU; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=aUJqzXjH; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 6B56621D10;
	Sat, 20 Sep 2025 06:36:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1758350188; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cuJwZIFYdbE6AtRgD8WxpCiO4B7kwdO8eeRBZDPSdKo=;
	b=rKyUb6gUpLpjCcmqmgjzBENP9nQS5nzMf6iIo4ocj4EKlujkCvqQz0rVxTLvaAR/ZaP6bY
	/1d6M292GJVEsd0WMSU63dGakYytwB314JVgx+hvXcxDWrhkvsnSPPc+r0cdsVlfumZ2bx
	HLAusN/0VL4ZvT6Pcgke3AKv2Dv0DFQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1758350188;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cuJwZIFYdbE6AtRgD8WxpCiO4B7kwdO8eeRBZDPSdKo=;
	b=aUJqzXjHrPqmSTG/9nVX09Kg4d7v3EoaOsJQlWR/AKUGKihJkNf11fLQX2ZNnyulFfB1hT
	8mk5Dy53QY/UpeCA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1758350188; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cuJwZIFYdbE6AtRgD8WxpCiO4B7kwdO8eeRBZDPSdKo=;
	b=rKyUb6gUpLpjCcmqmgjzBENP9nQS5nzMf6iIo4ocj4EKlujkCvqQz0rVxTLvaAR/ZaP6bY
	/1d6M292GJVEsd0WMSU63dGakYytwB314JVgx+hvXcxDWrhkvsnSPPc+r0cdsVlfumZ2bx
	HLAusN/0VL4ZvT6Pcgke3AKv2Dv0DFQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1758350188;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cuJwZIFYdbE6AtRgD8WxpCiO4B7kwdO8eeRBZDPSdKo=;
	b=aUJqzXjHrPqmSTG/9nVX09Kg4d7v3EoaOsJQlWR/AKUGKihJkNf11fLQX2ZNnyulFfB1hT
	8mk5Dy53QY/UpeCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 320BB137D2;
	Sat, 20 Sep 2025 06:36:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id TY6JCmxLzmiwMAAAD6G6ig
	(envelope-from <tiwai@suse.de>); Sat, 20 Sep 2025 06:36:28 +0000
Date: Sat, 20 Sep 2025 08:36:27 +0200
Message-ID: <87zfap7hqs.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Takashi Iwai <tiwai@suse.de>,
	linux-pm@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] PM: runtime: New class macros for auto-cleanup
In-Reply-To: <CAJZ5v0hjGi6vpgOYtjjX_Tmb47YPk4NSc97GuD-WnSQUsoBe5Q@mail.gmail.com>
References: <20250919163147.4743-1-tiwai@suse.de>
	<CAJZ5v0hjGi6vpgOYtjjX_Tmb47YPk4NSc97GuD-WnSQUsoBe5Q@mail.gmail.com>
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
X-Spamd-Result: default: False [-3.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.998];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email,suse.de:mid];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email,suse.de:mid]
X-Spam-Flag: NO
X-Spam-Score: -3.30

On Fri, 19 Sep 2025 18:44:12 +0200,
Rafael J. Wysocki wrote:
> 
> Hi,
> 
> On Fri, Sep 19, 2025 at 6:32 PM Takashi Iwai <tiwai@suse.de> wrote:
> >
> > Hi,
> >
> > this is a patch series to introduce the new class macros for easier
> > usage of PM runtime auto-cleanup features.
> >
> > There is only one existing user of __free(pm_runtime_put) in PCI core,
> > and this is converted with CLASS() macro, too.
> > Then the pm_runtime_put __free definition is dropped.
> >
> > The first patch was from Rafael (as found in the thread below), and I
> > left no sign-off as I expect he'll get and sign later again.
> >
> >
> > Link: https://lore.kernel.org/878qimv24u.wl-tiwai@suse.de
> 
> I've just done the same thing:
> 
> https://lore.kernel.org/linux-pm/5049058.31r3eYUQgx@rafael.j.wysocki/
> 
> which I said I would do:
> 
> https://lore.kernel.org/linux-pm/CAJZ5v0jJjYoTceD2_pgvKgKuPypo+8osnAuCefgAjrzY_w2n8A@mail.gmail.com/
> 
> :-)
> 
> Sorry for the confusion.
> 
> Any issues with using my version?

It was my misunderstanding as I read in hurry ;)
The patches look good, thanks!


Takashi

