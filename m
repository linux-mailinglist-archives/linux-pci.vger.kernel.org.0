Return-Path: <linux-pci+bounces-40311-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CE800C33E63
	for <lists+linux-pci@lfdr.de>; Wed, 05 Nov 2025 05:01:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 556D834AF9F
	for <lists+linux-pci@lfdr.de>; Wed,  5 Nov 2025 04:01:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61FC62066F7;
	Wed,  5 Nov 2025 04:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aC6xqfeg"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62F8C212FAA
	for <linux-pci@vger.kernel.org>; Wed,  5 Nov 2025 04:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762315260; cv=none; b=TgZEfTDpU+mNk9IEzcHdA2tkDblaOaEGFATzu/duyK+Ab/vWAmHLO2m+ESn+NmFLRyYygBwHE6xtwXjvvlguzFkrCX0iGddekCoSctXl9VPXGH1x5oUmT3jEZG0PYN8I0ehFXH/mpmWBoDeFnbBT015fF2P+S6/v55cuvmhM+YQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762315260; c=relaxed/simple;
	bh=qCQcdSlCH649eUcZK8ZKtiDtoC4NqKBCm6RYFu1zfLA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FpOE7qm47BuLJP7GF3x3+gJYIYOeG6bEpbJxHxsc/+rQgHhDJmz5gfyoev+lP+SnneSOyQY6iLFQfdUDCcdOX+/Ubgm13T7CGHTrbUQ1xuovjVgo7gJ86NEJsPZf4fgCkGEJ2pVPALedWCuG39zS++6K3dhD/Z1VNmIyCD9UzrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aC6xqfeg; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762315258; x=1793851258;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qCQcdSlCH649eUcZK8ZKtiDtoC4NqKBCm6RYFu1zfLA=;
  b=aC6xqfeg3pQ+XHsq07t0/Saxgy34e7AnIU8RjWeE84FihM5HdJ/9we+S
   J2XoBTGdKRgRzv5Stcm/memdx9/4NMPBgbJzcGLbaQf6+d7PyEkCKCdmZ
   lLMODW84bhqqEvS+coKd4JTNeOzFcdweh8UEIof/VHLb+OKQAWHEg+hOg
   KcAjRw0PBhq/4vdRUtau0goVNVfO6mqiGUq49f4V+fEuWASYuK5a4YdoE
   BpjD3VoujCH+3zUnrVu+nSOFY56u74eQkrTsLKGjQ/oNhcHaXy5Nq/TjS
   BZh26KBtaNY0meZ7SnPxG5xqX+ZufXy7mUVluqcWPgiXiAUQI8RGoyxr9
   g==;
X-CSE-ConnectionGUID: IZOXZawxQFiuAUIuq2gtQg==
X-CSE-MsgGUID: PgbDYQwrSzikrrHwJ10VUg==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="64328838"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="64328838"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2025 20:00:53 -0800
X-CSE-ConnectionGUID: nZ3xS4AKRESZGXod30TEKg==
X-CSE-MsgGUID: 3x5hRsd4S7yK+mMbnWV/eQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,280,1754982000"; 
   d="scan'208";a="224588549"
Received: from dwillia2-desk.jf.intel.com ([10.88.27.145])
  by orviesa001.jf.intel.com with ESMTP; 04 Nov 2025 20:00:53 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: linux-pci@vger.kernel.org
Cc: linux-coco@lists.linux.dev,
	bhelgaas@google.com,
	aneesh.kumar@kernel.org,
	yilun.xu@linux.intel.com,
	aik@amd.com,
	Lukas Wunner <lukas@wunner.de>,
	Samuel Ortiz <sameo@rivosinc.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: [PATCH 6/6] PCI/TSM: Add 'dsm' and 'bound' attributes for dependent functions
Date: Tue,  4 Nov 2025 20:00:55 -0800
Message-ID: <20251105040055.2832866-7-dan.j.williams@intel.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251105040055.2832866-1-dan.j.williams@intel.com>
References: <20251105040055.2832866-1-dan.j.williams@intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

