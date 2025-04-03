Return-Path: <linux-pci+bounces-25242-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BE6E2A7A80C
	for <lists+linux-pci@lfdr.de>; Thu,  3 Apr 2025 18:36:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A1E8173D8A
	for <lists+linux-pci@lfdr.de>; Thu,  3 Apr 2025 16:36:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC4F91F3BA9;
	Thu,  3 Apr 2025 16:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="PujN0zf+"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F6722500C5;
	Thu,  3 Apr 2025 16:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743698188; cv=none; b=agyf83NMvFJnOQfedtMKUPUPuv1jAdvKKlwDvD1/hXaz9nUQOiu7WlpOtOAo7jjs8jK3RpZ8n3uxUFklFyLMkTeW7Ox3RdNzz13KFprhCIhyp2kj/SZug9fYSWqk186COjIEWOOc+W6DETNgGJbygCekEnsgh90p5XXyleA3HcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743698188; c=relaxed/simple;
	bh=GWOjykiuNj6LqXHBcpsfAQL11Mg6d7NQ76P87A3BQGg=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=cHek+dzRc4nI+rX9uvV8AnYcJD9vdTbA5fnbvDLpiGIESiS1MFu+AcdhkpFfgpWRgSdFmXqdp+q69OKVPZMxKO62Sotvk6ROTOFadm4AZyYPCh06lXh5bCnL5wnxxcg76rRm3G0cQIlgjDmoxuu4aMcifDrr2FgICT0B4H8kqls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=PujN0zf+; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:From:
	Content-Type; bh=1rWupM0SD6fPf+IhLnUO+yDXsCHCx3+mPDtUqa7WKsA=;
	b=PujN0zf+upjs2ThgU2DXWp+UwH32aeHIZ3q8P3EucWQEGiqeDfKxLpFNe6Ympl
	jkcg2Ms1bpylaP6oTIvEg0CdCTJHChE9VL8F53t/5APeyaOeRGjBqQez570dmcls
	NwMVr59t/vaGU5KH49hXGneziaypFw/xu8Rv+5UhB2Y0w=
Received: from [192.168.71.89] (unknown [])
	by gzga-smtp-mtada-g1-3 (Coremail) with SMTP id _____wCXMd_cuO5nu9qWDw--.46905S2;
	Fri, 04 Apr 2025 00:35:40 +0800 (CST)
Message-ID: <ef0237d9-f5da-44d7-ab45-2be037cf0f25@163.com>
Date: Fri, 4 Apr 2025 00:35:40 +0800
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
X-CM-TRANSID:_____wCXMd_cuO5nu9qWDw--.46905S2
X-Coremail-Antispam: 1Uf129KBjvJXoW3Ww4Dtw4kWryxWFy8XF13urg_yoWDGFWDpF
	y5A3WayrW8J3ZFqwsFva18tr1ava97Aay7urWxGwn0vFyqkF9YyFySyF1agFy7trZ7CF17
	Xws0qFs5Ca1ayaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UsF4iUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/1tbiOhUko2fut54cUAAAsE



