Return-Path: <linux-pci+bounces-40345-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BCE3C35E59
	for <lists+linux-pci@lfdr.de>; Wed, 05 Nov 2025 14:45:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA0CF18C69F1
	for <lists+linux-pci@lfdr.de>; Wed,  5 Nov 2025 13:45:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 583BE324B30;
	Wed,  5 Nov 2025 13:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="c3cD09nn"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E73A3321457;
	Wed,  5 Nov 2025 13:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762350313; cv=none; b=QbuSt2pX8NDsN0qlNeHRW5vlgO3gsBQy3W/0yDjk8cNqHUtPqz7Q6dyyq6j9tReG9yvXHnGdLXH5eV25LWme2VkkIrqfEqiJOzhy2mez0F0rrqK3OH+ZIkzrpM/pj3kVk3BeQDQ8X5G9z3PbdG5l1XtAF+Y6fYW+SB1TTGsUmo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762350313; c=relaxed/simple;
	bh=yKNA3oVVzi0L+e9kUYLujTvxg6mYCSlJKCPM3ACEjxQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Nu6zn1Oviy4M3zhr1UnXAP9qA/nfNvjAhaJGhDAIJSgWeoxCypFa8gxg75/9DTB8BBifMIpYx4GLjjNthvWQxhGu4jrEnyBu76LWYECVWP9IPSeYglQBNcmf+nrUmFlNQac/K957s6xFeE2Zjf3tp7kS4UJfn+YtjF7Tbyi8Jno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=c3cD09nn; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=YiTt2ITrdK+2NIR80LhtxcCKhBuNYvfqzXfa02zC0r4=;
	b=c3cD09nn1x1DhCqk/InIc45fPVO+PRgaAIOZbswRlbPpyVROl0Ezg0/pwzkHJy
	LOY8TwPUbB6itnHttrPB6s9CPJuwDz/OYXl9jFkOr16uRoH++rHsVGM3I4f10njn
	ptiXOscQlRzDpe0wtVdrLmVhaNt3LtOUf/iphrP9X1VmE=
Received: from [IPV6:240e:b8f:927e:1000:46aa:8d7c:6cdf:9166] (unknown [])
	by gzga-smtp-mtada-g0-3 (Coremail) with SMTP id _____wCXW0_NVAtpSH37Bg--.5793S2;
	Wed, 05 Nov 2025 21:44:45 +0800 (CST)
Message-ID: <0bc327b3-ea1d-4d70-ba51-e79fd386f6fe@163.com>
Date: Wed, 5 Nov 2025 21:44:45 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/1] PCI: of: Relax max-link-speed check to support
 PCIe Gen5/Gen6
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: bhelgaas@google.com, helgaas@kernel.org, linux-pci@vger.kernel.org,
 LKML <linux-kernel@vger.kernel.org>, Manivannan Sadhasivam <mani@kernel.org>
References: <20251101164132.14145-1-18255117159@163.com>
 <6fdc4f2c-16fa-9aed-6580-759e229e5606@linux.intel.com>
 <eba1f55e-3396-052c-0d77-09bf8b8c8216@linux.intel.com>
Content-Language: en-US
From: Hans Zhang <18255117159@163.com>
In-Reply-To: <eba1f55e-3396-052c-0d77-09bf8b8c8216@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wCXW0_NVAtpSH37Bg--.5793S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxGw4xZrWDKr18Jr1rKw1Utrb_yoW5GFyrpa
	y7AF1FkFW8Xr43ur4vg3WFvFy0qF9xJrWjqry5Gw1DuFnxKF43JFyS9F4a9Fna9r4xCr12
	qr43tay3Gw4jyaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07U45lnUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbCww9lCWkLVM92hwAA3o



On 2025/11/5 16:45, Ilpo Järvinen wrote:
> On Wed, 5 Nov 2025, Ilpo Järvinen wrote:
> 
>> On Sun, 2 Nov 2025, Hans Zhang wrote:
>>
>>> The existing code restricted `max-link-speed` to values 1~4 (Gen1~Gen4),
>>> but current SOCs using Synopsys/Cadence IP may require Gen5/Gen6 support.
>>>
>>> While DT binding validation already checks this property, the code-level
>>> validation in `of_pci_get_max_link_speed` also needs to be updated to allow
>>> values up to 6, ensuring compatibility with newer PCIe generations.
>>>
>>> Signed-off-by: Hans Zhang <18255117159@163.com>
>>> Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>
>>> ---
>>> Changes for v3:
>>> - Modify the commit message.
>>> - Add Reviewed-by tag.
>>>
>>> Changes for v2:
>>> https://patchwork.kernel.org/project/linux-pci/cover/20250529021026.475861-1-18255117159@163.com/
>>> - The following files have been deleted:
>>>    Documentation/devicetree/bindings/pci/pci.txt
>>>
>>>    Update to this file again:
>>>    dtschema/schemas/pci/pci-bus-common.yaml
>>> ---
>>>   drivers/pci/of.c | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/pci/of.c b/drivers/pci/of.c
>>> index 3579265f1198..53928e4b3780 100644
>>> --- a/drivers/pci/of.c
>>> +++ b/drivers/pci/of.c
>>> @@ -890,7 +890,7 @@ int of_pci_get_max_link_speed(struct device_node *node)
>>>   	u32 max_link_speed;
>>>   
>>>   	if (of_property_read_u32(node, "max-link-speed", &max_link_speed) ||
>>> -	    max_link_speed == 0 || max_link_speed > 4)
>>> +	    max_link_speed == 0 || max_link_speed > 6)
>>>   		return -EINVAL;
>>>   
>>>   	return max_link_speed;
>>>
>>
>> Hi,
>>
>> IMO, using a literal here is somewhat annoying as it's hard to find this
>> spot when adding support to the next PCIe Link Speed. It would be nice if
>> it could get updated at the same while the generic support for a new Link
>> Speed is added.
>>
>> Perhaps include/linux/pci.h should have something along the lines of:
>>
>> static inline int pcie_max_supported_link_speed()
>> {
>> 	return PCI_EXP_LNKCAP_SLS_64_0GB - PCI_EXP_LNKCAP_SLS_2_5GB + 1;
>> }
> 
> ...Or maybe put it just to drivers/pci/pci.h instead.
> 
>> Then replace that 6 with pcie_max_supported_link_speed().
>>
>> So when the next speed get's added, somebody grepping for
>> PCI_EXP_LNKCAP_SLS_64_0GB will find pcie_max_supported_link_speed() has
>> to be changed and the change will propagate also to of.c.
>>
>>
> 

Hi Ilpo,

Thank you very much for your reply. Your feedback is so great. I will 
resubmit a version. Thank you again.

Best regards,
Hans



