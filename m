Return-Path: <linux-pci+bounces-24930-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ECA9A7485E
	for <lists+linux-pci@lfdr.de>; Fri, 28 Mar 2025 11:34:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C0CB1896116
	for <lists+linux-pci@lfdr.de>; Fri, 28 Mar 2025 10:34:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9253517A302;
	Fri, 28 Mar 2025 10:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="aj9regYp"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68F734A35;
	Fri, 28 Mar 2025 10:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743158053; cv=none; b=Ednmnw3IpNfjfeZc6tCiYXXBauG3nUFirbMbf50t1siUwXrFlMyGObJ2bOG8+D0lPZCowfx5fD/KZBWZOQs5bMxdGMi4JW4sJMoZkH9Z3nxfUm5F8o4HD1vYGDcjM9U4EuW7Ic4i3Xxq564v//7WKOT4Kw6W7v4ziD/RIZeM5Hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743158053; c=relaxed/simple;
	bh=n8LV2y0jcl19jFEKy2366B4vJq+cf9Ba091cscKrEZY=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=eP7sEKnxxWl70CckFlm8YAUOTaunJxJUpCcrGJxKLa8XTCf5rDsM8V/evNWt16H/y6iT5VqeAq5CN0qqq/KWsCwlheTESiqeWU11acscWcIZl2PL3cdNTx8NCXT1Jzx6GXjvdAGu6uyuHeRgfS4cpO+JwjJI0ebacD7KJJlxtBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=aj9regYp; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:From:
	Content-Type; bh=LmapWkrqWUTuiw6YKSd8zCrQeL5wVOZLPa/A4AV+vE0=;
	b=aj9regYpb3rZw9VPeCIptFKmJWnUfJ1RDhZix9uD18z5uvIPrK3BdMoKDQScUj
	sDcPFPh/6T8IpInVQ4hmlErqrN16GCB2vGLY/KCReSViQw4IaNyXu3G5glJwXdLz
	9sSfsxbpvoKM9wL1a4BxE+DXEwplqSqvloDvD2E+JO43Y=
Received: from [192.168.60.52] (unknown [])
	by gzga-smtp-mtada-g1-4 (Coremail) with SMTP id _____wBHnJb2euZnh+KxCQ--.63968S2;
	Fri, 28 Mar 2025 18:33:28 +0800 (CST)
Message-ID: <b279863e-8d8c-4c14-98ad-c19d26c69146@163.com>
Date: Fri, 28 Mar 2025 18:33:26 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [v6 3/5] PCI: cadence: Use common PCI host bridge APIs for
 finding the capabilities
From: Hans Zhang <18255117159@163.com>
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Bjorn Helgaas <bhelgaas@google.com>
Cc: lpieralisi@kernel.org, kw@linux.com, robh@kernel.org,
 jingoohan1@gmail.com, thomas.richard@bootlin.com, linux-pci@vger.kernel.org,
 LKML <linux-kernel@vger.kernel.org>
References: <20250323164852.430546-1-18255117159@163.com>
 <20250323164852.430546-4-18255117159@163.com>
 <f467056d-8d4a-9dab-2f0a-ca589adfde53@linux.intel.com>
 <d370b69a-3b70-4e3b-94a3-43e0bc1305cd@163.com>
 <a3462c68-ec1b-0b1a-fee7-612bd1109819@linux.intel.com>
 <3d9b2fa9-98bf-4f47-aa76-640a4f82cb2f@163.com>
 <26dcba54-93c1-dda4-c5e2-e324e9d50b09@linux.intel.com>
 <f2725090-e199-493d-9ae3-e807d65f647b@163.com>
 <de6ce71c-ba82-496e-9c72-7c9c61b37906@163.com>
 <ddabf340-a00f-75b1-2b6b-d9ab550a984f@linux.intel.com>
 <9118fcc0-e5a5-40f2-be4b-7e06b4b20601@163.com>
Content-Language: en-US
In-Reply-To: <9118fcc0-e5a5-40f2-be4b-7e06b4b20601@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wBHnJb2euZnh+KxCQ--.63968S2
X-Coremail-Antispam: 1Uf129KBjvJXoW3KrWftw4ktry8JFyUJrW5Jrb_yoWDKr4UpF
	W5Ja4SyFWrJF13Zrn2van0yr1ayF9Ika47JayxG34avr12krWrAFyIkFyagF1fKr4kWF13
	X3yDtFWkC3Z0yFUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UJnYwUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/1tbiOhQeo2fmdyluRQAAsn



