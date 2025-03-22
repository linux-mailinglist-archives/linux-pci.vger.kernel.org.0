Return-Path: <linux-pci+bounces-24440-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CB40A6CB46
	for <lists+linux-pci@lfdr.de>; Sat, 22 Mar 2025 16:48:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 596E13AB785
	for <lists+linux-pci@lfdr.de>; Sat, 22 Mar 2025 15:48:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C080B1F1932;
	Sat, 22 Mar 2025 15:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="oyoyh6Fs"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2547370809;
	Sat, 22 Mar 2025 15:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742658505; cv=none; b=aqVrlW+C9IM+IVSzn3bDzJf/Qr6eTP21PhBFKqE99u3sUpnbZcFlYAguxuqHuLLFU5oY6+6AafxcjHc5bRa2muZbvq/1C19YwLEJWBrfMqOHmx4dWWXD24kH2T0CXx5vcxOKBQpSerJPsgX4rtDKguFEjfR4jZa0PKtmKARR06c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742658505; c=relaxed/simple;
	bh=VBkmpeQ7g9OmfYDFzv64N3Z6kRDpYLs+wsHhcnMPoDQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GORP+g5wTaqc7DEsmHrxLEzuZUqLTGRcaKxED05yxNfaIRlrSTYN/G7jYyYBSFjlPw212lzmDtQf/ht4x8wh4RldcqfNoUpyJoMZxrd4hUKqnmifAUs5UTcnHiPaQ9Fvv5Yi2fZ+WhVVYsDU/OorIDpjkUgFVbmqmaC5QTW8EDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=oyoyh6Fs; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:From:
	Content-Type; bh=xpIbc3XOZFI1mfYHn62nlUutMFubuOBIPr/N/KynrOM=;
	b=oyoyh6Fst9UhsbXoiUQriRACoandjqLLSw3hqZF0eMk6iLeycTPr8WxMnl5/KU
	yKmHV0r9eem7k5L8o2oxPuslIhn2ssSwHsHpVq2xRmvuzd8bR/NJmYIhI3z+YdOT
	TWuztLnXU1ugjck/gkgp1WVJHv2UTrTTHHtJc37wBuBBg=
Received: from [192.168.71.89] (unknown [])
	by gzga-smtp-mtada-g1-4 (Coremail) with SMTP id _____wD3TJeG295nDAOOBA--.59311S2;
	Sat, 22 Mar 2025 23:47:19 +0800 (CST)
Message-ID: <e6e808b6-302b-4f3e-ad2d-5f9c4dce7394@163.com>
Date: Sat, 22 Mar 2025 23:47:18 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [v5 1/4] PCI: Introduce generic capability search functions
To: Lukas Wunner <lukas@wunner.de>
Cc: lpieralisi@kernel.org, kw@linux.com, manivannan.sadhasivam@linaro.org,
 robh@kernel.org, bhelgaas@google.com, jingoohan1@gmail.com,
 thomas.richard@bootlin.com, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250321163803.391056-1-18255117159@163.com>
 <20250321163803.391056-2-18255117159@163.com> <Z92cgXEGwgYD2gau@wunner.de>
Content-Language: en-US
From: Hans Zhang <18255117159@163.com>
In-Reply-To: <Z92cgXEGwgYD2gau@wunner.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_____wD3TJeG295nDAOOBA--.59311S2
X-Coremail-Antispam: 1Uf129KBjvJXoW3Xw47WFW8ZFWkZFW7Cr43Awb_yoWxtF4DpF
	ZYy34fCF18JF4avanIv3W8Ka43Xan7J3yUJ397GwnxZF17u3W7u3sFka4rtF17Ar47Xr15
	tF45t3Z5CF1DJ3JanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07U3-B_UUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/1tbiOhEYo2fe2DI2wAAAs1



On 2025/3/22 01:06, Lukas Wunner wrote:
> On Sat, Mar 22, 2025 at 12:38:00AM +0800, Hans Zhang wrote:
>> Existing controller drivers (e.g., DWC, custom out-of-tree drivers)
>> duplicate logic for scanning PCI capability lists. This creates
>> maintenance burdens and risks inconsistencies.
>>
>> To resolve this:
>>
>> Add pci_host_bridge_find_*capability() in drivers/pci/pci.c, accepting
>> controller-specific read functions and device data as parameters.
> [...]
>>   drivers/pci/pci.c   | 86 +++++++++++++++++++++++++++++++++++++++++++++
> 
> Please put this in a .c file which is only compiled and linked if
> one of the controller drivers using those new helpers is enabled
> in .config.
> 
> If you put the helpers in drivers/pci/pci.c, they unnecessarily
> enlarge the kernel's .text section even if it's known already
> at compile time that they're never going to be used (e.g. on x86).
> 

Hi Lukas,

Thanks your for reply. Increasing the size of the .text section was not 
my intention. I see what you mean.


> You could put them in drivers/pci/controller/pci-host-common.c
> and then select PCI_HOST_COMMON for each driver using them.
> Or put them in a separate completely new file.
> 


I add a drivers/pci/controller/pci-host-helpers.c file, how do you like 
it? Below, I have rearranged the patch, please kindly review it, thank 
you very much.

> 
>>   include/linux/pci.h | 16 ++++++++-
> 
> Helpers that are only used internally in the PCI core should be
> declared in drivers/pci/pci.h.  I'd assume this also applies to
> helpers used by controller drivers.
> 

Will change.

> Thanks,
> 
> Lukas

