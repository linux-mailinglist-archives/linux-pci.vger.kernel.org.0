Return-Path: <linux-pci+bounces-9820-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 03F9B927E3C
	for <lists+linux-pci@lfdr.de>; Thu,  4 Jul 2024 22:12:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6520D1F21DD8
	for <lists+linux-pci@lfdr.de>; Thu,  4 Jul 2024 20:12:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC7101E533;
	Thu,  4 Jul 2024 20:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="p0jEnROu";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="xntnrW+z";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="p0jEnROu";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="xntnrW+z"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30DF12F23;
	Thu,  4 Jul 2024 20:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720123925; cv=none; b=qa1HB6v1elCtl8LlMM2yOJUEWnh0lfIG2dTd8Dq9eOOs+Gvkp5R3ymYSm2cqhe9ULAG7a0A+1qfpV4aL465vQBB7fmLfGE1FqqI+QHmA2clsQlQDEokeqIOaxrxeWkUACnWzHMothdMHqwSxn3o9gQ9Ilt1sUhEMiIUkG5EWXBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720123925; c=relaxed/simple;
	bh=QKoMp6r/NggWhLsCXSjs5G35obDLVBLLQSngu8mj0Fc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nUsLDyLDPIOaFizDe7kWV+pUzQ5swcXNTRFhacbWy4LR4U8z2Kh+wFpD21EJlMobjkJUW3EQlPR6kwhbaGCzhzyGNIciQCwho1jFy0uaJs0JQZBHkEFHgKI/rucCpEVlfmteoKSc2ARjWJqlaw9pt5Pt4XrjOs4BOwuwhXbnhak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=p0jEnROu; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=xntnrW+z; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=p0jEnROu; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=xntnrW+z; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 528EF2122A;
	Thu,  4 Jul 2024 20:12:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1720123921; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=q0xbNEADlo/VTmNhYiX7C6UqOBxQAFv1iUFTviJbX8g=;
	b=p0jEnROu7r9nuu+S8CHJBYoCitB0oKTfcDYQ+cNaF0W4q16sUyXlE+9XmteucPIsT9oBLT
	NeqRtk8AS2FUW1ucTpvfgWDORvWmj8DRRFmAZfM52mMo7lB5iYBF8Z8bf5n1eKYkfD/KS4
	jZ0PieDjr6yRM9q7V/l+cfvBFMOLaWY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1720123921;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=q0xbNEADlo/VTmNhYiX7C6UqOBxQAFv1iUFTviJbX8g=;
	b=xntnrW+zxxt5ymncllo44PNkWC6pcGVRl2bt/SpCv33+HAc/F/j6BMcbQwqg7Xzls8BLIj
	vWj9+GZBFKJx4VBA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1720123921; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=q0xbNEADlo/VTmNhYiX7C6UqOBxQAFv1iUFTviJbX8g=;
	b=p0jEnROu7r9nuu+S8CHJBYoCitB0oKTfcDYQ+cNaF0W4q16sUyXlE+9XmteucPIsT9oBLT
	NeqRtk8AS2FUW1ucTpvfgWDORvWmj8DRRFmAZfM52mMo7lB5iYBF8Z8bf5n1eKYkfD/KS4
	jZ0PieDjr6yRM9q7V/l+cfvBFMOLaWY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1720123921;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=q0xbNEADlo/VTmNhYiX7C6UqOBxQAFv1iUFTviJbX8g=;
	b=xntnrW+zxxt5ymncllo44PNkWC6pcGVRl2bt/SpCv33+HAc/F/j6BMcbQwqg7Xzls8BLIj
	vWj9+GZBFKJx4VBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 40AE41369F;
	Thu,  4 Jul 2024 20:12:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id xVpCDRACh2bkCAAAD6G6ig
	(envelope-from <svarbanov@suse.de>); Thu, 04 Jul 2024 20:12:00 +0000
Message-ID: <bd097824-17a7-407f-ba92-6c4ef2c0029f@suse.de>
Date: Thu, 4 Jul 2024 23:11:55 +0300
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 09/12] PCI: brcmstb: Refactor for chips with many
 regular inbound BARs