On 2025/3/25 23:37, Hans Zhang wrote:
> 
> 
> On 2025/3/25 23:18, Ilpo Järvinen wrote:>>
>>> Hi Ilpo,
>>>
>>> Another question comes to mind:
>>> If working in EP mode, devm_pci_alloc_host_bridge will not be 
>>> executed and
>>> there will be no struct pci_host_bridge.
>>>
>>> Don't know if you have anything to add?
>>
>> Hi Hans,
>>
>> No, I don't have further ideas at this point, sorry. It seems it isn't
>> realistic without something more substantial that currently isn't there.
>>
>> This lack of way to have a generic way to read the config before the main
>> struct are instanciated by the PCI core seems to be the limitation that
>> hinders sharing code between controller drivers and it would have been
>> nice to address it.
>>
>> But please still make the capability list parsing code common, it should
>> be relatively straightforward using a macro which can take different read
>> functions similar to read_poll_timeout. That will avoid at least some
>> amount of code duplication.
>>
>> Thanks for trying to come up with a solution (or thinking enough to say
>> it doesn't work)!
>>
> 
> Hi Ilpo,
> 
> It's okay. It's what I'm supposed to do. Thank you very much for your 
> discussion with me. I'll try a macro definition like read_poll_timeout. 
> Will share the revised patches soon for your feedback.
> 
> Best regards,
> Hans
> 
> 

Dear Ilpo, Mani and Bjorn,


The following is my new idea, and the following is patch. Please help to 
check whether it is reasonable.

I successfully tested the CDNS and DWC drivers locally. If there are 
other risks, please point them out, and we'll discuss them. Please give 
your opinion. Thank you very much.

Or is the submitted patch reasonable? I'd like to ask for your advice.

Patchs:

diff --git a/drivers/pci/controller/cadence/pcie-cadence.c 
b/drivers/pci/controller/cadence/pcie-cadence.c
index 204e045aed8c..92aea42a18d0 100644
--- a/drivers/pci/controller/cadence/pcie-cadence.c
+++ b/drivers/pci/controller/cadence/pcie-cadence.c
@@ -5,9 +5,37 @@

  #include <linux/kernel.h>
  #include <linux/of.h>
+#include <linux/pci.h>

  #include "pcie-cadence.h"

+static int cdns_pcie_read_cfg(void *priv, unsigned int devfn, int where,
+			      int size, u32 *val)
+{
+	struct cdns_pcie *pcie = priv;
+
+	if (size == 4)
+		*val = cdns_pcie_readl(pcie, where);
+	else if (size == 2)
+		*val = cdns_pcie_readw(pcie, where);
+	else if (size == 1)
+		*val = cdns_pcie_readb(pcie, where);
+
+	return PCIBIOS_SUCCESSFUL;
+}
+
+u8 cdns_pcie_find_capability(struct cdns_pcie *pcie, u8 cap)
+{
+	return PCI_FIND_NEXT_CAP_TTL(pcie, 0, cdns_pcie_read_cfg,
+				     PCI_CAPABILITY_LIST, cap);
+}
+
+u16 cdns_pcie_find_ext_capability(struct cdns_pcie *pcie, u8 cap)
+{
+	return PCI_FIND_NEXT_EXT_CAPABILITY(pcie, 0, cdns_pcie_read_cfg, 0,
+					    cap);
+}
+
  void cdns_pcie_detect_quiet_min_delay_set(struct cdns_pcie *pcie)
  {
  	u32 delay = 0x3;
diff --git a/drivers/pci/controller/cadence/pcie-cadence.h 
b/drivers/pci/controller/cadence/pcie-cadence.h
index f5eeff834ec1..dd7cb6b6b291 100644
--- a/drivers/pci/controller/cadence/pcie-cadence.h
+++ b/drivers/pci/controller/cadence/pcie-cadence.h
@@ -398,6 +398,16 @@ static inline u32 cdns_pcie_readl(struct cdns_pcie 
*pcie, u32 reg)
  	return readl(pcie->reg_base + reg);
  }

+static inline u32 cdns_pcie_readw(struct cdns_pcie *pcie, u32 reg)
+{
+	return readw(pcie->reg_base + reg);
+}
+
+static inline u32 cdns_pcie_readb(struct cdns_pcie *pcie, u32 reg)
+{
+	return readb(pcie->reg_base + reg);
+}
+
  static inline u32 cdns_pcie_read_sz(void __iomem *addr, int size)
  {
  	void __iomem *aligned_addr = PTR_ALIGN_DOWN(addr, 0x4);
@@ -557,6 +567,9 @@ static inline int cdns_pcie_ep_setup(struct 
cdns_pcie_ep *ep)
  }
  #endif

+u8 cdns_pcie_find_capability(struct cdns_pcie *pcie, u8 cap);
+u16 cdns_pcie_find_ext_capability(struct cdns_pcie *pcie, u8 cap);
+
  void cdns_pcie_detect_quiet_min_delay_set(struct cdns_pcie *pcie);

  void cdns_pcie_set_outbound_region(struct cdns_pcie *pcie, u8 busnr, 
u8 fn,
diff --git a/drivers/pci/controller/dwc/pcie-designware.c 
b/drivers/pci/controller/dwc/pcie-designware.c
index 145e7f579072..1b579dbc5cb1 100644
--- a/drivers/pci/controller/dwc/pcie-designware.c
+++ b/drivers/pci/controller/dwc/pcie-designware.c
@@ -203,83 +203,26 @@ void dw_pcie_version_detect(struct dw_pcie *pci)
  		pci->type = ver;
  }

-/*
- * These interfaces resemble the pci_find_*capability() interfaces, but 
these
- * are for configuring host controllers, which are bridges *to* PCI 
devices but
- * are not PCI devices themselves.
- */
-static u8 __dw_pcie_find_next_cap(struct dw_pcie *pci, u8 cap_ptr,
-				  u8 cap)
+static int dw_pcie_read_cfg(void *priv, unsigned int devfn, int where, 
int size,
+			    u32 *val)
  {
-	u8 cap_id, next_cap_ptr;
-	u16 reg;
-
-	if (!cap_ptr)
-		return 0;
-
-	reg = dw_pcie_readw_dbi(pci, cap_ptr);
-	cap_id = (reg & 0x00ff);
-
-	if (cap_id > PCI_CAP_ID_MAX)
-		return 0;
+	struct dw_pcie *pcie = priv;
+	*val = dw_pcie_read_dbi(pcie, where, size);

-	if (cap_id == cap)
-		return cap_ptr;
-
-	next_cap_ptr = (reg & 0xff00) >> 8;
-	return __dw_pcie_find_next_cap(pci, next_cap_ptr, cap);
+	return PCIBIOS_SUCCESSFUL;
  }

  u8 dw_pcie_find_capability(struct dw_pcie *pci, u8 cap)
  {
-	u8 next_cap_ptr;
-	u16 reg;
-
-	reg = dw_pcie_readw_dbi(pci, PCI_CAPABILITY_LIST);
-	next_cap_ptr = (reg & 0x00ff);
-
-	return __dw_pcie_find_next_cap(pci, next_cap_ptr, cap);
+	return PCI_FIND_NEXT_CAP_TTL(pcie, 0, dw_pcie_read_cfg,
+				     PCI_CAPABILITY_LIST, cap);
  }
  EXPORT_SYMBOL_GPL(dw_pcie_find_capability);

-static u16 dw_pcie_find_next_ext_capability(struct dw_pcie *pci, u16 start,
-					    u8 cap)
-{
-	u32 header;
-	int ttl;
-	int pos = PCI_CFG_SPACE_SIZE;
-
-	/* minimum 8 bytes per capability */
-	ttl = (PCI_CFG_SPACE_EXP_SIZE - PCI_CFG_SPACE_SIZE) / 8;
-
-	if (start)
-		pos = start;
-
-	header = dw_pcie_readl_dbi(pci, pos);
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
-		header = dw_pcie_readl_dbi(pci, pos);
-	}
-
-	return 0;
-}
-
  u16 dw_pcie_find_ext_capability(struct dw_pcie *pci, u8 cap)
  {
-	return dw_pcie_find_next_ext_capability(pci, 0, cap);
+	return PCI_FIND_NEXT_EXT_CAPABILITY(pcie, 0, dw_pcie_read_cfg, 0,
+					    cap);
  }
  EXPORT_SYMBOL_GPL(dw_pcie_find_ext_capability);

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 869d204a70a3..af7467c3143d 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -423,28 +423,27 @@ static int pci_dev_str_match(struct pci_dev *dev, 
const char *p,
  	return 1;
  }

