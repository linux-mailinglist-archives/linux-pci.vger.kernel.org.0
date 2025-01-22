Return-Path: <linux-pci+bounces-20244-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BE04CA19662
	for <lists+linux-pci@lfdr.de>; Wed, 22 Jan 2025 17:21:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 77737188E037
	for <lists+linux-pci@lfdr.de>; Wed, 22 Jan 2025 16:21:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14790214A78;
	Wed, 22 Jan 2025 16:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="SDhspgNc";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="mfVXxY3G";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="SDhspgNc";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="mfVXxY3G"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D92F212B31;
	Wed, 22 Jan 2025 16:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737562848; cv=none; b=jypVVTfZjiEGnYRZ6VsoL3D8AcSzOE0Gc3YCUQoTGQC1T00bsqb9nM6rHmJBLg5JhYhEqz7eCsLhgtTJQgYGECIIkNOv/bvXE3ccluzlK11Vv7EsreVJOcCS0yEjLZcmEblg48B/faKRKDZNRwZO4KME1dSSHqJat89vwpKXX88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737562848; c=relaxed/simple;
	bh=8kM1WT3JNMGSU/cpmSYMoaF35HG8obeAnI8FcsETn5U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i2avY38tbkUp/PlWvPl+DuqhB6TwMH5D7XZTJWKq1bKScssbgSbZbHdftQFSdAjsOh2hRHY3C2Remjdb97bmTNAdtHs2muFI8wBiL+aYi1cfiMl7DalEQRJPgGeumaj5XdlE2vgYVa2dZyfrxb1GXIipbzgVKqyrMGr8fo7lKMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=SDhspgNc; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=mfVXxY3G; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=SDhspgNc; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=mfVXxY3G; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 49CF82190B;
	Wed, 22 Jan 2025 16:20:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1737562844; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nT+3HrKcZdya7PD/09X6ml+wR0vuTCRq8jZf0/rfslA=;
	b=SDhspgNc7hac5Pfg4OaVGvMwWVz4pD9JP45vdS1rNrueqTsfn5MG13bTpsCjQuq/91Ehi2
	XBpuiWWz6n8VTAXfHCntT1UAVZY0x10M4n9v/s3Aqobp4g/JaCUDqqJiUd0yxS4/HdZbOx
	htz2Ai6adwmXfHI5nisC7H+KkcpNeSY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1737562844;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nT+3HrKcZdya7PD/09X6ml+wR0vuTCRq8jZf0/rfslA=;
	b=mfVXxY3GXJjQJ0ox3IMljoELLK445aGMa2UoEAxVkDlispsSjgekkQJx5Mat4Mq0nEt/fF
	t4NZXvP2oVrWxgCw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1737562844; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nT+3HrKcZdya7PD/09X6ml+wR0vuTCRq8jZf0/rfslA=;
	b=SDhspgNc7hac5Pfg4OaVGvMwWVz4pD9JP45vdS1rNrueqTsfn5MG13bTpsCjQuq/91Ehi2
	XBpuiWWz6n8VTAXfHCntT1UAVZY0x10M4n9v/s3Aqobp4g/JaCUDqqJiUd0yxS4/HdZbOx
	htz2Ai6adwmXfHI5nisC7H+KkcpNeSY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1737562844;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nT+3HrKcZdya7PD/09X6ml+wR0vuTCRq8jZf0/rfslA=;
	b=mfVXxY3GXJjQJ0ox3IMljoELLK445aGMa2UoEAxVkDlispsSjgekkQJx5Mat4Mq0nEt/fF
	t4NZXvP2oVrWxgCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3CF7A136A1;
	Wed, 22 Jan 2025 16:20:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Lwp/DNsakWexcQAAD6G6ig
	(envelope-from <svarbanov@suse.de>); Wed, 22 Jan 2025 16:20:43 +0000
Message-ID: <d8c0f79f-1896-4afa-86e3-bd330218f362@suse.de>
Date: Wed, 22 Jan 2025 18:20:38 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 -next 09/11] PCI: brcmstb: Fix for missing of_node_put
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
 Phil Elwell <phil@raspberrypi.com>, Jonathan Bell
 <jonathan@raspberrypi.com>, Dave Stevenson <dave.stevenson@raspberrypi.com>,
 stable@vger.kernel.org
References: <20250120130119.671119-1-svarbanov@suse.de>
 <20250120130119.671119-10-svarbanov@suse.de>
 <1abdd175-280a-442a-a27a-9bc01c0a04c0@broadcom.com>
Content-Language: en-US
From: Stanimir Varbanov <svarbanov@suse.de>
In-Reply-To: <1abdd175-280a-442a-a27a-9bc01c0a04c0@broadcom.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-6.80 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[linutronix.de,kernel.org,gmail.com,google.com,linux.com,pengutronix.de,suse.com,raspberrypi.com,vger.kernel.org];
	RCVD_TLS_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TAGGED_RCPT(0.00)[dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email,suse.de:mid]
X-Spam-Score: -6.80
X-Spam-Flag: NO

Hi Florian,

On 1/21/25 8:32 PM, Florian Fainelli wrote:
> On 1/20/25 05:01, Stanimir Varbanov wrote:
>> A call to of_parse_phandle() increments refcount, of_node_put must be
>> called when done the work on it. Fix missing of_node_put() on the
>> msi_np device node by using scope based of_node_put() cleanups.
>>
>> Cc: stable@vger.kernel.org # v5.10+
>> Fixes: 40ca1bf580ef ("PCI: brcmstb: Add MSI support")
>> Signed-off-by: Stanimir Varbanov <svarbanov@suse.de>
>> ---
>> v4 -> v5:
>>   - New patch in the series.
>>
>>   drivers/pci/controller/pcie-brcmstb.c | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/
>> controller/pcie-brcmstb.c
>> index 744fe1a4cf9c..546056f7f0d3 100644
>> --- a/drivers/pci/controller/pcie-brcmstb.c
>> +++ b/drivers/pci/controller/pcie-brcmstb.c
>> @@ -1844,7 +1844,8 @@ static struct pci_ops brcm7425_pcie_ops = {
>>     static int brcm_pcie_probe(struct platform_device *pdev)
>>   {
>> -    struct device_node *np = pdev->dev.of_node, *msi_np;
>> +    struct device_node *msi_np __free(device_node) = NULL;
> 
> In the interest of making this a straight back port to 5.10 that does
> not have all of the __free() goodies, I would just add the missing
> of_node_put() where necessary.

Good point. Thank you.

> 
> Also, since this is a bug fix, you should probably make it appear
> earlier in the patch series, or even sent it as a separate fix entirely.

OK, will send it as a standalone patch (as v2 with your comment addressed).

~Stan


