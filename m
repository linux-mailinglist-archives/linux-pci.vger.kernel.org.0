Return-Path: <linux-pci+bounces-23789-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B63ABA62283
	for <lists+linux-pci@lfdr.de>; Sat, 15 Mar 2025 01:06:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9014319C16D4
	for <lists+linux-pci@lfdr.de>; Sat, 15 Mar 2025 00:06:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63931366;
	Sat, 15 Mar 2025 00:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="USRKyyiH"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5869B1362;
	Sat, 15 Mar 2025 00:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741997173; cv=none; b=kqqRJJ4emuuPu+se6tgLr6x7sxBR3wJJpR9eS4TnFIwb9r2jHqj4Q/cPD8Nmt9C7KHd9IgQyGeY2dGfw5PTe2oZqcvTY9wUtu4jBqgyO7B1+HWmlJOTRGknyWG2WRcD9T+8eHr8FS2191AtWcVTujt3vUkh6tHB6p92o5MagYu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741997173; c=relaxed/simple;
	bh=c+oJ5tUDjiRPX27O0pSaL1fRF9yu1mgP4Jz9TcxlRNk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rbIZgTNDnueVkT5B+ncb2jvAzN7tiY8o50nkMHthZ9Jv25Qeg1bkEvQqhjCZ9GpuX+egac6emK1CJqEnp+EhXMJLPxb4QzgJOK3H+/c4JygCMQHOB7+pSeruaTNQb02AK2pPpQ7S/9fIXIu0fLFSYrv9mJiepUj8fE5QVQ1zkuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=USRKyyiH; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:From:
	Content-Type; bh=wvC+85Y9b2oXoCXqZi463erf/m81eVV7oHxrRDuEYc4=;
	b=USRKyyiHTUjdN+fyKKR5kHWBUdg5vQGOAIJlMHPOH9TLN/sfStcvYXapkkgqsO
	rJ0W4UYkOjvdPjNDWr7m9XuxzesEQMW2mJvifcCPeKlxtgrLnsEcXSe5enM585G2
	8i2clj6Fa/wASBSjlsw8SYl6IUUZTpApgydfxtstknQUI=
Received: from [192.168.71.45] (unknown [])
	by gzsmtp1 (Coremail) with SMTP id PCgvCgAHBGI+xNRnpNs0BA--.32353S2;
	Sat, 15 Mar 2025 08:05:20 +0800 (CST)
Message-ID: <3cadf8d5-c4d8-4941-ae2e-8b00ceb83a8f@163.com>
Date: Sat, 15 Mar 2025 08:05:18 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [v2] PCI: cadence: Add configuration space capability search API
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Siddharth Vadapalli <s-vadapalli@ti.com>, lpieralisi@kernel.org,
 kw@linux.com, robh@kernel.org, bhelgaas@google.com, bwawrzyn@cisco.com,
 thomas.richard@bootlin.com, wojciech.jasko-EXT@continental-corporation.com,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250308133903.322216-1-18255117159@163.com>
 <20250309023839.2cakdpmsbzn6pm7g@uda0492258>
 <3e6645a8-6de9-4125-8444-fa1a4f526881@163.com>
 <20250309054835.4ydiq4xpguxtbvkf@uda0492258>
 <bf9fc865-58b9-45ed-a346-ce82899d838c@163.com>
 <20250309100243.ihrxe6vfdugzpzsn@uda0492258>
 <9eee0ab5-d870-451d-bf38-41578f487854@163.com>
 <20250314130511.hmceagpx5oq5gvrr@thinkpad>
Content-Language: en-US
From: Hans Zhang <18255117159@163.com>
In-Reply-To: <20250314130511.hmceagpx5oq5gvrr@thinkpad>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:PCgvCgAHBGI+xNRnpNs0BA--.32353S2
X-Coremail-Antispam: 1Uf129KBjvJXoW3Kw48ur18AryxKFW8CFyrCrg_yoWDWF47pF
	W8AFyxCan5JF42vr4qva1DAr13JF9IvFyxGFWkC34SvrnFkw1kKFyI9a45KFnxKrs2gF1a
	qrWDtFZ5Crn8ta7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UBKZXUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/1tbiWxQQo2fUkDA6xAABsQ



