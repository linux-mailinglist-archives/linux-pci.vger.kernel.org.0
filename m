Return-Path: <linux-pci+bounces-6916-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C9178B845E
	for <lists+linux-pci@lfdr.de>; Wed,  1 May 2024 04:27:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0CE391F23A2E
	for <lists+linux-pci@lfdr.de>; Wed,  1 May 2024 02:27:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6390134CC;
	Wed,  1 May 2024 02:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Xx4Q/fX3"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A17A10A24;
	Wed,  1 May 2024 02:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714530445; cv=none; b=UR77mNP978QJ7NLSl2eATOfxmusx3ychOaUdHcwqGdzTESczvg1F/dDml4Goj1MP6zz+K8R1+CLE9xKwiJXhHo6eLsXIm5oihNhE2naCJDllP7iXXt8U1/pGLYeySdy6MW1iLIDrjip4q+6CVfRV7LzBkWPppqXyTTEQ7wBQgrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714530445; c=relaxed/simple;
	bh=C4Bu0P+OcVflb3CYw1CsRaTAwx+iM5mGLHMnFPeHMeg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=UiFoRk5w/U3xtdkrGJ/QIJTjI8Py2+198lfoqqGNb+8xXYB7RbuQ/96Ku5Ot2Ru1YxgO+YpflGKdTskmprev5ZXpnC/S+1OHc0YkbtkPjspRTiq6AJQe7Od4c53RxzoxJbGzCfVfrIKMi1EgA1knqKvE5uup5NFu3MrV17OGkMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Xx4Q/fX3; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714530444; x=1746066444;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=C4Bu0P+OcVflb3CYw1CsRaTAwx+iM5mGLHMnFPeHMeg=;
  b=Xx4Q/fX3ZuuWiJKqGKKJTCRkzQbEmFTpPhtAb86jHoljSyDWZv/QH+Tq
   tVEfgNxQH5mUSN27j0dbjr63W7MJRP3IaCtdHBbxkoVNINZ2M3z9PG4QU
   KeAcuhnLmSkY9xnh3XeA99uM2tYClqKUjUC9A55X6x52qnjcRibIbHXp4
   G4jp4RPr6V1xyrye7arOjMOT/OGy0Y34mlgtyF3FTgppw2WJfArpIV197
   GND1k1N+G+P9oIkwbxeoGsZdPXgzEl/rjHYGnepjeeCXaHGobVZL3qib/
   +5EWtiAho9azF7wdN4q9g/fCuNjW9rYQDNShWgATuWQX7jbtVKe2HuTzB
   w==;
X-CSE-ConnectionGUID: rNDZ5CDpQcegox3PtQ/2gw==
X-CSE-MsgGUID: /rxfIYhPTLGPS8fNMmFZzQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11060"; a="13189223"
X-IronPort-AV: E=Sophos;i="6.07,244,1708416000"; 
   d="scan'208";a="13189223"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2024 19:27:23 -0700
X-CSE-ConnectionGUID: gy4PU1ujQk653FM7YqNNhg==
X-CSE-MsgGUID: zTLxzBfbScy1/tRs/ioAZg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,244,1708416000"; 
   d="scan'208";a="31274501"
Received: from skuppusw-desk2.jf.intel.com ([10.165.154.101])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2024 19:27:24 -0700
From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Thatchanamurthy Satish <Satish.Thatchanamurt@Dell.com>
Subject: [PATCH v1] PCI/EDR: Align EDR implementation with PCI firmware r3.3 spec
Date: Wed,  1 May 2024 02:25:43 +0000
Message-Id: <20240501022543.1626025-1-sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

During the Error Disconnect Recover (EDR) spec transition from r3.2 ECN
to PCI firmware spec r3.3, improvements were made to definitions of
EDR_PORT_DPC_ENABLE_DSM (0x0C) and EDR_PORT_LOCATE_DSM(0x0D) _DSMs.

