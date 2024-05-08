Return-Path: <linux-pci+bounces-7263-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90C7D8C0452
	for <lists+linux-pci@lfdr.de>; Wed,  8 May 2024 20:28:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C1F6286D10
	for <lists+linux-pci@lfdr.de>; Wed,  8 May 2024 18:28:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB7A912C52E;
	Wed,  8 May 2024 18:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UbGlWT+O"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C306E12BE9E;
	Wed,  8 May 2024 18:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715192871; cv=none; b=LZ969EhdRpCOHRoesdlh8snjiCpZtVW66FbAMNodeLrmLFG0Wnk41cHt0raeppCOlprpTocZzDW7VeHsKiagg1dxjx9etgi215RUAxZwhI6sG+Wq/q1I1IC95MADJxQq9tw8fFlk7rRtQ5petRDqHjhn7QpAOs+AWjICe2W/wvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715192871; c=relaxed/simple;
	bh=L72B4G+a+x3mvcV7BMSJURcAF7kdZYB0ONz5SoE/ihM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=D69zEFCt5EAH8Aj5hcF7ocEnfjVjpBQgd944+Eb2unXL/4d4qzJNf4zfDiM8CwMTcM2VebErUGghr9ADH+VbxtJbnNIa7e6DXx7U853Zp5hGpiDleqtlOE70+wIVjulZoWctoe3vMJalBQf5FshVklPljg+DJaKUNS7g4ThZq1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UbGlWT+O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EF16C113CC;
	Wed,  8 May 2024 18:27:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715192871;
	bh=L72B4G+a+x3mvcV7BMSJURcAF7kdZYB0ONz5SoE/ihM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=UbGlWT+O3RXMMb7+0j75P5B0SF9o5pkJjDoEigYDcBK1Wcd4VgyNu9OSed3/HIaUA
	 pGm2kJFiFtdLKvfifC1ONgEzLTJR/ZwKREKY+S73qzfQlzXgENVvaxnASyn/ZrG2Jb
	 AP55Pkb4QQ3gMQImZseLeD4skcaamoVPiMB3X5nLgEuTdOCi6iIdd0U66afF9ore6p
	 vqiJU3JCI19yeR9AFEI1Su2v2hcuiM72buRPvsvI7zqu6mQ5Oc2qCNEtUy2DOjQSxd
	 z0WTm9CRaZD1439KOZnrg+zX9wvFORCLZUXt5TdHVAm2hy5ptI5y0PBt9ag88AE2hI
	 YmixHwZiMzqAQ==
Date: Wed, 8 May 2024 13:27:49 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Dave Jiang <dave.jiang@intel.com>
Cc: linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org,
	dan.j.williams@intel.com, ira.weiny@intel.com,
	vishal.l.verma@intel.com, alison.schofield@intel.com,
	Jonathan.Cameron@huawei.com, dave@stgolabs.net, bhelgaas@google.com,
	lukas@wunner.de
Subject: Re: [PATCH v6 0/5] PCI: Add Secondary Bus Reset (SBR) support for CXL
Message-ID: <20240508182749.GA1778571@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240502165851.1948523-1-dave.jiang@intel.com>

On Thu, May 02, 2024 at 09:57:29AM -0700, Dave Jiang wrote:
> Hi Bjorn,
> Please consider this series for the next appropriate kernel merge window.
> The CXL part has review tags from Dan and Jonathan. It can go through your tree.
> The series attempt to add secondary bus reset (SBR) support to CXL. By default,
> SBR for CXL is masked. Per CXL specification r3.1 8.1.5.2, the Port Control
> Extensions register bit 0 (Unmask SBR) in the host bridge controls the masking
> of CXL SBR.  "When 0, SBR bit in Bridge Control register of this Port has no
> effect. When 1, the Port shall generate hot reset when SBR in Bridge Control
> gets set to 1.  Default value of this bit is 0. When the Port is operating in
> PCIe mode or RCD mode, this field has no effect on SBR functionality and Port
> shall follow PCIe Base Specification."

Applied with minor cleanups to pci/cxl for v6.10, thanks!

> v6:
> - Split out locking of upstream bridge to a separate patch and add lockdep
>   support. (Dan)
> - Added Dan's review tags for last 2 patches.
> 
> v5:
> - Move bridge locking to pci_reset_function(). (Dan)
> - Simplify retrieval of cxld. (Dan)
> - Add lock to device to prevent racing of disabled cxlmd. (Dan)
> - Promote dev_warn() to dev_crit() (Dan)
> - Remove LOCKDEP_NOT_UNRELIABLE flag. (Dan)
> 
> v4:
> - Return u16 for cxl_port_dvsec(). (Lukas)
> - Use pci_dev_lock guard() on bridge. (Lukas)
> - Clarify commit subject on 4/4. (Jonathan)
> 
> v3:
> - Move PCI_DVSEC_VENDOR_ID_CXL to PCI_VENDOR_ID_CXL in pci_ids.h (Bjorn)
> - Remove of CXL device checking. (Bjorn)
> - Rename defines to PCI_DVSEC_CXL_PORT_*. (Bjorn)
> - Fix SBR define in commit log. (Bjorn)
> - Update comment on dvsec not found. (Dan)
> - Check return of dvsec value read for error. (Dan)
> - Move cxl_port_dvsec() to an earlier patch. (Dan)
> - Add pci_cfg_access_lock() for bridge access. (Dan)
> - Change cxl_bus_force method to cxl_bus. (Dan)
> - Rename decoder_hw_mismatch() to __cxl_endpoint_decoder_reset_detected(). (Dan)
> - Move CXL register access function to core/pci.c. (Dan)
> - Add kernel taint to decoder reset warning. (Dan)
> 
> v2:
> - Use pci_upstream_bridge() instead of dev->bus->self. (Lukas)
> - Rename is_cxl_device() to pci_is_cxl(). (Lukas)
> - Return -ENOTTY on error. (Lukas)
> 
> Patch 1:
> Move PCI_DVSEC_VENDOR_ID_CXL to PCI_VENDOR_ID_CXL in pci_ids.h and adjust related
> CXL bits.
> 
> Patch 2:
> Add locking of the upstream bridge to keep configuration of the bridge consistent.
> 
> Patch 3:
> Add check to PCI bus_reset path for CXL device and return with error if "Unmask
> SBR" bit is set to 0. This allows user to realize that SBR is masked for this
> CXL device. However, if the user sets the "Unmask SBR" bit via a tool such as
> setpci, then the bus_reset will proceed.
> 
> Patch4:
> Add a new PCI reset method "cxl_bus" in order to allow the user an
> intetional way to perform SBR. The code will set the "Unmask SBR" bit to
> 1 and proceed with bus_reset. The original value of the bit will be restored
> after the reset operation.
> 
> Patch5:
> CXL driver change that provides a ->reset_done() callback. It compares the
> hardware decoder settings with the existing software configuration and emit
> warning if they differ. The difference indicates that decoders were programmed
> before the reset and are now cleared after reset. There may be onlined system
> memory backed by CXL memory device that are now violently ripped away from
> kernel mapping.
> 
> Patch series stemmed from this [1] patch. With comments [2] from Bjorn.
> 
> [1]: https://lore.kernel.org/linux-cxl/20240215232307.2793530-1-dave.jiang@intel.com/
> [2]: https://lore.kernel.org/linux-cxl/20240220203956.GA1502351@bhelgaas/
> 

