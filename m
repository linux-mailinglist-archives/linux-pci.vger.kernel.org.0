Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8C4168C802
	for <lists+linux-pci@lfdr.de>; Mon,  6 Feb 2023 21:51:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230057AbjBFUvQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 6 Feb 2023 15:51:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230416AbjBFUvO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 6 Feb 2023 15:51:14 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D8541F917;
        Mon,  6 Feb 2023 12:51:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675716673; x=1707252673;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2upboONhPsEQRYVRQaehuwu0mriRbjkDwyzG7PvshPA=;
  b=JRkSMXG5/oUfK+twbkWccGOH9j40oGSLjgMIMABc8eRF//RsdYCMFjXV
   iT98cP4JLzPZM6LCaPJ8IFBwMrZwqEznmVmPqh4VwG6yR4/lHTwBur0Ab
   ILJZX9nZdv3McVMUQ+glWKnX1/xah6jtPqwBPYNd0Y2mY5BgyfREg1zLe
   HW03pEJmCFE+rJnKAqYrqjfiucR88Qgfa+/L0LGI6LIfLy8AyoGxP6zhk
   3JEydzf9v3AcDtsKMrvDk/Ih9kJaQaUVGTHGedqyrCXS6PA2jgYY1zBOq
   UCXdKJTi0cXZ+YEdkadauR5TUFO2Yrz/nbc7hJHbDiDTVHPgLHM6C7zID
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10613"; a="391708501"
X-IronPort-AV: E=Sophos;i="5.97,276,1669104000"; 
   d="scan'208";a="391708501"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2023 12:51:13 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10613"; a="840493029"
X-IronPort-AV: E=Sophos;i="5.97,276,1669104000"; 
   d="scan'208";a="840493029"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO djiang5-mobl3.local) ([10.212.111.195])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2023 12:51:12 -0800
Subject: [PATCH 12/18] cxl: Add helpers to calculate pci latency for the CXL
 device
From:   Dave Jiang <dave.jiang@intel.com>
To:     linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-acpi@vger.kernel.org
Cc:     dan.j.williams@intel.com, ira.weiny@intel.com,
        vishal.l.verma@intel.com, alison.schofield@intel.com,
        rafael@kernel.org, bhelgaas@google.com, robert.moore@intel.com
Date:   Mon, 06 Feb 2023 13:51:10 -0700
Message-ID: <167571666898.587790.4824622451425607591.stgit@djiang5-mobl3.local>
In-Reply-To: <167571650007.587790.10040913293130712882.stgit@djiang5-mobl3.local>
References: <167571650007.587790.10040913293130712882.stgit@djiang5-mobl3.local>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The latency is calculated by dividing the FLIT size over the bandwidth. Add
support to retrieve the FLIT size for the CXL device and calculate the
latency of the downstream link.

Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/cxl/core/pci.c |   67 ++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/cxl/cxlpci.h   |   14 ++++++++++
 2 files changed, 81 insertions(+)

diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index a24dac36bedd..54ac6f8825ff 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -633,3 +633,70 @@ void read_cdat_data(struct cxl_port *port)
 	}
 }
 EXPORT_SYMBOL_NS_GPL(read_cdat_data, CXL);
+
+static int pcie_speed_to_mbps(enum pci_bus_speed speed)
+{
+	switch (speed) {
+	case PCIE_SPEED_2_5GT:
+		return 2500;
+	case PCIE_SPEED_5_0GT:
+		return 5000;
+	case PCIE_SPEED_8_0GT:
+		return 8000;
+	case PCIE_SPEED_16_0GT:
+		return 16000;
+	case PCIE_SPEED_32_0GT:
+		return 32000;
+	case PCIE_SPEED_64_0GT:
+		return 64000;
+	default:
+		break;
+	}
+
+	return -EINVAL;
+}
+
+static int cxl_pci_mbits_to_mbytes(struct pci_dev *pdev)
+{
+	int mbits;
+
+	mbits = pcie_speed_to_mbps(pcie_get_speed(pdev));
+	if (mbits < 0)
+		return mbits;
+
+	return mbits >> 3;
+}
+
+static int cxl_get_flit_size(struct pci_dev *pdev)
+{
+	if (cxl_pci_flit_256(pdev))
+		return 256;
+
+	return 66;
+}
+
+/**
+ * cxl_pci_get_latency - calculate the link latency for the PCIe link
+ * @pdev - PCI device
+ *
+ * CXL Memory Device SW Guide v1.0 2.11.4 Link latency calculation
+ * Link latency = LinkPropagationLatency + FlitLatency + RetimerLatency
+ * LinkProgationLatency is negligible, so 0 will be used
+ * RetimerLatency is assumed to be neglibible and 0 will be used
+ * FlitLatency = FlitSize / LinkBandwidth
+ * FlitSize is defined by spec. CXL v3.0 4.2.1.
+ * 68B flit is used up to 32GT/s. >32GT/s, 256B flit size is used.
+ * The FlitLatency is converted to pico-seconds.
+ */
+long cxl_pci_get_latency(struct pci_dev *pdev)
+{
+	long bw, flit_size;
+
+	bw = cxl_pci_mbits_to_mbytes(pdev);
+	if (bw < 0)
+		return bw;
+
+	flit_size = cxl_get_flit_size(pdev);
+	return flit_size * 1000000L / bw;
+}
+EXPORT_SYMBOL_NS_GPL(cxl_pci_get_latency, CXL);
diff --git a/drivers/cxl/cxlpci.h b/drivers/cxl/cxlpci.h
index 920909791bb9..d64a3e0458ab 100644
--- a/drivers/cxl/cxlpci.h
+++ b/drivers/cxl/cxlpci.h
@@ -62,8 +62,22 @@ enum cxl_regloc_type {
 	CXL_REGLOC_RBI_TYPES
 };
 
+/*
+ * CXL v3.0 6.2.3 Table 6-4
+ * The table indicates that if PCIe Flit Mode is set, then CXL is in 256B flits
+ * mode, otherwise it's 68B flits mode.
+ */
+static inline bool cxl_pci_flit_256(struct pci_dev *pdev)
+{
+	u32 lnksta2;
+
+	pcie_capability_read_dword(pdev, PCI_EXP_LNKSTA2, &lnksta2);
+	return lnksta2 & BIT(10);
+}
+
 int devm_cxl_port_enumerate_dports(struct cxl_port *port);
 struct cxl_dev_state;
 int cxl_hdm_decode_init(struct cxl_dev_state *cxlds, struct cxl_hdm *cxlhdm);
 void read_cdat_data(struct cxl_port *port);
+long cxl_pci_get_latency(struct pci_dev *pdev);
 #endif /* __CXL_PCI_H__ */


