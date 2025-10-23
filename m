Return-Path: <linux-pci+bounces-39070-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 411E8BFEC12
	for <lists+linux-pci@lfdr.de>; Thu, 23 Oct 2025 02:39:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED92B3A844D
	for <lists+linux-pci@lfdr.de>; Thu, 23 Oct 2025 00:39:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E01501885A5;
	Thu, 23 Oct 2025 00:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="R4rUwn0/"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-m8240.xmail.ntesmail.com (mail-m8240.xmail.ntesmail.com [156.224.82.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EAD6132117
	for <linux-pci@vger.kernel.org>; Thu, 23 Oct 2025 00:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.224.82.40
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761179957; cv=none; b=Skia4rzrEhqV0ON8+rhG7R6L9+GSt4SR8y36O2u2cwgC5hwXQSBg9Sj60RfB4dsjPykuIRGZqV7H3XK1BiwInOBQ+WV6pIkn6exncbKNjXbsoH3hNEpeHtnepT7mLFgMgb8c+liiCIOsQ/Gw6xyROF69PDE/I/ZV0ocb24BMm9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761179957; c=relaxed/simple;
	bh=cr/mWljUW1SeD1c4Puk1rrt29YLjnX+YjGmN/fn7Erw=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=bnctbSeDSWrhHj7KUJSbpNEjLmV2Y2Mgq+PhteEslyuUVPlwxBF2METDPJ1FgzVw3Ji5IkJsxtPJidnadEa/D6ji7j8hXj08xusQoge11quSfjpSfIUmA3tYRo7t4TesbUoS678hIQ16Gb9U0tUwy8HR17KJKqdvCLdZPdYC7Cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=R4rUwn0/; arc=none smtp.client-ip=156.224.82.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from [172.16.12.129] (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 26da9794c;
	Thu, 23 Oct 2025 08:39:03 +0800 (GMT+08:00)
Message-ID: <09baf633-9394-4ac4-b407-8167bca8f3b3@rock-chips.com>
Date: Thu, 23 Oct 2025 08:39:02 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: shawn.lin@rock-chips.com, Heiko Stuebner <heiko@sntech.de>,
 Bjorn Helgaas <bhelgaas@google.com>, linux-rockchip@lists.infradead.org,
 Niklas Cassel <cassel@kernel.org>, linux-pci@vger.kernel.org
Subject: Re: [PATCH v2 1/2] PCI: dw-rockchip: Add L1sub support
To: Manivannan Sadhasivam <mani@kernel.org>
References: <1761132954-177344-1-git-send-email-shawn.lin@rock-chips.com>
 <lvixfsccgsodm4hfwxejofjnms5l7xhcskn7fgfdxryfs3ez7z@fh6uajlce6x6>
 <988940fe-7cc3-4b24-b02d-f6e1d28145b7@rock-chips.com>
 <6aazm6t2j5qhdg5njlvzivnmtdomfewy54ap37efv7tbgn3rkq@kjiwmtrciyvq>
From: Shawn Lin <shawn.lin@rock-chips.com>
In-Reply-To: <6aazm6t2j5qhdg5njlvzivnmtdomfewy54ap37efv7tbgn3rkq@kjiwmtrciyvq>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9a0e81409a09cckunma3adcfc287cc3c
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQ0lDH1YaGE5IGB4aSk4YSx1WFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=R4rUwn0/3V65m6Ko5LhkNSji9tnepvv8rpUHp5B7y2HBePv7X4VmQmFWleJSaGzLTxVMit+86yC6xRZJzH4+CQwsHIZQhNfaqbCtifTIJMYZfs2kDDi5+86SUvj9TpxNqtwDB5nznZJoAXLL84by0jbcHOHzoo1MM0nSjNReBlE=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=JQUi4S8YachmS+OQNrvhCPFxZuSOuCg6N6tX2OkhHXE=;
	h=date:mime-version:subject:message-id:from;

Hi Mani

在 2025/10/23 星期四 0:03, Manivannan Sadhasivam 写道:
> On Wed, Oct 22, 2025 at 10:27:39PM +0800, Shawn Lin wrote:
>>
>> 在 2025/10/22 星期三 21:04, Manivannan Sadhasivam 写道:
>>> On Wed, Oct 22, 2025 at 07:35:53PM +0800, Shawn Lin wrote:
>>>> The driver should set app_clk_req_n(clkreq ready) of PCIE_CLIENT_POWER reg
>>>> to support L1sub. Otherwise, unset app_clk_req_n and pull down CLKREQ#.
>>>>
>>>
>>> You can definitely improve the commit message on explaining why L1 PM Substates
>>> need to be disabled when the DT property is not present etc... Please refer the
>>> patch from Niklas.
>>
>> Will do.
>>
>>>
>>>> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
>>>>
>>>> ---
>>>>
>>>> Changes in v2:
>>>> - drop of_pci_clkreq_presnt API
>>>> - drop dependency of Niklas's patch
>>>>
>>>>    drivers/pci/controller/dwc/pcie-dw-rockchip.c | 36 +++++++++++++++++++++++++++
>>>>    1 file changed, 36 insertions(+)
>>>>
>>>> diff --git a/drivers/pci/controller/dwc/pcie-dw-rockchip.c b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
>>>> index 3e2752c..18cd626 100644
>>>> --- a/drivers/pci/controller/dwc/pcie-dw-rockchip.c
>>>> +++ b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
>>>> @@ -62,6 +62,12 @@
>>>>    /* Interrupt Mask Register Related to Miscellaneous Operation */
>>>>    #define PCIE_CLIENT_INTR_MASK_MISC	0x24
>>>> +/* Power Management Control Register */
>>>> +#define PCIE_CLIENT_POWER		0x2c
>>>> +#define  PCIE_CLKREQ_READY		0x10001
>>>> +#define  PCIE_CLKREQ_NOT_READY		0x10000
>>>> +#define  PCIE_CLKREQ_PULL_DOWN		0x30001000
>>>
>>> Can you use bitfields instead of magic values?
>>
>> Of course, will fix.
>>
>>>
>>>> +
>>>>    /* Hot Reset Control Register */
>>>>    #define PCIE_CLIENT_HOT_RESET_CTRL	0x180
>>>>    #define  PCIE_LTSSM_APP_DLY2_EN		BIT(1)
>>>> @@ -85,6 +91,7 @@ struct rockchip_pcie {
>>>>    	struct regulator *vpcie3v3;
>>>>    	struct irq_domain *irq_domain;
>>>>    	const struct rockchip_pcie_of_data *data;
>>>> +	bool supports_clkreq;
>>>>    };
>>>>    struct rockchip_pcie_of_data {
>>>> @@ -200,6 +207,31 @@ static bool rockchip_pcie_link_up(struct dw_pcie *pci)
>>>>    	return FIELD_GET(PCIE_LINKUP_MASK, val) == PCIE_LINKUP;
>>>>    }
>>>> +static void rockchip_pcie_enable_l1sub(struct dw_pcie *pci)
>>>
>>> rockchip_pcie_configure_l1sub()? since this function is not just enabling L1ss.
>>>
>>>> +{
>>>> +	struct rockchip_pcie *rockchip = to_rockchip_pcie(pci);
>>>> +	u32 cap, l1subcap;
>>>> +
>>>> +	/* Enable L1 substates if CLKREQ# is properly connected */
>>>> +	if (rockchip->supports_clkreq) {
>>>> +		/* Ready to have reference clock removed */
>>>
>>> This comment is misleading (maybe wrong). The presence of this property implies
>>> that the link could enter L1 PM Substates. REFCLK removal only happens when the
>>> link is in L1ss.
>>>
>>> So drop the comment.
>>
>> Will drop.
>>
>>>
>>>> +		rockchip_pcie_writel_apb(rockchip, PCIE_CLKREQ_READY, PCIE_CLIENT_POWER);
>>>> +		return;
>>>> +	}
>>>> +
>>>> +	/* Otherwise, pull down CLKREQ# and disable L1 substates */
>>>
>>> "L1 PM Substates"
>>>
>>>> +	rockchip_pcie_writel_apb(rockchip, PCIE_CLKREQ_PULL_DOWN | PCIE_CLKREQ_NOT_READY,
>>>> +				 PCIE_CLIENT_POWER);
>>>> +	cap = dw_pcie_find_ext_capability(pci, PCI_EXT_CAP_ID_L1SS);
>>>> +	if (cap) {
>>>> +		l1subcap = dw_pcie_readl_dbi(pci, cap + PCI_L1SS_CAP);
>>>> +		l1subcap &= ~(PCI_L1SS_CAP_L1_PM_SS | PCI_L1SS_CAP_ASPM_L1_1 |
>>>> +			      PCI_L1SS_CAP_ASPM_L1_2 | PCI_L1SS_CAP_PCIPM_L1_1 |
>>>> +			      PCI_L1SS_CAP_PCIPM_L1_2);
>>>> +		dw_pcie_writel_dbi(pci, cap + PCI_L1SS_CAP, l1subcap);
>>>> +	}
>>>> +}
>>>> +
>>>>    static void rockchip_pcie_enable_l0s(struct dw_pcie *pci)
>>>>    {
>>>>    	u32 cap, lnkcap;
>>>> @@ -264,6 +296,7 @@ static int rockchip_pcie_host_init(struct dw_pcie_rp *pp)
>>>>    	irq_set_chained_handler_and_data(irq, rockchip_pcie_intx_handler,
>>>>    					 rockchip);
>>>> +	rockchip_pcie_enable_l1sub(pci);
>>>>    	rockchip_pcie_enable_l0s(pci);
>>>>    	return 0;
>>>> @@ -301,6 +334,7 @@ static void rockchip_pcie_ep_init(struct dw_pcie_ep *ep)
>>>>    	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
>>>>    	enum pci_barno bar;
>>>> +	rockchip_pcie_enable_l1sub(pci);
>>>
>>> I don't think you can decide the CLKREQ# routing on the EP side. The
>>> 'supports-clkreq' property is meant only for the RC afaik.
>>
>> You are right, we cannot decide the CLKREQ# routing on the EP side. But
>> what I have in mind is we at least need to set pinmux to CLKREQ function
>> because on Rockchip platforms, the CLKREQ# of EP mode could also be used
>> as GPIO or other funcions if guys never need L1ss to be supported.
>>
> 
> You don't need to configure pinmux in the driver manually. If the platform
> desginer knows that CLKREQ# is not used in the endpoint, then the corresponding
> pinmux state can be set to non-CLKREQ# function in DT.
> 
> I was assuming that CLKREQ# assert/deassert is handled by the endpoint
> controller hw without endpoint software intervention.

Ok, I got your point now. For the EP part, I'll drop L1ss support after
more internal disscussion as it also need more things to do, e.g,
trigger revelent L1.x irq to do something to actually save power...etc.

> 
> - Mani
> 


