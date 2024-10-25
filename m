Return-Path: <linux-pci+bounces-15288-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E1839B0062
	for <lists+linux-pci@lfdr.de>; Fri, 25 Oct 2024 12:43:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E433C1F22290
	for <lists+linux-pci@lfdr.de>; Fri, 25 Oct 2024 10:43:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23F991DD0D5;
	Fri, 25 Oct 2024 10:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ord2PV3/";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="cWM69N+R";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ord2PV3/";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="cWM69N+R"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47E891D967F;
	Fri, 25 Oct 2024 10:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729853025; cv=none; b=Tlie2IQGgpQlQVzGCMWr7nfzBKKJElD779g357mlp+pijbJx/e7OAaRz5EQpVeRM5jkZezGo4vpeE3mWJdHWXBeIvagPu2TXzmytyCp/ZVlSpEwz1/Rp1Q9d+ZOBFmOqBpkQWBD6mCYM2CZwIsTsTyrNuJMZ10YO6g9qXXHs7i4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729853025; c=relaxed/simple;
	bh=t8OiLzTtPmB3/dLntUiVXzE1lHcUbXnKj7QKPy4zWjg=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UPxA8/x9J1+d6vCfqbKEruD7sDTwMg5Erv9FNMi1zGpp9Xn7LIqh/tgdP1+yYkVRr+hqp0jH4TfshgllyiObEyO0ECg6jA/hsjGb/b7ZfJxWSYjA6Wp/lThyEvq67nIysnCbo5hnLWvvQt9uKstKuOBnVtvDdkZthbD7DPlrhaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ord2PV3/; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=cWM69N+R; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ord2PV3/; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=cWM69N+R; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 5671D1F7E7;
	Fri, 25 Oct 2024 10:43:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1729853020; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Z5I7xlLfbDEDq1Riz277WVFwbgSRPUJNYEnNFETcTBo=;
	b=ord2PV3/E2svwDzSeLg88Vd92IEudvizRCWnRsmbE4gVtzyAc2jHw84crwOUiSl5aewcYj
	pY+HYQZxuuOI5Sd7d60R0XDilKKinJIzzDzUEXQS+MdNot/zGflXl4Cg/7ePKJxk1p/wL0
	lUyzxnALv4ghtFYfRnyoZhhshR+IQXs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1729853020;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Z5I7xlLfbDEDq1Riz277WVFwbgSRPUJNYEnNFETcTBo=;
	b=cWM69N+Rx7AaBNLCZKRos5CiQb4exmg4AkKbypjfdnSWqa654d1QY6xzRhif4KoOQFmb+l
	SJfuaVFmYzBRD2Ag==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1729853020; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Z5I7xlLfbDEDq1Riz277WVFwbgSRPUJNYEnNFETcTBo=;
	b=ord2PV3/E2svwDzSeLg88Vd92IEudvizRCWnRsmbE4gVtzyAc2jHw84crwOUiSl5aewcYj
	pY+HYQZxuuOI5Sd7d60R0XDilKKinJIzzDzUEXQS+MdNot/zGflXl4Cg/7ePKJxk1p/wL0
	lUyzxnALv4ghtFYfRnyoZhhshR+IQXs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1729853020;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Z5I7xlLfbDEDq1Riz277WVFwbgSRPUJNYEnNFETcTBo=;
	b=cWM69N+Rx7AaBNLCZKRos5CiQb4exmg4AkKbypjfdnSWqa654d1QY6xzRhif4KoOQFmb+l
	SJfuaVFmYzBRD2Ag==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 24624136F5;
	Fri, 25 Oct 2024 10:43:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id GymjB1x2G2cAEQAAD6G6ig
	(envelope-from <tiwai@suse.de>); Fri, 25 Oct 2024 10:43:40 +0000
Date: Fri, 25 Oct 2024 12:44:41 +0200
Message-ID: <87y12csbqe.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Philipp Stanner <pstanner@redhat.com>
Cc: Takashi Iwai <tiwai@suse.de>,
	Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: Restore the original INTX_DISABLE bit by pcim_intx()
In-Reply-To: <933083faa55109949cbb5a07dcec27f3e4bff9ec.camel@redhat.com>
References: <20241024155539.19416-1-tiwai@suse.de>
	<933083faa55109949cbb5a07dcec27f3e4bff9ec.camel@redhat.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Score: -3.30
X-Spamd-Result: default: False [-3.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email]
X-Spam-Flag: NO
X-Spam-Level: 

On Fri, 25 Oct 2024 11:26:18 +0200,
Philipp Stanner wrote:
> 
> Hi,
> 
> On Thu, 2024-10-24 at 17:55 +0200, Takashi Iwai wrote:
> > pcim_intx() tries to restore the INTX_DISABLE bit at removal via
> > devres, but there is a chance that it restores a wrong value.
> > Because the value to be restored is blindly assumed to be the
> > negative
> > of the enable argument, when a driver calls pcim_intx() unnecessarily
> > for the already enabled state, it'll restore to the disabled state in
> > turn.
> 
> It depends on how it is called, no?
> 
> // INTx == 1
> pcim_intx(pdev, 0); // old INTx value assumed to be 1 -> correct
> 
> ---
> 
> // INTx == 0
> pcim_intx(pdev, 0); // old INTx value assumed to be 1 -> wrong
> 
> Maybe it makes sense to replace part of the commit text with something
> like the example above?

If it helps better understanding, why not.

> >   Also, when a driver calls pcim_intx() multiple times with
> > different enable argument values, the last one will win no matter
> > what
> > value it is.
> 
> Means
> 
> // INTx == 0
> pcim_intx(pdev, 0); // orig_INTx == 1, INTx == 0
> pcim_intx(pdev, 1); // orig_INTx == 0, INTx == 1
> pcim_intx(pdev, 0); // orig_INTx == 1, INTx == 0
> 
> So in this example the first call would cause a wrong orig_INTx, but
> the last call – the one "who will win" – seems to do the right thing,
> dosen't it?

