Return-Path: <linux-pci+bounces-20527-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A1304A21B1F
	for <lists+linux-pci@lfdr.de>; Wed, 29 Jan 2025 11:43:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C57543A34B4
	for <lists+linux-pci@lfdr.de>; Wed, 29 Jan 2025 10:43:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2AE11B0435;
	Wed, 29 Jan 2025 10:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="U/lnCV4G";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="VaZKT8hY";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="wArQ3UD8";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="MUSweoG3"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25D041AAA10;
	Wed, 29 Jan 2025 10:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738147419; cv=none; b=QJ5LFMRuyIfur4jlhdbMNXp0wb46NNMbYWA3u3Dnd2EFsMISO6QVq7ck4V3tJxdyg+v8w5ohhiKhjLu1sKEFHeNAQNhfXPTpnYVVwVX25UAXb5xKjNYN3n20iKRYI4pWgHaVt+Asco/PKKVcCygbFUsFXuW/z/0A6CgnxpNgq+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738147419; c=relaxed/simple;
	bh=CC343mfD0okuki1r57crt4ti98EOIoVeWw0sI+C/c/A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WUVDhd2r99CEDl5PWCV8C1urI7sImoMMt7/O462irpxfMfe9UYUVX+vEfQWg8Co/nCe4hcR9VXshhnGYHz1C1EL7oP+YyHw4dYedu8KJ9IWsGSCMqlyluGFvplU4eK+QPzkE9rHU9G4Cb16mDFYDsKKQ71lPPa43Mc2tYJoQXeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=U/lnCV4G; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=VaZKT8hY; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=wArQ3UD8; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=MUSweoG3; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id EB6801F365;
	Wed, 29 Jan 2025 10:43:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1738147416; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2tnS1z33E1lmdARbRZJZY1baV7i5IrhBmmqgHqbmlVM=;
	b=U/lnCV4GBIZG9GbQ1SLwed6PEFOLa2KtiY6O7akzy8ThP6T1VqE5oYuGdqn4uKfnAqC/k1
	KCLe8/AKMCU6a4ptb2qA4+1jPr9Y2ovmlTZmOlIZgji2XQKurkAnusdTuaa0Bx6Zg062/S
	6nT6jznqT6s44t3SkfFVyXd3U1tdxxQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1738147416;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2tnS1z33E1lmdARbRZJZY1baV7i5IrhBmmqgHqbmlVM=;
	b=VaZKT8hYvx0LvDaL9DncH7hgceQXTxV/NUnlHukMowsinbc2G6ukDey/6e71smi6XHiIWi
	I9IwBRm8e3VqvNAA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=wArQ3UD8;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=MUSweoG3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1738147414; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2tnS1z33E1lmdARbRZJZY1baV7i5IrhBmmqgHqbmlVM=;
	b=wArQ3UD8ofb8Duq+Uqy67bpUSGreo6Hiqr8UM04g7f2MxsC9UKifObCDP+OnI0zlBXChlu
	dYnzMI2mTY7jJMElIN4x44gRClFguzJgUeCXVK8+jHFM081mnCG0Sv4/PA39GANzMBwQ0y
	nTNXNR115MEBd2mbOvIjX3hlN9E33rU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1738147414;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2tnS1z33E1lmdARbRZJZY1baV7i5IrhBmmqgHqbmlVM=;
	b=MUSweoG3CdRus8S/4/g34ZtCsJ7NIYPezhBni7oNh8xix67Dfx0INn6LKOumml603x7ipq
	Simvrq8afwjaDBBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F3CD6137D2;
	Wed, 29 Jan 2025 10:43:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id KhYhOVUGmmfeWQAAD6G6ig
	(envelope-from <svarbanov@suse.de>); Wed, 29 Jan 2025 10:43:33 +0000
Message-ID: <320db9bc-3610-4336-a691-a8926cdb7e24@suse.de>
Date: Wed, 29 Jan 2025 12:43:25 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 -next 03/11] irqchip: Add Broadcom bcm2712 MSI-X
 interrupt controller
To: Florian Fainelli <florian.fainelli@broadcom.com>,
 Thomas Gleixner <tglx@linutronix.de>, Stanimir Varbanov <svarbanov@suse.de>,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rpi-kernel@lists.infradead.org,
 linux-pci@vger.kernel.org,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Bjorn Helgaas
 <bhelgaas@google.com>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Jim Quinlan <jim2101024@gmail.com>,
 Nicolas Saenz Julienne <nsaenz@kernel.org>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Philipp Zabel <p.zabel@pengutronix.de>,
 Andrea della Porta <andrea.porta@suse.com>,
 Phil Elwell <phil@raspberrypi.com>, Jonathan Bell
 <jonathan@raspberrypi.com>, Dave Stevenson <dave.stevenson@raspberrypi.com>
References: <20250120130119.671119-1-svarbanov@suse.de>
 <20250120130119.671119-4-svarbanov@suse.de> <87bjvs86w8.ffs@tglx>
 <b1009877-6749-4bb1-95b9-ae976bef591c@broadcom.com>
Content-Language: en-US
From: Stanimir Varbanov <svarbanov@suse.de>
In-Reply-To: <b1009877-6749-4bb1-95b9-ae976bef591c@broadcom.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: EB6801F365
X-Spam-Score: -3.01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,pengutronix.de,suse.com,raspberrypi.com];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	MID_RHS_MATCH_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dt];
	DKIM_TRACE(0.00)[suse.de:+];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim,suse.de:mid,suse.de:email,linutronix.de:email]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

Hi,

On 1/28/25 7:55 PM, Florian Fainelli wrote:
> On 1/27/25 10:10, Thomas Gleixner wrote:
>> On Mon, Jan 20 2025 at 15:01, Stanimir Varbanov wrote:
>>
>>> Add an interrupt controller driver for MSI-X Interrupt Peripheral (MIP)
>>> hardware block found in bcm2712. The interrupt controller is used to
>>> handle MSI-X interrupts from peripherials behind PCIe endpoints like
>>> RP1 south bridge found in RPi5.
>>>
>>> There are two MIPs on bcm2712, the first has 64 consecutive SPIs
>>> assigned to 64 output vectors, and the second has 17 SPIs, but only
>>> 8 of them are consecutive starting at the 8th output vector.
>>>
>>> Signed-off-by: Stanimir Varbanov <svarbanov@suse.de>
>>
>> Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
>>
>> As this is a new controller and required for the actual PCI muck, I
>> think the best way is to take it through the PCI tree, unless someone
>> wants me to pick the whole lot up.
> 
> Agreed, the PCI maintainers should take patches 1 through 9 inclusive,

Just small correction, patch 09/11 [1] has a new v2 at [2]. And I think
PCI maintainer have to take v2.

> and I will take patches 10-11 through the Broadcom ARM SoC tree, Bjorn,
> KW, does that work?

~Stan

[1] [PATCH v5 -next 09/11] PCI: brcmstb: Fix for missing of_node_put

[2]
https://lore.kernel.org/lkml/20250122222955.1752778-1-svarbanov@suse.de/T/



