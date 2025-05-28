Return-Path: <linux-pci+bounces-28494-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E7E73AC6151
	for <lists+linux-pci@lfdr.de>; Wed, 28 May 2025 07:42:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B716E4A522A
	for <lists+linux-pci@lfdr.de>; Wed, 28 May 2025 05:42:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19C4A20296A;
	Wed, 28 May 2025 05:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="P0qNcj8n"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58EA71F1501;
	Wed, 28 May 2025 05:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748410932; cv=none; b=KH4fxN9DUpTcOxjRvtoW+mesRSNfna6CvTMj97tIJMQRPsYIXwpgXgJuAIFeda6Mm0k2lAgSBVVInCnT14PSakFXQuefoHzLq9NOVmlr/GhoInrdSoL2okSa1ZLF7rec/xkb2vZw0ratxz3CCDBX8HN//I1fNmA9iKDhO8wo6LM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748410932; c=relaxed/simple;
	bh=BWX7HpTW3OUC/DXzs/Slwsj37HTERtYVXU2MLM3qzqk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GUuQzw/77H3Ft1TLMKnnDut05aLvkMlcu6Siyi/umtXk69+w7htJ34BNqJNSR2JjNCCTuhc1No16AXGYjXZ68YAfffKCLedi4OYZTDqq0b1Tksl5PaYYvnaZZK7g9Y2J5WTqf8EO2dZRqSW2avHGvgOAwLTQV7phqEAko9OydaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=P0qNcj8n; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=OKZVR5pHZSlScBzOKZd5xLcnKSixLDKu3f4FcAXfbe8=;
	b=P0qNcj8n7xwDw02AREIY+oMgV65ROf65kP7GsZNM4byewFyhj+Yc4ULBZFUfEe
	tYvbGY8sUGDpDPkFB0UOgEy1GGCQ22KcmwdGzVP2wLHfU5/rDVV2mjzIrJu3mMFE
	gFCV02nwm+kzg4uk4ZfVZKz/jD8It068OnJxQzF4/kTcM=
Received: from [192.168.18.52] (unknown [])
	by gzsmtp4 (Coremail) with SMTP id PygvCgBX7u4LojZoIdomBA--.25001S2;
	Wed, 28 May 2025 13:41:32 +0800 (CST)
Message-ID: <c2ddb1ad-72f9-4ebc-8d6a-3c9d7fa559e4@163.com>
Date: Wed, 28 May 2025 13:41:30 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] dt-bindings: PCI: Extend max-link-speed to support
 PCIe Gen5/Gen6
To: Rob Herring <robh@kernel.org>
Cc: bhelgaas@google.com, lpieralisi@kernel.org, kw@linux.com,
 krzk+dt@kernel.org, manivannan.sadhasivam@linaro.org, conor+dt@kernel.org,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org
References: <20250519160448.209461-1-18255117159@163.com>
 <20250519160448.209461-2-18255117159@163.com>
 <20250527193550.GA1104855-robh@kernel.org>
Content-Language: en-US
From: Hans Zhang <18255117159@163.com>
In-Reply-To: <20250527193550.GA1104855-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:PygvCgBX7u4LojZoIdomBA--.25001S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxJF1rJFW5Kw1xGFy8tryUGFg_yoW8CF4xpa
	yrCF1xtFWrJr17Wa97X3WfAw4Yq3srAayYkF98G347tFsxZFnYyw4agF15XF1kZryxZFWI
	qF4Y9F13C3WDAFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07U0jgxUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/1tbiOh5ao2g2EbKL5QABsP



On 2025/5/28 03:35, Rob Herring wrote:
> On Tue, May 20, 2025 at 12:04:46AM +0800, Hans Zhang wrote:
>> Update the device tree binding documentation for PCI to include
>> PCIe Gen5 and Gen6 support in the `max-link-speed` property.
>> The original documentation limited the value to 1~4 (Gen1~Gen4),
>> but the kernel now supports up to Gen6. This change ensures the
>> documentation aligns with the actual code implementation.
>>
>> Signed-off-by: Hans Zhang <18255117159@163.com>
>> ---
>>   Documentation/devicetree/bindings/pci/pci.txt | 5 +++--
>>   1 file changed, 3 insertions(+), 2 deletions(-)
> 
> This file is now removed. Update the schema if you need to. It lives in
> dtschema project.
> 

Dear Rob,

Thank you very much for your reply and reminder. I will resubmit in the 
next version.

Best regards,
Hans

>>
>> diff --git a/Documentation/devicetree/bindings/pci/pci.txt b/Documentation/devicetree/bindings/pci/pci.txt
>> index 6a8f2874a24d..5ffd690e3fc7 100644
>> --- a/Documentation/devicetree/bindings/pci/pci.txt
>> +++ b/Documentation/devicetree/bindings/pci/pci.txt
>> @@ -22,8 +22,9 @@ driver implementation may support the following properties:
>>      If present this property specifies PCI gen for link capability.  Host
>>      drivers could add this as a strategy to avoid unnecessary operation for
>>      unsupported link speed, for instance, trying to do training for
>> -   unsupported link speed, etc.  Must be '4' for gen4, '3' for gen3, '2'
>> -   for gen2, and '1' for gen1. Any other values are invalid.
>> +   unsupported link speed, etc.  Must be '6' for gen6, '5' for gen5, '4' for
>> +   gen4, '3' for gen3, '2' for gen2, and '1' for gen1. Any other values are
>> +   invalid.
>>   - reset-gpios:
>>      If present this property specifies PERST# GPIO. Host drivers can parse the
>>      GPIO and apply fundamental reset to endpoints.
>> -- 
>> 2.25.1
>>


