Return-Path: <linux-pci+bounces-18027-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 13FD59EB219
	for <lists+linux-pci@lfdr.de>; Tue, 10 Dec 2024 14:42:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 808EC188D5DF
	for <lists+linux-pci@lfdr.de>; Tue, 10 Dec 2024 13:42:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71CD41AA1C9;
	Tue, 10 Dec 2024 13:42:36 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30D7323DE8D;
	Tue, 10 Dec 2024 13:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733838156; cv=none; b=rXBS8S5Pt3ScVTESDam8tofl7+/cUWptXLvfxelkVAYv4gVXuLQvzu02hdECVtQzwED4SSNf1leSm+VnlHg1MM8AuLFg302sAfZepiRPbxoYJ4naQNtRxPPbnI/OfT0gv866LTg9r4ZAzdC/aMsxRPbCzowE81zXfTytLZH+qnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733838156; c=relaxed/simple;
	bh=2ImeuZPEA17RXiTbVmkx5ckmj8FT3FnWwQnJuUVKHdc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=t+f44Njz1RjamCWCn+NIvLfJP85RpNslsvpZMr+pkCdeIssjZs5xMCSdsJMZMvzjjZ2YLYF3ek6stYFVu4WBnqZzjsK6u6f0uJtQW9fH/wtKAsfAY1edaxP80U1U4iYqFEnLS0z45f9ANEaROcC+rOk6XTcQNWvrMjOVHCNFzvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 6AF6421163;
	Tue, 10 Dec 2024 13:42:31 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4B81D13A15;
	Tue, 10 Dec 2024 13:42:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id cLoBD0ZFWGcfBgAAD6G6ig
	(envelope-from <svarbanov@suse.de>); Tue, 10 Dec 2024 13:42:30 +0000
Message-ID: <f9f49030-0518-4e30-91a7-3c088c31180b@suse.de>
Date: Tue, 10 Dec 2024 15:42:21 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 08/10] PCI: brcmstb: Adjust PHY PLL setup to use a
 54MHz input refclk
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
 <20241025124515.14066-9-svarbanov@suse.de>
 <4bbdf9ed-f429-411b-8f5f-e51857f0f9d0@broadcom.com>
Content-Language: en-US
From: Stanimir Varbanov <svarbanov@suse.de>
In-Reply-To: <4bbdf9ed-f429-411b-8f5f-e51857f0f9d0@broadcom.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Spam-Level: 
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[];
	TAGGED_RCPT(0.00)[dt]
X-Spam-Score: -4.00
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 6AF6421163
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org

Hi Jim

On 12/10/24 12:52 AM, James Quinlan wrote:
> On 10/25/24 08:45, Stanimir Varbanov wrote:
>> The default input reference clock for the PHY PLL is 100Mhz, except for
>> some devices where it is 54Mhz like bcm2712C1 and bcm2712D0.
>>
>> To implement this adjustments introduce a new .post_setup op in
>> pcie_cfg_data and call it at the end of brcm_pcie_setup function.
>>
>> The bcm2712 .post_setup callback implements the required MDIO writes that
>> switch the PLL refclk and also change PHY PM clock period.
>>
>> Without this RPi5 PCIex1 is unable to enumerate endpoint devices on
>> the expansion connector.
>>
>> Signed-off-by: Stanimir Varbanov <svarbanov@suse.de>
>> ---
>> v3 -> v4:
>>   - Improved patch description (Florian)
>>
>>   drivers/pci/controller/pcie-brcmstb.c | 42 +++++++++++++++++++++++++++
>>   1 file changed, 42 insertions(+)
>>
>> diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/
>> controller/pcie-brcmstb.c
>> index d970a76aa9ef..2571dcc14560 100644
>> --- a/drivers/pci/controller/pcie-brcmstb.c
>> +++ b/drivers/pci/controller/pcie-brcmstb.c
>> @@ -55,6 +55,10 @@
>>   #define PCIE_RC_DL_MDIO_WR_DATA                0x1104
>>   #define PCIE_RC_DL_MDIO_RD_DATA                0x1108
>>   +#define PCIE_RC_PL_PHY_CTL_15                0x184c
>> +#define  PCIE_RC_PL_PHY_CTL_15_DIS_PLL_PD_MASK        0x400000
>> +#define  PCIE_RC_PL_PHY_CTL_15_PM_CLK_PERIOD_MASK    0xff
>> +
>>   #define PCIE_MISC_MISC_CTRL                0x4008
>>   #define  PCIE_MISC_MISC_CTRL_PCIE_RCB_64B_MODE_MASK    0x80
>>   #define  PCIE_MISC_MISC_CTRL_PCIE_RCB_MPS_MODE_MASK    0x400
>> @@ -251,6 +255,7 @@ struct pcie_cfg_data {
>>       u8 num_inbound_wins;
>>       int (*perst_set)(struct brcm_pcie *pcie, u32 val);
>>       int (*bridge_sw_init_set)(struct brcm_pcie *pcie, u32 val);
>> +    int (*post_setup)(struct brcm_pcie *pcie);
>>   };
>>     struct subdev_regulators {
>> @@ -826,6 +831,36 @@ static int brcm_pcie_perst_set_generic(struct
>> brcm_pcie *pcie, u32 val)
>>       return 0;
>>   }
>>   +static int brcm_pcie_post_setup_bcm2712(struct brcm_pcie *pcie)
>> +{
>> +    const u16 data[] = { 0x50b9, 0xbda1, 0x0094, 0x97b4, 0x5030,
>> 0x5030, 0x0007 };
>> +    const u8 regs[] = { 0x16, 0x17, 0x18, 0x19, 0x1b, 0x1c, 0x1e };
>> +    int ret, i;
>> +    u32 tmp;
>> +
>> +    /* Allow a 54MHz (xosc) refclk source */
>> +    ret = brcm_pcie_mdio_write(pcie->base, MDIO_PORT0,
>> SET_ADDR_OFFSET, 0x1600);
>> +    if (ret < 0)
>> +        return ret;
>> +
>> +    for (i = 0; i < ARRAY_SIZE(regs); i++) {
>> +        ret = brcm_pcie_mdio_write(pcie->base, MDIO_PORT0, regs[i],
>> data[i]);
>> +        if (ret < 0)
>> +            return ret;
>> +    }
>> +
>> +    usleep_range(100, 200);
>> +
>> +    /* Fix for L1SS errata */
>> +    tmp = readl(pcie->base + PCIE_RC_PL_PHY_CTL_15);
>> +    tmp &= ~PCIE_RC_PL_PHY_CTL_15_PM_CLK_PERIOD_MASK;
>> +    /* PM clock period is 18.52ns (round down) */
>> +    tmp |= 0x12;
>> +    writel(tmp, pcie->base + PCIE_RC_PL_PHY_CTL_15);
> 
> Hi Stan,
> 
> Can you please say more about where this errata came from?  I asked the
> 7712 PCIe HW folks and they said that there best guess was that it was a
> old workaround for a particular Broadcom Wifi endpoint.  Do you know its
> origin?

Unfortunately, I don't know the details. See the comments on previous
series version [1]. My observation shows that MDIO writes are
implemented in RPi platform firmware only for pcie2 (where RP1 south
bridge is connected) but not for pcie1 expansion connector.

~Stan

[1] https://www.spinics.net/lists/linux-pci/msg160842.html


