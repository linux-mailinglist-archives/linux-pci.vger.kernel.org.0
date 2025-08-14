Return-Path: <linux-pci+bounces-34083-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C817CB2718F
	for <lists+linux-pci@lfdr.de>; Fri, 15 Aug 2025 00:21:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 14B7B1CC38AF
	for <lists+linux-pci@lfdr.de>; Thu, 14 Aug 2025 22:22:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57D3127381B;
	Thu, 14 Aug 2025 22:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="On9Pfg2q"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDB6114A60F;
	Thu, 14 Aug 2025 22:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755210102; cv=none; b=K1lC7lyRhFZ34Esznu67PVBNiBc8bt1/CfBeXOFlAyJC7mdwmiglDhJPaod6Zmy1b2B2OBciy/VIjI7XWM/EI1xMPy8dvQu6zmOAMKDqB9NgfsImo5rB07rDwAyWM3HZk1JYD8lfFKFjfaGND2UAiN0ge0WH4Ze1vsO6SIdlGRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755210102; c=relaxed/simple;
	bh=ZHbgtAxDrT8yiWntXVHOdrATETxv8diX+RrUMvY9zic=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PJGwZOoqk7nRYdRNpwj9GMeN1McywkZ7dHIMjoK2qn0kzZldEw5QFMK0E60op23k+9vlS59uadc/CVs3jHdYVG7MI+On+SAM+ybUPQi3dC+qozp0oHGGzsmkVKB8A/+UDJHGvPE1BTkvITrzQTsyR8EDCetW00Bsc2uaDfextHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=On9Pfg2q; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=SlSXTvhn5j+7DO9bnsI1bBpWzqHBE4925y1YaoeDees=;
	b=On9Pfg2qCGopBJfDmNm+VpPqdP3s3hfV6cjAl3bfOtsHGinY88qNDLnEWAyCWh
	QFtwx0gh9ciFzFKDg22kiCyljz2WVCz96ckAcbU8RxCn3aet1Krlub772lK4AXC/
	U8+aQKbFZlL6VPPmeug1olj0U94l3kkRsqT5Io+Zbik5o=
Received: from [IPV6:240e:b8f:919b:3100:3980:6173:5059:2d2a] (unknown [])
	by gzga-smtp-mtada-g0-1 (Coremail) with SMTP id _____wDnd4BYYZ5oTc4qCA--.57335S2;
	Fri, 15 Aug 2025 06:21:13 +0800 (CST)
Message-ID: <ea1e512f-55fb-4e20-a13c-1c5ebb0d14e1@163.com>
Date: Fri, 15 Aug 2025 06:21:11 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v15 0/6] Refactor capability search into common macros
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: lpieralisi@kernel.org, kwilczynski@kernel.org, bhelgaas@google.com,
 jingoohan1@gmail.com, mani@kernel.org, robh@kernel.org,
 ilpo.jarvinen@linux.intel.com, schnelle@linux.ibm.com, gbayer@linux.ibm.com,
 lukas@wunner.de, arnd@kernel.org, geert@linux-m68k.org,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250814202519.GA344690@bhelgaas>
Content-Language: en-US
From: Hans Zhang <18255117159@163.com>
In-Reply-To: <20250814202519.GA344690@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_____wDnd4BYYZ5oTc4qCA--.57335S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxKF47Jw4fXw17Ww4rXr1UZFb_yoWxJryfpF
	9xC3ZIyrsxJrsFkan7t3WI9Fy3Aa92yry7J3y5K3sxXF17uFy8Jr4xta1ruF9rGrWxWw1I
	vF4UX34kuFn8Aa7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07U5nYwUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/1tbiWwGpo2ieVKT09QAAsX



