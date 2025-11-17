Return-Path: <linux-pci+bounces-41386-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 29715C63C42
	for <lists+linux-pci@lfdr.de>; Mon, 17 Nov 2025 12:20:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A8C02344BC3
	for <lists+linux-pci@lfdr.de>; Mon, 17 Nov 2025 11:13:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6EA032824A;
	Mon, 17 Nov 2025 11:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="QiSkSzYl";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="zrbr+06p";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="QiSkSzYl";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="zrbr+06p"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D271430CDB8
	for <linux-pci@vger.kernel.org>; Mon, 17 Nov 2025 11:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763377544; cv=none; b=M4+2hAxY9ox5pV6nb6oSUoDJogPbrvoz5PsA+f8902GfWhkIKmtMJya2t7EeGyp4ac8QJyu7C/rYaHEMmL956e8dUoAsxlDLfBxjZnXVNJn9AgYHyMIMwkuh/XxUQK0oE/rVmxN7saMSHEsdT8zIpBXtz5hBKFX3xvB2KYm+B5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763377544; c=relaxed/simple;
	bh=MyIG2cDSjZRjsRqa/zt8DNAhoChbdCt/PNwFr2FLH48=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ef9xH32q13atWGqzRG4U96OuTXo6euht0Bbdu0xJ2Y1KuD4EKE/HVkHtnwptVBx0DvFL+KQXw8pHlPDNc+p2a3R6imT2SZOuMi6FBBQk1i1w7OmOIU71xrGHm/z/ZieP4i7SdMdJh1kCbpIjluxENE+lBrbR9ksn2Daxez3IsTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=QiSkSzYl; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=zrbr+06p; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=QiSkSzYl; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=zrbr+06p; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 154772118C;
	Mon, 17 Nov 2025 11:05:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1763377541; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5OkKRwGM8TPoPqT1e9LmGWJtiaADIPsLhJ7pzzuke00=;
	b=QiSkSzYlOC9qY7JFOLC1hEgHUvNXyikVFEblc8ylh1xpnTFsSnb3xhHRHGG4qtt+DvwpTY
	qT5HErxHwKOXAa7KrH2X35ubAgB9ymR8h3sCUcpeK5TdhROJvye8ZfGrd/OQc/Q4n1a+vR
	9lihfpKefxapK/qiw2EmGigV3X65Py0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1763377541;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5OkKRwGM8TPoPqT1e9LmGWJtiaADIPsLhJ7pzzuke00=;
	b=zrbr+06pBnZ92gG/LcOLkrdjJG8amfzQKZP7RC8Nma/GFy/AHTw55FWtMQaX7TDo8ARRFb
	DGYmND/iBB/gWcAA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1763377541; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5OkKRwGM8TPoPqT1e9LmGWJtiaADIPsLhJ7pzzuke00=;
	b=QiSkSzYlOC9qY7JFOLC1hEgHUvNXyikVFEblc8ylh1xpnTFsSnb3xhHRHGG4qtt+DvwpTY
	qT5HErxHwKOXAa7KrH2X35ubAgB9ymR8h3sCUcpeK5TdhROJvye8ZfGrd/OQc/Q4n1a+vR
	9lihfpKefxapK/qiw2EmGigV3X65Py0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1763377541;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5OkKRwGM8TPoPqT1e9LmGWJtiaADIPsLhJ7pzzuke00=;
	b=zrbr+06pBnZ92gG/LcOLkrdjJG8amfzQKZP7RC8Nma/GFy/AHTw55FWtMQaX7TDo8ARRFb
	DGYmND/iBB/gWcAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B52BB3EA61;
	Mon, 17 Nov 2025 11:05:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 4+nsKoQBG2k/agAAD6G6ig
	(envelope-from <tiwai@suse.de>); Mon, 17 Nov 2025 11:05:40 +0000
Date: Mon, 17 Nov 2025 12:05:40 +0100
Message-ID: <877bvohqbf.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: =?ISO-8859-1?Q?P=E9ter?= Ujfalusi <peter.ujfalusi@linux.intel.com>
Cc: lgirdwood@gmail.com,
	broonie@kernel.org,
	linux-sound@vger.kernel.org,
	kai.vehmanen@linux.intel.com,
	ranjani.sridharan@linux.intel.com,
	yung-chuan.liao@linux.intel.com,
	pierre-louis.bossart@linux.dev,
	bhelgaas@google.com,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kw@linux.com
Subject: Re: [PATCH v2 0/7] ASoC/SOF/PCI/Intel: Support for Nova Lake S
In-Reply-To: <19a3db41-0d39-40eb-948f-3288fbe3cac8@linux.intel.com>
References: <20251104121650.21872-1-peter.ujfalusi@linux.intel.com>
	<19a3db41-0d39-40eb-948f-3288fbe3cac8@linux.intel.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/30.1 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-3.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	URIBL_BLOCKED(0.00)[suse.de:mid,imap1.dmz-prg2.suse.org:helo];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,vger.kernel.org,linux.intel.com,linux.dev,google.com,linux.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid]
X-Spam-Flag: NO
X-Spam-Score: -3.30
X-Spam-Level: 

On Mon, 17 Nov 2025 11:11:21 +0100,
Péter Ujfalusi wrote:
> 
> Hi Takashi,
> 
> On 04/11/2025 14:16, Peter Ujfalusi wrote:
> > Hi,
> > 
> > Changes since v1:
> > - Add information for the users of the PCI ID
> > - Add Acked-by tag for the pci_ids.h from Bjorn
> > - Add Acked-by tags from Mark for the ASoC patches
> > 
> > This series adds initial support for NVL-S from the Nova Lake family.
> > NVL-S includes ACE4 audio subsystem, it has 2 DSP cores.
> 
> Would you consider to pick up this series for 6.19?

I wasn't in Cc and it was ASoC subject prefix, so I overlooked this
series.  Now pull to for-next branch.


thanks,

Takashi

