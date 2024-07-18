Return-Path: <linux-pci+bounces-10521-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 03307935035
	for <lists+linux-pci@lfdr.de>; Thu, 18 Jul 2024 17:54:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 860722835A7
	for <lists+linux-pci@lfdr.de>; Thu, 18 Jul 2024 15:54:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 654AB1448C7;
	Thu, 18 Jul 2024 15:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="iJCh00NQ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Uj8Hvw2B";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="E69SeGTh";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="5uFBpiLV"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0C714D8B7;
	Thu, 18 Jul 2024 15:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721318067; cv=none; b=uSIOTgT869LMJRhT5M2hrmJMNud17XKh0zCuMj6HDI3l1KcTrCfT9ySY38Pz7TV9Ljt8oUxDoEhUf6R/Zg7qnAZSCf+g5sZFAhSFCPSV/Le8S7N8wvUSA3DjkL30Q8TuVD0CL6jf0ureNWAqW1r/zjlM1k0wX4dS96FeXLvVU+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721318067; c=relaxed/simple;
	bh=+GyF6wF45Mva/16xGi0bZK4e1fiwil2bPTQjhXLOiuA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mdnDxpZdnMmKFTTUZO2AH/Ik7k5OjnD8C+2IAoEgvEPZAYMFpEjmweyI2FOyiBCrdbSCfIbw0UYi9sijbVFxoEteLJ70LXaR8JrShg/3kh+hBZtJ1uXw9DfOHES8zbwJs7wJscg4jFcnFuwVQckGUm3qR06H5mvnvCJmfQwbFGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=iJCh00NQ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Uj8Hvw2B; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=E69SeGTh; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=5uFBpiLV; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C07061FBFB;
	Thu, 18 Jul 2024 15:54:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1721318064; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Hw0JL5HeNP2tQP8OBPZN6qivjdHQ01R9UaXvGFT6Pl0=;
	b=iJCh00NQGkmfEwGvfwMzpKue/TWOiYXwjn+GMJToXjItCBVOcl1OUyr0AIC9gEEJVW9b61
	XW2XYvIONDxZHC8aKWSjEieRE618ITkMd9P0j5l6NPKBVr4L5GyBavXRRX81306M1lEafW
	DK9iHSCx63rRqfwMGsyIZg72gupWvW8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1721318064;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Hw0JL5HeNP2tQP8OBPZN6qivjdHQ01R9UaXvGFT6Pl0=;
	b=Uj8Hvw2B+SS4PYs54olzZcUTitI6gR7jaxSDzGJzjhOBbZCwnjhgnFWb7JYv/KX01ocBnG
	fioRhtpAU7HrPTAw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=E69SeGTh;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=5uFBpiLV
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1721318063; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Hw0JL5HeNP2tQP8OBPZN6qivjdHQ01R9UaXvGFT6Pl0=;
	b=E69SeGThIYDdtfZ76g0+pC+Lfs1snFpP9Zy33ITQEk1+E3+wxGdJNazTURqB0/GEcCykwh
	M+KGhULAeFNJgiI5xKMWQmhOl5rYCzg/ZFXvI2VQ1P4DfuOqHZIftd5+aIC3GDs2Ubx0BU
	Gh3M4kj9XQMcW28ShyHxCO45KOwzLSI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1721318063;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Hw0JL5HeNP2tQP8OBPZN6qivjdHQ01R9UaXvGFT6Pl0=;
	b=5uFBpiLVBmYySZIclc9Wuxvf6b4xhF9lMS4vb6s37vgtXQ2NZmqMjoZF9EKUkBRe3tcgN0
	PRzbVTkeR+Fk8GCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CC9681379D;
	Thu, 18 Jul 2024 15:54:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id jw2UL646mWYFNAAAD6G6ig
	(envelope-from <svarbanov@suse.de>); Thu, 18 Jul 2024 15:54:22 +0000
Message-ID: <3fa9cdef-b242-43ef-bf53-33fb3f294039@suse.de>
Date: Thu, 18 Jul 2024 18:54:18 +0300
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/7] irqchip: Add Broadcom bcm2712 MSI-X interrupt
 controller
To: Thomas Gleixner <tglx@linutronix.de>,
 Stanimir Varbanov <svarbanov@suse.de>, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rpi-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Florian Fainelli <florian.fainelli@broadcom.com>,
 Jim Quinlan <jim2101024@gmail.com>,
 Nicolas Saenz Julienne <nsaenz@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>, kw@linux.com,
 Philipp Zabel <p.zabel@pengutronix.de>,
 Andrea della Porta <andrea.porta@suse.com>,
 Phil Elwell <phil@raspberrypi.com>, Jonathan Bell <jonathan@raspberrypi.com>
References: <20240626104544.14233-1-svarbanov@suse.de>
 <20240626104544.14233-4-svarbanov@suse.de> <87ikxu1t5e.ffs@tglx>
Content-Language: en-US
From: Stanimir Varbanov <svarbanov@suse.de>
In-Reply-To: <87ikxu1t5e.ffs@tglx>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-3.00 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	XM_UA_NO_VERSION(0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_TWELVE(0.00)[21];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[kernel.org,broadcom.com,gmail.com,google.com,linux.com,pengutronix.de,suse.com,raspberrypi.com];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[dt];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim]
X-Spam-Flag: NO
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.00
X-Spam-Level: 
X-Rspamd-Queue-Id: C07061FBFB

Hi Thomas,

Thank you for the comments!

On 6/27/24 15:12, Thomas Gleixner wrote:
> Stanimir!
> 
> On Wed, Jun 26 2024 at 13:45, Stanimir Varbanov wrote:
>> Add an interrupt controller driver for MSI-X Interrupt Peripheral (MIP)
>> hardware block found in bcm2712. The interrupt controller is used to
>> handle MSI-X interrupts from peripherials behind PCIe endpoints like
>> RP1 south bridge found in RPi5.
>>
>> There are two MIPs on bcm2712, the first has 64 consecutive SPIs
>> assigned to 64 output vectors, and the second has 17 SPIs, but only
>> 8 of them are consecutive starting at the 8th output vector.
> 
> This is going to conflict with:
> 
>   https://lore.kernel.org/all/20240623142137.448898081@linutronix.de/
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git devmsi-arm-v4-1
> 
> Can you please have a look and rework it to the new per device MSI
> domain concept?

When do you expect this will be merged?

~Stan

