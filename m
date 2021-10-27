Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE8A243C4D3
	for <lists+linux-pci@lfdr.de>; Wed, 27 Oct 2021 10:13:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237017AbhJ0IQH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 27 Oct 2021 04:16:07 -0400
Received: from out30-43.freemail.mail.aliyun.com ([115.124.30.43]:58897 "EHLO
        out30-43.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240856AbhJ0IPr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 27 Oct 2021 04:15:47 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R691e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=xuesong.chen@linux.alibaba.com;NM=1;PH=DS;RN=16;SR=0;TI=SMTPD_---0UtrwnYO_1635322399;
Received: from localhost.localdomain(mailfrom:xuesong.chen@linux.alibaba.com fp:SMTPD_---0UtrwnYO_1635322399)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 27 Oct 2021 16:13:20 +0800
From:   Xuesong Chen <xuesong.chen@linux.alibaba.com>
To:     helgaas@kernel.org
Cc:     catalin.marinas@arm.com, lorenzo.pieralisi@arm.com,
        james.morse@arm.com, will@kernel.org, rafael@kernel.org,
        tony.luck@intel.com, bp@alien8.de, mingo@kernel.org,
        bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, xuesong.chen@linux.alibaba.com
Subject: [PATCH v4 3/4] ACPI: APEI: Reserve the MCFG address for quirk ECAM implementation
Date:   Wed, 27 Oct 2021 16:13:12 +0800
Message-Id: <20211027081312.53682-1-xuesong.chen@linux.alibaba.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20211027081035.53370-1-xuesong.chen@linux.alibaba.com>
References: <20211027081035.53370-1-xuesong.chen@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On some platforms, the hardware ECAM implementiation is not generic
as expected, which will make the PCI configuration access atomic
primitive lost. In this case, we need to reserve those quirk MCFG
address regions when filtering the normal MCFG resource to make sure
the mutual exclusion still works between the MCFG configuration
access and EINJ's operation.

Signed-off-by: Xuesong Chen <xuesong.chen@linux.alibaba.com>
---
 drivers/acpi/apei/apei-base.c | 25 ++++++++++++++++++++++++-
 drivers/acpi/pci_mcfg.c       |  8 ++++++++
 drivers/pci/quirks.c          |  2 ++
 include/linux/pci.h           |  1 +
 4 files changed, 35 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/apei/apei-base.c b/drivers/acpi/apei/apei-base.c
index daae75a..4f7311a 100644
--- a/drivers/acpi/apei/apei-base.c
+++ b/drivers/acpi/apei/apei-base.c
@@ -450,6 +450,23 @@ static int apei_get_nvs_resources(struct apei_resources *resources)
 }
 
 #ifdef CONFIG_PCI
+int remove_quirk_mcfg_res(struct apei_resources *mcfg_res)
+{
+#ifdef CONFIG_PCI_QUIRKS
+	int rc = 0;
+	struct apei_resources quirk_res;
+
+	apei_resources_init(&quirk_res);
+	rc = apei_res_add(&quirk_res.iomem, pci_quirk_mcfg_res.start,
+		resource_size(&pci_quirk_mcfg_res));
+	if (rc)
+		return rc;
+
+	return apei_resources_sub(mcfg_res, &quirk_res);
+#else
+	return 0;
+#endif
+}
 extern struct list_head pci_mmcfg_list;
 static int apei_filter_mcfg_addr(struct apei_resources *res,
 			struct apei_resources *mcfg_res)
@@ -462,11 +479,17 @@ static int apei_filter_mcfg_addr(struct apei_resources *res,
 
 	apei_resources_init(mcfg_res);
 	list_for_each_entry(cfg, &pci_mmcfg_list, list) {
-		rc = apei_res_add(&mcfg_res->iomem, cfg->res.start, resource_size(&cfg->res));
+		rc = apei_res_add(&mcfg_res->iomem, cfg->res.start,
+				resource_size(&cfg->res));
 		if (rc)
 			return rc;
 	}
 
+	/* remove the pci quirk mcfg resource if any from the mcfg_res */
+	rc = remove_quirk_mcfg_res(mcfg_res);
+	if (rc)
+		return rc;
+
 	/* filter the mcfg resource from current APEI's */
 	return apei_resources_sub(res, mcfg_res);
 }
diff --git a/drivers/acpi/pci_mcfg.c b/drivers/acpi/pci_mcfg.c
index 6ce467f..b5ab866 100644
--- a/drivers/acpi/pci_mcfg.c
+++ b/drivers/acpi/pci_mcfg.c
@@ -26,6 +26,8 @@ struct mcfg_fixup {
 	struct resource cfgres;
 };
 
+static bool pci_quirk_matched;
+
 #define MCFG_BUS_RANGE(start, end)	DEFINE_RES_NAMED((start),	\
 						((end) - (start) + 1),	\
 						NULL, IORESOURCE_BUS)
@@ -195,6 +197,7 @@ static void pci_mcfg_apply_quirks(struct acpi_pci_root *root,
 
 	for (i = 0, f = mcfg_quirks; i < ARRAY_SIZE(mcfg_quirks); i++, f++) {
 		if (pci_mcfg_quirk_matches(f, segment, bus_range)) {
+			pci_quirk_matched = true;
 			if (f->cfgres.start)
 				*cfgres = f->cfgres;
 			if (f->ops)
@@ -251,6 +254,11 @@ int pci_mcfg_lookup(struct acpi_pci_root *root, struct resource *cfgres,
 
 	*cfgres = res;
 	*ecam_ops = ops;
+#ifdef CONFIG_PCI_QUIRKS
+	if (pci_quirk_matched)
+		pci_quirk_mcfg_res = res;
+#endif
+
 	return 0;
 }
 
diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index f284ab4..bf64232 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -32,6 +32,8 @@
 #include <asm/dma.h>	/* isa_dma_bridge_buggy */
 #include "pci.h"
 
+struct resource pci_quirk_mcfg_res;
+
 static ktime_t fixup_debug_start(struct pci_dev *dev,
 				 void (*fn)(struct pci_dev *dev))
 {
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 34b0cbb..10d2c17 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -2103,6 +2103,7 @@ enum pci_fixup_pass {
 		suspend_late##hook, vendor, device, PCI_ANY_ID, 0, hook)
 
 #ifdef CONFIG_PCI_QUIRKS
+extern struct resource pci_quirk_mcfg_res;
 void pci_fixup_device(enum pci_fixup_pass pass, struct pci_dev *dev);
 #else
 static inline void pci_fixup_device(enum pci_fixup_pass pass,
-- 
1.8.3.1

