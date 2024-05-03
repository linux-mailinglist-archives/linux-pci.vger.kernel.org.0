Return-Path: <linux-pci+bounces-7033-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DAC5F8BA730
	for <lists+linux-pci@lfdr.de>; Fri,  3 May 2024 08:45:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0545F1C2138D
	for <lists+linux-pci@lfdr.de>; Fri,  3 May 2024 06:45:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D77771386D7;
	Fri,  3 May 2024 06:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="xsozbu/q";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Zz4uX+SH";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="xsozbu/q";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Zz4uX+SH"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 398C1848D
	for <linux-pci@vger.kernel.org>; Fri,  3 May 2024 06:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714718717; cv=none; b=ZMRl3c9u3eJ1BqrVOvWL9OOJAJrMR3aI7/+lp8EAfI2e9gXqVe4DeYUIj7AdRYqlJbotTCRsNIOGRQm+JNy4+4VCLtB/eMxQET+Df0hdKxMa+bTpVSF4lJUrt0Is1py4hNUu6UQTBg5MksTpvL+1TV6ZOQS0EmvwdSHVMa3ISYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714718717; c=relaxed/simple;
	bh=+Z2+Ndj6NOC2+oNrYmH6HBdy9WKt5eQ23XdSjKEsoVE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pr7tT9Dy7nY+dmmwalBpqQrFlO5PeWe/q9cvdh436qzMmBMHRJUBfUKuPPL5bAv3RPYzw2bR6SVAK1WzBdPoM3V0scVOm+XrbiHIlNse43RSAMWWI56Zev/slGemZIKG062Wa76D6W8iDVWReJDye3QoKMZgn/LuhJTJ2KMpCFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=xsozbu/q; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Zz4uX+SH; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=xsozbu/q; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Zz4uX+SH; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 73D7E1FB61;
	Fri,  3 May 2024 06:45:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1714718714; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MhJMfCx/td6RfNHPGO1WOzPJ7RqP6GNGOZH5/kHRT+Q=;
	b=xsozbu/qdAxlMkWariP1DyRcakDJBzVb7t3gsSsuWdxL3jFbyFMhsg9dj/r1oA4F++6MpY
	j8hauzWb/TiZ85oiBzWWVQD1cpWr6brHCVBP6dVyDB3g73ln/nM7BnMIn5pPJc3YKUTGAa
	NKy++/8NstbmDyP5UdIYBhh20bhMUgY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1714718714;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MhJMfCx/td6RfNHPGO1WOzPJ7RqP6GNGOZH5/kHRT+Q=;
	b=Zz4uX+SHv8ga+isb8RKdCfTBhzi6tgY2yC8HIB/o6h9di+dggubUw0wHnc5EpuwTHbUF1O
	Z6YxJnE1oU5hP3DQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1714718714; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MhJMfCx/td6RfNHPGO1WOzPJ7RqP6GNGOZH5/kHRT+Q=;
	b=xsozbu/qdAxlMkWariP1DyRcakDJBzVb7t3gsSsuWdxL3jFbyFMhsg9dj/r1oA4F++6MpY
	j8hauzWb/TiZ85oiBzWWVQD1cpWr6brHCVBP6dVyDB3g73ln/nM7BnMIn5pPJc3YKUTGAa
	NKy++/8NstbmDyP5UdIYBhh20bhMUgY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1714718714;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MhJMfCx/td6RfNHPGO1WOzPJ7RqP6GNGOZH5/kHRT+Q=;
	b=Zz4uX+SHv8ga+isb8RKdCfTBhzi6tgY2yC8HIB/o6h9di+dggubUw0wHnc5EpuwTHbUF1O
	Z6YxJnE1oU5hP3DQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4EAD313991;
	Fri,  3 May 2024 06:45:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id wd6TEfqHNGY4eQAAD6G6ig
	(envelope-from <hare@suse.de>); Fri, 03 May 2024 06:45:14 +0000
Message-ID: <377ccedd-16e1-442d-9c1b-7ec18cf21fb5@suse.de>
Date: Fri, 3 May 2024 08:45:13 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] Revert "PCI/VPD: Allow access to valid parts of VPD
 if some is invalid"
Content-Language: en-US
To: Bjorn Helgaas <helgaas@kernel.org>,
 Josselin Mouette <josselin.mouette@exaion.com>
Cc: linux-pci@vger.kernel.org
References: <20240502222315.GA1551408@bhelgaas>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20240502222315.GA1551408@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -4.29
X-Spam-Level: 
X-Spamd-Result: default: False [-4.29 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]

On 5/3/24 00:23, Bjorn Helgaas wrote:
> On Thu, Mar 07, 2024 at 04:36:06PM -0600, Bjorn Helgaas wrote:
>> [+cc Hannes, who did a lot of related VPD work and reviewed the
>> original posting at
>> https://lore.kernel.org/r/20210715215959.2014576-6-helgaas@kernel.org/]
>>
>> On Thu, Mar 07, 2024 at 05:09:27PM +0100, Josselin Mouette wrote:
>>> When a device returns invalid VPD data, it can be misused by other
>>> code paths in kernel space or user space, and there are instances
>>> in which this seems to cause memory corruption.
>>
>> More of the background from Josselin at
>> https://lore.kernel.org/r/aaea0b30c35bb73b947727e4b3ec354d6b5c399c.camel@exaion.com
>>
>> This is a regression, and obviously needs to be fixed somehow, but I'm
>> a bit hesitant to revert this until we understand the problem better.
>> If there's a memory corruption lurking and a revert hides the
>> corruption so we never fix it, I'm not sure that's an improvement
>> overall.
> 
> I don't want to drop this, but we're kind of stuck here:
> 
>    - I'd still like to understand the problem better.
> 
>    - Trivially, I can't apply patches lacking the appropriate
>      signed-off-by; see https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst?id=v6.6#n396
> 
Right. Again.

So: Problem is that VPD data is a self-describing stream of serialized 
TLV records. The records themselves have no internal consistency check, 
so any data read is assumed to be correct. If there is an error during 
decoding we really should not continue, as everything beyond that error 
cannot be relied on.

However, the assumption was that the read data is correct, so in getting
an error the very assumption leading us to interpret the data as VPD 
records is invalid, too.

But question remains: was the data correct until the error?
Or was the error earlier, and we just mis-interpreted invalid data?

In my original patch I used the second attempt, as this will pretty
much guarantee that all VPD data will be correct. It has the drawback,
though, that for some cards we won't be able to read the VPD data, even
if they would provide valid data until the error.

As there is no good way out of this I'd rather see a blacklist of cards
which _can_ be read despite the error, and don't return VPD data otherwise.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich


