Return-Path: <linux-pci+bounces-8731-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B6EA906F61
	for <lists+linux-pci@lfdr.de>; Thu, 13 Jun 2024 14:19:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B85381F21F98
	for <lists+linux-pci@lfdr.de>; Thu, 13 Jun 2024 12:19:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFCAD145B3C;
	Thu, 13 Jun 2024 12:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="UZKaN0Dy";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="xNI6Zz7O";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="UZKaN0Dy";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="xNI6Zz7O"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C7E7145B20
	for <linux-pci@vger.kernel.org>; Thu, 13 Jun 2024 12:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718281004; cv=none; b=SVAoH5JW0jmsgRnVbWI84yAyEXlFe8WX8zaSsaG+hRyl8HzWGzR5sOFHBpdNTesBrRWqtAb8zkfVSVnAysB5EyvIS2w8MwtAlmLso9EuThQR1FdV5ZJ9RFraONdsUYwywpRKRxaAxm37JaJE1YUzhsdFMMC4tNoFNmoQuWd+9Ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718281004; c=relaxed/simple;
	bh=chaH5PEQuEBXO945nkro375PKs5kAc/lgz+rLka12Rg=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=e/Rphx5gwQ5qRnFIHTs+nFZtx6t/Gcgdp1JIrOvpB+h7ICOJrOzLf9XYIBnH9Ca7TKVva5tTy7qINnORbu43aYv25et+lGqMc+Wz9QyMzOyTg3ON817E/tQVwdV0VHbgLYR7td1ZOGa9lyWNJFIvIgs8KdoMLbShaHCK4QuP+Og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=UZKaN0Dy; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=xNI6Zz7O; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=UZKaN0Dy; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=xNI6Zz7O; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 31366353CB;
	Thu, 13 Jun 2024 12:16:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1718281001; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zTH7af/O3+tTOb2Qwr9Ce/F6lFIljG3Q0wfAwcsVTeQ=;
	b=UZKaN0Dy3ckg3jb4dqXD1gsEGqSHzqQGpIyWvLHExU6DM+XXdOIJc92Xy4zT2RzPOlRGzb
	HJ1u2xh6eRdexKLLUtQIK+FLdZhJFzdk3Gbz5zvc0SXUY+XXlRJkUaG4WDi6jlkUsZPaDG
	Vx5R5elkoqwSGHTCsLVhvg4BLlHZ7N8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1718281001;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zTH7af/O3+tTOb2Qwr9Ce/F6lFIljG3Q0wfAwcsVTeQ=;
	b=xNI6Zz7OE46nCYt+AakUrak8jL1+ZIqNGmIMUaPiBRdhE4L78mI/yJBGmXvsCr8kalUg37
	iFx2BU1+xe8XTdBg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=UZKaN0Dy;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=xNI6Zz7O
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1718281001; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zTH7af/O3+tTOb2Qwr9Ce/F6lFIljG3Q0wfAwcsVTeQ=;
	b=UZKaN0Dy3ckg3jb4dqXD1gsEGqSHzqQGpIyWvLHExU6DM+XXdOIJc92Xy4zT2RzPOlRGzb
	HJ1u2xh6eRdexKLLUtQIK+FLdZhJFzdk3Gbz5zvc0SXUY+XXlRJkUaG4WDi6jlkUsZPaDG
	Vx5R5elkoqwSGHTCsLVhvg4BLlHZ7N8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1718281001;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zTH7af/O3+tTOb2Qwr9Ce/F6lFIljG3Q0wfAwcsVTeQ=;
	b=xNI6Zz7OE46nCYt+AakUrak8jL1+ZIqNGmIMUaPiBRdhE4L78mI/yJBGmXvsCr8kalUg37
	iFx2BU1+xe8XTdBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D83A813A7F;
	Thu, 13 Jun 2024 12:16:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id +wmGMyjjamaBJAAAD6G6ig
	(envelope-from <tiwai@suse.de>); Thu, 13 Jun 2024 12:16:40 +0000
Date: Thu, 13 Jun 2024 14:17:04 +0200
Message-ID: <87a5jpnikf.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
	alsa-devel@alsa-project.org,	broonie@kernel.org,	Bjorn Helgaas
 <bhelgaas@google.com>,	linux-pci@vger.kernel.org,	=?ISO-8859-1?Q?P=E9ter?=
 Ujfalusi <peter.ujfalusi@linux.intel.com>,	Ranjani Sridharan
 <ranjani.sridharan@linux.intel.com>,	Bard Liao
 <yung-chuan.liao@linux.intel.com>
Subject: Re: [PATCH 1/3] PCI: pci_ids: add INTEL_HDA_PTL
In-Reply-To: <20240612194834.GA1034127@bhelgaas>
References: <20240612064709.51141-2-pierre-louis.bossart@linux.intel.com>
	<20240612194834.GA1034127@bhelgaas>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-3.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim,intel.com:email];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 31366353CB
X-Spam-Flag: NO
X-Spam-Score: -3.51
X-Spam-Level: 

On Wed, 12 Jun 2024 21:48:34 +0200,
Bjorn Helgaas wrote:
> 
> On Wed, Jun 12, 2024 at 08:47:07AM +0200, Pierre-Louis Bossart wrote:
> > More PCI ids for Intel audio.
> > 
> > Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> > Reviewed-by: Péter Ujfalusi <peter.ujfalusi@linux.intel.com>
> > Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
> > Reviewed-by: Bard Liao <yung-chuan.liao@linux.intel.com>
> > Reviewed-by: Péter Ujfalusi <peter.ujfalusi@linux.intel.com>
> 
> Change subject to match history:
> 
>   PCI: Add INTEL_HDA_PTL to pci_ids.h
> 
> It's helpful mention the places where this will be used in the commit
> log because we only add things here when they're used in more than one
> place.
> 
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>

OK, I corrected the subject at applying.


thanks,

Takashi

