Return-Path: <linux-pci+bounces-14945-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D6259A6E61
	for <lists+linux-pci@lfdr.de>; Mon, 21 Oct 2024 17:40:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CCA82281560
	for <lists+linux-pci@lfdr.de>; Mon, 21 Oct 2024 15:40:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F41E1C3F0B;
	Mon, 21 Oct 2024 15:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="mmNc7fZ/";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="fCTXftZz";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="mmNc7fZ/";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="fCTXftZz"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96DB9126C0B;
	Mon, 21 Oct 2024 15:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729525210; cv=none; b=FyvHOHkqFgsf99QVr840MDR2C4azMBY6bmnMP5wt4fQh7UTFdsXaBa1T9ohTAO2KPZ0TokNTyYTFwsui1lBV6LNNv6qt0gr2vwuMWEartLUcvEKtQfQ+WCxAJUhdALmSmn/QXwWGbPJUntMMh74/GhkmEt2VJ3SyPqUlUR31U44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729525210; c=relaxed/simple;
	bh=1W5B/sDDnCJ6y86lSH7pAHZK4QqYHPygiWJjNpbO+6U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Gwdx2xCiRV1HtPt43DEV860LwNvbfrPaNsUCPJPE3zYN/AM72JkDl2wbMvKAjxG1wAxm4PP6YgQpOstcwv7iMqOgpe98qHgbZ6PldWnRxAOac2c9iE7XE2WKaB+mXYzk9JkMAaJnI9Dd8tpb6wgybrBrtx9wo5DdrjOcz4kSXUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=mmNc7fZ/; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=fCTXftZz; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=mmNc7fZ/; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=fCTXftZz; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 9E2A81F7E9;
	Mon, 21 Oct 2024 15:40:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1729525204; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IrVNHHt0mG7LfTUbIY78i9Fn0M5UyUoiUWrwGWCGroQ=;
	b=mmNc7fZ/SBFfmwhY33t8nV28H+U+4VBprC2U7Bm8HnioNHgslcnB380iYIMrO1VzcR9Ho8
	h1RyVXgU2wObETww3mZc7jzvwpqQ4kX411vUC/M3E80D1T6vPQr9E6GalsORcC3icO0RJY
	qjkCgzWHFGGiIu0B23Wlh+C+JbwXDqY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1729525204;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IrVNHHt0mG7LfTUbIY78i9Fn0M5UyUoiUWrwGWCGroQ=;
	b=fCTXftZz6SDsfFmnAFU6IrBfoPDwnEREwCHZ7OS3qSItN2lHTYy5JK5FY2tC1oIIK0PbzO
	FlcRnCT7yOLCmWBA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1729525204; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IrVNHHt0mG7LfTUbIY78i9Fn0M5UyUoiUWrwGWCGroQ=;
	b=mmNc7fZ/SBFfmwhY33t8nV28H+U+4VBprC2U7Bm8HnioNHgslcnB380iYIMrO1VzcR9Ho8
	h1RyVXgU2wObETww3mZc7jzvwpqQ4kX411vUC/M3E80D1T6vPQr9E6GalsORcC3icO0RJY
	qjkCgzWHFGGiIu0B23Wlh+C+JbwXDqY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1729525204;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IrVNHHt0mG7LfTUbIY78i9Fn0M5UyUoiUWrwGWCGroQ=;
	b=fCTXftZz6SDsfFmnAFU6IrBfoPDwnEREwCHZ7OS3qSItN2lHTYy5JK5FY2tC1oIIK0PbzO
	FlcRnCT7yOLCmWBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A4445139E0;
	Mon, 21 Oct 2024 15:40:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id A/wyINN1FmdzbgAAD6G6ig
	(envelope-from <svarbanov@suse.de>); Mon, 21 Oct 2024 15:40:03 +0000
Message-ID: <a5a4ce33-3c32-4e43-a39b-7a3514339e37@suse.de>
Date: Mon, 21 Oct 2024 18:39:59 +0300
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 09/11] PCI: brcmstb: Adjust PHY PLL setup to use a
 54MHz input refclk
