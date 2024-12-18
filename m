Return-Path: <linux-pci+bounces-18708-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F6229F6925
	for <lists+linux-pci@lfdr.de>; Wed, 18 Dec 2024 15:55:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 41CE51885804
	for <lists+linux-pci@lfdr.de>; Wed, 18 Dec 2024 14:55:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8DAA1A23A3;
	Wed, 18 Dec 2024 14:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="nLw8h69j";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="uUw7S3vo";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="dM9Qe0DI";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="pk8iodLn"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5F0F7F48C;
	Wed, 18 Dec 2024 14:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734533702; cv=none; b=jDr8e84EfIvwj3R81pS0pwSfmiCA9XTpc8VWcD7bYoBHocnw/5KAS/2G42e3suakmeRXsO1dxsiV3YOgtBOx4A2qqdyckMEPyt//HiklLwBrkKGsYAotEnAbU7Ya80Rlt4H9GJXZLAGJ88xuaLZ8bHvhS/6rei2XKZ97q7/Vr/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734533702; c=relaxed/simple;
	bh=Bw3gOzzYvZZenGXcoFLjQciNc4lHifww2u4KEkAm9ng=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TrZKLMsLrigan1pKv7nkggbYhAXs7qRQ2zfN/0T7xuaMBmvhXG0U0Umc4NdWm100auBaXQvPv3gVzMRGH+4NRvv2Nwhl2HpIca4KyD0G9IYnCWtbz7x/tC0OTCc6xkvIAVt+0bdVisjglDVfoP/iGlwcvk7KIK/Jfm1z291c2Io=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=nLw8h69j; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=uUw7S3vo; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=dM9Qe0DI; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=pk8iodLn; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id EA0641F396;
	Wed, 18 Dec 2024 14:54:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1734533699; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RSUvcPI018AyiYq0gf2zMQGKhtDHBCTfLKLQONj0Wp4=;
	b=nLw8h69jQSs/wwYlBKzAhjAKDJsO1bLO9Q9IO6dsc72muSn1eh0CIUeAcS/AYTytb4Y5HI
	ZTYP1iXAbwLFFphFO+jfXpgN2MfNgznvrkci5QWYGKjsFOcJReY6mm985Y8u5VBuMcl8U3
	+qTkv+HHR0obtEyOuDhTiJDb1o8rkkI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1734533699;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RSUvcPI018AyiYq0gf2zMQGKhtDHBCTfLKLQONj0Wp4=;
	b=uUw7S3vorA9/0YRDvlqeCc0qO67wZmrRY/xlkdXc2699/Pkbc8fm1Ltevw9X43MXrCNCXR
	ZVFRAnhNtBsrLDDQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1734533698; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RSUvcPI018AyiYq0gf2zMQGKhtDHBCTfLKLQONj0Wp4=;
	b=dM9Qe0DIpJSARNJrDvBuzSgO0bgfueBzYlwceOCeVuyrP92xL6ubsvinC60utfSvaQ7lkP
	yNPoBtIb1W4feXKJi2g3ij7u8lZe03SkfYKEFRsCMEpln1JtMeD7OD5eOCmWKe5G/6c5WD
	ESo2u+OEmwtcjUkYuwZex/TgqbOYyM4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1734533698;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RSUvcPI018AyiYq0gf2zMQGKhtDHBCTfLKLQONj0Wp4=;
	b=pk8iodLnGP7TsrZ7nZNMGc4TIue8FWuwgxgAYvMNSb5bNkTTKbqnWRhwJyisjaAZzmc0Rz
	qFOjZjy6xJvU0KCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 01187137CF;
	Wed, 18 Dec 2024 14:54:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id kG/9OEHiYmfBLAAAD6G6ig
	(envelope-from <svarbanov@suse.de>); Wed, 18 Dec 2024 14:54:57 +0000
