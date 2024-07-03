Return-Path: <linux-pci+bounces-9725-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EDBA926172
	for <lists+linux-pci@lfdr.de>; Wed,  3 Jul 2024 15:10:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AFA671F24D94
	for <lists+linux-pci@lfdr.de>; Wed,  3 Jul 2024 13:09:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 150D517838B;
	Wed,  3 Jul 2024 13:09:57 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D546A17996;
	Wed,  3 Jul 2024 13:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720012197; cv=none; b=WqUpMWXgVsEQTZs9CE7mZ3DhngjqO75/tpoYGjOUJTphgxMb1032szhxGsBq3gG5lfmch9Cu5fPVng1RqvYno7aHztGulTdCHrrlTl6Se6m9viUV+aKOG+ubed9JjvwuTr0LEnXMbWGRO5hqyIWFXelsPDLU8MAoDyiT5LDhkcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720012197; c=relaxed/simple;
	bh=4knqHiokeW7MXs2sFDlxEP0aOTgB/CsZK7QCpjNnAyU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aZxQhvVZx6ar66ZG1m1TLHWMJbyvH4Cj4mlAlpXptKBRazNTtJl5pi6Vy3bqqcv7zqgrivphBWx4O+Kvq/Q4i3A8Tf5F19aafEAVPkYyF8AsyskgzCUVlNqiDN/E/oZJ/QGr/8M0rbDifXjbBBZTQ3x2CihS+eryYFMQ5ZnQ4pM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id EADF61FCE4;
	Wed,  3 Jul 2024 13:09:51 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 27E8713974;
	Wed,  3 Jul 2024 13:09:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id /cQxB59NhWYUJgAAD6G6ig
	(envelope-from <svarbanov@suse.de>); Wed, 03 Jul 2024 13:09:51 +0000
Message-ID: <055fe06c-58c3-42ad-a33e-c39de21f59b1@suse.de>
Date: Wed, 3 Jul 2024 16:09:46 +0300
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 3/8] PCI: brcmstb: Use bridge reset if available
To: Jim Quinlan <james.quinlan@broadcom.com>,
 Stanimir Varbanov <svarbanov@suse.de>
Cc: linux-pci@vger.kernel.org, Nicolas Saenz Julienne <nsaenz@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Cyril Brulebois <kibi@debian.org>, bcm-kernel-feedback-list@broadcom.com,
 jim2101024@gmail.com, Florian Fainelli <florian.fainelli@broadcom.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 Rob Herring <robh@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>,
 "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE"
 <linux-rpi-kernel@lists.infradead.org>,
 "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>,
 open list <linux-kernel@vger.kernel.org>
References: <20240628205430.24775-1-james.quinlan@broadcom.com>
 <20240628205430.24775-4-james.quinlan@broadcom.com>
 <48a3b910-e2c8-4faf-a8f0-d53b5ddcd5fe@suse.de>
 <CA+-6iNw3QziFzGuqrwzb8QsgY-B3uL9Z3z1rcTCBFG=6BW9MRQ@mail.gmail.com>
Content-Language: en-US
From: Stanimir Varbanov <svarbanov@suse.de>
In-Reply-To: <CA+-6iNw3QziFzGuqrwzb8QsgY-B3uL9Z3z1rcTCBFG=6BW9MRQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Spam-Flag: NO
X-Spam-Score: -4.00
X-Spam-Level: 
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Queue-Id: EADF61FCE4
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org

Hi Jim,

On 7/2/24 21:36, Jim Quinlan wrote:
> On Tue, Jul 2, 2024 at 8:59 AM Stanimir Varbanov <svarbanov@suse.de> wrote:
>>
>>
>>
>> On 6/28/24 23:54, Jim Quinlan wrote:
>>> The 7712 SOC has a bridge reset which can be described in the device tree.
>>> If it is present, use it. Otherwise, continue to use the legacy method to
>>> reset the bridge.
>>>
>>> Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>
>>> ---
>>>  drivers/pci/controller/pcie-brcmstb.c | 24 +++++++++++++++++++-----
>>>  1 file changed, 19 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
>>> index c2eb29b886f7..4104c3668fdb 100644
>>> --- a/drivers/pci/controller/pcie-brcmstb.c
>>> +++ b/drivers/pci/controller/pcie-brcmstb.c
>>> @@ -265,6 +265,7 @@ struct brcm_pcie {
>>>       enum pcie_type          type;
>>>       struct reset_control    *rescal;
>>>       struct reset_control    *perst_reset;
>>> +     struct reset_control    *bridge;
>>>       int                     num_memc;
>>>       u64                     memc_size[PCIE_BRCM_MAX_MEMC];
>>>       u32                     hw_rev;
>>> @@ -732,12 +733,19 @@ static void __iomem *brcm7425_pcie_map_bus(struct pci_bus *bus,
>>>
>>>  static void brcm_pcie_bridge_sw_init_set_generic(struct brcm_pcie *pcie, u32 val)
>>>  {
>>> -     u32 tmp, mask =  RGR1_SW_INIT_1_INIT_GENERIC_MASK;
>>> -     u32 shift = RGR1_SW_INIT_1_INIT_GENERIC_SHIFT;
>>> +     if (pcie->bridge) {
>>> +             if (val)
>>> +                     reset_control_assert(pcie->bridge);
>>> +             else
>>> +                     reset_control_deassert(pcie->bridge);
>>
>> Please check reset_control_assert/deassert() calls for error. This might
>> need to change the definition of brcm_pcie_bridge_sw_init_set_generic()
>> to return error.
> 
> Hi Stan,
> 
> Do you really think this is necessary?  If you look at
> "drivers/reset/reset-brcmstb.c"  there is no way for either of these
> calls to fail and I don't see that changing because it is just writing
> a bit into a register.

yes, I think there are kernel rules which we have to follow. We use
generic reset-control interface in pcie driver and we cannot rely on the
low-level implementation of this particular reset-controller driver
(reset-brcmstb.c).

regards,
~Stan

