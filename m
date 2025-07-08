Return-Path: <linux-pci+bounces-31656-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B16DAFC410
	for <lists+linux-pci@lfdr.de>; Tue,  8 Jul 2025 09:31:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E45EC189E1D4
	for <lists+linux-pci@lfdr.de>; Tue,  8 Jul 2025 07:31:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDCA02571B8;
	Tue,  8 Jul 2025 07:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PGg1Wc67"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3E31175D47;
	Tue,  8 Jul 2025 07:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751959853; cv=none; b=NYTjy21ljgR6b9nwFe4LuSNrS9SLbN4bt/kDj+151cr++Dt7HCrZnHnDG2NLBBBQOSMD1v48li4PfJ8Jng8uswzMuXPRRWyaAxl54K/QGG++uw7rfaQoDrLtLQ/1QXkSOQZC20Ax1hAaszjwzA2eulhZ6d1CZUKlFXcxxxmQ0t8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751959853; c=relaxed/simple;
	bh=fsiIYLp9z36dk35DgJnBlNrTO0D5I4SMQzYrEigmmTg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VlrUHRRmuJ2N66gLTpif3eRevFPm940SV5oRP7qdLhGQjgidlC97LP3nrLGxO7NzkaThWhktZOPRFfvQQy8NC3vSd4sqHW8/x/8fqylOsYhTZtyykRa62zTvYlrd7oGU1dDxpu4FmG2cjFL1srR3jQDcTMyW+4AfcujQd101ArU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PGg1Wc67; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF347C4CEF5;
	Tue,  8 Jul 2025 07:30:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751959853;
	bh=fsiIYLp9z36dk35DgJnBlNrTO0D5I4SMQzYrEigmmTg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PGg1Wc67FZYOGPJWoRh/x/hiQ9na/9so7ye8XcdHDZwi29nLVu6SUS0K7ek40q8au
	 Eb1nURNApEEmz8bx0aPB4AFN/P6QNqUALRV/LXACj/aytJI0shvZUa/kl7+bSo25B5
	 Gff646QFDVEhhNJuAJzx/Yw7huOS8vPnK2KvKB53saWCTENPORVXv5PSqa+GJwWyQF
	 gCLbwPxufA+kUNF8kt5kwo7y8WYJGXUn1GuqsxRuLCIyE7/o6MU1m3hCzPSNwhKcRK
	 VbKnV+ouE2DL5aZ4+4tIhQVe5A2Gym1gk4kCuQr0+/x8xA4TVazZFQoKyZ1o8YVfcg
	 rQXnCIAv2nRIQ==
Date: Tue, 8 Jul 2025 13:00:45 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Hans Zhang <18255117159@163.com>
Cc: lpieralisi@kernel.org, bhelgaas@google.com, 
	ilpo.jarvinen@linux.intel.com, kwilczynski@kernel.org, robh@kernel.org, jingoohan1@gmail.com, 
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v13 0/6] Refactor capability search into common macros
Message-ID: <fccfm6r7oi3lnqupx2srvvpv6fxm2oswi6ksymjnkhqsx4fcji@ipmc6v5nltdf>
References: <20250607161405.808585-1-18255117159@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250607161405.808585-1-18255117159@163.com>

On Sun, Jun 08, 2025 at 12:13:59AM GMT, Hans Zhang wrote:
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
>   use the new macros, removing device-specific assumptions and ensuring
>   consistent error handling.
> 
> - Enhanced Readability: Magic numbers are replaced with symbolic
>   constants, and config space accessors are standardized for clarity.
> 
> - Backward Compatibility: Existing PCI core behavior remains unchanged.
> 

Acked-by: Manivannan Sadhasivam <mani@kernel.org>

- Mani

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
>   PCI: Introduce generic bus config read helper function
>   PCI: Clean up __pci_find_next_cap_ttl() readability
>   PCI: Refactor capability search into common macros
>   PCI: dwc: Use common PCI host bridge APIs for finding the capabilities
>   PCI: cadence: Use common PCI host bridge APIs for finding the
>     capabilities
>   PCI: cadence: Use cdns_pcie_find_*capability to avoid hardcode
> 
>  drivers/pci/access.c                          | 15 ++++
>  .../pci/controller/cadence/pcie-cadence-ep.c  | 38 ++++----
>  drivers/pci/controller/cadence/pcie-cadence.c | 30 +++++++
>  drivers/pci/controller/cadence/pcie-cadence.h | 18 ++--
>  drivers/pci/controller/dwc/pcie-designware.c  | 83 ++++--------------
>  drivers/pci/pci.c                             | 76 +++-------------
>  drivers/pci/pci.h                             | 87 +++++++++++++++++++
>  include/uapi/linux/pci_regs.h                 |  3 +
>  8 files changed, 196 insertions(+), 154 deletions(-)
> 
> 
> base-commit: ec7714e4947909190ffb3041a03311a975350fe0
> -- 
> 2.25.1
> 

-- 
மணிவண்ணன் சதாசிவம்