-static u8 __pci_find_next_cap_ttl(struct pci_bus *bus, unsigned int devfn,
-				  u8 pos, int cap, int *ttl)
+static int __pci_bus_read_config(void *priv, unsigned int devfn, int where,
+				 u32 size, u32 *val)
  {
-	u8 id;
-	u16 ent;
+	struct pci_bus *bus = priv;
+	int ret;

-	pci_bus_read_config_byte(bus, devfn, pos, &pos);
+	if (size == 1)
+		ret = pci_bus_read_config_byte(bus, devfn, where, (u8 *)val);
+	else if (size == 2)
+		ret = pci_bus_read_config_word(bus, devfn, where, (u16 *)val);
+	else
+		ret = pci_bus_read_config_dword(bus, devfn, where, val);

-	while ((*ttl)--) {
-		if (pos < 0x40)
-			break;
-		pos &= ~3;
-		pci_bus_read_config_word(bus, devfn, pos, &ent);
+	return ret;
+}

-		id = ent & 0xff;
-		if (id == 0xff)
-			break;
-		if (id == cap)
-			return pos;
-		pos = (ent >> 8);
-	}
-	return 0;
+static u8 __pci_find_next_cap_ttl(struct pci_bus *bus, unsigned int devfn,
+				  u8 pos, int cap, int *ttl)
+{
+	return PCI_FIND_NEXT_CAP_TTL(bus, devfn, __pci_bus_read_config, pos,
+				     cap);
  }

  static u8 __pci_find_next_cap(struct pci_bus *bus, unsigned int devfn,
@@ -553,42 +552,11 @@ EXPORT_SYMBOL(pci_bus_find_capability);
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
+	return PCI_FIND_NEXT_EXT_CAPABILITY(dev->bus, dev->devfn,
+					    __pci_bus_read_config, start, cap);
  }
  EXPORT_SYMBOL_GPL(pci_find_next_ext_capability);

