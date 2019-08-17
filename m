Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ADCBB90BB0
	for <lists+linux-pci@lfdr.de>; Sat, 17 Aug 2019 02:13:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726404AbfHQANp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 16 Aug 2019 20:13:45 -0400
Received: from mga05.intel.com ([192.55.52.43]:12918 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725911AbfHQANY (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 16 Aug 2019 20:13:24 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Aug 2019 17:13:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,395,1559545200"; 
   d="scan'208";a="168195006"
Received: from skuppusw-desk.jf.intel.com ([10.54.74.33])
  by orsmga007.jf.intel.com with ESMTP; 16 Aug 2019 17:13:22 -0700
From:   sathyanarayanan.kuppuswamy@linux.intel.com
To:     bhelgaas@google.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        ashok.raj@intel.com, keith.busch@intel.com,
        sathyanarayanan.kuppuswamy@linux.intel.com
Subject: [PATCH v6 4/8] PCI/IOV: Add pci_physfn_reslock/unlock() interfaces
Date:   Fri, 16 Aug 2019 17:10:18 -0700
Message-Id: <6763a208e1782d7e58d72d131b8faad5529b890a.1565997310.git.sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1565997310.git.sathyanarayanan.kuppuswamy@linux.intel.com>
References: <cover.1565997310.git.sathyanarayanan.kuppuswamy@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

As per PCIe spec r5.0, sec 9.3.7, in SR-IOV devices, capabilities like
PASID, PRI, VC, etc are shared between PF and its associated VFs. So, to
prevent race conditions between PF/VF while updating configuration
registers of these shared capabilities, a new synchronization mechanism
is required.

As a first step, create shared resource lock and expose expose
pci_physfn_reslock/unlock() API's. Users of these shared capabilities can
use these lock/unlock interfaces to synchronize its access.

Since the shared capability is always implemented by PF, reslock mutex
has been added to pci_sriov structure which only exists for PF.

NOTE: Currently this reslock is common for all shared capabilities
between PF/VF. In future, if any performance impact has been noticed, we
should create individual locks for each of the shared capability.

Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
---
 drivers/pci/iov.c |  1 +
 drivers/pci/pci.h | 40 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 41 insertions(+)

diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
index 525fd3f272b3..004e7076b065 100644
--- a/drivers/pci/iov.c
+++ b/drivers/pci/iov.c
@@ -507,6 +507,7 @@ static int sriov_init(struct pci_dev *dev, int pos)
 	else
 		iov->dev = dev;
 
+	mutex_init(&iov->reslock);
 	dev->sriov = iov;
 	dev->is_physfn = 1;
 	rc = compute_max_vf_buses(dev);
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index d22d1b807701..c7fa09f3389a 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -304,6 +304,19 @@ struct pci_sriov {
 	u16		subsystem_device; /* VF subsystem device */
 	resource_size_t	barsz[PCI_SRIOV_NUM_BARS];	/* VF BAR size */
 	bool		drivers_autoprobe; /* Auto probing of VFs by driver */
+	/*
+	 * reslock mutex is used for synchronizing updates to resources
+	 * shared between PF and all associated VFs. For example, in
+	 * SRIOV devices, PRI and PASID interfaces are shared between
+	 * PF an all VFs, and hence we need proper locking mechanism to
+	 * prevent both PF and VF update the PRI or PASID configuration
+	 * registers at the same time.
+	 * NOTE: Currently, this lock is shared by all capabilities that
+	 * has shared resource between PF and VFs. If there is any performance
+	 * impact then perhaps we need to create separate lock for each of
+	 * the independent capability that has shared resources.
+	 */
+	struct mutex	reslock;	/* PF/VF shared resource lock */
 };
 
 /**
@@ -433,6 +446,27 @@ void pci_iov_update_resource(struct pci_dev *dev, int resno);
 resource_size_t pci_sriov_resource_alignment(struct pci_dev *dev, int resno);
 void pci_restore_iov_state(struct pci_dev *dev);
 int pci_iov_bus_range(struct pci_bus *bus);
+static inline void pci_physfn_reslock(struct pci_dev *dev)
+{
+	struct pci_dev *pf = pci_physfn(dev);
+
+	/* For non SRIOV devices, locking is not needed */
+	if (!pf->is_physfn)
+		return;
+
+	mutex_lock(&pf->sriov->reslock);
+}
+
+static inline void pci_physfn_resunlock(struct pci_dev *dev)
+{
+	struct pci_dev *pf = pci_physfn(dev);
+
+	/* For non SRIOV devices, reslock is never held */
+	if (!pf->is_physfn)
+		return;
+
+	mutex_unlock(&pf->sriov->reslock);
+}
 
 #else
 static inline int pci_iov_init(struct pci_dev *dev)
@@ -453,6 +487,12 @@ static inline int pci_iov_bus_range(struct pci_bus *bus)
 {
 	return 0;
 }
+static inline void pci_physfn_reslock(struct pci_dev *dev)
+{
+}
+static inline void pci_physfn_resunlock(struct pci_dev *dev)
+{
+}
 
 #endif /* CONFIG_PCI_IOV */
 
-- 
2.21.0

