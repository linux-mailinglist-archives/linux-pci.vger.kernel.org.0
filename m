Return-Path: <linux-pci+bounces-20438-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BC698A204F6
	for <lists+linux-pci@lfdr.de>; Tue, 28 Jan 2025 08:14:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C05D1885248
	for <lists+linux-pci@lfdr.de>; Tue, 28 Jan 2025 07:14:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12BDF19E7F8;
	Tue, 28 Jan 2025 07:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="yANUzMCg";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="mQrr8xs6";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="SaLkm0Nh";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="oBHzloX2"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B460192D84;
	Tue, 28 Jan 2025 07:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738048482; cv=none; b=PWNKHmJAgEdMyEbhqM0Pg83MThDTA3tSXZYeKfxpv9nP5v8BxLotFYtLQL5RsD0+OwCXV3XqRjVf+4pjcGd30cGQcXaEg4A2BRxmIuQ83vG3AXjwU9LTMfBF8mUk9FL6Yi1TNatgg3RnaFo1dqtUAqU+r+d3Sgub3Y0Qa7KLSCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738048482; c=relaxed/simple;
	bh=2mvmtby32CKnmitGypdPxYlCpiqjCrhpuNJs0zCcJ8w=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cd4aGkfAUuAvj56bwsUR6ESoglEXfrkq7Z/HtUbIzWOlzYe5JgbhZSwZV3q3lumua/aNRNJObCOhZ9xHVcQDPCAeroFggwT8CRbd+H2cqdPSNlPhvhucL6XZzku6uo0i/k07VephIh38ubKzkdHeuBDzHvD4HilKXX8MMSGjkKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=yANUzMCg; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=mQrr8xs6; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=SaLkm0Nh; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=oBHzloX2; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D41801F381;
	Tue, 28 Jan 2025 07:14:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1738048478; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VaZJDEn8aj8XF5Pepe9yDS8lsofY1GxPy4oJW5aEGVM=;
	b=yANUzMCg1O1CNQJLFrnXVyQ8mNag3HSl8nS5bYaNFc7nua/4121iuv4onchDVCkl8Vhe8k
	zVpnQ3WMmTXFGoBxWmSz0nblXhSM4L6iJDdBc+b7LFpaP+fBSzyGduT8NQ6n2+xABZZnfQ
	irHkx5bPd7O6z6bcW8jTEbIormvMABs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1738048478;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VaZJDEn8aj8XF5Pepe9yDS8lsofY1GxPy4oJW5aEGVM=;
	b=mQrr8xs6K8G/PgPXuilYjffpjVnfdLqMRvGyE6w2Kq9ykBQpvsYnZ1my9sb741XRkoa+k6
	I+ubLmhmnSagRnDg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1738048477; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VaZJDEn8aj8XF5Pepe9yDS8lsofY1GxPy4oJW5aEGVM=;
	b=SaLkm0Nh/vCNAfQfjNGC7lJk5iUkBB25QK+nXcPaaBwYRnwPX4sAqMnA5yzdPz48+Sv8q9
	VFkGFP5aML/fehoGhl1X7auhMmlIROmpTzERfRUW8nPR3WshahDzsF24r/EMuuUOgyvxsq
	ghA2dRut8p96rHsqCh7u3UAg0HnW1p8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1738048477;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VaZJDEn8aj8XF5Pepe9yDS8lsofY1GxPy4oJW5aEGVM=;
	b=oBHzloX25yon7mUoI3tWC3olHSjbMkkvzI2nl20gECUg38WAnHjueuXHg/7iCxYPIQxvDQ
	RxFCrNZCeGLhCoDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A219513715;
	Tue, 28 Jan 2025 07:14:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Xf0CJt2DmGdiQgAAD6G6ig
	(envelope-from <tiwai@suse.de>); Tue, 28 Jan 2025 07:14:37 +0000
Date: Tue, 28 Jan 2025 08:14:37 +0100
Message-ID: <874j1jbeaq.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Takashi Iwai <tiwai@suse.de>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Philipp Stanner <pstanner@redhat.com>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] PCI: Restore the original INTX_DISABLE bit by pcim_intx()
In-Reply-To: <20250127185853.GA127679@bhelgaas>
References: <87ikq0b61y.wl-tiwai@suse.de>
	<20250127185853.GA127679@bhelgaas>
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
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid]
X-Spam-Score: -3.30
X-Spam-Flag: NO

On Mon, 27 Jan 2025 19:58:53 +0100,
Bjorn Helgaas wrote:
> 
> On Mon, Jan 27, 2025 at 05:00:25PM +0100, Takashi Iwai wrote:
> > On Mon, 09 Dec 2024 14:15:19 +0100,
> > Philipp Stanner wrote:
> > > 
> > > On Mon, 2024-11-04 at 10:14 +0100, Philipp Stanner wrote:
> > > > On Thu, 2024-10-31 at 14:42 +0100, Takashi Iwai wrote:
> > > > > pcim_intx() tries to restore the INTx bit at removal via devres,
> > > > > but
> > > > > there is a chance that it restores a wrong value.
> > > > > Because the value to be restored is blindly assumed to be the
> > > > > negative
> > > > > of the enable argument, when a driver calls pcim_intx()
> > > > > unnecessarily
> > > > > for the already enabled state, it'll restore to the disabled state
> > > > > in
> > > > > turn.  That is, the function assumes the case like:
> > > > > 
> > > > >   // INTx == 1
> > > > >   pcim_intx(pdev, 0); // old INTx value assumed to be 1 -> correct
> > > > > 
> > > > > but it might be like the following, too:
> > > > > 
> > > > >   // INTx == 0
> > > > >   pcim_intx(pdev, 0); // old INTx value assumed to be 1 -> wrong
> > > > > 
> > > > > Also, when a driver calls pcim_intx() multiple times with different
> > > > > enable argument values, the last one will win no matter what value
> > > > > it
> > > > > is.  This can lead to inconsistency, e.g.
> > > > > 
> > > > >   // INTx == 1
> > > > >   pcim_intx(pdev, 0); // OK
> > > > >   ...
> > > > >   pcim_intx(pdev, 1); // now old INTx wrongly assumed to be 0
> > > > > 
> > > > > This patch addresses those inconsistencies by saving the original
> > > > > INTx state at the first pcim_intx() call.  For that,
> > > > > get_or_create_intx_devres() is folded into pcim_intx() caller side;
> > > > > it allows us to simply check the already allocated devres and
> > > > > record
> > > > > the original INTx along with the devres_alloc() call.
> > > > > 
> > > > > Fixes: 25216afc9db5 ("PCI: Add managed pcim_intx()")
> > > > > Cc: stable@vger.kernel.org # 6.11+
> > > > > Link: https://lore.kernel.org/87v7xk2ps5.wl-tiwai@suse.de
> > > > > Signed-off-by: Takashi Iwai <tiwai@suse.de>
> > > > 
> > > > Reviewed-by: Philipp Stanner <pstanner@redhat.com>
> > > 
> > > Hello,
> > > 
> > > it seems we forgot about this patch.
> > > 
> > > Regards,
> > > P.
> > 
> > This has fallen through the cracks.
> > Do I need to resubmit?
> 
> Oops, sorry, I did miss this.  I added to pci/for-linus for v6.14.  It
> didn't apply quite cleanly, so take a look and make sure I resolved it
> correctly:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git/commit/?h=for-linus&id=d555ed45a5a10a813528c7685f432369d536ae3d

Looks good to me.  Thanks!


Takashi

