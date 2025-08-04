Return-Path: <linux-pci+bounces-33340-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 794C9B19A62
	for <lists+linux-pci@lfdr.de>; Mon,  4 Aug 2025 05:07:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 89A76176AA9
	for <lists+linux-pci@lfdr.de>; Mon,  4 Aug 2025 03:07:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD033218EB1;
	Mon,  4 Aug 2025 03:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="NLaKte2x"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 159121C5489;
	Mon,  4 Aug 2025 03:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754276830; cv=none; b=WsP8VDcrgIdCVmAwY9FpofjOIEqpbPBb/+8lL4XB0D+i3lIcE7za4eE+8zTWDJA2ZsA9DU72j2xtvdgcliF5AL8O8m/NamuCRFNmUnOMhTmXX+4GEhwnXZWigE1dqhpX9G+UVZPfOI8Y5xNiSFI1UQe3/IUZOzwpsu2idJkZIWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754276830; c=relaxed/simple;
	bh=TwJoaDQgjVcBZ/Ds/fVDfTurh1evbR9XWagpeyFztPY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oqzE4Msf8JO9Oa1rpPemMecjQIruNEWwit7Zw7zdqLEvT+tSlK1rcJ7hRTj/9S9Q93WE4pauOhnxaDLcXSnzUrpphanjPw7Dlk0lsH3Xzy9ATv548ZLAp9rw4cYYj3YYWHcm80uzfuCe2gsAo/a7zd+eRMpm98Qx7QNdKWd1CJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=NLaKte2x; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=WSRh6+t5rUrNqeI8tjL+kgapeu0a9X7Koe+QVVPQggw=;
	b=NLaKte2xzIJfCoUol1muGvNPINJvPlmYrHdxHas/1L0GffTUoiolr+YuAATbTe
	Lb3g+e/Zuq1zOz7OTYhjdeXQ0sJobj8hWeTC3l4TXXNNzOUIEZ7RRk1e2DvyxGDA
	+m/WtQnVPPGSlK8y25HWhpSZpNlbfqcBirb9SVQjdLOY0=
Received: from [192.168.106.52] (unknown [])
	by gzga-smtp-mtada-g1-4 (Coremail) with SMTP id _____wD3fyq7I5BokTAbJw--.39897S2;
	Mon, 04 Aug 2025 11:06:38 +0800 (CST)
Message-ID: <06012cc6-824d-4a7d-85c9-9995ec915382@163.com>
Date: Mon, 4 Aug 2025 11:06:36 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI: Fix endianness issues in pci_bus_read_config()
To: Gerd Bayer <gbayer@linux.ibm.com>, Manivannan Sadhasivam
 <mani@kernel.org>, Hans Zhang <hans.zhang@cixtech.com>
Cc: Arnd Bergmann <arnd@kernel.org>, Bjorn Helgaas <helgaas@kernel.org>,
 bhelgaas@google.com, Alexander Gordeev <agordeev@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 jingoohan1@gmail.com, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?=
 <kwilczynski@kernel.org>, linux-kernel@vger.kernel.org,
 linux-s390@vger.kernel.org, linux-next <linux-next@vger.kernel.org>,
 linux-pci@vger.kernel.org, Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Rob Herring <robh@kernel.org>, Niklas Schnelle <schnelle@linux.ibm.com>,
 geert@linux-m68k.org
References: <20250731183944.GA3424583@bhelgaas>
 <6e34b4af-dff9-4360-b3da-c95ca7c740c9@app.fastmail.com>
 <vf65usnffqzlkgijm72nuaslxnflwrugc25vw6q6blbn2s2d2s@b35vjkowd6yc>
 <9a155e45-f723-4eec-81d3-2547bfe9a4e9@cixtech.com>
 <ofsbfhor5ah3yzvkc5g5kb4fpjlzoqkkzukctmr3f6ur4vl2e7@7zvudt63ucbk>
 <c8ffdd21-9000-40c2-9f4d-4d6318e730b5@cixtech.com>
 <cu7qdbwmnixqjce4aetr5ldwe3sqoixgq4fuzmzajzphjdywqq@yw6ojbgeqktm>
 <06f16b1a55eede3dc3e0bf31ff14eca89ab6f009.camel@linux.ibm.com>
Content-Language: en-US
From: Hans Zhang <18255117159@163.com>
In-Reply-To: <06f16b1a55eede3dc3e0bf31ff14eca89ab6f009.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_____wD3fyq7I5BokTAbJw--.39897S2
X-Coremail-Antispam: 1Uf129KBjvJXoW3tFWkWrWUJry8ZFyktF18Krg_yoWDAF1xpF
	W5JFWIyF48tF1avF1vva4DXw1YyF9IyFZrWa97Ca4IvFnakryUJFyYgFWagr1agw48Wr1a
	vws8tFZrAws8AF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UNXocUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/1tbiOhGfo2iQIIRxnAAAsm



