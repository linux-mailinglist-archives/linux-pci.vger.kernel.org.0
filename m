Return-Path: <linux-pci+bounces-13262-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A5B297AF13
	for <lists+linux-pci@lfdr.de>; Tue, 17 Sep 2024 12:41:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD00A1C20752
	for <lists+linux-pci@lfdr.de>; Tue, 17 Sep 2024 10:41:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ECB3165F19;
	Tue, 17 Sep 2024 10:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="PzGfis6o";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="5o95e55u";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="OEWKZpjy";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="cqzTbZDR"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC1E716130C;
	Tue, 17 Sep 2024 10:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726569664; cv=none; b=J9Y4BZ1AccSFhy0D4K2ZijM5nEZDgNySG8GLI4sSSzz3vpgVYWHqTvx2IMa1PPemMLaI+g7q8NkHwZUYkhZ1ilvAye+OfF8aBG3mXqLY1AY40iG6ZCrKFkau6Cx5eN14A2bQx+X2GuP7srStIi5L/HKLbzcO7sypcVYqmGoRQrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726569664; c=relaxed/simple;
	bh=NGYoXzzFMQt7/QqjqT0sfh07G+FI9nh3E5Gk0adWa0Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gRiGoi23cfE+Q0iDLl8JmHDyVHGhPdJzRK7QT9skoi7bPO1EOVNxh2cyqQnAamroNMTGOnb+OAKusT0Pp5Sgs5K94rSkah8TMk5puQckFDvMr7IRvnHX9DYyxe65Ov8lKqkXeNE5W/8OyOEpBfYsjuHXK+IAlYv1b3fuIDs8s6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=PzGfis6o; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=5o95e55u; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=OEWKZpjy; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=cqzTbZDR; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D5B2722113;
	Tue, 17 Sep 2024 10:40:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1726569661; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UxIhQZaCoEImEPjmzoyU9bT+2QV60ZDUbCgxrZhrBE0=;
	b=PzGfis6oXBNyDrdgqdcdd2WDbyY1ks7VAVzahzseCZjwsdwJCFeu5XF39fvO8J+LnPZcuh
	8J0x0mZ5o/nHF1MRvn+3yiuev+YhM7IQZlAYXUcc41/vRmz4mV2l8KZA+1JoiMVzq4MKoP
	j8ow1lxnueWC7Gln0UNLQC18ceGRkJg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1726569661;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UxIhQZaCoEImEPjmzoyU9bT+2QV60ZDUbCgxrZhrBE0=;
	b=5o95e55u5j4joCIO9QXkwNxzl41B9yfzDdrv5GV9gatI4lZQs4Id7IeRPLwHzCvczOzCYy
	ltkxVJYZCkzmFwBA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1726569659; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UxIhQZaCoEImEPjmzoyU9bT+2QV60ZDUbCgxrZhrBE0=;
	b=OEWKZpjyYQ85Aitk6U38t1LYhfuwCvVvH41dmtOfTziPPRdnBtxJOOtDgKnVx8yx0Bw51g
	IlFii8HXaEggsHEhtNCuN969qzrg1+YBYzHUaMWp00l2ohEVvXsXx25Kt1Y9XbnR9B7rZL
	xWHYC+xDQjSdN3Zs9tMJukdVPKYdTXQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1726569659;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UxIhQZaCoEImEPjmzoyU9bT+2QV60ZDUbCgxrZhrBE0=;
	b=cqzTbZDRWSsTIAKVAsx+kHaII+bKP2sui9irnRLB3Gwh4jEBuBVvygxG2X11zGNGIwY2dQ
	JJ+e8LhPDwME5qDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C85F2139CE;
	Tue, 17 Sep 2024 10:40:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id R1bkLbpc6WaPegAAD6G6ig
	(envelope-from <svarbanov@suse.de>); Tue, 17 Sep 2024 10:40:58 +0000
Message-ID: <34025684-f5e2-4c3e-aa8f-d90288c85218@suse.de>
Date: Tue, 17 Sep 2024 13:40:58 +0300
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 -next 07/11] PCI: brcmstb: Avoid turn off of bridge
 reset
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
References: <20240910151845.17308-1-svarbanov@suse.de>
 <20240910151845.17308-8-svarbanov@suse.de>
 <b41afb62-8a89-4c9d-8462-f4c5574eac7a@broadcom.com>
Content-Language: en-US
From: Stanimir Varbanov <svarbanov@suse.de>
In-Reply-To: <b41afb62-8a89-4c9d-8462-f4c5574eac7a@broadcom.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[21];
	ARC_NA(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[linutronix.de,kernel.org,gmail.com,google.com,linux.com,pengutronix.de,suse.com,raspberrypi.com];
	RCVD_COUNT_TWO(0.00)[2];
	TAGGED_RCPT(0.00)[dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email,suse.de:mid]
X-Spam-Score: -2.80
X-Spam-Flag: NO



On 9/10/24 20:03, Florian Fainelli wrote:
> On 9/10/24 08:18, Stanimir Varbanov wrote:
>> On brcm_pcie_turn_off avoid shutdown of bridge reset.
>>
>> Signed-off-by: Stanimir Varbanov <svarbanov@suse.de>
>> ---
>>   drivers/pci/controller/pcie-brcmstb.c | 14 ++++++++++++--
>>   1 file changed, 12 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/pci/controller/pcie-brcmstb.c
>> b/drivers/pci/controller/pcie-brcmstb.c
>> index d78f33b33884..185ccf7fe86a 100644
>> --- a/drivers/pci/controller/pcie-brcmstb.c
>> +++ b/drivers/pci/controller/pcie-brcmstb.c
>> @@ -234,10 +234,17 @@ struct inbound_win {
>>       u64 cpu_addr;
>>   };
>>   +/*
>> + * Shutting down this bridge on pcie1 means accesses to rescal block
>> + * will hang the chip if another RC wants to assert/deassert rescal.
>> + */
> 
> Maybe a slightly more detailed comment saying that the RESCAL block is
> tied to PCIe controller #1, regardless of the number of controllers, and
> turning off PCIe controller #1 prevents access to the RESCAL register
> blocks, therefore not other controller can access this register space,
> and depending upon the bus fabric we may get a timeout (UBUS/GISB), or a
> hang (AXI).

Ack. Thank you!

regards,
~Stan

