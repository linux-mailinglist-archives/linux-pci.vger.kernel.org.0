Return-Path: <linux-pci+bounces-29510-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B29E0AD64C8
	for <lists+linux-pci@lfdr.de>; Thu, 12 Jun 2025 02:50:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 57DB23AC867
	for <lists+linux-pci@lfdr.de>; Thu, 12 Jun 2025 00:50:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BC1E44C77;
	Thu, 12 Jun 2025 00:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="irQTORLM"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BAE3A944;
	Thu, 12 Jun 2025 00:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749689449; cv=none; b=rVs6WgbY2ofpfbVDGgk0LnNlxvi1Iwbq7YGdg7a8lPr3Yu7VkdAWzoIJURgVHjEzTb63/ZkwIAosu7zdSVHDVVNrfvMFv8h5/F5c5itVDsNepdjeIeoDNklKu7DGOvBd0tyO66CAP6z2E3yeDM7OD/PoUKWvuNduQBw0M6pk984=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749689449; c=relaxed/simple;
	bh=TO+esTbBV563zHhYclGKbQ4Kk44uqSY4io8/BVfQCA4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=csdQGFOV2TghZ5/PJxR6uxCgP7QmQ5bsdulp8uy37u62rLliWR6Oajg+nY9aPOjbJGmsxCm/rxociZ7thvkqdgxXZVWIeR+M/3JyVj4TVHIDV4WNWZAzUW4qijgbE9vhiQYZe9qrXmcrjW0I7uuqcfNfBDWKU0Fz3AsKlnz8upc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=irQTORLM; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=1dOaqnFjZKRJyblr+6PCERlCBnX9Gn93vnPzUMgrd8k=;
	b=irQTORLMsWATNz5nl8DuuEHMsyzgXw2/Mm0Pwo5Enw/7WdeqAA3TJoT5dG8wEX
	sK6NKHxsegaCxEosMrr7uFg7/Gq9Hm6UKGgCnium7S3a6JwyQyiq6uPEw8yXG1Js
	dy7rlCVvn8b0aTKdzU5rEhn6O9+TDwFPoHbFJSgHDnm9E=
Received: from [192.168.18.52] (unknown [])
	by gzga-smtp-mtada-g1-4 (Coremail) with SMTP id _____wBX7slSJEpoBHmaHw--.5481S2;
	Thu, 12 Jun 2025 08:50:28 +0800 (CST)
Message-ID: <bd7f1053-f00e-4a1b-9923-9c3e1d1605b2@163.com>
Date: Thu, 12 Jun 2025 08:50:25 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/13] PCI: dwc: Refactor imx6 to use
 dw_pcie_clear_and_set_dword()
To: Frank Li <Frank.li@nxp.com>
Cc: lpieralisi@kernel.org, bhelgaas@google.com, mani@kernel.org,
 kwilczynski@kernel.org, robh@kernel.org, jingoohan1@gmail.com,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250611163121.860619-1-18255117159@163.com>
 <aEnNFgv08BVVxfOQ@lizhi-Precision-Tower-5810>
 <aEnO4QSrAzEHzoAe@lizhi-Precision-Tower-5810>
Content-Language: en-US
From: Hans Zhang <18255117159@163.com>
In-Reply-To: <aEnO4QSrAzEHzoAe@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_____wBX7slSJEpoBHmaHw--.5481S2
X-Coremail-Antispam: 1Uf129KBjvJXoW3Xw1fAw17Kw4fuw1fAw4kCrg_yoW7GrW7p3
	y2vF4SkF48JrWruwsFvas5ZF13tasakr1DW3W7G340qF9Fyry7Ga1jyrW3Krn7Gr4Utryj
	kr1UJws3Aa4YyFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07Ujg4fUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbBDwNqo2hKH5lxbwABs+



On 2025/6/12 02:45, Frank Li wrote:
> On Wed, Jun 11, 2025 at 02:38:14PM -0400, Frank Li wrote:
>> On Thu, Jun 12, 2025 at 12:31:21AM +0800, Hans Zhang wrote:
>>
>> Subject should be
>>
>> PCI: dwc: imx6: Refactor code by using dw_pcie_clear_and_set_dword()
>>
>> tag "imx6:" should after "dwc:"
>>
>> Reviewed-by: Frank Li <Frank.Li@nxp.com>
> 
> I sent out too quick, please don't applied my review tag at next version
> because I found a issue, see:
> 
> https://lore.kernel.org/linux-pci/aEnONwJUSEMdMAUD@lizhi-Precision-Tower-5810/
> 

Dear Frank,

Thank you very much for your reply.

I have replied to you in the previous email. Bjorn also raised a 
question as to why the entire series is not under 
0000-cover-letter.patch. I will reply to Bjorn in the email and try to 
solve this problem.

Best regards,
Hans

