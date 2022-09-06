Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 625FA5AE658
	for <lists+linux-pci@lfdr.de>; Tue,  6 Sep 2022 13:18:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234000AbiIFLR7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 6 Sep 2022 07:17:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230112AbiIFLR6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 6 Sep 2022 07:17:58 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84C276E8B7;
        Tue,  6 Sep 2022 04:17:57 -0700 (PDT)
Received: from fraeml738-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4MMN762gjFz689rl;
        Tue,  6 Sep 2022 19:13:54 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (7.191.163.240) by
 fraeml738-chm.china.huawei.com (10.206.15.219) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 6 Sep 2022 13:17:55 +0200
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 6 Sep 2022 12:17:55 +0100
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     Lukas Wunner <lukas@wunner.de>, <linux-pci@vger.kernel.org>,
        <linux-cxl@vger.kernel.org>
CC:     <linuxarm@huawei.com>, Dan Williams <dan.j.williams@intel.com>,
        "Adam Manzanares" <a.manzanares@samsung.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Christoph Hellwig <hch@infradead.org>,
        Ben W <ben@bwidawsk.net>,
        "Lorenzo Pieralisi" <lorenzo.pieralisi@arm.com>,
        David E Box <david.e.box@intel.com>,
        Chuck Lever <chuck.lever@oracle.com>, <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Eric Biggers <ebiggers@google.com>
Subject: [RFC PATCH v3 4/4] cxl/pci: Add really basic CMA authentication support.
Date:   Tue, 6 Sep 2022 12:15:56 +0100
Message-ID: <20220906111556.1544-5-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220906111556.1544-1-Jonathan.Cameron@huawei.com>
References: <20220906111556.1544-1-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.122.247.231]
X-ClientProxiedBy: lhrpeml500002.china.huawei.com (7.191.160.78) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This is just for purposes of poking the CMA / SPDM code.
What exactly the model in the driver looks like is still to
be worked out.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
  May still need to force non async probe as done in earlier versions.

 drivers/cxl/Kconfig    |  1 +
 drivers/cxl/core/pci.c | 47 ++++++++++++++++++++++++++++++++++++++++++
 drivers/cxl/cxlpci.h   |  1 +
 drivers/cxl/port.c     |  1 +
 4 files changed, 50 insertions(+)

diff --git a/drivers/cxl/Kconfig b/drivers/cxl/Kconfig
index 768ced3d6fe8..a5d9589dd7a7 100644
--- a/drivers/cxl/Kconfig
+++ b/drivers/cxl/Kconfig
@@ -3,6 +3,7 @@ menuconfig CXL_BUS
 	tristate "CXL (Compute Express Link) Devices Support"
 	depends on PCI
 	select PCI_DOE
+	select PCI_CMA
 	help
 	  CXL is a bus that is electrically compatible with PCI Express, but
 	  layers three protocols on that signalling (CXL.io, CXL.cache, and
diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index 9240df53ed87..dfc9fc670be5 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -4,7 +4,9 @@
 #include <linux/device.h>
 #include <linux/delay.h>
 #include <linux/pci.h>
+#include <linux/pci-cma.h>
 #include <linux/pci-doe.h>
+#include <linux/spdm.h>
 #include <cxlpci.h>
 #include <cxlmem.h>
 #include <cxl.h>
@@ -625,3 +627,48 @@ void read_cdat_data(struct cxl_port *port)
 	}
 }
 EXPORT_SYMBOL_NS_GPL(read_cdat_data, CXL);
+
+/* Make a generic find routine that take the VID / Protocol */
+static struct pci_doe_mb *find_cma_doe(struct device *uport)
+{
+	struct cxl_memdev *cxlmd;
+	struct cxl_dev_state *cxlds;
+	unsigned long index;
+	void *entry;
+
+	cxlmd = to_cxl_memdev(uport);
+	cxlds = cxlmd->cxlds;
+
+	xa_for_each(&cxlds->doe_mbs, index, entry) {
+		struct pci_doe_mb *cur = entry;
+
+		if (pci_doe_supports_prot(cur, PCI_VENDOR_ID_PCI_SIG, 1))
+			return cur;
+	}
+
+	return NULL;
+}
+
+void cxl_cma_init(struct cxl_port *port)
+{
+	struct spdm_state *spdm_state;
+	struct pci_doe_mb *cma_doe;
+	struct device *dev = &port->dev;
+	struct device *uport = port->uport;
+	int rc;
+
+	cma_doe = find_cma_doe(uport);
+	if (!cma_doe) {
+		dev_info(dev, "No CDAT mailbox\n");
+		return;
+	}
+
+	spdm_state = pci_cma_create(dev, cma_doe);
+	rc = pci_cma_authenticate(spdm_state);
+	if (rc)
+		dev_info(dev, "No CMA support\n");
+	else
+		dev_info(dev, "Attestation passed\n");
+	pci_cma_destroy(spdm_state);
+}
+EXPORT_SYMBOL_NS_GPL(cxl_cma_init, CXL);
diff --git a/drivers/cxl/cxlpci.h b/drivers/cxl/cxlpci.h
index eec597dbe763..36d619563df1 100644
--- a/drivers/cxl/cxlpci.h
+++ b/drivers/cxl/cxlpci.h
@@ -75,4 +75,5 @@ int devm_cxl_port_enumerate_dports(struct cxl_port *port);
 struct cxl_dev_state;
 int cxl_hdm_decode_init(struct cxl_dev_state *cxlds, struct cxl_hdm *cxlhdm);
 void read_cdat_data(struct cxl_port *port);
+void cxl_cma_init(struct cxl_port *port);
 #endif /* __CXL_PCI_H__ */
diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
index 5453771bf330..9c6880e8c1f4 100644
--- a/drivers/cxl/port.c
+++ b/drivers/cxl/port.c
@@ -55,6 +55,7 @@ static int cxl_port_probe(struct device *dev)
 
 		/* Cache the data early to ensure is_visible() works */
 		read_cdat_data(port);
+		cxl_cma_init(port);
 
 		get_device(&cxlmd->dev);
 		rc = devm_add_action_or_reset(dev, schedule_detach, cxlmd);
-- 
2.32.0