To: Jonathan Bell <jonathan@raspberrypi.com>,
 Stanimir Varbanov <svarbanov@suse.de>
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rpi-kernel@lists.infradead.org,
 linux-pci@vger.kernel.org,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Thomas Gleixner
 <tglx@linutronix.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Jim Quinlan <jim2101024@gmail.com>,
 Nicolas Saenz Julienne <nsaenz@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>, kw@linux.com,
 Philipp Zabel <p.zabel@pengutronix.de>,
 Andrea della Porta <andrea.porta@suse.com>,
 Phil Elwell <phil@raspberrypi.com>
References: <20241014130710.413-1-svarbanov@suse.de>
 <20241014130710.413-10-svarbanov@suse.de>
 <60de2ae5-af4b-4c31-bc63-9f62b08be2fc@broadcom.com>
 <bed7b0ea-494b-429e-8130-12d12eb11bf0@suse.de>
 <CADQZjwdO6ifEMBwh15EVPsxm4XtSYGRs==hVCZ0HmcUbADh6hw@mail.gmail.com>
Content-Language: en-US
From: Stanimir Varbanov <svarbanov@suse.de>
In-Reply-To: <CADQZjwdO6ifEMBwh15EVPsxm4XtSYGRs==hVCZ0HmcUbADh6hw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Score: -2.80
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_TLS_ALL(0.00)[];
	TAGGED_RCPT(0.00)[dt];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[21];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[broadcom.com,vger.kernel.org,lists.infradead.org,linutronix.de,kernel.org,gmail.com,google.com,linux.com,pengutronix.de,suse.com,raspberrypi.com];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid,suse.de:email]
X-Spam-Flag: NO
X-Spam-Level: 

Hi,

On 10/21/24 15:56, Jonathan Bell wrote:
> On Thu, 17 Oct 2024 at 15:42, Stanimir Varbanov <svarbanov@suse.de> wrote:
>>
>> Hi Florian,
>>
>> On 10/14/24 20:07, Florian Fainelli wrote:
>>> On 10/14/24 06:07, Stanimir Varbanov wrote:
>>>> Use canned MDIO writes from Broadcom that switch the ref_clk output
>>>> pair to run from the internal fractional PLL, and set the internal
>>>> PLL to expect a 54MHz input reference clock.
>>>>
>>>> Without this RPi5 PCIe cannot enumerate endpoint devices on
>>>> extension connector.
>>>
>>> You could say that the default reference clock for the PLL is 100MHz,
>>> except for some devices, where it is 54MHz, like 2712d0. AFAIR, 2712c1
>>> might have been 100MHz as well, so whether we need to support that
>>> revision of the chip or not might be TBD.
>>
>> I'm confused now, according to [1] :
>>
>> BCM2712C1 - 4GB and 8GB RPi5 models
>> BCM2712D0 - 2GB RPi5 models
>>
>> My device is 4GB RPi5 model so I would expect it is BCM2712C1, thus
>> according to your comment the PLL PHY adjustment is not needed. But I
>> see that the PCIex1 RC cannot enumerate devices on ext PCI connector
>> because of link training failure. Implementing PLL adjustment fixes the
>> failure.
>>
>>
>> ~Stan
>>
>> [1]
>> https://www.raspberrypi.com/documentation/computers/processors.html#bcm2712
> 

Thanks for jumping in, Jon.

> The MDIO writes for 2712C1 are required because platform firmware
> arranges for the reference input clock to be 54MHz.
> 2712D0 can't generate a 100MHz reference input, it's 54MHz only. The
> MDIO register defaults are also changed to suit, but there's no harm

I see that MDIO register defaults for pcie2 (where RP1 is connected) are
changed to suit to 54Mhz but this is not true for pcie1 (expansion
connector). And that could explain why the link training is failing on
pcie1.

> in applying the writes anyway.
> Both steppings need to behave identically for compliance and interop reasons.

Yes, for sure.

> RP1 is very tolerant of out-of-spec reference clocks, which is why
> only the expansion connector appears to be affected.

Thank you for clarifications.

~Stan

[1] Firmware version: RPi: BOOTSYS release VERSION:790da7ef DATE:
2024/07/30 TIME: 15:25:46

