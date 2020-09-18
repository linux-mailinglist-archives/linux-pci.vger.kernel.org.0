Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5F8226F81C
	for <lists+linux-pci@lfdr.de>; Fri, 18 Sep 2020 10:24:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726502AbgIRIYO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 18 Sep 2020 04:24:14 -0400
Received: from inva021.nxp.com ([92.121.34.21]:40994 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726370AbgIRIYA (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 18 Sep 2020 04:24:00 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 47F11201763;
        Fri, 18 Sep 2020 10:08:50 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id EB0D62010F1;
        Fri, 18 Sep 2020 10:08:42 +0200 (CEST)
Received: from localhost.localdomain (mega.ap.freescale.net [10.192.208.232])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 0A46A40314;
        Fri, 18 Sep 2020 10:08:33 +0200 (CEST)
From:   Zhiqiang Hou <Zhiqiang.Hou@nxp.com>
To:     linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        robh+dt@kernel.org, lorenzo.pieralisi@arm.com, bhelgaas@google.com,
        shawnguo@kernel.org, kishon@ti.com, leoyang.li@nxp.com,
        gustavo.pimentel@synopsys.com, arnd@arndb.de,
        gregkh@linuxfoundation.org, andrew.murray@arm.com
Cc:     minghuan.Lian@nxp.com, mingkai.hu@nxp.com, roy.zang@nxp.com,
        Xiaowei Bao <xiaowei.bao@nxp.com>,
        Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
Subject: [PATCHv8 03/12] PCI: designware-ep: Move the function of getting MSI capability forward
Date:   Fri, 18 Sep 2020 16:00:15 +0800
Message-Id: <20200918080024.13639-4-Zhiqiang.Hou@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200918080024.13639-1-Zhiqiang.Hou@nxp.com>
References: <20200918080024.13639-1-Zhiqiang.Hou@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Xiaowei Bao <xiaowei.bao@nxp.com>

Move the function of getting MSI capability to the front of init
function, because the init function of the EP platform driver will use
the return value by the function of getting MSI capability.

Signed-off-by: Xiaowei Bao <xiaowei.bao@nxp.com>
Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
Reviewed-by: Andrew Murray <andrew.murray@arm.com>
---
V8:
 - No change.

 drivers/pci/controller/dwc/pcie-designware-ep.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
index 5ae87e8ffb85..25767a334259 100644
--- a/drivers/pci/controller/dwc/pcie-designware-ep.c
+++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
@@ -582,10 +582,6 @@ int dw_pcie_ep_init_complete(struct dw_pcie_ep *ep)
 		return -EIO;
 	}
 
-	ep->msi_cap = dw_pcie_find_capability(pci, PCI_CAP_ID_MSI);
-
-	ep->msix_cap = dw_pcie_find_capability(pci, PCI_CAP_ID_MSIX);
-
 	offset = dw_pcie_ep_find_ext_capability(pci, PCI_EXT_CAP_ID_REBAR);
 
 	dw_pcie_dbi_ro_wr_en(pci);
@@ -677,6 +673,10 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
 	if (ret < 0)
 		epc->max_functions = 1;
 
+	ep->msi_cap = dw_pcie_find_capability(pci, PCI_CAP_ID_MSI);
+
+	ep->msix_cap = dw_pcie_find_capability(pci, PCI_CAP_ID_MSIX);
+
 	if (ep->ops->ep_init)
 		ep->ops->ep_init(ep);
 
-- 
2.17.1