On 2025/8/1 19:30, Gerd Bayer wrote:
> On Fri, 2025-08-01 at 16:24 +0530, Manivannan Sadhasivam wrote:
> 
> <--- snip --->
> 
>>>>>>> The pci_bus_read_config() interface itself may have been a
>>>>>>> mistake, can't the callers just use the underlying helpers
>>>>>>> directly?
>>>>>>>
>>>>>>
>>>>>> They can! Since the callers of this API is mostly the macros, we can easily
>>>>>> implement the logic to call relevant accessors based on the requested size.
>>>>>>
>>>>>> Hans, could you please respin the series based the feedback since the series is
>>>>>> dropped for 6.17.
>>>>>>
>>>>>
>>>>> Dear all,
>>>>>
>>>>> I am once again deeply sorry for the problems that occurred in this series.
>>>>> I only test pulling the ARM platform.
>>>>>
>>>>> Thank you very much, Gerd, for reporting the problem.
> 
> no worries!
> 
>>>>> Thank you all for your discussions and suggestions for revision.
>>>>>
>>>>> Hi Mani,
>>>>>
>>>>> Geert provided a solution. My patch based on this is as follows. Please
>>>>> check if there are any problems.
>>>>> https://lore.kernel.org/linux-pci/CAMuHMdVwFeV46oCid_sMHjXfP+yyGTpBfs9t3uaa=wRxNcSOAQ@mail.gmail.com/
>>>>>
>>>>> Also, please ask Gerd to help test whether it works properly. Thank you very
>>>>> much.
>>>>>
> 
> I found Geert's proposal intriguing for a quick resolution of the
> issue. Yet, I have not tried that proposal, though.
> 
> Instead I spent some more cycles on Lukas' and Mani's question about
> the value of the pci_bus_read_config() helper. So I changed
> PCI_FIND_NEXT_CAP and PCI_FIND_NEXT_EXT_CAP to use size-aware versions
> of read_cfg accessor functions like this:
> 
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index ac954584d991..9e2f75ede95f 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -109,17 +109,17 @@ int pci_bus_read_config(void *priv, unsigned int
> devfn, int where, u32 size,
>   ({
> \
>          int __ttl = PCI_FIND_CAP_TTL;
> \
>          u8 __id, __found_pos = 0;
> \
> -       u32 __pos = (start);
> \
> -       u32 __ent;
> \
> +       u8 __pos = (start);
> \
> +       u16 __ent;
> \
>                                                                        
> \
> -       read_cfg(args, __pos, 1, &__pos);
> \
> +       read_cfg##_byte(args, __pos, &__pos);
> \
>                                                                        
> \
>          while (__ttl--) {
> \
>                  if (__pos < PCI_STD_HEADER_SIZEOF)
> \
>                          break;
> \
>                                                                        
> \
>                  __pos = ALIGN_DOWN(__pos, 4);
> \
> -               read_cfg(args, __pos, 2, &__ent);
> \
> +               read_cfg##_word(args, __pos, &__ent);
> \
>                                                                        
> \
>                  __id = FIELD_GET(PCI_CAP_ID_MASK, __ent);
> \
>                  if (__id == 0xff)
> \
> @@ -158,7 +158,7 @@ int pci_bus_read_config(void *priv, unsigned int
> devfn, int where, u32 size,
>                                                                        
> \
>          __ttl = (PCI_CFG_SPACE_EXP_SIZE - PCI_CFG_SPACE_SIZE) / 8;
> \
>          while (__ttl-- > 0 && __pos >= PCI_CFG_SPACE_SIZE) {
> \
> -               __ret = read_cfg(args, __pos, 4, &__header);
> \
> +               __ret = read_cfg##_dword(args, __pos, &__header);
> \
>                  if (__ret != PCIBIOS_SUCCESSFUL)
> \
>                          break;
> \
>                                                                        
> \
> 
> 
> This fixes the issue for s390's use-cases. With that
> pci_bus_read_config() becomes unused - and could be removed in further
> refinements.
>                                                                        
> However, this probably breaks your dwc and cdns use-cases. I think,
> with the accessor functions for dwc and cadence changed to follow the
> {_byte|_word|_dword} naming pattern they could be used straight out of
> PCI_FIND_NEXT_{EXT_}CAP, too. Then, dw_pcie_read_cfg() and
> cdns_pcie_read_cfg become obsolete as well.
> 
> Thoughts?

Dear all,

According to the issue mentioned by Lukas and Mani. Gerd has already 
been tested on the s390. I have tested it on the RK3588 and it works 
fine. RK3588 uses Synopsys' PCIe IP, that is, the DWC driver. Our 
company's is based on Cadence's PCIe 4.0 IP, and the test function is 
normal. All the platforms I tested were based on ARM.

The following is the patch based on the capability-search branch. May I 
ask everyone, do you have any more questions?

Gerd, if there's no problem, I'll add your Tested-by label.

Branch: 
ttps://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git/log/?h=capability-search


Patch:
diff --git a/drivers/pci/access.c b/drivers/pci/access.c
index ba66f55d2524..b123da16b63b 100644
--- a/drivers/pci/access.c
+++ b/drivers/pci/access.c
@@ -85,21 +85,6 @@ EXPORT_SYMBOL(pci_bus_write_config_byte);
  EXPORT_SYMBOL(pci_bus_write_config_word);
  EXPORT_SYMBOL(pci_bus_write_config_dword);

-int pci_bus_read_config(void *priv, unsigned int devfn, int where, u32 
size,
-			u32 *val)
-{
-	struct pci_bus *bus = priv;
-
-	if (size == 1)
-		return pci_bus_read_config_byte(bus, devfn, where, (u8 *)val);
-	else if (size == 2)
-		return pci_bus_read_config_word(bus, devfn, where, (u16 *)val);
-	else if (size == 4)
-		return pci_bus_read_config_dword(bus, devfn, where, val);
-	else
-		return PCIBIOS_BAD_REGISTER_NUMBER;
-}
-
  int pci_generic_config_read(struct pci_bus *bus, unsigned int devfn,
  			    int where, int size, u32 *val)
  {
diff --git a/drivers/pci/controller/cadence/pcie-cadence.c 
b/drivers/pci/controller/cadence/pcie-cadence.c
index 7b2955e4fafb..c45585ae1746 100644
--- a/drivers/pci/controller/cadence/pcie-cadence.c
+++ b/drivers/pci/controller/cadence/pcie-cadence.c
@@ -10,22 +10,6 @@
  #include "pcie-cadence.h"
  #include "../../pci.h"

-static int cdns_pcie_read_cfg(void *priv, int where, int size, u32 *val)
-{
-	struct cdns_pcie *pcie = priv;
-
-	if (size == 4)
-		*val = cdns_pcie_readl(pcie, where);
-	else if (size == 2)
-		*val = cdns_pcie_readw(pcie, where);
-	else if (size == 1)
-		*val = cdns_pcie_readb(pcie, where);
-	else
-		return PCIBIOS_BAD_REGISTER_NUMBER;
-
-	return PCIBIOS_SUCCESSFUL;
-}
-
  u8 cdns_pcie_find_capability(struct cdns_pcie *pcie, u8 cap)
  {
  	return PCI_FIND_NEXT_CAP(cdns_pcie_read_cfg, PCI_CAPABILITY_LIST,
diff --git a/drivers/pci/controller/cadence/pcie-cadence.h 
b/drivers/pci/controller/cadence/pcie-cadence.h
index f0fdeb3863f1..4ad874e68783 100644
--- a/drivers/pci/controller/cadence/pcie-cadence.h
+++ b/drivers/pci/controller/cadence/pcie-cadence.h
@@ -392,6 +392,26 @@ static inline u8 cdns_pcie_readb(struct cdns_pcie 
*pcie, u32 reg)
  	return readb(pcie->reg_base + reg);
  }

+#define CDNS_PCI_OP_READ(size, type, len)		\
+static inline int cdns_pcie_read_cfg_##size		\
+	(struct cdns_pcie *pcie, int where, type *val)	\
+{							\
+	if (len == 4)					\
+		*val = cdns_pcie_readl(pcie, where);	\
+	else if (len == 2)				\
+		*val = cdns_pcie_readw(pcie, where);	\
+	else if (len == 1)				\
+		*val = cdns_pcie_readb(pcie, where);	\
+	else						\
+		return PCIBIOS_BAD_REGISTER_NUMBER;	\
+							\
+	return PCIBIOS_SUCCESSFUL;			\
+}
+
+CDNS_PCI_OP_READ(byte, u8, 1)
+CDNS_PCI_OP_READ(word, u16, 2)
+CDNS_PCI_OP_READ(dword, u32, 4)
+
  static inline u32 cdns_pcie_read_sz(void __iomem *addr, int size)
  {
  	void __iomem *aligned_addr = PTR_ALIGN_DOWN(addr, 0x4);
diff --git a/drivers/pci/controller/dwc/pcie-designware.c 
b/drivers/pci/controller/dwc/pcie-designware.c
index b503cb4bcb28..befb9df3123f 100644
--- a/drivers/pci/controller/dwc/pcie-designware.c
+++ b/drivers/pci/controller/dwc/pcie-designware.c
@@ -213,22 +213,6 @@ void dw_pcie_version_detect(struct dw_pcie *pci)
  		pci->type = ver;
  }

-static int dw_pcie_read_cfg(void *priv, int where, int size, u32 *val)
-{
-	struct dw_pcie *pci = priv;
-
-	if (size == 4)
-		*val = dw_pcie_readl_dbi(pci, where);
-	else if (size == 2)
-		*val = dw_pcie_readw_dbi(pci, where);
-	else if (size == 1)
-		*val = dw_pcie_readb_dbi(pci, where);
-	else
-		return PCIBIOS_BAD_REGISTER_NUMBER;
-
-	return PCIBIOS_SUCCESSFUL;
-}
-
  u8 dw_pcie_find_capability(struct dw_pcie *pci, u8 cap)
  {
  	return PCI_FIND_NEXT_CAP(dw_pcie_read_cfg, PCI_CAPABILITY_LIST, cap,
diff --git a/drivers/pci/controller/dwc/pcie-designware.h 
b/drivers/pci/controller/dwc/pcie-designware.h
index ce9e18554e42..3b429a8ade70 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -614,6 +614,26 @@ static inline void dw_pcie_writel_dbi2(struct 
dw_pcie *pci, u32 reg, u32 val)
  	dw_pcie_write_dbi2(pci, reg, 0x4, val);
  }

+#define DW_PCI_OP_READ(size, type, len)			\
+static inline int dw_pcie_read_cfg_##size		\
+	(struct dw_pcie *pci, int where, type *val)	\
+{							\
+	if (len == 4)					\
+		*val = dw_pcie_readl_dbi(pci, where);	\
+	else if (len == 2)				\
+		*val = dw_pcie_readw_dbi(pci, where);	\
+	else if (len == 1)				\
+		*val = dw_pcie_readb_dbi(pci, where);	\
+	else						\
+		return PCIBIOS_BAD_REGISTER_NUMBER;	\
+							\
+	return PCIBIOS_SUCCESSFUL;			\
+}
+
+DW_PCI_OP_READ(byte, u8, 1)
+DW_PCI_OP_READ(word, u16, 2)
+DW_PCI_OP_READ(dword, u32, 4)
+
  static inline unsigned int dw_pcie_ep_get_dbi_offset(struct dw_pcie_ep 
*ep,
  						     u8 func_no)
  {
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index e53706d1d806..9c410e47e19a 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -92,8 +92,6 @@ extern bool pci_early_dump;
  bool pcie_cap_has_lnkctl(const struct pci_dev *dev);
  bool pcie_cap_has_lnkctl2(const struct pci_dev *dev);
  bool pcie_cap_has_rtctl(const struct pci_dev *dev);
-int pci_bus_read_config(void *priv, unsigned int devfn, int where, u32 
size,
-			u32 *val);

  /* Standard Capability finder */
  /**
@@ -112,17 +110,17 @@ int pci_bus_read_config(void *priv, unsigned int 
devfn, int where, u32 size,
  ({									\
  	int __ttl = PCI_FIND_CAP_TTL;					\
  	u8 __id, __found_pos = 0;					\
-	u32 __pos = (start);						\
-	u32 __ent;							\
+	u8 __pos = (start);						\
+	u16 __ent;							\
  									\
-	read_cfg(args, __pos, 1, &__pos);				\
+	read_cfg##_byte(args, __pos, &__pos);				\
  									\
  	while (__ttl--) {						\
  		if (__pos < PCI_STD_HEADER_SIZEOF)			\
  			break;						\
  									\
  		__pos = ALIGN_DOWN(__pos, 4);				\
-		read_cfg(args, __pos, 2, &__ent);			\
+		read_cfg##_word(args, __pos, &__ent);			\
  									\
  		__id = FIELD_GET(PCI_CAP_ID_MASK, __ent);		\
  		if (__id == 0xff)					\
@@ -161,7 +159,7 @@ int pci_bus_read_config(void *priv, unsigned int 
devfn, int where, u32 size,
  									\
  	__ttl = (PCI_CFG_SPACE_EXP_SIZE - PCI_CFG_SPACE_SIZE) / 8;	\
  	while (__ttl-- > 0 && __pos >= PCI_CFG_SPACE_SIZE) {		\
-		__ret = read_cfg(args, __pos, 4, &__header);		\
+		__ret = read_cfg##_dword(args, __pos, &__header);	\
  		if (__ret != PCIBIOS_SUCCESSFUL)			\
  			break;						\
  									\



Best regards,
Hans



