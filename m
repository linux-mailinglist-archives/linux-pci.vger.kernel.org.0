Return-Path: <linux-pci+bounces-18287-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 132339EE80A
	for <lists+linux-pci@lfdr.de>; Thu, 12 Dec 2024 14:48:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B844F282710
	for <lists+linux-pci@lfdr.de>; Thu, 12 Dec 2024 13:48:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C06152135AC;
	Thu, 12 Dec 2024 13:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="CTPt1+1O";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="MqdWU/zS";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="CTPt1+1O";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="MqdWU/zS"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDD0738396;
	Thu, 12 Dec 2024 13:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734011320; cv=none; b=Bo2Af8xSXMjnVu9UsBa/YhZsNk9zj+9r9+Qfv6UA8ZNBOvmFT+DfJ7axofasFcwDYUkjJ5pFXRR8YnGWzzF5BOajd3h3k1anpZXCpKV8QrDkOesAdM5BsF47RtTBGYrUOSqNDtQtS+H8FHzt1n+xP5S6wkRqHV26qwrfnbT7ihQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734011320; c=relaxed/simple;
	bh=P94YWYtZkz3Sh9SxayjdD759WkC5LM/GlTYF2rW09FU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A1yyliVZn+P6ZL6PWHbDq3il4LoDk3vMxVR0UM//LheLd0OeeTLBhN6xuMFTRwvX6rIjPoP92+SHSwoH8lACCFt8/pItiMrLkCDmtJTy5RJCuF+/qX0efL9Ah8OtpNNXnxdSWOHBFVmszy0J/31fniARWFKCNK+C/5xhC65OJsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=CTPt1+1O; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=MqdWU/zS; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=CTPt1+1O; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=MqdWU/zS; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B429C1F37C;
	Thu, 12 Dec 2024 13:48:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1734011316; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TRyhwbCFs9YdnDuH25cHl/brWhLVDYOwoyJ6Xun4/54=;
	b=CTPt1+1OwXTDKbXc/EkMUIj6Yz06KWM8JO0UQZaROMLvn9VlEhw6oGCh60OuODlHeKhLk5
	RSBZ56QwJHDk5UXexWrXr0jR80IyZSG7aYi+zO8GvX4C5eOjlMS2281luOivNQLDeD9A9Q
	Bgkq82ID3IO5rL9okQSmxQKMxKRl4U0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1734011316;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TRyhwbCFs9YdnDuH25cHl/brWhLVDYOwoyJ6Xun4/54=;
	b=MqdWU/zS4j6umFc78Qbzm+NvarMMEdpJCNKjFw3gf9KcIZJ57etWMrqkdiDfxDOCmEIiEQ
	D/NB7OWrK73GtrDA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=CTPt1+1O;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="MqdWU/zS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1734011316; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TRyhwbCFs9YdnDuH25cHl/brWhLVDYOwoyJ6Xun4/54=;
	b=CTPt1+1OwXTDKbXc/EkMUIj6Yz06KWM8JO0UQZaROMLvn9VlEhw6oGCh60OuODlHeKhLk5
	RSBZ56QwJHDk5UXexWrXr0jR80IyZSG7aYi+zO8GvX4C5eOjlMS2281luOivNQLDeD9A9Q
	Bgkq82ID3IO5rL9okQSmxQKMxKRl4U0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1734011316;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TRyhwbCFs9YdnDuH25cHl/brWhLVDYOwoyJ6Xun4/54=;
	b=MqdWU/zS4j6umFc78Qbzm+NvarMMEdpJCNKjFw3gf9KcIZJ57etWMrqkdiDfxDOCmEIiEQ
	D/NB7OWrK73GtrDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B8ACE13939;
	Thu, 12 Dec 2024 13:48:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id iiqTKrPpWme1YgAAD6G6ig
	(envelope-from <svarbanov@suse.de>); Thu, 12 Dec 2024 13:48:35 +0000
Message-ID: <462fcc0a-3b4a-4b59-b414-a2d305dcd29a@suse.de>
Date: Thu, 12 Dec 2024 15:48:35 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 08/10] PCI: brcmstb: Adjust PHY PLL setup to use a
 54MHz input refclk
