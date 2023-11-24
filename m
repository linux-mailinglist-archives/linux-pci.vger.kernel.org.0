Return-Path: <linux-pci+bounces-154-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A0847F6F25
	for <lists+linux-pci@lfdr.de>; Fri, 24 Nov 2023 10:09:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9FAB91C209BA
	for <lists+linux-pci@lfdr.de>; Fri, 24 Nov 2023 09:09:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92DB24C64;
	Fri, 24 Nov 2023 09:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="h2T48vt+"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 834F7D5E;
	Fri, 24 Nov 2023 01:09:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700816989; x=1732352989;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=JaTQ4JHa+dyVoXq+fCw9FkUT+lKnnmSMerIyEl8VRYc=;
  b=h2T48vt++CnaXEMlHgAJfLxPTpu+NrD9RSLgC88/jbZAM4cpH8rmJSql
   zK4A/6vPGcqervibKkhUNb7OXuf0iu2MAUtjX1GKIRoeMghOJThV/iK9s
   KdJVN4x13UOefTr5f1P/hCLRIfnes2ZCuFLhfzoeG+F04h2Uv0KZFKd1J
   7Uv4SXI8Ly7z4tiLgqyAXAGlBZRXQDCYdZprNs4GvN3uJpkYDSJQTCKq/
   ESNv8X71SxODjAFir04Fpd9qhgTfXaNX+C4UD0w4+Pqh7wOiAYPVj3Wum
   Co1399ZD3MgF6EyHLffRxOlMcEq+iAYPHNVbOuSDZRI4mfoQplYGD6SsF
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10902"; a="11066380"
X-IronPort-AV: E=Sophos;i="6.04,223,1695711600"; 
   d="scan'208";a="11066380"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2023 01:09:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10902"; a="885220541"
X-IronPort-AV: E=Sophos;i="6.04,223,1695711600"; 
   d="scan'208";a="885220541"
Received: from mvlasov-mobl1.ger.corp.intel.com (HELO localhost) ([10.251.220.89])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2023 01:09:27 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 1/6] x86: Use PCI_HEADER_TYPE_* instead of literals
Date: Fri, 24 Nov 2023 11:09:13 +0200
Message-Id: <20231124090919.23687-1-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Replace 0x7f and 0x80 literals with PCI_HEADER_TYPE_* defines.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 arch/x86/kernel/aperture_64.c  | 3 +--
 arch/x86/kernel/early-quirks.c | 4 ++--
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/aperture_64.c b/arch/x86/kernel/aperture_64.c
index 4feaa670d578..89c0c8a3fc7e 100644
--- a/arch/x86/kernel/aperture_64.c
+++ b/arch/x86/kernel/aperture_64.c
@@ -259,10 +259,9 @@ static u32 __init search_agp_bridge(u32 *order, int *valid_agp)
 							order);
 				}
 
-				/* No multi-function device? */
 				type = read_pci_config_byte(bus, slot, func,
 							       PCI_HEADER_TYPE);
-				if (!(type & 0x80))
+				if (!(type & PCI_HEADER_TYPE_MFD))
 					break;
 			}
 		}
diff --git a/arch/x86/kernel/early-quirks.c b/arch/x86/kernel/early-quirks.c
index a6c1867fc7aa..59f4aefc6bc1 100644
--- a/arch/x86/kernel/early-quirks.c
+++ b/arch/x86/kernel/early-quirks.c
@@ -779,13 +779,13 @@ static int __init check_dev_quirk(int num, int slot, int func)
 	type = read_pci_config_byte(num, slot, func,
 				    PCI_HEADER_TYPE);
 
-	if ((type & 0x7f) == PCI_HEADER_TYPE_BRIDGE) {
+	if ((type & PCI_HEADER_TYPE_MASK) == PCI_HEADER_TYPE_BRIDGE) {
 		sec = read_pci_config_byte(num, slot, func, PCI_SECONDARY_BUS);
 		if (sec > num)
 			early_pci_scan_bus(sec);
 	}
 
-	if (!(type & 0x80))
+	if (!(type & PCI_HEADER_TYPE_MFD))
 		return -1;
 
 	return 0;
-- 
2.30.2


