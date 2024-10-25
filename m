Return-Path: <linux-pci+bounces-15316-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DB8079B0631
	for <lists+linux-pci@lfdr.de>; Fri, 25 Oct 2024 16:51:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9AAD7283B1E
	for <lists+linux-pci@lfdr.de>; Fri, 25 Oct 2024 14:51:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24C981384B3;
	Fri, 25 Oct 2024 14:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="DgJq/EiI";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="7qF3C0DH";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="p2ept/an";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="RcOCTZ5I"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E59B2212198;
	Fri, 25 Oct 2024 14:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729867901; cv=none; b=FqIOc/noAvtVIeLnXWouqRYsRAOomjFTox5uy48RXEuGTEHm35Q7AVKzgwTdP0OCzZNeCtQSznw/vFNdxHTnknLP52OaB7UVIn18imi6Vm4zIPCbi1d+lus8gnlgczT7p1oc85+hQhdAFldxCOs4VXLf4+KkS4w2/kySH6VkeD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729867901; c=relaxed/simple;
	bh=JzQXJixmo0pWU+4DOmASce4WDJG5m+HYBpUMuDnxyJA=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j4z/y2RqbKlVmg8kRTpOiDAKw3PFuIzsyrEp/bigVw4NVpVVbXF0Gr9Q7/2hUqUx3swVd/K9tKnRVzlPQK8UV4KvoPUSt/rxyxTeJAuXzHA3GvPmS1VPwSxItREPGpo5YWoyuYO0JbyFtA+iAfEiHzin3J/3N6TQHlP9y2ba/18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=DgJq/EiI; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=7qF3C0DH; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=p2ept/an; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=RcOCTZ5I; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id EB7511F7F8;
	Fri, 25 Oct 2024 14:51:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1729867896; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sUFv99z+SBgkrrBnKamNrjnOE4wIrlieB9qgKNwHbD4=;
	b=DgJq/EiIZzukmfJ8ORrQIfEWu0YpGl2eyTw6v+ZYJ8jwzvpSA+lwMPFLQhPCXnc6kVTQfS
	9VrATpolgquLp1NSsUOabrwG9kZVKsnJcFKGHqVSgnPEHkCHkgimPTHSSt2iixVLELfV24
	m3VuoLx1bDEC6RWhyiqrsxM8XB82A4U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1729867896;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sUFv99z+SBgkrrBnKamNrjnOE4wIrlieB9qgKNwHbD4=;
	b=7qF3C0DHsy4URMPQvsFfJ9Tpa5zSpSkgsEQaZ6bVyGEdowHY2c9sVKKq90Gt4e3iZNVX7b
	k44eLrtFbZQmyfCg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="p2ept/an";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=RcOCTZ5I
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1729867895; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sUFv99z+SBgkrrBnKamNrjnOE4wIrlieB9qgKNwHbD4=;
	b=p2ept/angdVXAEIaWM/QB7chy+U1jSNsUCPUtogk1FokvnH+P9AziLgBg5x1WCAM1Tbodw
	C1CKeJUd/SUNy0Uv0tfyw4g3fxhgEnpuOW9IG4qUHwtP3yGFUxOd5Hwb1Mg+Ta4IYnT2oh
	flqxV0FlcgHKqMihprX4tmQJ74ilpEc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1729867895;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sUFv99z+SBgkrrBnKamNrjnOE4wIrlieB9qgKNwHbD4=;
	b=RcOCTZ5IOcbDCVH5esFFv+pEVGdGh8fygf0w51lwjf/cJDyH3H0tpd0q319ZBXnzQ6X4up
	BwMDuSjzAvO9fRAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C362A136F5;
	Fri, 25 Oct 2024 14:51:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id JmuDLnewG2c4YwAAD6G6ig
	(envelope-from <tiwai@suse.de>); Fri, 25 Oct 2024 14:51:35 +0000
Date: Fri, 25 Oct 2024 16:52:36 +0200
Message-ID: <87ldycs097.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Philipp Stanner <pstanner@redhat.com>
Cc: Takashi Iwai <tiwai@suse.de>,
	Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: Restore the original INTX_DISABLE bit by pcim_intx()
In-Reply-To: <5b2911489844f6a970da053ebfc126eddf7c896c.camel@redhat.com>
References: <20241024155539.19416-1-tiwai@suse.de>
	<933083faa55109949cbb5a07dcec27f3e4bff9ec.camel@redhat.com>
	<87y12csbqe.wl-tiwai@suse.de>
	<5b2911489844f6a970da053ebfc126eddf7c896c.camel@redhat.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: EB7511F7F8
