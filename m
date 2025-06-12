Return-Path: <linux-pci+bounces-29508-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F7CBAD64BB
	for <lists+linux-pci@lfdr.de>; Thu, 12 Jun 2025 02:48:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 05CC917D9BA
	for <lists+linux-pci@lfdr.de>; Thu, 12 Jun 2025 00:48:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C59C208CA;
	Thu, 12 Jun 2025 00:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="CyNcobQV"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5683A5258;
	Thu, 12 Jun 2025 00:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749689299; cv=none; b=oJQYFnSmF1FGqyxI/7kjgC+G0xeJRNCYSPSwhPolnQ3dVlOs1GNCibRymbQrdABShx9NqxuUQBYBh9eAQsBprKcov3ibzziCBLwCVPm8LhyXmSIn7PZc6hH8rMHyIa8CVj3+fQg1sRocYMi5VWHFAVsulPCF/URDech62rUjHTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749689299; c=relaxed/simple;
	bh=rzAXetcgYCh1V36mE0NcDkX0w2x4ZxWLJ7SX25U3hqU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kwxgXV0Ok8Jw/KG9zTFi6ezbo5eO9ZEMK4SBmANPtw1MaXBytKaz7hNrr33ur8pzw8aJfhMbwaia/5yOquzSyLP7RNTpyKBdoUzHhbVVY/rTxarWHTc8+9uwJ93AXkjNfzYhtwW7z3OiRRHs36qFIbPwHhfveR5yqfThU6EW/Rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=CyNcobQV; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=03CpQ0uFa1u0rSReeOB6H4LTBEb1QRsNXtybBT7HF48=;
	b=CyNcobQVLtsTLJdEouKEyFw3jmds+FznUHQdqtKtZWqBNcMbZBwL3Q4lj2EJGF
	wHR/TMvgDGdHjw976QEVi8Ea+7Sxm9nmlj+5lQvVY96vSSLbNfCHxaWBH+JB9pDM
	p2Jr9AtBHQ1kaInQodcLp36B+bcQBhQUNlgzPlBhfTC3E=
Received: from [192.168.18.52] (unknown [])
	by gzga-smtp-mtada-g1-0 (Coremail) with SMTP id _____wD3l7O8I0po1BvGIA--.58983S2;
	Thu, 12 Jun 2025 08:47:57 +0800 (CST)
Message-ID: <be51186a-5263-4322-8d26-7e98e67298ce@163.com>
Date: Thu, 12 Jun 2025 08:47:55 +0800
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
 <aEnONwJUSEMdMAUD@lizhi-Precision-Tower-5810>
Content-Language: en-US
From: Hans Zhang <18255117159@163.com>
In-Reply-To: <aEnONwJUSEMdMAUD@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_____wD3l7O8I0po1BvGIA--.58983S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxCr13Ar48Cw4UGw4xAF4DCFg_yoWruryDpa
	y2v3WSkF48JF4F9a1vya95ZF1aqas3Cr1UGanrKa4FqFy2yr9rWa10yrW3trn7CrW7tryj
	kw1UJw47X3W5tF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UbID7UUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbBDwFqo2hKH5lxVQAAsH



On 2025/6/12 02:43, Frank Li wrote:
> On Thu, Jun 12, 2025 at 12:31:21AM +0800, Hans Zhang wrote:
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
> 
> Sorry, where define dw_pcie_clear_and_set_dword() ?
> 

Dear Frank,

Thank you very much for your reply.

Please see the following link:
https://patchwork.kernel.org/project/linux-pci/patch/20250611163057.860353-1-18255117159@163.com/

Best regards,
Hans

>> Signed-off-by: Hans Zhang <18255117159@163.com>
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
> 
> supposed 3 args is mask. 0 should be PORT_LOGIC_SPEED_CHANGE.
> 
> Frank
> 
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


