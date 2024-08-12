Return-Path: <linux-pci+bounces-11611-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AF9A94F98F
	for <lists+linux-pci@lfdr.de>; Tue, 13 Aug 2024 00:28:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B1ADA1F21BF4
	for <lists+linux-pci@lfdr.de>; Mon, 12 Aug 2024 22:28:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3288195808;
	Mon, 12 Aug 2024 22:28:09 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E28261953B9;
	Mon, 12 Aug 2024 22:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723501689; cv=none; b=Ua4wbtiUZWIj3aUzSeflFeSWlPOPt4atFVtHawVqHtX/+pKoCh1TfbenwOIvUb4fqPFY2jaDdbUmRkqMEkKj9SOKdKzZfTnl8ydtW1y05oz97yS0UBkL8Tc5okq41sTqcWXfRA2L8hQoVQW9/GyiTP/Igys3N0GgZxmc3LoWdq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723501689; c=relaxed/simple;
	bh=Vjoe3Pd4AGjq5QVejoC1rRs3OVljWvtR56eC8TynqI4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r9hSNVu8x2Jt6DxODE23mWgM7DBaR1Kb97nHitxWnv+BtExalhlwYSSAJyPAQs+6t6V93Db6PuP1gz8Y/Xq7ELbnNmPpwvaFQ8D//Goc0tCOaih8vDy4wUrNonFTrDmfgxxhZtmGOAGsS4jaz+fS2Jng+U4M+IplY7bltb8/5cM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 1BC3922632;
	Mon, 12 Aug 2024 22:28:06 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 189FB13983;
	Mon, 12 Aug 2024 22:28:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id dDPnAnWMumZ+GAAAD6G6ig
	(envelope-from <svarbanov@suse.de>); Mon, 12 Aug 2024 22:28:05 +0000
Message-ID: <7b8b4b5f-4dc4-4099-b793-d10f2761d364@suse.de>
Date: Tue, 13 Aug 2024 01:28:04 +0300
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 04/12] PCI: brcmstb: Use bridge reset if available
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
References: <20240731222831.14895-1-james.quinlan@broadcom.com>
 <20240731222831.14895-5-james.quinlan@broadcom.com>
 <9c22a495-7b89-4df6-b57b-cb0f39b09c30@suse.de>
 <CA+-6iNy2f3zNsSZcFBHnEoTSqDHx34+ijZrLWhnC5bfF=S3nQg@mail.gmail.com>
Content-Language: en-US
From: Stanimir Varbanov <svarbanov@suse.de>
In-Reply-To: <CA+-6iNy2f3zNsSZcFBHnEoTSqDHx34+ijZrLWhnC5bfF=S3nQg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Spam-Score: -4.00
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Queue-Id: 1BC3922632
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Level: 

Hi Jim,

