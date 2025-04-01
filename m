Return-Path: <linux-pci+bounces-25081-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 90BEFA77F1C
	for <lists+linux-pci@lfdr.de>; Tue,  1 Apr 2025 17:36:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D1A28188F523
	for <lists+linux-pci@lfdr.de>; Tue,  1 Apr 2025 15:37:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CCDB20B208;
	Tue,  1 Apr 2025 15:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lgZ6RSJQ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6138820AF94;
	Tue,  1 Apr 2025 15:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743521798; cv=none; b=Vti0GUuz2USjy0FWz0OTUKY/OIei0hgmjvau2cTPh1I2OFXRrHrQLlqyfVFg/qddYMpwhpFAi9ftnm2TZ4FiUdfJcy1rmTXvMKBcrjDftaActjCdUlvwKhhBWOI4UuXb9SVtpQyRudtBYexEKQvoQ9/FDDLM37QcUwxZNEzYFVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743521798; c=relaxed/simple;
	bh=RGVfWksi97tOIwSsM8PfmoqSMtxWfhpbqylmDyrun3w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nHQMu8g9mZRSO38sFKJ3f07VWHEz5sQ6w/Lk/fBYWFEZp0ogVil5osArkMDynsqfyOLBW4BuROrloP2lfboaYOYm1WdCA1enyn3aRiPdwcRdzlmsi1bu72NHr5MkMgaIyIL6zOEeLuGAMowxq3cqOf1kPTsUx/2Wodu6uk3f/AA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lgZ6RSJQ; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743521798; x=1775057798;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=RGVfWksi97tOIwSsM8PfmoqSMtxWfhpbqylmDyrun3w=;
  b=lgZ6RSJQ6ATomRajMUmEsH+BRTYgiQiozH3X7TISykMAELXoyVOI4OoV
   qQxOj3RrurRAQDHBhI/dVc2EtvCr2+uSBZv+4wp2CQDx+i8Ff+OV1XlY5
   nSUIaqU1a91IiToDpVsVN4Nxtw4FVz2Cr2kVnpesuMeyyHkekY5j2rxPh
   SkYuX4bsjLA7XN7r9SXvWzakdhu85toSCorKQHui3pwPnMhl6zfwtPJDW
   3D+9kCGjgieGL/bVTxb/EwN8GP1FPlgZ1p92Sq9qBf2+uzasgntYqdNJX
   ufMAD3bso8iylszeGmnFmKnFq42yFexoTymFdv0kyZvZdx6pJ0uyt3/nb
   g==;
X-CSE-ConnectionGUID: /BBiJzPMSyWwpY6ua/v3bw==
X-CSE-MsgGUID: Sn2UrgixRdOYmw9eq7bPFQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11391"; a="67324935"
X-IronPort-AV: E=Sophos;i="6.14,293,1736841600"; 
   d="scan'208";a="67324935"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2025 08:36:35 -0700
X-CSE-ConnectionGUID: Adpi5qGPSbSthHKsEI0htw==
X-CSE-MsgGUID: RcDsk9/PTl2fNxN5ri5S9g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,293,1736841600"; 
   d="scan'208";a="126410967"
Received: from anshuma1-desk.iind.intel.com ([10.190.239.112])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2025 08:36:31 -0700
From: Anshuman Gupta <anshuman.gupta@intel.com>
To: intel-xe@lists.freedesktop.org,
	linux-acpi@vger.kernel.org,
	linux-pci@vger.kernel.org
Cc: rafael@kernel.org,
	lenb@kernel.org,
	bhelgaas@google.com,
	ilpo.jarvinen@linux.intel.com,
	lucas.demarchi@intel.com,
	rodrigo.vivi@intel.com,
	badal.nilawar@intel.com,
	anshuman.gupta@intel.com,
	varun.gupta@intel.com,
	ville.syrjala@linux.intel.com,
	uma.shankar@intel.com
Subject: [PATCH 08/12] drm/xe: Add PCIe ACPI Aux Power notifier
Date: Tue,  1 Apr 2025 21:02:21 +0530
Message-ID: <20250401153225.96379-9-anshuman.gupta@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250401153225.96379-1-anshuman.gupta@intel.com>
References: <20250401153225.96379-1-anshuman.gupta@intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Register PCIe ACPI notifier block and mark vrsr_capable
false in the notifier callback. This will ensure that
BMG GPU does not explode if any other PCIe child device
(under same Root Port) aux power request returns
with No main power removal.

Signed-off-by: Anshuman Gupta <anshuman.gupta@intel.com>
---
 drivers/gpu/drm/xe/xe_device_types.h |  3 ++
 drivers/gpu/drm/xe/xe_pm.c           | 41 ++++++++++++++++++++++++++++
 2 files changed, 44 insertions(+)

diff --git a/drivers/gpu/drm/xe/xe_device_types.h b/drivers/gpu/drm/xe/xe_device_types.h
index fd9dea207580..9aacd5af7d0f 100644
--- a/drivers/gpu/drm/xe/xe_device_types.h
+++ b/drivers/gpu/drm/xe/xe_device_types.h
@@ -517,6 +517,9 @@ struct xe_device {
 		struct mutex lock;
 	} d3cold;
 
+	/** @nb: PCI ACPI Aux power notifier */
+	struct notifier_block nb;
+
 	/** @pmt: Support the PMT driver callback interface */
 	struct {
 		/** @pmt.lock: protect access for telemetry data */
diff --git a/drivers/gpu/drm/xe/xe_pm.c b/drivers/gpu/drm/xe/xe_pm.c
index 364b937e0ded..ea93923d6671 100644
--- a/drivers/gpu/drm/xe/xe_pm.c
+++ b/drivers/gpu/drm/xe/xe_pm.c
@@ -87,6 +87,41 @@ static struct lockdep_map xe_pm_runtime_nod3cold_map = {
 };
 #endif
 
+static int aux_pwr_notifier(struct notifier_block *nb,
+			    unsigned long val, void *data)
+{
+	struct pci_dev *root_pdev = data;
+	struct pci_dev *pdev;
+	struct xe_device *xe;
+
+	xe = container_of(nb, struct xe_device, nb);
+
+	pdev = pcie_find_root_port(to_pci_dev(xe->drm.dev));
+	if (!pdev)
+		return -EINVAL;
+
+	if (root_pdev != pdev)
+		return 0;
+
+	xe_pm_runtime_get(xe);
+
+	if (val == ACPI_NO_MAIN_PW_REMOVAL) {
+		drm_err(&xe->drm, "PCIe core blocked the removal of Main Supply\n");
+		xe->d3cold.vrsr_capable = false;
+	}
+
+	xe_pm_runtime_put(xe);
+
+	return 0;
+}
+
+static void xe_pm_vrsr_fini(void *arg)
+{
+	struct xe_device *xe = arg;
+
+	pci_acpi_unregister_aux_power_notifier(&xe->nb);
+}
+
 /**
  * xe_rpm_reclaim_safe() - Whether runtime resume can be done from reclaim context
  * @xe: The xe device.
@@ -295,6 +330,12 @@ static int pci_acpi_aux_power_setup(struct xe_device *xe)
 		return ret;
 
 	ret = pci_acpi_add_perst_assertion_delay(root_pdev, perst_delay);
+	if (ret)
+		return ret;
+
+	xe->nb.notifier_call = aux_pwr_notifier;
+	pci_acpi_register_aux_power_notifier(&xe->nb);
+	devm_add_action_or_reset(xe->drm.dev, xe_pm_vrsr_fini, xe);
 
 	return ret;
 }
-- 
2.43.0


