Return-Path: <linux-pci+bounces-21483-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AE16CA3639B
	for <lists+linux-pci@lfdr.de>; Fri, 14 Feb 2025 17:51:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0BA6A18974B4
	for <lists+linux-pci@lfdr.de>; Fri, 14 Feb 2025 16:51:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D4E5267AF2;
	Fri, 14 Feb 2025 16:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="df9u/R4q"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60BE3262816;
	Fri, 14 Feb 2025 16:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739551845; cv=none; b=iqb6L7wHeqO+3Nc9BRKcqsfUuk0+IUymQBSYOCwDl2jemBaEFVxYvtb/3ZK18DgvOWu2WzH3I4ha/iNX3CkH5f8OFTBuZ1tcPr6lVf0YG8HupSA6e/ELnUnTVczEXtXYI/JDHHrbCxF+ezuslAKEaLAwAFVWBKrhyTK77Yw85T0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739551845; c=relaxed/simple;
	bh=ZU6Wdinzm0iDZJXAhUyBsz+0T7a7I/Jh6FasizolRAQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u8yc6R0SPAK0w9ktCC0ATWh8E5e5/PSVjkrc4RfI9jt5cJ0SWVTU9JfsBjfH6RW1nXi7+SfLt6nPYwLi8ISHT5BKOybptMZHtXxJO+3HXfqkAbBnsGcl9CriMTNVLgRnypkIQ113dCeoGFl86C5kb9MHxU+m4gczdUNHnHH3DB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=df9u/R4q; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:From:
	Content-Type; bh=yxx2jhgJ9WMamFCYuHMD3sgxZkNLWP78v874r2ZdjdM=;
	b=df9u/R4qHPyHivsWtg+3vCqvBuXF1FoKdzlLoQ+t0bkM+sjbGyjxxSOtVZzJeW
	cNSmzKKYsCBa+uT1SW+59KVm89PNDz5EYiN4TufJMy2bn+IqTKrlgIESD8JwVLRH
	azFKRZUfsXHJHTT+Uftlg8owi70T/L41Im4uPEz+qNfWs=
Received: from [192.168.71.44] (unknown [124.79.128.52])
	by gzsmtp5 (Coremail) with SMTP id QCgvCgDndyw3dK9nLdW4Nw--.28504S2;
	Sat, 15 Feb 2025 00:50:00 +0800 (CST)
Message-ID: <9ec0eab2-3320-45b2-8a65-7342de15f54d@163.com>
Date: Sat, 15 Feb 2025 00:49:59 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [v3] PCI: cadence: Fix sending message with data or without data
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: lpieralisi@kernel.org, kw@linux.com, manivannan.sadhasivam@linaro.org,
 robh@kernel.org, bhelgaas@google.com, bwawrzyn@cisco.com, cassel@kernel.org,
 wojciech.jasko-EXT@continental-corporation.com, a-verma1@ti.com,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, rockswang7@gmail.com
References: <20250207103923.32190-1-18255117159@163.com>
 <20250214160630.i3vbyl3e3a73onfa@thinkpad>
Content-Language: en-US
From: Hans Zhang <18255117159@163.com>
In-Reply-To: <20250214160630.i3vbyl3e3a73onfa@thinkpad>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:QCgvCgDndyw3dK9nLdW4Nw--.28504S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxZr4DZrW3Jw48JFWDtw18Xwb_yoW5XF4UpF
	W8GFySk3WxtrWa9an5Z3W5XF13tanIyF97Gw4v934xZFnrury8GF17tFyrGFWUWrWvqr1I
	y3WDtF9rGFsxA3JanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UVOJ5UUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbBDwLzo2evYzzwsQAAsL



On 2025/2/15 00:06, Manivannan Sadhasivam wrote:
> On Fri, Feb 07, 2025 at 06:39:23PM +0800, Hans Zhang wrote:
> 
> Subject should be changed as:
> 
> PCI: cadence-ep: Fix the driver to send MSG TLP for INTx without data payload

Okay.

>> View from cdns document cdn_pcie_gen4_hpa_axi_ips_ug_v1.04.pdf.
>> In section 9.1.7.1 AXI Subordinate to PCIe Address Translation
>> Registers below:
>>
>> axi_s_awaddr bits 16 is 1 for MSG with data and 0 for MSG without data.
>>
> 
> How about,
> 
> Cadence reference manual cdn_pcie_gen4_hpa_axi_ips_ug_v1.04.pdf, section
> 9.1.7.1 'AXI Subordinate to PCIe Address Translation' mentions that
> axi_s_awaddr bits 16 when set, corresponds to MSG with data and when not
> set, MSG without data.
> 
> But the driver is doing the opposite and due to this, INTx is never
> received on the host. So fix the driver to reflect the documentation and
> also make INTx work.

Thank you very much.

>> Signed-off-by: hans.zhang <18255117159@163.com>
> 
> Please add the Fixes tag also.
> 

Okay.

> 
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
>>   
>>   struct cdns_pcie;
>>   
>>
>> base-commit: bb066fe812d6fb3a9d01c073d9f1e2fd5a63403b
>> -- 
>> 2.47.1
>>
> 


