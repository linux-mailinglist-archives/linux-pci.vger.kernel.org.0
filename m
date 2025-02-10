Return-Path: <linux-pci+bounces-21097-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96551A2F4EC
	for <lists+linux-pci@lfdr.de>; Mon, 10 Feb 2025 18:14:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 42DAA1634B4
	for <lists+linux-pci@lfdr.de>; Mon, 10 Feb 2025 17:14:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1D0B22257B;
	Mon, 10 Feb 2025 17:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="dG214BhH";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="+A1v9IkE";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="DiIo31ja";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="j8b+8T/D"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 224631F4629;
	Mon, 10 Feb 2025 17:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739207661; cv=none; b=Dmx/ZZK4aGDDB0yWA9mz6C9JnBoue4MsDyo3ApppwPXp/YpQvlqA+bmzSVuJnlsVWDQRLvM0O1OgClqhogs0qlnYyMKb7iNCr5B4j9FTA3vD6e4siQtbLTSd2WKYoLqvoYP7TE9U/76v/HIwbgD8j3ArPmiA4ZgrNPZGweV38lA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739207661; c=relaxed/simple;
	bh=RHJ/mE+3CIXJ26NK0VzyZMCtDgPhWyECcVBdhzfFpV0=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Sksv3UqP9Ncu9x3gMoZcGU8JoA2gByRu8wHaw6egTDSUtw27lpHHuSU/jTEIK2UvYb1ykGuSELPH+Ugljt4GFbBbphhJ5fu3N/oSbm4eBz9bFV+kVaCLpxilJTYuTclmKo5K9EaZWBx7/xZM4CmD801wwAOOvT1+z/NcXz2nVLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=dG214BhH; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=+A1v9IkE; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=DiIo31ja; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=j8b+8T/D; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 411AD21102;
	Mon, 10 Feb 2025 17:14:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1739207658; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QWAbgjUI+Y3HKFjPsXNiudAooyxa5r8YZAL/8whS31w=;
	b=dG214BhHjqYrZNqlpEJitq6mZ0FbiUG1E2WZBo4c/11Yd9Yqj8n9uHiXU3AXkNq7l/Hsh/
	fZhSixfj2NENCLPHd9mxnAgd3x7UGhAM+IujS4/OTBVRGILxmqjEfvm0Vlf0sRjXMz7sxI
	abZ5FBvtx3v7JQCfBgMxDjuiSlT4Is8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1739207658;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QWAbgjUI+Y3HKFjPsXNiudAooyxa5r8YZAL/8whS31w=;
	b=+A1v9IkE6gGbBBWlODNSRDVmgP3AkkUX/JN0Zis8TiM4JJ4N0QjunRQ1WXWol+uuw8Vz47
	ILCWqtW4OhYvZeCQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1739207657; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QWAbgjUI+Y3HKFjPsXNiudAooyxa5r8YZAL/8whS31w=;
	b=DiIo31jaS/R22hbO5uIJU867Brjuq3xMin3kG0Nvk8x/gJ2wJNpB0/EsQ5GTVSpA0pfR3L
	sw1He/mxyXWFOLhi2MwNQG+MDwaMQX7jNgvdfp4/0ZC9y3CAJMqC0r17hM6duq/oDnYNw0
	+lYObECkDV9jVlMkObJJWKqJtgd8TQY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1739207657;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QWAbgjUI+Y3HKFjPsXNiudAooyxa5r8YZAL/8whS31w=;
	b=j8b+8T/DQTCLs+xajPrzUypzMEY/Z5yrZVKVdqvWzhGTQXzzEqtdKm8nS9MCQ19ocJzb1q
	OO+6CTpnJ+MeLVCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E126013707;
	Mon, 10 Feb 2025 17:14:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id R53DNegzqmcTXAAAD6G6ig
	(envelope-from <tiwai@suse.de>); Mon, 10 Feb 2025 17:14:16 +0000
Date: Mon, 10 Feb 2025 18:14:16 +0100
Message-ID: <8734glafiv.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Cc: lgirdwood@gmail.com,
	broonie@kernel.org,
	tiwai@suse.com,
	linux-sound@vger.kernel.org,
	kai.vehmanen@linux.intel.com,
	ranjani.sridharan@linux.intel.com,
	yung-chuan.liao@linux.intel.com,
	pierre-louis.bossart@linux.dev,
	bhelgaas@google.com,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/4] ASoC/SOF/PCI/Intel: add PantherLake H support
In-Reply-To: <20250210081730.22916-1-peter.ujfalusi@linux.intel.com>
References: <20250210081730.22916-1-peter.ujfalusi@linux.intel.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spam-Score: -3.30
X-Spamd-Result: default: False [-3.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	ARC_NA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RCPT_COUNT_TWELVE(0.00)[12];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,suse.com,vger.kernel.org,linux.intel.com,linux.dev,google.com];
	RCVD_TLS_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Level: 

On Mon, 10 Feb 2025 09:17:26 +0100,
Peter Ujfalusi wrote:
> 
> Hi,
> 
> Changes since v1:
> - Updated the commit messages
> - added the Acked-by from Bjorn and Mark
> 
> The audio IP in PTL-H is identical to the already supported PTL but the
> PCI-ID has been changes due to the differences in the product's
> configuration outside of audio.
> 
> To support PTL-H we really just need to wire up the new ID.
> 
> Regards,
> Peter
> --- 
> Peter Ujfalusi (1):
>   ASoC: SOF: Intel: pci-ptl: Add support for PTL-H
> 
> Pierre-Louis Bossart (3):
>   PCI: pci_ids: add INTEL_HDA_PTL_H
>   ALSA: hda: intel-dsp-config: Add PTL-H support
>   ALSA: hda: hda-intel: add Panther Lake-H support

As all those are trivial ID-addition changes, I picked up now to
for-linus branch.


thanks,

Takashi

