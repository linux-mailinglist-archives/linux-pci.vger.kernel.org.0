Return-Path: <linux-pci+bounces-22621-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 79A45A49448
	for <lists+linux-pci@lfdr.de>; Fri, 28 Feb 2025 10:01:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A4BD318943A9
	for <lists+linux-pci@lfdr.de>; Fri, 28 Feb 2025 09:01:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5742E1E8321;
	Fri, 28 Feb 2025 09:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="Rm3YVtzh"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7535255E3B;
	Fri, 28 Feb 2025 09:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740733268; cv=none; b=sSUZ1c5WUmjubU6ErvI9PLXEI1WJEzpuJC425TTgJbrns9/AkMVhL+nDb7sBZqQySzwLxQxOAJFjs4HjpO1ggX/ZS3IyVpEkPgUxYQLbMQleHfTimr8souz9Pg2kQ9VgaGuwyNC5eUUrLGGV770+Zr6QYZeQD7LLpdFYb6f39+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740733268; c=relaxed/simple;
	bh=zKrcIFrclyOGfQUXyUn6MaoJojyv/MvCl+HCcUqvmOY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qP1ES611qfMys9TMmLlyGiqXJ11sbfjGzIXW4ob5O3LY1/qy3km5m1KlAoVW2WEBSYb58rKt9F8AAsJ4CfEX99ORQvbje3FJIk+DIu5ISzkcJLw3LWe0izIKIrTikV2VLvT8ragqA3vOVxeprjYHB/b8HBvx72BYLeFNp0f7Iqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=Rm3YVtzh; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:From:
	Content-Type; bh=22YFTJcKm8NjTIDk8c5vro1lpPOD/KWOFdJohyC6a9k=;
	b=Rm3YVtzht+DE7sclvNWjM+I8N6j9ytKj4I3S1NZ7iSlrND5y+z8t/ovM+oyYqC
	3eMl5BS2qOw9hGgck05VOsfdg+jfRTW6woXfJu9QrQ3+VXWyg/AwCcTcXhlPMR/S
	qqXc6CYs4UWP/tTNWGyzc9bKDDdyxOSnuiYKqtqaL8JR0=
Received: from [192.168.34.52] (unknown [])
	by gzga-smtp-mtada-g1-2 (Coremail) with SMTP id _____wAH+C0me8Fnbdn5PA--.9176S2;
	Fri, 28 Feb 2025 17:00:24 +0800 (CST)
Message-ID: <d3bfa9c9-bf72-4ddc-bed3-1fe9ef88d518@163.com>
Date: Fri, 28 Feb 2025 17:00:22 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] genirq/msi: Add the address and data that show MSI/MSIX
To: Frank Li <Frank.li@nxp.com>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 tglx@linutronix.de, kw@linux.com, kwilczynski@kernel.org,
 bhelgaas@google.com, cassel@kernel.org, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250227162821.253020-1-18255117159@163.com>
 <20250227163937.wv4hsucatyandde3@thinkpad>
 <f6e44f34-8800-421c-ba2c-755c10a6840e@163.com>
 <Z8Co4ZnqObpnEbg7@lizhi-Precision-Tower-5810>
Content-Language: en-US
From: Hans Zhang <18255117159@163.com>
In-Reply-To: <Z8Co4ZnqObpnEbg7@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_____wAH+C0me8Fnbdn5PA--.9176S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7GF4UZF4xur43JrW8urW3Wrg_yoWfKFXE9r
	ykKF1xWr4jkrySqw4aywsIgFZ8W3sFvr18Z3y3Xr9Fqr98tanrAwnakr97Ka4rGrW2yFn0
	kr4Sg34DJr9F9jkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUjJKs5UUUUU==
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbBDwMCo2fBdUClLAAAs3



On 2025/2/28 02:03, Frank Li wrote:
> On Fri, Feb 28, 2025 at 12:49:38AM +0800, Hans Zhang wrote:
>> Thanks Mani for the tip.
>>
>> If I want to implement similar functionality, where should I add it? Since
>> this sysfs node is the only one that displays the MSI/MSIX interrupt number,
>> I don't know where to implement similar debug functionality at this time. Do
>> you have any suggestions? Or it shouldn't have a similar function.
> 
> I think it is useful feature to help debug. Generally only one property
> for one sys file.
> 
> A possible create 3 files under
> 
> /sys/kernel/irq/26/
> 	address_hi, address_lo, msg_data.
> 
> cat address_hi, only show 0x00000000. ... ABI doc need update also.
> 
> Thomas(tglx) may provide better suggestions.

Thank you very much for Frank's opinion and agreeing with my idea. I 
also think this is a good debug method.

I will reply to Thomas(tglx) later, and then please review whether the 
patch I provided is OK?

Best regards
Hans


