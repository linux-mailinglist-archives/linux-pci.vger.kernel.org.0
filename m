Return-Path: <linux-pci+bounces-25190-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 63962A79245
	for <lists+linux-pci@lfdr.de>; Wed,  2 Apr 2025 17:38:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A10211895196
	for <lists+linux-pci@lfdr.de>; Wed,  2 Apr 2025 15:39:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 082DE13D8B2;
	Wed,  2 Apr 2025 15:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="hJNUbsV7"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C64162E3372;
	Wed,  2 Apr 2025 15:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743608325; cv=none; b=MZ3wttyaJ+BZUDLx8uXOYxzrTcbdvh7JPnfinOP7OV+XK0dNbLny6dhkfFlOWrn9IfC/0hmscK3N4Tuaaxz+snTbpwfQaZvb/A6KZBeEC5nJroXw048b2PzGw7ZYnSoyOFu47YzkhYzi0VQILjGL8iNfGDgnrUb3q7EsJ7xbSyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743608325; c=relaxed/simple;
	bh=1a5AtKgtRfWa1wPOQRdDqRvCNnUU1/G3gjL/nQcplR0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mdUigLz5kEI3eLqFBMvX0FWxKWWW1fcFDcKNrk93KEnKn3gTUcp8kYXG/H1BNUY3UGWU8czj4V8v383kxLluonGcpnn84M1g6nvl/NjUya9Krc4WoTbuhHWFCsvlgHANrCdQAuBU/5pEaKi2gqoy9QNTtR+nQ+x32mGqIcNDu1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=hJNUbsV7; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:From:
	Content-Type; bh=QUj+GFy5Qx5hlrV4dqr5cXgZbrQBFi4pUIlzv+rdsis=;
	b=hJNUbsV7QR+OM2qdvyos1+yy6/57sM4lpcCGwxIfc610aluYcmCeJ+XQTWeCt2
	Xwyr61iQ6qd0opkcP2ySXlJWYLY3p9Od75W37qy4qaPv8XyBji86P7Uz/ysLHCyX
	zUeQLRJI6d8rL+dcX2au9RzOeFDliuUXDhZarWGUVEmrU=
Received: from [192.168.71.89] (unknown [])
	by gzga-smtp-mtada-g1-0 (Coremail) with SMTP id _____wC3Owa+We1n0VouBg--.8836S2;
	Wed, 02 Apr 2025 23:37:35 +0800 (CST)
Message-ID: <c6706073-86b0-445a-b39f-993ac9b054fa@163.com>
Date: Wed, 2 Apr 2025 23:37:34 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [v7 2/5] PCI: Refactor capability search functions to eliminate
 code duplication
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: lpieralisi@kernel.org, bhelgaas@google.com, kw@linux.com,
 manivannan.sadhasivam@linaro.org, robh@kernel.org, jingoohan1@gmail.com,
 thomas.richard@bootlin.com, linux-pci@vger.kernel.org,
 LKML <linux-kernel@vger.kernel.org>
References: <20250402042020.48681-1-18255117159@163.com>
 <20250402042020.48681-3-18255117159@163.com>
 <8b693bfc-73e0-2956-2ba3-1bfd639660b6@linux.intel.com>
Content-Language: en-US
From: Hans Zhang <18255117159@163.com>
In-Reply-To: <8b693bfc-73e0-2956-2ba3-1bfd639660b6@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wC3Owa+We1n0VouBg--.8836S2
X-Coremail-Antispam: 1Uf129KBjvJXoW3AFyDZw13tF4ftrWDtF1UWrg_yoW3JFyfpF
	W3J3WayrW8GF12gF4qvayktryaqFZ7JFWxGrWxCas0vFnFkF9YvFy2kw15W342grWkWF1x
	Xws5tFyDC3WvyaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UVnQUUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbBDxMjo2ftV0IYYAABs6



