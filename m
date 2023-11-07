Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99E337E3C13
	for <lists+linux-pci@lfdr.de>; Tue,  7 Nov 2023 13:12:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234179AbjKGMMT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 7 Nov 2023 07:12:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234429AbjKGMLs (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 7 Nov 2023 07:11:48 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 346DE19BD;
        Tue,  7 Nov 2023 04:09:48 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5D43C433C9;
        Tue,  7 Nov 2023 12:09:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699358988;
        bh=oxL5q+LXqa/6GFIBeO17c/ibc8JlajUX3kY8hpeFTeY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fyUucl5GudI/RK99/s4VSeHFGoNQPD744fDd8rJFScAVW/8YtKU9LoZ5SWtXLP6zd
         A/d4DaN65wJilgzw4JTcYGooQ/X6kj+chN3GuEfK3WiozO7ZMzPQN4nIowefRQPPTg
         hoEWzDCF9fHh5mMbtYmN6OsEx8s8OrsjcqaNzSdOyAojqGmHQC4YUJwllzl9WwfqqO
         DTgojUQGc++qcaXXygseUo9qcq0SuEXaWQLG5/TyobWExir/+vdp0MPDeMlHD6C+KY
         PIOy7x6tavB5phbboaxznU1OnDxXlcrE0Y9S5naPEz7rKsMPcNSf29Q7Y4077JMXmq
         grnOLQFaVV87g==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Shiju Jose <shiju.jose@huawei.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Sasha Levin <sashal@kernel.org>, rafael@kernel.org,
        mahesh@linux.ibm.com, robert.moore@intel.com, pabeni@redhat.com,
        leoyang.li@nxp.com, tony.luck@intel.com, rostedt@goodmis.org,
        linmiaohe@huawei.com, linux-acpi@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
        acpica-devel@lists.linuxfoundation.org
Subject: [PATCH AUTOSEL 6.5 11/30] ACPI: APEI: Fix AER info corruption when error status data has multiple sections
Date:   Tue,  7 Nov 2023 07:08:26 -0500
Message-ID: <20231107120922.3757126-11-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231107120922.3757126-1-sashal@kernel.org>
References: <20231107120922.3757126-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.5.10
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Shiju Jose <shiju.jose@huawei.com>

[ Upstream commit e2abc47a5a1a9f641e7cacdca643fdd40729bf6e ]

ghes_handle_aer() passes AER data to the PCI core for logging and
recovery by calling aer_recover_queue() with a pointer to struct
aer_capability_regs.

The problem was that aer_recover_queue() queues the pointer directly
without copying the aer_capability_regs data.  The pointer was to
the ghes->estatus buffer, which could be reused before
aer_recover_work_func() reads the data.

To avoid this problem, allocate a new aer_capability_regs structure
from the ghes_estatus_pool, copy the AER data from the ghes->estatus
buffer into it, pass a pointer to the new struct to
aer_recover_queue(), and free it after aer_recover_work_func() has
processed it.

Reported-by: Bjorn Helgaas <helgaas@kernel.org>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
[ rjw: Subject edits ]
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/acpi/apei/ghes.c | 23 ++++++++++++++++++++++-
 drivers/pci/pcie/aer.c   | 10 ++++++++++
 include/acpi/ghes.h      |  4 ++++
 3 files changed, 36 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index ef59d6ea16da0..63ad0541db381 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -209,6 +209,20 @@ int ghes_estatus_pool_init(unsigned int num_ghes)
 	return -ENOMEM;
 }
 
+/**
+ * ghes_estatus_pool_region_free - free previously allocated memory
+ *				   from the ghes_estatus_pool.
+ * @addr: address of memory to free.
+ * @size: size of memory to free.
+ *
+ * Returns none.
+ */
+void ghes_estatus_pool_region_free(unsigned long addr, u32 size)
+{
+	gen_pool_free(ghes_estatus_pool, addr, size);
+}
+EXPORT_SYMBOL_GPL(ghes_estatus_pool_region_free);
+
 static int map_gen_v2(struct ghes *ghes)
 {
 	return apei_map_generic_address(&ghes->generic_v2->read_ack_register);
@@ -564,6 +578,7 @@ static void ghes_handle_aer(struct acpi_hest_generic_data *gdata)
 	    pcie_err->validation_bits & CPER_PCIE_VALID_AER_INFO) {
 		unsigned int devfn;
 		int aer_severity;
+		u8 *aer_info;
 
 		devfn = PCI_DEVFN(pcie_err->device_id.device,
 				  pcie_err->device_id.function);
@@ -577,11 +592,17 @@ static void ghes_handle_aer(struct acpi_hest_generic_data *gdata)
 		if (gdata->flags & CPER_SEC_RESET)
 			aer_severity = AER_FATAL;
 
+		aer_info = (void *)gen_pool_alloc(ghes_estatus_pool,
+						  sizeof(struct aer_capability_regs));
+		if (!aer_info)
+			return;
+		memcpy(aer_info, pcie_err->aer_info, sizeof(struct aer_capability_regs));
+
 		aer_recover_queue(pcie_err->device_id.segment,
 				  pcie_err->device_id.bus,
 				  devfn, aer_severity,
 				  (struct aer_capability_regs *)
-				  pcie_err->aer_info);
+				  aer_info);
 	}
 #endif
 }
diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index f6c24ded134cd..67025ee2b7454 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -29,6 +29,7 @@
 #include <linux/kfifo.h>
 #include <linux/slab.h>
 #include <acpi/apei.h>
+#include <acpi/ghes.h>
 #include <ras/ras_event.h>
 
 #include "../pci.h"
@@ -1010,6 +1011,15 @@ static void aer_recover_work_func(struct work_struct *work)
 			continue;
 		}
 		cper_print_aer(pdev, entry.severity, entry.regs);
+		/*
+		 * Memory for aer_capability_regs(entry.regs) is being allocated from the
+		 * ghes_estatus_pool to protect it from overwriting when multiple sections
+		 * are present in the error status. Thus free the same after processing
+		 * the data.
+		 */
+		ghes_estatus_pool_region_free((unsigned long)entry.regs,
+					      sizeof(struct aer_capability_regs));
+
 		if (entry.severity == AER_NONFATAL)
 			pcie_do_recovery(pdev, pci_channel_io_normal,
 					 aer_root_reset);
diff --git a/include/acpi/ghes.h b/include/acpi/ghes.h
index 3c8bba9f1114a..be1dd4c1a9174 100644
--- a/include/acpi/ghes.h
+++ b/include/acpi/ghes.h
@@ -73,8 +73,12 @@ int ghes_register_vendor_record_notifier(struct notifier_block *nb);
 void ghes_unregister_vendor_record_notifier(struct notifier_block *nb);
 
 struct list_head *ghes_get_devices(void);
+
+void ghes_estatus_pool_region_free(unsigned long addr, u32 size);
 #else
 static inline struct list_head *ghes_get_devices(void) { return NULL; }
+
+static inline void ghes_estatus_pool_region_free(unsigned long addr, u32 size) { return; }
 #endif
 
 int ghes_estatus_pool_init(unsigned int num_ghes);
-- 
2.42.0

