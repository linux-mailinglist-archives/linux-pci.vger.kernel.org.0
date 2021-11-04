Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C2DF4451DF
	for <lists+linux-pci@lfdr.de>; Thu,  4 Nov 2021 11:59:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231254AbhKDLCb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 4 Nov 2021 07:02:31 -0400
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133]:55676 "EHLO
        out30-133.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231171AbhKDLCb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 4 Nov 2021 07:02:31 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=xuesong.chen@linux.alibaba.com;NM=1;PH=DS;RN=17;SR=0;TI=SMTPD_---0Uv1L71P_1636023590;
Received: from localhost.localdomain(mailfrom:xuesong.chen@linux.alibaba.com fp:SMTPD_---0Uv1L71P_1636023590)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 04 Nov 2021 18:59:51 +0800
From:   Xuesong Chen <xuesong.chen@linux.alibaba.com>
To:     helgaas@kernel.org
Cc:     catalin.marinas@arm.com, lorenzo.pieralisi@arm.com,
        james.morse@arm.com, will@kernel.org, rafael@kernel.org,
        tony.luck@intel.com, bp@alien8.de, mingo@kernel.org,
        bhelgaas@google.com, ying.huang@intel.com,
        linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        xuesong.chen@linux.alibaba.com
Subject: [PATCH v5 2/4] ACPI: APEI: Filter the PCI MCFG address with an arch-agnostic method
Date:   Thu,  4 Nov 2021 18:59:45 +0800
Message-Id: <20211104105945.47625-1-xuesong.chen@linux.alibaba.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20211104105715.47396-1-xuesong.chen@linux.alibaba.com>
References: <20211104105715.47396-1-xuesong.chen@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The commit d91525eb8ee6 ("ACPI, EINJ: Enhance error injection tolerance
level") fixes the issue that the ACPI/APEI can not access the PCI MCFG
address on x86 platform, but this issue can also happen on other
architectures, for instance, we got below error message on ARM64 platform:
...
APEI: Can not request [mem 0x50100000-0x50100003] for APEI EINJ Trigger registers
...

The above register range is within the MCFG area, because the PCI ECAM
can access the configuration space in an atomic way in case of the
hardware implementation of ECAM is correct, which means we don't need
a mutual exclusion for the EINJ action, thus we can remove this register
address region from the MCFG safely just like the x86 fix does.

Since all the MCFG resources have been saved into the pci_mmcfg_list
which is shared across different arches, thus we can filter the MCFG
resources from the APEI by apei_resources_sub(...) in a more common
arch-agnostic way, which will be beneficial to all the APEI-dependent
platforms after that.

Signed-off-by: Xuesong Chen <xuesong.chen@linux.alibaba.com>
---
 arch/x86/pci/mmconfig-shared.c | 28 --------------------------
 drivers/acpi/apei/apei-base.c  | 45 ++++++++++++++++++++++++++++--------------
 2 files changed, 30 insertions(+), 43 deletions(-)

diff --git a/arch/x86/pci/mmconfig-shared.c b/arch/x86/pci/mmconfig-shared.c
index 0b961fe6..12f7d96 100644
--- a/arch/x86/pci/mmconfig-shared.c
+++ b/arch/x86/pci/mmconfig-shared.c
@@ -605,32 +605,6 @@ static int __init pci_parse_mcfg(struct acpi_table_header *header)
 	return 0;
 }
 
-#ifdef CONFIG_ACPI_APEI
-extern int (*arch_apei_filter_addr)(int (*func)(__u64 start, __u64 size,
-				     void *data), void *data);
-
-static int pci_mmcfg_for_each_region(int (*func)(__u64 start, __u64 size,
-				     void *data), void *data)
-{
-	struct pci_mmcfg_region *cfg;
-	int rc;
-
-	if (list_empty(&pci_mmcfg_list))
-		return 0;
-
-	list_for_each_entry(cfg, &pci_mmcfg_list, list) {
-		rc = func(cfg->res.start, resource_size(&cfg->res), data);
-		if (rc)
-			return rc;
-	}
-
-	return 0;
-}
-#define set_apei_filter() (arch_apei_filter_addr = pci_mmcfg_for_each_region)
-#else
-#define set_apei_filter()
-#endif
-
 static void __init __pci_mmcfg_init(int early)
 {
 	pci_mmcfg_reject_broken(early);
@@ -665,8 +639,6 @@ void __init pci_mmcfg_early_init(void)
 		else
 			acpi_table_parse(ACPI_SIG_MCFG, pci_parse_mcfg);
 		__pci_mmcfg_init(1);
-
-		set_apei_filter();
 	}
 }
 
diff --git a/drivers/acpi/apei/apei-base.c b/drivers/acpi/apei/apei-base.c
index c7fdb12..daae75a 100644
--- a/drivers/acpi/apei/apei-base.c
+++ b/drivers/acpi/apei/apei-base.c
@@ -21,6 +21,7 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/init.h>
+#include <linux/pci.h>
 #include <linux/acpi.h>
 #include <linux/slab.h>
 #include <linux/io.h>
@@ -448,13 +449,34 @@ static int apei_get_nvs_resources(struct apei_resources *resources)
 	return acpi_nvs_for_each_region(apei_get_res_callback, resources);
 }
 
-int (*arch_apei_filter_addr)(int (*func)(__u64 start, __u64 size,
-				     void *data), void *data);
-static int apei_get_arch_resources(struct apei_resources *resources)
+#ifdef CONFIG_PCI
+extern struct list_head pci_mmcfg_list;
+static int apei_filter_mcfg_addr(struct apei_resources *res,
+			struct apei_resources *mcfg_res)
+{
+	int rc = 0;
+	struct pci_mmcfg_region *cfg;
+
+	if (list_empty(&pci_mmcfg_list))
+		return 0;
+
+	apei_resources_init(mcfg_res);
+	list_for_each_entry(cfg, &pci_mmcfg_list, list) {
+		rc = apei_res_add(&mcfg_res->iomem, cfg->res.start, resource_size(&cfg->res));
+		if (rc)
+			return rc;
+	}
 
+	/* filter the mcfg resource from current APEI's */
+	return apei_resources_sub(res, mcfg_res);
+}
+#else
+static inline int apei_filter_mcfg_addr(struct apei_resources *res,
+			struct apei_resources *mcfg_res)
 {
-	return arch_apei_filter_addr(apei_get_res_callback, resources);
+	return 0;
 }
+#endif
 
 /*
  * IO memory/port resource management mechanism is used to check
@@ -486,15 +508,9 @@ int apei_resources_request(struct apei_resources *resources,
 	if (rc)
 		goto nvs_res_fini;
 
-	if (arch_apei_filter_addr) {
-		apei_resources_init(&arch_res);
-		rc = apei_get_arch_resources(&arch_res);
-		if (rc)
-			goto arch_res_fini;
-		rc = apei_resources_sub(resources, &arch_res);
-		if (rc)
-			goto arch_res_fini;
-	}
+	rc = apei_filter_mcfg_addr(resources, &arch_res);
+	if (rc)
+		goto arch_res_fini;
 
 	rc = -EINVAL;
 	list_for_each_entry(res, &resources->iomem, list) {
@@ -544,8 +560,7 @@ int apei_resources_request(struct apei_resources *resources,
 		release_mem_region(res->start, res->end - res->start);
 	}
 arch_res_fini:
-	if (arch_apei_filter_addr)
-		apei_resources_fini(&arch_res);
+	apei_resources_fini(&arch_res);
 nvs_res_fini:
 	apei_resources_fini(&nvs_resources);
 	return rc;
-- 
2.9.5

