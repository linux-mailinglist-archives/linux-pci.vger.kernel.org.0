Return-Path: <linux-pci+bounces-21463-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C71E5A36062
	for <lists+linux-pci@lfdr.de>; Fri, 14 Feb 2025 15:29:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9FD171894CB2
	for <lists+linux-pci@lfdr.de>; Fri, 14 Feb 2025 14:29:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6DEE265CB6;
	Fri, 14 Feb 2025 14:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="I5cXHKML"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C4D35BAF0;
	Fri, 14 Feb 2025 14:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739543342; cv=none; b=Tn5lNFrrMgXCgZfO2acD6Oab64HDee4i5prhMVARyWQF7PItRLJN4LCwiTb8MOUSHtv9HLr95OxLFPI5Jmx6slDbj8LpoZ55Bf3i6IHGQ0rROmOHRr+qUvE2nG2nBoKI4RclOIoS4x97ayHl2zel0RYoQYjbZFDrXawBsG8+cFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739543342; c=relaxed/simple;
	bh=MrEM/iHmIbineORQLS8NmrG1GLmj/4CMf3zVWTU8Asc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tteqJhbrumLX5Tfsn05gPWrpG7kVgl2et+PJ6hHrZYCGUW7E+HEXQ69LJPqW/BTVJUOmh35apklKiLhmAI6pkJ9Y1EeiNsZ+5X8QpYto5auCpjI+YLGPuDFsUl6OvK88RHfDf40HmGenHRxk6IOsJ5MKox6fNfGI/Vz9RIZhbsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=I5cXHKML; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:From:
	Content-Type; bh=ZWPwF0vF6Snifzn+9M+0+9hnpb87+w9sonDEwMS6fNg=;
	b=I5cXHKML20836aQvCf1KDjmXYIdHk3/mIIaFz5L+MRZQoCqaRkjY1U0uOFX3iL
	lylQ1vxeyXuByRDPhy0e6qK8N6nrOGxPKBvAEHIFf1vNCDqXxLlhQ9T/CMVgTsWG
	zso7uH9njwPCaVXDvh5GGSQZmTyIwied5dLyzbetZO+mo=
Received: from [192.168.243.52] (unknown [])
	by gzga-smtp-mtada-g0-2 (Coremail) with SMTP id _____wD3Pw_8Uq9n_qCGMA--.61782S2;
	Fri, 14 Feb 2025 22:28:13 +0800 (CST)
Message-ID: <332ec463-ebd9-477c-8b10-157887343225@163.com>
Date: Fri, 14 Feb 2025 22:28:11 +0800
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
 <7eb9fedc-67c9-4886-9470-d747273f136c@163.com>
 <20250214132115.fpiqq65tqtowl2wa@thinkpad>
Content-Language: en-US
From: Hans Zhang <18255117159@163.com>
In-Reply-To: <20250214132115.fpiqq65tqtowl2wa@thinkpad>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_____wD3Pw_8Uq9n_qCGMA--.61782S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxZryUWFWxCr4kAr1kKFW3Wrg_yoW5tFy7pF
	W8GFyFyF1xXrW3ua1vvw4kGF13tan3tay7Wr4qk34xuFnF9FyUGFy7KFy5WrW5GrWvqr17
	ZwnFqF9rGFsIya7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UBVbkUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbBDxfzo2evIoSj1wACsQ



