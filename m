Return-Path: <linux-pci+bounces-41044-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E7C5AC55665
	for <lists+linux-pci@lfdr.de>; Thu, 13 Nov 2025 03:14:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DDA244E2A6C
	for <lists+linux-pci@lfdr.de>; Thu, 13 Nov 2025 02:14:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B678C2DC798;
	Thu, 13 Nov 2025 02:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="n6zc+sOb"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA3702E2825
	for <linux-pci@vger.kernel.org>; Thu, 13 Nov 2025 02:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763000051; cv=none; b=EH5qME7P3WlaXSOMpHlKjy4AMTusuI35cjdN9AxvFnh4ci/9HmJNskII2s984hNavDRlPtHHfyTFC58veiAMdU64kgoTrFrudk2bNSGNrZ/yEIVV5gEgiACFL6lg904Pp5PJ3NI8v56okc6Jt7pZw6tSxyOfMRTgbln3k1JVxHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763000051; c=relaxed/simple;
	bh=eoliV8fU/eplTxYKatqS2XKVJOb0dwAI7L3fMCPMt/I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=vE20c7JXe8t3CHv8LFBFXjhr0PvymzVmlPLcqqSR9UWqTB8BrVOzpy9CG5uT8ke0lunlHDtOYyqmj+XqsbqupAuIf6lg4juWP+kqtwab8ykF7jCj00XB45QIiwoym3nuYkjDgviJMrCZdoPTfY9xoWg3LLcUkabe8TzovHHjxmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=n6zc+sOb; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763000051; x=1794536051;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=eoliV8fU/eplTxYKatqS2XKVJOb0dwAI7L3fMCPMt/I=;
  b=n6zc+sOb2Caqy11byWXy48sr8unEomMy66We2OmoVfoCGzWyFmcYvK5a
   q9UNFbbXsVAe5M0aUn8CLsSAQZdvUEG4TU2Kgv1dSXJBpOZz2nYJdYJ/3
   MDvqTneFJlRE0Mm7maNoIUy6k1Dw5fpV6J0xUN9fYy6xpLJykqB67B3Zc
   0lEKJJzsW9DRZiDV0pUVPUoeXvJ/s5C4n+qFdw4y6DVxOUqfY9n+S9klK
   7M9tfMqoaPvT7VXKb8UtoYShoX2Rb+t7uDiyt0hF6D/KBz2vqSBfm1mo3
   WmpYZ/KAEYZOadXLudDJj69BIpBnlK2VKxCxbjGLEDOtsiMauwBosGslb
   Q==;
X-CSE-ConnectionGUID: H6iV4CCGS+yAby+voxqvoQ==
X-CSE-MsgGUID: nSHbAJL0Qu6fVUexQ3TMqg==
X-IronPort-AV: E=McAfee;i="6800,10657,11611"; a="82471782"
X-IronPort-AV: E=Sophos;i="6.19,300,1754982000"; 
   d="scan'208";a="82471782"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2025 18:14:06 -0800
X-CSE-ConnectionGUID: OGuh9fgrS6inajp5MvC5xA==
X-CSE-MsgGUID: Cl6BZk5BQuW7CWLjz1vaBQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,300,1754982000"; 
   d="scan'208";a="189802507"
Received: from dwillia2-desk.jf.intel.com ([10.88.27.145])
  by fmviesa009.fm.intel.com with ESMTP; 12 Nov 2025 18:14:05 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: linux-pci@vger.kernel.org
Cc: linux-coco@lists.linux.dev,
	Jonathan.Cameron@huawei.com,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lukas Wunner <lukas@wunner.de>,
	Samuel Ortiz <sameo@rivosinc.com>,
	Alexey Kardashevskiy <aik@amd.com>,
	Xu Yilun <yilun.xu@linux.intel.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>
Subject: [PATCH v2 8/8] PCI/TSM: Add 'dsm' and 'bound' attributes for dependent functions
Date: Wed, 12 Nov 2025 18:14:46 -0800
Message-ID: <20251113021446.436830-9-dan.j.williams@intel.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251113021446.436830-1-dan.j.williams@intel.com>
References: <20251113021446.436830-1-dan.j.williams@intel.com>
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
index 5e57501f693e..5fdcd7f2e820 100644
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
 
@@ -468,12 +490,74 @@ static ssize_t disconnect_store(struct device *dev,
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
 
@@ -485,9 +569,27 @@ static umode_t pci_tsm_attr_visible(struct kobject *kobj,
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
@@ -502,6 +604,8 @@ DEFINE_SYSFS_GROUP_VISIBLE(pci_tsm);
 static struct attribute *pci_tsm_attrs[] = {
 	&dev_attr_connect.attr,
 	&dev_attr_disconnect.attr,
+	&dev_attr_bound.attr,
+	&dev_attr_dsm.attr,
 	NULL
 };
 
@@ -657,18 +761,6 @@ void pci_tsm_pf0_destructor(struct pci_tsm_pf0 *pf0_tsm)
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
@@ -689,7 +781,7 @@ int pci_tsm_register(struct tsm_dev *tsm_dev)
 	if (is_link_tsm(tsm_dev) && pci_tsm_link_count++ == 0) {
 		for_each_pci_dev(pdev)
 			if (is_pci_tsm_pf0(pdev))
-				pf0_sysfs_enable(pdev);
+				link_sysfs_enable(pdev);
 	} else if (is_devsec_tsm(tsm_dev)) {
 		pci_tsm_devsec_count++;
 	}
@@ -723,10 +815,8 @@ static void __pci_tsm_destroy(struct pci_dev *pdev, struct tsm_dev *tsm_dev)
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
2.51.1


