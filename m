Return-Path: <linux-pci+bounces-23329-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AFB6A5993E
	for <lists+linux-pci@lfdr.de>; Mon, 10 Mar 2025 16:11:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5636416DE11
	for <lists+linux-pci@lfdr.de>; Mon, 10 Mar 2025 15:11:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED78C22DF8A;
	Mon, 10 Mar 2025 15:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="UR/FD+r+"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 153C222D4DC;
	Mon, 10 Mar 2025 15:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741619474; cv=none; b=atFanMx5pL6+ud/gGzd/RgstUjXBbGgyMjiQCgv5CFC4ih3Fw3Kbl51BpYz6N8WXcXWLzrQh4ShNA7A+imdv7SCYLImxbt1UlecrX/sdlBpO4LcAPYIYxxmTNzly9tA3gXwZsJLtDhnOM4doGC0u9YKzUguX/KPcuOxYqVe65e4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741619474; c=relaxed/simple;
	bh=QMcsbQVKT+fiuPq7AGkPf+0PAMbG6qvWcqcMmQ+Wr0c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sfy1RXIV/hoe3cCJDzpI6EGb1Mt14ifGvBvbO+jgf8lec5ai+jBVICDiq0+2wrACSvyWqtZugQc11HsnL3o0OxSqpZJjLBmxTd7PO0EYyQqqXkjxS/fjZPGJKR+chD9ctXFzlOynkFkZatwZAUaQZbbj4jWseoxw3KObU4n+D1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=UR/FD+r+; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:From:
	Content-Type; bh=RJdV8dINmj0DyHz22Fro0RD9n3L+kRh/ucEwMBwHgpM=;
	b=UR/FD+r+IyZhYJy7xAFkU4MSoKiS3ogTViwPKaS2CYi2flIrr1M7I/cpImtpEr
	bEJor8ITunQwdcql9KgAlUXT8StrXUqU+Nh4TpBatwBO47+WsMw7GpIgzgK7yceQ
	np49Tk/ncox8QaK5kjwWg+8SEFAIdSi7Icrc8e3ikeRqk=
Received: from [192.168.71.45] (unknown [])
	by gzga-smtp-mtada-g1-0 (Coremail) with SMTP id _____wDnvyTAAM9nvU1pRw--.5995S2;
	Mon, 10 Mar 2025 23:09:53 +0800 (CST)
Message-ID: <9eee0ab5-d870-451d-bf38-41578f487854@163.com>
Date: Mon, 10 Mar 2025 23:09:54 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [v2] PCI: cadence: Add configuration space capability search API
To: Siddharth Vadapalli <s-vadapalli@ti.com>
Cc: lpieralisi@kernel.org, kw@linux.com, manivannan.sadhasivam@linaro.org,
 robh@kernel.org, bhelgaas@google.com, bwawrzyn@cisco.com,
 thomas.richard@bootlin.com, wojciech.jasko-EXT@continental-corporation.com,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250308133903.322216-1-18255117159@163.com>
 <20250309023839.2cakdpmsbzn6pm7g@uda0492258>
 <3e6645a8-6de9-4125-8444-fa1a4f526881@163.com>
 <20250309054835.4ydiq4xpguxtbvkf@uda0492258>
 <bf9fc865-58b9-45ed-a346-ce82899d838c@163.com>
 <20250309100243.ihrxe6vfdugzpzsn@uda0492258>
Content-Language: en-US
From: Hans Zhang <18255117159@163.com>
In-Reply-To: <20250309100243.ihrxe6vfdugzpzsn@uda0492258>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_____wDnvyTAAM9nvU1pRw--.5995S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxGF4fAFy8Xr1xZF1UWry5CFg_yoW5AF18pF
	4Dtryay3WDJa1fZ3s7Ww4vgFyfZ3s7Jw15GF98Kwn5AwsIga42kF4Yyr1rua9rCrZ2qF1j
	vrW3Xas7CFZ8JaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UVMKtUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbBDwsMo2fO+J-xnQAAsJ



On 2025/3/9 18:02, Siddharth Vadapalli wrote:
>> Hi Siddharth,
>>
>> Prior to this patch, I don't think hard-coded is that reasonable. Because
>> the SOC design of each company does not guarantee that the offset of each
>> capability is the same. This parameter can be configured when selecting PCIe
>> configuration options. The current code that just happens to hit the offset
>> address is the same.
> 
> 1. You are modifying the driver for the Cadence PCIe Controller IP and
> not the one for your SoC (a.k.a the application/glue/wrapper driver).
> 2. The offsets are tied to the Controller IP and not to your SoC. Any
> differences that arise due to IP Integration into your SoC should be
> handled in the Glue driver (the one which you haven't upstreamed yet).
> 3. If the offsets in the Controller IP itself have changed, this
> indicates a different IP version which has nothing to do with the SoC
> that you are using.
> 
> Please clarify whether you are facing problems with the offsets due to a
> difference in the IP Controller Version, or due to the way in which the IP
> was integrated into your SoC.
> 

Hi Siddharth,

I have consulted several PCIe RTL designers in the past two days. They 
told me that the controller IP of Synopsys or Cadence can be configured 
with the offset address of the capability. I don't think it has anything 
to do with SOC, it's just a feature of PCIe controller IP. In 
particular, the number of extended capability is relatively large. When 
RTL is generated, one more configuration may cause the offset addresses 
of extended capability to be different. Therefore, it is unreasonable to 
assign all the offset addresses in advance.

Here, I want to make Cadence PCIe common driver more general. When we 
keep developing new SoCs, the capability or extended capability offset 
address may eventually be inconsistent.

Thank you very much Siddharth for discussing this patch with me. I would 
like to know what other maintainers have to say about this.

>>
>> You can refer to the pci_find_*capability() or dw_pcie_find_*capability API.
>> The meaning of their appearance is the same as what I said, and the design
>> of each company may be different.
> 
> These APIs exits since there are multiple users with different Controllers
> (in the case of pci_find_*capability()) or different versions of the
> Controller (in the case of dw_pcie_find_*capability) due to which we cannot
> hard-code offsets. In the case of the Cadence PCIe Controller, I see only
> one user in Upstream Linux at the moment which happens to be the
> "pci-j721e.c" driver. Maybe there are other users, but the offsets seem
> to be compatible with their SoCs in that case.

Yes. Cadence definitely has a lot of customers, and from what I 
understand, not every customer wants to go upstream on their drive. Most 
of these customers are just local modifications, probably mimicking the 
API that the dwc driver already uses. We are, for example.

Best regards,
Hans



