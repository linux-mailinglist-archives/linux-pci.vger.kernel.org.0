Return-Path: <linux-pci+bounces-30933-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9679BAEBBFB
	for <lists+linux-pci@lfdr.de>; Fri, 27 Jun 2025 17:35:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A5C36167058
	for <lists+linux-pci@lfdr.de>; Fri, 27 Jun 2025 15:35:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 270F62E92C4;
	Fri, 27 Jun 2025 15:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="UgJXL9R3"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 506C02E92C8;
	Fri, 27 Jun 2025 15:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751038443; cv=none; b=G90Bc4SbdaU+T5AiDfWCOzz7jnzbOomFSYeI8Jw+nFAPANO9HuHiUZ13f53JNZ2pcjDOweWJIHigvhTwtN9Co4aw7jl5baOeHeTkP/Jy3EvaOYvgsLowXYwMULfl3iK/v31keD6sZdVc7GOIlZjKaSw+5lV3vJIAKnn9TSx4M54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751038443; c=relaxed/simple;
	bh=LgdvqBTRB61bdlKxwir8i1HbLL9fRJZEYQrJo9z9NSI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SUSgLPbSky7Um4XFmBAJZB5rBgLLPcgbSt5bhAJ1BtWN0gWdYhqZan9ozaGbKZljaWTkTEHrPIRmPBp3/bRBBlW5vNdzys1ZQqGnQ7qszAdas6DONhagSEK6drsrvxo75opYySvLk+OT9/T6XVbQZi6gZ9Ah1GeZ3r9EwuM4tvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=UgJXL9R3; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=y5QkQnnSrcoyz3W4bWPHzK9WuTb9VBE36yVoQb6GpKY=;
	b=UgJXL9R3RyB/lWpMZBiVFD7Lp7reJ5J2XFU30O8Mzi5F7kYW3+5s8lEX2GgjMu
	L/P8Qymi6+pmY+bHFwHq90Z5zusEROqKt1LUZL7xuEQz8769EqDLZuRM8F0NP7XU
	A5WPD/kgN2N299Tlwhc3JYvWHEax0TZHQ0BpWQEJSznI8=
Received: from [IPV6:240e:b8f:919b:3100:5951:e2f3:d3e5:8d13] (unknown [])
	by gzsmtp1 (Coremail) with SMTP id PCgvCgCHFBbAuV5oafePAQ--.54065S2;
	Fri, 27 Jun 2025 23:33:22 +0800 (CST)
Message-ID: <f24aac22-d53e-4751-8bc5-db86a6d12598@163.com>
Date: Fri, 27 Jun 2025 23:33:20 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 04/13] PCI: imx6: Refactor code by using
 dw_pcie_clear_and_set_dword()
To: Frank Li <Frank.li@nxp.com>
Cc: lpieralisi@kernel.org, bhelgaas@google.com, mani@kernel.org,
 kwilczynski@kernel.org, robh@kernel.org, jingoohan1@gmail.com,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250626145040.14180-1-18255117159@163.com>
 <20250626145040.14180-5-18255117159@163.com>
 <aF1/DzLRRhtgFVsH@lizhi-Precision-Tower-5810>
Content-Language: en-US
From: Hans Zhang <18255117159@163.com>
In-Reply-To: <aF1/DzLRRhtgFVsH@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:PCgvCgCHFBbAuV5oafePAQ--.54065S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxAF1fAF1UXFyrJr47KF4DJwb_yoWrZw4rpa
	y2v3WSkF48JF4ruan2ya95ZF1aqas3Cr1DG3ZrK34FqFy2yr9rKa10y3y3trn7Cr47tryj
	kw1UJw43Ga1YyF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UoBTrUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/1tbiQxJ4o2hdXLQ8tQACsc



On 2025/6/27 01:10, Frank Li wrote:
> On Thu, Jun 26, 2025 at 10:50:31PM +0800, Hans Zhang wrote:
>> i.MX6 PCIe driver contains multiple read-modify-write sequences for
>> link training and speed configuration. These operations manually handle
>> bit masking and shifting to update specific fields in control registers,
>> particularly for link capabilities and speed change initiation.
>>
>> Refactor link capability configuration and speed change handling using
>> dw_pcie_clear_and_set_dword(). The helper simplifies LNKCAP modification
>> by encapsulating bit clear/set operations and eliminates intermediate
>> variables. For speed change control, replace explicit bit manipulation
>> with direct register updates through the helper.
>>
>> Adopting the standard interface reduces code complexity in link training
>> paths and ensures consistent handling of speed-related bits. The change
>> also prepares the driver for future enhancements to Gen3 link training
>> by centralizing bit manipulation logic.
>>
>> Signed-off-by: Hans Zhang <18255117159@163.com>
> 
> missed my review tag, you need collect all review tags when respin patches.
> 
> Reviewed-by: Frank Li <Frank.Li@nxp.com>
> 
> https://lore.kernel.org/linux-pci/aFQp4MYpRaEUXNQy@lizhi-Precision-Tower-5810/
> 

