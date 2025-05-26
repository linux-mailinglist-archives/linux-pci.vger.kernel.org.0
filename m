Return-Path: <linux-pci+bounces-28407-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D330AC41E2
	for <lists+linux-pci@lfdr.de>; Mon, 26 May 2025 16:54:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 57FD93B8BF7
	for <lists+linux-pci@lfdr.de>; Mon, 26 May 2025 14:54:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1C6720F09A;
	Mon, 26 May 2025 14:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="kUL7fobQ"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59E1020E01F;
	Mon, 26 May 2025 14:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748271268; cv=none; b=cFw6Kwr3CfCWgnu8bl8rJO1kGx3l2g3sEEIWRQed9WEyE0xGpS4FvBh5zdXccRz/Z0RZipLYsd0rCHkC1a2vHUTxPuLTCsz+EjCgNHJq0Uqb7zsMLCYruuoGAaJyQVbKvIGQh/zHVcTf/z6hIsuSTQRzdUD4bnNx5uOtXME2+xI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748271268; c=relaxed/simple;
	bh=JFs9+wDYyc+/5TaWqhHhVWBo67C7BQy53q6HAKhlo/w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Vwi/DWZQdhNUHVMhNdKCMH2S7ZrM+fFMSH/lo4zz4ZYuY1ZKq2F5oMEFCjp2zx+ernwNOx/vAxVRdhywY7/GRCxVn3PNM2vxGmx9xyP1qG18hNL5mSEvsT+JGLYi/+BRzu+7AIG+ufjqt+Hur1beqf+okPWP3MoXhsKNa7zGGnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=kUL7fobQ; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=W0V5A4hmMfXrnMU3cZdDhRR4hXBKJTTiA4wVB7nCdiQ=;
	b=kUL7fobQdqsEHgi9poZcyazu5uTiJUgbG3o9YJw6gb6/K6RD6lztxzKxLQtwTV
	1aDqRb/I26FnA66K0XcvFi6rmZ/Vrc2O6ViUal5h0TEvD0CYMf6PR8Qo/qSI66MZ
	Mr71m0XpaNcpPP+xvTJKMzf8PdD6XcPYfxeFAn1OlpTa0=
Received: from [192.168.71.94] (unknown [])
	by gzga-smtp-mtada-g1-2 (Coremail) with SMTP id _____wC3_HZagDRoErghEA--.12334S2;
	Mon, 26 May 2025 22:53:15 +0800 (CST)
Message-ID: <60860792-ef02-4c10-b313-b3f34bab0a8b@163.com>
Date: Mon, 26 May 2025 22:53:15 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 0/6] Refactor capability search into common macros
To: lpieralisi@kernel.org, bhelgaas@google.com,
 manivannan.sadhasivam@linaro.org, ilpo.jarvinen@linux.intel.com, kw@linux.com
Cc: cassel@kernel.org, robh@kernel.org, jingoohan1@gmail.com,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250514161258.93844-1-18255117159@163.com>
Content-Language: en-US
From: Hans Zhang <18255117159@163.com>
In-Reply-To: <20250514161258.93844-1-18255117159@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_____wC3_HZagDRoErghEA--.12334S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxAF1rWw1ruw1DJFy7Xw17GFg_yoWrurWrpF
	yrGwnxCrW8JFZruan2ya1I9FW5Xan7t347J3y5Kwn8ZFnxuFyrJrn7Kw4rAF9rKrZ7X3W2
	vFWUtrykCF1DAa7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UB7K3UUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/1tbiWwhZo2g0evyS9wAAsW


Dear Ilpo,

May I ask if you have time to review the patches of this series? If 
there are any problems, I can continue to improve. If you think there is 
no problem, could you review it and add review tags?


Best regards,
Hans

On 2025/5/15 00:12, Hans Zhang wrote:
> Dear Maintainers,
> 
> This patch series addresses long-standing code duplication in PCI
> capability discovery logic across the PCI core and controller drivers.
> The existing implementation ties capability search to fully initialized
> PCI device structures, limiting its usability during early controller
> initialization phases where device/bus structures may not yet be
> available.
> 
> The primary goal is to decouple capability discovery from PCI device
> dependencies by introducing a unified framework using config space
> accessor-based macros. This enables:
> 
> 1. Early Capability Discovery: Host controllers (e.g., Cadence, DWC)
> can now perform capability searches during pre-initialization stages
> using their native config accessors.
> 
> 2. Code Consolidation: Common logic for standard and extended capability
> searches is refactored into shared macros (`PCI_FIND_NEXT_CAP_TTL` and
> `PCI_FIND_NEXT_EXT_CAPABILITY`), eliminating redundant implementations.
> 
> 3. Safety and Maintainability: TTL checks are centralized within the
> macros to prevent infinite loops, while hardcoded offsets in drivers
> are replaced with dynamic discovery, reducing fragility.
> 
> Key improvements include:
> - Driver Conversions: DesignWare and Cadence drivers are migrated to
>    use the new macros, removing device-specific assumptions and ensuring
>    consistent error handling.
> 
> - Enhanced Readability: Magic numbers are replaced with symbolic
>    constants, and config space accessors are standardized for clarity.
> 
> - Backward Compatibility: Existing PCI core behavior remains unchanged.
> 
> ---
> Changes since v11:
> - Resolved some compilation warning.
> - Add some include.
> - Add the *** BLURB HERE *** description(Corrected by Mani and Krzysztof).
> 
> Changes since v10:
> - The patch [v10 2/6] remove #include <uapi/linux/pci_regs.h> and add macro definition comments.
> - The patch [v10 3/6] remove #include <uapi/linux/pci_regs.h> and commit message were modified.
> - The other patches have not been modified.
> 
> Changes since v9:
> - Resolved [v9 4/6] compilation error.
>    The latest 6.15 rc1 merge __dw_pcie_find_vsec_capability, which uses
>    dw_pcie_find_next_ext_capability.
> - The other patches have not been modified.
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
> ---
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
>   drivers/pci/controller/dwc/pcie-designware.c  | 81 +++--------------
>   drivers/pci/pci.c                             | 68 ++------------
>   drivers/pci/pci.h                             | 88 +++++++++++++++++++
>   include/uapi/linux/pci_regs.h                 |  2 +
>   8 files changed, 194 insertions(+), 148 deletions(-)
> 
> 
> base-commit: 82f2b0b97b36ee3fcddf0f0780a9a0825d52fec3


