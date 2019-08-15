Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 46DEE8E746
	for <lists+linux-pci@lfdr.de>; Thu, 15 Aug 2019 10:48:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731118AbfHOIr4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 15 Aug 2019 04:47:56 -0400
Received: from inva020.nxp.com ([92.121.34.13]:59638 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731108AbfHOIrz (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 15 Aug 2019 04:47:55 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 2463B1A046A;
        Thu, 15 Aug 2019 10:47:54 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 71AA51A046E;
        Thu, 15 Aug 2019 10:47:45 +0200 (CEST)
Received: from titan.ap.freescale.net (TITAN.ap.freescale.net [10.192.208.233])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 9F07440305;
        Thu, 15 Aug 2019 16:47:34 +0800 (SGT)
From:   Xiaowei Bao <xiaowei.bao@nxp.com>
To:     jingoohan1@gmail.com, gustavo.pimentel@synopsys.com,
        bhelgaas@google.com, robh+dt@kernel.org, mark.rutland@arm.com,
        shawnguo@kernel.org, leoyang.li@nxp.com, kishon@ti.com,
        lorenzo.pieralisi@arm.com, arnd@arndb.de,
        gregkh@linuxfoundation.org, minghuan.Lian@nxp.com,
        mingkai.hu@nxp.com, roy.zang@nxp.com, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org
Cc:     Xiaowei Bao <xiaowei.bao@nxp.com>
Subject: [PATCH 07/10] PCI: layerscape: Fix some format issue of the code
Date:   Thu, 15 Aug 2019 16:37:13 +0800
Message-Id: <20190815083716.4715-7-xiaowei.bao@nxp.com>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20190815083716.4715-1-xiaowei.bao@nxp.com>
References: <20190815083716.4715-1-xiaowei.bao@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Fix some format issue of the code in EP driver.

Signed-off-by: Xiaowei Bao <xiaowei.bao@nxp.com>
---
 drivers/pci/controller/dwc/pci-layerscape-ep.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-layerscape-ep.c b/drivers/pci/controller/dwc/pci-layerscape-ep.c
index a0cd5ff..2ada445 100644
--- a/drivers/pci/controller/dwc/pci-layerscape-ep.c
+++ b/drivers/pci/controller/dwc/pci-layerscape-ep.c
@@ -64,7 +64,7 @@ static void ls_pcie_ep_init(struct dw_pcie_ep *ep)
 }
 
 static int ls_pcie_ep_raise_irq(struct dw_pcie_ep *ep, u8 func_no,
-				  enum pci_epc_irq_type type, u16 interrupt_num)
+				enum pci_epc_irq_type type, u16 interrupt_num)
 {
 	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
 
@@ -89,7 +89,7 @@ static const struct dw_pcie_ep_ops pcie_ep_ops = {
 };
 
 static int __init ls_add_pcie_ep(struct ls_pcie_ep *pcie,
-					struct platform_device *pdev)
+				 struct platform_device *pdev)
 {
 	struct dw_pcie *pci = pcie->pci;
 	struct device *dev = pci->dev;
-- 
2.9.5

