Return-Path: <linux-pci+bounces-33287-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64007B1820B
	for <lists+linux-pci@lfdr.de>; Fri,  1 Aug 2025 15:00:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0AD066278A8
	for <lists+linux-pci@lfdr.de>; Fri,  1 Aug 2025 13:00:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5563D22069E;
	Fri,  1 Aug 2025 13:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="he36To9o"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DAF71798F;
	Fri,  1 Aug 2025 13:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754053225; cv=none; b=aBcyUZODZpKOot481E/FjduM6mYHI174GPa5056OsULbjlyoz7Q9yDEuQ/66/ifynWq8XYdJ88aq8y40dOo4zAfasOnxQPuxTvqxRq23bjQ1AFb0gy9Rl3M5WFfxuOLb2LtmA+kio4Tw5KKGBsl0h//GD5y7WQCnigpI8oPMLF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754053225; c=relaxed/simple;
	bh=ExJEHWTpehzS2IwhurKbBBMl5M2sMDVXiU3hT+7cSXs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=GoqINnrYMf5a5wRIoibiy4UU2v4xrtMcuuVrn6yutCCI20e7ogwIfFje+p3ziAfaK4owF4ebK3v/WYZzKu0A0ZC8cVfERKYeDh4P6SfGWevzvB3q30+zaeQLtXBY8t0NwydQA63FrLxSepKsJ2z5YD23zK07BQ/Xo/cPbNuUX9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=he36To9o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95915C4CEE7;
	Fri,  1 Aug 2025 13:00:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754053223;
	bh=ExJEHWTpehzS2IwhurKbBBMl5M2sMDVXiU3hT+7cSXs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=he36To9oio6hWhAFv42x41vKhOO9HjTuLgp/S/cFud8dxCoMWFRAPeIt+35V1wNoi
	 B/gBzgLhfC8DLBA6/1ik/Mn4SIbApUjQ+wTEKZyH0eeGPfx1u3EqnWJzssqdvwkDMX
	 90IGUQN1jpMkmGi+XQRXpNPriLmjBn1ejfqwuwOHM4H0elTeKrZcCWzNFM5wE7p0QW
	 JCSD7LuGeaF6S0ENXpa6bisEY2SRPutbhi1b40ewhyszQj4N0lhTuNGdsF9U/vqwJ/
	 aKzcLO4md5kam41kTO132BJiDyYhSJnwTAgC6/1jXVOcS1TmFMSIA+BDXpozMMgY7a
	 NnK9gwfq1iwFA==
Date: Fri, 1 Aug 2025 08:00:22 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Hans Zhang <18255117159@163.com>
Cc: lpieralisi@kernel.org, kwilczynski@kernel.org, bhelgaas@google.com,
	jingoohan1@gmail.com, mani@kernel.org, robh@kernel.org,
	ilpo.jarvinen@linux.intel.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v14 0/7] Refactor capability search into common macros
Message-ID: <20250801130022.GA3493113@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250716231121.GA2564572@bhelgaas>

