Return-Path: <linux-pci+bounces-20363-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AB3BA1C83F
	for <lists+linux-pci@lfdr.de>; Sun, 26 Jan 2025 15:08:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A4101883456
	for <lists+linux-pci@lfdr.de>; Sun, 26 Jan 2025 14:08:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 962A725A652;
	Sun, 26 Jan 2025 14:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="I06299TJ"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 060538BEE;
	Sun, 26 Jan 2025 14:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737900486; cv=none; b=UNuiNpUpdsetvIvMLhKhrs3MwBrJo/4tw7VBtC+fz/aSqnW/gSpYhdd1LusrUOe9pE8MF+GhqLgtjwn6YQZLmtEZky0FBtvUwQYS0bel4i11QGIlZBwy3abBCgQbodqqKngQXUOfQAGA1gZT+i/0EvSVWgZvH7cDIw2utQrvM8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737900486; c=relaxed/simple;
	bh=seWpbShS80+QnALHdnGNksyKt2oFkJ6ecYuuT4HZ3FE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CGhUD9E32PjuEJ/eRVcY9z1U9iUf0aAyZuIvG/yVVwn8SXPLrl+hhiy4RHIdgxz/31jLtXPbfBmDgvXBhs4KFKsnaQ/M5C6L8a2coG3apGlMjxuJhIOXhq229xDaGi/GuL2MkhfKBawIwjdI202IMxPhwHkNbrCEQnQwnI7Ppo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=I06299TJ; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:From:
	Content-Type; bh=+ZVRjrDPc/1Z5B+T6fPUOGTt6Y8OpsuZYA4HmX9VYns=;
	b=I06299TJXFJJUpiIt7nwvfACX5fbFTwuek5UnHtt0L8MhOF3zvYgVMNJqAhKF5
	XwDtvbBIoQnmPEEaBr2UbqQzmuB1t6w6aLBn3/1hZIz0RjJ5zxrDSCebHVm0SCkf
	2OU9qq8X5mqXdRv1ySlVKz9kgBcvz6jLxXCk7wskOLCOc=
Received: from [192.168.174.52] (unknown [])
	by gzga-smtp-mtada-g0-2 (Coremail) with SMTP id _____wAXPld7QZZnv2P2IQ--.10950S2;
	Sun, 26 Jan 2025 22:06:52 +0800 (CST)
Message-ID: <5e0196ec-41f8-4969-bd6d-febd5be5048a@163.com>
Date: Sun, 26 Jan 2025 22:06:52 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI: dwc: Add the sysfs property to provide the LTSSM
 status of the PCIe link
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: jingoohan1@gmail.com, manivannan.sadhasivam@linaro.org,
 lpieralisi@kernel.org, kw@linux.com, robh@kernel.org, bhelgaas@google.com,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, rockswang7@gmail.com
References: <20250123164944.GA1223935@bhelgaas>
Content-Language: en-US
From: Hans Zhang <18255117159@163.com>
In-Reply-To: <20250123164944.GA1223935@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_____wAXPld7QZZnv2P2IQ--.10950S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxJry5Kry3GrW5urWxGr48Zwb_yoW8GFyUpF
	WDtFs5tFs3Gryj9rWkCw1YvF1ft3s3JrW8Gr4DWw13C3Z8C34fKr4IkF4Yqr9rXrZFgF40
	y3WYvr95Ar4Sy37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UOzV8UUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/1tbiDxvgo2eV2WCJiwABsf



On 2025/1/24 00:49, Bjorn Helgaas wrote:
> On Thu, Jan 23, 2025 at 03:13:26PM +0800, Hans Zhang wrote:
>> Add the sysfs property to provide a view of the current link's LTSSM
>> status from the root port device.
>>
>>    /sys/bus/pci/devices/<dev>/ltssm_status
> 
> Would need a rationale, i.e., what benefit this provides.  Obviously
> this is currently only implemented for DWC-based controllers and
> probably not ever available for ACPI or other generic host bridges.
> 
> Also documentation somewhere in
> Documentation/ABI/testing/sysfs-bus-pci*.
> 
> LTSSM is applicable to all Downstream Ports, including both Root Ports
> and Switch Downstream Ports, but in general I doubt this information
> is available for Switches in any generic way.
> 
>> +++ b/drivers/pci/pci-sysfs.c
>> @@ -1696,6 +1696,9 @@ const struct attribute_group *pci_dev_attr_groups[] = {
>>   #endif
>>   #ifdef CONFIG_PCIEASPM
>>   	&aspm_ctrl_attr_group,
>> +#endif
>> +#ifdef CONFIG_PCIE_DW_HOST
>> +	&dw_ltssm_status_attr_group,
>>   #endif
> 
> I'm not convinced of the value of potentially dozens of device- or
> vendor-specific additions like this.


At present, someone has submitted the dwc common debugfs driver.

dwc common driver: add debugfs
https://lore.kernel.org/linux-pci/20250121111421.35437-3-shradha.t@samsung.com/


I will make a patch version based on this patch.

Best regards
Hans


