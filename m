Return-Path: <linux-pci+bounces-2659-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FD2183FAF4
	for <lists+linux-pci@lfdr.de>; Mon, 29 Jan 2024 00:32:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5CB0128474A
	for <lists+linux-pci@lfdr.de>; Sun, 28 Jan 2024 23:32:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBCF14C60C;
	Sun, 28 Jan 2024 23:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KB42YIRH"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43DA64595D;
	Sun, 28 Jan 2024 23:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.134.136.31
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706484738; cv=none; b=Fsp4gZWasuFbtiVrVkGpI1ni0ouziL67rn8xRY/KjAnMBlNAsY8xOm9LUNCo8FLGCfY4GgcAQz6b3DtmvG5FSW2ugXSzjlFfYMJlXiGnJaOwaLoSAt0MqsTXYJOu3DjzhMHAlHM/dh1565yGZU/GrjZUkGL/s03D930ITxyg+R8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706484738; c=relaxed/simple;
	bh=bx8duAkTrynztEMQULCsS8d2N4dVOXeKVQtbu5S9ZNg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Dsoa4hUlwB7B5G3MLZIDuhd1QoT/045iaruvjZ9X4SiE7IHvDk95Do5qQ16YhIVBQuBJJJYWMF2cwwk/4FfRMKiS0TNxiKUp2vPBdTt9G0wzV2rQH7Rg+NTO1cWT8ehPMCvBNcoxM+RVlNoAFV6NTARljp39TEtkdtD8EN6rtuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KB42YIRH; arc=none smtp.client-ip=134.134.136.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706484737; x=1738020737;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=bx8duAkTrynztEMQULCsS8d2N4dVOXeKVQtbu5S9ZNg=;
  b=KB42YIRH/UaRoyB0x2L/QGye/5MNpgpWjmrYB25jR7nuQemssAC+QkI4
   7M+1z11B0VYLKWWlylIHFy65OupVMwfyC8rbhLVNcgOg8tOSdi23tr1VH
   V3K08mrGTp30+gHYgD2EAM3Y19tz6nubc+wcx+Q6QmiuAR0G6quBAC5Cm
   IeREyRD/6WplW3HuE+ozu1Sia3n4tOuliamr4Pr3L9bn5qROspXJSRRLI
   gvCjTrDW6GiV7hkfCYmCieySZVoxDeg9Hy46XPUaru/gfLn1dQJYx8Fnz
   iSVWKgwEscPX0p02A/TMo/hy6te6LiSbrLxyi27onwxyU+Ie/LWqIyRlq
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10967"; a="467081131"
X-IronPort-AV: E=Sophos;i="6.05,226,1701158400"; 
   d="scan'208";a="467081131"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2024 15:32:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10967"; a="930913784"
X-IronPort-AV: E=Sophos;i="6.05,226,1701158400"; 
   d="scan'208";a="930913784"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2024 15:32:14 -0800
Received: from debox1-desk4.intel.com (sdutta-mobl2.amr.corp.intel.com [10.209.55.52])
	by linux.intel.com (Postfix) with ESMTP id 12C9F580DDD;
	Sun, 28 Jan 2024 15:32:14 -0800 (PST)
From: "David E. Box" <david.e.box@linux.intel.com>
To: mika.westerberg@linux.intel.com,
	david.e.box@linux.intel.com,
	ilpo.jarvinen@linux.intel.com,
	bhelgaas@google.com,
	rjw@rjwysocki.net
Cc: tasev.stefanoska@skynet.be,
	enriquezmark36@gmail.com,
	kernel@witt.link,
	wse@tuxedocomputers.com,
	vidyas@nvidia.com,
	kai.heng.feng@canonical.com,
	sathyanarayanan.kuppuswamy@linux.intel.com,
	ricky_wu@realtek.com,
	mario.limonciello@amd.com,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 5/5] PCI: Save and restore LTR state from pci_save/restore_pcie_state()
Date: Sun, 28 Jan 2024 15:32:12 -0800
Message-Id: <20240128233212.1139663-6-david.e.box@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240128233212.1139663-1-david.e.box@linux.intel.com>
References: <20240128233212.1139663-1-david.e.box@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ASPM state is saved and restored from pci_save/restore_pcie_state().
Since the LTR Capability is linked with ASPM, move the LTR save and
restore calls there as well.

Suggested-by: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: David E. Box <david.e.box@linux.intel.com>
---
 drivers/pci/pci.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 61e56e040510..78c3c9d82b3b 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -1561,6 +1561,7 @@ static int pci_save_pcie_state(struct pci_dev *dev)
 	pcie_capability_read_word(dev, PCI_EXP_SLTCTL2, &cap[i++]);
 
 	pci_save_aspm_state(dev);
+	pci_save_ltr_state(dev);
 
 	return 0;
 }
@@ -1571,6 +1572,12 @@ static void pci_restore_pcie_state(struct pci_dev *dev)
 	struct pci_cap_saved_state *save_state;
 	u16 *cap, val;
 
+	/*
+	 * Restore max latencies (in the LTR capability) before enabling
+	 * LTR itself (in the PCIe capability).
+	 */
+	pci_restore_ltr_state(dev);
+
 	save_state = pci_find_saved_cap(dev, PCI_CAP_ID_EXP);
 	if (!save_state)
 		return;
@@ -1660,7 +1667,6 @@ int pci_save_state(struct pci_dev *dev)
 	if (i != 0)
 		return i;
 
-	pci_save_ltr_state(dev);
 	pci_save_dpc_state(dev);
 	pci_save_aer_state(dev);
 	pci_save_ptm_state(dev);
@@ -1761,12 +1767,6 @@ void pci_restore_state(struct pci_dev *dev)
 	if (!dev->state_saved)
 		return;
 
-	/*
-	 * Restore max latencies (in the LTR capability) before enabling
-	 * LTR itself (in the PCIe capability).
-	 */
-	pci_restore_ltr_state(dev);
-
 	pci_restore_pcie_state(dev);
 	pci_restore_pasid_state(dev);
 	pci_restore_pri_state(dev);
-- 
2.34.1


