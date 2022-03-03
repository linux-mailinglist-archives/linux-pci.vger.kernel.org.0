Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CEFD4CBF58
	for <lists+linux-pci@lfdr.de>; Thu,  3 Mar 2022 15:01:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233876AbiCCOCT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 3 Mar 2022 09:02:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229881AbiCCOCS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 3 Mar 2022 09:02:18 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56F3764BC9;
        Thu,  3 Mar 2022 06:01:30 -0800 (PST)
Received: from fraeml734-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4K8XgK6tnzz67xLh;
        Thu,  3 Mar 2022 22:00:13 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml734-chm.china.huawei.com (10.206.15.215) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Thu, 3 Mar 2022 15:01:28 +0100
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhreml710-chm.china.huawei.com (10.201.108.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2308.21; Thu, 3 Mar 2022 14:01:27 +0000
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     <linux-cxl@vger.kernel.org>, <linux-pci@vger.kernel.org>
CC:     <linuxarm@huawei.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Chris Browy <cbrowy@avery-design.com>,
        <keyrings@vger.kernel.org>, "Bjorn Helgaas" <bjorn@helgaas.com>,
        "David E . Box" <david.e.box@linux.intel.com>,
        <dan.j.williams@intel.com>
Subject: [RFC PATCH v2 05/14] cxl/pci: Create DOE auxiliary devices
Date:   Thu, 3 Mar 2022 13:58:56 +0000
Message-ID: <20220303135905.10420-6-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220303135905.10420-1-Jonathan.Cameron@huawei.com>
References: <20220303135905.10420-1-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.122.247.231]
X-ClientProxiedBy: lhreml706-chm.china.huawei.com (10.201.108.55) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Ira Weiny <ira.weiny@intel.com>

CXL devices will need DOE mailbox access to read things like CDAT.

Call the PCI core helper to find all DOE mailboxes on the device and
create the auxiliary devices for those mailboxes.

sysfs shows this relationship.  Starting with a qemu system with 2
memory devices mem0 and mem1.

$ ls -l /sys/bus/cxl/devices/mem*
lrwxrwxrwx 1 root root 0 Jan 25 16:15 /sys/bus/cxl/devices/mem0 -> ../../../devices/pci0000:34/0000:34:00.0/0000:35:00.0/mem0
lrwxrwxrwx 1 root root 0 Jan 25 16:15 /sys/bus/cxl/devices/mem1 -> ../../../devices/pci0000:34/0000:34:01.0/0000:36:00.0/mem1

$ ls -l /sys/bus/auxiliary/devices/
total 0
lrwxrwxrwx 1 root root 0 Jan 25 16:16 pci_doe.doe.0 -> ../../../devices/pci0000:34/0000:34:00.0/0000:35:00.0/pci_doe.doe.0
lrwxrwxrwx 1 root root 0 Jan 25 16:16 pci_doe.doe.1 -> ../../../devices/pci0000:34/0000:34:01.0/0000:36:00.0/pci_doe.doe.1
lrwxrwxrwx 1 root root 0 Jan 25 16:16 pci_doe.doe.2 -> ../../../devices/pci0000:34/0000:34:01.0/0000:36:00.0/pci_doe.doe.2
lrwxrwxrwx 1 root root 0 Jan 25 16:16 pci_doe.doe.3 -> ../../../devices/pci0000:34/0000:34:00.0/0000:35:00.0/pci_doe.doe.3

$ ls -l /sys/bus/auxiliary/drivers
total 0
drwxr-xr-x 2 root root 0 Jan 25 16:15 pci_doe.pci_doe

Signed-off-by: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/cxl/Kconfig |  1 +
 drivers/cxl/pci.c   | 13 +++++++++++++
 2 files changed, 14 insertions(+)

diff --git a/drivers/cxl/Kconfig b/drivers/cxl/Kconfig
index 67c91378f2dd..9d53720bea07 100644
--- a/drivers/cxl/Kconfig
+++ b/drivers/cxl/Kconfig
@@ -16,6 +16,7 @@ if CXL_BUS
 config CXL_MEM
 	tristate "CXL.mem: Memory Devices"
 	default CXL_BUS
+	select PCI_DOE_DRIVER
 	help
 	  The CXL.mem protocol allows a device to act as a provider of
 	  "System RAM" and/or "Persistent Memory" that is fully coherent
diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index 8dc91fd3396a..0adc7798e0cf 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -6,6 +6,7 @@
 #include <linux/mutex.h>
 #include <linux/list.h>
 #include <linux/pci.h>
+#include <linux/pci-doe.h>
 #include <linux/io.h>
 #include "cxlmem.h"
 #include "pci.h"
@@ -471,6 +472,14 @@ static int cxl_setup_regs(struct pci_dev *pdev, enum cxl_regloc_type type,
 	return rc;
 }
 
+static int cxl_setup_doe_devices(struct cxl_dev_state *cxlds)
+{
+	struct device *dev = cxlds->dev;
+	struct pci_dev *pdev = to_pci_dev(dev);
+
+	return pci_doe_create_doe_devices(pdev);
+}
+
 static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 {
 	struct cxl_register_map map;
@@ -497,6 +506,10 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	if (rc)
 		return rc;
 
+	rc = cxl_setup_doe_devices(cxlds);
+	if (rc)
+		return rc;
+
 	rc = cxl_map_regs(cxlds, &map);
 	if (rc)
 		return rc;
-- 
2.32.0

