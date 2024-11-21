Return-Path: <linux-pci+bounces-17157-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E2DC09D4C76
	for <lists+linux-pci@lfdr.de>; Thu, 21 Nov 2024 13:01:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 87C4C1F21988
	for <lists+linux-pci@lfdr.de>; Thu, 21 Nov 2024 12:01:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8B601D2F64;
	Thu, 21 Nov 2024 12:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="AV9Tk90u";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="YGJwp7Gc";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="AV9Tk90u";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="YGJwp7Gc"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E19E1D151F;
	Thu, 21 Nov 2024 12:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732190494; cv=none; b=GdWLs59knyGsvqbsr+ZRdIQH2UcaIwCtgHkYfPxy29grCmS8t2VMR2N6H+A/uSJhovMYsHaJFKPqqphAKrOqs28UPPyC39vXK5nTjblLh+Ex8Um4gDesyZ2SX6boAI9UHA6x17m8QF+mt+CdzCx2ZhJGj/tqQQpNjk+Bx7eS8/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732190494; c=relaxed/simple;
	bh=PitWbxnrL3aZYw6vmt7mJkFGNEstgDny5hDwRsO5ikY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f49LzEA32dKeaH2Zfa34I1dCcykHWtIP8GQCEh2KXhjzkmLfnvinLs5nJcMrLJGq6gA5tHo5xEtfaBD/wQyiEDFlDgcuC1X5Qx8RriG7k67Si4rdQ/V1v4wYjyQC+oysIdgNPdyfS/W762kW8SxFh82h3F5usSkq7zntamwkW5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=AV9Tk90u; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=YGJwp7Gc; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=AV9Tk90u; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=YGJwp7Gc; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 4FC6221A14;
	Thu, 21 Nov 2024 12:01:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1732190491; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Cqudnxx7QhMg21RnzN/JlCktLvQ8S8xJx9uySb2H+7U=;
	b=AV9Tk90uD8l1aeZUmclFngo69O4Whbzmr9/wKwXQ4nwADzz9vnQuDngw9uGIfWvxPW0rKO
	J8sJf/npH+X4r/bxRZTL6tORY5/H/4awzzwtLSOrtef3BS6t0iIJD2RQ7SIPqKk01EvqbP
	vQv0yKR8qd0G9wUUph4bN8TuKl++oeo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1732190491;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Cqudnxx7QhMg21RnzN/JlCktLvQ8S8xJx9uySb2H+7U=;
	b=YGJwp7GctzpZ2oWi96BFxiNlt0kaiwV96iQmhlYHvuuLA6yCR8FkYjJdoJsZ6dFCFM3gbt
	kkHIQsD222ciIwCg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1732190491; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Cqudnxx7QhMg21RnzN/JlCktLvQ8S8xJx9uySb2H+7U=;
	b=AV9Tk90uD8l1aeZUmclFngo69O4Whbzmr9/wKwXQ4nwADzz9vnQuDngw9uGIfWvxPW0rKO
	J8sJf/npH+X4r/bxRZTL6tORY5/H/4awzzwtLSOrtef3BS6t0iIJD2RQ7SIPqKk01EvqbP
	vQv0yKR8qd0G9wUUph4bN8TuKl++oeo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1732190491;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Cqudnxx7QhMg21RnzN/JlCktLvQ8S8xJx9uySb2H+7U=;
	b=YGJwp7GctzpZ2oWi96BFxiNlt0kaiwV96iQmhlYHvuuLA6yCR8FkYjJdoJsZ6dFCFM3gbt
	kkHIQsD222ciIwCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 895F613927;
	Thu, 21 Nov 2024 12:01:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 0ow8HxohP2czDQAAD6G6ig
	(envelope-from <jdelvare@suse.de>); Thu, 21 Nov 2024 12:01:30 +0000
Date: Thu, 21 Nov 2024 13:01:27 +0100
From: Jean Delvare <jdelvare@suse.de>
To: Leon Romanovsky <leon@kernel.org>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Leon Romanovsky <leonro@nvidia.com>,
 Krzysztof =?UTF-8?B?V2lsY3p5xYRza2k=?= <kw@linux.com>,
 linux-pci@vger.kernel.org, Ariel Almog <ariela@nvidia.com>, Aditya Prabhune
 <aprabhune@nvidia.com>, Hannes Reinecke <hare@suse.de>, Heiner Kallweit
 <hkallweit1@gmail.com>, Arun Easi <aeasi@marvell.com>, Jonathan Chocron
 <jonnyc@amazon.com>, Bert Kenward <bkenward@solarflare.com>, Matt Carlson
 <mcarlson@broadcom.com>, Kai-Heng Feng <kai.heng.feng@canonical.com>, Alex
 Williamson <alex.williamson@redhat.com>, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>, Thomas
 =?UTF-8?B?V2Vpw59zY2h1aA==?= <linux@weissschuh.net>, Stephen Hemminger
 <stephen@networkplumber.org>
Subject: Re: [PATCH v2] PCI/sysfs: Change read permissions for VPD
 attributes
Message-ID: <20241121130127.5df61661@endymion.delvare>
In-Reply-To: <61a0fa74461c15edfae76222522fa445c28bec34.1731502431.git.leon@kernel.org>
References: <61a0fa74461c15edfae76222522fa445c28bec34.1731502431.git.leon@kernel.org>
Organization: SUSE Linux
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.34; x86_64-suse-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	HAS_ORG_HEADER(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[kernel.org,nvidia.com,linux.com,vger.kernel.org,suse.de,gmail.com,marvell.com,amazon.com,solarflare.com,broadcom.com,canonical.com,redhat.com,weissschuh.net,networkplumber.org];
	RCVD_TLS_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_DN_SOME(0.00)[]
X-Spam-Score: -4.30
X-Spam-Flag: NO

Hi Leon,

On Wed, 13 Nov 2024 14:59:58 +0200, Leon Romanovsky wrote:
> --- a/drivers/pci/vpd.c
> +++ b/drivers/pci/vpd.c
> @@ -332,6 +332,14 @@ static umode_t vpd_attr_is_visible(struct kobject *kobj,
>  	if (!pdev->vpd.cap)
>  		return 0;
>  
> +	/*
> +	 * Mellanox devices have implementation that allows VPD read by
> +	 * unprivileged users, so just add needed bits to allow read.
> +	 */
> +	WARN_ON_ONCE(a->attr.mode != 0600);
> +	if (unlikely(pdev->vendor == PCI_VENDOR_ID_MELLANOX))
> +		return a->attr.mode + 0044;

When manipulating bitfields, | is preferred. This would make the
operation safe regardless of the initial value, so you can even get rid
of the WARN_ON_ONCE() above.

> +
>  	return a->attr.mode;
>  }
>  

-- 
Jean Delvare
SUSE L3 Support

