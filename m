Return-Path: <linux-pci+bounces-43302-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B5B4CCBFB1
	for <lists+linux-pci@lfdr.de>; Thu, 18 Dec 2025 14:23:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A893D3074FC3
	for <lists+linux-pci@lfdr.de>; Thu, 18 Dec 2025 13:19:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1B933148C5;
	Thu, 18 Dec 2025 13:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="igMD0w5O"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D285C322B93;
	Thu, 18 Dec 2025 13:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766063992; cv=none; b=MuO3PfFDzcMpXc98axZKfav6GpnbyYmcgYCD2LXLHDN1wAPrrAtwLwYMonTJ7+ZbRtfLYz5Vv178s85QPOXQxi7ApbTNyRjnpSWn+m0nlD1out3wFTcqRymjVIjDp+FMiFyzUDe0DDenguZwB8khiQkghsvHgE9Q+kNn5HszPtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766063992; c=relaxed/simple;
	bh=ZG70tTTgNSetu0D+CINSeTIbQU/b4fKhgFvP0u0CEL4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tK6vOjxBYJH53OVsbGTf89EYfx5mKiKaspHrnhhO5Hn3FCkiUVndlgIueuWC4z69DyTzE6OddrvTj774KiOR400p00y0FzdC7aonTg9TEEkCN/olMdxU+oSKuuyxkpxoJKRQ+VM8eOM0IRGK6lj5nY1p1m5Dveet4nNKfQe3ExE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=igMD0w5O; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=wxB2+5Uljhzy3KyRbfM5gFnaUX4l4IGLJWLDsX/gKes=;
	b=igMD0w5OnLl9zK061kMM5zemHE4J5U8lZJ94QtyZgYG2iyzSqdNDBVGiayKLEC
	uRR3aZLhRZmJ76fkD0J7IKmf0BXfBWiZXqQny5PAmNOTS2336Lz+IihZ2t8vLd1r
	m4z7irD11+puhjEnAXWdBGzeBAbPt7gjN7h/cLhC0SfeM=
Received: from [IPV6:240e:b8f:927e:1000:25d6:ba9d:e967:4b1c] (unknown [])
	by gzsmtp4 (Coremail) with SMTP id PygvCgDHz8Jc_0NpueqeHw--.237S2;
	Thu, 18 Dec 2025 21:19:27 +0800 (CST)
Message-ID: <0702df59-bad8-4bc1-84d6-11dbe9872af2@163.com>
Date: Thu, 18 Dec 2025 21:19:24 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/1] PCI: of: Remove max-link-speed generation
 validation
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: bhelgaas@google.com, helgaas@kernel.org, ilpo.jarvinen@linux.intel.com,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251218125909.305300-1-18255117159@163.com>
 <vpnjb4tip76yiy4uhn3frun6forrb57bq5czjvkx77uxt7ooc3@twemnyweabv6>
Content-Language: en-US
From: Hans Zhang <18255117159@163.com>
In-Reply-To: <vpnjb4tip76yiy4uhn3frun6forrb57bq5czjvkx77uxt7ooc3@twemnyweabv6>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:PygvCgDHz8Jc_0NpueqeHw--.237S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxWry3Xw45Ary7AFyfCrWxWFg_yoW5WrW3pF
	WjyFyF9FW8WrW3Ww4jg3WrZFyjq3Z3WrW8tryrWwnrZw15JF1SqFySgF1YvFn29Fs5Cr1I
	v3W2qa17G34qyaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zR3l1PUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbCwwBD5mlD-2CJIAAA36



On 2025/12/18 21:06, Manivannan Sadhasivam wrote:
> On Thu, Dec 18, 2025 at 08:59:09PM +0800, Hans Zhang wrote:
>> The current implementation of of_pci_get_max_link_speed() validates
>> max-link-speed property values to be in the range 1~4 (Gen1~Gen4).
>> However, this creates maintenance overhead as each new PCIe generation
>> requires updating this validation logic.
>>
>> Since device tree binding validation already enforces the allowed
>> values through the schema, and the callers of this function perform
>> their own validation checks, this intermediate validation becomes
>> redundant.
>>
>> Furthermore, with upcoming SOCs using Synopsys/Cadence IP requiring
>> Gen5/Gen6 support, removing this hardcoded check enables seamless
>> support for future PCIe generations without requiring kernel updates
>> for each new speed grade.
>>
>> Remove the max-link-speed > 4 validation check while retaining the
>> property existence and non-zero check. This simplifies maintenance
>> and aligns with the existing validation architecture where DT binding
>> and driver-level checks provide sufficient validation.
>>
>> Signed-off-by: Hans Zhang <18255117159@163.com>
>> ---
>> Changes for v5:
>> - Delete the check for speed. (Mani)
>>
>> Changes for v4:
>> https://patchwork.kernel.org/project/linux-pci/patch/20251105134701.182795-1-18255117159@163.com/
>>
>> - Add pcie_max_supported_link_speed.(Ilpo)
>>
>> Changes for v3:
>> https://patchwork.kernel.org/project/linux-pci/patch/20251101164132.14145-1-18255117159@163.com/
>>
>> - Modify the commit message.
>> - Add Reviewed-by tag.
>>
>> Changes for v2:
>> https://patchwork.kernel.org/project/linux-pci/cover/20250529021026.475861-1-18255117159@163.com/
>> - The following files have been deleted:
>>    Documentation/devicetree/bindings/pci/pci.txt
>>
>>    Update to this file again:
>>    dtschema/schemas/pci/pci-bus-common.yaml
>> ---
>>   drivers/pci/of.c | 3 +--
>>   1 file changed, 1 insertion(+), 2 deletions(-)
>>
>> diff --git a/drivers/pci/of.c b/drivers/pci/of.c
>> index 3579265f1198..1f8435780247 100644
>> --- a/drivers/pci/of.c
>> +++ b/drivers/pci/of.c
>> @@ -889,8 +889,7 @@ int of_pci_get_max_link_speed(struct device_node *node)
>>   {
>>   	u32 max_link_speed;
>>   
>> -	if (of_property_read_u32(node, "max-link-speed", &max_link_speed) ||
>> -	    max_link_speed == 0 || max_link_speed > 4)
>> +	if (of_property_read_u32(node, "max-link-speed", &max_link_speed))
>>   		return -EINVAL;
> 
> It'd be good to return the actual errno as of_property_read_u32() can return
> -EINVAL, -ENODATA and -EOVERFLOW.

Hi Mani

Will change.

Best regards,
Hans

> 
> With that change,
> 
> Acked-by: Manivannan Sadhasivam <mani@kernel.org>
> 
> - Mani
> 


