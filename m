Return-Path: <linux-pci+bounces-20408-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E5E1A1DA10
	for <lists+linux-pci@lfdr.de>; Mon, 27 Jan 2025 17:00:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C53B3163117
	for <lists+linux-pci@lfdr.de>; Mon, 27 Jan 2025 16:00:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D8133B784;
	Mon, 27 Jan 2025 16:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="u5hItDtY";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="BawzRPd9";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="u5hItDtY";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="BawzRPd9"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 103481EB3E;
	Mon, 27 Jan 2025 16:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737993631; cv=none; b=Zfw1VWN65SFm3MxrvLgu+Io6GEo8qq6mt+p+T7EqLq1WoCvHqgJ0RT86fXzJrXrapOlkVZemkKSszRtnZPlkJzKiHsDxio5blfzXP0Geo6Fg6AcMsChuvpPMX5PihRl4C2g7OuZnFvJ8Os5PUXpJYR10LX077/LHh78cSrctZOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737993631; c=relaxed/simple;
	bh=JdaEwo4oGlPqJ1G89rmGH7Am2UPWhHt4jlzZz/FEqiw=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Hrq8Lui+5Vy+C/kMEyeMNjHqj4XtwDep+ruYtjBLBXKydSIrTU2uADczYOkCKyWUATB2nwsbb5h3qJhDMqAtfqFj7b8geAmZtvOEypx1+Z3J8zFcyCzHT8cGgsv4uYNU+y1g3Xln5VPI7IzC506kt9Qof7ZA7hfh0OAvkPZhOIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=u5hItDtY; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=BawzRPd9; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=u5hItDtY; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=BawzRPd9; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id CCAB21F383;
	Mon, 27 Jan 2025 16:00:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1737993625; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PP4sn92K5qvKbtrbPyxIfyOKFdcZnCQ8Jt78PyTcXQU=;
	b=u5hItDtYBA9ZuH5A1Z9SU1tn76VGXVxNHNy+UgK9JjC8pMwr1usqntXiGrEQXS42T3I/0F
	a9hJpbd+zKH59YTANfECl0dSjeihn9oablNCWPYJ1z2ytJSfsXwsQZHwuzIEF7AX/WERYI
	uSAi9GQwHs7EjEHFjASn786Y55217dg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1737993625;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PP4sn92K5qvKbtrbPyxIfyOKFdcZnCQ8Jt78PyTcXQU=;
	b=BawzRPd9k6d6RIa57JnTARKemY6Y8SzHF4cgAmInobXkRcZpMT+uFjJanO1cqxDJrsyan4
	fE41AfCactEGVLCg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1737993625; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PP4sn92K5qvKbtrbPyxIfyOKFdcZnCQ8Jt78PyTcXQU=;
	b=u5hItDtYBA9ZuH5A1Z9SU1tn76VGXVxNHNy+UgK9JjC8pMwr1usqntXiGrEQXS42T3I/0F
	a9hJpbd+zKH59YTANfECl0dSjeihn9oablNCWPYJ1z2ytJSfsXwsQZHwuzIEF7AX/WERYI
	uSAi9GQwHs7EjEHFjASn786Y55217dg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1737993625;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PP4sn92K5qvKbtrbPyxIfyOKFdcZnCQ8Jt78PyTcXQU=;
	b=BawzRPd9k6d6RIa57JnTARKemY6Y8SzHF4cgAmInobXkRcZpMT+uFjJanO1cqxDJrsyan4
	fE41AfCactEGVLCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9F230137C0;
	Mon, 27 Jan 2025 16:00:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 5FidJZmtl2e+KgAAD6G6ig
	(envelope-from <tiwai@suse.de>); Mon, 27 Jan 2025 16:00:25 +0000
Date: Mon, 27 Jan 2025 17:00:25 +0100
Message-ID: <87ikq0b61y.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Philipp Stanner <pstanner@redhat.com>,
    Takashi Iwai <tiwai@suse.de>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] PCI: Restore the original INTX_DISABLE bit by pcim_intx()
In-Reply-To: <5201b58b1b20f6af6104c4f9153545b7859bd22e.camel@redhat.com>
References: <20241031134300.10296-1-tiwai@suse.de>
	<61ef07331f843c25b19e5a6f68419e0a607a1b0b.camel@redhat.com>
	<5201b58b1b20f6af6104c4f9153545b7859bd22e.camel@redhat.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-3.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email,suse.de:mid]
X-Spam-Score: -3.30
X-Spam-Flag: NO

