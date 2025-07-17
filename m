Return-Path: <linux-pci+bounces-32346-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5878B08179
	for <lists+linux-pci@lfdr.de>; Thu, 17 Jul 2025 02:40:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F948580216
	for <lists+linux-pci@lfdr.de>; Thu, 17 Jul 2025 00:40:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 679B981720;
	Thu, 17 Jul 2025 00:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hHHIdONq"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BA762E370C;
	Thu, 17 Jul 2025 00:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752712846; cv=none; b=e+DDGWMlificHNnLnwRpRqGOgbt20bJerPa9vLVkumaybxgtYL/sZoy1aKLrF1ip9znxZkiLYzSd/ucKbnfvLevLa/MSxAstB8s3aTbNCOIdD7dvoWXF/Gl4Ed9ueygD5sYc1aCyNSG4NWi8BDiYRETySrAsfpJS8uAqHFsir3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752712846; c=relaxed/simple;
	bh=Y+Cots5rJi/FBfAEv4lDLQM4MAAkN0eNxoE077TY2OQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=AxEM6aPRKFg4DC7kFHBJSS67A+L0BiDmlTHXC4ezbeXGXnJI5CcXFzKlXxILxABI52yTW8XS/5JHnX4lnLtToFaD/QonNb5FpwNi1De2CeGmPpG7jxpr56CsfKN/6n6Icv05LegqlvKy7KuRXSjdw1TpEv21selkNlNI/iEOk2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hHHIdONq; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752712845; x=1784248845;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Y+Cots5rJi/FBfAEv4lDLQM4MAAkN0eNxoE077TY2OQ=;
  b=hHHIdONqJi9Zpj0As2WEdKN66ELXIgWDR6SHLLjQ05YYI9JofLduXWdW
   XbDzhBF5BZYZLk/WoHHBBSsbPAs3XTZN4ao2rXoUr6MmXI2zw7NLYh9Nh
   ZZ1eHJKPAn5FW5o5qE+4Eei91Ebo1SdNw0B4jr8ZZqCI3yp1m4y7R1Miv
   EZEuLQB1V92pkpO6Vu5UMnoxXnxSAl17u41jq0e1ppE4COlZoDxmkppaD
   hFVJnt5q1YWXxJv/89C+8WLpvjCNt02Ilrwo3V6anXX0B2GUdfgsHHGDc
   oyJsOIEmy4hRWupj5esQnM9WtbhKra++4yVL1E+8OeD6Z/mxccdxe8Fqg
   g==;
X-CSE-ConnectionGUID: iA3INIuUTTK0Q82xnEJuCQ==
X-CSE-MsgGUID: MS3rKLZ5QVi8g/wXku5i+w==
X-IronPort-AV: E=McAfee;i="6800,10657,11493"; a="54912420"
X-IronPort-AV: E=Sophos;i="6.16,317,1744095600"; 
   d="scan'208";a="54912420"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2025 17:40:44 -0700
X-CSE-ConnectionGUID: tmfiHJLNTvOBnxZra5SbBA==
X-CSE-MsgGUID: 9djRhehiRJmPdxzYy78DMg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,317,1744095600"; 
   d="scan'208";a="188596607"
Received: from rfrazer-mobl3.amr.corp.intel.com (HELO debox1-desk4.intel.com) ([10.124.220.193])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2025 17:40:42 -0700
From: "David E. Box" <david.e.box@linux.intel.com>
To: rafael@kernel.org,
	bhelgaas@google.com,
	vicamo.yang@canonical.com,
	kenny@panix.com,
	ilpo.jarvinen@linux.intel.com,
	nirmal.patel@linux.intel.com
Cc: "David E. Box" <david.e.box@linux.intel.com>,
	linux-pm@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC 0/2] PCI/ASPM: Allow controller-defined default link state
Date: Wed, 16 Jul 2025 17:40:24 -0700
Message-ID: <20250717004034.2998443-1-david.e.box@linux.intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi all,

This RFC series addresses a limitation in the PCIe ASPM subsystem where
devices on synthetic PCIe hierarchies, such as those created by Intel=E2=80=
=99s
Volume Management Device (VMD), do not receive default ASPM settings
because they are not visible to firmware. As a result, ASPM remains
disabled on these devices unless explicitly enabled later by the driver,
contrary to platform power-saving expectations.

Problem with Current Behavior

Today, ASPM default policy is set in pcie_aspm_cap_init() based on values
provided by BIOS. For devices under VMD, BIOS has no visibility into the
hierarchy, and therefore no ASPM defaults are applied. The VMD driver can
attempt to walk the bus hierarchy and enable ASPM post-init using runtime
mechanisms, but this fails when aspm_disabled is set because the kernel
intentionally blocks runtime ASPM changes under ACPI=E2=80=99s FADT_NO_ASPM=
 flag.
However, this flag does not apply to VMD, which controls its domain
independently of firmware.

Goal

The ideal solution is to allow VMD or any controller driver managing a
synthetic hierarchy to provide a default ASPM link state at the same time
it's set for BIOS, in pcie_aspm_cap_init().

Solution

1. A new bus flag, PCI_BUS_FLAGS_ASPM_DEFAULT_OVERRIDE, based on Rafael's
suggestion, to signal that the driver intends to override the default ASPM
setting. 2. A new field, aspm_bus_link_state, in 'struct pci_bus' to supply
the desired default link state using the existing PCIE_LINK_STATE_XXX
bitmask.

If the flag is set, the ASPM core uses the driver-supplied value in place
of the firmware one. If not, behavior is unchanged.

Only the immediate parent bus is checked for this flag. If future use cases
require deeper inheritance (e.g., through PCIe switches), the logic can be
extended to walk the bus hierarchy.

This approach avoids adding driver-specific logic to ASPM core code and
keeps the layering clean.

Testing is appreciated as I didn't get a chance to do so yet but plan to.

Thanks, David

---

David E. Box (2):
  PCI/ASPM: Allow drivers to provide ASPM link state via pci_bus
  PCI: vmd: Provide default ASPM link state for synthetic hierarchy

 drivers/pci/controller/vmd.c |  7 +++++--
 drivers/pci/pcie/aspm.c      |  5 ++++-
 include/linux/pci.h          | 12 ++++++++----
 3 files changed, 17 insertions(+), 7 deletions(-)


base-commit: d0b3b7b22dfa1f4b515fd3a295b3fd958f9e81af
--=20
2.43.0