On 2025/4/3 20:24, Hans Zhang wrote:
>>>>>    }
>>>>>    EXPORT_SYMBOL_GPL(pci_find_next_ext_capability);
>>>>>    @@ -648,7 +614,6 @@ EXPORT_SYMBOL_GPL(pci_get_dsn);
>>>>>      static u8 __pci_find_next_ht_cap(struct pci_dev *dev, u8 pos, int
>>>>> ht_cap)
>>>>>    {
>>>>> -    int rc, ttl = PCI_FIND_CAP_TTL;
>>>>>        u8 cap, mask;
>>>>>          if (ht_cap == HT_CAPTYPE_SLAVE || ht_cap == HT_CAPTYPE_HOST)
>>>>> @@ -657,7 +622,7 @@ static u8 __pci_find_next_ht_cap(struct pci_dev 
>>>>> *dev,
>>>>> u8 pos, int ht_cap)
>>>>>            mask = HT_5BIT_CAP_MASK;
>>>>>          pos = __pci_find_next_cap_ttl(dev->bus, dev->devfn, pos,
>>>>> -                      PCI_CAP_ID_HT, &ttl);
>>>>> +                      PCI_CAP_ID_HT);
>>>>>        while (pos) {
>>>>>            rc = pci_read_config_byte(dev, pos + 3, &cap);
>>>>>            if (rc != PCIBIOS_SUCCESSFUL)
>>>>> @@ -668,7 +633,7 @@ static u8 __pci_find_next_ht_cap(struct pci_dev 
>>>>> *dev,
>>>>> u8 pos, int ht_cap)
>>>>>              pos = __pci_find_next_cap_ttl(dev->bus, dev->devfn,
>>>>>                              pos + PCI_CAP_LIST_NEXT,
>>>>> -                          PCI_CAP_ID_HT, &ttl);
>>>>> +                          PCI_CAP_ID_HT);
>>>>
>>>> This function kind of had the idea to share the ttl but I suppose 
>>>> that was
>>>> just a final safeguard to make sure the loop will always terminate 
>>>> in case
>>>> the config space is corrupted so the unsharing is not a big issue.
>>>>
>>>
>>> __pci_find_next_cap_ttl
>>>    // This macro definition already has ttl loop restrictions inside it.
>>>    PCI_FIND_NEXT_CAP_TTL
>>>
>>> Do I understand that you agree to remove ttl initialization and 
>>> parameter
>>> passing?
>>
>> Yes, I agree with it but doing anything like this (although I'd mention
>> the reasoning in the changelog myself).
>>
> 
> Ok, I see. I will give the reasons.

Hi Ilpo,

The [v9 3/6]patch I plan to submit is as follows, please review it.

 From 6da415d130e76b57ecf401f14bf0b66f20407839 Mon Sep 17 00:00:00 2001
From: Hans Zhang <18255117159@163.com>
Date: Fri, 4 Apr 2025 00:20:29 +0800
Subject: [v9 3/6] PCI: Refactor capability search into common macros

- Capability search is done both in PCI core and some controller drivers.
- PCI core's cap search func requires PCI device and bus structs exist.
- Controller drivers cannot use PCI core's cap search func as they
   need to find capabilities before they instantiated the PCI device & bus
   structs.

- Move capability search into a macro so it can be reused where normal
   PCI config space accessors cannot yet be used due to lack of the
   instantiated PCI dev.
- Instead, give the config space reading function as an argument to the
   new macro.
- Convert PCI core to use the new macro.

The macros now implement, parameterized by the config access method. The
PCI core functions are converted to utilize these macros with the standard
pci_bus_read_config accessors. Controller drivers can later use the same
macros with their early access mechanisms while maintaining the existing
protection against infinite loops through preserved TTL checks.

The ttl parameter was originally an additional safeguard to prevent
infinite loops in corrupted config space.  However, the
PCI_FIND_NEXT_CAP_TTL macro already enforces a TTL limit internally.
Removing redundant ttl handling simplifies the interface while maintaining
the safety guarantee. This aligns with the macro's design intent of
encapsulating TTL management.

Signed-off-by: Hans Zhang <18255117159@163.com>
---
  drivers/pci/pci.c | 70 +++++---------------------------------
  drivers/pci/pci.h | 86 +++++++++++++++++++++++++++++++++++++++++++++++
  2 files changed, 95 insertions(+), 61 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index e4d3719b653d..bef242d84ab4 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -9,7 +9,6 @@
   */

  #include <linux/acpi.h>
-#include <linux/align.h>
  #include <linux/kernel.h>
  #include <linux/delay.h>
  #include <linux/dmi.h>
@@ -31,7 +30,6 @@
  #include <asm/dma.h>
  #include <linux/aer.h>
  #include <linux/bitfield.h>
-#include <uapi/linux/pci_regs.h>
  #include "pci.h"

  DEFINE_MUTEX(pci_slot_mutex);