Yes and no.  The last call wins to write the current value, but
shouldn't win for setting the original value.  The original value must
be recorded only from the first call.

> > This patch addresses those inconsistencies by saving the original
> > INTX_DISABLE state at the first devres_alloc(); this assures that the
> > original state is restored properly, and the later pcim_intx() calls
> > won't overwrite res->orig_intx any longer.
> > 
> > Fixes: 25216afc9db5 ("PCI: Add managed pcim_intx()")
> 
> That commit is also in 6.11, so we need:
> 
> Cc: stable@vger.kernel.org # 6.11+

OK.

> > Link: https://lore.kernel.org/87v7xk2ps5.wl-tiwai@suse.de
> > Signed-off-by: Takashi Iwai <tiwai@suse.de>
> > ---
> >  drivers/pci/devres.c | 18 ++++++++++++++----
> >  1 file changed, 14 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/pci/devres.c b/drivers/pci/devres.c
> > index b133967faef8..aed3c9a355cb 100644
> > --- a/drivers/pci/devres.c
> > +++ b/drivers/pci/devres.c
> > @@ -438,8 +438,17 @@ static void pcim_intx_restore(struct device
> > *dev, void *data)
> >  	__pcim_intx(pdev, res->orig_intx);
> >  }
> >  
> > -static struct pcim_intx_devres *get_or_create_intx_devres(struct
> > device *dev)
> > +static void save_orig_intx(struct pci_dev *pdev, struct
> > pcim_intx_devres *res)
> >  {
> > +	u16 pci_command;
> > +
> > +	pci_read_config_word(pdev, PCI_COMMAND, &pci_command);
> > +	res->orig_intx = !(pci_command & PCI_COMMAND_INTX_DISABLE);
> > +}
> > +
> > +static struct pcim_intx_devres *get_or_create_intx_devres(struct
> > pci_dev *pdev)
> > +{
> > +	struct device *dev = &pdev->dev;
> >  	struct pcim_intx_devres *res;
> >  
> >  	res = devres_find(dev, pcim_intx_restore, NULL, NULL);
> > @@ -447,8 +456,10 @@ static struct pcim_intx_devres
> > *get_or_create_intx_devres(struct device *dev)
> >  		return res;
> >  
> >  	res = devres_alloc(pcim_intx_restore, sizeof(*res),
> > GFP_KERNEL);
> > -	if (res)
> > +	if (res) {
> > +		save_orig_intx(pdev, res);
> 
> This is not the correct place – get_or_create_intx_devres() should get
> the resource if it exists, or allocate it if it doesn't, but its
> purpose is not to modify the resource.

The behavior of the function makes the implementation a bit harder,
because the initialization of res->orig_intx should be done only once
at the very first call.

> >  		devres_add(dev, res);
> > +	}
> >  
> >  	return res;
> >  }
> > @@ -467,11 +478,10 @@ int pcim_intx(struct pci_dev *pdev, int enable)
> >  {
> >  	struct pcim_intx_devres *res;
> >  
> > -	res = get_or_create_intx_devres(&pdev->dev);
> > +	res = get_or_create_intx_devres(pdev);
> >  	if (!res)
> >  		return -ENOMEM;
> >  
> > -	res->orig_intx = !enable;
> 
> Here is the right place to call save_orig_intx(). That way you also
> won't need the new variable struct device *dev above :)

The problem is that, at this place, we don't know whether it's a
freshly created devres or it's an inherited one.  So, we'd need to
modify get_or_create_intx_devres() to indicate that it's a new
creation.  Or, maybe simpler would be rather to flatten
get_or_create_intx_devres() into pcim_intx().  It's a small function,
and it wouldn't be worsen the readability so much.

That is, something like below.


thanks,

Takashi

--- a/drivers/pci/devres.c
+++ b/drivers/pci/devres.c
@@ -438,21 +438,6 @@ static void pcim_intx_restore(struct device *dev, void *data)
 	__pcim_intx(pdev, res->orig_intx);
 }
 
-static struct pcim_intx_devres *get_or_create_intx_devres(struct device *dev)
-{
-	struct pcim_intx_devres *res;
-
-	res = devres_find(dev, pcim_intx_restore, NULL, NULL);
-	if (res)
-		return res;
-
-	res = devres_alloc(pcim_intx_restore, sizeof(*res), GFP_KERNEL);
-	if (res)
-		devres_add(dev, res);
-
-	return res;
-}
-
 /**
  * pcim_intx - managed pci_intx()
  * @pdev: the PCI device to operate on
@@ -466,12 +451,21 @@ static struct pcim_intx_devres *get_or_create_intx_devres(struct device *dev)
 int pcim_intx(struct pci_dev *pdev, int enable)
 {
 	struct pcim_intx_devres *res;
+	struct device *dev = &pdev->dev;
+	u16 pci_command;
 
-	res = get_or_create_intx_devres(&pdev->dev);
-	if (!res)
-		return -ENOMEM;
+	res = devres_find(dev, pcim_intx_restore, NULL, NULL);
+	if (!res) {
+		res = devres_alloc(pcim_intx_restore, sizeof(*res), GFP_KERNEL);
+		if (!res)
+			return -ENOMEM;
+
+		pci_read_config_word(pdev, PCI_COMMAND, &pci_command);
+		res->orig_intx = !(pci_command & PCI_COMMAND_INTX_DISABLE);
+
+		devres_add(dev, res);
+	}
 
-	res->orig_intx = !enable;
 	__pcim_intx(pdev, enable);
 
 	return 0;

