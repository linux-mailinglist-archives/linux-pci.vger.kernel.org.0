Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86096244647
	for <lists+linux-pci@lfdr.de>; Fri, 14 Aug 2020 10:15:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727053AbgHNIPc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 14 Aug 2020 04:15:32 -0400
Received: from inva020.nxp.com ([92.121.34.13]:46076 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726050AbgHNIPc (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 14 Aug 2020 04:15:32 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 0631B1A0372;
        Fri, 14 Aug 2020 10:15:31 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 384A61A0366;
        Fri, 14 Aug 2020 10:15:27 +0200 (CEST)
Received: from localhost.localdomain (mega.ap.freescale.net [10.192.208.232])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 36E9B402A8;
        Fri, 14 Aug 2020 10:15:22 +0200 (CEST)
From:   Zhiqiang Hou <Zhiqiang.Hou@nxp.com>
To:     linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        lorenzo.pieralisi@arm.com, robh@kernel.org, bhelgaas@google.com,
        amurray@thegoodpenguin.co.uk, jingoohan1@gmail.com,
        gustavo.pimentel@synopsys.com
Cc:     Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
Subject: [PATCH] PCI: designware-ep: Fix the Header Type check
Date:   Fri, 14 Aug 2020 16:08:13 +0800
Message-Id: <20200814080813.8070-1-Zhiqiang.Hou@nxp.com>
X-Mailer: git-send-email 2.17.1
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>

The current check will result in the multiple function device
fails to initialize. So fix the check by masking out the
multiple function bit.

Fixes: 0b24134f7888 ("PCI: dwc: Add validation that PCIe core is set to correct mode")
Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
---
 drivers/pci/controller/dwc/pcie-designware-ep.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
index 4680a51c49c0..4b7abfb1e669 100644
--- a/drivers/pci/controller/dwc/pcie-designware-ep.c
+++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
@@ -654,7 +654,7 @@ int dw_pcie_ep_init_complete(struct dw_pcie_ep *ep)
 	int i;
 
 	hdr_type = dw_pcie_readb_dbi(pci, PCI_HEADER_TYPE);
-	if (hdr_type != PCI_HEADER_TYPE_NORMAL) {
+	if (hdr_type & 0x7f != PCI_HEADER_TYPE_NORMAL) {
 		dev_err(pci->dev,
 			"PCIe controller is not set to EP mode (hdr_type:0x%x)!\n",
 			hdr_type);
-- 
2.17.1

