Return-Path: <linux-pci+bounces-24977-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E900A75726
	for <lists+linux-pci@lfdr.de>; Sat, 29 Mar 2025 17:04:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B3B818848A7
	for <lists+linux-pci@lfdr.de>; Sat, 29 Mar 2025 16:04:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46AF71D63FC;
	Sat, 29 Mar 2025 16:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="nP7/JNp6"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE1BD149C55;
	Sat, 29 Mar 2025 16:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743264286; cv=none; b=MZ++pLL7yOi0Vew+3tFNAiNxRawoNXdZ3ya+JG/hKE78VWvJI85kDmJFRduKYqjgi9Ps5Us3yTbqqw/Ye9WK/b6qTVDkkM/Wi87F1pormXJYgu/uGuI+vEnKa0kYonPIxls6XMIXWiFEdRSO33vO0AdwQ/Jf+roH9ktjHpMwuUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743264286; c=relaxed/simple;
	bh=GV0VJoG2FOuRIEztRSJsH/0e5FecCJlzCmtykVF4ktM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IsylsOTeYWmpVmhZOLWv/Rl7TJkF4IGNiR4ybUf8P3wXMCj7stvpLgbrlDLZ23s2IStuASCM/70icY03NrXBrOBvQNlM1oDOdZ1aR6/P2Gf0aQkn1lUCk716Yif5U1FKlQW6Mjd4vveHQKcrG6LDfi5kBfjxMtJjMl5ryNSKE6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=nP7/JNp6; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:From:
	Content-Type; bh=PGvq+IgOO0pDlT/nRQyeX7phWlmZUo5b8zjWNJ3Kvqw=;
	b=nP7/JNp6EALTPYs4yVKLSsSjs8lgJlyxUaRey+NgDroyOjOftlsB1YOjlmP4Iu
	EdE/516y+FD7AAo/vYby6xjLJUHLh9RLrn9m4Tfwgf+jh4oJXHF/2T2DrJwuJ0v+
	rBADRGOvSpDVuMkeEOyaCrjHBaCLqwsRohGFmGmD2BvDA=
Received: from [192.168.71.89] (unknown [])
	by gzsmtp1 (Coremail) with SMTP id PCgvCgAX2MDiGehnaj5fAg--.12996S2;
	Sun, 30 Mar 2025 00:03:48 +0800 (CST)
Message-ID: <95d9f7d9-6569-4252-a54d-cbe38ade706b@163.com>
Date: Sun, 30 Mar 2025 00:03:46 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [v6 3/5] PCI: cadence: Use common PCI host bridge APIs for
 finding the capabilities
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Bjorn Helgaas <bhelgaas@google.com>, lpieralisi@kernel.org, kw@linux.com,
 robh@kernel.org, jingoohan1@gmail.com, thomas.richard@bootlin.com,
 linux-pci@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
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
 <b279863e-8d8c-4c14-98ad-c19d26c69146@163.com>
 <0e493832-6292-10d7-6f87-ed190059c999@linux.intel.com>
Content-Language: en-US
From: Hans Zhang <18255117159@163.com>
In-Reply-To: <0e493832-6292-10d7-6f87-ed190059c999@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PCgvCgAX2MDiGehnaj5fAg--.12996S2
X-Coremail-Antispam: 1Uf129KBjvAXoW3CrWruF4DCFyxAw1UGFW7Jwb_yoW8GF48uo
	WfXrnxu3WrWr17A3yDKas7XwnrZa4avFn3AF4fCrs8XFy5Aa15Cr43Ca1fZ3y5uw48trWU
	Zryktw12gFsFv3Wfn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
	AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUn1v3DUUUU
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/1tbiOgMeo2fmiTkwdQABsx



