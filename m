Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3650B47D791
	for <lists+linux-pci@lfdr.de>; Wed, 22 Dec 2021 20:21:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345162AbhLVTVg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 22 Dec 2021 14:21:36 -0500
Received: from mga09.intel.com ([134.134.136.24]:27347 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1345143AbhLVTVf (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 22 Dec 2021 14:21:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640200895; x=1671736895;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Ie5kqnOr5yj7JVgrXETxahQe7HTBvMNTAOfAnlloruU=;
  b=Sk9/QnYl+zriSUAGp7wFxtNYkVHYoHy7TasYnnSP+y9zGW4r9SkKpzfr
   Vvgg2E0vMimcu0kSqOlEbhY9+E0VQ1/SYHvZFMSyuGoMRH8uLljvP9pha
   n8w+foOLz4Y/h63yORN+iDY9NAGP2ZnUfFocXhPLIliVUeUAy5ALJpXdf
   NnV655cTr/0bQG8I+FpRnbirALL7DiynndOema3YkjfB1nbKd1Kc7ayNq
   ealUXFmg9df3sqDmsOIBkFS9J2o2+W+yLXPlzPSNFLi/34P4TgxUL/67J
   oQoSyMi0FlCUwavMbRqmQIQUnl/fVtJSwvM4MHaLheJDtvLLzpsoAWc/M
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10206"; a="240499602"
X-IronPort-AV: E=Sophos;i="5.88,227,1635231600"; 
   d="scan'208";a="240499602"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2021 11:21:35 -0800
X-IronPort-AV: E=Sophos;i="5.88,227,1635231600"; 
   d="scan'208";a="521801932"
Received: from lmaniak-dev.igk.intel.com ([10.55.249.72])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2021 11:21:33 -0800
From:   Lukasz Maniak <lukasz.maniak@linux.intel.com>
To:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Lukasz Maniak <lukasz.maniak@linux.intel.com>,
        =?UTF-8?q?=C5=81ukasz=20Gieryk?= <lukasz.gieryk@linux.intel.com>
Subject: [PATCH] PCI: Reset IOV state on FLR to PF
Date:   Wed, 22 Dec 2021 20:19:57 +0100
Message-Id: <20211222191958.955681-1-lukasz.maniak@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

As per PCI Express specification, FLR to a PF resets the PF state as
well as the SR-IOV extended capability including VF Enable which means
that VFs no longer exist.

Currently, the IOV state is not updated during FLR, resulting in
non-compliant PCI driver behavior.

This patch introduces a simple function, called on the FLR path, that
removes the virtual function devices from the PCI bus and their
corresponding sysfs links with a final clear of the num_vfs value in IOV
state.

Signed-off-by: Lukasz Maniak <lukasz.maniak@linux.intel.com>
---
 drivers/pci/iov.c | 21 +++++++++++++++++++++
 drivers/pci/pci.c |  2 ++
 drivers/pci/pci.h |  4 ++++
 3 files changed, 27 insertions(+)

diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
index 0267977c9f17..69ee321027b4 100644
--- a/drivers/pci/iov.c
+++ b/drivers/pci/iov.c
@@ -1013,6 +1013,27 @@ int pci_iov_bus_range(struct pci_bus *bus)
 	return max ? max - bus->number : 0;
 }
 
+/**
+ * pci_reset_iov_state - reset the state of the IOV capability
+ * @dev: the PCI device
+ */
+void pci_reset_iov_state(struct pci_dev *dev)
+{
+	struct pci_sriov *iov = dev->sriov;
+
+	if (!dev->is_physfn)
+		return;
+	if (!iov->num_VFs)
+		return;
+
+	sriov_del_vfs(dev);
+
+	if (iov->link != dev->devfn)
+		sysfs_remove_link(&dev->dev.kobj, "dep_link");
+
+	iov->num_VFs = 0;
+}
+
 /**
  * pci_enable_sriov - enable the SR-IOV capability
  * @dev: the PCI device
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 3d2fb394986a..535f19d37e8d 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -4694,6 +4694,8 @@ EXPORT_SYMBOL(pci_wait_for_pending_transaction);
  */
 int pcie_flr(struct pci_dev *dev)
 {
+	pci_reset_iov_state(dev);
+
 	if (!pci_wait_for_pending_transaction(dev))
 		pci_err(dev, "timed out waiting for pending transaction; performing function level reset anyway\n");
 
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 3d60cabde1a1..7bb144fbec76 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -480,6 +480,7 @@ void pci_iov_update_resource(struct pci_dev *dev, int resno);
 resource_size_t pci_sriov_resource_alignment(struct pci_dev *dev, int resno);
 void pci_restore_iov_state(struct pci_dev *dev);
 int pci_iov_bus_range(struct pci_bus *bus);
+void pci_reset_iov_state(struct pci_dev *dev);
 extern const struct attribute_group sriov_pf_dev_attr_group;
 extern const struct attribute_group sriov_vf_dev_attr_group;
 #else
@@ -501,6 +502,9 @@ static inline int pci_iov_bus_range(struct pci_bus *bus)
 {
 	return 0;
 }
+static inline void pci_reset_iov_state(struct pci_dev *dev)
+{
+}
 
 #endif /* CONFIG_PCI_IOV */
 

base-commit: fa55b7dcdc43c1aa1ba12bca9d2dd4318c2a0dbf
-- 
2.25.1