PCI/TSM sysfs for physical function 0 devices, i.e. the "DSM" (Device
Security Manager), contains the 'connect' and 'disconnect' attributes.
After a successful 'connect' operation the DSM, its dependent functions
(SR-IOV virtual functions, non-zero multi-functions, or downstream
endpoints of a switch DSM) are candidates for being transitioned into a
TDISP (TEE Device Interface Security Protocol) operational state, via
pci_tsm_bind(). At present sysfs is blind to which devices are capable of
TDISP operation and it is ambiguous which functions are serviced by which
DSMs.

Add a 'dsm' attribute to identify a function's DSM device, and add a
'bound' attribute to identify when a function has entered a TDISP
operational state.

Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Lukas Wunner <lukas@wunner.de>
Cc: Samuel Ortiz <sameo@rivosinc.com>
Cc: Alexey Kardashevskiy <aik@amd.com>
Cc: Xu Yilun <yilun.xu@linux.intel.com>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 Documentation/ABI/testing/sysfs-bus-pci |  30 ++++++
 drivers/pci/tsm.c                       | 130 ++++++++++++++++++++----
 2 files changed, 140 insertions(+), 20 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-pci b/Documentation/ABI/testing/sysfs-bus-pci
index 6ffe02f854d6..b767db2c52cb 100644
--- a/Documentation/ABI/testing/sysfs-bus-pci
+++ b/Documentation/ABI/testing/sysfs-bus-pci
@@ -655,6 +655,36 @@ Description:
 		(WO) Write the name of the TSM device that was specified
 		to 'connect' to teardown the connection.
 
+What:		/sys/bus/pci/devices/.../tsm/dsm
+Contact:	linux-coco@lists.linux.dev
+Description:	(RO) Return PCI device name of this device's DSM (Device
+		Security Manager). When a device is in the connected state it
+		indicates that the platform TSM (TEE Security Manager) has made
+		a secure-session connection with a device's DSM. A DSM is always
+		physical function 0 and when the device supports TDISP (TEE
+		Device Interface Security Protocol) its managed functions also
+		populate this tsm/dsm attribute. The managed functions of a DSM
+		are SR-IOV (Single Root I/O Virtualization) virtual functions,
+		non-zero functions of a multi-function device, or downstream
+		endpoints depending on whether the DSM is an SR-IOV physical
+		function, function0 of a multi-function device, or an upstream
+		PCIe switch port. This is a "link" TSM attribute, see
+		Documentation/ABI/testing/sysfs-class-tsm.
+
+What:		/sys/bus/pci/devices/.../tsm/bound
+Contact:	linux-coco@lists.linux.dev
+Description:	(RO) Return the device name of the TSM when the device is in a
+		TDISP (TEE Device Interface Security Protocol) operational state
+		(LOCKED, RUN, or ERROR, not UNLOCKED). Bound devices consume
+		platform TSM resources and depend on the device's configuration
+		(e.g. BME (Bus Master Enable) and MSE (Memory Space Enable)
+		among other settings) to remain stable for the duration of the
+		bound state. This attribute is only visible for devices that
+		support TDISP operation, and it is only populated after
+		successful connect and TSM bind. The TSM bind operation is
+		initiated by VFIO/IOMMUFD. This is a "link" TSM attribute, see
+		Documentation/ABI/testing/sysfs-class-tsm.
+
 What:		/sys/bus/pci/devices/.../authenticated
 Contact:	linux-pci@vger.kernel.org
 Description:
diff --git a/drivers/pci/tsm.c b/drivers/pci/tsm.c
index 4dd518b45eea..9abfdb2b2033 100644
--- a/drivers/pci/tsm.c
+++ b/drivers/pci/tsm.c
@@ -151,6 +151,25 @@ static void pci_tsm_walk_fns_reverse(struct pci_dev *pdev,
 	}
 }
 