On 2025/3/28 19:42, Ilpo Järvinen wrote:
>> diff --git a/include/linux/pci.h b/include/linux/pci.h
>> index 47b31ad724fa..0d5dfd010a01 100644
>> --- a/include/linux/pci.h
>> +++ b/include/linux/pci.h
>> @@ -1198,6 +1198,64 @@ void pci_sort_breadthfirst(void);
>>
>>   /* Generic PCI functions exported to card drivers */
>>
>> +/* Extended capability finder */
>> +#define PCI_FIND_NEXT_CAP_TTL(priv, devfn, read_cfg, start, cap)     \
> 
> Please put it into drivers/pci/pci.h but other than that this is certainly
> to the direction I was suggesting.

Hi Ilpo,

I'm sorry for not replying to you in time. I tried to understand your 
suggestion, modify it, and then experiment on the actual SOC platform. 
Thank you very much for your reply and patient advice.

I'm going to put it in the drivers/pci/pci.h file.

> 
> You don't need to have those priv and devfn there like that but you can
> use the args... trick (see linux/iopoll.h) and put them as last parameters
> to the macro so they can wary based on the caller needs, assuming args
> will work like this, I've not tested:
> 
> 		read_cfg(args, __pos, &val)
> 

I have modified it in the following reply, but I only modify it like 
this at present: read_cfg(args, __pos, size, &val)

> The size parameter is the most annoying one as it's in between where and
> *val arguments so args... trick won't work for it. I suggest just
> providing a function with the same signature as the related pci/access.c
> function for now.
> 

Currently DWC, CDNS, and pci.c seem to be unable to unify a common 
function to read config.

I don't quite understand what you mean here. Is the current 
dw_pcie_read_cfg, cdns_pcie_read_cfg, __pci_bus_read_config correct? 
Please look at my latest modification. If it is not correct, please 
explain it again. Thank you very much.

> A few nits related to the existing code quality of the cap parser function
> which should be addressed while we touch this function (probably in own
> patches indepedent of this code move/rearrange patch itself).
> 

I will revise it in my final submission. The following reply has been 
modified.

>> +	({                                                                  \
>> +		typeof(start) __pos = (start);                              \
>> +		int __ttl = PCI_FIND_CAP_TTL;                               \
>> +		u16 __ent = 0;                                              \
>> +		u8 __found_pos = 0;                                         \
>> +		u8 __id;                                                    \
>> +     \
>> +		read_cfg((priv), (devfn), __pos, 1, (u32 *)&__pos);         \
>> +     \
>> +		while (__ttl--) {                                           \
>> +			if (__pos < 0x40)                                   \
> 
> I started to wonder if there's something for this and it turn out we've
> PCI_STD_HEADER_SIZEOF.

It has been modified.

> 
>> +				break;                                      \
>> +			__pos &= ~3;                                        \
> 
> This could use some align helper.

It has been modified.

> 
>> +			read_cfg((priv), (devfn), __pos, 2, (u32 *)&__ent); \
>> +     \
>> +			__id = __ent & 0xff;                                \
>> +			if (__id == 0xff)                                   \
>> +				break;                                      \
>> +			if (__id == (cap)) {                                \
>> +				__found_pos = __pos;                        \
>> +				break;                                      \
>> +			}                                                   \
>> +			__pos = (__ent >> 8);                               \
> 
> I'd add these into uapi/linux/pci_regs.h:

This means that you will submit, and I will submit after you?
Or should I submit this series of patches together?

> 
> #define PCI_CAP_ID_MASK		0x00ff
> #define PCI_CAP_LIST_NEXT_MASK	0xff00
> 
> And then use FIELD_GET() to extract the fields.

It has been modified.

> 
>> +		}                                                           \
>> +		__found_pos;                                                \
>> +	})
>> +
>> +/* Extended capability finder */
>> +#define PCI_FIND_NEXT_EXT_CAPABILITY(priv, devfn, read_cfg, start, cap)    \
>> +	({                                                                 \
>> +		u16 __pos = (start) ?: PCI_CFG_SPACE_SIZE;                 \
>> +		u16 __found_pos = 0;                                       \
>> +		int __ttl, __ret;                                          \
>> +		u32 __header;                                              \
>> +    \
>> +		__ttl = (PCI_CFG_SPACE_EXP_SIZE - PCI_CFG_SPACE_SIZE) / 8; \
>> +		while (__ttl-- > 0 && __pos >= PCI_CFG_SPACE_SIZE) {       \
>> +			__ret = read_cfg((priv), (devfn), __pos, 4,        \
>> +					 &__header);                       \
>> +			if (__ret != PCIBIOS_SUCCESSFUL)                   \
>> +				break;                                     \
>> +    \
>> +			if (__header == 0)                                 \
>> +				break;                                     \
>> +    \
>> +			if (PCI_EXT_CAP_ID(__header) == (cap) &&           \
>> +			    __pos != start) {                              \
>> +				__found_pos = __pos;                       \
>> +				break;                                     \
>> +			}                                                  \
>> +    \
>> +			__pos = PCI_EXT_CAP_NEXT(__header);                \
>> +		}                                                          \
>> +		__found_pos;                                               \
>> +	})
>> +
>>   u8 pci_bus_find_capability(struct pci_bus *bus, unsigned int devfn, int cap);
>>   u8 pci_find_capability(struct pci_dev *dev, int cap);
>>   u8 pci_find_next_capability(struct pci_dev *dev, u8 pos, int cap);
> 
> 
> I started to wonder though if the controller drivers could simply create
> an "early" struct pci_dev & pci_bus just so they can use the normal
> accessors while the real structs are not yet created. It looks not
> much is needed from those structs to let the accessors to work.
> 

