Return-Path: <linux-pci+bounces-26696-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DB9D6A9B1B1
	for <lists+linux-pci@lfdr.de>; Thu, 24 Apr 2025 17:08:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3095317D475
	for <lists+linux-pci@lfdr.de>; Thu, 24 Apr 2025 15:08:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3142919ABD4;
	Thu, 24 Apr 2025 15:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="gze8Qcx0"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A5161A2C25;
	Thu, 24 Apr 2025 15:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745507302; cv=none; b=nPFkIPdFmp66V4iq3q/KedR2sp4yPTBDdM8t4oV/ysunkMQxP/X6gnpSvhV+Gc738tT6OcE3X6kyt32gf1euZOT9ovbE6ZEHR2CtfbuuieTgOshhyDOs4rFXBKU/I+SnQKdaFnGsQsH4BIvS3GXmyqt8m9/szOcbySYCftt2Zhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745507302; c=relaxed/simple;
	bh=o0Ai0SZtFa2RI/ToDkaO+WyZAtbDmUgbncrOBGd7aoc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=vGYOFPCA1Q4pRuX+l9ur2Dj13++eTx2zb5T1pkyMq7JHwVn7jLgLtcutft0sBbL/zqd6Y7xiV68IeXbITttc/REUQdjGOHHU5mS09mDOfdbhx7mFPmCjEaB6sQE839Ggzi/1/QlQAPKQDCrgHS8cos/JmSym/u5WmTMz+VVZFBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=gze8Qcx0; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:From:
	Content-Type; bh=dxkLHxxes5L86/5YQKS8XzPz7S8vMgBcRlB7XXBOdd8=;
	b=gze8Qcx0fL+kkSwV1lswzgml7JSlY6wzsY78QTxcRvsjVFQge7f4crLl52Tdcw
	6Nfkk4XPs+Q4UdJTVruj1bY6nsi+RqsRjmXO1e6DEOMyYsJxw8WlEMj7sC8+sdls
	eAI+HWAn5QbNQGbPg6KsM7Lg2kIsDX83MlbU/4YAVx8js=
Received: from [192.168.71.89] (unknown [])
	by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id _____wBnQmWwUwpo+yqACQ--.5746S2;
	Thu, 24 Apr 2025 23:07:29 +0800 (CST)
Message-ID: <f8818830-d23f-468e-886e-a14a2f96ebb8@163.com>
Date: Thu, 24 Apr 2025 23:07:28 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 0/6] Refactor capability search into common macros
To: lpieralisi@kernel.org, bhelgaas@google.com
Cc: kw@linux.com, manivannan.sadhasivam@linaro.org,
 ilpo.jarvinen@linux.intel.com, robh@kernel.org, jingoohan1@gmail.com,
 thomas.richard@bootlin.com, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250409034156.92686-1-18255117159@163.com>
Content-Language: en-US
From: Hans Zhang <18255117159@163.com>
In-Reply-To: <20250409034156.92686-1-18255117159@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_____wBnQmWwUwpo+yqACQ--.5746S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7ZFWkWw1rCryDCFy5JFW3GFg_yoW8Kry5pF
	yrXwn3CrWrJa9a9an2yw4IkF43Aan7Ja47J3ySkwn3ZF17ZFy5Krn3Kw1rAFy2v397Xwnx
	ZF4UJr9YkFn0ya7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UVMKtUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbBDwM5o2gKTGYWkgABsb


On 2025/4/9 11:41, Hans Zhang wrote:
> 1. Introduce generic bus config read helper function.
> 2. Clean up __pci_find_next_cap_ttl() readability.
> 3. Refactor capability search into common macros.
> 4. DWC/CDNS use common PCI host bridge macros for finding the
>     capabilities.
> 5. Use cdns_pcie_find_*capability to avoid hardcode.
> 
> Changes since v8:
> - Split patch.
> - The patch commit message were modified.
> - Other patches(4/6, 5/6, 6/6) are unchanged.
> 
> Changes since v7:
> - Patch 2/5 and 3/5 compilation error resolved.
> - Other patches are unchanged.
> 
> Changes since v6:
> - Refactor capability search into common macros.
> - Delete pci-host-helpers.c and MAINTAINERS.
> 
> Changes since v5:
> - If you put the helpers in drivers/pci/pci.c, they unnecessarily enlarge
>    the kernel's .text section even if it's known already at compile time
>    that they're never going to be used (e.g. on x86).
> - Move the API for find capabilitys to a new file called
>    pci-host-helpers.c.
> - Add new patch for MAINTAINERS.
> 
> Changes since v4:
> - Resolved [v4 1/4] compilation warning.
> - The patch subject and commit message were modified.
> 
> Changes since v3:
> - Resolved [v3 1/4] compilation error.
> - Other patches are not modified.
> 
> Changes since v2:
> - Add and split into a series of patches.
> 
> Hans Zhang (6):
>    PCI: Introduce generic bus config read helper function
>    PCI: Clean up __pci_find_next_cap_ttl() readability
>    PCI: Refactor capability search into common macros
>    PCI: dwc: Use common PCI host bridge APIs for finding the capabilities
>    PCI: cadence: Use common PCI host bridge APIs for finding the
>      capabilities
>    PCI: cadence: Use cdns_pcie_find_*capability to avoid hardcode.
> 
>   drivers/pci/access.c                          | 17 ++++
>   .../pci/controller/cadence/pcie-cadence-ep.c  | 40 +++++----
>   drivers/pci/controller/cadence/pcie-cadence.c | 28 ++++++
>   drivers/pci/controller/cadence/pcie-cadence.h | 18 ++--
>   drivers/pci/controller/dwc/pcie-designware.c  | 72 ++-------------
>   drivers/pci/pci.c                             | 68 ++------------
>   drivers/pci/pci.h                             | 88 +++++++++++++++++++
>   include/uapi/linux/pci_regs.h                 |  2 +
>   8 files changed, 187 insertions(+), 146 deletions(-)
> 
> 
> base-commit: a24588245776dafc227243a01bfbeb8a59bafba9


Dear all,

Gentle ping.

Best regards,
Hans


