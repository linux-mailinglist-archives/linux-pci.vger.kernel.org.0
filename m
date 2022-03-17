Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDDA34DCB0F
	for <lists+linux-pci@lfdr.de>; Thu, 17 Mar 2022 17:17:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231443AbiCQQSe (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 17 Mar 2022 12:18:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229812AbiCQQSe (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 17 Mar 2022 12:18:34 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 91E122156CE;
        Thu, 17 Mar 2022 09:17:17 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 571631424;
        Thu, 17 Mar 2022 09:17:17 -0700 (PDT)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.1.196.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 24DC83F7B4;
        Thu, 17 Mar 2022 09:17:16 -0700 (PDT)
From:   Robin Murphy <robin.murphy@arm.com>
To:     andreas.noever@gmail.com, michael.jamet@intel.com,
        mika.westerberg@linux.intel.com, YehezkelShB@gmail.com
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        iommu@lists.linux-foundation.org, linux-pci@vger.kernel.org,
        mario.limonciello@amd.com
Subject: [PATCH] thunderbolt: Make iommu_dma_protection more accurate
Date:   Thu, 17 Mar 2022 16:17:07 +0000
Message-Id: <2d01fa50c2650c730b0244929097737918e302e7.1647533152.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.28.0.dirty
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Between me trying to get rid of iommu_present() and Mario wanting to
support the AMD equivalent of DMAR_PLATFORM_OPT_IN, scrutiny has shown
that the iommu_dma_protection attribute is being far too optimistic.
Even if an IOMMU might be present for some PCI segment in the system,
that doesn't necessarily mean it provides translation for the device(s)
we care about. Furthermore, all that DMAR_PLATFORM_OPT_IN really does
is tell us that memory was protected before the kernel was loaded, and
prevent the user from disabling the intel-iommu driver entirely. What
actually matters is whether we trust individual devices, based on the
"external facing" property that we expect firmware to describe for
Thunderbolt ports.

Avoid false positives by looking as close as possible to the same PCI
topology that the IOMMU layer will consider once a Thunderbolt endpoint
appears. Crucially, we can't assume that IOMMU translation being enabled
for any reason is sufficient on its own; full (expensive) DMA protection
will still only be imposed on untrusted devices.

CC: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---

This supersedes my previous attempt just trying to replace
iommu_present() at [1], further to the original discussion at [2].

[1] https://lore.kernel.org/linux-iommu/BL1PR12MB515799C0BE396377DBBEF055E2119@BL1PR12MB5157.namprd12.prod.outlook.com/T/
[2] https://lore.kernel.org/linux-iommu/202203160844.lKviWR1Q-lkp@intel.com/T/

 drivers/thunderbolt/domain.c | 12 +++---------
 drivers/thunderbolt/nhi.c    | 35 +++++++++++++++++++++++++++++++++++
 include/linux/thunderbolt.h  |  2 ++
 3 files changed, 40 insertions(+), 9 deletions(-)

diff --git a/drivers/thunderbolt/domain.c b/drivers/thunderbolt/domain.c
index 7018d959f775..d5c825e84ac8 100644
--- a/drivers/thunderbolt/domain.c
+++ b/drivers/thunderbolt/domain.c
@@ -7,9 +7,7 @@
  */
 
 #include <linux/device.h>
-#include <linux/dmar.h>
 #include <linux/idr.h>
-#include <linux/iommu.h>
 #include <linux/module.h>
 #include <linux/pm_runtime.h>
 #include <linux/slab.h>
@@ -257,13 +255,9 @@ static ssize_t iommu_dma_protection_show(struct device *dev,
 					 struct device_attribute *attr,
 					 char *buf)
 {
-	/*
-	 * Kernel DMA protection is a feature where Thunderbolt security is
-	 * handled natively using IOMMU. It is enabled when IOMMU is
-	 * enabled and ACPI DMAR table has DMAR_PLATFORM_OPT_IN set.
-	 */
-	return sprintf(buf, "%d\n",
-		       iommu_present(&pci_bus_type) && dmar_platform_optin());
+	struct tb *tb = container_of(dev, struct tb, dev);
+
+	return sprintf(buf, "%d\n", tb->nhi->iommu_dma_protection);
 }
 static DEVICE_ATTR_RO(iommu_dma_protection);
 
diff --git a/drivers/thunderbolt/nhi.c b/drivers/thunderbolt/nhi.c
index c73da0532be4..e12c2e266741 100644
--- a/drivers/thunderbolt/nhi.c
+++ b/drivers/thunderbolt/nhi.c
@@ -14,6 +14,7 @@
 #include <linux/errno.h>
 #include <linux/pci.h>
 #include <linux/interrupt.h>
+#include <linux/iommu.h>
 #include <linux/module.h>
 #include <linux/delay.h>
 #include <linux/property.h>
@@ -1102,6 +1103,39 @@ static void nhi_check_quirks(struct tb_nhi *nhi)
 		nhi->quirks |= QUIRK_AUTO_CLEAR_INT;
 }
 
+static void nhi_check_iommu(struct tb_nhi *nhi)
+{
+	struct pci_dev *pdev;
+	bool port_ok = false;
+
+	/*
+	 * Check for sibling devices that look like they should be our
+	 * tunnelled ports. We can reasonably assume that if an IOMMU is
+	 * managing the bridge it will manage any future devices beyond it
+	 * too. If firmware has described a port as external-facing as
+	 * expected then we can trust the IOMMU layer to enforce isolation;
+	 * otherwise even if translation is enabled for existing devices it
+	 * may potentially be overridden for a future tunnelled endpoint.
+	 */
+	for_each_pci_bridge(pdev, nhi->pdev->bus) {
+		if (!pci_is_pcie(pdev) ||
+		    !(pci_pcie_type(pdev) == PCI_EXP_TYPE_ROOT_PORT ||
+		      pci_pcie_type(pdev) == PCI_EXP_TYPE_DOWNSTREAM))
+			continue;
+
+		if (!device_iommu_mapped(&pdev->dev))
+			return;
+
+		if (!pdev->untrusted) {
+			dev_info(&nhi->pdev->dev,
+				 "Assuming unreliable Kernel DMA protection\n");
+			return;
+		}
+		port_ok = true;
+	}
+	nhi->iommu_dma_protection = port_ok;
+}
+
 static int nhi_init_msi(struct tb_nhi *nhi)
 {
 	struct pci_dev *pdev = nhi->pdev;
@@ -1219,6 +1253,7 @@ static int nhi_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 		return -ENOMEM;
 
 	nhi_check_quirks(nhi);
+	nhi_check_iommu(nhi);
 
 	res = nhi_init_msi(nhi);
 	if (res) {
diff --git a/include/linux/thunderbolt.h b/include/linux/thunderbolt.h
index 124e13cb1469..7a8ad984e651 100644
--- a/include/linux/thunderbolt.h
+++ b/include/linux/thunderbolt.h
@@ -465,6 +465,7 @@ static inline struct tb_xdomain *tb_service_parent(struct tb_service *svc)
  * @msix_ida: Used to allocate MSI-X vectors for rings
  * @going_away: The host controller device is about to disappear so when
  *		this flag is set, avoid touching the hardware anymore.
+ * @iommu_dma_protection: An IOMMU will isolate external-facing ports.
  * @interrupt_work: Work scheduled to handle ring interrupt when no
  *		    MSI-X is used.
  * @hop_count: Number of rings (end point hops) supported by NHI.
@@ -479,6 +480,7 @@ struct tb_nhi {
 	struct tb_ring **rx_rings;
 	struct ida msix_ida;
 	bool going_away;
+	bool iommu_dma_protection;
 	struct work_struct interrupt_work;
 	u32 hop_count;
 	unsigned long quirks;
-- 
2.28.0.dirty

