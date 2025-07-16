Return-Path: <linux-pci+bounces-32342-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C2D13B080D5
	for <lists+linux-pci@lfdr.de>; Thu, 17 Jul 2025 01:11:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 254F41C27031
	for <lists+linux-pci@lfdr.de>; Wed, 16 Jul 2025 23:11:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACE532ECD28;
	Wed, 16 Jul 2025 23:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TT0rWzgx"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D72E3FE7;
	Wed, 16 Jul 2025 23:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752707483; cv=none; b=WGlrbacT3XrMFc++113n5rcgaTXsWEGWwNIpiXlTGHlVAYpdkWFeMzggVccQmpVkeRgSAQCd6eJSY7gxqHuyZSUuvYngmC3Kz9oVRapbnF3OSoN6pQFY1Z6aViwRZaVwlTyuEqfp8x0GiVJfbx/1NYoyBnfRTyZBZp2sHgj5OEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752707483; c=relaxed/simple;
	bh=/l4TyeEkX/0K3FTsq04WjRdyLLSoPhLq+387Eo/nNuo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=S4mAsFl4eUU6k0xxkg+hHP9GjV70UETsM+uBS1wnS2/w1nYFI3Z8Io0SNMFwcnghKHJDFkz909lndfotUQ03t0rFNi+aYYO6j9AP3EjLX7V0x6KOiQFs0odCW6V0SvtTJBIcTi9RWU4/z8zCDLykR0O5Lj1PGdco+fwGIyzYebg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TT0rWzgx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1079FC4CEE7;
	Wed, 16 Jul 2025 23:11:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752707483;
	bh=/l4TyeEkX/0K3FTsq04WjRdyLLSoPhLq+387Eo/nNuo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=TT0rWzgxzeCEn7X6fG28hWm08c5vXFsCr9qHK4nYL8gcx5mY1bo3fjACkUdL+EecL
	 55ItTWub+UjltOIgqq7AIwxMlzoLUdoxhCEMsG4qUKTDy0NpgDP5dKLq9i2t+1eWTH
	 zHZqq4L7379nhcdp6IZNV/vImuuityWOUAiaIBomhb9mqfI6uaoWBG9IaISSy3ZvyM
	 zJc7KDYd9l2fmBGhRjLh+sN3L92q9arWiTu+2p5PIPyGNf1AB5JfJplvXXgi4zQaeJ
	 ztE6bpdWTQuRxrnozLbKm5AwT1TXzxbSq5nHEcA7sc/qAtNUxnCljEMaRBXTdEtCuS
	 pNIV5pK3208Pg==
Date: Wed, 16 Jul 2025 18:11:21 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Hans Zhang <18255117159@163.com>
Cc: lpieralisi@kernel.org, kwilczynski@kernel.org, bhelgaas@google.com,
	jingoohan1@gmail.com, mani@kernel.org, robh@kernel.org,
	ilpo.jarvinen@linux.intel.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v14 0/7] Refactor capability search into common macros
Message-ID: <20250716231121.GA2564572@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250716161203.83823-1-18255117159@163.com>

On Thu, Jul 17, 2025 at 12:11:56AM +0800, Hans Zhang wrote:
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
> Hans Zhang (7):
>   PCI: Introduce generic bus config read helper function
>   PCI: Clean up __pci_find_next_cap_ttl() readability
>   PCI: Refactor standard capability search into common macro
>   PCI: Refactor extended capability search into common macro
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
> base-commit: 19272b37aa4f83ca52bdf9c16d5d81bdd1354494

Applied to pci/capability-search for v6.17, thanks for all this work!

