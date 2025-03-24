Return-Path: <linux-pci+bounces-24536-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A0A0A6DD32
	for <lists+linux-pci@lfdr.de>; Mon, 24 Mar 2025 15:40:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC13E169256
	for <lists+linux-pci@lfdr.de>; Mon, 24 Mar 2025 14:40:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C12425C6FE;
	Mon, 24 Mar 2025 14:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="kWWqMBl4"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C30C325E83E;
	Mon, 24 Mar 2025 14:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742827231; cv=none; b=RyOtzitPV/A0pZc/RGOws8ar0VX3ZIUsSppMnQYUjddq4MlUy8sFtnQe9SVI8TPKZMbxCMFKbb20GaM20EcA9or93hR4VTuX6bOlvRWwRm0CY78rFoILTGv2r0dzLxC+QIs9Xpzm/x8ZTjcJbZRiQr+FLpUc+s1q6rVbpftVFco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742827231; c=relaxed/simple;
	bh=0uqHDc4NDA1PZMegFpvDGKUYSKubz/uQSIQ+hG6yk2M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ksq0cSt0ZNg2931NLFgvbnztxRXu2bD0RoaT+c0wlJEQUpaQRoj/cFllN5TQWXlcorE8TZR5GDdp12sPed/3452Kn58gSmOTatj1i0C5bJVMOfq2p/DzlOGQA+3k8Q/EuntJeVNQFizJMilhEkEb6V2lkl0DS0IGpOTE/NBOKjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=kWWqMBl4; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:From:
	Content-Type; bh=swD230yY2eiEAmVV0aOuAIgLhYzjzT72TMgpEjDgkjc=;
	b=kWWqMBl4aTBPaocX4b+4y0A8YWNSfEUNHhg4oTOg1VHocsEH0nBS/SCNgXdKP7
	dI7KgyXHsV71oUkAlmHHesjEWNCsXDr2p94NtWTSFP2TRNjqV7dXyW8Iko1acgKV
	HvTDUdda5SX/IOQPtpI0gbVfrNhW3q3JK8UjUVlEUwkdw=
Received: from [192.168.71.89] (unknown [])
	by gzga-smtp-mtada-g0-3 (Coremail) with SMTP id _____wCHzDq1buFnpug5Bg--.14531S2;
	Mon, 24 Mar 2025 22:39:50 +0800 (CST)
Message-ID: <b846123d-a161-4380-b7c7-24d7066f8d25@163.com>
Date: Mon, 24 Mar 2025 22:39:49 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [v6 1/5] PCI: Introduce generic capability search functions
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: lpieralisi@kernel.org, kw@linux.com, manivannan.sadhasivam@linaro.org,
 robh@kernel.org, bhelgaas@google.com, jingoohan1@gmail.com,
 thomas.richard@bootlin.com, linux-pci@vger.kernel.org,
 LKML <linux-kernel@vger.kernel.org>
References: <20250323164852.430546-1-18255117159@163.com>
 <20250323164852.430546-2-18255117159@163.com>
 <f89f3d00-4423-f65d-293e-8aec3be14418@linux.intel.com>
Content-Language: en-US
From: Hans Zhang <18255117159@163.com>
In-Reply-To: <f89f3d00-4423-f65d-293e-8aec3be14418@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wCHzDq1buFnpug5Bg--.14531S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxtw4UWF4rAF4xCF1fCryxGrg_yoW3uw1DpF
	WrX3WakF48JF4ayanFv3W0kFyaqa97AryUG395KwnxZrsxuasrXr9Fk345tF9rAr42qF1Y
	yFWjq3Z2krn0ya7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07U9VysUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbBDxoao2fhbpsC1wAAsK



