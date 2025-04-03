Return-Path: <linux-pci+bounces-25241-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58779A7A802
	for <lists+linux-pci@lfdr.de>; Thu,  3 Apr 2025 18:32:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 13697175F05
	for <lists+linux-pci@lfdr.de>; Thu,  3 Apr 2025 16:32:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFA481946C3;
	Thu,  3 Apr 2025 16:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="DnfYs7UI"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE9F22E3387;
	Thu,  3 Apr 2025 16:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743697934; cv=none; b=Mu0KW7vQIlDODaH8XKywtxn8qXYdTQ+PlXaiBcVuPDuqleJkFCZAYFBFC/0xNcbw10m5tGcC3h1PDGLVAADOBnYtnRQZbAlEny2iNuCcfb+18lQPQLdy/h30zhQU6R86Xxvrrws036vKipQDkLPxMgNyK2aC54bX8AtwCxIU478=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743697934; c=relaxed/simple;
	bh=mFTql2fQe91w/S3dMui9ACkHHSYRfXpfZMsRcDQHEeQ=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=TO/CoFJI2vryprsQ/28ecmAKXmVzLP5+ZAEDxJtx5ReYlREpPy8WaTH5TOJ33puKFG/ImOj+sjaDjTnHARVTdmRxxBrnhT1etDvkyBNTIabyzDrfv+cWNjexjOr/BcHMw5wp2iJqfzWLD5LTx/kSo5rrpsaIf3BM788YPjev5CA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=DnfYs7UI; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:From:
	Content-Type; bh=OuP8ZQ+Mg9eSGX38jD1aAJeq1T8gEdgY9LWbVkC4DNs=;
	b=DnfYs7UI6XR+t4Y88pZ69xmzEXdZCNgCFMDpUaM4GjBq0him9pycCJSB2PANeC
	tluElMPLFr1aBGo2W2JW2p3nonX742aWypVwuh5IN4ij1PCQGTcswZDJkN1U3dKt
	ZDC0X1zi9NaOj1+mVi7PgIN86st8wZKz79jUMlz2J18+c=
Received: from [192.168.71.89] (unknown [])
	by gzga-smtp-mtada-g1-0 (Coremail) with SMTP id _____wBHpZfet+5nYQYfBw--.36929S2;
	Fri, 04 Apr 2025 00:31:27 +0800 (CST)
Message-ID: <fffcd237-9084-4be3-8967-f012d981b3f5@163.com>
Date: Fri, 4 Apr 2025 00:31:26 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [v7 1/5] PCI: Refactor capability search into common macros
From: Hans Zhang <18255117159@163.com>
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: lpieralisi@kernel.org, bhelgaas@google.com, kw@linux.com,
 manivannan.sadhasivam@linaro.org, robh@kernel.org, jingoohan1@gmail.com,
 thomas.richard@bootlin.com, linux-pci@vger.kernel.org,
 LKML <linux-kernel@vger.kernel.org>
References: <20250402042020.48681-1-18255117159@163.com>
 <20250402042020.48681-2-18255117159@163.com>
 <909653ac-7ba2-9da7-f519-3d849146f433@linux.intel.com>
 <6075b776-d2be-49d3-8321-e6af66781709@163.com>
 <9e9a68b1-8c3a-6132-d4fc-9f7b0b2d3e3a@linux.intel.com>
 <a0483c8d-3cd4-4da2-aca5-586379870e3a@163.com>
Content-Language: en-US
In-Reply-To: <a0483c8d-3cd4-4da2-aca5-586379870e3a@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wBHpZfet+5nYQYfBw--.36929S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxXFyxJFy3GF43AFW5Aw1DKFg_yoWrGr4DpF
	98C3WayrW8JF12krn29a4jywnFqFyDCayDW34fW3WDZF9FyF1xt392kr1agF17X397KF15
	X34q9a4fGFWayFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UVOJ5UUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbBDxUko2fulgLOSAACsE



