Return-Path: <linux-pci+bounces-36564-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 02801B8C0C7
	for <lists+linux-pci@lfdr.de>; Sat, 20 Sep 2025 08:34:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1FFA81C04593
	for <lists+linux-pci@lfdr.de>; Sat, 20 Sep 2025 06:34:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D16522D7387;
	Sat, 20 Sep 2025 06:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="tfGpCzEr";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="1K7rWjtv";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="tfGpCzEr";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="1K7rWjtv"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54BD52D63E4
	for <linux-pci@vger.kernel.org>; Sat, 20 Sep 2025 06:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758350020; cv=none; b=jYAs9zbjfBVQsrI/QKJRRphdrlEC4WSu2diUMTk2cIbbgpYDWP6lY6HWRpRpj7p5s+QEB6kA1PJ14pcIz4xGlpP4bXqKDdUwxuly0jFVd2YZz1CzT3a/PJmheoepNbmZBGn5qeT0vX/l/iF8ZzYzZ0z7bADMo3MWYShvwZ6x1Gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758350020; c=relaxed/simple;
	bh=eQQ7hAR9nUWaQKK9+1wa0UedrmpZ2j2iHLjutzK58HY=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ob/aYb9P/0wbSMfxK/nSEzrCBD7tTKR97zP2FB6lXWSaQsVFVmqvsPKhXm5UkYkvLWUF9DaCJww4NHnB7gQC7IQa1CntN4ecZanxWgyKTQlNkHa4FwsYp9Uba4Nha5WY7UecI0+j9Xrf/Y7U0uRoZZc5ugLYnCGuVnL1D5h/Xeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=tfGpCzEr; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=1K7rWjtv; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=tfGpCzEr; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=1K7rWjtv; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 6849D1F7C7;
	Sat, 20 Sep 2025 06:33:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1758350015; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ARoLZetUoV/xoy3KPCCrxgqpJg/9aMXXpwF6+HXIJXc=;
	b=tfGpCzEr92hc15Fv312tFVzyk2eCFsIW2PTwZ4J23rIFj2jDPo8IJr18AwfUDPQteOHDTH
	iH6NBud80/TSFD/DC9Mv8YyNwZVwB6sQSBrULhUkpBbkfZkwQU1jlQYLZh1EhpID4wKPLj
	ABRLkbUO0YrRJM8NlprsHivd9xhrOQ0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1758350015;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ARoLZetUoV/xoy3KPCCrxgqpJg/9aMXXpwF6+HXIJXc=;
	b=1K7rWjtvRR98Dh5/Q8UuO0dS3B33cK7APPZhEPtRbLMfwHlHnm1sNrdfwWr3DRi7YXAVaB
	32bk8kEzMCPbvRCg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=tfGpCzEr;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=1K7rWjtv
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1758350015; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ARoLZetUoV/xoy3KPCCrxgqpJg/9aMXXpwF6+HXIJXc=;
	b=tfGpCzEr92hc15Fv312tFVzyk2eCFsIW2PTwZ4J23rIFj2jDPo8IJr18AwfUDPQteOHDTH
	iH6NBud80/TSFD/DC9Mv8YyNwZVwB6sQSBrULhUkpBbkfZkwQU1jlQYLZh1EhpID4wKPLj
	ABRLkbUO0YrRJM8NlprsHivd9xhrOQ0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1758350015;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ARoLZetUoV/xoy3KPCCrxgqpJg/9aMXXpwF6+HXIJXc=;
	b=1K7rWjtvRR98Dh5/Q8UuO0dS3B33cK7APPZhEPtRbLMfwHlHnm1sNrdfwWr3DRi7YXAVaB
	32bk8kEzMCPbvRCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 24A66137D2;
	Sat, 20 Sep 2025 06:33:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id sxc8B79Kzmj5LwAAD6G6ig
	(envelope-from <tiwai@suse.de>); Sat, 20 Sep 2025 06:33:35 +0000
Date: Sat, 20 Sep 2025 08:33:34 +0200
Message-ID: <871po18wg1.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Takashi Iwai <tiwai@suse.de>,
	linux-pm@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] PCI: Use PM runtime class macro for the auto cleanup
In-Reply-To: <CAJZ5v0jbr8WKp3+POEMy_mz2daWMGDPWHGMhWc-Ac=rcPAzDkg@mail.gmail.com>
References: <20250919163147.4743-1-tiwai@suse.de>
	<20250919163147.4743-3-tiwai@suse.de>
	<CAJZ5v0jbr8WKp3+POEMy_mz2daWMGDPWHGMhWc-Ac=rcPAzDkg@mail.gmail.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-3.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:dkim,suse.de:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	DKIM_TRACE(0.00)[suse.de:+]
X-Spam-Flag: NO
X-Spam-Level: 
X-Rspamd-Queue-Id: 6849D1F7C7
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.51

On Fri, 19 Sep 2025 20:39:04 +0200,
Rafael J. Wysocki wrote:
> 
> On Fri, Sep 19, 2025 at 6:32 PM Takashi Iwai <tiwai@suse.de> wrote:
> >
> > Use the newly introduced class macro to simplify the code.
> > Also, add the proper error handling for the PM runtime get errors,
> > too.
> >
> > Signed-off-by: Takashi Iwai <tiwai@suse.de>
> > ---
> >  drivers/pci/pci-sysfs.c | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
> > index 5eea14c1f7f5..08e5cf2ba73e 100644
> > --- a/drivers/pci/pci-sysfs.c
> > +++ b/drivers/pci/pci-sysfs.c
> > @@ -1475,8 +1475,9 @@ static ssize_t reset_method_store(struct device *dev,
> >                 return count;
> >         }
> >
> > -       pm_runtime_get_sync(dev);
> > -       struct device *pmdev __free(pm_runtime_put) = dev;
> > +       CLASS(pm_runtime_resume_and_get, pmdev)(dev);
> > +       if (IS_ERR(pmdev))
> > +               return -ENXIO;
> >
> >         if (sysfs_streq(buf, "default")) {
> >                 pci_init_reset_methods(pdev);
> > --
> 
> I've just realized that this patch won't work and the reason why is
> that __pm_runtime_resume() returns an error if runtime PM is disabled
> for a device, so pmdev above will be an error pointer in that case.

Good catch, this was completely forgotten...

> One possible approach may be to make pm_runtime_resume_and_get_dev()
> return 0 and bump up the usage counter for devices with runtime PM
> disabled.

Sounds reasonable.


thanks,

Takashi