On 2025/3/24 21:28, Ilpo Järvinen wrote:
> On Mon, 24 Mar 2025, Hans Zhang wrote:
> 
>> Existing controller drivers (e.g., DWC, custom out-of-tree drivers)
>> duplicate logic for scanning PCI capability lists. This creates
>> maintenance burdens and risks inconsistencies.
>>
>> To resolve this:
>>
>> Add pci_host_bridge_find_*capability() in pci-host-helpers.c, accepting
>> controller-specific read functions and device data as parameters.
>>
>> This approach:
>> - Centralizes critical PCI capability scanning logic
>> - Allows flexible adaptation to varied hardware access methods
>> - Reduces future maintenance overhead
>> - Aligns with kernel code reuse best practices
>>
>> Signed-off-by: Hans Zhang <18255117159@163.com>
>> ---
>> Changes since v5:
>> https://lore.kernel.org/linux-pci/20250321163803.391056-2-18255117159@163.com
>>
>> - If you put the helpers in drivers/pci/pci.c, they unnecessarily enlarge
>>    the kernel's .text section even if it's known already at compile time
>>    that they're never going to be used (e.g. on x86).
>>
>> - Move the API for find capabilitys to a new file called
>>    pci-host-helpers.c.
>>
>> Changes since v4:
>> https://lore.kernel.org/linux-pci/20250321101710.371480-2-18255117159@163.com
>>
>> - Resolved [v4 1/4] compilation warning.
>> - The patch commit message were modified.
>> ---
>>   drivers/pci/controller/Kconfig            | 17 ++++
>>   drivers/pci/controller/Makefile           |  1 +
>>   drivers/pci/controller/pci-host-helpers.c | 98 +++++++++++++++++++++++
>>   drivers/pci/pci.h                         |  7 ++
>>   4 files changed, 123 insertions(+)
>>   create mode 100644 drivers/pci/controller/pci-host-helpers.c
>>
>> diff --git a/drivers/pci/controller/Kconfig b/drivers/pci/controller/Kconfig
>> index 9800b7681054..0020a892a55b 100644
>> --- a/drivers/pci/controller/Kconfig
>> +++ b/drivers/pci/controller/Kconfig
>> @@ -132,6 +132,23 @@ config PCI_HOST_GENERIC
>>   	  Say Y here if you want to support a simple generic PCI host
>>   	  controller, such as the one emulated by kvmtool.
>>   
>> +config PCI_HOST_HELPERS
>> +	bool
>> +	prompt "PCI Host Controller Helper Functions" if EXPERT
>> + 	help
>> +	  This provides common infrastructure for PCI host controller drivers to
>> +	  handle PCI capability scanning and other shared operations. The helper
>> +	  functions eliminate code duplication across controller drivers.
>> +
>> +	  These functions are used by PCI controller drivers that need to scan
>> +	  PCI capabilities using controller-specific access methods (e.g. when
>> +	  the controller is behind a non-standard configuration space).
>> +
>> +	  If you are using any PCI host controller drivers that require these
>> +	  helpers (such as DesignWare, Cadence, etc), this will be
>> +	  automatically selected. Say N unless you are developing a custom PCI
>> +	  host controller driver.
> 
> Hi,
> 
> Does this need to be user selectable at all? What's the benefit? If
> somebody is developing a driver, they can just as well add the select
> clause in that driver to get it built.
> 

Dear Ilpo,

Thanks your for reply. Only DWC and CDNS drivers are used here, what do 
you suggest should be done?