On 2025/4/2 20:38, Ilpo Järvinen wrote:
> On Wed, 2 Apr 2025, Hans Zhang wrote:
> 
>> Refactor the PCI capability and extended capability search functions
>> by consolidating common code patterns into reusable macros
>> (PCI_FIND_NEXT_CAP_TTL and PCI_FIND_NEXT_EXT_CAPABILITY). The main
>> changes include:
>>
>> 1. Introducing a unified config space read helper (__pci_bus_read_config).
>> 2. Removing duplicate search logic from __pci_find_next_cap_ttl and
>>     pci_find_next_ext_capability.
>> 3. Implementing consistent capability discovery using the new macros.
>> 4. Simplifying HyperTransport capability lookup by leveraging the
>>     refactored code.
>>
>> The refactoring maintains existing functionality while reducing code
>> duplication and improving maintainability. By centralizing the search
>> logic, we achieve better code consistency and make future updates easier.
>>
>> This change has been verified to maintain backward compatibility with
>> existing capability discovery patterns through thorough testing of PCI
>> device enumeration and capability probing.
>>
>> Signed-off-by: Hans Zhang <18255117159@163.com>
>> ---
>>   drivers/pci/pci.c | 79 +++++++++++++----------------------------------
>>   1 file changed, 22 insertions(+), 57 deletions(-)
>>
>> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
>> index 869d204a70a3..521096c73686 100644
>> --- a/drivers/pci/pci.c
>> +++ b/drivers/pci/pci.c
>> @@ -423,36 +423,33 @@ static int pci_dev_str_match(struct pci_dev *dev, const char *p,
>>   	return 1;
>>   }
>>   
>> -static u8 __pci_find_next_cap_ttl(struct pci_bus *bus, unsigned int devfn,
>> -				  u8 pos, int cap, int *ttl)
>> +static int __pci_bus_read_config(void *priv, unsigned int devfn, int where,
>> +				 u32 size, u32 *val)
> 
> This probably should be where the other accessors are so in access.c. I'd
> put its prototype into drivers/pci/pci.h only for now.
> 

Hi Ilpo,

Thank you very much for your guidance. Will change.