+static void link_sysfs_disable(struct pci_dev *pdev)
+{
+	sysfs_update_group(&pdev->dev.kobj, &pci_tsm_auth_attr_group);
+	sysfs_update_group(&pdev->dev.kobj, &pci_tsm_attr_group);
+}
+
+static void link_sysfs_enable(struct pci_dev *pdev)
+{
+	bool tee = has_tee(pdev);
+
+	pci_dbg(pdev, "%s Security Manager detected (%s%s%s)\n",
+		pdev->tsm ? "Device" : "Platform TEE",
+		pdev->ide_cap ? "IDE" : "", pdev->ide_cap && tee ? " " : "",
+		tee ? "TEE" : "");
+
+	sysfs_update_group(&pdev->dev.kobj, &pci_tsm_auth_attr_group);
+	sysfs_update_group(&pdev->dev.kobj, &pci_tsm_attr_group);
+}
+
 static int probe_fn(struct pci_dev *pdev, void *dsm)
 {
 	struct pci_dev *dsm_dev = dsm;
@@ -159,6 +178,8 @@ static int probe_fn(struct pci_dev *pdev, void *dsm)
 	pdev->tsm = ops->probe(dsm_dev->tsm->tsm_dev, pdev);
 	pci_dbg(pdev, "setup TSM context: DSM: %s status: %s\n",
 		pci_name(dsm_dev), pdev->tsm ? "success" : "failed");
+	if (pdev->tsm)
+		link_sysfs_enable(pdev);
 	return 0;
 }
 
@@ -267,6 +288,7 @@ static DEVICE_ATTR_RW(connect);
 static int remove_fn(struct pci_dev *pdev, void *data)
 {
 	tsm_remove(pdev->tsm);
+	link_sysfs_disable(pdev);
 	return 0;
 }
 
@@ -472,12 +494,74 @@ static ssize_t disconnect_store(struct device *dev,
 }
 static DEVICE_ATTR_WO(disconnect);
 
+static ssize_t bound_show(struct device *dev,
+			  struct device_attribute *attr, char *buf)
+{
+	struct pci_dev *pdev = to_pci_dev(dev);
+	struct pci_tsm_pf0 *tsm_pf0;
+	struct pci_tsm *tsm;
+	int rc;
+
+	ACQUIRE(rwsem_read_intr, lock)(&pci_tsm_rwsem);
+	if ((rc = ACQUIRE_ERR(rwsem_read_intr, &lock)))
+		return rc;
+
+	tsm = pdev->tsm;
+	if (!tsm)
+		return sysfs_emit(buf, "\n");
+	tsm_pf0 = to_pci_tsm_pf0(tsm);
+
+	ACQUIRE(mutex_intr, ops_lock)(&tsm_pf0->lock);
+	if ((rc = ACQUIRE_ERR(mutex_intr, &ops_lock)))
+		return rc;
+
+	if (!tsm->tdi)
+		return sysfs_emit(buf, "\n");
+	return sysfs_emit(buf, "%s\n", dev_name(&tsm->tsm_dev->dev));
+}
+static DEVICE_ATTR_RO(bound);
+
+static ssize_t dsm_show(struct device *dev, struct device_attribute *attr,
+			char *buf)
+{
+	struct pci_dev *pdev = to_pci_dev(dev);
+	struct pci_tsm *tsm;
+	int rc;
+
+	ACQUIRE(rwsem_read_intr, lock)(&pci_tsm_rwsem);
+	if ((rc = ACQUIRE_ERR(rwsem_read_intr, &lock)))
+		return rc;
+
+	tsm = pdev->tsm;
+	if (!tsm)
+		return sysfs_emit(buf, "\n");
+
+	return sysfs_emit(buf, "%s\n", pci_name(tsm->dsm_dev));
+}
+static DEVICE_ATTR_RO(dsm);
+
 /* The 'authenticated' attribute is exclusive to the presence of a 'link' TSM */
 static bool pci_tsm_link_group_visible(struct kobject *kobj)
 {
 	struct pci_dev *pdev = to_pci_dev(kobj_to_dev(kobj));
 
-	return pci_tsm_link_count && is_pci_tsm_pf0(pdev);
+	if (!pci_tsm_link_count)
+		return false;
+
+	if (!pci_is_pcie(pdev))
+		return false;
+
+	if (is_pci_tsm_pf0(pdev))
+		return true;
+
+	/*
+	 * Show 'authenticated' and other attributes for the managed
+	 * sub-functions of a DSM.
+	 */
+	if (pdev->tsm)
+		return true;
+
+	return false;
 }
 DEFINE_SIMPLE_SYSFS_GROUP_VISIBLE(pci_tsm_link);
 