Here are a few questions:
1. We need to initialize some variables for pci_dev. For example, 
dev->cfg_size needs to be initialized to 4K for PCIe.

u16 pci_find_next_ext_capability(struct pci_dev *dev, u16 start, int cap)
{
	......
	if (dev->cfg_size <= PCI_CFG_SPACE_SIZE)
		return 0;
	......


2. Create an "early" struct pci_dev & pci_bus for each SOC vendor (Qcom, 
Rockchip, etc). It leads to a lot of code that feels weird.

I still prefer the approach we are discussing now.


This is a modified patchs based on your suggestion:

diff --git a/drivers/pci/controller/cadence/pcie-cadence.c 
b/drivers/pci/controller/cadence/pcie-cadence.c
index 204e045aed8c..3991cc4c58d6 100644
--- a/drivers/pci/controller/cadence/pcie-cadence.c
+++ b/drivers/pci/controller/cadence/pcie-cadence.c
@@ -7,6 +7,32 @@
  #include <linux/of.h>

  #include "pcie-cadence.h"
+#include "../../pci.h"
+
+static int cdns_pcie_read_cfg(void *priv, int where, int size, u32 *val)
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
+	return PCI_FIND_NEXT_CAP_TTL(cdns_pcie_read_cfg, PCI_CAPABILITY_LIST,
+				     cap, pcie);
+}
+
+u16 cdns_pcie_find_ext_capability(struct cdns_pcie *pcie, u8 cap)
+{
+	return PCI_FIND_NEXT_EXT_CAPABILITY(cdns_pcie_read_cfg, 0, cap, pcie);
+}

  void cdns_pcie_detect_quiet_min_delay_set(struct cdns_pcie *pcie)
  {
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
index 145e7f579072..e9a9a80b1085 100644
--- a/drivers/pci/controller/dwc/pcie-designware.c
+++ b/drivers/pci/controller/dwc/pcie-designware.c
@@ -203,83 +203,25 @@ void dw_pcie_version_detect(struct dw_pcie *pci)
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
+static int dw_pcie_read_cfg(void *priv, int where, int size, u32 *val)
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

-	if (cap_id == cap)
-		return cap_ptr;
+	*val = dw_pcie_read_dbi(pcie, where, size);

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
+	return PCI_FIND_NEXT_CAP_TTL(dw_pcie_read_cfg, PCI_CAPABILITY_LIST, cap,
+				     pcie);
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
+	return PCI_FIND_NEXT_EXT_CAPABILITY(dw_pcie_read_cfg, 0, cap, pcie);
  }
  EXPORT_SYMBOL_GPL(dw_pcie_find_ext_capability);

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 869d204a70a3..778e366ea72e 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -423,28 +423,28 @@ static int pci_dev_str_match(struct pci_dev *dev, 
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
+	// If accepted, I will remove all use of "int *ttl" in a future patch.
+	return PCI_FIND_NEXT_CAP_TTL(__pci_bus_read_config, pos, cap, bus,
+				     devfn);
  }

  static u8 __pci_find_next_cap(struct pci_bus *bus, unsigned int devfn,
@@ -553,42 +553,11 @@ EXPORT_SYMBOL(pci_bus_find_capability);
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
+	return PCI_FIND_NEXT_EXT_CAPABILITY(__pci_bus_read_config, start, cap,
+					    dev->bus, dev->devfn);
  }
  EXPORT_SYMBOL_GPL(pci_find_next_ext_capability);

diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 2e9cf26a9ee9..68c111be521d 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -4,6 +4,65 @@

  #include <linux/pci.h>

+/* Ilpo: I'd add these into uapi/linux/pci_regs.h: */
+#define PCI_CAP_ID_MASK		0x00ff
+#define PCI_CAP_LIST_NEXT_MASK	0xff00
+
+/* Standard capability finder */
+#define PCI_FIND_NEXT_CAP_TTL(read_cfg, start, cap, args...)		\
+({									\
+	u8 __pos = (start);						\
+	int __ttl = PCI_FIND_CAP_TTL;					\
+	u16 __ent;							\
+	u8 __found_pos = 0;						\
+	u8 __id;							\
+									\
+	read_cfg(args, __pos, 1, (u32 *)&__pos);			\
+									\
+	while (__ttl--) {						\
+		if (__pos < PCI_STD_HEADER_SIZEOF)			\
+			break;						\
+		__pos = ALIGN_DOWN(__pos, 4);				\
+		read_cfg(args, __pos, 2, (u32 *)&__ent);		\
+		__id = FIELD_GET(PCI_CAP_ID_MASK, __ent);		\
+		if (__id == 0xff)					\
+			break;						\
+		if (__id == (cap)) {					\
+			__found_pos = __pos;				\
+			break;						\
+		}							\
+		__pos = FIELD_GET(PCI_CAP_LIST_NEXT_MASK, __ent);	\
+	}								\
+	__found_pos;							\
+})
+
+/* Extended capability finder */
+#define PCI_FIND_NEXT_EXT_CAPABILITY(read_cfg, start, cap, args...)	\
+({									\
+	u16 __pos = (start) ?: PCI_CFG_SPACE_SIZE;			\
+	u16 __found_pos = 0;						\
+	int __ttl, __ret;						\
+	u32 __header;							\
+									\
+	__ttl = (PCI_CFG_SPACE_EXP_SIZE - PCI_CFG_SPACE_SIZE) / 8;	\
+	while (__ttl-- > 0 && __pos >= PCI_CFG_SPACE_SIZE) {		\
+		__ret = read_cfg(args, __pos, 4, &__header);		\
+		if (__ret != PCIBIOS_SUCCESSFUL)			\
+			break;						\
+									\
+		if (__header == 0)					\
+			break;						\
+									\
+		if (PCI_EXT_CAP_ID(__header) == (cap) && __pos != start) {\
+			__found_pos = __pos;				\
+			break;						\
+		}							\
+									\
+		__pos = PCI_EXT_CAP_NEXT(__header);			\
+	}								\
+	__found_pos;							\
+})
+
  struct pcie_tlp_log;

  /* Number of possible devfns: 0.0 to 1f.7 inclusive */


Looking forward to your latest suggestions.

Best regards,
Hans


