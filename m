Return-Path: <linux-pci+bounces-14797-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 22AF29A2553
	for <lists+linux-pci@lfdr.de>; Thu, 17 Oct 2024 16:42:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 751CFB21A9D
	for <lists+linux-pci@lfdr.de>; Thu, 17 Oct 2024 14:42:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D72831DE885;
	Thu, 17 Oct 2024 14:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="HcTuBVe9";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="WRpZSJhl";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="HcTuBVe9";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="WRpZSJhl"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5D291DE4D2;
	Thu, 17 Oct 2024 14:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729176152; cv=none; b=sMhQgK6p7BcaYeHmhmWXTiURNrG6/iixCr1SNn3x/6TPXDInXPOCUMrjlQJxee1p2jVdxkCE9ljWr/2Z5fKiMehgtIeBk4BhlVq2gZdVUKjXOnNqQsyniLdV8ntrSiwlw2sVKqfBElTcadW0fuzyHnLzMqRySprlyQmuWaif+i8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729176152; c=relaxed/simple;
	bh=aRsXh3WlcPiguO065JSN1ww7Mu+ct1RIHN/oLRfkIiE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ayxTPOeusxHX+J+tVV/Gknu4xnJhCbbSpU60KgyoXZCMYvYBafqtbt0veuKK6ULVEAdq0e+xijwaqS92AYrhjt6hIY6Cb7Ya97sJ2cu8zs0oHlVoTS/xozzgzaT/qvpN+FT/vbUEl7m9XR3ohd8VzgTnghAK0Xx2K8OhbpYQC8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=HcTuBVe9; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=WRpZSJhl; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=HcTuBVe9; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=WRpZSJhl; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id C3CE021CA1;
	Thu, 17 Oct 2024 14:42:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1729176144; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Hlxh0bcMo2l0x2YqrsdI35AUgQmto6DnXucDuIIvlIQ=;
	b=HcTuBVe9HTvxG6z5OqXhvYa9479F1a6LuNX1wPgmDEI906oF+i8x4ZFzJW3i2xRXC7WzUT
	gCfFsMFV6An0Uv58xNfTiQJCOrCtIqChDk9kBwy2zDW2g2pX2lRf031XOy/LwwADRq+FHE
	67M6y8YivQmyrjYPoC1jlapHrz24yEM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1729176144;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Hlxh0bcMo2l0x2YqrsdI35AUgQmto6DnXucDuIIvlIQ=;
	b=WRpZSJhlqTCrbSLk7HJ5HWtBArsFvMFy8cHpnn7W1nNKfU+2jsCaY3J8FGag7XoOUEQv3i
	M9tUR9Js5kcv3sCw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=HcTuBVe9;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=WRpZSJhl
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1729176144; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Hlxh0bcMo2l0x2YqrsdI35AUgQmto6DnXucDuIIvlIQ=;
	b=HcTuBVe9HTvxG6z5OqXhvYa9479F1a6LuNX1wPgmDEI906oF+i8x4ZFzJW3i2xRXC7WzUT
	gCfFsMFV6An0Uv58xNfTiQJCOrCtIqChDk9kBwy2zDW2g2pX2lRf031XOy/LwwADRq+FHE
	67M6y8YivQmyrjYPoC1jlapHrz24yEM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1729176144;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Hlxh0bcMo2l0x2YqrsdI35AUgQmto6DnXucDuIIvlIQ=;
	b=WRpZSJhlqTCrbSLk7HJ5HWtBArsFvMFy8cHpnn7W1nNKfU+2jsCaY3J8FGag7XoOUEQv3i
	M9tUR9Js5kcv3sCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D343513A42;
	Thu, 17 Oct 2024 14:42:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id vJWEME8iEWfuKwAAD6G6ig
	(envelope-from <svarbanov@suse.de>); Thu, 17 Oct 2024 14:42:23 +0000
Message-ID: <bed7b0ea-494b-429e-8130-12d12eb11bf0@suse.de>
Date: Thu, 17 Oct 2024 17:42:23 +0300
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 09/11] PCI: brcmstb: Adjust PHY PLL setup to use a
 54MHz input refclk
To: Florian Fainelli <florian.fainelli@broadcom.com>,
 Stanimir Varbanov <svarbanov@suse.de>, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rpi-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Jim Quinlan <jim2101024@gmail.com>,
 Nicolas Saenz Julienne <nsaenz@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>, kw@linux.com,
 Philipp Zabel <p.zabel@pengutronix.de>,
 Andrea della Porta <andrea.porta@suse.com>,
 Phil Elwell <phil@raspberrypi.com>, Jonathan Bell <jonathan@raspberrypi.com>
References: <20241014130710.413-1-svarbanov@suse.de>
 <20241014130710.413-10-svarbanov@suse.de>
 <60de2ae5-af4b-4c31-bc63-9f62b08be2fc@broadcom.com>
Content-Language: en-US
From: Stanimir Varbanov <svarbanov@suse.de>
In-Reply-To: <60de2ae5-af4b-4c31-bc63-9f62b08be2fc@broadcom.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: C3CE021CA1
X-Spam-Level: 
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[linutronix.de,kernel.org,gmail.com,google.com,linux.com,pengutronix.de,suse.com,raspberrypi.com];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dt];
	DKIM_TRACE(0.00)[suse.de:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.01
X-Spam-Flag: NO

Hi Florian,

On 10/14/24 20:07, Florian Fainelli wrote:
> On 10/14/24 06:07, Stanimir Varbanov wrote:
>> Use canned MDIO writes from Broadcom that switch the ref_clk output
>> pair to run from the internal fractional PLL, and set the internal
>> PLL to expect a 54MHz input reference clock.
>>
>> Without this RPi5 PCIe cannot enumerate endpoint devices on
>> extension connector.
> 
> You could say that the default reference clock for the PLL is 100MHz,
> except for some devices, where it is 54MHz, like 2712d0. AFAIR, 2712c1
> might have been 100MHz as well, so whether we need to support that
> revision of the chip or not might be TBD.

I'm confused now, according to [1] :

BCM2712C1 - 4GB and 8GB RPi5 models
BCM2712D0 - 2GB RPi5 models

My device is 4GB RPi5 model so I would expect it is BCM2712C1, thus
according to your comment the PLL PHY adjustment is not needed. But I
see that the PCIex1 RC cannot enumerate devices on ext PCI connector
because of link training failure. Implementing PLL adjustment fixes the
failure.


~Stan

[1]
https://www.raspberrypi.com/documentation/computers/processors.html#bcm2712