> 
>> +
>>   config PCIE_HISI_ERR
>>   	depends on ACPI_APEI_GHES && (ARM64 || COMPILE_TEST)
>>   	bool "HiSilicon HIP PCIe controller error handling driver"
>> diff --git a/drivers/pci/controller/Makefile b/drivers/pci/controller/Makefile
>> index 038ccbd9e3ba..e80091eb7597 100644
>> --- a/drivers/pci/controller/Makefile
>> +++ b/drivers/pci/controller/Makefile
>> @@ -12,6 +12,7 @@ obj-$(CONFIG_PCIE_RCAR_HOST) += pcie-rcar.o pcie-rcar-host.o
>>   obj-$(CONFIG_PCIE_RCAR_EP) += pcie-rcar.o pcie-rcar-ep.o
>>   obj-$(CONFIG_PCI_HOST_COMMON) += pci-host-common.o
>>   obj-$(CONFIG_PCI_HOST_GENERIC) += pci-host-generic.o
>> +obj-$(CONFIG_PCI_HOST_HELPERS) += pci-host-helpers.o
>>   obj-$(CONFIG_PCI_HOST_THUNDER_ECAM) += pci-thunder-ecam.o
>>   obj-$(CONFIG_PCI_HOST_THUNDER_PEM) += pci-thunder-pem.o
>>   obj-$(CONFIG_PCIE_XILINX) += pcie-xilinx.o
>> diff --git a/drivers/pci/controller/pci-host-helpers.c b/drivers/pci/controller/pci-host-helpers.c
>> new file mode 100644
>> index 000000000000..cd261a281c60
>> --- /dev/null
>> +++ b/drivers/pci/controller/pci-host-helpers.c
>> @@ -0,0 +1,98 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * PCI Host Controller Helper Functions
>> + *
>> + * Copyright (C) 2025 Hans Zhang
>> + *
>> + * Author: Hans Zhang <18255117159@163.com>
>> + */
>> +
>> +#include <linux/pci.h>
>> +
>> +#include "../pci.h"
>> +
>> +/*
>> + * These interfaces resemble the pci_find_*capability() interfaces, but these
>> + * are for configuring host controllers, which are bridges *to* PCI devices but
>> + * are not PCI devices themselves.
>> + */
>> +static u8 __pci_host_bridge_find_next_cap(void *priv,
>> +					  pci_host_bridge_read_cfg read_cfg,
>> +					  u8 cap_ptr, u8 cap)
>> +{
>> +	u8 cap_id, next_cap_ptr;
>> +	u16 reg;
>> +
>> +	if (!cap_ptr)
>> +		return 0;
>> +
>> +	reg = read_cfg(priv, cap_ptr, 2);
>> +	cap_id = (reg & 0x00ff);
>> +
>> +	if (cap_id > PCI_CAP_ID_MAX)
>> +		return 0;
>> +
>> +	if (cap_id == cap)
>> +		return cap_ptr;
>> +
>> +	next_cap_ptr = (reg & 0xff00) >> 8;
>> +	return __pci_host_bridge_find_next_cap(priv, read_cfg, next_cap_ptr,
>> +					       cap);
> 
> This is doing (tail) recursion?? Why??
> 
> What should be done, IMO, is that code in __pci_find_next_cap_ttl()
> refactored such that it can be reused instead of duplicating it in a
> slightly different form here and the functions below.
> 
> The capability list parser should be the same?
> 

The original function is in the following file:
drivers/pci/controller/dwc/pcie-designware.c
u8 dw_pcie_find_capability(struct dw_pcie *pci, u8 cap)
u16 dw_pcie_find_ext_capability(struct dw_pcie *pci, u8 cap)

CDNS has the same need to find the offset of the capability.

We don't have pci_dev before calling pci_host_probe, but we want to get 
the offset of the capability and configure some registers to initialize 
the root port. Therefore, the __pci_find_next_cap_ttl function cannot be 
used. This is also the purpose of dw_pcie_find_*capability.


The CDNS driver does not have a cdns_pcie_find_*capability function. 
Therefore, separate the find capability, and then DWC and CDNS can be 
used at the same time to reduce duplicate code.


Communication history:

Bjorn HelgaasMarch 14, 2025, 8:31 p.m. UTC | #8
On Fri, Mar 14, 2025 at 06:35:11PM +0530, Manivannan Sadhasivam wrote:
 > ...

 > Even though this patch is mostly for an out of tree controller
 > driver which is not going to be upstreamed, the patch itself is
 > serving some purpose. I really like to avoid the hardcoded offsets
 > wherever possible. So I'm in favor of this patch.
 >
 > However, these newly introduced functions are a duplicated version
 > of DWC functions. So we will end up with duplicated functions in
 > multiple places. I'd like them to be moved (both this and DWC) to
 > drivers/pci/pci.c if possible. The generic function
 > *_find_capability() can accept the controller specific readl/ readw
 > APIs and the controller specific private data.

I agree, it would be really nice to share this code.

It looks a little messy to deal with passing around pointers to
controller read ops, and we'll still end up with a lot of duplicated
code between __pci_find_next_cap() and __cdns_pcie_find_next_cap(),
etc.

Maybe someday we'll make a generic way to access non-PCI "config"
space like this host controller space and PCIe RCRBs.

Or if you add interfaces that accept read/write ops, maybe the
existing pci_find_capability() etc could be refactored on top of them
by passing in pci_bus_read_config_word() as the accessor.


>> +}
>> +
>> +u8 pci_host_bridge_find_capability(void *priv,
>> +				   pci_host_bridge_read_cfg read_cfg, u8 cap)
>> +{
>> +	u8 next_cap_ptr;
>> +	u16 reg;
>> +
>> +	reg = read_cfg(priv, PCI_CAPABILITY_LIST, 2);
>> +	next_cap_ptr = (reg & 0x00ff);
>> +
>> +	return __pci_host_bridge_find_next_cap(priv, read_cfg, next_cap_ptr,
>> +					       cap);
>> +}
>> +EXPORT_SYMBOL_GPL(pci_host_bridge_find_capability);


Best regards,
Hans


