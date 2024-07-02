Return-Path: <linux-pci+bounces-9584-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ADF7C923B0B
	for <lists+linux-pci@lfdr.de>; Tue,  2 Jul 2024 12:05:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D10DD1C21281
	for <lists+linux-pci@lfdr.de>; Tue,  2 Jul 2024 10:05:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC74F14F9FA;
	Tue,  2 Jul 2024 10:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="mjk0hAPn";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="kAuK0Vrs";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="mjk0hAPn";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="kAuK0Vrs"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52ED27F47B;
	Tue,  2 Jul 2024 10:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719914724; cv=none; b=Mo8R6LjMAENtwC8wjlbaOPuLLhEgnHax8BsxLNWKAckP+2KK14edtQCeC5r8sfooVjteKGX+cw+GWdmPViOuCUtKe2Ve7d4AEypypGIdbun8A4T6StRrNfngIreAuOIQ5RETmJJq7G/WKV7aQZl2v3t2YrQUHEA71kaNtqtq35U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719914724; c=relaxed/simple;
	bh=mhOJZW7Zk/WukhprJ5A7RkP8chUJyL8pjmf42EkjSZY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mX49hyC66vgUO1ie031BugyRD95hRW8Q31Z2h93bzT+Btme7tYbDGXYUyZT5JCeqLMo6aLWDsXEhEPaWs+U7u4w6UoZH3kB26eFIYunDEJ10Ev0I8NwmRFKf4RxTcrKD8tZLwRBnrm33yiS4iSuNV8efNx6/hfLjgvrIJz4B01Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=mjk0hAPn; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=kAuK0Vrs; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=mjk0hAPn; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=kAuK0Vrs; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 46B752199A;
	Tue,  2 Jul 2024 10:05:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1719914721; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VT/A0LJZ/LMX/rqyuXqUDapR9hC/2J9IlVs+gBCcdC8=;
	b=mjk0hAPnNv1wryFP+AJU02jxDou69zJVzAWsLACvtVQyy7srL/U3dDS0u1gn28cIz54AGW
	BTmoALSKK/08C8ZBJqnsgrSVPYtIQXdN7Tpd93ZYi7rWOdnX3oT5/Tv1bIAueoCCf5EuXG
	D0RFCq1kIbvUlIy9q+2g1RiuucxMY9Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1719914721;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VT/A0LJZ/LMX/rqyuXqUDapR9hC/2J9IlVs+gBCcdC8=;
	b=kAuK0VrsYMQy54aX0Hf+1pLSDte8Z4KNso4lHVagnSivX+RBTzCkz8q+b67iiNDO2Cbt3W
	kSINNIZ2+QGBTWBQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=mjk0hAPn;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=kAuK0Vrs
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1719914721; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VT/A0LJZ/LMX/rqyuXqUDapR9hC/2J9IlVs+gBCcdC8=;
	b=mjk0hAPnNv1wryFP+AJU02jxDou69zJVzAWsLACvtVQyy7srL/U3dDS0u1gn28cIz54AGW
	BTmoALSKK/08C8ZBJqnsgrSVPYtIQXdN7Tpd93ZYi7rWOdnX3oT5/Tv1bIAueoCCf5EuXG
	D0RFCq1kIbvUlIy9q+2g1RiuucxMY9Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1719914721;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VT/A0LJZ/LMX/rqyuXqUDapR9hC/2J9IlVs+gBCcdC8=;
	b=kAuK0VrsYMQy54aX0Hf+1pLSDte8Z4KNso4lHVagnSivX+RBTzCkz8q+b67iiNDO2Cbt3W
	kSINNIZ2+QGBTWBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5625913A9A;
	Tue,  2 Jul 2024 10:05:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Hmt0EuDQg2Z0OgAAD6G6ig
	(envelope-from <svarbanov@suse.de>); Tue, 02 Jul 2024 10:05:20 +0000
Message-ID: <34701ce5-4f35-463d-a2d2-5144a20aaf0f@suse.de>
Date: Tue, 2 Jul 2024 13:05:15 +0300
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/7] Add PCIe support for bcm2712
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
References: <20240626104544.14233-1-svarbanov@suse.de>
 <5bbf813f-9a7b-467b-a2c7-6bc21ea85ef8@broadcom.com>
Content-Language: en-US
From: Stanimir Varbanov <svarbanov@suse.de>
In-Reply-To: <5bbf813f-9a7b-467b-a2c7-6bc21ea85ef8@broadcom.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 46B752199A
X-Spam-Score: -3.00
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-3.00 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
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
	FREEMAIL_CC(0.00)[linutronix.de,kernel.org,gmail.com,google.com,linux.com,pengutronix.de,suse.com,raspberrypi.com];
	RCVD_TLS_ALL(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
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
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org

Hi Florian,

On 6/26/24 14:31, Florian Fainelli wrote:
> Hi,
> 
> On 26/06/2024 11:45, Stanimir Varbanov wrote:
>> This patchset aims to add bare minimum support for bcm2712
>> in brcmstb PCIe driver needed to support the peripherals from
>> RP1 south-bridge found in RPi5. In order to support RP1
>> PCIe endpoint peripherals a new interrupt controller is added.
>> The interrupt controller supports 64 interrupt sources which
>> are enough to handle 61 RP1 peripherals.
>>
>> Patch 1 is adding DT binding schema for the MIP interrupt
>> controller, patch 2 is adding relevant changes for PCIe
>> bcm2712 in yaml. Patch 3 adds MIP intterrupt cotroller driver.
>> Patches 4 and 5 are preparations for adding bcm2712 support in 6.
>> The last patch updates bcm2712 .dsti by adding pcie DT nodes.
>>
>> Few concerns about the implementation:
>>   - the connection between MIP interrupt-controller and PCIe RC is
>>     done through BAR1. The PCIe driver is parsing the msi_parent
>>     DT property in order to obtain few private DT properties like
>>     "brcm,msi-pci-addr" and "reg". IMO this looks hackish but I failed
>>     to find something better. Ideas?
>>
>>   - in downstream RPi kernel "ranges" and "dma-ranges" DT properties
>>     are under an axi {} simple-bus node even that PCIe block is on CPU
>>     MMIO bus. I tried to merge axi {} in soc {} and the result could be
>>     seen on the last patch in this series, but I'm still not sure that
>>     it looks good enough.
>>
>> This series has been functionally tested on OpenSUSE Tumbleweed with
>> downstream RP1 south-bridge PCIe endpoint driver implementation as
>> MFD by using ethernet which is part of it.
>>
>> The series is based on Andrea's "Add minimal boot support for
>> Raspberry Pi 5"
>> series.
>>
>> Comments are welcome!
> 
> We are just about submitting support for 7712 which is the sister chip
> of 2712 and requires similar, if not identical types of changes to
> pcie-brcmstb.c, would you mind reviewing that patch series when it gets
> posted by Jim in the next few days, and base yours upon that one? It

Sure, I'll review bcm7712 series and rebase bcm2712 on top of it.

> does separate changes in a more atomic and a more reviewer friendly
> rather than having one big commit modifying pcie-brcmstb.c

Agreed.

> 
> Thanks.

~Stan

