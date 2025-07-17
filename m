Return-Path: <linux-pci+bounces-32356-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 59A16B08594
	for <lists+linux-pci@lfdr.de>; Thu, 17 Jul 2025 08:56:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B10E91A6104B
	for <lists+linux-pci@lfdr.de>; Thu, 17 Jul 2025 06:56:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E62B21CFE0;
	Thu, 17 Jul 2025 06:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mPbFzUnL"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D71C21B9DA;
	Thu, 17 Jul 2025 06:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752735330; cv=none; b=a1iOpc/uWY8eJP3syIQMu1lPHnDxlla39WynJwQH3Y0q7JSEhtKoAmTwWU590TxHBmn28vNG1hZUiy60Nqd91pVtKMjUG21yvTfDzO0qOrxhjWrvkL9BvMY+svKcJLua9hy8WHkrAm3Ba//34GeFCQzkFLQq/S/lu5DMteUOZKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752735330; c=relaxed/simple;
	bh=IhxxHydjIe6EFEU4lYJoRQW2Yd7Xi9kUlDBeEWu4WIM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZLAKfNDX2NRAgyv9iCv3YB9kyThVnhVBq8F9CMLU/Thz4UFS5LW4pSk8tLDCb9EtO+BOpcBKAaivWxvUe22pO+6IkSfvFQlEFBvmXkss/Dz/WXm8CAg99mVlLMC8psN+CBHKh7J4lxI/e6Lfu64Wib6Uooot701TId/jTCArvL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mPbFzUnL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17374C4CEEB;
	Thu, 17 Jul 2025 06:55:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752735329;
	bh=IhxxHydjIe6EFEU4lYJoRQW2Yd7Xi9kUlDBeEWu4WIM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mPbFzUnLR2i5DE9Aglw+TF50CYhn3g0/toaxuOkIwWnfG3s6p7FQufUOkDCdQEO5F
	 +r7AkJ8FC0jgeVUm0afxMPdXtQP7kE9FtlcCvO/pQ8uKJwS1ktR2gPVUkOXGnRd/5e
	 6jW6N3eKPf7EbvYDjyHoL+KrzC2XQejSYwqgYTLsnISWnPRp/ornKjrL/QB26PwtQM
	 byWeHQDJ2RRl3DRdj+005ql7Ifhw92DhpcYUDaEPmgPosj46IvYAbs/zRqoVkP+mzE
	 dMYURQ7ACnS0bxeeez9YrJpMAVUGHRNp3C9t63HZZy3Hm/pOOpnyMImI0b4NSy0NS+
	 b2t1KDvYgYmUw==
Date: Thu, 17 Jul 2025 12:25:20 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: "David E. Box" <david.e.box@linux.intel.com>
Cc: rafael@kernel.org, bhelgaas@google.com, vicamo.yang@canonical.com, 
	kenny@panix.com, ilpo.jarvinen@linux.intel.com, nirmal.patel@linux.intel.com, 
	linux-pm@vger.kernel.org, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC 0/2] PCI/ASPM: Allow controller-defined default link state
Message-ID: <4xcwba3d4slmz5gfuwypavxqreobnigzyu4vib6powtbibytyp@mmqcns27vlyr>
References: <20250717004034.2998443-1-david.e.box@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250717004034.2998443-1-david.e.box@linux.intel.com>

On Wed, Jul 16, 2025 at 05:40:24PM GMT, David E. Box wrote:
> Hi all,
> 
> This RFC series addresses a limitation in the PCIe ASPM subsystem where
> devices on synthetic PCIe hierarchies, such as those created by Intel’s
> Volume Management Device (VMD), do not receive default ASPM settings
> because they are not visible to firmware. As a result, ASPM remains
> disabled on these devices unless explicitly enabled later by the driver,
> contrary to platform power-saving expectations.
> 
> Problem with Current Behavior
> 
> Today, ASPM default policy is set in pcie_aspm_cap_init() based on values
> provided by BIOS. For devices under VMD, BIOS has no visibility into the
> hierarchy, and therefore no ASPM defaults are applied. The VMD driver can
> attempt to walk the bus hierarchy and enable ASPM post-init using runtime
> mechanisms, but this fails when aspm_disabled is set because the kernel
> intentionally blocks runtime ASPM changes under ACPI’s FADT_NO_ASPM flag.
> However, this flag does not apply to VMD, which controls its domain
> independently of firmware.
> 
> Goal
> 
> The ideal solution is to allow VMD or any controller driver managing a
> synthetic hierarchy to provide a default ASPM link state at the same time
> it's set for BIOS, in pcie_aspm_cap_init().
> 

I like the idea and would like to use it to address the similar limitation on
Qcom SoCs where the BIOS doesn't configure ASPM settings for any devices and
sometimes there is no BIOS at all (typical for SoCs used in embedded usecases).
So I was using pci_walk_bus() in the controller driver to enable ASPM for all
devices, but that obviously has issues with hotplugged devices.

> Solution
> 
> 1. A new bus flag, PCI_BUS_FLAGS_ASPM_DEFAULT_OVERRIDE, based on Rafael's
> suggestion, to signal that the driver intends to override the default ASPM
> setting. 2. A new field, aspm_bus_link_state, in 'struct pci_bus' to supply
> the desired default link state using the existing PCIE_LINK_STATE_XXX
> bitmask.
> 

Why would you need to make it the 'bus' specific flag? It is clear that the
controller driver is providing the default ASPM setting. So pcie_aspm_cap_init()
should be able to use the value provided by it for all busses.

Like:

diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index 2ad1852ac9b2..830496e556af 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -791,6 +791,7 @@ static void aspm_l1ss_init(struct pcie_link_state *link)
 static void pcie_aspm_cap_init(struct pcie_link_state *link, int blacklist)
 {
        struct pci_dev *child = link->downstream, *parent = link->pdev;
+       struct pci_host_bridge *host = pci_find_host_bridge(parent->bus);
        u32 parent_lnkcap, child_lnkcap;
        u16 parent_lnkctl, child_lnkctl;
        struct pci_bus *linkbus = parent->subordinate;
@@ -866,8 +867,8 @@ static void pcie_aspm_cap_init(struct pcie_link_state *link, int blacklist)
        }

        /* Save default state */
-       if (parent->bus->bus_flags & PCI_BUS_FLAGS_NO_ASPM_DEFAULT)
-               link->aspm_default = parent->bus->aspm_bus_link_state;
+       if (host && host->aspm_bus_link_state)
+               link->aspm_default = host->aspm_bus_link_state;
        else
                link->aspm_default = link->aspm_enabled;

This avoids the usage of the bus flag (which your series is not at all making
use of) and allows setting the 'host_bridge::aspm_bus_link_state' easily by the
controller drivers.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