On 8/12/24 18:46, Jim Quinlan wrote:
> On Fri, Aug 9, 2024 at 7:16 AM Stanimir Varbanov <svarbanov@suse.de> wrote:
>>
>> Hi Jim,
>>
>> On 8/1/24 01:28, Jim Quinlan wrote:
>>> The 7712 SOC has a bridge reset which can be described in the device tree.
>>> Use it if present.  Otherwise, continue to use the legacy method to reset
>>> the bridge.
>>>
>>> Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>
>>> ---
>>>  drivers/pci/controller/pcie-brcmstb.c | 24 +++++++++++++++++++-----
>>>  1 file changed, 19 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
>>> index 7595e7009192..4d68fe318178 100644
>>> --- a/drivers/pci/controller/pcie-brcmstb.c
>>> +++ b/drivers/pci/controller/pcie-brcmstb.c
>>> @@ -265,6 +265,7 @@ struct brcm_pcie {
>>>       enum pcie_type          type;
>>>       struct reset_control    *rescal;
>>>       struct reset_control    *perst_reset;
>>> +     struct reset_control    *bridge_reset;
>>>       int                     num_memc;
>>>       u64                     memc_size[PCIE_BRCM_MAX_MEMC];
>>>       u32                     hw_rev;
>>> @@ -732,12 +733,19 @@ static void __iomem *brcm7425_pcie_map_bus(struct pci_bus *bus,
>>>
>>>  static void brcm_pcie_bridge_sw_init_set_generic(struct brcm_pcie *pcie, u32 val)
>>>  {
>>> -     u32 tmp, mask =  RGR1_SW_INIT_1_INIT_GENERIC_MASK;
>>> -     u32 shift = RGR1_SW_INIT_1_INIT_GENERIC_SHIFT;
>>> +     if (val)
>>> +             reset_control_assert(pcie->bridge_reset);
>>> +     else
>>> +             reset_control_deassert(pcie->bridge_reset);
>>>
>>> -     tmp = readl(pcie->base + PCIE_RGR1_SW_INIT_1(pcie));
>>> -     tmp = (tmp & ~mask) | ((val << shift) & mask);
>>> -     writel(tmp, pcie->base + PCIE_RGR1_SW_INIT_1(pcie));
>>> +     if (!pcie->bridge_reset) {
>>> +             u32 tmp, mask =  RGR1_SW_INIT_1_INIT_GENERIC_MASK;
>>> +             u32 shift = RGR1_SW_INIT_1_INIT_GENERIC_SHIFT;
>>> +
>>> +             tmp = readl(pcie->base + PCIE_RGR1_SW_INIT_1(pcie));
>>> +             tmp = (tmp & ~mask) | ((val << shift) & mask);
>>> +             writel(tmp, pcie->base + PCIE_RGR1_SW_INIT_1(pcie));
>>> +     }
>>>  }
>>>
>>>  static void brcm_pcie_bridge_sw_init_set_7278(struct brcm_pcie *pcie, u32 val)
>>> @@ -1621,10 +1629,16 @@ static int brcm_pcie_probe(struct platform_device *pdev)
>>>       if (IS_ERR(pcie->perst_reset))
>>>               return PTR_ERR(pcie->perst_reset);
>>>
>>> +     pcie->bridge_reset = devm_reset_control_get_optional_exclusive(&pdev->dev, "bridge");
>>
>> Shouldn't this be devm_reset_control_get_optional_shared? See more below.
>>
>>> +     if (IS_ERR(pcie->bridge_reset))
>>> +             return PTR_ERR(pcie->bridge_reset);
>>> +
>>>       ret = clk_prepare_enable(pcie->clk);
>>>       if (ret)
>>>               return dev_err_probe(&pdev->dev, ret, "could not enable clock\n");
>>>
>>> +     pcie->bridge_sw_init_set(pcie, 0);

^^^ this was missing in v4

>>
>> According to reset_control_get_shared description looks like this
>> .deassert is satisfying the requirements for _shared reset-control API
>> variant.
>> Is that the intention to call reset_control_deassert() here?
> 
> Hi Stan,
> Now I'm not sure I understand you.  All of the resets (bridge, perst,
> swinit) are exclusive, except for the "rescal" reset, which is shared.

... the call of pcie->bridge_sw_init_set(pcie, 0) from brcm_pcie_probe()
was missing in previous v4 and I'm wondering what changed in v5.

And because of _shared reset-control description [1] I decided (wrongly)
that the bridge reset could be _shared_.

> 
> On the exclusive resets I am using reset_control_assert() and
> reset_control_deasssert().  On the shared reset I am using
> reset_control_rearm() and reset_control_reset().   Why do
> you think the calls I am using are incongruent with the shard/exclusive
> status?

I'd argue that rescal reset is not correctly used in brcm_pcie_probe(),
see [2] and according to [1] "Calling reset_control_reset is also not
allowed on a shared reset control."


[1]
https://elixir.bootlin.com/linux/v6.11-rc3/source/include/linux/reset.h#L338

[2]
https://elixir.bootlin.com/linux/v6.11-rc3/source/drivers/pci/controller/pcie-brcmstb.c#L1632

~Stan

