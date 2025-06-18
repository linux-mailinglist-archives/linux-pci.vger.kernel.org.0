Return-Path: <linux-pci+bounces-30066-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9517FADEF59
	for <lists+linux-pci@lfdr.de>; Wed, 18 Jun 2025 16:29:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E8A04A4446
	for <lists+linux-pci@lfdr.de>; Wed, 18 Jun 2025 14:27:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 956942EE96F;
	Wed, 18 Jun 2025 14:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="U67lLJ8g"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 249D42EE983;
	Wed, 18 Jun 2025 14:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750256692; cv=none; b=eNtNuE10GEIpoHjb86t6c8N78VuXtrjspzbl0Hbt6ge4rQaBQVn4rEDn9QodYdkghVyuSxb6HZCM2fuwiMzGJ7nMgtcpFlc6prUyZYJgC9ohVh6/1B/Fc+ACsHXN+vRbSB/ddPWqZww317Y+tZUDdVhJ6Y58GWz5GdVuGzf//lM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750256692; c=relaxed/simple;
	bh=2DJvhQxFzEg6ADcIM1XmAmUVjvyMbKPZgoLzfUZ0cxM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q1fGxYanE1FjEolkmp8ElZbqfanCmdq8aRYwWmQCMqYmHp4lkh3ryvKHYZ1GsDPQgBLAK6+AND+O4FQX/dSPOwh1lTJ0ysXDhdb5e56V6WOevNY9XivWWihNjXdaxVSjS2HBPxq9NSgpW8UiQx4mxQ8XcjFsvBXlI7fSWowPywM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=U67lLJ8g; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=+pGl/jrl761RiW9nxGM87f6KLL0RhF44OQat3XVOQyI=;
	b=U67lLJ8gK2NC55sPi4QCQlSCWlz8xjhXGxNKAuNWd8vKXnxyrYSaofFIdqJQQ1
	t/q54Qt9VJGVxI6dCeQlGPlZIOjol5peYgxyrBUikw1Klso9I1L4sw9Wcp5Xpb2q
	UJls5cVEbHgwfCMcIKPoL4l18krsWk9DB4NGC8Hzjuj/Y=
Received: from [IPV6:240e:b8f:919b:3100:8440:da7c:be7e:927f] (unknown [])
	by gzsmtp2 (Coremail) with SMTP id PSgvCgBHMBgNzFJovnUQAA--.2192S2;
	Wed, 18 Jun 2025 22:24:13 +0800 (CST)
Message-ID: <145c8616-d595-4caf-980d-20eadc39d0bd@163.com>
Date: Wed, 18 Jun 2025 22:24:12 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] PCI: of: Relax max-link-speed check to support
 PCIe Gen5/Gen6
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: bhelgaas@google.com, lpieralisi@kernel.org, kw@linux.com,
 krzk+dt@kernel.org, manivannan.sadhasivam@linaro.org, conor+dt@kernel.org,
 robh@kernel.org, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org
References: <20250529021026.475861-1-18255117159@163.com>
 <20250529021026.475861-4-18255117159@163.com>
 <5baxv7vnmm46ye6egf6i54letsl6c6zcsle4aoaigxnve33pfk@qn33xy5wfghv>
Content-Language: en-US
From: Hans Zhang <18255117159@163.com>
In-Reply-To: <5baxv7vnmm46ye6egf6i54letsl6c6zcsle4aoaigxnve33pfk@qn33xy5wfghv>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PSgvCgBHMBgNzFJovnUQAA--.2192S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7AFWUAr1kJr1DCr4xAr45Awb_yoW8JFyUpa
	y7AryruF48XF43XF4UW3WrZa4jgas5WrZ7JryrW3WDuFnxJFsxta42vFWfuFn29FnrZr1S
	q3W2qr47Jr45JaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UenQUUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/1tbiOgBwo2hSykUnrgAAsV



On 2025/6/18 00:50, Manivannan Sadhasivam wrote:
> On Thu, May 29, 2025 at 10:10:26AM +0800, Hans Zhang wrote:
>> The existing code restricted `max-link-speed` to values 1~4 (Gen1~Gen4),
>> but current SOCs using Synopsys/Cadence IP may require Gen5/Gen6 support.
>> This patch updates the validation in `of_pci_get_max_link_speed` to allow
>> values up to 6, ensuring compatibility with newer PCIe generations.
>>
>> Signed-off-by: Hans Zhang <18255117159@163.com>
> 
> DT binding validation should be sufficient. But still...
> 
> Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>
> 

Dear Mani，

Thank you very much for your review.

Best regards,
Hans


> - Mani
> 
>> ---
>>   drivers/pci/of.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/pci/of.c b/drivers/pci/of.c
>> index ab7a8252bf41..379d90913937 100644
>> --- a/drivers/pci/of.c
>> +++ b/drivers/pci/of.c
>> @@ -890,7 +890,7 @@ int of_pci_get_max_link_speed(struct device_node *node)
>>   	u32 max_link_speed;
>>   
>>   	if (of_property_read_u32(node, "max-link-speed", &max_link_speed) ||
>> -	    max_link_speed == 0 || max_link_speed > 4)
>> +	    max_link_speed == 0 || max_link_speed > 6)
>>   		return -EINVAL;
>>   
>>   	return max_link_speed;
>> -- 
>> 2.25.1
>>
> 


