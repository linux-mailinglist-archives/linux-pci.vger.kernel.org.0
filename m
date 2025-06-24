Return-Path: <linux-pci+bounces-30514-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E033DAE6B16
	for <lists+linux-pci@lfdr.de>; Tue, 24 Jun 2025 17:32:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 486B53BE38D
	for <lists+linux-pci@lfdr.de>; Tue, 24 Jun 2025 15:28:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2611B2DECA8;
	Tue, 24 Jun 2025 15:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="Y00tVdkY"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AAB8307499;
	Tue, 24 Jun 2025 15:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750777843; cv=none; b=JXJnnNOiKu67e8JrNaHuTplxQxaOv3UIQETpyXPc0ToGVvW1LOc3gybxEgGVK7OG+g9oxc9VmXS5MV4PgBf/9TUyo09Dvf1eSXyODZdQj7/xuYmGWqVK+o+LYidpMQe043HHK1ChYFOO+CPIwba6bGTW1ntL+Dqujl+dxqLUPos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750777843; c=relaxed/simple;
	bh=91yEZNSfIskPJ8XoHlVkbp2xXmaSBMhH6H5PY5nldmE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m6ifCw6TUkm1gmNfioT4kgWg4ta5YJHr0TDBdTnR3J3vWt7LU/7HD1VxyeTNI/WXSYD5QCee2p9aFrl0/rUlBLdqKHzlJ023Rvhc8d7f90NNaqnGc8peawlWIGRy182RB81PRf0Xalg2btly4IxmjSV7ej6dqrwS0UQIkUgukQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=Y00tVdkY; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=jBDraCOAu6lGXn4DYIOE+w7raa5KrA4Ch8QdIgmramI=;
	b=Y00tVdkYP9pDKVJlnT+Yn8VolhYXqZsOSToPHdrp3jn+oMfGUUc6lbpWaq7Usp
	lQOV+exddYiiMFfD0H1e9ZjRDsP9qX+OHP8TQUoy3kb8sERQp+lhy6IDWpeM1diS
	9VZ5KJWj3SqpdoGurAHMny7434iEez9HGt3yA5kTpir2I=
Received: from [IPV6:240e:b8f:919b:3100:5951:e2f3:d3e5:8d13] (unknown [])
	by gzsmtp5 (Coremail) with SMTP id QCgvCgBH83S0v1posFFDAA--.9579S2;
	Tue, 24 Jun 2025 23:09:41 +0800 (CST)
Message-ID: <a499a2cb-1755-423d-95a0-c87746c128d2@163.com>
Date: Tue, 24 Jun 2025 23:09:39 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v13 0/6] Refactor capability search into common macros
To: lpieralisi@kernel.org, bhelgaas@google.com, mani@kernel.org,
 ilpo.jarvinen@linux.intel.com, kwilczynski@kernel.org
Cc: robh@kernel.org, jingoohan1@gmail.com, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250607161405.808585-1-18255117159@163.com>
Content-Language: en-US
From: Hans Zhang <18255117159@163.com>
In-Reply-To: <20250607161405.808585-1-18255117159@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:QCgvCgBH83S0v1posFFDAA--.9579S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxZFW5Jr4Uur4rJFWfGry5CFg_yoWrZw1fpF
	1rCwnxCrWrJ39xuan7tw4I9FW5Zan7J34xJ3y5Kwn3ZF13uFyrJrn7Kw4rAF9rGrZ7X3W2
	vFWUt34kCF1DAa7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UoBTrUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/1tbiWx92o2havwMT3QAAsR

Dear Ilpo,

Gentle ping.

Best regards,
Hans

On 2025/6/8 00:13, Hans Zhang wrote:
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
> Changes since v12:
> - Modify some commit messages, code format issues, and optimize the function return values.
> 
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
>    PCI: cadence: Use cdns_pcie_find_*capability to avoid hardcode
> 
>   drivers/pci/access.c                          | 15 ++++
>   .../pci/controller/cadence/pcie-cadence-ep.c  | 38 ++++----
>   drivers/pci/controller/cadence/pcie-cadence.c | 30 +++++++
>   drivers/pci/controller/cadence/pcie-cadence.h | 18 ++--
>   drivers/pci/controller/dwc/pcie-designware.c  | 83 ++++--------------
>   drivers/pci/pci.c                             | 76 +++-------------
>   drivers/pci/pci.h                             | 87 +++++++++++++++++++
>   include/uapi/linux/pci_regs.h                 |  3 +
>   8 files changed, 196 insertions(+), 154 deletions(-)
> 
> 
> base-commit: ec7714e4947909190ffb3041a03311a975350fe0


