Return-Path: <linux-pci+bounces-8739-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 755C1907518
	for <lists+linux-pci@lfdr.de>; Thu, 13 Jun 2024 16:22:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 677861C20433
	for <lists+linux-pci@lfdr.de>; Thu, 13 Jun 2024 14:22:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 810FC142E73;
	Thu, 13 Jun 2024 14:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="J4+9ZXzd";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="EbPV+//L";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="J4+9ZXzd";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="EbPV+//L"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA2611DFFC
	for <linux-pci@vger.kernel.org>; Thu, 13 Jun 2024 14:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718288532; cv=none; b=jSfUzxqD+VPq/PiQ19mN5/FadvqDbiBuHbli6y2XGTQliS/vwrgf5EYKM/j8odfkzanPF9HgdgYh0qQAlXtHFe+zEUoCmAo6NWyQW/ysXlKEDIhwZZz7VnU8vqWehon2Epv0ucaq+A8CZRCqf9UGStfHBHd5PRVvdWiYDFgfs6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718288532; c=relaxed/simple;
	bh=sKuuZmyqqYeC6HEUHACWutcdl3zzlBnpPCFbb0N07vQ=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YYvdJZpPyiv3G3j1e8o106ZEdtYJYZPhBNTPoff50m61o21B3PyWK4txm8IunURfCiF4lwmxT/2NmjBWWfZlWKxDG5FEhser4awQaliLlXeGH93jR9WniG5m4UbjeqFellJcXFJqNoVQSCPq+hyfXb7KqJAEtwiytGo0gPRJ6vQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=J4+9ZXzd; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=EbPV+//L; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=J4+9ZXzd; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=EbPV+//L; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B04D237287;
	Thu, 13 Jun 2024 14:22:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1718288528; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3cBqruwSNJ1bqtPFj/6DT+8SGZYtXxl0Ds4dcQq2/Dw=;
	b=J4+9ZXzdwRtWghE0qwJnbZLOTy+brvzC3MxyHfxgCiBFg/jaHuxtgdIVDIbEokq49JqXLq
	X5hrAZwiPdQ+2ygWbOSK9BpAa+nTKwKp/803IbrY083i9EngUifNH9/iid9Bogx4DwTdCP
	2tdD94iAihp8U6wTTuquLBSJAh8QPuM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1718288528;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3cBqruwSNJ1bqtPFj/6DT+8SGZYtXxl0Ds4dcQq2/Dw=;
	b=EbPV+//LdfhaDgOboAM+4ElPS+H6zcmT/dMA2mc0MfSEz2Y0n58npYm0tFjaFS5JFXn13s
	WO+kgDDKAj+2YgCw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=J4+9ZXzd;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="EbPV+//L"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1718288528; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3cBqruwSNJ1bqtPFj/6DT+8SGZYtXxl0Ds4dcQq2/Dw=;
	b=J4+9ZXzdwRtWghE0qwJnbZLOTy+brvzC3MxyHfxgCiBFg/jaHuxtgdIVDIbEokq49JqXLq
	X5hrAZwiPdQ+2ygWbOSK9BpAa+nTKwKp/803IbrY083i9EngUifNH9/iid9Bogx4DwTdCP
	2tdD94iAihp8U6wTTuquLBSJAh8QPuM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1718288528;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3cBqruwSNJ1bqtPFj/6DT+8SGZYtXxl0Ds4dcQq2/Dw=;
	b=EbPV+//LdfhaDgOboAM+4ElPS+H6zcmT/dMA2mc0MfSEz2Y0n58npYm0tFjaFS5JFXn13s
	WO+kgDDKAj+2YgCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8675813A7F;
	Thu, 13 Jun 2024 14:22:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id YiCOH5AAa2b8TAAAD6G6ig
	(envelope-from <tiwai@suse.de>); Thu, 13 Jun 2024 14:22:08 +0000
Date: Thu, 13 Jun 2024 16:22:32 +0200
Message-ID: <871q50orbr.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: alsa-devel@alsa-project.org,
	broonie@kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH 0/3] ALSA/PCI: add PantherLake audio support
In-Reply-To: <d7d06d90-d714-4fe6-a191-57c641cff01c@linux.intel.com>
References: <20240612064709.51141-1-pierre-louis.bossart@linux.intel.com>
	<878qz9nih2.wl-tiwai@suse.de>
	<d7d06d90-d714-4fe6-a191-57c641cff01c@linux.intel.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Rspamd-Queue-Id: B04D237287
X-Spam-Score: -3.49
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-3.49 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.18)[-0.875];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org

On Thu, 13 Jun 2024 16:16:33 +0200,
Pierre-Louis Bossart wrote:
> 
> 
> 
> On 6/13/24 14:19, Takashi Iwai wrote:
> > On Wed, 12 Jun 2024 08:47:06 +0200,
> > Pierre-Louis Bossart wrote:
> >>
> >> Add the PCI ID for PantherLake.
> >>
> >> Since there's a follow-up patchset for ASoC, these 3 patches could be
> >> applied to the ASoC tree. Otherwise an immutable branch would be
> >> needed.
> >>
> >> Pierre-Louis Bossart (3):
> >>   PCI: pci_ids: add INTEL_HDA_PTL
> >>   ALSA: hda: hda-intel: add PantherLake support
> >>   ALSA: hda: intel-dsp-config: Add PTL support
> > 
> > Applied now to for-next branch.
> > 
> > There were duplicated Reviewed-by tags by Peter as checkpatch
> > complained, so I removed the one. 
> 
> Thanks Takashi, how do we proceed to get those changes into AsoC?
> 
> the first patch is a dependency for the patchset "[PATCH v2 0/5]
> ASoC/SOF/PCI/Intel: add PantherLake support"

ASoC tree needs to merge for-next branch from my sound.git tree.
Or vice versa, Mark sends a PR to sync the content.  (It should be
done more often, not only once per cycle, IMHO.)


thanks,

Takashi