diff --git a/include/linux/pci.h b/include/linux/pci.h
index 47b31ad724fa..0d5dfd010a01 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1198,6 +1198,64 @@ void pci_sort_breadthfirst(void);

  /* Generic PCI functions exported to card drivers */

+/* Extended capability finder */
+#define PCI_FIND_NEXT_CAP_TTL(priv, devfn, read_cfg, start, cap) 
     \
+	({                                                                  \
+		typeof(start) __pos = (start);                              \
+		int __ttl = PCI_FIND_CAP_TTL;                               \
+		u16 __ent = 0;                                              \
+		u8 __found_pos = 0;                                         \
+		u8 __id;                                                    \
+ 
     \
+		read_cfg((priv), (devfn), __pos, 1, (u32 *)&__pos);         \
+ 
     \
+		while (__ttl--) {                                           \
+			if (__pos < 0x40)                                   \
+				break;                                      \
+			__pos &= ~3;                                        \
+			read_cfg((priv), (devfn), __pos, 2, (u32 *)&__ent); \
+ 
     \
+			__id = __ent & 0xff;                                \
+			if (__id == 0xff)                                   \
+				break;                                      \
+			if (__id == (cap)) {                                \
+				__found_pos = __pos;                        \
+				break;                                      \
+			}                                                   \
+			__pos = (__ent >> 8);                               \
+		}                                                           \
+		__found_pos;                                                \
+	})
+
+/* Extended capability finder */
+#define PCI_FIND_NEXT_EXT_CAPABILITY(priv, devfn, read_cfg, start, cap) 
    \
+	({                                                                 \
+		u16 __pos = (start) ?: PCI_CFG_SPACE_SIZE;                 \
+		u16 __found_pos = 0;                                       \
+		int __ttl, __ret;                                          \
+		u32 __header;                                              \
+ 
    \
+		__ttl = (PCI_CFG_SPACE_EXP_SIZE - PCI_CFG_SPACE_SIZE) / 8; \
+		while (__ttl-- > 0 && __pos >= PCI_CFG_SPACE_SIZE) {       \
+			__ret = read_cfg((priv), (devfn), __pos, 4,        \
+					 &__header);                       \
+			if (__ret != PCIBIOS_SUCCESSFUL)                   \
+				break;                                     \
+ 
    \
+			if (__header == 0)                                 \
+				break;                                     \
+ 
    \
+			if (PCI_EXT_CAP_ID(__header) == (cap) &&           \
+			    __pos != start) {                              \
+				__found_pos = __pos;                       \
+				break;                                     \
+			}                                                  \
+ 
    \
+			__pos = PCI_EXT_CAP_NEXT(__header);                \
+		}                                                          \
+		__found_pos;                                               \
+	})
+
  u8 pci_bus_find_capability(struct pci_bus *bus, unsigned int devfn, 
int cap);
  u8 pci_find_capability(struct pci_dev *dev, int cap);
  u8 pci_find_next_capability(struct pci_dev *dev, u8 pos, int cap);





Best regards,
Hans