@@ -426,35 +424,16 @@ static int pci_dev_str_match(struct pci_dev *dev, 
const char *p,
  }

  static u8 __pci_find_next_cap_ttl(struct pci_bus *bus, unsigned int devfn,
-				  u8 pos, int cap, int *ttl)
+				  u8 pos, int cap)
  {
-	u8 id;
-	u16 ent;
-
-	pci_bus_read_config_byte(bus, devfn, pos, &pos);
-
-	while ((*ttl)--) {
-		if (pos < PCI_STD_HEADER_SIZEOF)
-			break;
-		pos = ALIGN_DOWN(pos, 4);
-		pci_bus_read_config_word(bus, devfn, pos, &ent);
-
-		id = FIELD_GET(PCI_CAP_ID_MASK, ent);
-		if (id == 0xff)
-			break;
-		if (id == cap)
-			return pos;
-		pos = FIELD_GET(PCI_CAP_LIST_NEXT_MASK, ent);
-	}
-	return 0;
+	return PCI_FIND_NEXT_CAP_TTL(pci_bus_read_config, pos, cap, bus,
+				     devfn);
  }

  static u8 __pci_find_next_cap(struct pci_bus *bus, unsigned int devfn,
  			      u8 pos, int cap)
  {
-	int ttl = PCI_FIND_CAP_TTL;
-
-	return __pci_find_next_cap_ttl(bus, devfn, pos, cap, &ttl);
+	return __pci_find_next_cap_ttl(bus, devfn, pos, cap);
  }

  u8 pci_find_next_capability(struct pci_dev *dev, u8 pos, int cap)
@@ -555,42 +534,11 @@ EXPORT_SYMBOL(pci_bus_find_capability);
   */
  u16 pci_find_next_ext_capability(struct pci_dev *dev, u16 start, int cap)
  {
-	u32 header;
-	int ttl;
-	u16 pos = PCI_CFG_SPACE_SIZE;
-
-	/* minimum 8 bytes per capability */
-	ttl = (PCI_CFG_SPACE_EXP_SIZE - PCI_CFG_SPACE_SIZE) / 8;
-
  	if (dev->cfg_size <= PCI_CFG_SPACE_SIZE)
  		return 0;

-	if (start)
-		pos = start;
-
-	if (pci_read_config_dword(dev, pos, &header) != PCIBIOS_SUCCESSFUL)
-		return 0;
-
-	/*
-	 * If we have no capabilities, this is indicated by cap ID,
-	 * cap version and next pointer all being 0.
-	 */
-	if (header == 0)
-		return 0;
-
-	while (ttl-- > 0) {
-		if (PCI_EXT_CAP_ID(header) == cap && pos != start)
-			return pos;
-
-		pos = PCI_EXT_CAP_NEXT(header);
-		if (pos < PCI_CFG_SPACE_SIZE)
-			break;
-
-		if (pci_read_config_dword(dev, pos, &header) != PCIBIOS_SUCCESSFUL)
-			break;
-	}
-
-	return 0;
+	return PCI_FIND_NEXT_EXT_CAPABILITY(pci_bus_read_config, start, cap,
+					    dev->bus, dev->devfn);
  }
  EXPORT_SYMBOL_GPL(pci_find_next_ext_capability);

@@ -650,7 +598,7 @@ EXPORT_SYMBOL_GPL(pci_get_dsn);

  static u8 __pci_find_next_ht_cap(struct pci_dev *dev, u8 pos, int ht_cap)
  {
-	int rc, ttl = PCI_FIND_CAP_TTL;
+	int rc;
  	u8 cap, mask;

  	if (ht_cap == HT_CAPTYPE_SLAVE || ht_cap == HT_CAPTYPE_HOST)
@@ -659,7 +607,7 @@ static u8 __pci_find_next_ht_cap(struct pci_dev 
*dev, u8 pos, int ht_cap)
  		mask = HT_5BIT_CAP_MASK;

  	pos = __pci_find_next_cap_ttl(dev->bus, dev->devfn, pos,
-				      PCI_CAP_ID_HT, &ttl);
+				      PCI_CAP_ID_HT);
  	while (pos) {
  		rc = pci_read_config_byte(dev, pos + 3, &cap);
  		if (rc != PCIBIOS_SUCCESSFUL)
@@ -670,7 +618,7 @@ static u8 __pci_find_next_ht_cap(struct pci_dev 
*dev, u8 pos, int ht_cap)

  		pos = __pci_find_next_cap_ttl(dev->bus, dev->devfn,
  					      pos + PCI_CAP_LIST_NEXT,
-					      PCI_CAP_ID_HT, &ttl);
+					      PCI_CAP_ID_HT);
  	}

  	return 0;
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 6a7c88b9cd35..b204ebeeb1cf 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -2,7 +2,9 @@
  #ifndef DRIVERS_PCI_H
  #define DRIVERS_PCI_H

