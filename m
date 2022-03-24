Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 760AD4E9AF1
	for <lists+linux-pci@lfdr.de>; Mon, 28 Mar 2022 17:24:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237195AbiC1PZ5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 28 Mar 2022 11:25:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236912AbiC1PZz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 28 Mar 2022 11:25:55 -0400
Received: from mail.baikalelectronics.ru (mail.baikalelectronics.com [87.245.175.226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 97B6723140;
        Mon, 28 Mar 2022 08:24:12 -0700 (PDT)
Received: from mail.baikalelectronics.ru (unknown [192.168.51.25])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id 95C241E4929;
        Thu, 24 Mar 2022 04:37:56 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.baikalelectronics.ru 95C241E4929
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baikalelectronics.ru; s=mail; t=1648085876;
        bh=JUzxfKi0MQDTXGgN5Cp017DVBJQxZSN3g4muSQcPmsg=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=dP3AhX5KBEPxHZxHwo+WqaXRCLjEJvSQ4+saFBlsJRINv2STOgx42KXYwwviEs73e
         M6bJynpSnwQuFJKEkV0UbxenbHOg5uuw0pE4ep38KvYTRJ46KvZzoIBDedd6atguDz
         zBsnxcO5tKgFcmA/Yu0tqmKjSZPqJzd8nADCCa+0=
Received: from localhost (192.168.168.10) by mail (192.168.51.25) with
 Microsoft SMTP Server (TLS) id 15.0.1395.4; Thu, 24 Mar 2022 04:37:56 +0300
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
Subject: [PATCH 10/16] PCI: dwc: Drop iATU regions enumeration - dw_pcie_region_type
Date:   Thu, 24 Mar 2022 04:37:28 +0300
Message-ID: <20220324013734.18234-11-Sergey.Semin@baikalelectronics.ru>
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

There is no point in having the dw_pcie_region_type enumeration for almost
the same reasons as it was stated for dw_pcie_as_type. First of all it's
redundant since the driver already has a set of macro declared which
describe the possible inbound and outbound iATU regions. Having an
addition abstraction just needlessly complicates the code. Secondly
checking the region index passed to the dw_pcie_disable_atu() method for
validity is pointless since the erroneous situation will be just
ignored in the current code implementation. So to speak let's drop the
redundant dw_pcie_region_type enumeration replacing it with the direct
iATU direction macro usage.

While at it we suggest to convert the dw_pcie_disable_atu() method to
being more consistent with the dw_pcie_readl_atu{_ib}() and
dw_pcie_readl_atu{_ob}() functions by having the direction parameter
specified ahead of the region index. Thus the code will be a little bit
more pleasant to read.

Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
---
 drivers/pci/controller/dwc/pcie-designware-ep.c  |  4 ++--
 .../pci/controller/dwc/pcie-designware-host.c    |  2 +-
 drivers/pci/controller/dwc/pcie-designware.c     | 16 +---------------
 drivers/pci/controller/dwc/pcie-designware.h     |  9 +--------
 4 files changed, 5 insertions(+), 26 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
index 3bd9026071e8..83ceba84b79d 100644
--- a/drivers/pci/controller/dwc/pcie-designware-ep.c
+++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
@@ -212,7 +212,7 @@ static void dw_pcie_ep_clear_bar(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
 
 	__dw_pcie_ep_reset_bar(pci, func_no, bar, epf_bar->flags);
 
-	dw_pcie_disable_atu(pci, atu_index, DW_PCIE_REGION_INBOUND);
+	dw_pcie_disable_atu(pci, PCIE_ATU_REGION_DIR_IB, atu_index);
 	clear_bit(atu_index, ep->ib_window_map);
 	ep->epf_bar[bar] = NULL;
 }
@@ -286,7 +286,7 @@ static void dw_pcie_ep_unmap_addr(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
 	if (ret < 0)
 		return;
 
-	dw_pcie_disable_atu(pci, atu_index, DW_PCIE_REGION_OUTBOUND);
+	dw_pcie_disable_atu(pci, PCIE_ATU_REGION_DIR_OB, atu_index);
 	clear_bit(atu_index, ep->ob_window_map);
 }
 
diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index 602cf4fe502b..e9aa3d8539d8 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -644,7 +644,7 @@ void dw_pcie_setup_rc(struct pcie_port *pp)
 		 * multiple matches
 		 */
 		for (i = 0; i < pci->num_ob_windows; i++)
-			dw_pcie_disable_atu(pci, i, DW_PCIE_REGION_OUTBOUND);
+			dw_pcie_disable_atu(pci, PCIE_ATU_REGION_DIR_OB, i);
 
 		/* Get last memory resource entry */
 		resource_list_for_each_entry(entry, &pp->bridge->windows) {
diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
index f1aa6e2e85fe..ce360986609f 100644
--- a/drivers/pci/controller/dwc/pcie-designware.c
+++ b/drivers/pci/controller/dwc/pcie-designware.c
@@ -421,22 +421,8 @@ int dw_pcie_prog_inbound_atu(struct dw_pcie *pci, u8 func_no, int index,
 	return -ETIMEDOUT;
 }
 
-void dw_pcie_disable_atu(struct dw_pcie *pci, int index,
-			 enum dw_pcie_region_type type)
+void dw_pcie_disable_atu(struct dw_pcie *pci, u32 dir, int index)
 {
-	u32 dir;
-
-	switch (type) {
-	case DW_PCIE_REGION_INBOUND:
-		dir = PCIE_ATU_REGION_DIR_IB;
-		break;
-	case DW_PCIE_REGION_OUTBOUND:
-		dir = PCIE_ATU_REGION_DIR_OB;
-		break;
-	default:
-		return;
-	}
-
 	dw_pcie_writel_atu(pci, dir, index, PCIE_ATU_REGION_CTRL2, 0);
 }
 
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index 6adf0c957c3b..203f9dfb9048 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -175,12 +175,6 @@ struct pcie_port;
 struct dw_pcie;
 struct dw_pcie_ep;
 
-enum dw_pcie_region_type {
-	DW_PCIE_REGION_UNKNOWN,
-	DW_PCIE_REGION_INBOUND,
-	DW_PCIE_REGION_OUTBOUND,
-};
-
 enum dw_pcie_device_mode {
 	DW_PCIE_UNKNOWN_TYPE,
 	DW_PCIE_EP_TYPE,
@@ -316,8 +310,7 @@ void dw_pcie_prog_ep_outbound_atu(struct dw_pcie *pci, u8 func_no, int index,
 				  u64 size);
 int dw_pcie_prog_inbound_atu(struct dw_pcie *pci, u8 func_no, int index,
 			     int type, u64 cpu_addr, u8 bar);
-void dw_pcie_disable_atu(struct dw_pcie *pci, int index,
-			 enum dw_pcie_region_type type);
+void dw_pcie_disable_atu(struct dw_pcie *pci, u32 dir, int index);
 void dw_pcie_setup(struct dw_pcie *pci);
 void dw_pcie_iatu_detect(struct dw_pcie *pci);
 
-- 
2.35.1