On Wed, Jul 16, 2025 at 06:11:21PM -0500, Bjorn Helgaas wrote:
> On Thu, Jul 17, 2025 at 12:11:56AM +0800, Hans Zhang wrote:
> > Dear Maintainers,
> > 
> > This patch series addresses long-standing code duplication in PCI
> > capability discovery logic across the PCI core and controller drivers.
> > The existing implementation ties capability search to fully initialized
> > PCI device structures, limiting its usability during early controller
> > initialization phases where device/bus structures may not yet be
> > available.
> > 
> > The primary goal is to decouple capability discovery from PCI device
> > dependencies by introducing a unified framework using config space
> > accessor-based macros. This enables:
> > 
> > 1. Early Capability Discovery: Host controllers (e.g., Cadence, DWC)
> > can now perform capability searches during pre-initialization stages
> > using their native config accessors.
> > 
> > 2. Code Consolidation: Common logic for standard and extended capability
> > searches is refactored into shared macros (`PCI_FIND_NEXT_CAP` and
> > `PCI_FIND_NEXT_EXT_CAP`), eliminating redundant implementations.
> > 
> > 3. Safety and Maintainability: TTL checks are centralized within the
> > macros to prevent infinite loops, while hardcoded offsets in drivers
> > are replaced with dynamic discovery, reducing fragility.
> > 
> > Key improvements include:  
> > - Driver Conversions: DesignWare and Cadence drivers are migrated to
> >   use the new macros, removing device-specific assumptions and ensuring
> >   consistent error handling.
> > 
> > - Enhanced Readability: Magic numbers are replaced with symbolic
> >   constants, and config space accessors are standardized for clarity.
> > 
> > - Backward Compatibility: Existing PCI core behavior remains unchanged.
> > 
> > ---
> > Changes since v13:
> > - Split patch 3/6 into two patches for searching standard and extended capability. (Bjorn)
> > - Optimize the code based on the review comments from Bjorn.
> > - Patch 5/7 and 6/7 use simplified macro definitions: PCI_FIND_NEXT_CAP(), PCI_FIND_NEXT_EXT_CAP().
> > - The other patches have not been modified.
> > 
> > Changes since v12:
> > - Modify some commit messages, code format issues, and optimize the function return values.
> > 
> > Changes since v11:
> > - Resolved some compilation warning.
> > - Add some include.
> > - Add the *** BLURB HERE *** description(Corrected by Mani and Krzysztof).
> > 
> > Changes since v10:
> > - The patch [v10 2/6] remove #include <uapi/linux/pci_regs.h> and add macro definition comments.
> > - The patch [v10 3/6] remove #include <uapi/linux/pci_regs.h> and commit message were modified.
> > - The other patches have not been modified.
> > 
> > Changes since v9:
> > - Resolved [v9 4/6] compilation error.
> >   The latest 6.15 rc1 merge __dw_pcie_find_vsec_capability, which uses 
> >   dw_pcie_find_next_ext_capability.
> > - The other patches have not been modified.
> > 
> > Changes since v8:
> > - Split patch.
> > - The patch commit message were modified.
> > - Other patches(4/6, 5/6, 6/6) are unchanged.
> > 
> > Changes since v7:
> > - Patch 2/5 and 3/5 compilation error resolved.
> > - Other patches are unchanged.
> > 
> > Changes since v6:
> > - Refactor capability search into common macros.
> > - Delete pci-host-helpers.c and MAINTAINERS.
> > 
> > Changes since v5:
> > - If you put the helpers in drivers/pci/pci.c, they unnecessarily enlarge
> >   the kernel's .text section even if it's known already at compile time
> >   that they're never going to be used (e.g. on x86).
> > - Move the API for find capabilitys to a new file called
> >   pci-host-helpers.c.
> > - Add new patch for MAINTAINERS.
> > 
> > Changes since v4:
> > - Resolved [v4 1/4] compilation warning.
> > - The patch subject and commit message were modified.
> > 
> > Changes since v3:
> > - Resolved [v3 1/4] compilation error.
> > - Other patches are not modified.
> > 
> > Changes since v2:
> > - Add and split into a series of patches.
> > ---
> > 
> > Hans Zhang (7):
> >   PCI: Introduce generic bus config read helper function
> >   PCI: Clean up __pci_find_next_cap_ttl() readability
> >   PCI: Refactor standard capability search into common macro
> >   PCI: Refactor extended capability search into common macro
> >   PCI: dwc: Use common PCI host bridge APIs for finding the capabilities
> >   PCI: cadence: Use common PCI host bridge APIs for finding the
> >     capabilities
> >   PCI: cadence: Use cdns_pcie_find_*capability to avoid hardcode
> > 
> >  drivers/pci/access.c                          | 15 ++++
> >  .../pci/controller/cadence/pcie-cadence-ep.c  | 38 ++++----
> >  drivers/pci/controller/cadence/pcie-cadence.c | 30 +++++++
> >  drivers/pci/controller/cadence/pcie-cadence.h | 18 ++--
> >  drivers/pci/controller/dwc/pcie-designware.c  | 83 ++++--------------
> >  drivers/pci/pci.c                             | 76 +++-------------
> >  drivers/pci/pci.h                             | 87 +++++++++++++++++++
> >  include/uapi/linux/pci_regs.h                 |  3 +
> >  8 files changed, 196 insertions(+), 154 deletions(-)
> > 
> > 
> > base-commit: 19272b37aa4f83ca52bdf9c16d5d81bdd1354494
> 
> Applied to pci/capability-search for v6.17, thanks for all this work!

Deferred until the next cycle for the big-endian issue.

Bjorn

