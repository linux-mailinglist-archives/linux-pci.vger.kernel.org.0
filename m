Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4905D4E9B0B
	for <lists+linux-pci@lfdr.de>; Mon, 28 Mar 2022 17:25:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237424AbiC1P0g (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 28 Mar 2022 11:26:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237392AbiC1P0J (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 28 Mar 2022 11:26:09 -0400
Received: from mail.baikalelectronics.ru (mail.baikalelectronics.com [87.245.175.226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 462E21FA55;
        Mon, 28 Mar 2022 08:24:13 -0700 (PDT)
Received: from mail.baikalelectronics.ru (unknown [192.168.51.25])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id 5EB0C1E4923;
        Thu, 24 Mar 2022 04:37:52 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.baikalelectronics.ru 5EB0C1E4923
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baikalelectronics.ru; s=mail; t=1648085872;
        bh=i8/8fLcZUXbXg67aSAjVRqmL8MzIGLx2dw5JpgWmYX8=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=bA0h9hLl7MP/I1G5OEbHLaqxYZu89pAzQIAk2mJsklz854E9hcGVO2UVPNnklG+Zg
         bVcnza/LmIEdgFT7ppap3kRjOlw4YHR+JBiYjMDHSENoQQpgeE3KZeDqR8RVXBiRVf
         yra6hstTZJrL1F0RD3gB2BfTdjN3qHVpWAVw0XFk=
Received: from localhost (192.168.168.10) by mail (192.168.51.25) with
 Microsoft SMTP Server (TLS) id 15.0.1395.4; Thu, 24 Mar 2022 04:37:52 +0300
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
Subject: [PATCH 05/16] PCI: dwc: Add IP-core version detection procedure
Date:   Thu, 24 Mar 2022 04:37:23 +0300
Message-ID: <20220324013734.18234-6-Sergey.Semin@baikalelectronics.ru>
In-Reply-To: <20220324013734.18234-1-Sergey.Semin@baikalelectronics.ru>
References: <20220324013734.18234-1-Sergey.Semin@baikalelectronics.ru>
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
 .../pci/controller/dwc/pcie-designware-ep.c   |  2 ++
 .../pci/controller/dwc/pcie-designware-host.c |  2 ++
 drivers/pci/controller/dwc/pcie-designware.c  | 24 +++++++++++++++++++
 drivers/pci/controller/dwc/pcie-designware.h  |  6 +++++
 4 files changed, 34 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
index 7c9315fffe24..3b981d13cca9 100644
--- a/drivers/pci/controller/dwc/pcie-designware-ep.c
+++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
@@ -645,6 +645,8 @@ int dw_pcie_ep_init_complete(struct dw_pcie_ep *ep)
 	u32 reg;
 	int i;
 
+	dw_pcie_version_detect(pci);
+
 	hdr_type = dw_pcie_readb_dbi(pci, PCI_HEADER_TYPE) &
 		   PCI_HEADER_TYPE_MASK;
 	if (hdr_type != PCI_HEADER_TYPE_NORMAL) {
diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index 8364ea234e88..8f0d473ff770 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -398,6 +398,8 @@ int dw_pcie_host_init(struct pcie_port *pp)
 		}
 	}
 
+	dw_pcie_version_detect(pci);
+
 	dw_pcie_iatu_detect(pci);
 
 	dw_pcie_setup_rc(pp);
diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
index c21373c6cb51..49c494d82042 100644
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

