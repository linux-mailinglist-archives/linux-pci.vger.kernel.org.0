Return-Path: <linux-pci+bounces-24464-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 954ADA6CFE7
	for <lists+linux-pci@lfdr.de>; Sun, 23 Mar 2025 16:38:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 152E616E815
	for <lists+linux-pci@lfdr.de>; Sun, 23 Mar 2025 15:38:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2BF87F7FC;
	Sun, 23 Mar 2025 15:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="g1a4C1HT"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD4D77083F;
	Sun, 23 Mar 2025 15:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742744305; cv=none; b=a+j9IfjCPpZy7yBPwXsZrJ8PFm315gP/dNpxXMSzYsHgLWS9zWuYI1M71CXmK0SvSTYUluscByqFLNb2lrra2xT+kNf2EgbQHzaSp36LivtAoHFTP/FiJhJXgRoZWuMkfJTWxi1uHXwZvJ19rfADsRhFLFIWP5cp8Mju1hoH0Cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742744305; c=relaxed/simple;
	bh=y2RJ1LlwUK3RVMGfvNs/Gokkk+Cs5qxHe99+/rQlNZI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OSmzP228MlFVY5kEoOxSJzG079oi5QNw95CMvVkYEbyrD21N0JA+Tteb/bFlHI2s158bvU6rH9a3EaFZNyBQZw4wu7V1RQfN4eGG/d678+5zPNfmGIfEezd4tVy4CbnqTG/69QCVl180VQNwjUw8zEfosmcCpiq+aaL7RgVAtrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=g1a4C1HT; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:From:
	Content-Type; bh=41JUD+fiRBn0TgwP++GGOmP/IuXeJMDNoAnv49VUXlo=;
	b=g1a4C1HT3zSzytgEBtkI78sRqf12vhq8AiduVETM2sLjOInsPjROx6DB+Mk0KP
	fVFrY/l933ipz8lDsd8k35QErRse9qvN3ZyMGanWaStlSvfJgWN9HVDtXnqkYKS+
	/5fuCxaUwD9GRm93P7c+LFCQaAL6T6E/YDnSOavBFWqr0=
Received: from [192.168.71.89] (unknown [])
	by gzsmtp4 (Coremail) with SMTP id PygvCgAX+WOBKuBnsqUNAA--.2365S2;
	Sun, 23 Mar 2025 23:36:33 +0800 (CST)
Message-ID: <65049dff-cb22-44fd-8663-e4521d8b23fb@163.com>
Date: Sun, 23 Mar 2025 23:36:33 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [v5 1/4] PCI: Introduce generic capability search functions
To: Lukas Wunner <lukas@wunner.de>
Cc: lpieralisi@kernel.org, kw@linux.com, manivannan.sadhasivam@linaro.org,
 robh@kernel.org, bhelgaas@google.com, jingoohan1@gmail.com,
 thomas.richard@bootlin.com, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250321163803.391056-1-18255117159@163.com>
 <20250321163803.391056-2-18255117159@163.com> <Z92cgXEGwgYD2gau@wunner.de>
 <e6e808b6-302b-4f3e-ad2d-5f9c4dce7394@163.com> <Z97hLJM4z8R39ZBk@wunner.de>
Content-Language: en-US
From: Hans Zhang <18255117159@163.com>
In-Reply-To: <Z97hLJM4z8R39ZBk@wunner.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:PygvCgAX+WOBKuBnsqUNAA--.2365S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxWFyrtr4UuF4xJFWUZF43Jrb_yoW5Cw1xpa
	y5Way3CF1kJF45A3ZFvw10ga4aqan7J34DGwn8G3s5Zrnxury7WrWqkr1Fya4DAr4Ivr4j
	yF48t3W29FnxAFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07U3UUbUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/1tbiWwIZo2fgJyROnQAAs0



On 2025/3/23 00:11, Lukas Wunner wrote:
> On Sat, Mar 22, 2025 at 11:47:18PM +0800, Hans Zhang wrote:
>> On 2025/3/22 01:06, Lukas Wunner wrote:
>>> On Sat, Mar 22, 2025 at 12:38:00AM +0800, Hans Zhang wrote:
>>>> Add pci_host_bridge_find_*capability() in drivers/pci/pci.c, accepting
>>>> controller-specific read functions and device data as parameters.
>>>
>>> Please put this in a .c file which is only compiled and linked if
>>> one of the controller drivers using those new helpers is enabled
>>> in .config.
>>>
>>> If you put the helpers in drivers/pci/pci.c, they unnecessarily
>>> enlarge the kernel's .text section even if it's known already
>>> at compile time that they're never going to be used (e.g. on x86).
>>>
>>> You could put them in drivers/pci/controller/pci-host-common.c
>>> and then select PCI_HOST_COMMON for each driver using them.
>>> Or put them in a separate completely new file.
>>
>> I add a drivers/pci/controller/pci-host-helpers.c file, how do you like it?
>> Below, I have rearranged the patch, please kindly review it, thank you very
>> much.
> 
> Looks fine to me, but I'm not one of the maintainers for the controller
> drivers, they may have a different opinion.  I'd recommending submitting
> this and see if any of them doesn't like it.
> 

Hi Lukas,

Thanks your for reply. I will submit it in the next version.

> Just one nit that caught my eye:
> 
>> --- a/drivers/pci/controller/Kconfig
>> +++ b/drivers/pci/controller/Kconfig
>> @@ -132,6 +132,22 @@ config PCI_HOST_GENERIC
>>   	  Say Y here if you want to support a simple generic PCI host
>>   	  controller, such as the one emulated by kvmtool.
>>
>> +config PCI_HOST_HELPERS
>> + 	bool "PCI Host Controller Helper Functions"
>> + 	help
>> +	  This provides common infrastructure for PCI host controller drivers to
>> +	  handle PCI capability scanning and other shared operations. The helper
>> +	  functions eliminate code duplication across controller drivers.
>> +
>> +	  These functions are used by PCI controller drivers that need to scan
>> +	  PCI capabilities using controller-specific access methods (e.g. when
>> +	  the controller is behind a non-standard configuration space).
>> +
>> +	  If you are using any PCI host controller drivers that require these
>> +	  helpers (such as DesignWare, Cadence, etc), this will be
>> +	  automatically selected. Say N unless you are developing a custom PCI
>> +	  host controller driver.
> 
> I like the comprehensive help text, but I'd recommend removing the
> input prompt "PCI Host Controller Helper Functions" after the "bool".
> 
> I think generally only menu entries should be displayed that are relevant
> for end users.  The prompt is only needed for developers and they can
> easily modify Kconfig to select the item when they add their driver.
> 
> If you absolutely positively want to have a prompt, I'd recommend
> hiding the menu entry unless CONFIG_EXPERT is also enabled, i.e.:
> 
> 	bool
> 	prompt "PCI Host Controller Helper Functions" if EXPERT
> 
> Or maybe there's something better than CONFIG_EXPERT for cases like this,
> dunno.
> 

Well, thank you for your advice.

Best regards,
Hans