On 2025/4/3 20:22, Hans Zhang wrote:
>>>>> +#define PCI_FIND_NEXT_CAP_TTL(read_cfg, start, cap, args...)
>>>>> \
>>>>> +({                                    \
>>>>> +    u8 __pos = (start);                        \
>>>>> +    int __ttl = PCI_FIND_CAP_TTL;                    \
>>>>> +    u16 __ent;                            \
>>>>> +    u8 __found_pos = 0;                        \
>>>>> +    u8 __id;                            \
>>>>> +                                    \
>>>>> +    read_cfg(args, __pos, 1, (u32 *)&__pos);            \
>>>>> +                                    \
>>>>> +    while (__ttl--) {                        \
>>>>> +        if (__pos < PCI_STD_HEADER_SIZEOF)            \
>>>>> +            break;                        \
>>>>> +        __pos = ALIGN_DOWN(__pos, 4);                \
>>>>> +        read_cfg(args, __pos, 2, (u32 *)&__ent);        \
>>>>> +        __id = FIELD_GET(PCI_CAP_ID_MASK, __ent);        \
>>>>> +        if (__id == 0xff)                    \
>>>>> +            break;                        \
>>>>> +        if (__id == (cap)) {                    \
>>>>> +            __found_pos = __pos;                \
>>>>> +            break;                        \
>>>>> +        }                            \
>>>>> +        __pos = FIELD_GET(PCI_CAP_LIST_NEXT_MASK, __ent);    \
>>>>
>>>> Could you please separate the coding style cleanups into own patch that
>>>> is before the actual move patch. IMO, all those cleanups can be in the
>>>> same patch.
>>>>
>>>
>>> Thanks your for reply. I don't understand. Is it like this?
>>
>> Add a patch before the first patch which does only the cleanups to
>> __pci_find_next_cap_ttl(). The patch that creates PCI_FIND_NEXT_CAP_TTL()
>> and converts its PCI core users (most of the patches 1&2) is to be based
>> on top of that cleanup patch.
>>
> 
> Thank you so much for your patience in explaining it to me.

Hi Ilpo,

The [v9 2/6]patch I plan to submit is as follows, please review it.

 From 300fe1f428930d0bf8a361ea1d1a3272a6153107 Mon Sep 17 00:00:00 2001
From: Hans Zhang <18255117159@163.com>
Date: Fri, 4 Apr 2025 00:20:03 +0800
Subject: [v9 2/6] PCI: Clean up __pci_find_next_cap_ttl() readability

Refactor the __pci_find_next_cap_ttl() to improve code clarity:
- Replace magic number 0x40 with PCI_STD_HEADER_SIZEOF.
- Use ALIGN_DOWN() for position alignment instead of manual bitmask.
- Extract PCI capability fields via FIELD_GET() with standardized masks.
- Add necessary headers (linux/align.h, uapi/linux/pci_regs.h).

The changes are purely non-functional cleanups, ensuring behavior remains
identical to the original implementation.

Signed-off-by: Hans Zhang <18255117159@163.com>
---
  drivers/pci/pci.c             | 10 ++++++----
  include/uapi/linux/pci_regs.h |  2 ++
  2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 869d204a70a3..e4d3719b653d 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -9,6 +9,7 @@
   */

  #include <linux/acpi.h>
+#include <linux/align.h>
  #include <linux/kernel.h>
  #include <linux/delay.h>
  #include <linux/dmi.h>
@@ -30,6 +31,7 @@
  #include <asm/dma.h>
  #include <linux/aer.h>
  #include <linux/bitfield.h>
+#include <uapi/linux/pci_regs.h>
  #include "pci.h"

  DEFINE_MUTEX(pci_slot_mutex);
@@ -432,17 +434,17 @@ static u8 __pci_find_next_cap_ttl(struct pci_bus 
*bus, unsigned int devfn,
  	pci_bus_read_config_byte(bus, devfn, pos, &pos);

  	while ((*ttl)--) {
-		if (pos < 0x40)
+		if (pos < PCI_STD_HEADER_SIZEOF)
  			break;
-		pos &= ~3;
+		pos = ALIGN_DOWN(pos, 4);
  		pci_bus_read_config_word(bus, devfn, pos, &ent);

-		id = ent & 0xff;
+		id = FIELD_GET(PCI_CAP_ID_MASK, ent);
  		if (id == 0xff)
  			break;
  		if (id == cap)
  			return pos;
-		pos = (ent >> 8);
+		pos = FIELD_GET(PCI_CAP_LIST_NEXT_MASK, ent);
  	}
  	return 0;
  }
diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
index 3445c4970e4d..a11ebbab99fc 100644
--- a/include/uapi/linux/pci_regs.h
+++ b/include/uapi/linux/pci_regs.h
@@ -206,6 +206,8 @@
  /* 0x48-0x7f reserved */

  /* Capability lists */
+#define PCI_CAP_ID_MASK		0x00ff
+#define PCI_CAP_LIST_NEXT_MASK	0xff00

  #define PCI_CAP_LIST_ID		0	/* Capability ID */
  #define  PCI_CAP_ID_PM		0x01	/* Power Management */




Best regards,
Hans