Dear Frank,

Sorry. Next time I will check the corresponding tag.

Best regards,
Hans

> 
>> ---
>>   drivers/pci/controller/dwc/pci-imx6.c | 26 ++++++++++----------------
>>   1 file changed, 10 insertions(+), 16 deletions(-)
>>
>> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
>> index 5a38cfaf989b..3004e432f013 100644
>> --- a/drivers/pci/controller/dwc/pci-imx6.c
>> +++ b/drivers/pci/controller/dwc/pci-imx6.c
>> @@ -941,7 +941,6 @@ static int imx_pcie_start_link(struct dw_pcie *pci)
>>   	struct imx_pcie *imx_pcie = to_imx_pcie(pci);
>>   	struct device *dev = pci->dev;
>>   	u8 offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
>> -	u32 tmp;
>>   	int ret;
>>
>>   	if (!(imx_pcie->drvdata->flags &
>> @@ -956,10 +955,9 @@ static int imx_pcie_start_link(struct dw_pcie *pci)
>>   	 * bus will not be detected at all.  This happens with PCIe switches.
>>   	 */
>>   	dw_pcie_dbi_ro_wr_en(pci);
>> -	tmp = dw_pcie_readl_dbi(pci, offset + PCI_EXP_LNKCAP);
>> -	tmp &= ~PCI_EXP_LNKCAP_SLS;
>> -	tmp |= PCI_EXP_LNKCAP_SLS_2_5GB;
>> -	dw_pcie_writel_dbi(pci, offset + PCI_EXP_LNKCAP, tmp);
>> +	dw_pcie_clear_and_set_dword(pci, offset + PCI_EXP_LNKCAP,
>> +				    PCI_EXP_LNKCAP_SLS,
>> +				    PCI_EXP_LNKCAP_SLS_2_5GB);
>>   	dw_pcie_dbi_ro_wr_dis(pci);
>>
>>   	/* Start LTSSM. */
>> @@ -972,18 +970,16 @@ static int imx_pcie_start_link(struct dw_pcie *pci)
>>
>>   		/* Allow faster modes after the link is up */
>>   		dw_pcie_dbi_ro_wr_en(pci);
>> -		tmp = dw_pcie_readl_dbi(pci, offset + PCI_EXP_LNKCAP);
>> -		tmp &= ~PCI_EXP_LNKCAP_SLS;
>> -		tmp |= pci->max_link_speed;
>> -		dw_pcie_writel_dbi(pci, offset + PCI_EXP_LNKCAP, tmp);
>> +		dw_pcie_clear_and_set_dword(pci, offset + PCI_EXP_LNKCAP,
>> +					    PCI_EXP_LNKCAP_SLS,
>> +					    pci->max_link_speed);
>>
>>   		/*
>>   		 * Start Directed Speed Change so the best possible
>>   		 * speed both link partners support can be negotiated.
>>   		 */
>> -		tmp = dw_pcie_readl_dbi(pci, PCIE_LINK_WIDTH_SPEED_CONTROL);
>> -		tmp |= PORT_LOGIC_SPEED_CHANGE;
>> -		dw_pcie_writel_dbi(pci, PCIE_LINK_WIDTH_SPEED_CONTROL, tmp);
>> +		dw_pcie_clear_and_set_dword(pci, PCIE_LINK_WIDTH_SPEED_CONTROL,
>> +					    0, PORT_LOGIC_SPEED_CHANGE);
>>   		dw_pcie_dbi_ro_wr_dis(pci);
>>
>>   		ret = imx_pcie_wait_for_speed_change(imx_pcie);
>> @@ -1295,7 +1291,6 @@ static void imx_pcie_host_post_init(struct dw_pcie_rp *pp)
>>   {
>>   	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
>>   	struct imx_pcie *imx_pcie = to_imx_pcie(pci);
>> -	u32 val;
>>
>>   	if (imx_pcie->drvdata->flags & IMX_PCIE_FLAG_8GT_ECN_ERR051586) {
>>   		/*
>> @@ -1310,9 +1305,8 @@ static void imx_pcie_host_post_init(struct dw_pcie_rp *pp)
>>   		 * to 0.
>>   		 */
>>   		dw_pcie_dbi_ro_wr_en(pci);
>> -		val = dw_pcie_readl_dbi(pci, GEN3_RELATED_OFF);
>> -		val &= ~GEN3_RELATED_OFF_GEN3_ZRXDC_NONCOMPL;
>> -		dw_pcie_writel_dbi(pci, GEN3_RELATED_OFF, val);
>> +		dw_pcie_clear_and_set_dword(pci, GEN3_RELATED_OFF,
>> +					    GEN3_RELATED_OFF_GEN3_ZRXDC_NONCOMPL, 0);
>>   		dw_pcie_dbi_ro_wr_dis(pci);
>>   	}
>>   }
>> --
>> 2.25.1
>>


