Return-Path: <linux-pci+bounces-21431-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15B31A358D2
	for <lists+linux-pci@lfdr.de>; Fri, 14 Feb 2025 09:27:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75FB13A4B88
	for <lists+linux-pci@lfdr.de>; Fri, 14 Feb 2025 08:26:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3307D2222D1;
	Fri, 14 Feb 2025 08:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="WySG346z"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD320221D9B;
	Fri, 14 Feb 2025 08:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739521603; cv=none; b=m7kzjmE1MgaQRgYdT/CdddqE4AHKm5Y2ogiEACXl5T+Rfx7uLWXp44Xg1rcvebONZHCSCny3a3Xoi9olVFScikLQuuT5O/ooXVKRnj/SG/64tZ0UMb57NW8nfEHE4+YFkooA2VyL2r8u5UUD/s2JwASjMiLuC0s8mGNV47btakk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739521603; c=relaxed/simple;
	bh=b2MiWfQHSB0RAB0pmFHuqacCfz92l6CK7wHPtW/rt94=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Cg82gUTXxfGMsDDnHH1vgOc6kZ5zxd1Yrr2PkcYd6gVfuLInlE0sD/DbNBxt7HgoqcjJostUjcAVU9Y2zPJ8x9tYMrJCga7vXZTCcbBKreAE24c2s5P7O3fdsSqGlIW+u4alVwqnH0Tus46T6AGjB6Lqt79K/U16XEVNj73x4TU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=WySG346z; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:From:
	Content-Type; bh=xnxR2UO6iMifdgzSi2xLADILm1SOZ4TrzsLhURcsqJ0=;
	b=WySG346z1/VS/KXE6t1xl/LfFVDscC3exq0jV0ZI2Mf9f2SR6cpjvDxyMGiegL
	gyq+xyCcZ3aHzlw2DveOASaQ2Qgs5y1paib46G69NMr7ZePkeO41HiH2iokyN9kg
	K69/7YcU6LsGgK9IUPC/gaPMdft3F+AY0/AE2B43OXM9A=
Received: from [192.168.243.52] (unknown [])
	by gzga-smtp-mtada-g1-0 (Coremail) with SMTP id _____wD3nxuF_a5nW8PgMA--.37922S2;
	Fri, 14 Feb 2025 16:23:34 +0800 (CST)
Message-ID: <7eb9fedc-67c9-4886-9470-d747273f136c@163.com>
Date: Fri, 14 Feb 2025 16:23:33 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [v3] PCI: cadence: Fix sending message with data or without data
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: lpieralisi@kernel.org, kw@linux.com, robh@kernel.org,
 bhelgaas@google.com, bwawrzyn@cisco.com, cassel@kernel.org,
 wojciech.jasko-EXT@continental-corporation.com, a-verma1@ti.com,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, rockswang7@gmail.com
References: <20250207103923.32190-1-18255117159@163.com>
 <20250214073030.4vckeq2hf6wbb4ez@thinkpad>
Content-Language: en-US
From: Hans Zhang <18255117159@163.com>
In-Reply-To: <20250214073030.4vckeq2hf6wbb4ez@thinkpad>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_____wD3nxuF_a5nW8PgMA--.37922S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxGF1xXw4xXryxJrW8uFy7Awb_yoW5XFW3pF
	W8GFyFy3WxtrW3ua1kZ3W8GF13tan3tay7Gw4q934fuFnrZFy8GF129F15JFWUGrWvqr12
	yw4DtF9rKFsIyFUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UHVbkUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/1tbiWxvzo2eu9yyeNgAAsq



On 2025/2/14 15:30, Manivannan Sadhasivam wrote:
> On Fri, Feb 07, 2025 at 06:39:23PM +0800, Hans Zhang wrote:
>> View from cdns document cdn_pcie_gen4_hpa_axi_ips_ug_v1.04.pdf.
>> In section 9.1.7.1 AXI Subordinate to PCIe Address Translation
>> Registers below:
>>
>> axi_s_awaddr bits 16 is 1 for MSG with data and 0 for MSG without data.
>>
>> Signed-off-by: hans.zhang <18255117159@163.com>
>> ---
>> Changes since v1-v2:
>> - Change email number and Signed-off-by
>> ---
>>   drivers/pci/controller/cadence/pcie-cadence-ep.c | 3 +--
>>   drivers/pci/controller/cadence/pcie-cadence.h    | 2 +-
>>   2 files changed, 2 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/pci/controller/cadence/pcie-cadence-ep.c b/drivers/pci/controller/cadence/pcie-cadence-ep.c
>> index e0cc4560dfde..0bf4cde34f51 100644
>> --- a/drivers/pci/controller/cadence/pcie-cadence-ep.c
>> +++ b/drivers/pci/controller/cadence/pcie-cadence-ep.c
>> @@ -352,8 +352,7 @@ static void cdns_pcie_ep_assert_intx(struct cdns_pcie_ep *ep, u8 fn, u8 intx,
>>   	spin_unlock_irqrestore(&ep->lock, flags);
>>   
>>   	offset = CDNS_PCIE_NORMAL_MSG_ROUTING(MSG_ROUTING_LOCAL) |
>> -		 CDNS_PCIE_NORMAL_MSG_CODE(msg_code) |
>> -		 CDNS_PCIE_MSG_NO_DATA;
>> +		 CDNS_PCIE_NORMAL_MSG_CODE(msg_code);
>>   	writel(0, ep->irq_cpu_addr + offset);
>>   }
>>   
>> diff --git a/drivers/pci/controller/cadence/pcie-cadence.h b/drivers/pci/controller/cadence/pcie-cadence.h
>> index f5eeff834ec1..39ee9945c903 100644
>> --- a/drivers/pci/controller/cadence/pcie-cadence.h
>> +++ b/drivers/pci/controller/cadence/pcie-cadence.h
>> @@ -246,7 +246,7 @@ struct cdns_pcie_rp_ib_bar {
>>   #define CDNS_PCIE_NORMAL_MSG_CODE_MASK		GENMASK(15, 8)
>>   #define CDNS_PCIE_NORMAL_MSG_CODE(code) \
>>   	(((code) << 8) & CDNS_PCIE_NORMAL_MSG_CODE_MASK)
>> -#define CDNS_PCIE_MSG_NO_DATA			BIT(16)
>> +#define CDNS_PCIE_MSG_DATA			BIT(16)
> 
> Oops! So how did you spot the issue? Did INTx triggering ever worked? RC should
> have reported it as malformed TLP isn't it?
> 
In our first generation SOC, sending messages did not work, and the 
length of messages was all 1. Cadence fixed this problem in the second 
generation SOC. And I have verified in the EMU environment that it is OK 
to send various messages, including INTx.

And that's what Cadence's release documentation says:
axi_s_awaddr bits 16 is 1 for MSG with data and 0 for MSG without data.
The final verification results are also consistent with the 
documentation description.

Due to the RTL bug in Cadence IP of our SOC in the first generation, the 
AER Error reported at that time was Unsupported Request Error Status.

Best regards
Hans


