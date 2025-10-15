Return-Path: <linux-pci+bounces-38165-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 211E3BDD49D
	for <lists+linux-pci@lfdr.de>; Wed, 15 Oct 2025 10:03:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 834674FC865
	for <lists+linux-pci@lfdr.de>; Wed, 15 Oct 2025 08:02:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D293A2C21F7;
	Wed, 15 Oct 2025 08:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Lu6iHtgg"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 204832BEFF0;
	Wed, 15 Oct 2025 08:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760515354; cv=none; b=DK4WNwxlAdaKJYlRYfMIHWp1KNgvICa4mXqd5ckbrEIlliWdTPk+4l5DfkQbzUI2ja1R50ePFNx28u+8tG1nnVtdHpzc3QkZwsoxSoy/NQ6yqbhIDKc4g4e/f9kYdCGV8DpLYrq4m2lC73fR5E7RqtxF5hFOylSnQurGsx/KTn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760515354; c=relaxed/simple;
	bh=F8QIm+Tz/bXp76dVeUk9ZhzzgidkpKI7fQUxteIFSbM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rGqptw+3HhsSXdbzXJW6RFHif6mDXhWlN+nHAXiTUZ1P0SyTiSUUN2wBJA8Jg528lvXhDtabn11yC8Q//nCS4C8R+bIYYVa1AIT+FdUoEqlBM8aN/ks46zg6HLaDEA6SuprmhUY4+52w2E0jqTENDd9v9YiN5Q3Xq2nBYtUVlMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Lu6iHtgg; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760515353; x=1792051353;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=F8QIm+Tz/bXp76dVeUk9ZhzzgidkpKI7fQUxteIFSbM=;
  b=Lu6iHtgg0OZ/s4bnZ8jowDpgn9QQ/fg4ISFdk4cnI/zSeRmuNcgEllUP
   wjg5h2TsB3KhMjIqTKqD6Wjfokow8scwM1eBy8+DQVwConcTiDNtfmQqC
   ZRAus04pXvpyP9gLf+7Jnjsa6bpYwsEnfrJ447s0AzUtR2v7UBqfE3igk
   7nWSYOTi9aE65dmo8qBoW0/LUdFrBKK/zRa8zhXw7UboJ0DaMvf87JPlp
   niD1omgU38Xv4XwW2VTMfK1F+UjQFzRRCvoeu9irXMY9ouRLRjiiM4Cdw
   A/KM5/MRrgLCznPONVggx2FkxbOrb8RLGlRHSkw8oL0RXdnjKSgiEyxJn
   g==;
X-CSE-ConnectionGUID: sF4X4lcxQ/KGqBaw/NG0nQ==
X-CSE-MsgGUID: ++DVSMYWQxWLbBh7rIfAig==
X-IronPort-AV: E=McAfee;i="6800,10657,11582"; a="61891454"
X-IronPort-AV: E=Sophos;i="6.19,230,1754982000"; 
   d="scan'208";a="61891454"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2025 01:02:33 -0700
X-CSE-ConnectionGUID: RrMR87dTRouOL+SYm0MvCg==
X-CSE-MsgGUID: x6ag2MihQkesF6EYyFnKFQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,230,1754982000"; 
   d="scan'208";a="205805360"
Received: from bnilawar-desk2.iind.intel.com ([10.190.239.41])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2025 01:02:29 -0700
From: Badal Nilawar <badal.nilawar@intel.com>
To: intel-xe@lists.freedesktop.org,
	linux-acpi@vger.kernel.org,
	linux-pci@vger.kernel.org
Cc: anshuman.gupta@intel.com,
	rafael@kernel.org,
	lenb@kernel.org,
	bhelgaas@google.com,
	ilpo.jarvinen@linux.intel.com,
	lucas.demarchi@intel.com,
	rodrigo.vivi@intel.com,
	varun.gupta@intel.com,
	ville.syrjala@linux.intel.com,
	uma.shankar@intel.com,
	karthik.poosa@intel.com
Subject: [PATCH v5 02/12] PCI/ACPI: Per Root/Switch Downstream Port allow one aux power limit request
Date: Wed, 15 Oct 2025 13:37:00 +0530
Message-Id: <20251015080710.1468409-3-badal.nilawar@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251015080710.1468409-1-badal.nilawar@intel.com>
References: <20251015080710.1468409-1-badal.nilawar@intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Since aggregation of auxiliary power across multiple devices under a
Root or Switch Downstream Port is not supported, allow only one device
is to request auxiliary power

Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Cc: Anshuman Gupta <anshuman.gupta@intel.com>
Signed-off-by: Badal Nilawar <badal.nilawar@intel.com>
---
V1:
 - Use guard(mutex) for new mutex (Rafael)
 - Add mutex_detroy (Ilpo Järvinen)
 - %s/pci_warn/pci_info/ for -EAGAIN
 - Allow the same device to re-request auxiliary power if it has already been granted
