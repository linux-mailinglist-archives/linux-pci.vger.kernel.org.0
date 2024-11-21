Return-Path: <linux-pci+bounces-17165-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D05F09D4E53
	for <lists+linux-pci@lfdr.de>; Thu, 21 Nov 2024 15:11:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 574781F22E91
	for <lists+linux-pci@lfdr.de>; Thu, 21 Nov 2024 14:11:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 205D41D89E2;
	Thu, 21 Nov 2024 14:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Hxm+jn3s";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="YGXSeOHa";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="CGeu9KB/";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="K6ngicCq"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 358F81D79B0;
	Thu, 21 Nov 2024 14:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732198283; cv=none; b=RGWMPLYdgH5xXRzutbFjNkF3q+qygseP198Uq3YzgUiRduAMPXyaSprjf+EJ/AppI80qwmyvpzGxGvtdk5Qur0D7d/fvLN9BB6JJqx2o3F6piVbRGhJbb9saxRjpFORQVsV6MO3ZFc5xR6/DGTmcp3zYeJ5SXOa2pyJIrQQ+h9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732198283; c=relaxed/simple;
	bh=Ey0IAPn0edSlqo7bOQ+Oiyx7q+LGOFPvfHfglTadl48=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=avfNkRCA8Y59w8LCAy76PIfNZF9lbzOzPaJ3zczEUZAsphuTOK1HBKkGYs3pEnT/1fjmDKxnPY/u8gNEufRdJh4fIJ3Jipuk3+dqzEYyNr5JmV2IGS4/xq9hyAAAI1b4gbxAvR97MdXppfjYwR8Yhdwyx6tRsm0gNcvntibjoz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Hxm+jn3s; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=YGXSeOHa; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=CGeu9KB/; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=K6ngicCq; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 1318F21A24;
	Thu, 21 Nov 2024 14:11:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1732198279; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=90qHUuZk+1shGNjirM2QL8Sq/3ge+2iP+PRdngdmwIc=;
	b=Hxm+jn3syYbS/XV73a7xZR+I3qTeWIKIAL32wjjGghP/Q+pClw2UCrojhSIycO5T+VgQxc
	4pw9T043OAd3pqQ/USAFQyhj06bSugJCCqCy089T5iCcwE3BGenx5H2sFJzdBT7OGKgUbr
	90fIrko6yH8/4TThNXoj5T6pw7cPCzQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1732198279;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=90qHUuZk+1shGNjirM2QL8Sq/3ge+2iP+PRdngdmwIc=;
	b=YGXSeOHa5HHOZMGy8Mc9vhsoUcaEWwniGYLfXV1/F12FnMwNZK83oA2hMdDm+1PSMiv2As
	Fct9jTR6FxM2yfBQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="CGeu9KB/";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=K6ngicCq
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1732198278; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=90qHUuZk+1shGNjirM2QL8Sq/3ge+2iP+PRdngdmwIc=;
	b=CGeu9KB/AMGHF+y5efvIZEnWDHTbQKZ8oQCIjmZqD5nwHfeWl/URw0G90EkFlxg30vNNaP
	qAM4V/jVeQf+sevvwynf3QQ/lsISGmUvkgscFY9I4OM8Mi+8Gcw1JSNWYCdhjBsJdlVijA
	nWvsyiVEXLBEAp/JVJdcCpOJKqRodzU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1732198278;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=90qHUuZk+1shGNjirM2QL8Sq/3ge+2iP+PRdngdmwIc=;
	b=K6ngicCqcSxUVrJ49BCm0nDvfriyWDmz7K6hkNWM3oB4Q2w4pFLaemKNuU1kMcVsD3lbWw
	K+BQ5DoUsPdL/7Bg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 51B8513927;
	Thu, 21 Nov 2024 14:11:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Xb3nEYU/P2doNQAAD6G6ig
	(envelope-from <jdelvare@suse.de>); Thu, 21 Nov 2024 14:11:17 +0000
