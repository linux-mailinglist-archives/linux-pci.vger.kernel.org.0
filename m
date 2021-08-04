Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DD803E05D2
	for <lists+linux-pci@lfdr.de>; Wed,  4 Aug 2021 18:23:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237343AbhHDQXg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 4 Aug 2021 12:23:36 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3580 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234482AbhHDQXg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 4 Aug 2021 12:23:36 -0400
Received: from fraeml744-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4GfxqZ3XzTz6GFV7;
        Thu,  5 Aug 2021 00:23:06 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml744-chm.china.huawei.com (10.206.15.225) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 4 Aug 2021 18:23:21 +0200
Received: from localhost.localdomain (10.123.41.22) by
 lhreml710-chm.china.huawei.com (10.201.108.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 4 Aug 2021 17:23:20 +0100
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     <linux-cxl@vger.kernel.org>, <linux-pci@vger.kernel.org>
CC:     <keyrings@vger.kernel.org>, <dan.j.williams@intel.com>,
        Chris Browy <cbrowy@avery-design.com>, <linuxarm@huawei.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bjorn@helgaas.com>,
        Jeremy Kerr <jk@codeconstruct.com.au>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [RFC PATCH 3/4] PCI/CMA: Initial support for Component Measurement and Authentication ECN
Date:   Thu, 5 Aug 2021 00:18:38 +0800
Message-ID: <20210804161839.3492053-4-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20210804161839.3492053-1-Jonathan.Cameron@huawei.com>
References: <20210804161839.3492053-1-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.123.41.22]
X-ClientProxiedBy: lhreml754-chm.china.huawei.com (10.201.108.204) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This currently very much a PoC.  Currently the SPDM library only provides
a single function to allow a challenge / authentication of the PCI EP.

SPDM exchanges must occur in one of a small set of valid squences over
which the message digest used in authentication is built up.
Placing that complexity in the SPDM library seems like a good way
to enforce that logic, without having to do it for each transport.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/pci/Kconfig     | 9 +++++++++
 drivers/pci/Makefile    | 1 +
 drivers/pci/doe.c       | 2 --
 include/linux/pci-doe.h | 2 ++
 4 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
index a30c59cf5e27..43e3b0d5e8cd 100644
--- a/drivers/pci/Kconfig
+++ b/drivers/pci/Kconfig
@@ -198,6 +198,15 @@ config PCI_DOE
 	  used by a number of different protocols.
 	  DOE is defined in the Data Object Exchange ECN to the PCIe r5.0 spec.
 
+config PCI_CMA
+	tristate
+	select PCI_DOE
+	select ASN1_ENCODER
+	select SPDM
+	help
+	  This enables library support for the PCI Component Measurement and
+	  Authentication ECN. This uses DMTF SPDM 1.1
+
 choice
 	prompt "PCI Express hierarchy optimization setting"
 	default PCIE_BUS_DEFAULT
diff --git a/drivers/pci/Makefile b/drivers/pci/Makefile
index 1b61c1a1c232..3f6b3543d565 100644
--- a/drivers/pci/Makefile
+++ b/drivers/pci/Makefile
@@ -29,6 +29,7 @@ obj-$(CONFIG_PCI_PF_STUB)	+= pci-pf-stub.o
 obj-$(CONFIG_PCI_ECAM)		+= ecam.o
 obj-$(CONFIG_PCI_P2PDMA)	+= p2pdma.o
 obj-$(CONFIG_PCI_DOE)		+= doe.o
+obj-$(CONFIG_PCI_CMA)		+= cma.o
 obj-$(CONFIG_XEN_PCIDEV_FRONTEND) += xen-pcifront.o
 
 # Endpoint library must be initialized before its users
diff --git a/drivers/pci/doe.c b/drivers/pci/doe.c
index 2d20f59e42c6..f6aaeed01010 100644
--- a/drivers/pci/doe.c
+++ b/drivers/pci/doe.c
@@ -20,8 +20,6 @@
 /* Maximum number of DOE instances in the system */
 #define PCI_DOE_MAX_CNT 65536
 
-#define PCI_DOE_PROTOCOL_DISCOVERY 0
-
 #define PCI_DOE_BUSY_MAX_RETRIES 16
 #define PCI_DOE_POLL_INTERVAL (HZ / 128)
 
diff --git a/include/linux/pci-doe.h b/include/linux/pci-doe.h
index bdc5f15f14ab..1347c124ed70 100644
--- a/include/linux/pci-doe.h
+++ b/include/linux/pci-doe.h
@@ -19,6 +19,8 @@ struct pci_doe_prot {
 	u8 type;
 };
 
+#define PCI_DOE_PROTOCOL_DISCOVERY 0
+#define PCI_DOE_PROTOCOL_CMA 1
 struct workqueue_struct;
 
 enum pci_doe_state {
-- 
2.19.1

