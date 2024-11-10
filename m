Return-Path: <linux-pci+bounces-16379-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE9FC9C317E
	for <lists+linux-pci@lfdr.de>; Sun, 10 Nov 2024 10:41:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B36C1C20A3A
	for <lists+linux-pci@lfdr.de>; Sun, 10 Nov 2024 09:41:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C89F1537CB;
	Sun, 10 Nov 2024 09:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="vc85F1+q";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="xbtDXHoB";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="SIg2cies";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="e7ZZrLlE"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C94431537AA;
	Sun, 10 Nov 2024 09:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731231688; cv=none; b=EYgVOsEaN2b2GhdGgbsY8JlSasX5EAQ89PWRR86qEjWnVx9GIr4AS9r10os0SPY5L1ugPLnRrx3T1KV/nPrhDSZxCJf3xCNsfmnNKgLeCzLVT0oSRC1SS8XTm6PL87vo4gWhAFj0d4EMrhAY/BD45RUVB5Wods4yST3NzXNwDb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731231688; c=relaxed/simple;
	bh=4qvdpQkT3SlRFIlu6TD25SeR7NwDjNqtyUfySTP5Dbw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OiW+cJPKTgX00WHUWDl0kdg7n/uobAm+4Ju5w6rlAXq6c625RJ2ker7VeMNB3ahyBFLWQt2KN6ZED52TEk/2EuyUDWnX6tYVtLTvKE1h+EHOQmihykHUUfsvhL63cGCHSsEQhP2Q0Qof1Ps9NVLzaqvj0ohBny5TlHAw5QWhS+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=vc85F1+q; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=xbtDXHoB; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=SIg2cies; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=e7ZZrLlE; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id CC68921A73;
	Sun, 10 Nov 2024 09:41:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1731231685; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iVJB3Qkd5+VbKsHz2eRls6oNz9FZXUF6a+d/UpC1v0A=;
	b=vc85F1+qXSlODxZaLhmNcZrstutruYw4x2I0CBroDXHmysmrEDftTJABxh9ZovWyDp/kYa
	hAHrpOfIzZAtsoPFkLxL3ASV/DSv8R4HvP9asGScEqI8e/BrEGrJViIXTG1tb/UyouURWZ
	bDj0mPuAuPA/5oSpeGuMfbZ3fQcrcAc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1731231685;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iVJB3Qkd5+VbKsHz2eRls6oNz9FZXUF6a+d/UpC1v0A=;
	b=xbtDXHoBGiX6KQaqAz0fV/teTf19uPjPeWisqeq4Va4sKwKMIR6cGCxbfB9wsnF8t4DaQM
	u+HESoWYH0ETEeAQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=SIg2cies;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=e7ZZrLlE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1731231684; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iVJB3Qkd5+VbKsHz2eRls6oNz9FZXUF6a+d/UpC1v0A=;
	b=SIg2ciesrB2kCBhM4fo5FIaTlEodFUvLoaQrC3cx2yA8YwIfKP1VFZEYoYGkcyk5vMqESM
	DGacZ+DeJgSQ3BY3HXyqBK3lAaAfkNriiQSEeCKYmXNh95ebcx4h0DoKuuFUFJnKQ867i7
	fAfPURE0kigQaZPnz1TgoJlnNmz03/Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1731231684;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iVJB3Qkd5+VbKsHz2eRls6oNz9FZXUF6a+d/UpC1v0A=;
	b=e7ZZrLlEkEfpRFMd1jnS8waLpaAogHYsT9Klum1apOlrYGFGliQr3gykKwWvKnC6lG2+aa
	QAFl9wRDGAd41XDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D018C13980;
	Sun, 10 Nov 2024 09:41:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 7erzL8N/MGfcFQAAD6G6ig
	(envelope-from <svarbanov@suse.de>); Sun, 10 Nov 2024 09:41:23 +0000
Message-ID: <3724f8ff-4b89-465c-ac9d-1dec7c86fb62@suse.de>
Date: Sun, 10 Nov 2024 11:41:11 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 06/10] PCI: brcmstb: Enable external MSI-X if available
To: Stanimir Varbanov <svarbanov@suse.de>, linux-kernel@vger.kernel.org,
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
 <20241025124515.14066-7-svarbanov@suse.de>
Content-Language: en-US
From: Stanimir Varbanov <svarbanov@suse.de>
In-Reply-To: <20241025124515.14066-7-svarbanov@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: CC68921A73
X-Spam-Level: 
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	TAGGED_RCPT(0.00)[dt];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[linutronix.de,kernel.org,broadcom.com,gmail.com,google.com,linux.com,pengutronix.de,suse.com,raspberrypi.com];
	MID_RHS_MATCH_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.01
X-Spam-Flag: NO

Hi,

Jim, Florian there is no review comments on this patch. Could you please
take a look.

regards,
~Stan

On 10/25/24 15:45, Stanimir Varbanov wrote:
> On RPi5 there is an external MIP MSI-X interrupt controller
> which can handle up to 64 interrupts.
> 
> Signed-off-by: Stanimir Varbanov <svarbanov@suse.de>
> ---
> v3 -> v4:
>  - no changes.
> 
>  drivers/pci/controller/pcie-brcmstb.c | 63 +++++++++++++++++++++++++--
>  1 file changed, 59 insertions(+), 4 deletions(-)
> 

<cut>