Date: Thu, 21 Nov 2024 15:11:16 +0100
From: Jean Delvare <jdelvare@suse.de>
To: Leon Romanovsky <leon@kernel.org>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Krzysztof =?UTF-8?B?V2lsY3p5xYRz?=
 =?UTF-8?B?a2k=?= <kw@linux.com>, linux-pci@vger.kernel.org, Ariel Almog
 <ariela@nvidia.com>, Aditya Prabhune <aprabhune@nvidia.com>, Hannes
 Reinecke <hare@suse.de>, Heiner Kallweit <hkallweit1@gmail.com>, Arun Easi
 <aeasi@marvell.com>, Jonathan Chocron <jonnyc@amazon.com>, Bert Kenward
 <bkenward@solarflare.com>, Matt Carlson <mcarlson@broadcom.com>, Kai-Heng
 Feng <kai.heng.feng@canonical.com>, Alex Williamson
 <alex.williamson@redhat.com>, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>, Thomas
 =?UTF-8?B?V2Vpw59zY2h1aA==?= <linux@weissschuh.net>, Stephen Hemminger
 <stephen@networkplumber.org>
Subject: Re: [PATCH v2] PCI/sysfs: Change read permissions for VPD
 attributes
Message-ID: <20241121151116.4213c144@endymion.delvare>
In-Reply-To: <20241121121301.GA160612@unreal>
References: <61a0fa74461c15edfae76222522fa445c28bec34.1731502431.git.leon@kernel.org>
	<20241121130127.5df61661@endymion.delvare>
	<20241121121301.GA160612@unreal>
Organization: SUSE Linux
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.34; x86_64-suse-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 1318F21A24
X-Spam-Score: -4.51
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	HAS_ORG_HEADER(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,linux.com,vger.kernel.org,nvidia.com,suse.de,gmail.com,marvell.com,amazon.com,solarflare.com,broadcom.com,canonical.com,redhat.com,weissschuh.net,networkplumber.org];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,endymion.delvare:mid,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Thu, 21 Nov 2024 14:13:01 +0200, Leon Romanovsky wrote:
> On Thu, Nov 21, 2024 at 01:01:27PM +0100, Jean Delvare wrote:
> > On Wed, 13 Nov 2024 14:59:58 +0200, Leon Romanovsky wrote:  
> > > --- a/drivers/pci/vpd.c
> > > +++ b/drivers/pci/vpd.c
> > > @@ -332,6 +332,14 @@ static umode_t vpd_attr_is_visible(struct kobject *kobj,
> > >  	if (!pdev->vpd.cap)
> > >  		return 0;
> > >  
> > > +	/*
> > > +	 * Mellanox devices have implementation that allows VPD read by
> > > +	 * unprivileged users, so just add needed bits to allow read.
> > > +	 */
> > > +	WARN_ON_ONCE(a->attr.mode != 0600);
> > > +	if (unlikely(pdev->vendor == PCI_VENDOR_ID_MELLANOX))
> > > +		return a->attr.mode + 0044;  
> > 
> > When manipulating bitfields, | is preferred. This would make the
> > operation safe regardless of the initial value, so you can even get rid
> > of the WARN_ON_ONCE() above.  
> 
> The WARN_ON_ONCE() is intended to catch future changes in VPD sysfs
> attributes. My intention is that once that WARN will trigger, the
> author will be forced to reevaluate the latter if ( ... PCI_VENDOR_ID_MELLANOX)
> condition and maybe we won't need it anymore. Without WARN_ON_ONCE, it
> is easy to miss that code.

The default permissions are 10 lines above in the same file. Doesn't
seem that easy to miss to me.

In my opinion, WARN_ON should be limited to cases where something really
bad has happened. It's not supposed to be a reminder for developers to
perform some code clean-up. Remember that WARN_ON has a run-time cost
and it could be evaluated for a possibly large number of PCI devices
(although admittedly VPD support seems to be present only in a limited
number of PCI device).

Assuming you properly use | instead of +, then nothing bad will happen
if the default permissions change, the code will simply become a no-op,
until someone notices and deletes it. No harm done.

I'm not maintaining this part of the kernel so I can't speak or decide
on behalf of the maintainers, but in my opinion, if you really want to
leave a note for future developers, then a comment in the source code
is a better way, as it has no run-time cost, and will also be found
earlier by the developers (no need for run-time testing).

Thanks,
-- 
Jean Delvare
SUSE L3 Support