X-Spam-Score: -3.51
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,suse.de:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Fri, 25 Oct 2024 16:28:42 +0200,
Philipp Stanner wrote:
> 
> On Fri, 2024-10-25 at 12:44 +0200, Takashi Iwai wrote:
> > On Fri, 25 Oct 2024 11:26:18 +0200,
> > Philipp Stanner wrote:
> > > 
> > > Hi,
> > > 
> > > On Thu, 2024-10-24 at 17:55 +0200, Takashi Iwai wrote:
> > > > pcim_intx() tries to restore the INTX_DISABLE bit at removal via
> > > > devres, but there is a chance that it restores a wrong value.
> > > > Because the value to be restored is blindly assumed to be the
> > > > negative
> > > > of the enable argument, when a driver calls pcim_intx()
> > > > unnecessarily
> > > > for the already enabled state, it'll restore to the disabled
> > > > state in
> > > > turn.
> > > 
> > > It depends on how it is called, no?
> > > 
> > > // INTx == 1
> > > pcim_intx(pdev, 0); // old INTx value assumed to be 1 -> correct
> > > 
> > > ---
> > > 
> > > // INTx == 0
> > > pcim_intx(pdev, 0); // old INTx value assumed to be 1 -> wrong
> > > 
> > > Maybe it makes sense to replace part of the commit text with
> > > something
> > > like the example above?
> > 
> > If it helps better understanding, why not.
> > 
> > > >   Also, when a driver calls pcim_intx() multiple times with
> > > > different enable argument values, the last one will win no matter
> > > > what
> > > > value it is.
> > > 
> > > Means
> > > 
> > > // INTx == 0
> > > pcim_intx(pdev, 0); // orig_INTx == 1, INTx == 0
> > > pcim_intx(pdev, 1); // orig_INTx == 0, INTx == 1
> > > pcim_intx(pdev, 0); // orig_INTx == 1, INTx == 0
> > > 
> > > So in this example the first call would cause a wrong orig_INTx,
> > > but
> > > the last call – the one "who will win" – seems to do the right
> > > thing,
> > > dosen't it?
> > 
> > Yes and no.  The last call wins to write the current value, but
> > shouldn't win for setting the original value.  The original value
> > must
> > be recorded only from the first call.
> 
> Alright, so you think that pcim_intx() should always restore the INTx
> state that existed before the driver was loaded.
> 
> > > > This patch addresses those inconsistencies by saving the original
> > > > INTX_DISABLE state at the first devres_alloc(); this assures that
> > > > the
> > > > original state is restored properly, and the later pcim_intx()
> > > > calls
> > > > won't overwrite res->orig_intx any longer.
> > > > 
> > > > Fixes: 25216afc9db5 ("PCI: Add managed pcim_intx()")
> > > 
> > > That commit is also in 6.11, so we need:
> > > 
> > > Cc: stable@vger.kernel.org # 6.11+
> > 
> > OK.
> > 
> > > > Link: https://lore.kernel.org/87v7xk2ps5.wl-tiwai@suse.de
> > > > Signed-off-by: Takashi Iwai <tiwai@suse.de>
> > > > ---
> > > >  drivers/pci/devres.c | 18 ++++++++++++++----
> > > >  1 file changed, 14 insertions(+), 4 deletions(-)
> > > > 
> > > > diff --git a/drivers/pci/devres.c b/drivers/pci/devres.c
> > > > index b133967faef8..aed3c9a355cb 100644
> > > > --- a/drivers/pci/devres.c
> > > > +++ b/drivers/pci/devres.c
> > > > @@ -438,8 +438,17 @@ static void pcim_intx_restore(struct device
> > > > *dev, void *data)
> > > >  	__pcim_intx(pdev, res->orig_intx);
> > > >  }
> > > >  
> > > > -static struct pcim_intx_devres *get_or_create_intx_devres(struct
> > > > device *dev)
> > > > +static void save_orig_intx(struct pci_dev *pdev, struct
> > > > pcim_intx_devres *res)
> > > >  {
> > > > +	u16 pci_command;
> > > > +
> > > > +	pci_read_config_word(pdev, PCI_COMMAND, &pci_command);
> > > > +	res->orig_intx = !(pci_command &
> > > > PCI_COMMAND_INTX_DISABLE);
> > > > +}
> > > > +
> > > > +static struct pcim_intx_devres *get_or_create_intx_devres(struct
> > > > pci_dev *pdev)
> > > > +{
> > > > +	struct device *dev = &pdev->dev;
> > > >  	struct pcim_intx_devres *res;
> > > >  
> > > >  	res = devres_find(dev, pcim_intx_restore, NULL, NULL);
> > > > @@ -447,8 +456,10 @@ static struct pcim_intx_devres
> > > > *get_or_create_intx_devres(struct device *dev)
> > > >  		return res;
> > > >  
> > > >  	res = devres_alloc(pcim_intx_restore, sizeof(*res),
> > > > GFP_KERNEL);
> > > > -	if (res)
> > > > +	if (res) {
> > > > +		save_orig_intx(pdev, res);
> > > 
> > > This is not the correct place – get_or_create_intx_devres() should
> > > get
> > > the resource if it exists, or allocate it if it doesn't, but its
> > > purpose is not to modify the resource.
> > 
> > The behavior of the function makes the implementation a bit harder,
> > because the initialization of res->orig_intx should be done only once
> > at the very first call.
> > 
> > > >  		devres_add(dev, res);
> > > > +	}
> > > >  
> > > >  	return res;
> > > >  }
> > > > @@ -467,11 +478,10 @@ int pcim_intx(struct pci_dev *pdev, int
> > > > enable)
> > > >  {
> > > >  	struct pcim_intx_devres *res;
> > > >  
> > > > -	res = get_or_create_intx_devres(&pdev->dev);
> > > > +	res = get_or_create_intx_devres(pdev);
> > > >  	if (!res)
> > > >  		return -ENOMEM;
> > > >  
> > > > -	res->orig_intx = !enable;
> > > 
> > > Here is the right place to call save_orig_intx(). That way you also
> > > won't need the new variable struct device *dev above :)
> > 
> > The problem is that, at this place, we don't know whether it's a
> > freshly created devres or it's an inherited one.  So, we'd need to
> > modify get_or_create_intx_devres() to indicate that it's a new
> > creation.  Or, maybe simpler would be rather to flatten
> > get_or_create_intx_devres() into pcim_intx().  It's a small function,
> > and it wouldn't be worsen the readability so much.
> 
> That might be the best solution. If it's done that way it should
> include a comment detailing the problem.
> 
> Looking at the implementation of pci_intx() before
> 25216afc9db53d85dc648aba8fb7f6d31f2c8731 probably indicates that you're
> right:
> 
> 	if (dr && !dr->restore_intx) {
> 		dr->restore_intx = 1;
> 		dr->orig_intx = !enable;
> 	}
> 
> 
> So they used a boolean to only take the first state. Although that
> still wouldn't have necessarily been the pre-driver INTx state.

IIRC, this code path is reached only after checking that the INTx
state is changed.  Hence "!enable" is assured to be the pre-driver
INTx state in the old code.


> > 
> > That is, something like below.
> > 
> > 
> > thanks,
> > 
> > Takashi
> > 
> > --- a/drivers/pci/devres.c
> > +++ b/drivers/pci/devres.c
> > @@ -438,21 +438,6 @@ static void pcim_intx_restore(struct device
> > *dev, void *data)
> >  	__pcim_intx(pdev, res->orig_intx);
> >  }
> >  
> > -static struct pcim_intx_devres *get_or_create_intx_devres(struct
> > device *dev)
> > -{
> > -	struct pcim_intx_devres *res;
> > -
> > -	res = devres_find(dev, pcim_intx_restore, NULL, NULL);
> > -	if (res)
> > -		return res;
> > -
> > -	res = devres_alloc(pcim_intx_restore, sizeof(*res),
> > GFP_KERNEL);
> > -	if (res)
> > -		devres_add(dev, res);
> > -
> > -	return res;
> > -}
> > -
> >  /**
> >   * pcim_intx - managed pci_intx()
> >   * @pdev: the PCI device to operate on
> > @@ -466,12 +451,21 @@ static struct pcim_intx_devres
> > *get_or_create_intx_devres(struct device *dev)
> >  int pcim_intx(struct pci_dev *pdev, int enable)
> >  {
> >  	struct pcim_intx_devres *res;
> > +	struct device *dev = &pdev->dev;
> > +	u16 pci_command;
> >  
> > -	res = get_or_create_intx_devres(&pdev->dev);
> > -	if (!res)
> > -		return -ENOMEM;
> > +	res = devres_find(dev, pcim_intx_restore, NULL, NULL);
> 
> sth like:
> 
> /*
>  * pcim_intx() must only restore the INTx value that existed before the
>  * driver was loaded, i.e., before it called pcim_intx() for the
>  * first time.
>  */

