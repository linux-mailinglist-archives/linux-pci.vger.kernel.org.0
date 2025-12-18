Return-Path: <linux-pci+bounces-43284-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 32C49CCBB1B
	for <lists+linux-pci@lfdr.de>; Thu, 18 Dec 2025 12:57:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 877CC300C295
	for <lists+linux-pci@lfdr.de>; Thu, 18 Dec 2025 11:56:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB32E328256;
	Thu, 18 Dec 2025 11:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="l0N1rEMO"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3C59320A3C;
	Thu, 18 Dec 2025 11:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766059012; cv=none; b=O73DTEZhL814ZE3oOn5GYeCKCx33eMW7anSXUe+mXEdnhZP2FlVrMf+L2JE+sXS3931wtownZejcbdurUpNq1tNqBmUOtVRd3KMxWVYlS4tQaNp3G9fZ5R4cmHyiUx8Khku5uLGkgre9K10NjX47gQH1NGvo71Xl9ypg32zBqvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766059012; c=relaxed/simple;
	bh=yrErPSwEUZ9cqWkmC/hiS0zyoSXy6BfdfbN7MtDUuyA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=t7iD+dzjV3KwHnrFSIjIY/FHYsytiCFo3fWCE6xV9USHw3CJ4w34JlBvvreP3WTDCcjFnn4G5hM+m+wWmxFrObS15NN5JUIkiJL8S2fkYfyC6CoY/yhsIqQvI75/p+UyFYmDgPUvelqcoBRj5WGZf8rrzhSuivU5yrJhorutEYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=l0N1rEMO; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=DkVJqWTdh7VkWpx0w8fHL4GlwYtxJkcMR7DZLFHtBWg=;
	b=l0N1rEMO9sMUUx3tSTb/Hd3e2UIjedqJzl4HXcEhtpxrjJ9zTCB/QFOE3B9RDY
	2vYrhiKwteF1FrCdvYSJ2VnuPqNEwvjuoIQqVArRroSbzM+huaLmmqz/QblDupsy
	5CSEd6hQMSO3hb+11wUZCXLfYlUR2KH2uA8EQitMDSOFY=
Received: from [IPV6:240e:b8f:927e:1000:25d6:ba9d:e967:4b1c] (unknown [])
	by gzsmtp4 (Coremail) with SMTP id PygvCgBnor3f60NpoeyXHw--.148S2;
	Thu, 18 Dec 2025 19:56:18 +0800 (CST)
Message-ID: <b4c24074-0898-40d8-8cf0-ff5f95e2a8a9@163.com>
Date: Thu, 18 Dec 2025 19:56:14 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/1] PCI: of: Relax max-link-speed check to support
 PCIe Gen5/Gen6
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: bhelgaas@google.com, helgaas@kernel.org, ilpo.jarvinen@linux.intel.com,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251105134701.182795-1-18255117159@163.com>
 <hsfa7kxvhrjcth3pabsrid2bzzjch7thu2uxggrg32tt54ipaq@lj7nbweoaj35>
Content-Language: en-US
From: Hans Zhang <18255117159@163.com>
In-Reply-To: <hsfa7kxvhrjcth3pabsrid2bzzjch7thu2uxggrg32tt54ipaq@lj7nbweoaj35>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:PygvCgBnor3f60NpoeyXHw--.148S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxWw1UZw15Cr4rWr43tw17Awb_yoWrJryrpa
	y7Ca4rZry8XF43Xr4vq3WrZFyYq3Z3GrWUKryrW3Z7uFnxCFZxtFyYqF43Xr1I9rsrZr12
	qF43tr47Cw4YyaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07U4rW7UUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbCwwJeAmlD6+K8vQAA3-



