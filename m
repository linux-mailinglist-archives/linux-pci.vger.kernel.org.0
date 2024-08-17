Return-Path: <linux-pci+bounces-11792-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A2A3995592E
	for <lists+linux-pci@lfdr.de>; Sat, 17 Aug 2024 19:41:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD7551C20B01
	for <lists+linux-pci@lfdr.de>; Sat, 17 Aug 2024 17:41:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57A16C133;
	Sat, 17 Aug 2024 17:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="efjNRCeT";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="fyJtI0Ne";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="efjNRCeT";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="fyJtI0Ne"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FF95440C;
	Sat, 17 Aug 2024 17:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723916515; cv=none; b=ZqGmEWFaRHDv50nZHs3E2o1RhIjBVz9zrBZXJvLXOhTrwZQDICnb1p0RdGllErVMPcBpqPv6gOlBjtB67pTWXXoQOoei8glKgJOmt0IZ5wM5xx/QD+wJYuj5i2nwtC/Ddxb8eDGtGwjE1n+LV6I6cKWCSYvEyGyxqrGIZ0MCUNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723916515; c=relaxed/simple;
	bh=jtqDTtNajvInU5FR+593dp7wIWkfBEwX/qDLvacvdGU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gke0JMDcAC3wHc5jrv44Wi9iqj/TDd1E1GBn2xoy0WIKxJvqVLvKCozmygBQMBcLFWu2cgAXPHpEoEWW0Yx1LZwTyQFcYomckUvia6y1KxsJMdSEyPkv3O9GUwsbVnDu9Bfybq5Mpno8qU/KzpJFECECA/1/fpOBHpFuLcUcxNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=efjNRCeT; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=fyJtI0Ne; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=efjNRCeT; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=fyJtI0Ne; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 45F4220233;
	Sat, 17 Aug 2024 17:41:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1723916506; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KVJWcYecUYFD2wvA80Jm7qXMKv1nO73ux4O2gMSc0l8=;
	b=efjNRCeT06TaE2zT9OdcsxWe+em4oIyhgfp0atysl8mwt9tLlqtJz2CjFYu1nWCbW25eyu
	eF5ogRAUlKyUxXL6ceoaKEMQB0hBIs/yxfayavEkxE4LhvE5E7FRa8jo1l5uHVYCLSAidf
	2ulZneqPT/tKQ95GyhRFVapqbmHpYp8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1723916506;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KVJWcYecUYFD2wvA80Jm7qXMKv1nO73ux4O2gMSc0l8=;
	b=fyJtI0NeM10LedJTJL22uWlCRNpI6huGDudR1Ms5Dslf/+wt34IF99AglPFyMvWYJHRmUc
	MSayPAyjbz8C4bAQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1723916506; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KVJWcYecUYFD2wvA80Jm7qXMKv1nO73ux4O2gMSc0l8=;
	b=efjNRCeT06TaE2zT9OdcsxWe+em4oIyhgfp0atysl8mwt9tLlqtJz2CjFYu1nWCbW25eyu
	eF5ogRAUlKyUxXL6ceoaKEMQB0hBIs/yxfayavEkxE4LhvE5E7FRa8jo1l5uHVYCLSAidf
	2ulZneqPT/tKQ95GyhRFVapqbmHpYp8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1723916506;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KVJWcYecUYFD2wvA80Jm7qXMKv1nO73ux4O2gMSc0l8=;
	b=fyJtI0NeM10LedJTJL22uWlCRNpI6huGDudR1Ms5Dslf/+wt34IF99AglPFyMvWYJHRmUc
	MSayPAyjbz8C4bAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6B90113991;
	Sat, 17 Aug 2024 17:41:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Dc64F9ngwGZ0BgAAD6G6ig
	(envelope-from <svarbanov@suse.de>); Sat, 17 Aug 2024 17:41:45 +0000
Message-ID: <1a6d6972-f2db-4d44-b79c-811ba44368f0@suse.de>
Date: Sat, 17 Aug 2024 20:41:29 +0300
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 05/13] PCI: brcmstb: Use bridge reset if available
To: Jim Quinlan <james.quinlan@broadcom.com>, linux-pci@vger.kernel.org,
 Nicolas Saenz Julienne <nsaenz@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Cyril Brulebois <kibi@debian.org>, Stanimir Varbanov <svarbanov@suse.de>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Krzysztof Kozlowski <krzk@kernel.org>,
 bcm-kernel-feedback-list@broadcom.com, jim2101024@gmail.com
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 Rob Herring <robh@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>,
 "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE"
 <linux-rpi-kernel@lists.infradead.org>,
 "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>,
 open list <linux-kernel@vger.kernel.org>
References: <20240815225731.40276-1-james.quinlan@broadcom.com>
 <20240815225731.40276-6-james.quinlan@broadcom.com>
Content-Language: en-US
From: Stanimir Varbanov <svarbanov@suse.de>
In-Reply-To: <20240815225731.40276-6-james.quinlan@broadcom.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[broadcom.com,vger.kernel.org,kernel.org,google.com,arm.com,debian.org,suse.de,linaro.org,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[19];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid]
X-Spam-Score: -4.30

Hi Jim,

On 8/16/24 01:57, Jim Quinlan wrote:
> The 7712 SOC has a bridge reset which can be described in the device tree.
> Use it if present.  Otherwise, continue to use the legacy method to reset
> the bridge.
> 
> Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>
> ---
>  drivers/pci/controller/pcie-brcmstb.c | 24 +++++++++++++++++++-----
>  1 file changed, 19 insertions(+), 5 deletions(-)

Reviewed-by: Stanimir Varbanov <svarbanov@suse.de>

One problem though on RPi5 (bcm2712).

With this series applied + my WIP patches for enablement of PCIe on
bcm2712 when enable the pcie1 and pcie2 root ports in dts, I see kernel
boot stuck on pcie2 enumeration and I have to add this [1] to make it
work again.

Some more info about resets used:

pcie0 @ 100000:
	resets = <&bcm_reset 5>, <&bcm_reset 42>, <&pcie_rescal>;
	reset-names = "swinit", "bridge", "rescal";

pcie1 @ 110000:
	resets = <&bcm_reset 7>, <&bcm_reset 43>, <&pcie_rescal>;
	reset-names = "swinit", "bridge", "rescal";

pcie2 @ 120000:
	resets = <&bcm_reset 9>, <&bcm_reset 44>, <&pcie_rescal>;
	reset-names = "swinit", "bridge", "rescal";


I changed "swinit" reset for pcie2 to <&bcm_reset 9> (it is 32 in
downstream rpi kernel) because otherwise I'm unable to enumerate RP1
south bridge at all.

Any help will be appreciated.

~Stan

[1]
https://github.com/raspberrypi/linux/blob/rpi-6.11.y/drivers/pci/controller/pcie-brcmstb.c#L1711

