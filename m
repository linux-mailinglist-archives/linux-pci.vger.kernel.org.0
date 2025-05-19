Return-Path: <linux-pci+bounces-28011-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 30B06ABC88E
	for <lists+linux-pci@lfdr.de>; Mon, 19 May 2025 22:41:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C34B94A2EBF
	for <lists+linux-pci@lfdr.de>; Mon, 19 May 2025 20:41:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59E59217709;
	Mon, 19 May 2025 20:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="EnMdbyED";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="vqZZp9wJ";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="rG9Z7i+q";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="OdGXE+I1"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B548D2135D7
	for <linux-pci@vger.kernel.org>; Mon, 19 May 2025 20:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747687262; cv=none; b=KbKoPKtfdVK6lRw1KIcnsNbtLolHHrntKes64nW8f7vCMGF5q8Z47effibo86JAgvPV6j9J60sxMaJr+Q4smsRPJYhvw2GRJZXOmmqgYuPlFAHTnoUNEXnA3Z0rM1zWUgm+K5v/j3qJ+cVfUDwZ74LfQtWBrSjlFaKyhNY6RBoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747687262; c=relaxed/simple;
	bh=0cGSZuPlLsQ06kPzb5cAf+1buHk5lMRcLfepHFsSg3g=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sSmF1p/2JaUy2Avq6Ab6P55FjPDVY5tsjNlmG5RY0fXaal6GWVxxC13DS6YbeufSKnMO7n0b/s4V+NlCCC4WUg225XV27X1NXcYeeB7S1Keja3Jmy+Xrkx5V8QJZPCUBUk6QE3FKpD33ZyuCN7crYQWT/qmRVGvJynnWVVcKxBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=EnMdbyED; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=vqZZp9wJ; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=rG9Z7i+q; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=OdGXE+I1; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D430F222E9;
	Mon, 19 May 2025 20:40:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1747687259; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hMb9PBgoLwxRI3vqLA8OCLc76p2ye28dsa+DWT/q4BE=;
	b=EnMdbyED6DP4umvmULBjNf9I9EdNVYqWaWYA9ry94EZh7qO20U24l9Ga9WHTKiYppS9QQ1
	U1hi2OI82VGevDe7UQSVpkp2LfXqk8TyelYs+j1908j6h+J730pGgyM5YsFUfXXM+GBPu0
	tBg96mKEwTgCxFn120tnlKoxUunBMqo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1747687259;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hMb9PBgoLwxRI3vqLA8OCLc76p2ye28dsa+DWT/q4BE=;
	b=vqZZp9wJ2tktcNVCgoK4mlmwWxxPN/ZHP0v8P4dF3BbecZaK+2E/ZDVVLomPSZw9ZTPfLu
	LiMzwnhThxiLQbBw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1747687258; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hMb9PBgoLwxRI3vqLA8OCLc76p2ye28dsa+DWT/q4BE=;
	b=rG9Z7i+qvEgbQgiVmwFOSf68F7x5DtsoKea4GozJpxM5a5Pe6XZMnDzFLPcibC7gVZK2i3
	QzCPCwQa3dC703ThwOuxFD+uw1CyJ8YMxxs+al+FDs924MCvonsEYKSnJ9or6o75vT2obj
	31Ulp1OrPHq1W3I0eP/HkIAHDlaAKPI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1747687258;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hMb9PBgoLwxRI3vqLA8OCLc76p2ye28dsa+DWT/q4BE=;
	b=OdGXE+I1bL5e8x9uL4/CElrymmKGHKYRFWslIXUye9FfXPsszekLFvV89Y+hTFXImvXy6T
	f5q0R0wHes4LCrBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9E0B91372E;
	Mon, 19 May 2025 20:40:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id N+6iJVqXK2j1GgAAD6G6ig
	(envelope-from <tiwai@suse.de>); Mon, 19 May 2025 20:40:58 +0000
Date: Mon, 19 May 2025 22:40:58 +0200
Message-ID: <87cyc45o6d.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Cc: lgirdwood@gmail.com,
	broonie@kernel.org,
	linux-sound@vger.kernel.org,
	kai.vehmanen@linux.intel.com,
	ranjani.sridharan@linux.intel.com,
	yung-chuan.liao@linux.intel.com,
	pierre-louis.bossart@linux.dev,
	guennadi.liakhovetski@linux.intel.com,
	bhelgaas@google.com,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kw@linux.com
Subject: Re: [PATCH v2 0/5] ASoC/SOF/PCI/Intel: add Wildcat Lake support
In-Reply-To: <20250519080855.16977-1-peter.ujfalusi@linux.intel.com>
References: <20250519080855.16977-1-peter.ujfalusi@linux.intel.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spamd-Result: default: False [-3.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,vger.kernel.org,linux.intel.com,linux.dev,google.com,linux.com];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid]
X-Spam-Flag: NO
X-Spam-Score: -3.30
X-Spam-Level: 

On Mon, 19 May 2025 10:08:50 +0200,
Peter Ujfalusi wrote:
> 
> Hi,
> 
> Changes since v1:
> - The PCI ID patch commit subject and message updated
> - Reviewed-by, Acked-by tags added to patches
> 
> The audio IP in Wildcat Lake (WCL) is largely identical to the one in
> Panther Lake, the main difference is the number of DSP cores, memory
> and clocking.
> It is based on the same ACE3 architecture.
> 
> In SOF the PTL topologies can be re-used for WCL to reduce duplication
> of code and topology files. 
> 
> Regards,
> Peter
> ---
> 
> 
> Kai Vehmanen (1):
>   ALSA: hda: add HDMI codec ID for Intel WCL
> 
> Peter Ujfalusi (4):
>   PCI: Add Intel Wildcat Lake audio Device ID
>   ASoC: SOF: Intel: add initial support for WCL
>   ALSA: hda: intel-dsp-config: Add WCL support
>   ALSA: hda: hda-intel: add Wildcat Lake support

As Mark already gave his Ack, I merged all those now to sound git tree
for-next branch.


thanks,

Takashi

