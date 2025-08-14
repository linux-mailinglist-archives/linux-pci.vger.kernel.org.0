Return-Path: <linux-pci+bounces-34068-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 99B1AB27024
	for <lists+linux-pci@lfdr.de>; Thu, 14 Aug 2025 22:25:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 408D0A249C4
	for <lists+linux-pci@lfdr.de>; Thu, 14 Aug 2025 20:25:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 126A0259C98;
	Thu, 14 Aug 2025 20:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OD9Bx9iM"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCAB3258CF7;
	Thu, 14 Aug 2025 20:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755203122; cv=none; b=iVMp3ddptsa4DN+rZ+QTtg/fvWHgCsBcCWpeSJ0IJJQ/eCxS0Zk0hYOAanKBG8nmysY8FHPVDIZTXje7iWUUOQ6LlMVyjLXYZy7fd777coaRzuAgVvhY6cA4zPeqRHIO6UUiIcPb6URmhu+uIv7FZKfnmvvYPJ/IGGZcYCsiTkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755203122; c=relaxed/simple;
	bh=UZ5iOE/FwivBm/rIFSOlAgOmXTo+j4bV2ld3eUuQQsw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=WSX3P+kHix7y6yW9Fm05k3vMwkmOCYPHyG7YOWZ5iRc96BKo1A+aN94JNggMs7gBFad6wqbe3EbbjwGb0uvrqN/kXR2BQZ4uKGqi04yX0T0Y7KNWWHCb+ZPV4Enqya1lcrEU23dLJlMfR3GZVO/JQHD+q2ttGOvBn+JBCG84cXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OD9Bx9iM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E01BC4CEED;
	Thu, 14 Aug 2025 20:25:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755203121;
	bh=UZ5iOE/FwivBm/rIFSOlAgOmXTo+j4bV2ld3eUuQQsw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=OD9Bx9iM9M/reeKNAm+jKAfDbKgkmLbMQ4cE6d4UZlzzF3B2UlhTIK8DyinVRIlmG
	 mBNq/I16fGciXq+pCKpVvoeuyXvmUSdZU1paAHA3pUcS9Nmd5BtQdem8MqmyBQ24Vn
	 k6dRo7qOCv5U1ibGGNNiK4Scy1iEGkfmdBBGql3FJUHIa+slCUW6y0LvJSFQfbhRh6
	 69JJ8wt9/iGLYY8SpYY1TNc8/HYRb3XEUs8w9S11XOVNsqjL2key5xXQX1eDLmTLNq
	 xSNkt1IPSCp8YrFbQZBASvQVnD14uEZvDE7lP4B6t3HqQAc7tIzCebnmuBP2V+tG7T
	 SdTl20E4N3q/w==
Date: Thu, 14 Aug 2025 15:25:19 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Hans Zhang <18255117159@163.com>
Cc: lpieralisi@kernel.org, kwilczynski@kernel.org, bhelgaas@google.com,
	jingoohan1@gmail.com, mani@kernel.org, robh@kernel.org,
	ilpo.jarvinen@linux.intel.com, schnelle@linux.ibm.com,
	gbayer@linux.ibm.com, lukas@wunner.de, arnd@kernel.org,
	geert@linux-m68k.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v15 0/6] Refactor capability search into common macros
Message-ID: <20250814202519.GA344690@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250813144529.303548-1-18255117159@163.com>

On Wed, Aug 13, 2025 at 10:45:23PM +0800, Hans Zhang wrote:
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
> searches is refactored into shared macros (`PCI_FIND_NEXT_CAP` and
> `PCI_FIND_NEXT_EXT_CAP`), eliminating redundant implementations.
> 
> 3. Safety and Maintainability: TTL checks are centralized within the
> macros to prevent infinite loops, while hardcoded offsets in drivers
> are replaced with dynamic discovery, reducing fragility.
> 
> Key improvements include:  
> - Driver Conversions: DesignWare and Cadence drivers are migrated to
>   use the new macros, removing device-specific assumptions and ensuring
>   consistent error handling.
> 
> - Enhanced Readability: Magic numbers are replaced with symbolic
>   constants, and config space accessors are standardized for clarity.
> 
> - Backward Compatibility: Existing PCI core behavior remains unchanged.
> 
> ---
> Dear Niklas and Gerd,
> 
> Can you test this series of patches on the s390?
> 
> Thank you very much.
> ---
> 
> ---
> Changes since v14:
> - Delete the first patch in the v14 series.
> - The functions that can obtain the values of the registers u8/u16/u32 are
>   directly called in PCI_FIND_NEXT_CAP() and PCI_FIND_NEXT_EXT_CAP().
>   Use the pci_bus_read_config_byte/word/dword function directly.
> - Delete dw_pcie_read_cfg and redefine three functions: dw_pcie_read_cfg_byte/word/dword.
> - Delete cdns_pcie_read_cfg and redefine three functions: cdns_pcie_read_cfg_byte/word/dword.
> 
> Changes since v13:
> - Split patch 3/6 into two patches for searching standard and extended capability. (Bjorn)
> - Optimize the code based on the review comments from Bjorn.
> - Patch 5/7 and 6/7 use simplified macro definitions: PCI_FIND_NEXT_CAP(), PCI_FIND_NEXT_EXT_CAP().
> - The other patches have not been modified.
> 
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
>   The latest 6.15 rc1 merge __dw_pcie_find_vsec_capability, which uses 
>   dw_pcie_find_next_ext_capability.
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
>   the kernel's .text section even if it's known already at compile time
>   that they're never going to be used (e.g. on x86).
> - Move the API for find capabilitys to a new file called
>   pci-host-helpers.c.
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
>   PCI: Clean up __pci_find_next_cap_ttl() readability
>   PCI: Refactor capability search into PCI_FIND_NEXT_CAP()
>   PCI: Refactor extended capability search into PCI_FIND_NEXT_EXT_CAP()
>   PCI: dwc: Use PCI core APIs to find capabilities
>   PCI: cadence: Use PCI core APIs to find capabilities
>   PCI: cadence: Use cdns_pcie_find_*capability() to avoid hardcoding
>     offsets
> 
>  .../pci/controller/cadence/pcie-cadence-ep.c  | 38 +++++----
>  drivers/pci/controller/cadence/pcie-cadence.c | 14 +++
>  drivers/pci/controller/cadence/pcie-cadence.h | 39 +++++++--
>  drivers/pci/controller/dwc/pcie-designware.c  | 77 ++---------------
>  drivers/pci/controller/dwc/pcie-designware.h  | 21 +++++
>  drivers/pci/pci.c                             | 76 +++--------------
>  drivers/pci/pci.h                             | 85 +++++++++++++++++++
>  include/uapi/linux/pci_regs.h                 |  3 +
>  8 files changed, 194 insertions(+), 159 deletions(-)

I applied this on pci/capability-search for v6.18, thanks!

Niklas, I added your Tested-by, omitting the dwc and cadence patches
because I think you tested s390 and probably didn't exercise dwc or
cadence.  Thanks very much to you and Gerd for finding the issue and
testing the resolution!

Bjorn

