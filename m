Return-Path: <linux-pci+bounces-25240-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 330B1A7A7FD
	for <lists+linux-pci@lfdr.de>; Thu,  3 Apr 2025 18:29:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F10C81743B2
	for <lists+linux-pci@lfdr.de>; Thu,  3 Apr 2025 16:29:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DDDB2512C5;
	Thu,  3 Apr 2025 16:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="Mo+e7mq/"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E8DB27706;
	Thu,  3 Apr 2025 16:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743697790; cv=none; b=kJQU/hohBuQYf2mryYtltepvtPeVeu6RFz1dJtf3OxrcevgaFvU1fO2ggWEhs/Nw5ADEtZfqereP9Nj15vD2G640Hi+O+J7sr7dtSVLvhq1PXOUgpnnnZd8CLb9FX3bjglUnqIrdIeeRRYMfMfO98E21/wTQdexBTNKuzFu1MQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743697790; c=relaxed/simple;
	bh=IHWl79kvzLC9W7BTsH1VqCgxs+FXeKSarMtyo1iNJoM=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=uZubH5zKLDB1HniLGS7W1efsik/vG0WGOis4TA5UD+RdcXFnj66MltSvzO+AUyi675JR9me0uNTbHQXXMFMxy+TdYXtsUwWfeSeD8kAqtewoc9RmXR9DocWdR2La/MPZAQrcdjRxvOacp6Aui1wbJ1CTggb1e/CoPWkJkO7sg7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=Mo+e7mq/; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:From:
	Content-Type; bh=WzrZiOGSl6iaEuSiDefAlje4knT4teo708pQl63CXy4=;
	b=Mo+e7mq/0SDhDkx9cGVPl3suCgfNGE9wKb95gXZzQE14rbdvuGU6w0DYZHal8J
	s6hZi3Le0ecY7TxOGrNFGqa/OlvWtGdxuAVdp6itEc4SCvWS2oTDw9zDCtc0/Gvd
	CtBLpB//sQyczu8eo2u9e2q6D7HvREnsgak4kK0rZ10S0=
Received: from [192.168.71.89] (unknown [])
	by gzga-smtp-mtada-g0-1 (Coremail) with SMTP id _____wCHTQBNt+5njhfcDw--.45272S2;
	Fri, 04 Apr 2025 00:29:02 +0800 (CST)
Message-ID: <d92d433b-89eb-434a-ae5d-0cc2e1ce3606@163.com>
Date: Fri, 4 Apr 2025 00:29:01 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [v7 2/5] PCI: Refactor capability search functions to eliminate
 code duplication
From: Hans Zhang <18255117159@163.com>
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: lpieralisi@kernel.org, bhelgaas@google.com, kw@linux.com,
 manivannan.sadhasivam@linaro.org, robh@kernel.org, jingoohan1@gmail.com,
 thomas.richard@bootlin.com, linux-pci@vger.kernel.org,
 LKML <linux-kernel@vger.kernel.org>
References: <20250402042020.48681-1-18255117159@163.com>
 <20250402042020.48681-3-18255117159@163.com>
 <8b693bfc-73e0-2956-2ba3-1bfd639660b6@linux.intel.com>
 <c6706073-86b0-445a-b39f-993ac9b054fa@163.com>
 <bf6f0acb-9c48-05de-6d6d-efb0236e2d30@linux.intel.com>
 <f77f60a0-72d2-4a9c-864e-bd8c4ea8a514@163.com>
Content-Language: en-US
In-Reply-To: <f77f60a0-72d2-4a9c-864e-bd8c4ea8a514@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wCHTQBNt+5njhfcDw--.45272S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxXr47Jr4DAF48Cry5Xw4Dtwb_yoW5ur4fpF
	W5AF13Cr48JF15XF4vqay8GFy5Ka97tFy7GrWIk3sIvFnFkayjyF9Ig343uryagrWDZr1x
	Z395WFy7G3Z5AFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07U3wIgUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbBDxUko2fulgLOSAABsH