@@ -489,9 +573,27 @@ static umode_t pci_tsm_attr_visible(struct kobject *kobj,
 				    struct attribute *attr, int n)
 {
 	if (pci_tsm_link_group_visible(kobj)) {
+		struct pci_dev *pdev = to_pci_dev(kobj_to_dev(kobj));
+
+		if (attr == &dev_attr_bound.attr) {
+			if (is_pci_tsm_pf0(pdev) && has_tee(pdev))
+				return attr->mode;
+			if (pdev->tsm && has_tee(pdev->tsm->dsm_dev))
+				return attr->mode;
+		}
+
+		if (attr == &dev_attr_dsm.attr) {
+			if (is_pci_tsm_pf0(pdev))
+				return attr->mode;
+			if (pdev->tsm && has_tee(pdev->tsm->dsm_dev))
+				return attr->mode;
+		}
+
 		if (attr == &dev_attr_connect.attr ||
-		    attr == &dev_attr_disconnect.attr)
-			return attr->mode;
+		    attr == &dev_attr_disconnect.attr) {
+			if (is_pci_tsm_pf0(pdev))
+				return attr->mode;
+		}
 	}
 
 	return 0;
@@ -506,6 +608,8 @@ DEFINE_SYSFS_GROUP_VISIBLE(pci_tsm);
 static struct attribute *pci_tsm_attrs[] = {
 	&dev_attr_connect.attr,
 	&dev_attr_disconnect.attr,
+	&dev_attr_bound.attr,
+	&dev_attr_dsm.attr,
 	NULL
 };
 
@@ -661,18 +765,6 @@ void pci_tsm_pf0_destructor(struct pci_tsm_pf0 *pf0_tsm)
 }
 EXPORT_SYMBOL_GPL(pci_tsm_pf0_destructor);
 
-static void pf0_sysfs_enable(struct pci_dev *pdev)
-{
-	bool tee = has_tee(pdev);
-
-	pci_dbg(pdev, "Device Security Manager detected (%s%s%s)\n",
-		pdev->ide_cap ? "IDE" : "", pdev->ide_cap && tee ? " " : "",
-		tee ? "TEE" : "");
-
-	sysfs_update_group(&pdev->dev.kobj, &pci_tsm_auth_attr_group);
-	sysfs_update_group(&pdev->dev.kobj, &pci_tsm_attr_group);
-}
-
 int pci_tsm_register(struct tsm_dev *tsm_dev)
 {
 	struct pci_dev *pdev = NULL;
@@ -693,7 +785,7 @@ int pci_tsm_register(struct tsm_dev *tsm_dev)
 	if (is_link_tsm(tsm_dev) && pci_tsm_link_count++ == 0) {
 		for_each_pci_dev(pdev)
 			if (is_pci_tsm_pf0(pdev))
-				pf0_sysfs_enable(pdev);
+				link_sysfs_enable(pdev);
 	} else if (is_devsec_tsm(tsm_dev)) {
 		pci_tsm_devsec_count++;
 	}
@@ -727,10 +819,8 @@ static void __pci_tsm_destroy(struct pci_dev *pdev, struct tsm_dev *tsm_dev)
 	 * skipped if the device itself is being removed since sysfs goes away
 	 * naturally at that point
 	 */
-	if (is_link_tsm(tsm_dev) && is_pci_tsm_pf0(pdev) && !pci_tsm_link_count) {
-		sysfs_update_group(&pdev->dev.kobj, &pci_tsm_auth_attr_group);
-		sysfs_update_group(&pdev->dev.kobj, &pci_tsm_attr_group);
-	}
+	if (is_link_tsm(tsm_dev) && is_pci_tsm_pf0(pdev) && !pci_tsm_link_count)
+		link_sysfs_disable(pdev);
 
 	/* Nothing else to do if this device never attached to the departing TSM */
 	if (!tsm)
-- 
2.51.0