Message-ID: <ab136131-a306-4344-adaf-904e3b32326e@suse.de>
Date: Wed, 18 Dec 2024 16:54:57 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 06/10] PCI: brcmstb: Enable external MSI-X if available
To: James Quinlan <james.quinlan@broadcom.com>,
 Stanimir Varbanov <svarbanov@suse.de>, linux-kernel@vger.kernel.org,
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
 <f0a734d9-6bf6-4d28-b30b-99b6be9f62dc@broadcom.com>
Content-Language: en-US
From: Stanimir Varbanov <svarbanov@suse.de>
In-Reply-To: <f0a734d9-6bf6-4d28-b30b-99b6be9f62dc@broadcom.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Score: -2.80
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
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
	FREEMAIL_CC(0.00)[linutronix.de,kernel.org,broadcom.com,gmail.com,google.com,linux.com,pengutronix.de,suse.com,raspberrypi.com];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid,suse.de:email]
X-Spam-Flag: NO
X-Spam-Level: 

Hi Jim,

Thanks for comments!

On 12/11/24 10:01 PM, James Quinlan wrote:
> On 10/25/24 08:45, Stanimir Varbanov wrote:
>> On RPi5 there is an external MIP MSI-X interrupt controller
>> which can handle up to 64 interrupts.
>>
>> Signed-off-by: Stanimir Varbanov <svarbanov@suse.de>
>> ---
>> v3 -> v4:
>>   - no changes.
>>
>>   drivers/pci/controller/pcie-brcmstb.c | 63 +++++++++++++++++++++++++--
>>   1 file changed, 59 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/
>> controller/pcie-brcmstb.c
>> index c01462b07eea..af01a7915c94 100644
>> --- a/drivers/pci/controller/pcie-brcmstb.c
>> +++ b/drivers/pci/controller/pcie-brcmstb.c
>> @@ -1318,6 +1318,52 @@ static int brcm_pcie_start_link(struct
>> brcm_pcie *pcie)
>>       return 0;
>>   }
>>   +static int brcm_pcie_enable_external_msix(struct brcm_pcie *pcie,
>> +                      struct device_node *msi_np)
>> +{
>> +    struct inbound_win inbound_wins[PCIE_BRCM_MAX_INBOUND_WINS];
>> +    u64 msi_pci_addr, msi_phys_addr;
>> +    struct resource r;
>> +    int mip_bar, ret;
>> +    u32 val, reg;
>> +
>> +    ret = of_property_read_reg(msi_np, 1, &msi_pci_addr, NULL);
>> +    if (ret)
>> +        return ret;
>> +
>> +    ret = of_address_to_resource(msi_np, 0, &r);
>> +    if (ret)
>> +        return ret;
>> +
>> +    msi_phys_addr = r.start;
>> +
>> +    /* Find free inbound window for MIP access */
>> +    mip_bar = brcm_pcie_get_inbound_wins(pcie, inbound_wins);
>> +    if (mip_bar < 0)
>> +        return mip_bar;
>> +
>> +    mip_bar += 1;
>> +    reg = brcm_bar_reg_offset(mip_bar);
>> +
>> +    val = lower_32_bits(msi_pci_addr);
>> +    val |= brcm_pcie_encode_ibar_size(SZ_4K);
>> +    writel(val, pcie->base + reg);
>> +
>> +    val = upper_32_bits(msi_pci_addr);
>> +    writel(val, pcie->base + reg + 4);
>> +
>> +    reg = brcm_ubus_reg_offset(mip_bar);
>> +
>> +    val = lower_32_bits(msi_phys_addr);
>> +    val |= PCIE_MISC_UBUS_BAR1_CONFIG_REMAP_ACCESS_EN_MASK;
>> +    writel(val, pcie->base + reg);
>> +
>> +    val = upper_32_bits(msi_phys_addr);
>> +    writel(val, pcie->base + reg + 4);
> 
> Hi Stan,
> 
> It looks like all this is doing is setting up an identity-mapped inbound
> window, is that correct?  If so, couldn't you get the same effect by
> adding an identity-mapped dma-range in the PCIe DT node?

Yes, that approach could work, I verified it.

Do you want me to drop this patch from the series and make the relevant
changes in PCIe dma-ranges properties?

~Stan




