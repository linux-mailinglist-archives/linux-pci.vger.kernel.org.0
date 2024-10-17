Return-Path: <linux-pci+bounces-14752-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EAEB9A1C94
	for <lists+linux-pci@lfdr.de>; Thu, 17 Oct 2024 10:09:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8FBCCB239E5
	for <lists+linux-pci@lfdr.de>; Thu, 17 Oct 2024 08:09:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CD911D1E64;
	Thu, 17 Oct 2024 08:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="cFY05F3A";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Q7jAAyXh";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="SvL/xg5m";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="S3nudW/7"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E34751C1AB5;
	Thu, 17 Oct 2024 08:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729152356; cv=none; b=BLHpEIlpcTpP0Q1UBE0FUFeLt4zgIjBRFd34oWgIIyXnRMXf/lbGbYWYfljrRRasix8DaCrs7HSIAcGCJUgtWJFqFNkFYZKlUwe1pbR8mmNvqI54l0NDlAIftFGMT1M+XAj+e4ksOY0yvcJyh54hUeoXWGg8y3MvH3zoGC/WyvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729152356; c=relaxed/simple;
	bh=GXJMVyFELub+vdQLJcy+oGUeVVcTIu+YTDM23hkd3CE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Nd2rTBzstFnW771BsIFmEDeB7Letk4SvunxJaDweUsDgAT+8ZxqZFzHCIwkLO32vco/cpmT82/fDz7hFaQLEwyVDO37Df1kLVn3fupMR7y0j9W+LMjwoh1yMJx4+6cYG1uxw6gZZme6/S94evgAVQfOIAo8rRWYzG4n4cGbpzFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=cFY05F3A; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Q7jAAyXh; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=SvL/xg5m; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=S3nudW/7; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id EBEDD1F88F;
	Thu, 17 Oct 2024 08:05:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1729152351; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=X8FGyRrg5NXMlwUjlKAiy/xJZRw8FDMkvWHXVincjfY=;
	b=cFY05F3AK6V0Ppa7cc9hMCsGr0F5FB6kl2qbtkZNaKtAueLJU8fyN5tHaYk+LRB813DHK3
	PvGQKdKiGW3xkTxh6Kv6/+R+jvj/wuYT8obuBbUOmSev8sxSvEG7COj80A/tbT7UD5a1Ti
	wCzd+VDHQmSg6HLagpainiTqJEljE5E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1729152351;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=X8FGyRrg5NXMlwUjlKAiy/xJZRw8FDMkvWHXVincjfY=;
	b=Q7jAAyXhJYB6Qa/4DRorKsSiwi/66ya1zbFHf0cRs3xauMO3Hz8t66TWjDssuIVyCaBoA3
	gDonh2PnqEP68ZCQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="SvL/xg5m";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="S3nudW/7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1729152350; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=X8FGyRrg5NXMlwUjlKAiy/xJZRw8FDMkvWHXVincjfY=;
	b=SvL/xg5mHNGm7BSlfjqukmxyPfZokjmuUANQJqZcLEYV0WmO45LzZ6B8P3EH8xYHmSbM2j
	umhA3TZWOVMlJ0TcJjQqJzqCSlPNxg/6JuuinwaJL0uV9xNqMPonJo2IdZb5RKdH4Ci/iN
	V9v/ccJ+QR/MdcrW1uU5cfNAHtJyCtE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1729152350;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=X8FGyRrg5NXMlwUjlKAiy/xJZRw8FDMkvWHXVincjfY=;
	b=S3nudW/7nQgPORIo8jRWgrQYZvZJHDQHRFHXEXvPcfj/XzOpU1sy1LYGQClLyw45eO94Vy
	YqPbV/KHl3Ad8sCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F41B013A53;
	Thu, 17 Oct 2024 08:05:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id qu1mM13FEGc4MQAAD6G6ig
	(envelope-from <svarbanov@suse.de>); Thu, 17 Oct 2024 08:05:49 +0000
Message-ID: <3b3f22e9-2cc8-4c8b-9726-651eb5e75e0d@suse.de>
Date: Thu, 17 Oct 2024 11:05:45 +0300
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 06/11] PCI: brcmstb: Avoid turn off of bridge reset
To: Jim Quinlan <jim2101024@gmail.com>, Stanimir Varbanov <svarbanov@suse.de>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rpi-kernel@lists.infradead.org,
 linux-pci@vger.kernel.org,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Thomas Gleixner
 <tglx@linutronix.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Florian Fainelli <florian.fainelli@broadcom.com>,
 Nicolas Saenz Julienne <nsaenz@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>, kw@linux.com,
 Philipp Zabel <p.zabel@pengutronix.de>,
 Andrea della Porta <andrea.porta@suse.com>,
 Phil Elwell <phil@raspberrypi.com>, Jonathan Bell <jonathan@raspberrypi.com>
References: <20241014130710.413-1-svarbanov@suse.de>
 <20241014130710.413-7-svarbanov@suse.de>
 <CANCKTBt-QAOytUSp6=HcS_SiPD7wSOFdFv2U=4c146uzmdinAQ@mail.gmail.com>
Content-Language: en-US
From: Stanimir Varbanov <svarbanov@suse.de>
In-Reply-To: <CANCKTBt-QAOytUSp6=HcS_SiPD7wSOFdFv2U=4c146uzmdinAQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: EBEDD1F88F
X-Spam-Level: 
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TAGGED_RCPT(0.00)[dt];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com,suse.de];
	MID_RHS_MATCH_FROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:dkim,suse.de:mid,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	RCVD_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.01
X-Spam-Flag: NO

Hi Jim,

On 10/16/24 20:17, Jim Quinlan wrote:
> On Mon, Oct 14, 2024 at 9:07 AM Stanimir Varbanov <svarbanov@suse.de> wrote:
>>
>> On PCIe turn off avoid shutdown of bridge reset,
>> by introducing a quirk flag.
>>
>> Signed-off-by: Stanimir Varbanov <svarbanov@suse.de>
>> ---
>> v2 -> v3:
>>  - Added more descriptive comment on CFG_QUIRK_AVOID_BRIDGE_SHUTDOWN quirk.
>>
>>  drivers/pci/controller/pcie-brcmstb.c | 17 +++++++++++++++--
>>  1 file changed, 15 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
>> index b76c16287f37..757a1646d53c 100644
>> --- a/drivers/pci/controller/pcie-brcmstb.c
>> +++ b/drivers/pci/controller/pcie-brcmstb.c
>> @@ -234,10 +234,20 @@ struct inbound_win {
>>         u64 cpu_addr;
>>  };
>>
>> +/*
>> + * The RESCAL block is tied to PCIe controller #1, regardless of the number of
>> + * controllers, and turning off PCIe controller #1 prevents access to the RESCAL
>> + * register blocks, therefore not other controller can access this register
> 
> s/no/not/
> 
> I assume that the quirks is specific to 2712 as the 7712 does not need
> this since it only has PCIe1
> (I'll probably seethis as I read more of your commits).

Yes, the .post_setup op is implemented for 2712 only. Look into next
patch in the series.

~Stan