Specifically,

* EDR_PORT_DPC_ENABLE_DSM _DSM version changed from 5 to 6, and
  arg4 is now a package type instead of an integer in version 5.
* EDR_PORT_LOCATE_DSM _DSM uses BIT(31) to return the status of the
  operation.

Ensure _DSM implementation aligns with PCI firmware r3.3 spec
recommendation. More details about the EDR_PORT_DPC_ENABLE_DSM and
EDR_PORT_LOCATE_DSM _DSMs can be found in PCI firmware specification,
r3.3, sec 4.6.12 and sec 4.6.13.

While at it, fix a typo in EDR_PORT_LOCATE_DSM comments.

Fixes: ac1c8e35a326 ("PCI/DPC: Add Error Disconnect Recover (EDR) support")
Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
---
 drivers/pci/pcie/edr.c | 23 +++++++++++++++++------
 1 file changed, 17 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/pcie/edr.c b/drivers/pci/pcie/edr.c
index 5f4914d313a1..fea098e22e3e 100644
--- a/drivers/pci/pcie/edr.c
+++ b/drivers/pci/pcie/edr.c
@@ -35,7 +35,7 @@ static int acpi_enable_dpc(struct pci_dev *pdev)
 	 * Behavior when calling unsupported _DSM functions is undefined,
 	 * so check whether EDR_PORT_DPC_ENABLE_DSM is supported.
 	 */
-	if (!acpi_check_dsm(adev->handle, &pci_acpi_dsm_guid, 5,
+	if (!acpi_check_dsm(adev->handle, &pci_acpi_dsm_guid, 6,
 			    1ULL << EDR_PORT_DPC_ENABLE_DSM))
 		return 0;
 
@@ -47,11 +47,11 @@ static int acpi_enable_dpc(struct pci_dev *pdev)
 	argv4.package.elements = &req;
 
 	/*
-	 * Per Downstream Port Containment Related Enhancements ECN to PCI
-	 * Firmware Specification r3.2, sec 4.6.12, EDR_PORT_DPC_ENABLE_DSM is
-	 * optional.  Return success if it's not implemented.
+	 * Per PCI Firmware Specification r3.3, sec 4.6.12,
+	 * EDR_PORT_DPC_ENABLE_DSM is optional. Return success if it's not
+	 * implemented.
 	 */
-	obj = acpi_evaluate_dsm(adev->handle, &pci_acpi_dsm_guid, 5,
+	obj = acpi_evaluate_dsm(adev->handle, &pci_acpi_dsm_guid, 6,
 				EDR_PORT_DPC_ENABLE_DSM, &argv4);
 	if (!obj)
 		return 0;
@@ -86,7 +86,7 @@ static struct pci_dev *acpi_dpc_port_get(struct pci_dev *pdev)
 
 	/*
 	 * Behavior when calling unsupported _DSM functions is undefined,
-	 * so check whether EDR_PORT_DPC_ENABLE_DSM is supported.
+	 * so check whether EDR_PORT_LOCATE_DSM is supported.
 	 */
 	if (!acpi_check_dsm(adev->handle, &pci_acpi_dsm_guid, 5,
 			    1ULL << EDR_PORT_LOCATE_DSM))
@@ -103,6 +103,17 @@ static struct pci_dev *acpi_dpc_port_get(struct pci_dev *pdev)
 		return NULL;
 	}
 
+	/*
+	 * Per PCI Firmware Specification r3.3, sec 4.6.13, bit 31 represents
+	 * the success/failure of the operation. If bit 31 is set, the operation
+	 * is failed.
+	 */
+	if (obj->integer.value & BIT(31)) {
+		ACPI_FREE(obj);
+		pci_err(pdev, "Locate Port _DSM failed\n");
+		return NULL;
+	}
+
 	/*
 	 * Firmware returns DPC port BDF details in following format:
 	 *	15:8 = bus
-- 
2.25.1


