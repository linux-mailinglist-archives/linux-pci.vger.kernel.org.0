Return-Path: <linux-pci+bounces-24931-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 53BCEA7486D
	for <lists+linux-pci@lfdr.de>; Fri, 28 Mar 2025 11:37:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C3C83B4D2F
	for <lists+linux-pci@lfdr.de>; Fri, 28 Mar 2025 10:37:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CA6B1C174E;
	Fri, 28 Mar 2025 10:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="JJaZ6yyd"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B2454A35;
	Fri, 28 Mar 2025 10:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743158263; cv=none; b=ZDNnaVxQpgrHipsvyAe+8F3cyytrmDKXm/oYUNJvnpyaeNqrtkAwhgFteT160KY2SH1AXLtuUwq8QG2XaOU4ockLt50j1VHJ/37TwNTOhKRNZofHA70IrL3FO2Y9gsYVGG3vVajqWFMxEWnf2hguOLRjYF6qcGBMJrD7li4zWEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743158263; c=relaxed/simple;
	bh=RQ87awM6i41scoynOvduNSQIKE3lzz/f6tmL1gIJyVM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NIGzQk1JTZLEBgd6I0yA6rv+36NyGkg3OULjeQIoBpjfvxw2vNQKg19WjWgGHIco6DU+i8l8TyVsQikggvw3A8gC5HYDJtA8nwJMuwwHgBqcSu9IFEH95rWNUeyTcwLDWOC0Vy2iUcQJWSL4a9RmiurHfkXXa8JH9yK1sVfJSJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=JJaZ6yyd; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:From:
	Content-Type; bh=qfYs8RPda9ZUYc5Un8iQbHHWtbo82BVkP1+oi5eU9m0=;
	b=JJaZ6yyd5ZxBkVYjsSg5Nc4aXEDGJYe733qi2XuzrlwDyixD7T787pHAWzmKuL
	mMyn3N2gK7c4AgqG1fTBAPvqHmlrn69p+I3woXZhBF0vxTeiv17efZpBpeab4nIJ
	UZOyaHBBy343e3uQ+OgtaQO5XURUWUo7Pof+yb/VEjpN4=
Received: from [192.168.60.52] (unknown [])
	by gzga-smtp-mtada-g0-1 (Coremail) with SMTP id _____wC3j3yte+Znmt0YCg--.34641S2;
	Fri, 28 Mar 2025 18:36:30 +0800 (CST)
Message-ID: <fc7b4f0a-91bf-4680-be75-47df8c87e5a0@163.com>
Date: Fri, 28 Mar 2025 18:36:28 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [v6 5/5] MAINTAINERS: Add entry for PCI host controller helpers
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: lpieralisi@kernel.org, kw@linux.com, robh@kernel.org,
 bhelgaas@google.com, jingoohan1@gmail.com, thomas.richard@bootlin.com,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250323164852.430546-1-18255117159@163.com>
 <20250323164852.430546-6-18255117159@163.com>
 <qbqkt53c27zwaetm7faqleqypy7yuxjfdcbukd3vd6t4p3tiwq@jtrk4524wsjr>
Content-Language: en-US
From: Hans Zhang <18255117159@163.com>
In-Reply-To: <qbqkt53c27zwaetm7faqleqypy7yuxjfdcbukd3vd6t4p3tiwq@jtrk4524wsjr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_____wC3j3yte+Znmt0YCg--.34641S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7JF1kJFyrWFW3Ww4rWF18AFb_yoWkuwc_ur
	4UCFWxArWUKFyIkanYkFZFyryYyw47tF1Fga4ktwnrAayrJFZ8trn3J3sa9w1UGrs3Grsx
	ZF90yF4Ikry3ujkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUUQJ55UUUUU==
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbBDxoeo2fmdBbYUAAAsD



On 2025/3/28 01:01, Manivannan Sadhasivam wrote:
> On Mon, Mar 24, 2025 at 12:48:52AM +0800, Hans Zhang wrote:
>> Add maintenance entry for the newly introduced PCI host controller helper
>> functions. These functions provide common infrastructure for capability
>> scanning and other shared operations across PCI host controller drivers.
>>
>> Signed-off-by: Hans Zhang <18255117159@163.com>
>> ---
>>   MAINTAINERS | 6 ++++++
>>   1 file changed, 6 insertions(+)
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 00e94bec401e..9b3236704b83 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -18119,6 +18119,12 @@ S:	Maintained
>>   F:	Documentation/devicetree/bindings/pci/intel,ixp4xx-pci.yaml
>>   F:	drivers/pci/controller/pci-ixp4xx.c
>>   
>> +PCI DRIVER FOR HELPER FUNCTIONS
>> +M:	Hans Zhang <18255117159@163.com>
>> +L:	linux-pci@vger.kernel.org
>> +S:	Maintained
>> +F:	drivers/pci/controller/pci-host-helpers.c
> 
> I don't see much value in maintaining this file separately as these helpers are
> not going to evolve much, thus not needing separate maintenance.
> 

Hi Mani,

Thanks your for reply. Will delete.

Best regards,
Hans