On 2025/12/18 14:31, Manivannan Sadhasivam wrote:
> On Wed, Nov 05, 2025 at 09:47:01PM +0800, Hans Zhang wrote:
>> The existing code restricted max-link-speed to values 1~4 (Gen1~Gen4),
>> but current SOCs using Synopsys/Cadence IP may require Gen5/Gen6 support.
>> While DT binding validation already checks this property, the code-level
>> validation in of_pci_get_max_link_speed still lags behind, needing an
>> update to accommodate newer PCIe generations.
>>
>> Hardcoded literals in such validation logic create maintainability
>> challenges, as they are difficult to track and update when adding
>> support for future PCIe link speeds.  To address this, a helper function
>> pcie_max_supported_link_speed() is added in drivers/pci/pci.h, which
>> calculates the maximum supported link speed generation using existing
>> PCIe capability macros (PCI_EXP_LNKCAP_SLS_*). This ensures alignment
>> with the kernel's generic PCIe link speed definitions and avoids
>> standalone hardcoded values.
>>
>> The previous hardcoded "4" in the validation check is replaced with a
>> call to this helper function, eliminating the need to modify this specific
>> code path when extending support for future PCIe generations.
> 
> How can you not modify this function when PCIe 7.0 gets added? It still requires
> an update.
> 
> I'd prefer to just drop the check altogether as the callers already have checks
> on their own.

Hi Mani,


Thank you very much for your reply. Do you mean the following modification?

diff --git a/drivers/pci/of.c b/drivers/pci/of.c
index 3579265f1198..9d3980e425b4 100644
--- a/drivers/pci/of.c
+++ b/drivers/pci/of.c
@@ -890,7 +890,7 @@ int of_pci_get_max_link_speed(struct device_node *node)
  	u32 max_link_speed;

  	if (of_property_read_u32(node, "max-link-speed", &max_link_speed) ||
-	    max_link_speed == 0 || max_link_speed > 4)
+	    max_link_speed == 0)
  		return -EINVAL;

  	return max_link_speed;

Best regards,
Hans


> 
> - Mani
> 
>> The
>> implementation maintains full backward compatibility with existing
>> configurations, while enabling seamless extension for newer link
>> speeds, future updates will only require updating the relevant PCI
>> capability macros without changing the validation logic here.
>>
>> Signed-off-by: Hans Zhang <18255117159@163.com>
>> ---
>>   drivers/pci/of.c  | 3 ++-
>>   drivers/pci/pci.h | 5 +++++
>>   2 files changed, 7 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/pci/of.c b/drivers/pci/of.c
>> index 3579265f1198..de1fe6b9ba6a 100644
>> --- a/drivers/pci/of.c
>> +++ b/drivers/pci/of.c
>> @@ -890,7 +890,8 @@ int of_pci_get_max_link_speed(struct device_node *node)
>>   	u32 max_link_speed;
>>   
>>   	if (of_property_read_u32(node, "max-link-speed", &max_link_speed) ||
>> -	    max_link_speed == 0 || max_link_speed > 4)
>> +	    max_link_speed == 0 ||
>> +	    max_link_speed > pcie_max_supported_link_speed())
>>   		return -EINVAL;
>>   
>>   	return max_link_speed;
>> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
>> index 4492b809094b..2f0f319e80ce 100644
>> --- a/drivers/pci/pci.h
>> +++ b/drivers/pci/pci.h
>> @@ -548,6 +548,11 @@ static inline int pcie_dev_speed_mbps(enum pci_bus_speed speed)
>>   	return -EINVAL;
>>   }
>>   
>> +static inline int pcie_max_supported_link_speed(void)
>> +{
>> +	return PCI_EXP_LNKCAP_SLS_64_0GB - PCI_EXP_LNKCAP_SLS_2_5GB + 1;
>> +}
>> +
>>   u8 pcie_get_supported_speeds(struct pci_dev *dev);
>>   const char *pci_speed_string(enum pci_bus_speed speed);
>>   void __pcie_print_link_status(struct pci_dev *dev, bool verbose);
>> -- 
>> 2.34.1
>>
> 