>>   {
>> -	u8 id;
>> -	u16 ent;
>> +	struct pci_bus *bus = priv;
>> +	int ret;
>>   
>> -	pci_bus_read_config_byte(bus, devfn, pos, &pos);
>> +	if (size == 1)
>> +		ret = pci_bus_read_config_byte(bus, devfn, where, (u8 *)val);
>> +	else if (size == 2)
>> +		ret = pci_bus_read_config_word(bus, devfn, where, (u16 *)val);
>> +	else
>> +		ret = pci_bus_read_config_dword(bus, devfn, where, val);
>>   
>> -	while ((*ttl)--) {
>> -		if (pos < 0x40)
>> -			break;
>> -		pos &= ~3;
>> -		pci_bus_read_config_word(bus, devfn, pos, &ent);
>> +	return ret;
>> +}
>>   
>> -		id = ent & 0xff;
>> -		if (id == 0xff)
>> -			break;
>> -		if (id == cap)
>> -			return pos;
>> -		pos = (ent >> 8);
>> -	}
>> -	return 0;
>> +static u8 __pci_find_next_cap_ttl(struct pci_bus *bus, unsigned int devfn,
>> +				  u8 pos, int cap)
>> +{
>> +	return PCI_FIND_NEXT_CAP_TTL(__pci_bus_read_config, pos, cap, bus,
>> +				     devfn);
>>   }
>>   
>>   static u8 __pci_find_next_cap(struct pci_bus *bus, unsigned int devfn,
>>   			      u8 pos, int cap)
>>   {
>> -	int ttl = PCI_FIND_CAP_TTL;
>> -
>> -	return __pci_find_next_cap_ttl(bus, devfn, pos, cap, &ttl);
>> +	return __pci_find_next_cap_ttl(bus, devfn, pos, cap);
>>   }
>>   
>>   u8 pci_find_next_capability(struct pci_dev *dev, u8 pos, int cap)
>> @@ -553,42 +550,11 @@ EXPORT_SYMBOL(pci_bus_find_capability);
>>    */
>>   u16 pci_find_next_ext_capability(struct pci_dev *dev, u16 start, int cap)
>>   {
>> -	u32 header;
>> -	int ttl;
>> -	u16 pos = PCI_CFG_SPACE_SIZE;
>> -
>> -	/* minimum 8 bytes per capability */
>> -	ttl = (PCI_CFG_SPACE_EXP_SIZE - PCI_CFG_SPACE_SIZE) / 8;
>> -
>>   	if (dev->cfg_size <= PCI_CFG_SPACE_SIZE)
>>   		return 0;
>>   
>> -	if (start)
>> -		pos = start;
>> -
>> -	if (pci_read_config_dword(dev, pos, &header) != PCIBIOS_SUCCESSFUL)
>> -		return 0;
>> -
>> -	/*
>> -	 * If we have no capabilities, this is indicated by cap ID,
>> -	 * cap version and next pointer all being 0.
>> -	 */
>> -	if (header == 0)
>> -		return 0;
>> -
>> -	while (ttl-- > 0) {
>> -		if (PCI_EXT_CAP_ID(header) == cap && pos != start)
>> -			return pos;
>> -
>> -		pos = PCI_EXT_CAP_NEXT(header);
>> -		if (pos < PCI_CFG_SPACE_SIZE)
>> -			break;
>> -
>> -		if (pci_read_config_dword(dev, pos, &header) != PCIBIOS_SUCCESSFUL)
>> -			break;
>> -	}
>> -
>> -	return 0;
>> +	return PCI_FIND_NEXT_EXT_CAPABILITY(__pci_bus_read_config, start, cap,
>> +					    dev->bus, dev->devfn);
> 
> I don't like how 1 & 2 patches are split into two. IMO, they mostly belong
> together. However, (IMO) you can introduce the new all-size config space
> accessor in a separate patch before the combined patch.
> 

Ok. I'll change it to the following. The rest I'll combine into a patch.

diff --git a/drivers/pci/access.c b/drivers/pci/access.c
index b123da16b63b..bb2e26c2eb81 100644
--- a/drivers/pci/access.c
+++ b/drivers/pci/access.c
@@ -85,6 +85,23 @@ EXPORT_SYMBOL(pci_bus_write_config_byte);
  EXPORT_SYMBOL(pci_bus_write_config_word);
  EXPORT_SYMBOL(pci_bus_write_config_dword);

+
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


>>   }
>>   EXPORT_SYMBOL_GPL(pci_find_next_ext_capability);
>>   
>> @@ -648,7 +614,6 @@ EXPORT_SYMBOL_GPL(pci_get_dsn);
>>   
>>   static u8 __pci_find_next_ht_cap(struct pci_dev *dev, u8 pos, int ht_cap)
>>   {
>> -	int rc, ttl = PCI_FIND_CAP_TTL;
>>   	u8 cap, mask;
>>   
>>   	if (ht_cap == HT_CAPTYPE_SLAVE || ht_cap == HT_CAPTYPE_HOST)
>> @@ -657,7 +622,7 @@ static u8 __pci_find_next_ht_cap(struct pci_dev *dev, u8 pos, int ht_cap)
>>   		mask = HT_5BIT_CAP_MASK;
>>   
>>   	pos = __pci_find_next_cap_ttl(dev->bus, dev->devfn, pos,
>> -				      PCI_CAP_ID_HT, &ttl);
>> +				      PCI_CAP_ID_HT);
>>   	while (pos) {
>>   		rc = pci_read_config_byte(dev, pos + 3, &cap);
>>   		if (rc != PCIBIOS_SUCCESSFUL)
>> @@ -668,7 +633,7 @@ static u8 __pci_find_next_ht_cap(struct pci_dev *dev, u8 pos, int ht_cap)
>>   
>>   		pos = __pci_find_next_cap_ttl(dev->bus, dev->devfn,
>>   					      pos + PCI_CAP_LIST_NEXT,
>> -					      PCI_CAP_ID_HT, &ttl);
>> +					      PCI_CAP_ID_HT);
> 
> This function kind of had the idea to share the ttl but I suppose that was
> just a final safeguard to make sure the loop will always terminate in case
> the config space is corrupted so the unsharing is not a big issue.
> 

__pci_find_next_cap_ttl
   // This macro definition already has ttl loop restrictions inside it.
   PCI_FIND_NEXT_CAP_TTL

Do I understand that you agree to remove ttl initialization and 
parameter passing?

Best regards,
Hans

>>   	}
>>   
>>   	return 0;
>>
> 