To: Jonathan Bell <jonathan@raspberrypi.com>,
 James Quinlan <james.quinlan@broadcom.com>
Cc: Stanimir Varbanov <svarbanov@suse.de>, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rpi-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Thomas Gleixner
 <tglx@linutronix.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Florian Fainelli <florian.fainelli@broadcom.com>,
 Jim Quinlan <jim2101024@gmail.com>,
 Nicolas Saenz Julienne <nsaenz@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>, kw@linux.com,
 Philipp Zabel <p.zabel@pengutronix.de>,
 Andrea della Porta <andrea.porta@suse.com>,
 Phil Elwell <phil@raspberrypi.com>
References: <20241025124515.14066-1-svarbanov@suse.de>
 <20241025124515.14066-9-svarbanov@suse.de>
 <4bbdf9ed-f429-411b-8f5f-e51857f0f9d0@broadcom.com>
 <f9f49030-0518-4e30-91a7-3c088c31180b@suse.de>
 <474e5e38-37a4-439b-b25a-fe60df03f25b@broadcom.com>
 <CADQZjwci2SVN=AG178kj3yN=17nVixOHEZOjZCs9LSUihbby4Q@mail.gmail.com>
Content-Language: en-US
From: Stanimir Varbanov <svarbanov@suse.de>
In-Reply-To: <CADQZjwci2SVN=AG178kj3yN=17nVixOHEZOjZCs9LSUihbby4Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: B429C1F37C
X-Spam-Score: -3.01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RCPT_COUNT_TWELVE(0.00)[22];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[suse.de,vger.kernel.org,lists.infradead.org,broadcom.com,linutronix.de,kernel.org,gmail.com,google.com,linux.com,pengutronix.de,suse.com,raspberrypi.com];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dt];
	DKIM_TRACE(0.00)[suse.de:+];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim,suse.de:mid,suse.de:email]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

Hi

