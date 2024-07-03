Return-Path: <linux-pci+bounces-9724-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E38F926083
	for <lists+linux-pci@lfdr.de>; Wed,  3 Jul 2024 14:38:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C1C8E1C216A8
	for <lists+linux-pci@lfdr.de>; Wed,  3 Jul 2024 12:38:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B74C316DEAC;
	Wed,  3 Jul 2024 12:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="eTst2Ck8";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="//RW5yhK";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="eTst2Ck8";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="//RW5yhK"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B0EC1428F8;
	Wed,  3 Jul 2024 12:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720010303; cv=none; b=KA5cqN67bq/55zCb1R0gImP5g5HiNiiqZkINa9KHOquRhERQWzIIghuK987OUoz563pwCjb4R9gFj2K10EWpUI6xR4T0SONao35yu2Vs3gMMze5BVY2pbSwF4aiZL1MnVq7rKtL7DdeD/NjP5kC07UDDdog1d6WBSe4J9h8TZP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720010303; c=relaxed/simple;
	bh=f+qR685pbhcyKQMkLuPoyqsahB0cvtIGZxL6oXcyKm4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Hw/Atd1Jk9f38Ny2e6W928f3ffrOTzZIN0u1W/qA/SGI/mP9tT3WUGcLeYJP92u6msZpZYUxxqZb9SKo5FcbQl777+Q9rSbu+G0RWjdkMcvLNawQB9Z+pwe3xqYdoSAFNYt+A/dGTUtgMeQmH8pK+cXaf3SCltAwU40gmH1NFtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=eTst2Ck8; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=//RW5yhK; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=eTst2Ck8; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=//RW5yhK; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 03410211A2;
	Wed,  3 Jul 2024 12:38:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1720010300; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ptMAAIn4sgaMZbUvdt3ovM6Pv3+HJopjDCBtTl8iZQI=;
	b=eTst2Ck8ScDdPo17eR9/IHq9IlNroSbvCJA24/R2DyFkeOLh0uZZ7C+5kpXwEKBEn7dAPF
	ngeYrNSzv8P9zxUUwOW7tF/vYdUS4fPT/PpweBeLIog6+c4qh/DvGHzHANyznHilJqpqtG
	oktSx+eVQw9J+qoNP+3GPjX0vJSHmek=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1720010300;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ptMAAIn4sgaMZbUvdt3ovM6Pv3+HJopjDCBtTl8iZQI=;
	b=//RW5yhKy1p6BN+ZG+2wgoMV/sui7BLVmX5S/kl7rE/80IGLAM2vRRw2ZuxAwIL8Wg17E/
	Y9S2xMUaVCl1caAw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=eTst2Ck8;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="//RW5yhK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1720010300; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ptMAAIn4sgaMZbUvdt3ovM6Pv3+HJopjDCBtTl8iZQI=;
	b=eTst2Ck8ScDdPo17eR9/IHq9IlNroSbvCJA24/R2DyFkeOLh0uZZ7C+5kpXwEKBEn7dAPF
	ngeYrNSzv8P9zxUUwOW7tF/vYdUS4fPT/PpweBeLIog6+c4qh/DvGHzHANyznHilJqpqtG
	oktSx+eVQw9J+qoNP+3GPjX0vJSHmek=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1720010300;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ptMAAIn4sgaMZbUvdt3ovM6Pv3+HJopjDCBtTl8iZQI=;
	b=//RW5yhKy1p6BN+ZG+2wgoMV/sui7BLVmX5S/kl7rE/80IGLAM2vRRw2ZuxAwIL8Wg17E/
	Y9S2xMUaVCl1caAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2BF4313889;
	Wed,  3 Jul 2024 12:38:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id TYdBCDtGhWZ0HAAAD6G6ig
	(envelope-from <svarbanov@suse.de>); Wed, 03 Jul 2024 12:38:19 +0000
Message-ID: <cc6cb49c-a76a-4d0d-94b5-c6213016d90d@suse.de>
Date: Wed, 3 Jul 2024 15:38:10 +0300
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 6/8] PCI: brcmstb: Don't conflate the reset rescal with
 phy ctrl
To: Jim Quinlan <james.quinlan@broadcom.com>,
 Stanimir Varbanov <svarbanov@suse.de>
Cc: linux-pci@vger.kernel.org, Nicolas Saenz Julienne <nsaenz@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Cyril Brulebois <kibi@debian.org>, bcm-kernel-feedback-list@broadcom.com,
 jim2101024@gmail.com, Florian Fainelli <florian.fainelli@broadcom.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 Rob Herring <robh@kernel.org>,
 "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE"
 <linux-rpi-kernel@lists.infradead.org>,
 "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>,
 open list <linux-kernel@vger.kernel.org>
References: <20240628205430.24775-1-james.quinlan@broadcom.com>
 <20240628205430.24775-7-james.quinlan@broadcom.com>
 <c4633d7a-11a4-4c1c-954b-45f631cb2563@suse.de>
 <CA+-6iNwmqq1YnmzeD0=kniPSmKLDwY_KZ322ZUM7GpTvE9Zv6Q@mail.gmail.com>
Content-Language: en-US
From: Stanimir Varbanov <svarbanov@suse.de>
In-Reply-To: <CA+-6iNwmqq1YnmzeD0=kniPSmKLDwY_KZ322ZUM7GpTvE9Zv6Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 03410211A2
X-Spam-Score: -4.50
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-4.50 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	MX_GOOD(-0.01)[];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,google.com,arm.com,debian.org,broadcom.com,gmail.com,linux.com,lists.infradead.org];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org



On 7/2/24 20:59, Jim Quinlan wrote:
> On Tue, Jul 2, 2024 at 9:10 AM Stanimir Varbanov <svarbanov@suse.de> wrote:
>>
>>
>>
>> On 6/28/24 23:54, Jim Quinlan wrote:
>>> We've been assuming that if an SOC has a "rescal" reset controller that we
>>> should automatically invoke brcm_phy_cntl(...).  This will not be true in
>>> future SOCs, so we create a bool "has_phy" and adjust the cfg_data
>>> appropriately (we need to give 7216 its own cfg_data structure instead of
>>> sharing one).
>>>
>>> Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>
>>> ---
>>>  drivers/pci/controller/pcie-brcmstb.c | 17 ++++++++++++++---
>>>  1 file changed, 14 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c

<cut>

>>>
>>> +static const struct pcie_cfg_data bcm7216_cfg = {
>>> +     .offsets        = pcie_offset_bcm7278,
>>> +     .type           = BCM7278,
>>
>> This "type" field is confusing, maybe it would be good to rename it to
>> "family"? For example BCM72XX family.
> 
> Hi Stanimir,
> 
> I'm open for another name but "family" would present problems with Broadcom STB.
> For example, we call 7216b0 a "family" as there are a number of
> derivative products based off

OK, sorry I'm not familiar with STB families. Then, it makes sense.

> of this general design.  Second, having something like "BCM72XX" won't work;
> we have 7211 which is something altogether different from the 7216.
> Note that we only
> introduce a new "type" when we need to; if the behavior is the same as
> a previously declared
> "type" we do not introduce new ones.
> 
> But if you wanted to change "type" to "model" then I have no problem with that.
> 

"model" sounds good to me. We might need to document this in kernel doc
style comment in struct pcie_cfg_data as a separate patch.

> Regards,
> Jim Quinlan

thanks
~Stan