On 2025/2/14 21:21, Manivannan Sadhasivam wrote:
> On Fri, Feb 14, 2025 at 04:23:33PM +0800, Hans Zhang wrote:
>>
>>
>> On 2025/2/14 15:30, Manivannan Sadhasivam wrote:
>>> On Fri, Feb 07, 2025 at 06:39:23PM +0800, Hans Zhang wrote:
>>>> View from cdns document cdn_pcie_gen4_hpa_axi_ips_ug_v1.04.pdf.
>>>> In section 9.1.7.1 AXI Subordinate to PCIe Address Translation
>>>> Registers below:
>>>>
>>>> axi_s_awaddr bits 16 is 1 for MSG with data and 0 for MSG without data.
>>>>
>>>> Signed-off-by: hans.zhang <18255117159@163.com>
>>>> ---
>>>> Changes since v1-v2:
>>>> - Change email number and Signed-off-by
>>>> ---
>>>>    drivers/pci/controller/cadence/pcie-cadence-ep.c | 3 +--
>>>>    drivers/pci/controller/cadence/pcie-cadence.h    | 2 +-
>>>>    2 files changed, 2 insertions(+), 3 deletions(-)
>>>>
>>>> diff --git a/drivers/pci/controller/cadence/pcie-cadence-ep.c b/drivers/pci/controller/cadence/pcie-cadence-ep.c
>>>> index e0cc4560dfde..0bf4cde34f51 100644
>>>> --- a/drivers/pci/controller/cadence/pcie-cadence-ep.c
>>>> +++ b/drivers/pci/controller/cadence/pcie-cadence-ep.c
>>>> @@ -352,8 +352,7 @@ static void cdns_pcie_ep_assert_intx(struct cdns_pcie_ep *ep, u8 fn, u8 intx,
>>>>    	spin_unlock_irqrestore(&ep->lock, flags);
>>>>    	offset = CDNS_PCIE_NORMAL_MSG_ROUTING(MSG_ROUTING_LOCAL) |
>>>> -		 CDNS_PCIE_NORMAL_MSG_CODE(msg_code) |
>>>> -		 CDNS_PCIE_MSG_NO_DATA;
>>>> +		 CDNS_PCIE_NORMAL_MSG_CODE(msg_code);
>>>>    	writel(0, ep->irq_cpu_addr + offset);
>>>>    }
>>>> diff --git a/drivers/pci/controller/cadence/pcie-cadence.h b/drivers/pci/controller/cadence/pcie-cadence.h
>>>> index f5eeff834ec1..39ee9945c903 100644
>>>> --- a/drivers/pci/controller/cadence/pcie-cadence.h
>>>> +++ b/drivers/pci/controller/cadence/pcie-cadence.h
>>>> @@ -246,7 +246,7 @@ struct cdns_pcie_rp_ib_bar {
>>>>    #define CDNS_PCIE_NORMAL_MSG_CODE_MASK		GENMASK(15, 8)
>>>>    #define CDNS_PCIE_NORMAL_MSG_CODE(code) \
>>>>    	(((code) << 8) & CDNS_PCIE_NORMAL_MSG_CODE_MASK)
>>>> -#define CDNS_PCIE_MSG_NO_DATA			BIT(16)
>>>> +#define CDNS_PCIE_MSG_DATA			BIT(16)
>>>
>>> Oops! So how did you spot the issue? Did INTx triggering ever worked? RC should
>>> have reported it as malformed TLP isn't it?
>>>
>> In our first generation SOC, sending messages did not work, and the length
>> of messages was all 1. Cadence fixed this problem in the second generation
>> SOC. And I have verified in the EMU environment that it is OK to send
>> various messages, including INTx.
>>
>> And that's what Cadence's release documentation says:
>> axi_s_awaddr bits 16 is 1 for MSG with data and 0 for MSG without data.
> 
> I'm confused now. So the change in axi_s_awaddr bit applies to second generation
> SoCs only? What about the first ones?
> 
> Are you saying that the first generation SoCs can never send any message TLPs at
> all? This sounds horrible.


Sorry Mani, I shouldn't have spread this SOC bug. This is a bug in RTL 
design, the WSTRB signal of AXI bus is not connected correctly, so the 
first generation SOC cannot send message, because we mainly use RC mode, 
and we cannot send PME_Turn_OFF, that is, our SOC does not support L2. I 
have no choice about this, I entered the company relatively late, and 
our SOC has already TO.


This patch is to solve the Cadence common code bug, and does not conform 
to Cadence documentation.

Best regards
Hans