On Mon, 09 Dec 2024 14:15:19 +0100,
Philipp Stanner wrote:
> 
> On Mon, 2024-11-04 at 10:14 +0100, Philipp Stanner wrote:
> > On Thu, 2024-10-31 at 14:42 +0100, Takashi Iwai wrote:
> > > pcim_intx() tries to restore the INTx bit at removal via devres,
> > > but
> > > there is a chance that it restores a wrong value.
> > > Because the value to be restored is blindly assumed to be the
> > > negative
> > > of the enable argument, when a driver calls pcim_intx()
> > > unnecessarily
> > > for the already enabled state, it'll restore to the disabled state
> > > in
> > > turn.  That is, the function assumes the case like:
> > > 
> > >   // INTx == 1
> > >   pcim_intx(pdev, 0); // old INTx value assumed to be 1 -> correct
> > > 
> > > but it might be like the following, too:
> > > 
> > >   // INTx == 0
> > >   pcim_intx(pdev, 0); // old INTx value assumed to be 1 -> wrong
> > > 
> > > Also, when a driver calls pcim_intx() multiple times with different
> > > enable argument values, the last one will win no matter what value
> > > it
> > > is.  This can lead to inconsistency, e.g.
> > > 
> > >   // INTx == 1
> > >   pcim_intx(pdev, 0); // OK
> > >   ...
> > >   pcim_intx(pdev, 1); // now old INTx wrongly assumed to be 0
> > > 
> > > This patch addresses those inconsistencies by saving the original
> > > INTx state at the first pcim_intx() call.  For that,
> > > get_or_create_intx_devres() is folded into pcim_intx() caller side;
> > > it allows us to simply check the already allocated devres and
> > > record
> > > the original INTx along with the devres_alloc() call.
> > > 
> > > Fixes: 25216afc9db5 ("PCI: Add managed pcim_intx()")
> > > Cc: stable@vger.kernel.org # 6.11+
> > > Link: https://lore.kernel.org/87v7xk2ps5.wl-tiwai@suse.de
> > > Signed-off-by: Takashi Iwai <tiwai@suse.de>
> > 
> > Reviewed-by: Philipp Stanner <pstanner@redhat.com>
> 
> Hello,
> 
> it seems we forgot about this patch.
> 
> Regards,
> P.

This has fallen through the cracks.
Do I need to resubmit?


thanks,

Takashi


> 
> 
> > 
> > Nice!
> > 
> > > ---
> > > v1->v2: refactoring, fold get_or_create_intx_devres() into the
> > > caller
> > > instead of retrieving the original INTx there.
> > > Also add comments and improve the patch description.
> > > 
> > >  drivers/pci/devres.c | 34 +++++++++++++++++++---------------
> > >  1 file changed, 19 insertions(+), 15 deletions(-)
> > > 
> > > diff --git a/drivers/pci/devres.c b/drivers/pci/devres.c
> > > index b133967faef8..c93d4d4499a0 100644
> > > --- a/drivers/pci/devres.c
> > > +++ b/drivers/pci/devres.c
> > > @@ -438,19 +438,12 @@ static void pcim_intx_restore(struct device
> > > *dev, void *data)
> > >  	__pcim_intx(pdev, res->orig_intx);
> > >  }
> > >  
> > > -static struct pcim_intx_devres *get_or_create_intx_devres(struct
> > > device *dev)
> > > +static void save_orig_intx(struct pci_dev *pdev, struct
> > > pcim_intx_devres *res)
> > >  {
> > > -	struct pcim_intx_devres *res;
> > > +	u16 pci_command;
> > >  
> > > -	res = devres_find(dev, pcim_intx_restore, NULL, NULL);
> > > -	if (res)
> > > -		return res;
> > > -
> > > -	res = devres_alloc(pcim_intx_restore, sizeof(*res),
> > > GFP_KERNEL);
> > > -	if (res)
> > > -		devres_add(dev, res);
> > > -
> > > -	return res;
> > > +	pci_read_config_word(pdev, PCI_COMMAND, &pci_command);
> > > +	res->orig_intx = !(pci_command &
> > > PCI_COMMAND_INTX_DISABLE);
> > >  }
> > >  
> > >  /**
> > > @@ -466,12 +459,23 @@ static struct pcim_intx_devres
> > > *get_or_create_intx_devres(struct device *dev)
> > >  int pcim_intx(struct pci_dev *pdev, int enable)
> > >  {
> > >  	struct pcim_intx_devres *res;
> > > +	struct device *dev = &pdev->dev;
> > >  
> > > -	res = get_or_create_intx_devres(&pdev->dev);
> > > -	if (!res)
> > > -		return -ENOMEM;
> > > +	/*
> > > +	 * pcim_intx() must only restore the INTx value that
> > > existed
> > > before the
> > > +	 * driver was loaded, i.e., before it called pcim_intx()
> > > for
> > > the
> > > +	 * first time.
> > > +	 */
> > > +	res = devres_find(dev, pcim_intx_restore, NULL, NULL);
> > > +	if (!res) {
> > > +		res = devres_alloc(pcim_intx_restore,
> > > sizeof(*res),
> > > GFP_KERNEL);
> > > +		if (!res)
> > > +			return -ENOMEM;
> > > +
> > > +		save_orig_intx(pdev, res);
> > > +		devres_add(dev, res);
> > > +	}
> > >  
> > > -	res->orig_intx = !enable;
> > >  	__pcim_intx(pdev, enable);
> > >  
> > >  	return 0;
> > 
> 

