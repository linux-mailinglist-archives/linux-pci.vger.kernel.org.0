Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55779545FD8
	for <lists+linux-pci@lfdr.de>; Fri, 10 Jun 2022 10:47:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348098AbiFJIpJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 10 Jun 2022 04:45:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348076AbiFJIo7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 10 Jun 2022 04:44:59 -0400
Received: from mail.baikalelectronics.com (mail.baikalelectronics.com [87.245.175.230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4C25037AB2;
        Fri, 10 Jun 2022 01:44:58 -0700 (PDT)
Received: from mail (mail.baikal.int [192.168.51.25])
        by mail.baikalelectronics.com (Postfix) with ESMTP id AF0BC16A6;
        Fri, 10 Jun 2022 11:45:40 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.baikalelectronics.com AF0BC16A6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baikalelectronics.ru; s=mail; t=1654850740;
        bh=dXe+KhYz/Roo8Ip3gbdMuPtAJ/cdbIaVUkW+u5Hmsqs=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=O6nO+Fi4sTs514rT7lmP8Dko34bJc4uK7MYXYWvR+lD0YVo6BUaOssNs52H+WKq9e
         Tc88iA9DUaRcAw4SxrNDVn8Ubn5ZtraztA87F58E4Z8IFnlAOuDniN/gh2f6khyDyZ
         LsUrWjqvf05ycgfBxnj/UBlH46OxPjTxieDPZtoA=
Received: from localhost (192.168.53.207) by mail (192.168.51.25) with
 Microsoft SMTP Server (TLS) id 15.0.1395.4; Fri, 10 Jun 2022 11:44:48 +0300
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>
CC:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Frank Li <Frank.Li@nxp.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 04/15] PCI: dwc: Add IP-core version detection procedure
Date:   Fri, 10 Jun 2022 11:44:32 +0300
Message-ID: <20220610084444.14549-5-Sergey.Semin@baikalelectronics.ru>
In-Reply-To: <20220610084444.14549-1-Sergey.Semin@baikalelectronics.ru>
References: <20220610084444.14549-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
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
Reviewed-by: Rob Herring <robh@kernel.org>

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
index 1e35542d6f72..ffbd3af6d65a 100644
--- a/drivers/pci/controller/dwc/pcie-designware-ep.c
+++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
@@ -711,6 +711,8 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
 	ep->phys_base = res->start;
 	ep->addr_size = resource_size(res);
 
+	dw_pcie_version_detect(pci);
+
 	dw_pcie_iatu_detect(pci);
 
 	ep->ib_window_map = devm_kcalloc(dev,
diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index 12aa61cf7073..0a1c475e7414 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -404,6 +404,8 @@ int dw_pcie_host_init(struct dw_pcie_rp *pp)
 		}
 	}
 
+	dw_pcie_version_detect(pci);
+
 	dw_pcie_iatu_detect(pci);
 
 	dw_pcie_setup_rc(pp);
diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
index f10a7d5d94e8..cbb36ccaa48b 100644
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
index 6b81530fb2ca..7899808bdbc6 100644
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
@@ -279,6 +282,7 @@ struct dw_pcie {
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

