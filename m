Return-Path: <linux-pci+bounces-32348-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 430BCB08180
	for <lists+linux-pci@lfdr.de>; Thu, 17 Jul 2025 02:41:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA69F1C27D73
	for <lists+linux-pci@lfdr.de>; Thu, 17 Jul 2025 00:41:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4A5A17DFE7;
	Thu, 17 Jul 2025 00:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="J+xoq7WV"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 111F213BC3F;
	Thu, 17 Jul 2025 00:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752712848; cv=none; b=Yav5gSGZu57s3fM/2Uz1wEzpzUZ4CSMl4zKE0Xom0BtrgqvgyJ8lXs/pr3zJC8ZXkIdKmSYnPmExgjIHWDn611m4ncTRZ/tiiA7c2KUSjRbj/NkI4sF7iNzs1u+n0hEOEUbs9mEJ2k7sI7a1ZS/rEgQYkshu6Njez6PPREpOAd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752712848; c=relaxed/simple;
	bh=pGPEUa+QjgHSwGSl+XsBJJrSNi73U++upVdMDW8I9eI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a6YuOQlXfuydWi6HBqVaPEI2nf4ChvicndE4YFFdRb2DnatIswsUTHG9EIynzQQhp+N4PF5zYgEFteb4fJLEpkw6krR5PArAe7CcoFeS8u+cNTu2F5FvJLHwympmruHxOGxmeH1thoax55aRCwbYDv2XG8BIefppAd1IJmB2bXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=J+xoq7WV; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752712847; x=1784248847;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=pGPEUa+QjgHSwGSl+XsBJJrSNi73U++upVdMDW8I9eI=;
  b=J+xoq7WVX9r463DJsJ1/98Kk8m4V+lrrXr2oJX3KbPVykNzm4i0/yo7e
   id+gWU8zQq/s7KB0DmjFrOD2Ghrx7uB175zvuetGPLC58o5tgp5I9zOce
   HxjRPdrhSlMWRV5TUy8LBl+x5vFRYbLpYUdwGbO83aPXx050dyswIltnB
   detJ12jNdpI7E70IigFkK7TW6qI+rYmd0o2oki1sH/m0A/sD7jwUzNQtc
   SLWcndtwJASEPKYEcfRhtTSRrvprlwTwalWXAt3s9VCYt3wT3G6j7lV1P
   PAPzkl5KL21la78kZLqRxOfrOOlj92ehCuS/7GZJpn0xjNmvEmHaEv4p8
   Q==;
X-CSE-ConnectionGUID: PCZMeV3OSY68+BErxLZcKw==
X-CSE-MsgGUID: NgSGwxryQA28rXk2/6moHQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11493"; a="54912432"
X-IronPort-AV: E=Sophos;i="6.16,317,1744095600"; 
   d="scan'208";a="54912432"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2025 17:40:45 -0700
X-CSE-ConnectionGUID: u1vk3HlqRTmsrLq1YVPcdQ==
X-CSE-MsgGUID: Hdr82QNmQTS2R6Fx9AstiA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,317,1744095600"; 
   d="scan'208";a="188596627"
Received: from rfrazer-mobl3.amr.corp.intel.com (HELO debox1-desk4.intel.com) ([10.124.220.193])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2025 17:40:44 -0700
From: "David E. Box" <david.e.box@linux.intel.com>
To: rafael@kernel.org,
	bhelgaas@google.com,
	vicamo.yang@canonical.com,
	kenny@panix.com,
	nirmal.patel@linux.intel.com
Cc: "David E. Box" <david.e.box@linux.intel.com>,
	linux-pm@vger.kernel.org,
	linux-pci@vger.kernel.org,
	ilpo.jarvinen@linux.intel.com,
	linux-kernel@vger.kernel.org
Subject: [RFC 2/2] PCI: vmd: Provide default ASPM link state for synthetic hierarchy
Date: Wed, 16 Jul 2025 17:40:26 -0700
Message-ID: <20250717004034.2998443-3-david.e.box@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250717004034.2998443-1-david.e.box@linux.intel.com>
References: <20250717004034.2998443-1-david.e.box@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Devices behind the VMD controller reside on a synthetic PCIe hierarchy that
is not visible to ACPI and not configured by firmware. As a result, these
devices receive no ASPM defaults from the BIOS, and ASPM remains disabled
unless explicitly enabled later.

Now that the ASPM core supports driver-supplied default link states via
pci_bus->aspm_bus_link_state, set this field on the VMD root bus to enable
ASPM for devices in the VMD domain. This ensures the platform's intended
power-saving configuration is applied during initialization without
requiring any special-case logic in the ASPM core.

Link: https://lore.kernel.org/linux-pm/0b166ece-eeec-ba5d-2212-50d995611cef=
@panix.com
Signed-off-by: David E. Box <david.e.box@linux.intel.com>
---
 drivers/pci/controller/vmd.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
index 8df064b62a2f..a0d4e96ce872 100644
--- a/drivers/pci/controller/vmd.c
+++ b/drivers/pci/controller/vmd.c
@@ -730,7 +730,7 @@ static void vmd_copy_host_bridge_flags(struct pci_host_=
bridge *root_bridge,
 }
=20
 /*
- * Enable ASPM and LTR settings on devices that aren't configured by BIOS.
+ * Enable LTR settings on devices that aren't configured by BIOS.
  */
 static int vmd_pm_enable_quirk(struct pci_dev *pdev, void *userdata)
 {
@@ -770,7 +770,6 @@ static int vmd_pm_enable_quirk(struct pci_dev *pdev, vo=
id *userdata)
 	 * PCIe r6.0, sec 5.5.4.
 	 */
 	pci_set_power_state_locked(pdev, PCI_D0);
-	pci_enable_link_state_locked(pdev, PCIE_LINK_STATE_ALL);
 	return 0;
 }
=20
@@ -911,6 +910,10 @@ static int vmd_enable_domain(struct vmd_dev *vmd, unsi=
gned long features)
 		return -ENODEV;
 	}
=20
+#ifdef CONFIG_PCIEASPM
+	vmd->bus->aspm_bus_link_state =3D PCIE_LINK_STATE_ALL;
+#endif
+
 	vmd_copy_host_bridge_flags(pci_find_host_bridge(vmd->dev->bus),
 				   to_pci_host_bridge(vmd->bus->bridge));
=20
--=20
2.43.0


