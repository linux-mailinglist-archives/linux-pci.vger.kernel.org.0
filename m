Return-Path: <linux-pci+bounces-8732-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FB07906FA3
	for <lists+linux-pci@lfdr.de>; Thu, 13 Jun 2024 14:22:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB88A1F23027
	for <lists+linux-pci@lfdr.de>; Thu, 13 Jun 2024 12:22:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4289A14386B;
	Thu, 13 Jun 2024 12:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="wHnG6SEy";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="OoUYrf43";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="qFXKRSac";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="AfBiJI5M"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B23FF81ABF
	for <linux-pci@vger.kernel.org>; Thu, 13 Jun 2024 12:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718281125; cv=none; b=X8fpiwK6xairMgoVe1I7DEOtBo4leq1Sl6cLsig8Mwvcj6201JjkXJE+N8Z5DK2TFxeRzhfpHXI6RFTTxPSOnkPYhxqcEfnQaHzYFO5d+bRTToPaDlMyE7gA/fJ/TTgZjUaKTM8HB3i1Gw540NsEwVW+JJczFTLK8kfAxkIm90w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718281125; c=relaxed/simple;
	bh=0vHhhY/zVA/M2y+Bpp6L+TVzNi4/llugcqCiUaie5S0=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pCRNWdVMBY0LhK3ax8qqpV5ZSa6FFDVXyRk8g6732w926DESRurFFZvFKuxa2PWiiybLHURRjKSpPqbe28Wz5228JNTLPfl40W84+SaeRGztLZvfOB1pgGCo4DVX1NomevQ0WYzXiwk83Y+GwntRiP/jL3MIbDg0gNOnbjtKPgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=wHnG6SEy; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=OoUYrf43; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=qFXKRSac; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=AfBiJI5M; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id F2A785D310;
	Thu, 13 Jun 2024 12:18:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1718281122; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0zyDaPAJGmhXRks7wpCQ+3jCzRqQBdOOqpYhFbCloeU=;
	b=wHnG6SEy9p+Tt/9iIvLJ9EPqWcsQQMGEFX+UPPtF4GBv7gstElLCDg0/6/8Emk8Xm8j/4L
	yDWgBzpEsT5hw1WJK1nltbjbNUhDdEST3nDUMs7YKOiL92uCV1kTJVPj5aOZSDhJrkhhMg
	/yfGSt69kUcFifHYeJGSJvZl1hhe0ik=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1718281122;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0zyDaPAJGmhXRks7wpCQ+3jCzRqQBdOOqpYhFbCloeU=;
	b=OoUYrf43yHy17TMAr0MbNB8TbECbz+LwdcsZwu/XVnUqowNWXw+rr0/UljNaU/fixnB3xF
	4a3BUMHH07ei8jCQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1718281121; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0zyDaPAJGmhXRks7wpCQ+3jCzRqQBdOOqpYhFbCloeU=;
	b=qFXKRSacJJron3VuSdezq3edxMPAJaAwPV1gt4ITXR3xWZJwxcZZZnM77DV+TZ+avzG6UG
	Zb8JkbU//Vm4NgXZ5EIOlKnunbfgdCFA9ZCxBOPSwRIESzQu+k0xKizKc3jhVbyZG4iH1z
	XEBmPvS9toVUlUOtc+X9SLyYrOhDnso=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1718281121;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0zyDaPAJGmhXRks7wpCQ+3jCzRqQBdOOqpYhFbCloeU=;
	b=AfBiJI5Mpy8UZBWd44/vYJzonl1vKkAiixQBHSQYnGkTBYlQ9WDkawxBA2QfgxEMhgFn3d
	8lAWmO+64p+VvPDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C457D13A7F;
	Thu, 13 Jun 2024 12:18:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 4sBULqHjamYlJQAAD6G6ig
	(envelope-from <tiwai@suse.de>); Thu, 13 Jun 2024 12:18:41 +0000
Date: Thu, 13 Jun 2024 14:19:05 +0200
Message-ID: <878qz9nih2.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: alsa-devel@alsa-project.org,
	broonie@kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH 0/3] ALSA/PCI: add PantherLake audio support
In-Reply-To: <20240612064709.51141-1-pierre-louis.bossart@linux.intel.com>
References: <20240612064709.51141-1-pierre-louis.bossart@linux.intel.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spamd-Result: default: False [-3.30 / 50.00];
	BAYES_HAM(-3.00)[99.97%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Score: -3.30
X-Spam-Level: 

On Wed, 12 Jun 2024 08:47:06 +0200,
Pierre-Louis Bossart wrote:
> 
> Add the PCI ID for PantherLake.
> 
> Since there's a follow-up patchset for ASoC, these 3 patches could be
> applied to the ASoC tree. Otherwise an immutable branch would be
> needed.
> 
> Pierre-Louis Bossart (3):
>   PCI: pci_ids: add INTEL_HDA_PTL
>   ALSA: hda: hda-intel: add PantherLake support
>   ALSA: hda: intel-dsp-config: Add PTL support

Applied now to for-next branch.

There were duplicated Reviewed-by tags by Peter as checkpatch
complained, so I removed the one. 


thanks,

Takashi