Next version patch:

  drivers/pci/controller/Kconfig            | 16 ++++
  drivers/pci/controller/Makefile           |  1 +
  drivers/pci/controller/pci-host-helpers.c | 98 +++++++++++++++++++++++
  drivers/pci/pci.h                         |  7 ++
  4 files changed, 122 insertions(+)
  create mode 100644 drivers/pci/controller/pci-host-helpers.c

diff --git a/drivers/pci/controller/Kconfig b/drivers/pci/controller/Kconfig
index 9800b7681054..662c775999a1 100644
--- a/drivers/pci/controller/Kconfig
+++ b/drivers/pci/controller/Kconfig
@@ -132,6 +132,22 @@ config PCI_HOST_GENERIC
  	  Say Y here if you want to support a simple generic PCI host
  	  controller, such as the one emulated by kvmtool.

+config PCI_HOST_HELPERS
+ 	bool "PCI Host Controller Helper Functions"
+ 	help
+	  This provides common infrastructure for PCI host controller drivers to
+	  handle PCI capability scanning and other shared operations. The helper
+	  functions eliminate code duplication across controller drivers.
+
+	  These functions are used by PCI controller drivers that need to scan
+	  PCI capabilities using controller-specific access methods (e.g. when
+	  the controller is behind a non-standard configuration space).
+
+	  If you are using any PCI host controller drivers that require these
+	  helpers (such as DesignWare, Cadence, etc), this will be
+	  automatically selected. Say N unless you are developing a custom PCI
+	  host controller driver.
+
  config PCIE_HISI_ERR
  	depends on ACPI_APEI_GHES && (ARM64 || COMPILE_TEST)
  	bool "HiSilicon HIP PCIe controller error handling driver"
diff --git a/drivers/pci/controller/Makefile 
b/drivers/pci/controller/Makefile
index 038ccbd9e3ba..e80091eb7597 100644
--- a/drivers/pci/controller/Makefile
+++ b/drivers/pci/controller/Makefile
@@ -12,6 +12,7 @@ obj-$(CONFIG_PCIE_RCAR_HOST) += pcie-rcar.o 
pcie-rcar-host.o
  obj-$(CONFIG_PCIE_RCAR_EP) += pcie-rcar.o pcie-rcar-ep.o
  obj-$(CONFIG_PCI_HOST_COMMON) += pci-host-common.o
  obj-$(CONFIG_PCI_HOST_GENERIC) += pci-host-generic.o
+obj-$(CONFIG_PCI_HOST_HELPERS) += pci-host-helpers.o
  obj-$(CONFIG_PCI_HOST_THUNDER_ECAM) += pci-thunder-ecam.o
  obj-$(CONFIG_PCI_HOST_THUNDER_PEM) += pci-thunder-pem.o
  obj-$(CONFIG_PCIE_XILINX) += pcie-xilinx.o
diff --git a/drivers/pci/controller/pci-host-helpers.c 
b/drivers/pci/controller/pci-host-helpers.c
new file mode 100644
index 000000000000..cd261a281c60
--- /dev/null
+++ b/drivers/pci/controller/pci-host-helpers.c
@@ -0,0 +1,98 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * PCI Host Controller Helper Functions
+ *
+ * Copyright (C) 2025 Hans Zhang
+ *
+ * Author: Hans Zhang <18255117159@163.com>
+ */
+
+#include <linux/pci.h>
+
+#include "../pci.h"
+
+/*
+ * These interfaces resemble the pci_find_*capability() interfaces, but 
these
+ * are for configuring host controllers, which are bridges *to* PCI 
devices but
+ * are not PCI devices themselves.
+ */
+static u8 __pci_host_bridge_find_next_cap(void *priv,
+					  pci_host_bridge_read_cfg read_cfg,
+					  u8 cap_ptr, u8 cap)
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
+	return __pci_host_bridge_find_next_cap(priv, read_cfg, next_cap_ptr,
+					       cap);
+}
+
+u8 pci_host_bridge_find_capability(void *priv,
+				   pci_host_bridge_read_cfg read_cfg, u8 cap)
+{
+	u8 next_cap_ptr;
+	u16 reg;
+
+	reg = read_cfg(priv, PCI_CAPABILITY_LIST, 2);
+	next_cap_ptr = (reg & 0x00ff);
+
+	return __pci_host_bridge_find_next_cap(priv, read_cfg, next_cap_ptr,
+					       cap);
+}
+EXPORT_SYMBOL_GPL(pci_host_bridge_find_capability);
+
+static u16 pci_host_bridge_find_next_ext_capability(
+	void *priv, pci_host_bridge_read_cfg read_cfg, u16 start, u8 cap)
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
+u16 pci_host_bridge_find_ext_capability(void *priv,
+					pci_host_bridge_read_cfg read_cfg,
+					u8 cap)
+{
+	return pci_host_bridge_find_next_ext_capability(priv, read_cfg, 0, cap);
+}
+EXPORT_SYMBOL_GPL(pci_host_bridge_find_ext_capability);
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 01e51db8d285..8d1c919cbfef 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -1034,4 +1034,11 @@ void pcim_release_region(struct pci_dev *pdev, 
int bar);
  	(PCI_CONF1_ADDRESS(bus, dev, func, reg) | \
  	 PCI_CONF1_EXT_REG(reg))

+typedef u32 (*pci_host_bridge_read_cfg)(void *priv, int where, int size);
+u8 pci_host_bridge_find_capability(void *priv,
+				   pci_host_bridge_read_cfg read_cfg, u8 cap);
+u16 pci_host_bridge_find_ext_capability(void *priv,
+					pci_host_bridge_read_cfg read_cfg,
+					u8 cap);
+
  #endif /* DRIVERS_PCI_H */


Best regards,
Hans


