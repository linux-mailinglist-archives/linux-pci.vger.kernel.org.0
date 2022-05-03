Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77A3D519096
	for <lists+linux-pci@lfdr.de>; Tue,  3 May 2022 23:51:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243199AbiECVu5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 3 May 2022 17:50:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243203AbiECVuv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 3 May 2022 17:50:51 -0400
Received: from mail.baikalelectronics.ru (mail.baikalelectronics.com [87.245.175.226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C31D4419A7;
        Tue,  3 May 2022 14:47:06 -0700 (PDT)
Received: from mail.baikalelectronics.ru (unknown [192.168.51.25])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id BDCE916D6;
        Wed,  4 May 2022 00:47:39 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.baikalelectronics.ru BDCE916D6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baikalelectronics.ru; s=mail; t=1651614459;
        bh=hrJgTy2FnB/c9Q9rJw4QNSOKSyrn0kRuvuyAhzMZnVw=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=EN7vShXicF6Osf/mn0TVzIBJn+pXOpOw+AQ+PKt9G3hnnLOPMDKC1FVkP3GjdoPjA
         ddoxeu9r5GjBOZv+ARc3szXnQYUK3Uf9R9tyJVy4C78IaqA/rHI40eXtwDKpYINvSB
         9M3Osns4936mkyH5rzYZKaS+AT8+lu+eokhnVGJ4=
Received: from localhost (192.168.53.207) by mail (192.168.51.25) with
 Microsoft SMTP Server (TLS) id 15.0.1395.4; Wed, 4 May 2022 00:47:05 +0300
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>
CC:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Frank Li <Frank.Li@nxp.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 06/17] PCI: dwc: Add IP-core version detection procedure
Date:   Wed, 4 May 2022 00:46:27 +0300
Message-ID: <20220503214638.1895-7-Sergey.Semin@baikalelectronics.ru>
In-Reply-To: <20220503214638.1895-1-Sergey.Semin@baikalelectronics.ru>
References: <20220503214638.1895-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Since DWC PCIe v4.70a the controller version and version type can be read
from the PORT_LOGIC.PCIE_VERSION_OFF and PORT_LOGIC.PCIE_VERSION_TYPE_OFF
registers respectively. Seeing the generic code has got version-dependent
parts let's use these registers to find out the controller version.  The
detection procedure is executed for both RC and EP modes right after the
platform-specific initialization. We can't do that earlier since the
glue-drivers can perform the DBI-related setups there including the bus
reference clocks activation, without which the CSRs just can't be read.

Note the CSRs content is zero on the older DWC PCIe controller. In that
case we have no choice but to rely on the platform setup.

Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>

---

Changelog v2:
- Move the IP-core version detection procedure call from
  dw_pcie_ep_init_complete() to dw_pcie_ep_init().
---
 .../pci/controller/dwc/pcie-designware-ep.c   |  2 ++
 .../pci/controller/dwc/pcie-designware-host.c |  2 ++
 drivers/pci/controller/dwc/pcie-designware.c  | 24 +++++++++++++++++++
 drivers/pci/controller/dwc/pcie-designware.h  |  6 +++++
 4 files changed, 34 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
index c152021d0bf6..1be8bbf35047 100644
--- a/drivers/pci/controller/dwc/pcie-designware-ep.c
+++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
@@ -715,6 +715,8 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
 	ep->phys_base = res->start;
 	ep->addr_size = resource_size(res);
 
+	dw_pcie_version_detect(pci);
+
 	dw_pcie_iatu_detect(pci);
 
 	ep->ib_window_map = devm_kcalloc(dev,
diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index 1c815d3bead9..c74b4587b236 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -404,6 +404,8 @@ int dw_pcie_host_init(struct pcie_port *pp)
 		}
 	}
 
+	dw_pcie_version_detect(pci);
+
 	dw_pcie_iatu_detect(pci);
 
 	dw_pcie_setup_rc(pp);
diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
index 3ebb7bfee10f..62f50086aa49 100644
--- a/drivers/pci/controller/dwc/pcie-designware.c
+++ b/drivers/pci/controller/dwc/pcie-designware.c
@@ -16,6 +16,30 @@
 #include "../../pci.h"
 #include "pcie-designware.h"
 
+void dw_pcie_version_detect(struct dw_pcie *pci)
+{
+	u32 ver;
+
+	/* The content of the CSR is zero on DWC PCIe older than v4.70a */
+	ver = dw_pcie_readl_dbi(pci, PCIE_VERSION_NUMBER);
+	if (!ver)
+		return;
+
+	if (pci->version && pci->version != ver)
+		dev_warn(pci->dev, "Versions don't match (%08x != %08x)\n",
+			 pci->version, ver);
+	else
+		pci->version = ver;
+
+	ver = dw_pcie_readl_dbi(pci, PCIE_VERSION_TYPE);
+
+	if (pci->type && pci->type != ver)
+		dev_warn(pci->dev, "Types don't match (%08x != %08x)\n",
+			 pci->type, ver);
+	else
+		pci->type = ver;
+}
+
 /*
  * These interfaces resemble the pci_find_*capability() interfaces, but these
  * are for configuring host controllers, which are bridges *to* PCI devices but
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index 5be43c662176..f70cbdedf5a3 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -85,6 +85,9 @@
 #define PCIE_PORT_MULTI_LANE_CTRL	0x8C0
 #define PORT_MLTI_UPCFG_SUPPORT		BIT(7)
 
+#define PCIE_VERSION_NUMBER		0x8F8
+#define PCIE_VERSION_TYPE		0x8FC
+
 #define PCIE_ATU_VIEWPORT		0x900
 #define PCIE_ATU_REGION_INBOUND		BIT(31)
 #define PCIE_ATU_REGION_OUTBOUND	0
@@ -278,6 +281,7 @@ struct dw_pcie {
 	struct dw_pcie_ep	ep;
 	const struct dw_pcie_ops *ops;
 	u32			version;
+	u32			type;
 	int			num_lanes;
 	int			link_gen;
 	u8			n_fts[2];
@@ -290,6 +294,8 @@ struct dw_pcie {
 #define to_dw_pcie_from_ep(endpoint)   \
 		container_of((endpoint), struct dw_pcie, ep)
 
+void dw_pcie_version_detect(struct dw_pcie *pci);
+
 u8 dw_pcie_find_capability(struct dw_pcie *pci, u8 cap);
 u16 dw_pcie_find_ext_capability(struct dw_pcie *pci, u8 cap);
 
-- 
2.35.1

