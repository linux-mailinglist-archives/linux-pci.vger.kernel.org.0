Return-Path: <linux-pci+bounces-11907-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1526C959145
	for <lists+linux-pci@lfdr.de>; Wed, 21 Aug 2024 01:38:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C21EC2823B2
	for <lists+linux-pci@lfdr.de>; Tue, 20 Aug 2024 23:38:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B60015749C;
	Tue, 20 Aug 2024 23:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="nZRY1MRc";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="qah2dklX";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="nZRY1MRc";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="qah2dklX"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F80414A4F0;
	Tue, 20 Aug 2024 23:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724197093; cv=none; b=f4/wwJbJG5L37s6K0OlMBG96OC97LtVzMVYJLfQzlGKt0G+Ywp5fmr97fYAeiFdyOoBF5KWYWOLPeHlnzrk7HAsRMSOwvzd8X0raDenc3U3/O2c/Z1A3WYsKFGs10QXF21gKSkPP474hLOe1JhmnqiReV/5QujbviFmTT9qWHfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724197093; c=relaxed/simple;
	bh=vfojRWFLi+4W9W7J/pnwkzPO4mn3DQn3TtlWP1FYGi0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Zu2YshGqUKBYjZZhMU6G5AMdkaKUrKcb3W3iaz7aH78aXepVjYwnkr4WZC5RZmFBGw8RxCkgfbhaDbLwtJ60sBv/dgTSuxdcpOH13iODd6lHrpcN9A9rDen2a75qsd8NZL+TYIKsjYru/ttjlxBce92GkzI2dQtm/3n/0wFebos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=nZRY1MRc; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=qah2dklX; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=nZRY1MRc; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=qah2dklX; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 368641FD5E;
	Tue, 20 Aug 2024 23:38:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1724197089; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1A2gbeRIWHzClVGEu4ZdxEfV/uStl0vp0MvsG0fNmso=;
	b=nZRY1MRcJMR0u+f2z51Ah7x5E7VjPji+94XO2q3llZWA5glpM2NhtbgVzpwwfQie1xNLQe
	ciqVsyFQmp5sqadireoWPKsY8TZ+1LJGW56Zk1EOUswcy2AyGRZo+5z/Q/60GVTr53R3JK
	2cL8H8uHQ7VAz3UfF5EIzmIYBKf4HGU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1724197089;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1A2gbeRIWHzClVGEu4ZdxEfV/uStl0vp0MvsG0fNmso=;
	b=qah2dklXJJ15qfTheO947F/rkT1b0jF/XWtHMnXqtQKchjuGcxCYARZhIAcvYcuip2V+oW
	kWlLyKTlgpikSxAw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=nZRY1MRc;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=qah2dklX
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1724197089; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1A2gbeRIWHzClVGEu4ZdxEfV/uStl0vp0MvsG0fNmso=;
	b=nZRY1MRcJMR0u+f2z51Ah7x5E7VjPji+94XO2q3llZWA5glpM2NhtbgVzpwwfQie1xNLQe
	ciqVsyFQmp5sqadireoWPKsY8TZ+1LJGW56Zk1EOUswcy2AyGRZo+5z/Q/60GVTr53R3JK
	2cL8H8uHQ7VAz3UfF5EIzmIYBKf4HGU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1724197089;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1A2gbeRIWHzClVGEu4ZdxEfV/uStl0vp0MvsG0fNmso=;
	b=qah2dklXJJ15qfTheO947F/rkT1b0jF/XWtHMnXqtQKchjuGcxCYARZhIAcvYcuip2V+oW
	kWlLyKTlgpikSxAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6371F13A17;
	Tue, 20 Aug 2024 23:38:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ePQXFuAoxWanNgAAD6G6ig
	(envelope-from <svarbanov@suse.de>); Tue, 20 Aug 2024 23:38:08 +0000
