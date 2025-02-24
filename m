Return-Path: <linux-pci+bounces-22267-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08A03A42F06
	for <lists+linux-pci@lfdr.de>; Mon, 24 Feb 2025 22:28:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EEC7E7A4FD4
	for <lists+linux-pci@lfdr.de>; Mon, 24 Feb 2025 21:27:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 742371DDA33;
	Mon, 24 Feb 2025 21:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="GV0bpMsq";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="6KZfci/H";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="eDL/v6Wx";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="rRv9u7fE"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D16091DC98B
	for <linux-pci@vger.kernel.org>; Mon, 24 Feb 2025 21:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740432502; cv=none; b=R9MxSHgTO1vgJyVOLp64Q+FilunYFECR8LiVzfjnCNAdL3IkNK6pqlTqsynm8m7IjQ1NyuZj4oaKN/AH3W3DG0kA/65prGJYy57iq18ExC4r7wKW2YgxShhO9pWV4u+FhNuQQuYLsMpRbz5xGCLRZ6w93pQBSNImyAkgP7Tid0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740432502; c=relaxed/simple;
	bh=GL21N69H/P/6mdUx2zjbZ2ak9oshViQynEjDaJrrehc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=S2MiNPQJWWLLywFpwS1d1HqSLCPl/+KtJOzyOahl48nkJMCwM/jZ35Mbez0JrOpnNqFSrqLBlkvk0FfWWLPAFYu94r/9UYoUB676v/6BkzBeVdvQV7SoF6/qcI7lz2C9Q3W/opG3X782H+gqepL+VTXmBpKVffGTE/Y1NmjNQlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=GV0bpMsq; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=6KZfci/H; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=eDL/v6Wx; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=rRv9u7fE; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C92E21F44E;
	Mon, 24 Feb 2025 21:28:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1740432498; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Qvgm+D28JDvejs53Z18fdULzcHEuXR6KF6+ladTokSM=;
	b=GV0bpMsq5UQbZviMXq9ntFQ+U1cxHTSutltlQ+ufcM8iRz+33IGwOHXO0h8IZJEDtJKYyC
	ceP1NQKsiWMyktJ1NPhtPBWrSAqtyCJlyevg6zQ2vdyF7WIIdQi/MZr0iqhztTKjVPUGv+
	WcmD6dpRkOPS0CE5GS+gM1EQxFSUAFk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1740432498;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Qvgm+D28JDvejs53Z18fdULzcHEuXR6KF6+ladTokSM=;
	b=6KZfci/Hi52jZd1i5JMzlEubUQzzNg/QE1zE6kvBvkUu+8JBPN43jH7/WGhFWL8tsSYY8G
	NYdC6I2iKFomd9CA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1740432497; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Qvgm+D28JDvejs53Z18fdULzcHEuXR6KF6+ladTokSM=;
	b=eDL/v6Wx+hy0B2WiyaN66MzTiRU0RC4aeVtES+O0PMrzRO2Eu6UcFf+U1STZGxmFCYZkjm
	HjDgR+xZ1VAgix1LHTjXURDdjovyY0U6KxtcdezQMAGaIecnfO1pruZfgXpTXJ7sF/iOIa
	Rw8yyeUVKaFUu1LoK/vyVCURcbMfDSw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1740432497;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Qvgm+D28JDvejs53Z18fdULzcHEuXR6KF6+ladTokSM=;
	b=rRv9u7fEBGAkK0D81JkV2U5IBsqrmDp5Zbtb3+mwxC5jQov2DAstrgDmR7RGavmTEOglfI
	HwIgqZvOHsxwYYBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B426013332;
	Mon, 24 Feb 2025 21:28:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 0uQmKXDkvGeoSQAAD6G6ig
	(envelope-from <svarbanov@suse.de>); Mon, 24 Feb 2025 21:28:16 +0000
Message-ID: <7219082a-6a84-4681-ad9e-6f76aba08966@suse.de>
Date: Mon, 24 Feb 2025 23:28:16 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 0/7] Add PCIe support for bcm2712
To: =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 Stanimir Varbanov <svarbanov@suse.de>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rpi-kernel@lists.infradead.org,
 linux-pci@vger.kernel.org,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Thomas Gleixner
 <tglx@linutronix.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Florian Fainelli <florian.fainelli@broadcom.com>,
 Jim Quinlan <jim2101024@gmail.com>,
 Nicolas Saenz Julienne <nsaenz@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Philipp Zabel <p.zabel@pengutronix.de>,
 Andrea della Porta <andrea.porta@suse.com>,
 Phil Elwell <phil@raspberrypi.com>, Jonathan Bell
 <jonathan@raspberrypi.com>, Dave Stevenson <dave.stevenson@raspberrypi.com>
References: <20250224083559.47645-1-svarbanov@suse.de>
 <20250224192215.GC2064156@rocinante>
Content-Language: en-US
From: Stanimir Varbanov <svarbanov@suse.de>
In-Reply-To: <20250224192215.GC2064156@rocinante>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.992];
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
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.infradead.org,broadcom.com,linutronix.de,kernel.org,gmail.com,google.com,pengutronix.de,suse.com,raspberrypi.com];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -2.80
X-Spam-Flag: NO



On 2/24/25 9:22 PM, Krzysztof Wilczyński wrote:
> Hello,
> 
>> Hello, v6 is re-based version of controller/brcmstb branch of pci tree.
> 
> Applied to controller/brcmstb, thank you!

Thank you, Krzysztof!

~Stan