On 12/11/24 10:54 PM, Jonathan Bell wrote:
> On Wed, 11 Dec 2024 at 19:39, James Quinlan <james.quinlan@broadcom.com> wrote:
>>
>> On 12/10/24 08:42, Stanimir Varbanov wrote:
>>> Hi Jim
>>>
>>> On 12/10/24 12:52 AM, James Quinlan wrote:
>>>> On 10/25/24 08:45, Stanimir Varbanov wrote:
>>>>> The default input reference clock for the PHY PLL is 100Mhz, except for
>>>>> some devices where it is 54Mhz like bcm2712C1 and bcm2712D0.
>>>>>
>>>>> To implement this adjustments introduce a new .post_setup op in
>>>>> pcie_cfg_data and call it at the end of brcm_pcie_setup function.
>>>>>
>>>>> The bcm2712 .post_setup callback implements the required MDIO writes that
>>>>> switch the PLL refclk and also change PHY PM clock period.
>>>>>
>>>>> Without this RPi5 PCIex1 is unable to enumerate endpoint devices on
>>>>> the expansion connector.
>>>>>
>>>>> Signed-off-by: Stanimir Varbanov <svarbanov@suse.de>
>>>>> ---
>>>>> v3 -> v4:
>>>>>    - Improved patch description (Florian)
>>>>>
>>>>>    drivers/pci/controller/pcie-brcmstb.c | 42 +++++++++++++++++++++++++++
>>>>>    1 file changed, 42 insertions(+)
>>>>>
>>>>> diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/
>>>>> controller/pcie-brcmstb.c
>>>>> index d970a76aa9ef..2571dcc14560 100644
>>>>> --- a/drivers/pci/controller/pcie-brcmstb.c
>>>>> +++ b/drivers/pci/controller/pcie-brcmstb.c
>>>>> @@ -55,6 +55,10 @@
>>>>>    #define PCIE_RC_DL_MDIO_WR_DATA                0x1104
>>>>>    #define PCIE_RC_DL_MDIO_RD_DATA                0x1108
>>>>>    +#define PCIE_RC_PL_PHY_CTL_15                0x184c
>>>>> +#define  PCIE_RC_PL_PHY_CTL_15_DIS_PLL_PD_MASK        0x400000
>>>>> +#define  PCIE_RC_PL_PHY_CTL_15_PM_CLK_PERIOD_MASK    0xff
>>>>> +
>>>>>    #define PCIE_MISC_MISC_CTRL                0x4008
>>>>>    #define  PCIE_MISC_MISC_CTRL_PCIE_RCB_64B_MODE_MASK    0x80
>>>>>    #define  PCIE_MISC_MISC_CTRL_PCIE_RCB_MPS_MODE_MASK    0x400
>>>>> @@ -251,6 +255,7 @@ struct pcie_cfg_data {
>>>>>        u8 num_inbound_wins;
>>>>>        int (*perst_set)(struct brcm_pcie *pcie, u32 val);
>>>>>        int (*bridge_sw_init_set)(struct brcm_pcie *pcie, u32 val);
>>>>> +    int (*post_setup)(struct brcm_pcie *pcie);
>>>>>    };
>>>>>      struct subdev_regulators {
>>>>> @@ -826,6 +831,36 @@ static int brcm_pcie_perst_set_generic(struct
>>>>> brcm_pcie *pcie, u32 val)
>>>>>        return 0;
>>>>>    }
>>>>>    +static int brcm_pcie_post_setup_bcm2712(struct brcm_pcie *pcie)
>>>>> +{
>>>>> +    const u16 data[] = { 0x50b9, 0xbda1, 0x0094, 0x97b4, 0x5030,
>>>>> 0x5030, 0x0007 };
>>>>> +    const u8 regs[] = { 0x16, 0x17, 0x18, 0x19, 0x1b, 0x1c, 0x1e };
>>>>> +    int ret, i;
>>>>> +    u32 tmp;
>>>>> +
>>>>> +    /* Allow a 54MHz (xosc) refclk source */
>>>>> +    ret = brcm_pcie_mdio_write(pcie->base, MDIO_PORT0,
>>>>> SET_ADDR_OFFSET, 0x1600);
>>>>> +    if (ret < 0)
>>>>> +        return ret;
>>>>> +
>>>>> +    for (i = 0; i < ARRAY_SIZE(regs); i++) {
>>>>> +        ret = brcm_pcie_mdio_write(pcie->base, MDIO_PORT0, regs[i],
>>>>> data[i]);
>>>>> +        if (ret < 0)
>>>>> +            return ret;
>>>>> +    }
>>>>> +
>>>>> +    usleep_range(100, 200);
>>>>> +
>>>>> +    /* Fix for L1SS errata */
>>>>> +    tmp = readl(pcie->base + PCIE_RC_PL_PHY_CTL_15);
>>>>> +    tmp &= ~PCIE_RC_PL_PHY_CTL_15_PM_CLK_PERIOD_MASK;
>>>>> +    /* PM clock period is 18.52ns (round down) */
>>>>> +    tmp |= 0x12;
>>>>> +    writel(tmp, pcie->base + PCIE_RC_PL_PHY_CTL_15);
>>>> Hi Stan,
>>>>
>>>> Can you please say more about where this errata came from?  I asked the
>>>> 7712 PCIe HW folks and they said that there best guess was that it was a
>>>> old workaround for a particular Broadcom Wifi endpoint.  Do you know its
>>>> origin?
>>> Unfortunately, I don't know the details. See the comments on previous
>>> series version [1]. My observation shows that MDIO writes are
>>> implemented in RPi platform firmware only for pcie2 (where RP1 south
>>> bridge is connected) but not for pcie1 expansion connector.
>>
>> Well, I think my concern is more about the comment "Fix for L1SS errata"
>> rather than the code.  If this is a bonafide errata it should have an
>> identifier and some documentation somewhere. Declaring it to be an
>> unknown errata provides little info.
> 
> I'm the originator of this thunk - erratum is perhaps the wrong description.
> If the reference clock provided to the RC is 54MHz and not 100MHz, as
> is the case on BCM2712, then many of the L1 sub-state timers run
> slower which means state transitions are unnecessarily lengthened.
> 
> This change, and the MDIO manipulation above, should be applied
> regardless of the RC instance and/or connected EP.
> 

Thank you Jonathan.

I guess you are fine to take this description in the next version of the
series?

~Stan



