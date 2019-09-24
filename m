Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0A84CBC014
	for <lists+linux-pci@lfdr.de>; Tue, 24 Sep 2019 04:31:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408592AbfIXC3j (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 23 Sep 2019 22:29:39 -0400
Received: from inva020.nxp.com ([92.121.34.13]:38828 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406127AbfIXC3i (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 23 Sep 2019 22:29:38 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 2EADC1A0A01;
        Tue, 24 Sep 2019 04:29:36 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 6B1521A09F9;
        Tue, 24 Sep 2019 04:29:28 +0200 (CEST)
Received: from titan.ap.freescale.net (TITAN.ap.freescale.net [10.192.208.233])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 9D3964030F;
        Tue, 24 Sep 2019 10:29:17 +0800 (SGT)
From:   Xiaowei Bao <xiaowei.bao@nxp.com>
To:     robh+dt@kernel.org, mark.rutland@arm.com, shawnguo@kernel.org,
        leoyang.li@nxp.com, kishon@ti.com, lorenzo.pieralisi@arm.com,
        minghuan.Lian@nxp.com, mingkai.hu@nxp.com, roy.zang@nxp.com,
        jingoohan1@gmail.com, gustavo.pimentel@synopsys.com,
        andrew.murray@arm.com, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc:     Xiaowei Bao <xiaowei.bao@nxp.com>
Subject: [PATCH v4 03/11] PCI: designware-ep: Move the function of getting MSI capability forward
Date:   Tue, 24 Sep 2019 10:18:41 +0800
Message-Id: <20190924021849.3185-4-xiaowei.bao@nxp.com>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20190924021849.3185-1-xiaowei.bao@nxp.com>
References: <20190924021849.3185-1-xiaowei.bao@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Move the function of getting MSI capability to the front of init
function, because the init function of the EP platform driver will use
the return value by the function of getting MSI capability.

Signed-off-by: Xiaowei Bao <xiaowei.bao@nxp.com>
Reviewed-by: Andrew Murray <andrew.murray@arm.com>
---
v2:
 - No change.
v3:
 - No change.
v4:
 - No change.

 drivers/pci/controller/dwc/pcie-designware-ep.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
index 55b23ce..c3bc7bd 100644
--- a/drivers/pci/controller/dwc/pcie-designware-ep.c
+++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
@@ -624,6 +624,10 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
 	if (ret < 0)
 		epc->max_functions = 1;
 
+	ep->msi_cap = dw_pcie_find_capability(pci, PCI_CAP_ID_MSI);
+
+	ep->msix_cap = dw_pcie_find_capability(pci, PCI_CAP_ID_MSIX);
+
 	if (ep->ops->ep_init)
 		ep->ops->ep_init(ep);
 
@@ -640,9 +644,6 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
 		dev_err(dev, "Failed to reserve memory for MSI/MSI-X\n");
 		return -ENOMEM;
 	}
-	ep->msi_cap = dw_pcie_find_capability(pci, PCI_CAP_ID_MSI);
-
-	ep->msix_cap = dw_pcie_find_capability(pci, PCI_CAP_ID_MSIX);
 
 	offset = dw_pcie_ep_find_ext_capability(pci, PCI_EXT_CAP_ID_REBAR);
 	if (offset) {
-- 
2.9.5