> Frank
>>
>>> i.MX6 PCIe driver contains multiple read-modify-write sequences for
>>> link training and speed configuration. These operations manually handle
>>> bit masking and shifting to update specific fields in control registers,
>>> particularly for link capabilities and speed change initiation.
>>>
>>> Refactor link capability configuration and speed change handling using
>>> dw_pcie_clear_and_set_dword(). The helper simplifies LNKCAP modification
>>> by encapsulating bit clear/set operations and eliminates intermediate
>>> variables. For speed change control, replace explicit bit manipulation
>>> with direct register updates through the helper.
>>>
>>> Adopting the standard interface reduces code complexity in link training
>>> paths and ensures consistent handling of speed-related bits. The change
>>> also prepares the driver for future enhancements to Gen3 link training
>>> by centralizing bit manipulation logic.
>>>
>>> Signed-off-by: Hans Zhang <18255117159@163.com>
>>> ---
>>>   drivers/pci/controller/dwc/pci-imx6.c | 26 ++++++++++----------------
>>>   1 file changed, 10 insertions(+), 16 deletions(-)
>>>
>>> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
>>> index 5a38cfaf989b..3004e432f013 100644
>>> --- a/drivers/pci/controller/dwc/pci-imx6.c
>>> +++ b/drivers/pci/controller/dwc/pci-imx6.c
>>> @@ -941,7 +941,6 @@ static int imx_pcie_start_link(struct dw_pcie *pci)
>>>   	struct imx_pcie *imx_pcie = to_imx_pcie(pci);
>>>   	struct device *dev = pci->dev;
>>>   	u8 offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
>>> -	u32 tmp;
>>>   	int ret;
>>>
>>>   	if (!(imx_pcie->drvdata->flags &
>>> @@ -956,10 +955,9 @@ static int imx_pcie_start_link(struct dw_pcie *pci)
>>>   	 * bus will not be detected at all.  This happens with PCIe switches.
>>>   	 */
>>>   	dw_pcie_dbi_ro_wr_en(pci);
>>> -	tmp = dw_pcie_readl_dbi(pci, offset + PCI_EXP_LNKCAP);
>>> -	tmp &= ~PCI_EXP_LNKCAP_SLS;
>>> -	tmp |= PCI_EXP_LNKCAP_SLS_2_5GB;
>>> -	dw_pcie_writel_dbi(pci, offset + PCI_EXP_LNKCAP, tmp);
>>> +	dw_pcie_clear_and_set_dword(pci, offset + PCI_EXP_LNKCAP,
>>> +				    PCI_EXP_LNKCAP_SLS,
>>> +				    PCI_EXP_LNKCAP_SLS_2_5GB);
>>>   	dw_pcie_dbi_ro_wr_dis(pci);
>>>
>>>   	/* Start LTSSM. */
>>> @@ -972,18 +970,16 @@ static int imx_pcie_start_link(struct dw_pcie *pci)
>>>
>>>   		/* Allow faster modes after the link is up */
>>>   		dw_pcie_dbi_ro_wr_en(pci);
>>> -		tmp = dw_pcie_readl_dbi(pci, offset + PCI_EXP_LNKCAP);
>>> -		tmp &= ~PCI_EXP_LNKCAP_SLS;
>>> -		tmp |= pci->max_link_speed;
>>> -		dw_pcie_writel_dbi(pci, offset + PCI_EXP_LNKCAP, tmp);
>>> +		dw_pcie_clear_and_set_dword(pci, offset + PCI_EXP_LNKCAP,
>>> +					    PCI_EXP_LNKCAP_SLS,
>>> +					    pci->max_link_speed);
>>>
>>>   		/*
>>>   		 * Start Directed Speed Change so the best possible
>>>   		 * speed both link partners support can be negotiated.
>>>   		 */
>>> -		tmp = dw_pcie_readl_dbi(pci, PCIE_LINK_WIDTH_SPEED_CONTROL);
>>> -		tmp |= PORT_LOGIC_SPEED_CHANGE;
>>> -		dw_pcie_writel_dbi(pci, PCIE_LINK_WIDTH_SPEED_CONTROL, tmp);
>>> +		dw_pcie_clear_and_set_dword(pci, PCIE_LINK_WIDTH_SPEED_CONTROL,
>>> +					    0, PORT_LOGIC_SPEED_CHANGE);
>>>   		dw_pcie_dbi_ro_wr_dis(pci);
>>>
>>>   		ret = imx_pcie_wait_for_speed_change(imx_pcie);
>>> @@ -1295,7 +1291,6 @@ static void imx_pcie_host_post_init(struct dw_pcie_rp *pp)
>>>   {
>>>   	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
>>>   	struct imx_pcie *imx_pcie = to_imx_pcie(pci);
>>> -	u32 val;
>>>
>>>   	if (imx_pcie->drvdata->flags & IMX_PCIE_FLAG_8GT_ECN_ERR051586) {
>>>   		/*
>>> @@ -1310,9 +1305,8 @@ static void imx_pcie_host_post_init(struct dw_pcie_rp *pp)
>>>   		 * to 0.
>>>   		 */
>>>   		dw_pcie_dbi_ro_wr_en(pci);
>>> -		val = dw_pcie_readl_dbi(pci, GEN3_RELATED_OFF);
>>> -		val &= ~GEN3_RELATED_OFF_GEN3_ZRXDC_NONCOMPL;
>>> -		dw_pcie_writel_dbi(pci, GEN3_RELATED_OFF, val);
>>> +		dw_pcie_clear_and_set_dword(pci, GEN3_RELATED_OFF,
>>> +					    GEN3_RELATED_OFF_GEN3_ZRXDC_NONCOMPL, 0);
>>>   		dw_pcie_dbi_ro_wr_dis(pci);
>>>   	}
>>>   }
>>> --
>>> 2.25.1
>>>


