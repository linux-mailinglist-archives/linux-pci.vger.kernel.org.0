Return-Path: <linux-pci+bounces-19445-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01D6AA04517
	for <lists+linux-pci@lfdr.de>; Tue,  7 Jan 2025 16:47:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 621A6161496
	for <lists+linux-pci@lfdr.de>; Tue,  7 Jan 2025 15:46:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F07D21F4289;
	Tue,  7 Jan 2025 15:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="YxrpOLzu"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 170AC1F5425;
	Tue,  7 Jan 2025 15:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736264697; cv=none; b=rFOVF/yiZs1qZ1ggyFpTTaMngsACcSKc1lgbYh2by5AH+YM2XO81iEr3xPmxK4V32hOLF4nSfxFiVJ17weIiK25IqwDKZyUWlfC6BuZwXucM9b+uL71k2AEDhXX4SBNCB0VYIWGES4zwi3z7LZca9KI0cGfbES9u9UDpZ9ODt9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736264697; c=relaxed/simple;
	bh=iBRA3KEjds+Lgv9ZZ0Pkdm2/FnLyFrBoFkka713gs9A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b32mq+UOIcjAyfMup1WgcIFrSJ98t0MXQYdObYYlqoPfVwwJRVSdXlpZrNqczUChVwI9qZc/hOTEnCfa6CJt4vX6MohObQCcuhRXV+I3/gMqGd8qzWCXdJfftjBdS3vWlgoebZ0X2WrrfAjM2EtQJyo5msPpB0rqwXEbltRerQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=YxrpOLzu; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:From:
	Content-Type; bh=KVmPS4Fu+9irQI4b55mWsUJxhORx84MgcQmPcC5jsDw=;
	b=YxrpOLzutg4OnpKzijw4gOfQ6reGLukHl17Al51I082Ytp0ZTgEvh5MoyYjSj5
	xMe1M9REh6ueB+8YKMR3zSjhrbURJS2Kz4prTrR0PSUFVC5hW09fLZRUn7wAaEY/
	tOr48flfCAr5tkvUs8BfleeOqCxbH0yUHr0m1Tc4AN270=
Received: from [192.168.71.44] (unknown [])
	by gzga-smtp-mtada-g1-3 (Coremail) with SMTP id _____wDHGT3VS31nzeAWEg--.18654S2;
	Tue, 07 Jan 2025 23:44:21 +0800 (CST)
Message-ID: <4bfb6c46-6f93-431b-9a8c-038bc7f77241@163.com>
Date: Tue, 7 Jan 2025 23:44:21 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [v8] misc: pci_endpoint_test: Fix overflow of bar_size
To: Niklas Cassel <cassel@kernel.org>
Cc: manivannan.sadhasivam@linaro.org, kw@linux.com, kishon@kernel.org,
 arnd@arndb.de, gregkh@linuxfoundation.org, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, rockswang7@gmail.com
References: <20250104151652.1652181-1-18255117159@163.com>
 <Z3vDLcq9kWL4ueq7@ryzen> <d79d5a72-d1b0-4442-a0a3-e53516726204@163.com>
 <Z30CywAKGRYE_p28@ryzen> <96b3a0f7-f144-4f2a-9f84-82c31d8ec23e@163.com>
 <Z30RFBcOI61784bI@ryzen> <270783b7-70c6-49d5-8464-fb542396e2dd@163.com>
 <Z30UXDVZi3Re_J9p@ryzen>
Content-Language: en-US
From: Hans Zhang <18255117159@163.com>
In-Reply-To: <Z30UXDVZi3Re_J9p@ryzen>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_____wDHGT3VS31nzeAWEg--.18654S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7ZF1ktF4xZF1fXw1kJrykGrg_yoW8Wr1kpr
	4Yy3yqvFWFvrWjya1kC3yUuF95t34fAry3Kas3X34rtF45Kr4jq3W29F4Svr1jyFWYka45
	JF1fXa4q9345AFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jTQ6dUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbBDxHNo2d9Sh83tAAAs8



On 2025/1/7 19:47, Niklas Cassel wrote:

Hi Niklas,

> The error:
> drivers/misc/pci_endpoint_test.c:315: undefined reference to `__udivmoddi4'
> sounds like the compiler is using a specialized instruction to do both div
> and mod in one. By removing the mod in patch 1/2, I expect that patch 2/2
> will no longer get this error.

The __udivmoddi4 may be the way div and mod are combined.

Delete remain's patch 1/2 according to your suggestion. I compiled it as 
a KO module for an experiment.

There are still __udivdi3 errors, so the do_div API must be used.

zhb@zhb:/media/zhb/hans/code/kernel_org/hans$ make
make -C /media/zhb/hans/code/kernel_org/linux/ 
M=/media/zhb/hans/code/kernel_org/hans modules
make[1]: Entering directory '/media/zhb/hans/code/kernel_org/linux'
make[2]: Entering directory '/media/zhb/hans/code/kernel_org/hans'
   CC [M]  pci_endpoint_test.o
   MODPOST Module.symvers
ERROR: modpost: "__udivdi3" [pci_endpoint_test.ko] undefined!
make[4]: *** 
[/media/zhb/hans/code/kernel_org/linux/scripts/Makefile.modpost:145: 
Module.symvers] Error 1
make[3]: *** [/media/zhb/hans/code/kernel_org/linux/Makefile:1939: 
modpost] Error 2
make[2]: *** [/media/zhb/hans/code/kernel_org/linux/Makefile:251: 
__sub-make] Error 2
make[2]: Leaving directory '/media/zhb/hans/code/kernel_org/hans'
make[1]: *** [Makefile:251: __sub-make] Error 2
make[1]: Leaving directory '/media/zhb/hans/code/kernel_org/linux'
make: *** [Makefile:10: kernel_modules] Error 2

Best regards
Hans