On 2025/4/3 20:24, Hans Zhang wrote:
> 
> 
> On 2025/4/3 17:15, Ilpo Järvinen wrote:
>>>> I don't like how 1 & 2 patches are split into two. IMO, they mostly 
>>>> belong
>>>> together. However, (IMO) you can introduce the new all-size config 
>>>> space
>>>> accessor in a separate patch before the combined patch.
>>>>
>>>
>>> Ok. I'll change it to the following. The rest I'll combine into a patch.
>>>
>>> diff --git a/drivers/pci/access.c b/drivers/pci/access.c
>>> index b123da16b63b..bb2e26c2eb81 100644
>>> --- a/drivers/pci/access.c
>>> +++ b/drivers/pci/access.c
>>> @@ -85,6 +85,23 @@ EXPORT_SYMBOL(pci_bus_write_config_byte);
>>>   EXPORT_SYMBOL(pci_bus_write_config_word);
>>>   EXPORT_SYMBOL(pci_bus_write_config_dword);
>>>
>>> +
>>
>> Extra newline
>>
> 
> Hi Ilpo,
> 
> Thanks your for reply. Will delete.
> 

Hi Ilpo,

The [v9 1/6]patch I plan to submit is as follows, please review it.

 From c099691ff1e980ff4633c55e94abcd888000e2cc Mon Sep 17 00:00:00 2001
From: Hans Zhang <18255117159@163.com>
Date: Fri, 4 Apr 2025 00:19:32 +0800
Subject: [v9 1/6] PCI: Introduce generic bus config read helper function

The primary PCI config space accessors are tied to the size of the read
(byte/word/dword). Upcoming refactoring of PCI capability discovery logic
requires passing a config accessor function that must be able to perform
read with different sizes.

Add any size config space read accessor pci_bus_read_config() to allow
giving it as the config space accessor to the upcoming PCI capability
discovery macro.

Reconstructs the PCI function discovery logic to prepare for unified
configuration of access modes.  No function changes are intended.

Signed-off-by: Hans Zhang <18255117159@163.com>
---
  drivers/pci/access.c | 17 +++++++++++++++++
  drivers/pci/pci.h    |  2 ++
  2 files changed, 19 insertions(+)

diff --git a/drivers/pci/access.c b/drivers/pci/access.c
index b123da16b63b..603332658ab3 100644
--- a/drivers/pci/access.c
+++ b/drivers/pci/access.c
@@ -85,6 +85,23 @@ EXPORT_SYMBOL(pci_bus_write_config_byte);
  EXPORT_SYMBOL(pci_bus_write_config_word);
  EXPORT_SYMBOL(pci_bus_write_config_dword);

+int pci_bus_read_config(void *priv, unsigned int devfn, int where, u32 
size,
+			u32 *val)
+{
+	struct pci_bus *bus = priv;
+	int ret;
+
+	if (size == 1)
+		ret = pci_bus_read_config_byte(bus, devfn, where, (u8 *)val);
+	else if (size == 2)
+		ret = pci_bus_read_config_word(bus, devfn, where, (u16 *)val);
+	else
+		ret = pci_bus_read_config_dword(bus, devfn, where, val);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(pci_bus_read_config);
+
  int pci_generic_config_read(struct pci_bus *bus, unsigned int devfn,
  			    int where, int size, u32 *val)
  {
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 2e9cf26a9ee9..6a7c88b9cd35 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -88,6 +88,8 @@ extern bool pci_early_dump;
  bool pcie_cap_has_lnkctl(const struct pci_dev *dev);
  bool pcie_cap_has_lnkctl2(const struct pci_dev *dev);
  bool pcie_cap_has_rtctl(const struct pci_dev *dev);
+int pci_bus_read_config(void *priv, unsigned int devfn, int where, u32 
size,
+			u32 *val);

  /* Functions internal to the PCI core code */



Best regards,
Hans


