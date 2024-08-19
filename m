Return-Path: <linux-pci+bounces-11842-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 79FD5957496
	for <lists+linux-pci@lfdr.de>; Mon, 19 Aug 2024 21:39:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CC999B22C8A
	for <lists+linux-pci@lfdr.de>; Mon, 19 Aug 2024 19:39:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 045441D6187;
	Mon, 19 Aug 2024 19:39:23 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 029D81D54E0;
	Mon, 19 Aug 2024 19:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724096362; cv=none; b=FyrSbrYRbWrM4ZVzV1FFjQlLAcWjA41/T0sn6wUt+2ayyNKnoTv7I113idyzaSNb0K5VMJfKlzCYLFTenhHmTCMj/vW2bDeZ+pwY+15zip8dVVyEGOrfCtCIXMmrI/gu3Z7hER7Vt/MA5g6MU8chmqR0cEMWe8/hdwu1puINCi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724096362; c=relaxed/simple;
	bh=BomMNfY2iAiew9cnUbgviJ5TZayWl5/YovaQf6MYUls=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kfBJiGBTg00Pv0m0pc65dFXnON4GiWC66sBjnfn9Tyi4J8BDNMiHxCQkvfv5yajMDUeEMy9/CnJAuLLlOb06MKGrNOX3Hx3IhKcAreLiTg6YRllYbPma/4ANGwjTPNdzWlgbr6STJ0n3sp4iyfInqdYl/5vrsardMe1cMeegIS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 233392276E;
	Mon, 19 Aug 2024 19:39:19 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3BAE3137C3;
	Mon, 19 Aug 2024 19:39:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id RXvTC2afw2bPYAAAD6G6ig
	(envelope-from <svarbanov@suse.de>); Mon, 19 Aug 2024 19:39:18 +0000
Message-ID: <76b528f8-88e2-4954-94cf-7e0933b4ad03@suse.de>
Date: Mon, 19 Aug 2024 22:39:13 +0300
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 05/13] PCI: brcmstb: Use bridge reset if available
To: Jim Quinlan <james.quinlan@broadcom.com>,
 Stanimir Varbanov <svarbanov@suse.de>
Cc: linux-pci@vger.kernel.org, Nicolas Saenz Julienne <nsaenz@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Cyril Brulebois <kibi@debian.org>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Krzysztof Kozlowski <krzk@kernel.org>,
 bcm-kernel-feedback-list@broadcom.com, jim2101024@gmail.com,
 Florian Fainelli <florian.fainelli@broadcom.com>,
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
 <1a6d6972-f2db-4d44-b79c-811ba44368f0@suse.de>
 <CA+-6iNxFotwXW4Cc31daT+KwE_LEdAR=pcpsg_3Ng0ep1vYLBA@mail.gmail.com>
Content-Language: en-US
From: Stanimir Varbanov <svarbanov@suse.de>
In-Reply-To: <CA+-6iNxFotwXW4Cc31daT+KwE_LEdAR=pcpsg_3Ng0ep1vYLBA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Spam-Flag: NO
X-Spam-Score: -4.00
X-Rspamd-Queue-Id: 233392276E
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Level: 

Hi Jim,

On 8/19/24 21:09, Jim Quinlan wrote:
> On Sat, Aug 17, 2024 at 1:41 PM Stanimir Varbanov <svarbanov@suse.de> wrote:
>>
>> Hi Jim,
>>
>> On 8/16/24 01:57, Jim Quinlan wrote:
>>> The 7712 SOC has a bridge reset which can be described in the device tree.
>>> Use it if present.  Otherwise, continue to use the legacy method to reset
>>> the bridge.
>>>
>>> Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>
>>> ---
>>>  drivers/pci/controller/pcie-brcmstb.c | 24 +++++++++++++++++++-----
>>>  1 file changed, 19 insertions(+), 5 deletions(-)
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
>>         resets = <&bcm_reset 5>, <&bcm_reset 42>, <&pcie_rescal>;
>>         reset-names = "swinit", "bridge", "rescal";
>>
>> pcie1 @ 110000:
>>         resets = <&bcm_reset 7>, <&bcm_reset 43>, <&pcie_rescal>;
>>         reset-names = "swinit", "bridge", "rescal";
>>
>> pcie2 @ 120000:
>>         resets = <&bcm_reset 9>, <&bcm_reset 44>, <&pcie_rescal>;
>>         reset-names = "swinit", "bridge", "rescal";
>>
>>
>> I changed "swinit" reset for pcie2 to <&bcm_reset 9> (it is 32 in
>> downstream rpi kernel) because otherwise I'm unable to enumerate RP1
>> south bridge at all.
>>
>> Any help will be appreciated.
> 
> Hi Stan,
> Let me look into this.  Why is one of the controllers turning off --
> is it not populated with a device?

Yes, I enabled pcie1 but no PCI endpoint devices attached on the
expansion connector.

> 
> As you probably know the 7712 only has access to PCIe1.  But we do
> have another chip with two controllers and I will try to reproduce
> your failure and get to the bottom of it.

Thank you for the help.

~Stan

> 
> Regards,
> Jim Quinlan
> Broadcom STB/CM
>>
>> ~Stan
>>
>> [1]
>> https://github.com/raspberrypi/linux/blob/rpi-6.11.y/drivers/pci/controller/pcie-brcmstb.c#L1711