---
 drivers/acpi/scan.c     |  3 +++
 drivers/pci/pci-acpi.c  | 22 ++++++++++++++++++++++
 include/acpi/acpi_bus.h |  3 +++
 3 files changed, 28 insertions(+)

diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index ef16d58b2949..4573fb0f4f3e 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -518,6 +518,7 @@ static void acpi_device_release(struct device *dev)
 	acpi_free_properties(acpi_dev);
 	acpi_free_pnp_ids(&acpi_dev->pnp);
 	acpi_free_power_resources_lists(acpi_dev);
+	mutex_destroy(&acpi_dev->power.aux_pwr_lock);
 	kfree(acpi_dev);
 }
 
@@ -746,6 +747,8 @@ int acpi_device_add(struct acpi_device *device)
 	INIT_LIST_HEAD(&device->physical_node_list);
 	INIT_LIST_HEAD(&device->del_list);
 	mutex_init(&device->physical_node_lock);
+	mutex_init(&device->power.aux_pwr_lock);
+	device->power.dev = NULL;
 
 	mutex_lock(&acpi_device_lock);
 
diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
index c7eab1e75dd5..74f118016b1d 100644
--- a/drivers/pci/pci-acpi.c
+++ b/drivers/pci/pci-acpi.c
@@ -1477,6 +1477,7 @@ int pci_acpi_request_d3cold_aux_power(struct pci_dev *dev, u32 requested_mw,
 	union acpi_object *out_obj;
 	int result, ret = -EINVAL;
 	struct pci_dev *bdev;
+	struct acpi_device *adev;
 
 	if (!dev || PCI_FUNC(dev->devfn) != 0)
 		return -EINVAL;
@@ -1486,6 +1487,19 @@ int pci_acpi_request_d3cold_aux_power(struct pci_dev *dev, u32 requested_mw,
 	if (IS_ERR(bdev))
 		return PTR_ERR(bdev);
 
+	adev = ACPI_COMPANION(&bdev->dev);
+	if (!adev)
+		return -EINVAL;
+
+	guard(mutex)(&adev->power.aux_pwr_lock);
+
+	/* Check if aux power already granted to different device */
+	if (adev->power.dev && adev->power.dev != &dev->dev) {
+		pci_info(to_pci_dev(adev->power.dev), "D3cold Aux Power request already granted: %u mW\n",
+			 adev->power.aux_power_limit);
+		return -EPERM;
+	}
+
 	out_obj = acpi_evaluate_dsm_typed(ACPI_HANDLE(&bdev->dev),
 					  &pci_acpi_dsm_guid, 4,
 					  DSM_PCI_D3COLD_AUX_POWER_LIMIT,
@@ -1501,14 +1515,20 @@ int pci_acpi_request_d3cold_aux_power(struct pci_dev *dev, u32 requested_mw,
 	case AUX_PWR_REQ_DENIED:
 		pci_dbg(bdev, "D3cold Aux Power %u mW request denied\n",
 			requested_mw);
+		adev->power.aux_power_limit = 0;
+		adev->power.dev = NULL;
 		break;
 	case AUX_PWR_REQ_GRANTED:
 		pci_info(bdev, "D3cold Aux Power request granted: %u mW\n",
 			 requested_mw);
+		adev->power.aux_power_limit = requested_mw;
+		adev->power.dev = &dev->dev;
 		ret = 0;
 		break;
 	case AUX_PWR_REQ_NO_MAIN_PWR_REMOVAL:
 		pci_info(bdev, "D3cold Aux Power: Main power won't be removed\n");
+		adev->power.aux_power_limit = 0;
+		adev->power.dev = NULL;
 		ret = -EBUSY;
 		break;
 	default:
@@ -1524,6 +1544,8 @@ int pci_acpi_request_d3cold_aux_power(struct pci_dev *dev, u32 requested_mw,
 			pci_err(bdev, "D3cold Aux Power: Reserved or unsupported response: 0x%x\n",
 				result);
 		}
+		adev->power.aux_power_limit = 0;
+		adev->power.dev = NULL;
 		break;
 	}
 
diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
index aad1a95e6863..cfa0c7233f13 100644
--- a/include/acpi/acpi_bus.h
+++ b/include/acpi/acpi_bus.h
@@ -294,6 +294,9 @@ struct acpi_device_power {
 	struct acpi_device_power_flags flags;
 	struct acpi_device_power_state states[ACPI_D_STATE_COUNT];	/* Power states (D0-D3Cold) */
 	u8 state_for_enumeration; /* Deepest power state for enumeration */
+	u32 aux_power_limit;		/* aux power limit granted by platform firmware */
+	struct device *dev;		/* device to which aux power is granted */
+	struct mutex aux_pwr_lock;	/* prevent concurrent aux power limit requests */
 };
 
 struct acpi_dep_data {
-- 
2.34.1