+#include <linux/align.h>
  #include <linux/pci.h>
+#include <uapi/linux/pci_regs.h>

  struct pcie_tlp_log;

@@ -91,6 +93,90 @@ bool pcie_cap_has_rtctl(const struct pci_dev *dev);
  int pci_bus_read_config(void *priv, unsigned int devfn, int where, u32 
size,
  			u32 *val);

+/* Standard Capability finder */
+/**
+ * PCI_FIND_NEXT_CAP_TTL - Find a PCI standard capability
+ * @read_cfg: Function pointer for reading PCI config space
+ * @start: Starting position to begin search
+ * @cap: Capability ID to find
+ * @args: Arguments to pass to read_cfg function
+ *
+ * Iterates through the capability list in PCI config space to find
+ * the specified capability. Implements TTL (time-to-live) protection
+ * against infinite loops.
+ *
+ * Returns: Position of the capability if found, 0 otherwise.
+ */
+#define PCI_FIND_NEXT_CAP_TTL(read_cfg, start, cap, args...)		\
+({									\
+	int __ttl = PCI_FIND_CAP_TTL;					\
+	u8 __id, __found_pos = 0;					\
+	u8 __pos = (start);						\
+	u16 __ent;							\
+									\
+	read_cfg(args, __pos, 1, (u32 *)&__pos);			\
+									\
+	while (__ttl--) {						\
+		if (__pos < PCI_STD_HEADER_SIZEOF)			\
+			break;						\
+									\
+		__pos = ALIGN_DOWN(__pos, 4);				\
+		read_cfg(args, __pos, 2, (u32 *)&__ent);		\
+									\
+		__id = FIELD_GET(PCI_CAP_ID_MASK, __ent);		\
+		if (__id == 0xff)					\
+			break;						\
+									\
+		if (__id == (cap)) {					\
+			__found_pos = __pos;				\
+			break;						\
+		}							\
+									\
+		__pos = FIELD_GET(PCI_CAP_LIST_NEXT_MASK, __ent);	\
+	}								\
+	__found_pos;							\
+})
+
+/* Extended Capability finder */
+/**
+ * PCI_FIND_NEXT_EXT_CAPABILITY - Find a PCI extended capability
+ * @read_cfg: Function pointer for reading PCI config space
+ * @start: Starting position to begin search (0 for initial search)
+ * @cap: Extended capability ID to find
+ * @args: Arguments to pass to read_cfg function
+ *
+ * Searches the extended capability space in PCI config registers
+ * for the specified capability. Implements TTL protection against
+ * infinite loops using a calculated maximum search count.
+ *
+ * Returns: Position of the capability if found, 0 otherwise.
+ */
+#define PCI_FIND_NEXT_EXT_CAPABILITY(read_cfg, start, cap, args...)		\
+({										\
+	u16 __pos = (start) ?: PCI_CFG_SPACE_SIZE;				\
+	u16 __found_pos = 0;							\
+	int __ttl, __ret;							\
+	u32 __header;								\
+										\
+	__ttl = (PCI_CFG_SPACE_EXP_SIZE - PCI_CFG_SPACE_SIZE) / 8;		\
+	while (__ttl-- > 0 && __pos >= PCI_CFG_SPACE_SIZE) {			\
+		__ret = read_cfg(args, __pos, 4, &__header);			\
+		if (__ret != PCIBIOS_SUCCESSFUL)				\
+			break;							\
+										\
+		if (__header == 0)						\
+			break;							\
+										\
+		if (PCI_EXT_CAP_ID(__header) == (cap) && __pos != start) {	\
+			__found_pos = __pos;					\
+			break;							\
+		}								\
+										\
+		__pos = PCI_EXT_CAP_NEXT(__header);				\
+	}									\
+	__found_pos;								\
+})
+
  /* Functions internal to the PCI core code */

  #ifdef CONFIG_DMI



Best regards,
Hans


