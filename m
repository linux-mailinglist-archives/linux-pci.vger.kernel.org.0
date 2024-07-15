Return-Path: <linux-pci+bounces-10247-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C87EA93124F
	for <lists+linux-pci@lfdr.de>; Mon, 15 Jul 2024 12:33:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D06B1F22871
	for <lists+linux-pci@lfdr.de>; Mon, 15 Jul 2024 10:33:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25083187345;
	Mon, 15 Jul 2024 10:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="DWrItPJa";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="mxVqFlZO";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="DWrItPJa";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="mxVqFlZO"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 449EA13B5BD;
	Mon, 15 Jul 2024 10:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721039576; cv=none; b=nWbzFX2DocCOmY1TYAB4WDIyr8yoAl6ctLyirRL1SRd0GxQTEHPs4A/dP20zbloxTF0IdI2nvISXSrk3NyfPggq6o0LRxb9RlLyLNfysG+t+pY2yhMWKQJ3+eViruO/BYWZQVbM1IYmxymFYQ+OJ3ADpe1nWKG1GPM9zgkcqdiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721039576; c=relaxed/simple;
	bh=EXshsVruvNY9Apx2j4uobdihoNp8SK46HnKmdJt6SO8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=njYYYLRp4GQ6l11Jd7iByRyrgtcHB8i0zlAFiZfL8RuZjz9Ka02femwV01aT01pzQhEWipr156DeMYyQwVp5COBAw3wDHJgXjEUNxlQy1T59h0N0Alh8ClUa6XAh3ZFTnolGqqS+4M38MENj/KFQMUqZ+9zfSHqtDKAfPPlqfSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=DWrItPJa; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=mxVqFlZO; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=DWrItPJa; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=mxVqFlZO; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 358021F7E2;
	Mon, 15 Jul 2024 10:32:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1721039572; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Fdbk1AhMufcu8Sd78ZIVpwnXec9SSQ0Mk+3sOV88C9k=;
	b=DWrItPJaEvI2LSQqRnbgEQOh5hLEE/RdbvqHBS7/TcoZj/Ie76wvtM5G9KsjC6vsqf0yua
	yHofde01/QtaIlYnpS+j3OLVm2nhzZ/kEz2duxdKFgw7FpaqZaq58hyN5O4Sut3ijYodxQ
	/Dw77D8rf4MO+OJk94TjFAP4hBa7fuY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1721039572;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Fdbk1AhMufcu8Sd78ZIVpwnXec9SSQ0Mk+3sOV88C9k=;
	b=mxVqFlZOKbeUZwNBTBNaQ5sqibRN1SlouFHlslHfe2qdZJq92iUkGmHwW6tUpF4tLfTCRP
	QJES3O7AFRjxZnCA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=DWrItPJa;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=mxVqFlZO
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1721039572; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Fdbk1AhMufcu8Sd78ZIVpwnXec9SSQ0Mk+3sOV88C9k=;
	b=DWrItPJaEvI2LSQqRnbgEQOh5hLEE/RdbvqHBS7/TcoZj/Ie76wvtM5G9KsjC6vsqf0yua
	yHofde01/QtaIlYnpS+j3OLVm2nhzZ/kEz2duxdKFgw7FpaqZaq58hyN5O4Sut3ijYodxQ
	/Dw77D8rf4MO+OJk94TjFAP4hBa7fuY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1721039572;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Fdbk1AhMufcu8Sd78ZIVpwnXec9SSQ0Mk+3sOV88C9k=;
	b=mxVqFlZOKbeUZwNBTBNaQ5sqibRN1SlouFHlslHfe2qdZJq92iUkGmHwW6tUpF4tLfTCRP
	QJES3O7AFRjxZnCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5E19E137EB;
	Mon, 15 Jul 2024 10:32:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id asnnE9P6lGZIIgAAD6G6ig
	(envelope-from <svarbanov@suse.de>); Mon, 15 Jul 2024 10:32:51 +0000
Message-ID: <0c3f0521-7e03-41e0-9c45-c2d8244f3963@suse.de>
Date: Mon, 15 Jul 2024 13:32:50 +0300
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 03/12] PCI: brcmstb: Use common error handling code in
 brcm_pcie_probe()
To: Jim Quinlan <james.quinlan@broadcom.com>, linux-pci@vger.kernel.org,
 Nicolas Saenz Julienne <nsaenz@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Cyril Brulebois <kibi@debian.org>, Stanimir Varbanov <svarbanov@suse.de>,
 Krzysztof Kozlowski <krzk@kernel.org>,
 bcm-kernel-feedback-list@broadcom.com, jim2101024@gmail.com
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 Rob Herring <robh@kernel.org>,
 "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE"
 <linux-rpi-kernel@lists.infradead.org>,
 "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>,
 open list <linux-kernel@vger.kernel.org>
References: <20240710221630.29561-1-james.quinlan@broadcom.com>
 <20240710221630.29561-4-james.quinlan@broadcom.com>
Content-Language: en-US
From: Stanimir Varbanov <svarbanov@suse.de>
In-Reply-To: <20240710221630.29561-4-james.quinlan@broadcom.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-5.50 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	DWL_DNSWL_LOW(-1.00)[suse.de:dkim];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	MX_GOOD(-0.01)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RCPT_COUNT_TWELVE(0.00)[17];
	ARC_NA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FREEMAIL_TO(0.00)[broadcom.com,vger.kernel.org,kernel.org,google.com,arm.com,debian.org,suse.de,gmail.com];
	MIME_TRACE(0.00)[0:+];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Spam-Flag: NO
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -5.50
X-Spam-Level: 
X-Rspamd-Queue-Id: 358021F7E2



On 7/11/24 01:16, Jim Quinlan wrote:
> o Move the clk_prepare_enable() below the resource allocations.
> o Add a jump target (clk_out) so that a bit of exception handling can be
>   better reused at the end of this function implementation.
> 
> Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>
> 
> Fixes: bb610757fcd7 ("PCI: brcmstb: Use reset/rearm instead of deassert/assert")

I don't think the current patch is related to bb610757fcd7, please drop
Fixes tag.

> ---
>  drivers/pci/controller/pcie-brcmstb.c | 29 +++++++++++++++------------
>  1 file changed, 16 insertions(+), 13 deletions(-)

Reviewed-by: Stanimir Varbanov <svarbanov@suse.de>

~Stan