On 2025/8/15 04:25, Bjorn Helgaas wrote:
> On Wed, Aug 13, 2025 at 10:45:23PM +0800, Hans Zhang wrote:
>> Dear Maintainers,
>>
>> This patch series addresses long-standing code duplication in PCI
>> capability discovery logic across the PCI core and controller drivers.
>> The existing implementation ties capability search to fully initialized
>> PCI device structures, limiting its usability during early controller
>> initialization phases where device/bus structures may not yet be
>> available.
>>
>> The primary goal is to decouple capability discovery from PCI device
>> dependencies by introducing a unified framework using config space
>> accessor-based macros. This enables:
>>
>> 1. Early Capability Discovery: Host controllers (e.g., Cadence, DWC)
>> can now perform capability searches during pre-initialization stages
>> using their native config accessors.
>>
>> 2. Code Consolidation: Common logic for standard and extended capability
>> searches is refactored into shared macros (`PCI_FIND_NEXT_CAP` and
>> `PCI_FIND_NEXT_EXT_CAP`), eliminating redundant implementations.
>>
>> 3. Safety and Maintainability: TTL checks are centralized within the
>> macros to prevent infinite loops, while hardcoded offsets in drivers
>> are replaced with dynamic discovery, reducing fragility.
>>
>> Key improvements include:
>> - Driver Conversions: DesignWare and Cadence drivers are migrated to
>>    use the new macros, removing device-specific assumptions and ensuring
>>    consistent error handling.
>>
>> - Enhanced Readability: Magic numbers are replaced with symbolic
>>    constants, and config space accessors are standardized for clarity.
>>
>> - Backward Compatibility: Existing PCI core behavior remains unchanged.
>>
>> ---
>> Dear Niklas and Gerd,
>>
>> Can you test this series of patches on the s390?
>>
>> Thank you very much.
>> ---
>>
>> ---
>> Changes since v14:
>> - Delete the first patch in the v14 series.
>> - The functions that can obtain the values of the registers u8/u16/u32 are
>>    directly called in PCI_FIND_NEXT_CAP() and PCI_FIND_NEXT_EXT_CAP().
>>    Use the pci_bus_read_config_byte/word/dword function directly.
>> - Delete dw_pcie_read_cfg and redefine three functions: dw_pcie_read_cfg_byte/word/dword.
>> - Delete cdns_pcie_read_cfg and redefine three functions: cdns_pcie_read_cfg_byte/word/dword.
>>
>> Changes since v13:
>> - Split patch 3/6 into two patches for searching standard and extended capability. (Bjorn)
>> - Optimize the code based on the review comments from Bjorn.
>> - Patch 5/7 and 6/7 use simplified macro definitions: PCI_FIND_NEXT_CAP(), PCI_FIND_NEXT_EXT_CAP().
>> - The other patches have not been modified.
>>
>> Changes since v12:
>> - Modify some commit messages, code format issues, and optimize the function return values.
>>
>> Changes since v11:
>> - Resolved some compilation warning.
>> - Add some include.
>> - Add the *** BLURB HERE *** description(Corrected by Mani and Krzysztof).
>>
>> Changes since v10:
>> - The patch [v10 2/6] remove #include <uapi/linux/pci_regs.h> and add macro definition comments.
>> - The patch [v10 3/6] remove #include <uapi/linux/pci_regs.h> and commit message were modified.
>> - The other patches have not been modified.
>>
>> Changes since v9:
>> - Resolved [v9 4/6] compilation error.
>>    The latest 6.15 rc1 merge __dw_pcie_find_vsec_capability, which uses
>>    dw_pcie_find_next_ext_capability.
>> - The other patches have not been modified.
>>
>> Changes since v8:
>> - Split patch.
>> - The patch commit message were modified.
>> - Other patches(4/6, 5/6, 6/6) are unchanged.
>>
>> Changes since v7:
>> - Patch 2/5 and 3/5 compilation error resolved.
>> - Other patches are unchanged.
>>
>> Changes since v6:
>> - Refactor capability search into common macros.
>> - Delete pci-host-helpers.c and MAINTAINERS.
>>
>> Changes since v5:
>> - If you put the helpers in drivers/pci/pci.c, they unnecessarily enlarge
>>    the kernel's .text section even if it's known already at compile time
>>    that they're never going to be used (e.g. on x86).
>> - Move the API for find capabilitys to a new file called
>>    pci-host-helpers.c.
>> - Add new patch for MAINTAINERS.
>>
>> Changes since v4:
>> - Resolved [v4 1/4] compilation warning.
>> - The patch subject and commit message were modified.
>>
>> Changes since v3:
>> - Resolved [v3 1/4] compilation error.
>> - Other patches are not modified.
>>
>> Changes since v2:
>> - Add and split into a series of patches.
>> ---
>>
>> Hans Zhang (6):
>>    PCI: Clean up __pci_find_next_cap_ttl() readability
>>    PCI: Refactor capability search into PCI_FIND_NEXT_CAP()
>>    PCI: Refactor extended capability search into PCI_FIND_NEXT_EXT_CAP()
>>    PCI: dwc: Use PCI core APIs to find capabilities
>>    PCI: cadence: Use PCI core APIs to find capabilities
>>    PCI: cadence: Use cdns_pcie_find_*capability() to avoid hardcoding
>>      offsets
>>
>>   .../pci/controller/cadence/pcie-cadence-ep.c  | 38 +++++----
>>   drivers/pci/controller/cadence/pcie-cadence.c | 14 +++
>>   drivers/pci/controller/cadence/pcie-cadence.h | 39 +++++++--
>>   drivers/pci/controller/dwc/pcie-designware.c  | 77 ++---------------
>>   drivers/pci/controller/dwc/pcie-designware.h  | 21 +++++
>>   drivers/pci/pci.c                             | 76 +++--------------
>>   drivers/pci/pci.h                             | 85 +++++++++++++++++++
>>   include/uapi/linux/pci_regs.h                 |  3 +
>>   8 files changed, 194 insertions(+), 159 deletions(-)
> 
> I applied this on pci/capability-search for v6.18, thanks!
> 
> Niklas, I added your Tested-by, omitting the dwc and cadence patches
> because I think you tested s390 and probably didn't exercise dwc or
> cadence.  Thanks very much to you and Gerd for finding the issue and
> testing the resolution!

Dear Bjorn,

I have tested it on our company's own EVB board and it works normally. 
(Cadence PCIe 4.0 IP)

And it was tested on the RK3588 and worked normally. (Synopsys PCIe 3.0 IP)

Of course, it would be great if others were willing to give it a try.

Best regards,
Hans