To: Stanimir Varbanov <svarbanov@suse.de>,
 Jim Quinlan <james.quinlan@broadcom.com>, linux-pci@vger.kernel.org,
 Nicolas Saenz Julienne <nsaenz@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Cyril Brulebois <kibi@debian.org>, bcm-kernel-feedback-list@broadcom.com,
 jim2101024@gmail.com
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 Rob Herring <robh@kernel.org>,
 "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE"
 <linux-rpi-kernel@lists.infradead.org>,
 "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>,
 open list <linux-kernel@vger.kernel.org>
References: <20240703180300.42959-1-james.quinlan@broadcom.com>
 <20240703180300.42959-10-james.quinlan@broadcom.com>
 <8433a148-47d5-49a0-b7ed-75801060bce7@suse.de>
Content-Language: en-US
From: Stanimir Varbanov <svarbanov@suse.de>
In-Reply-To: <8433a148-47d5-49a0-b7ed-75801060bce7@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-4.29 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	FREEMAIL_TO(0.00)[suse.de,broadcom.com,vger.kernel.org,kernel.org,google.com,arm.com,debian.org,gmail.com];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	RCVD_TLS_ALL(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_DN_SOME(0.00)[]
X-Spam-Flag: NO
X-Spam-Score: -4.29
X-Spam-Level: 

Hi,

On 7/4/24 16:30, Stanimir Varbanov wrote:
> Hi Jim,
> 
> On 7/3/24 21:02, Jim Quinlan wrote:
>> Previously, our chips provided three inbound "BARS" with fixed purposes:
>> the first was for mapping SOC registers, the second was for memory, and the
>> third was for memory but with the endian swapped.  We typically only used
>> one of these BARs.
>>
>> Complicating that BARs usage was the fact that the PCIe HW would do a
>> baroque internal mapping of system memory, and concatenate the regions of
>> multiple memory controllers.
>>
>> Newer chips such as the 7712 and Cable Modem SOCs have taken a step forward
>> and now provide multiple inbound BARs.  This works in concert with the
>> dma-ranges property, where each provided range becomes an inbound BAR.
>>
>> This commit provides support for these new chips and their multiple
>> inbound BARs but also keeps the legacy support for the older system.
>>
>> Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>
>> ---
>>  drivers/pci/controller/pcie-brcmstb.c | 199 +++++++++++++++++++-------
>>  1 file changed, 150 insertions(+), 49 deletions(-)

<cut>

>>  static int brcm_pcie_setup(struct brcm_pcie *pcie)
>>  {
>> -	u64 rc_bar2_offset, rc_bar2_size;
>> +	struct rc_bar rc_bars[PCIE_BRCM_MAX_RC_BARS];
>>  	void __iomem *base = pcie->base;
>>  	struct pci_host_bridge *bridge;
>>  	struct resource_entry *entry;
>>  	u32 tmp, burst, aspm_support;
>> -	int num_out_wins = 0;
>> -	int ret, memc;
>> +	int num_out_wins = 0, num_rc_bars = 0;
>> +	int i, memc;
>>  
>>  	/* Reset the bridge */
>>  	pcie->bridge_sw_init_set(pcie, 1);
>> @@ -933,17 +1016,47 @@ static int brcm_pcie_setup(struct brcm_pcie *pcie)
>>  	u32p_replace_bits(&tmp, 1, PCIE_MISC_MISC_CTRL_PCIE_RCB_64B_MODE_MASK);
>>  	writel(tmp, base + PCIE_MISC_MISC_CTRL);
>>  
>> -	ret = brcm_pcie_get_rc_bar2_size_and_offset(pcie, &rc_bar2_size,
>> -						    &rc_bar2_offset);
>> -	if (ret)
>> -		return ret;
>> +	num_rc_bars = brcm_pcie_get_rc_bar_sizes_and_offsets(pcie, rc_bars);
> 
> Can we change the function name to brcm_pcie_get_inbound_regions? ...

... or better brcm_pcie_get_inbound_wins() ?

~Stan