On 2025/3/14 21:05, Manivannan Sadhasivam wrote:
> On Mon, Mar 10, 2025 at 11:09:54PM +0800, Hans Zhang wrote:
>>
>>
>> On 2025/3/9 18:02, Siddharth Vadapalli wrote:
>>>> Hi Siddharth,
>>>>
>>>> Prior to this patch, I don't think hard-coded is that reasonable. Because
>>>> the SOC design of each company does not guarantee that the offset of each
>>>> capability is the same. This parameter can be configured when selecting PCIe
>>>> configuration options. The current code that just happens to hit the offset
>>>> address is the same.
>>>
>>> 1. You are modifying the driver for the Cadence PCIe Controller IP and
>>> not the one for your SoC (a.k.a the application/glue/wrapper driver).
>>> 2. The offsets are tied to the Controller IP and not to your SoC. Any
>>> differences that arise due to IP Integration into your SoC should be
>>> handled in the Glue driver (the one which you haven't upstreamed yet).
>>> 3. If the offsets in the Controller IP itself have changed, this
>>> indicates a different IP version which has nothing to do with the SoC
>>> that you are using.
>>>
>>> Please clarify whether you are facing problems with the offsets due to a
>>> difference in the IP Controller Version, or due to the way in which the IP
>>> was integrated into your SoC.
>>>
>>
>> Hi Siddharth,
>>
>> I have consulted several PCIe RTL designers in the past two days. They told
>> me that the controller IP of Synopsys or Cadence can be configured with the
>> offset address of the capability. I don't think it has anything to do with
>> SOC, it's just a feature of PCIe controller IP. In particular, the number of
>> extended capability is relatively large. When RTL is generated, one more
>> configuration may cause the offset addresses of extended capability to be
>> different. Therefore, it is unreasonable to assign all the offset addresses
>> in advance.
>>
>> Here, I want to make Cadence PCIe common driver more general. When we keep
>> developing new SoCs, the capability or extended capability offset address
>> may eventually be inconsistent.
>>
>> Thank you very much Siddharth for discussing this patch with me. I would
>> like to know what other maintainers have to say about this.
>>
> 
> Even though this patch is mostly for an out of tree controller driver which is
> not going to be upstreamed, the patch itself is serving some purpose. I really
> like to avoid the hardcoded offsets wherever possible. So I'm in favor of this
> patch.
> 
> However, these newly introduced functions are a duplicated version of DWC
> functions. So we will end up with duplicated functions in multiple places. I'd
> like them to be moved (both this and DWC) to drivers/pci/pci.c if possible. The
> generic function *_find_capability() can accept the controller specific readl/
> readw APIs and the controller specific private data.


Hi Mani,

Thanks Mani for the idea. Please check whether the following patches are 
OK. If yes, I will submit a series of patches again.

I have tested on RK3588 development board, as well as cdns platform is OK.

diff --git a/drivers/pci/controller/cadence/pcie-cadence.c 
b/drivers/pci/controller/cadence/pcie-cadence.c
index 204e045aed8c..e1ce3ad612c9 100644
--- a/drivers/pci/controller/cadence/pcie-cadence.c
+++ b/drivers/pci/controller/cadence/pcie-cadence.c
@@ -8,6 +8,31 @@

  #include "pcie-cadence.h"

+static u32 cdns_pcie_read_cfg(void *priv, int where, int size)
+{
+	struct cdns_pcie *pcie = priv;
+	u32 val;
+
+	if (size == 4)
+		val = readl(pcie->reg_base + where);
+	else if (size == 2)
+		val = readw(pcie->reg_base + where);
+	else if (size == 1)
+		val = readb(pcie->reg_base + where);
+
+	return val;
+}
+
+u8 cdns_find_cap(struct cdns_pcie *pcie, int cap)
+{
+	return pci_generic_find_capability(pcie, cdns_pcie_read_cfg, cap);
+}
+
+u16 cdns_find_ext_cap(struct cdns_pcie *pcie, int cap)
+{
+	return pci_generic_find_ext_capability(pcie, cdns_pcie_read_cfg, cap);
+}
+
  void cdns_pcie_detect_quiet_min_delay_set(struct cdns_pcie *pcie)
  {
  	u32 delay = 0x3;
diff --git a/drivers/pci/controller/cadence/pcie-cadence.h 
b/drivers/pci/controller/cadence/pcie-cadence.h
index f5eeff834ec1..e90464c4a660 100644
--- a/drivers/pci/controller/cadence/pcie-cadence.h
+++ b/drivers/pci/controller/cadence/pcie-cadence.h
@@ -557,6 +557,9 @@ static inline int cdns_pcie_ep_setup(struct 
cdns_pcie_ep *ep)
  }
  #endif

+u8 cdns_find_cap(struct cdns_pcie *pcie, int cap);
+u16 cdns_find_ext_cap(struct cdns_pcie *pcie, int cap);
+
  void cdns_pcie_detect_quiet_min_delay_set(struct cdns_pcie *pcie);

  void cdns_pcie_set_outbound_region(struct cdns_pcie *pcie, u8 busnr, 
u8 fn,
diff --git a/drivers/pci/controller/dwc/pcie-designware.c 
b/drivers/pci/controller/dwc/pcie-designware.c
index 145e7f579072..4b645ad58b35 100644
--- a/drivers/pci/controller/dwc/pcie-designware.c
+++ b/drivers/pci/controller/dwc/pcie-designware.c
@@ -283,6 +283,22 @@ u16 dw_pcie_find_ext_capability(struct dw_pcie 
*pci, u8 cap)
  }
  EXPORT_SYMBOL_GPL(dw_pcie_find_ext_capability);

+static u32 dwc_pcie_read_cfg(void *priv, int where, int size)
+{
+	struct dw_pcie *pcie = priv;
+	return dw_pcie_read_dbi(pcie, where, size);
+}
+
+u8 dwc_find_cap(struct dw_pcie *pcie, int cap)
+{
+	return pci_generic_find_capability(pcie, dwc_pcie_read_cfg, cap);
+}
+
+u16 dwc_find_ext_cap(struct dw_pcie *pcie, int cap)
+{
+	return pci_generic_find_ext_capability(pcie, dwc_pcie_read_cfg, cap);
+}
+
  int dw_pcie_read(void __iomem *addr, int size, u32 *val)
  {
  	if (!IS_ALIGNED((uintptr_t)addr, size)) {
diff --git a/drivers/pci/controller/dwc/pcie-designware.h 
b/drivers/pci/controller/dwc/pcie-designware.h
index 501d9ddfea16..260c6672a4f5 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -479,6 +479,9 @@ void dw_pcie_version_detect(struct dw_pcie *pci);
  u8 dw_pcie_find_capability(struct dw_pcie *pci, u8 cap);
  u16 dw_pcie_find_ext_capability(struct dw_pcie *pci, u8 cap);

+u8 dwc_find_cap(struct dw_pcie *pcie, int cap);
+u16 dwc_find_ext_cap(struct dw_pcie *pcie, int cap);
+
  int dw_pcie_read(void __iomem *addr, int size, u32 *val);
  int dw_pcie_write(void __iomem *addr, int size, u32 val);

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 869d204a70a3..4376bee65cc6 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -612,6 +612,84 @@ u16 pci_find_ext_capability(struct pci_dev *dev, 
int cap)
  }
  EXPORT_SYMBOL_GPL(pci_find_ext_capability);

+static u8 __pci_generic_find_next_cap(void *priv, pci_generic_read_cfg 
read_cfg,
+				      u8 cap_ptr, int cap)
+{
+	u8 cap_id, next_cap_ptr;
+	u16 reg;
+
+	if (!cap_ptr)
+		return 0;
+
+	reg = read_cfg(priv, cap_ptr, 2);
+	cap_id = (reg & 0x00ff);
+
+	if (cap_id > PCI_CAP_ID_MAX)
+		return 0;
+
+	if (cap_id == cap)
+		return cap_ptr;
+
+	next_cap_ptr = (reg & 0xff00) >> 8;
+	return __pci_generic_find_next_cap(priv, read_cfg, next_cap_ptr, cap);
+}
+
+u8 pci_generic_find_capability(void *priv, pci_generic_read_cfg read_cfg,
+			       int cap)
+{
+	u8 next_cap_ptr;
+	u16 reg;
+
+	reg = read_cfg(priv, PCI_CAPABILITY_LIST, 2);
+	next_cap_ptr = (reg & 0x00ff);
+
+	return __pci_generic_find_next_cap(priv, read_cfg, next_cap_ptr, cap);
+}
+EXPORT_SYMBOL_GPL(pci_generic_find_capability);
+
+static u16 pci_generic_find_next_ext_capability(void *priv,
+						pci_generic_read_cfg read_cfg,
+						u16 start, u8 cap)
+{
+	u32 header;
+	int ttl;
+	int pos = PCI_CFG_SPACE_SIZE;
+
+	/* minimum 8 bytes per capability */
+	ttl = (PCI_CFG_SPACE_EXP_SIZE - PCI_CFG_SPACE_SIZE) / 8;
+
+	if (start)
+		pos = start;
+
+	header = read_cfg(priv, pos, 4);
+	/*
+	 * If we have no capabilities, this is indicated by cap ID,
+	 * cap version and next pointer all being 0.
+	 */
+	if (header == 0)
+		return 0;
+
+	while (ttl-- > 0) {
+		if (PCI_EXT_CAP_ID(header) == cap && pos != start)
+			return pos;
+
+		pos = PCI_EXT_CAP_NEXT(header);
+		if (pos < PCI_CFG_SPACE_SIZE)
+			break;
+
+		header = read_cfg(priv, pos, 4);
+	}
+
+	return 0;
+}
+
+u16 pci_generic_find_ext_capability(void *priv, pci_generic_read_cfg 
read_cfg,
+				    int cap)
+{
+	return pci_generic_find_next_ext_capability(priv, read_cfg, 0, cap);
+}
+EXPORT_SYMBOL_GPL(pci_generic_find_ext_capability);
+
  /**
   * pci_get_dsn - Read and return the 8-byte Device Serial Number
   * @dev: PCI device to query
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 47b31ad724fa..63744f3de3a4 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1205,6 +1205,11 @@ u8 pci_find_ht_capability(struct pci_dev *dev, 
int ht_cap);
  u8 pci_find_next_ht_capability(struct pci_dev *dev, u8 pos, int ht_cap);
  u16 pci_find_ext_capability(struct pci_dev *dev, int cap);
  u16 pci_find_next_ext_capability(struct pci_dev *dev, u16 pos, int cap);
+typedef u32 (*pci_generic_read_cfg)(void *priv, int where, int size);
+u8 pci_generic_find_capability(void *priv, pci_generic_read_cfg read_cfg,
+			       int cap);
+u16 pci_generic_find_ext_capability(void *priv, pci_generic_read_cfg 
read_cfg,
+				    int cap);
  struct pci_bus *pci_find_next_bus(const struct pci_bus *from);
  u16 pci_find_vsec_capability(struct pci_dev *dev, u16 vendor, int cap);
  u16 pci_find_dvsec_capability(struct pci_dev *dev, u16 vendor, u16 dvsec);
@@ -2012,7 +2017,13 @@ static inline u8 pci_find_next_capability(struct 
pci_dev *dev, u8 post, int cap)
  { return 0; }
  static inline u16 pci_find_ext_capability(struct pci_dev *dev, int cap)
  { return 0; }
-
+typedef u32 (*pci_generic_read_cfg)(void *priv, int where, int size);
+u8 pci_generic_find_capability(void *priv, pci_generic_read_cfg read_cfg,
+			       int cap)
+{ return 0; }
+u16 pci_generic_find_ext_capability(void *priv, pci_generic_read_cfg 
read_cfg,
+				    int cap)
+{ return 0; }
  static inline u64 pci_get_dsn(struct pci_dev *dev)
  { return 0; }


Best regards,
Hans