OK, will add it.

> > +	if (!res) {
> > +		res = devres_alloc(pcim_intx_restore, sizeof(*res),
> > GFP_KERNEL);
> > +		if (!res)
> > +			return -ENOMEM;
> > +
> > +		pci_read_config_word(pdev, PCI_COMMAND,
> > &pci_command);
> > +		res->orig_intx = !(pci_command &
> > PCI_COMMAND_INTX_DISABLE);
> > +
> > +		devres_add(dev, res);
> > +	}
> >  
> > -	res->orig_intx = !enable;
> >  	__pcim_intx(pdev, enable);
> 
> Looks like a good idea to me
> 
> The only thing I'm wondering about right now is the following: In the
> old days, there was only pci_intx(), which either did devres or didn't.
> 
> Now you have two functions, pcim_intx() and pci_intx().
> 
> The thing is that the driver could theoretically still intermingle them
> and for example call pci_intx() before pcim_intx(), which would lead
> the latter to still restore the wrong value.
> 
> But that's very unlikely and I'm not sure whether we can do something
> about it.

Right, pcim_intx() assures to restore INTx value back to the moment it
was called.  And that should be enough and consistent behavior.

BTW, a possible optimization would be to skip the devres if the value
isn't really changed from the current state (which is similar like the
old code before pcim_intx()).  OTOH, this can lead to inconsistencies
when INTx is changed manually after pcim_intx() somehow.  So maybe
it's not worth.


thanks,

Takashi

