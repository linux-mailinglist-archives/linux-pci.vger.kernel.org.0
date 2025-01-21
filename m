Return-Path: <linux-pci+bounces-20198-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B80BA180A0
	for <lists+linux-pci@lfdr.de>; Tue, 21 Jan 2025 16:01:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6288C3A347A
	for <lists+linux-pci@lfdr.de>; Tue, 21 Jan 2025 15:01:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 627D91F192F;
	Tue, 21 Jan 2025 15:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="WGbFTEh7";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="yALy81RY";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="rKpy+5Q1";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="l+FnA78Z"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0BD723A9;
	Tue, 21 Jan 2025 15:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737471713; cv=none; b=kDEOmvNzRWViI0v/TXAB9zJdZZQlX1Kzg/OcI5cHrQNwgEknbr4SC8UFWsINQZ02kMydDSmzPFt22QZCNOUbhsNF0z7lhaiXusz5unK9c8c3Fr39/ZWtUcOQc1UsZuVOk5mt2413envpRPz9LjQOVYqU1IiVXFmz4AKp8S90QkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737471713; c=relaxed/simple;
	bh=UJrdIdXdLZLXMGCD43TTSA5683JRqNTyKGyFa3qtGeQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N8hfomVDNbthhORS24Qm0KrLTRrPJj2A79eO6jFxpIBFi5hmnAm4cGzAJdYFrysL4J1WxGpaVYHesgQhd5XzDRMuWQnCZPmOFcYmfLslbCrds12600Ab2QIhjYsUF/7Dz3/uGG8zS9efZkjtSy1EhCbVdtPXnJaUz6JGSHZkzmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=WGbFTEh7; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=yALy81RY; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=rKpy+5Q1; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=l+FnA78Z; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D64002110A;
	Tue, 21 Jan 2025 15:01:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1737471709; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0byVvo++YtkFDQYObcsaLWp1UF3HNGpLniy8FFAvXks=;
	b=WGbFTEh7HiKf291KkdD89RuKF0YIN5rR0lsu8iBRJ272ACcwcJXcWtQsP7nD8wEIMSB35w
	YuwOIzCZlrTojfsRNp0dVML/F2pjiqgkUKFoAnrBU0vUtFYOXeR/BgTiwTzYhPH1jx+Acn
	tRyKGqWOl5exorxVQjLGUTAJVBkpelA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1737471709;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0byVvo++YtkFDQYObcsaLWp1UF3HNGpLniy8FFAvXks=;
	b=yALy81RYjlqCrOcNWfGjt0ZQvzyNo/rYxTCZOu34eHMI8hg1FSwqtgL/D09kki2ngz0qo9
	1Spxqe1KDSsKPZBg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1737471708; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0byVvo++YtkFDQYObcsaLWp1UF3HNGpLniy8FFAvXks=;
	b=rKpy+5Q1igPIgUJsVtTmoqe1O8W6ZCZJUrUxxZ1QXZQSziaGC+9zh1PgWu8YgE7vV2S8+u
	2FEhQN0UA6jxOhmJEPszPYWcnbFkFMcHeRSRP6XZLqlk0ehvSpd4mZZqTyn4GkLsZPpy01
	k38EpYKpDvqF8m907F+DtwmbPP3DTVk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1737471708;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0byVvo++YtkFDQYObcsaLWp1UF3HNGpLniy8FFAvXks=;
	b=l+FnA78Z09ynyPgCTsdHqj6HXy0cy4f93jF4vdegExSALru3ba+GvkWuXYmgxyL4UpKfez
	gZ5kF8jK1Umzo8CA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DA3441387C;
	Tue, 21 Jan 2025 15:01:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id iIHNMtu2j2cYKQAAD6G6ig
	(envelope-from <svarbanov@suse.de>); Tue, 21 Jan 2025 15:01:47 +0000
Message-ID: <f3f15261-9246-4822-b504-61ffa768b7a9@suse.de>
Date: Tue, 21 Jan 2025 17:01:43 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 00/10] Add PCIe support for bcm2712
To: Olivier Benjamin <olivier.benjamin@bootlin.com>,
 Stanimir Varbanov <svarbanov@suse.de>, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rpi-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Florian Fainelli <florian.fainelli@broadcom.com>,
 Jim Quinlan <jim2101024@gmail.com>,
 Nicolas Saenz Julienne <nsaenz@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>, kw@linux.com,
 Philipp Zabel <p.zabel@pengutronix.de>,
 Andrea della Porta <andrea.porta@suse.com>,
 Phil Elwell <phil@raspberrypi.com>, Jonathan Bell <jonathan@raspberrypi.com>
References: <20241025124515.14066-1-svarbanov@suse.de>
 <9b7161a7-2682-4824-8af0-39477b0938d8@bootlin.com>
Content-Language: en-US
From: Stanimir Varbanov <svarbanov@suse.de>
In-Reply-To: <9b7161a7-2682-4824-8af0-39477b0938d8@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Score: -2.80
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_TLS_ALL(0.00)[];
	TAGGED_RCPT(0.00)[dt];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[22];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[linutronix.de,kernel.org,broadcom.com,gmail.com,google.com,linux.com,pengutronix.de,suse.com,raspberrypi.com];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Level: 

Hi Olivier,

On 12/23/24 6:35 PM, Olivier Benjamin wrote:
> On 10/25/24 14:45, Stanimir Varbanov wrote:
>> Here is v4 of the series which aims to add support for PCIe on bcm2712
>> SoC
>> used by RPi5. Previous v3 can be found at [1].
>>
> Hello Stanimir,
> 
> Thank you for you work on this!
> 
>> v3 -> v4 changes include:
>>   - Addressed comments on the interrupt-controller driver (Thomas)
>>   - Moved "Reuse config structure" patch earlier in the series (Bjorn)
>>   - Merged "Avoid turn off of bridge reset" into "Add bcm2712
>> support" (Bjorn)
>>   - Fixed DTB warnings on broadcom/bcm2712-rpi-5-b.dtb
>>
>> For more detailed info check patches.
>>
> I would simply like to report that I have (rather succintly) tested this
> series.
> I have built a 6.13.0-rc4-v8 vanilla kernel and deployed it to a
> Raspberry Pi 5 equipped with a "Raspberry Pi SSD" NVMe Drive on an M.2
> Hat+ connected to the main board using PCIe.
> This of course did not work, and I could not see my drive.
> I then applied this series on top, rebuilt and deployed the kernel, and
> I could see the /dev/nvme0 device and mount the ext4 fs on the 1st
> partition.
> 
>> Comments are welcome!
>> ~Stan
>     
> If you find it helpful, feel free to collect my Tested-By tag.
> 
> I'll be happy to do the same for future versions of the series and can
> do some additional testing if you want an extra pair of eyes.
> 

Thanks for the help! I definitely will need Tested-by for the recently
posted v5 :)

~Stan


