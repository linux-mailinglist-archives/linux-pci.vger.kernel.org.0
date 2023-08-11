Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45ABE778A81
	for <lists+linux-pci@lfdr.de>; Fri, 11 Aug 2023 11:59:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229546AbjHKJ7k (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 11 Aug 2023 05:59:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230149AbjHKJ7h (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 11 Aug 2023 05:59:37 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B46D9273E;
        Fri, 11 Aug 2023 02:59:36 -0700 (PDT)
Received: from canpemm500007.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RMfNd0P6yzTmQq;
        Fri, 11 Aug 2023 17:57:37 +0800 (CST)
Received: from localhost (10.174.179.215) by canpemm500007.china.huawei.com
 (7.192.104.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 11 Aug
 2023 17:59:34 +0800
From:   Yue Haibing <yuehaibing@huawei.com>
To:     <rafael@kernel.org>, <lenb@kernel.org>, <bhelgaas@google.com>,
        <scott@spiteful.org>, <yuehaibing@huawei.com>
CC:     <linux-acpi@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH -next] PCI: Remove unused function declarations
Date:   Fri, 11 Aug 2023 17:59:33 +0800
Message-ID: <20230811095933.28652-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.174.179.215]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 canpemm500007.china.huawei.com (7.192.104.62)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

These declarations is never implemented since the beginning of git history.

Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
---
 drivers/pci/hotplug/acpiphp.h      | 1 -
 drivers/pci/hotplug/cpci_hotplug.h | 2 --
 drivers/pci/hotplug/ibmphp.h       | 2 --
 include/linux/pci.h                | 1 -
 4 files changed, 6 deletions(-)

diff --git a/drivers/pci/hotplug/acpiphp.h b/drivers/pci/hotplug/acpiphp.h
index 1f8ab4377ad8..5745be6018e1 100644
--- a/drivers/pci/hotplug/acpiphp.h
+++ b/drivers/pci/hotplug/acpiphp.h
@@ -178,7 +178,6 @@ void acpiphp_unregister_hotplug_slot(struct acpiphp_slot *slot);
 int acpiphp_enable_slot(struct acpiphp_slot *slot);
 int acpiphp_disable_slot(struct acpiphp_slot *slot);
 u8 acpiphp_get_power_status(struct acpiphp_slot *slot);
-u8 acpiphp_get_attention_status(struct acpiphp_slot *slot);
 u8 acpiphp_get_latch_status(struct acpiphp_slot *slot);
 u8 acpiphp_get_adapter_status(struct acpiphp_slot *slot);
 
diff --git a/drivers/pci/hotplug/cpci_hotplug.h b/drivers/pci/hotplug/cpci_hotplug.h
index 3fdd1b9bd8c3..6d8970d8c3f2 100644
--- a/drivers/pci/hotplug/cpci_hotplug.h
+++ b/drivers/pci/hotplug/cpci_hotplug.h
@@ -83,8 +83,6 @@ extern int cpci_debug;
  * board/chassis drivers.
  */
 u8 cpci_get_attention_status(struct slot *slot);
-u8 cpci_get_latch_status(struct slot *slot);
-u8 cpci_get_adapter_status(struct slot *slot);
 u16 cpci_get_hs_csr(struct slot *slot);
 int cpci_set_attention_status(struct slot *slot, int status);
 int cpci_check_and_clear_ins(struct slot *slot);
diff --git a/drivers/pci/hotplug/ibmphp.h b/drivers/pci/hotplug/ibmphp.h
index 0399c60d2ec1..41eafe511210 100644
--- a/drivers/pci/hotplug/ibmphp.h
+++ b/drivers/pci/hotplug/ibmphp.h
@@ -264,8 +264,6 @@ extern struct list_head ibmphp_slot_head;
 void ibmphp_free_ebda_hpc_queue(void);
 int ibmphp_access_ebda(void);
 struct slot *ibmphp_get_slot_from_physical_num(u8);
-int ibmphp_get_total_hp_slots(void);
-void ibmphp_free_ibm_slot(struct slot *);
 void ibmphp_free_bus_info_queue(void);
 void ibmphp_free_ebda_pci_rsrc_queue(void);
 struct bus_info *ibmphp_find_same_bus_num(u32);
diff --git a/include/linux/pci.h b/include/linux/pci.h
index eeb2e6f6130f..494470a38abf 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1403,7 +1403,6 @@ void pci_assign_unassigned_bridge_resources(struct pci_dev *bridge);
 void pci_assign_unassigned_bus_resources(struct pci_bus *bus);
 void pci_assign_unassigned_root_bus_resources(struct pci_bus *bus);
 int pci_reassign_bridge_resources(struct pci_dev *bridge, unsigned long type);
-void pdev_enable_device(struct pci_dev *);
 int pci_enable_resources(struct pci_dev *, int mask);
 void pci_assign_irq(struct pci_dev *dev);
 struct resource *pci_find_resource(struct pci_dev *dev, struct resource *res);
-- 
2.34.1

