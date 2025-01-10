Return-Path: <linux-pci+bounces-19621-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97C5FA08CBF
	for <lists+linux-pci@lfdr.de>; Fri, 10 Jan 2025 10:48:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE23A169472
	for <lists+linux-pci@lfdr.de>; Fri, 10 Jan 2025 09:48:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE94520B80C;
	Fri, 10 Jan 2025 09:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="vM8M40Zx";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="pUT0HKTf";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="FiTLtD9J";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="cR7s4WMM"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3B9B20D504;
	Fri, 10 Jan 2025 09:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736502358; cv=none; b=nvZPqgkfIwZOr39eYnoAPsXeK3SjyXBjY2857dc8hN908/CtpzbvhotRqJoqcQUmm7GalNFUjARtqb10XJUGcbWj+FZXDKJgzdih5yg6/6r8dexqfN62Jf/Swj3xNhWMRTDy/uwSaOR2xPY4rU0t3ISMoy8JN5a4DDgFpZhNZqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736502358; c=relaxed/simple;
	bh=Q2/3kmT/vyx6pmcI/hZczofTzEzaiq2O2rTHpBaYHAk=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tol6D0XYmxNL0yAGLJl+HZO00n9T3vXBscHc0gml9/UZJl7LfiWEtySOTK+9r+9x4JqmkKTixQGjA+ucbwvNFaomK0qyuLXelnmt4voXg7UWrLx9Fq6X3D6b1rr3FNaOfDCC9riGxHNzjGsxi7E8u0V/nIYr+3TXh+ifR6xgl3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=vM8M40Zx; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=pUT0HKTf; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=FiTLtD9J; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=cR7s4WMM; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E82DC1F394;
	Fri, 10 Jan 2025 09:45:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1736502355; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UjaBQWC2anXgz9BOymTHSSrozji+GZUUIHOTSaG9d8k=;
	b=vM8M40Zx16oCWRTzPnzEA9d3SIXaXAqP/nLt8Nqnru5k1XMO6PkOJOCcSepwUIXmb9zZW4
	dQUMRdIKw75OoF6xCrs/1B8cN/3eVWuokkFmBENG1abx5rywQdeH+U4lUpf9yqjAIhkhBB
	gOojkOpXLU/Cu9bihmsxz9iMSX4GB+c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1736502355;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UjaBQWC2anXgz9BOymTHSSrozji+GZUUIHOTSaG9d8k=;
	b=pUT0HKTfzR14Mma39HjR4num6MAo/mvL/41eypl6jlESZqrv1BPFhz4nLIyfVFNEp1SMZX
	hXa861+5qstnJCDg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=FiTLtD9J;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=cR7s4WMM
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1736502354; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UjaBQWC2anXgz9BOymTHSSrozji+GZUUIHOTSaG9d8k=;
	b=FiTLtD9Jdwxa+MxOY9sE5U7pp3IJP0wtFsl709yKPh7/mz3G8yJHquzw41BJWL+p+9g+RQ
	0GA3cRKopMvQrN2YCeFs9tYPxtkBScPf3H8i5sxB9tBRhRitSMZ4JLeebMrhsBCGbYsDYQ
	dQRcSiZIZIIS4c6tjhl5sUSXRBlqkow=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1736502354;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UjaBQWC2anXgz9BOymTHSSrozji+GZUUIHOTSaG9d8k=;
	b=cR7s4WMMAxglBulE7TbG/7BxQ00MUIem0byBECIFFLlQxVb7ERaAZ1ZEcOA8QWuTnoonE4
	Unh57STZTiaL2RBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AB2BE13A86;
	Fri, 10 Jan 2025 09:45:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id uL//J1LsgGenGAAAD6G6ig
	(envelope-from <tiwai@suse.de>); Fri, 10 Jan 2025 09:45:54 +0000
Date: Fri, 10 Jan 2025 10:45:54 +0100
Message-ID: <87ldvjuhm5.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>,	Takashi Iwai <tiwai@suse.de>,	Ilpo
 =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,	Kuppuswamy
 Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,	Keith Busch
 <keith.busch@intel.com>,	Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org,	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI/DPC: Yet another quirk for PIO log size on Intel Raptor Lake-P
In-Reply-To: <20250105082520.GT3713119@black.fi.intel.com>
References: <20250102164315.7562-1-tiwai@suse.de>
	<20250103225315.GA12322@bhelgaas>
	<20250105082520.GT3713119@black.fi.intel.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Rspamd-Queue-Id: E82DC1F394
X-Spam-Level: 
X-Spamd-Result: default: False [-3.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	ARC_NA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.51
X-Spam-Flag: NO

On Sun, 05 Jan 2025 09:25:20 +0100,
Mika Westerberg wrote:
> 
> Hi,
> 
> On Fri, Jan 03, 2025 at 04:53:15PM -0600, Bjorn Helgaas wrote:
> > On Thu, Jan 02, 2025 at 05:43:13PM +0100, Takashi Iwai wrote:
> > > There is yet another PCI entry for Intel Raptor Lake-P that shows the
> > >   error "DPC: RP PIO log size 0 is invalid":
> > >   0000:00:07.0 PCI bridge [0604]: Intel Corporation Raptor Lake-P Thunderbolt 4 PCI Express Root Port #0 [8086:a76e]
> > >   0000:00:07.2 PCI bridge [0604]: Intel Corporation Raptor Lake-P Thunderbolt 4 PCI Express Root Port #2 [8086:a72f]
> > > 
> > > Add the corresponding quirk entry for 8086:a72f.
> > > 
> > > Note that the one for 8086:a76e has been already added by the commit
> > > 627c6db20703 ("PCI/DPC: Quirk PIO log size for Intel Raptor Lake Root
> > > Ports").
> > 
> > Intel folks, what's the long-term resolution of this?  I'm kind of
> > tired of adding quirks like this.  So far we have these (not including
> > the current patch), dating back to Aug 2022:
> > 
> >   627c6db20703 ("PCI/DPC: Quirk PIO log size for Intel Raptor Lake Root Ports")
> >   3b8803494a06 ("PCI/DPC: Quirk PIO log size for Intel Ice Lake Root Ports")
> >   5459c0b70467 ("PCI/DPC: Quirk PIO log size for certain Intel Root Ports")
> > 
> > I *thought* this problem was caused by BIOS defects that were supposed
> > to be fixed, but nothing seems to be happening.
> 
> As far as I know it should be fixed already. I just checked my MTLP and PTL
> systems (both with integrated TBT PCIe root ports) and I don't see the
> message anymore. I don't have RPL system though. This is on reference
> hardware and BIOS so it is possible that the fix has not been taken into
> the OEM BIOS.

The reporter verified that the issue persists with the latest BIOS.
Sigh.


Takashi