Message-ID: <51eff793-2b72-4e1c-a86e-149f17d08279@suse.de>
Date: Wed, 21 Aug 2024 02:38:07 +0300
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 05/13] PCI: brcmstb: Use bridge reset if available
To: Florian Fainelli <florian.fainelli@broadcom.com>,
 Stanimir Varbanov <svarbanov@suse.de>,
 Jim Quinlan <james.quinlan@broadcom.com>, linux-pci@vger.kernel.org,
 Nicolas Saenz Julienne <nsaenz@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Cyril Brulebois <kibi@debian.org>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Krzysztof Kozlowski <krzk@kernel.org>,
 bcm-kernel-feedback-list@broadcom.com, jim2101024@gmail.com
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 Rob Herring <robh@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>,
 "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE"
 <linux-rpi-kernel@lists.infradead.org>,
 "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>,
 open list <linux-kernel@vger.kernel.org>
References: <20240815225731.40276-1-james.quinlan@broadcom.com>
 <20240815225731.40276-6-james.quinlan@broadcom.com>
 <1a6d6972-f2db-4d44-b79c-811ba44368f0@suse.de>
 <2fb74b23-a862-4b1c-b1e1-a3e3abc4571b@broadcom.com>
Content-Language: en-US
From: Stanimir Varbanov <svarbanov@suse.de>
In-Reply-To: <2fb74b23-a862-4b1c-b1e1-a3e3abc4571b@broadcom.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 368641FD5E
X-Spam-Level: 
X-Spamd-Result: default: False [-6.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	DWL_DNSWL_MED(-2.00)[suse.de:dkim];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	FREEMAIL_TO(0.00)[broadcom.com,suse.de,vger.kernel.org,kernel.org,google.com,arm.com,debian.org,linaro.org,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:dkim,suse.de:mid,broadcom.com:email];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -6.51
X-Spam-Flag: NO

Hi Florian,

On 8/19/24 22:07, Florian Fainelli wrote:
> On 8/17/24 10:41, Stanimir Varbanov wrote:
>> Hi Jim,
>>
>> On 8/16/24 01:57, Jim Quinlan wrote:
>>> The 7712 SOC has a bridge reset which can be described in the device
>>> tree.
>>> Use it if present.  Otherwise, continue to use the legacy method to
>>> reset
>>> the bridge.
>>>
>>> Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>
>>> ---
>>>   drivers/pci/controller/pcie-brcmstb.c | 24 +++++++++++++++++++-----
>>>   1 file changed, 19 insertions(+), 5 deletions(-)
>>
>> Reviewed-by: Stanimir Varbanov <svarbanov@suse.de>
>>
>> One problem though on RPi5 (bcm2712).
>>
>> With this series applied + my WIP patches for enablement of PCIe on
>> bcm2712 when enable the pcie1 and pcie2 root ports in dts, I see kernel
>> boot stuck on pcie2 enumeration and I have to add this [1] to make it
>> work again.
>>
>> Some more info about resets used:
>>
>> pcie0 @ 100000:
>>     resets = <&bcm_reset 5>, <&bcm_reset 42>, <&pcie_rescal>;
>>     reset-names = "swinit", "bridge", "rescal";
>>
>> pcie1 @ 110000:
>>     resets = <&bcm_reset 7>, <&bcm_reset 43>, <&pcie_rescal>;
>>     reset-names = "swinit", "bridge", "rescal";
>>
>> pcie2 @ 120000:
>>     resets = <&bcm_reset 9>, <&bcm_reset 44>, <&pcie_rescal>;
>>     reset-names = "swinit", "bridge", "rescal"; >
>>
>> I changed "swinit" reset for pcie2 to <&bcm_reset 9> (it is 32 in
>> downstream rpi kernel) because otherwise I'm unable to enumerate RP1
>> south bridge at all.
> 
> The value 9 is unused, so I suppose it does not really hurt to use it,
> but it is also unlikely to achieve what you desire. 32 is the correct
> value since pcie2_sw_init is bit 0 within SW_INIT_1 (second bank of
> resets).

Good to know that 9 is not the proper reset line, thank you.

Unfortunately, I'm unable to make it work with the proper reset line (32).

> 
> The file link you provided appears to be lacking support for the
> "swinit" reset line, is that intentional? I don't think you can assume

No idea why downstream RPi kernel does not use swinit reset.

> this will work without.

If I do not populate swinit in PCIe DT node it works i.e. PCI
enumeration is working and RP1 south-bridge is functional.

~Stan

