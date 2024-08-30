Return-Path: <linux-pci+bounces-12511-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A0759661C5
	for <lists+linux-pci@lfdr.de>; Fri, 30 Aug 2024 14:31:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C8409B2A5EB
	for <lists+linux-pci@lfdr.de>; Fri, 30 Aug 2024 12:30:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0B2A192D9C;
	Fri, 30 Aug 2024 12:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="zQx1YGez";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="XkSUFLdL";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="zQx1YGez";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="XkSUFLdL"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE32E192581
	for <linux-pci@vger.kernel.org>; Fri, 30 Aug 2024 12:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725021018; cv=none; b=iwvKn4EVm3nkMzhSGPI2DF6C3aF0vLkrqRUX29mW0c7AU4UJAZFsDn1JYqEGjfA10gidTMXUurWmqcI4e3SpLvz0TC7GydpZxGo3kOmRnyprGj2UjoEw+2yBYmSBNuENgyWzc87O1j5KyhQhmf+GPB2t/eK+8v/qC3gAR0IbgtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725021018; c=relaxed/simple;
	bh=TVcMzNRMegYsp4eglrjfjrklqy5cCwCiyO8uYAi/gkM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uT7+XM74de06BSbYKGd+uL/uvYsqpXuxRziYOMwtyYWyN6t84jjDk6owemacmNVacbc0UxEw3c9JUWHtQ0qhXESqskwKHwu+GdhJg67sbFbnOKpJpmuw//LRodmARRl5MCej6WJnhFueHZzJ/vBXQSPyzbI61kgW8q9B6qRLEKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=zQx1YGez; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=XkSUFLdL; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=zQx1YGez; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=XkSUFLdL; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id BDFAC21A37;
	Fri, 30 Aug 2024 12:30:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1725021014; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EuWAsH+Dtv6pQIUO5K6WAozw2zAgSePkfh0GGaXg+9k=;
	b=zQx1YGezjdCZoIVkD8uUKXlzyKYanJgmL3KRlUcahu6jHUygEaaTUGiXrZcBV9BkmBBWnS
	rL56KeyZR5QWT3N7Jz8Lu/bZoOMCHF2r4PMFTsSOXenyInAUPxrhWiSWqL2IlD6evL2QKg
	oDE8II+88x5WyZdxNjesAdopui+B9xE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1725021014;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EuWAsH+Dtv6pQIUO5K6WAozw2zAgSePkfh0GGaXg+9k=;
	b=XkSUFLdLBjJ5R4cY6zA4I3EOZrXhaDctretXIGm9e6l4RJhkniFQpdls7U8lXbdsTPhA6V
	Jyl+LhGLc/PKQgCA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=zQx1YGez;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=XkSUFLdL
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1725021014; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EuWAsH+Dtv6pQIUO5K6WAozw2zAgSePkfh0GGaXg+9k=;
	b=zQx1YGezjdCZoIVkD8uUKXlzyKYanJgmL3KRlUcahu6jHUygEaaTUGiXrZcBV9BkmBBWnS
	rL56KeyZR5QWT3N7Jz8Lu/bZoOMCHF2r4PMFTsSOXenyInAUPxrhWiSWqL2IlD6evL2QKg
	oDE8II+88x5WyZdxNjesAdopui+B9xE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1725021014;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EuWAsH+Dtv6pQIUO5K6WAozw2zAgSePkfh0GGaXg+9k=;
	b=XkSUFLdLBjJ5R4cY6zA4I3EOZrXhaDctretXIGm9e6l4RJhkniFQpdls7U8lXbdsTPhA6V
	Jyl+LhGLc/PKQgCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8637813A3D;
	Fri, 30 Aug 2024 12:30:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 5N2IH1a70WahQwAAD6G6ig
	(envelope-from <jroedel@suse.de>); Fri, 30 Aug 2024 12:30:14 +0000
Date: Fri, 30 Aug 2024 14:30:13 +0200
From: Joerg Roedel <jroedel@suse.de>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: linux-pci@vger.kernel.org, Lu Baolu <baolu.lu@linux.intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Kevin Tian <kevin.tian@intel.com>,
	kernel test robot <lkp@intel.com>, patches@lists.linux.dev
Subject: Re: [PATCH] PCI/ATS: Add missing pci_prepare_ats() stub
Message-ID: <ZtG7VXSsmDbt4a3I@suse.de>
References: <0-v1-3ff295fa1528+d7-pci_prepare_ats_proto_jgg@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0-v1-3ff295fa1528+d7-pci_prepare_ats_proto_jgg@nvidia.com>
X-Rspamd-Queue-Id: BDFAC21A37
X-Spam-Score: -6.51
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-6.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	DWL_DNSWL_MED(-2.00)[suse.de:dkim];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:url,suse.de:dkim,suse.de:mid,suse.de:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Wed, Aug 14, 2024 at 07:20:52PM -0300, Jason Gunthorpe wrote:
> Surprised 0-day didn't catch this before it made it to linux-next, but here it
> is..
> 
> Joerg if you can squash it that would be great.

Done, thanks. 

-- 
Jörg Rödel
jroedel@suse.de

SUSE Software Solutions Germany GmbH
Frankenstraße 146
90461 Nürnberg
Germany
https://www.suse.com/

Geschäftsführer: Ivo Totev, Andrew McDonald, Werner Knoblich
(HRB 36809, AG Nürnberg)

