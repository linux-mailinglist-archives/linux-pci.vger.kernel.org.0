Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B855241950
	for <lists+linux-pci@lfdr.de>; Tue, 11 Aug 2020 12:02:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728517AbgHKKCO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 11 Aug 2020 06:02:14 -0400
Received: from inva021.nxp.com ([92.121.34.21]:41900 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728502AbgHKKCL (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 11 Aug 2020 06:02:11 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 5B6ED201EF0;
        Tue, 11 Aug 2020 12:02:09 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 1B134201EFB;
        Tue, 11 Aug 2020 12:02:02 +0200 (CEST)
Received: from localhost.localdomain (mega.ap.freescale.net [10.192.208.232])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 8AE314032C;
        Tue, 11 Aug 2020 12:01:52 +0200 (CEST)
From:   Zhiqiang Hou <Zhiqiang.Hou@nxp.com>
To:     linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, robh+dt@kernel.org,
        bhelgaas@google.com, lorenzo.pieralisi@arm.com,
        shawnguo@kernel.org, leoyang.li@nxp.com, kishon@ti.com,
        gustavo.pimentel@synopsys.com, roy.zang@nxp.com,
        jingoohan1@gmail.com, andrew.murray@arm.com
Cc:     mingkai.hu@nxp.com, minghuan.Lian@nxp.com,
        Xiaowei Bao <xiaowei.bao@nxp.com>,
        Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
Subject: [PATCHv7 05/12] dt-bindings: pci: layerscape-pci: Add compatible strings for ls1088a and ls2088a
Date:   Tue, 11 Aug 2020 17:54:34 +0800
Message-Id: <20200811095441.7636-6-Zhiqiang.Hou@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200811095441.7636-1-Zhiqiang.Hou@nxp.com>
References: <20200811095441.7636-1-Zhiqiang.Hou@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Xiaowei Bao <xiaowei.bao@nxp.com>

Add compatible strings for ls1088a and ls2088a.

Signed-off-by: Xiaowei Bao <xiaowei.bao@nxp.com>
Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
---
V7:
 - Rebase the patch without functionality change.

 Documentation/devicetree/bindings/pci/layerscape-pci.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/layerscape-pci.txt b/Documentation/devicetree/bindings/pci/layerscape-pci.txt
index 99a386ea691c..daa99f7d4c3f 100644
--- a/Documentation/devicetree/bindings/pci/layerscape-pci.txt
+++ b/Documentation/devicetree/bindings/pci/layerscape-pci.txt
@@ -24,6 +24,8 @@ Required properties:
         "fsl,ls1028a-pcie"
   EP mode:
 	"fsl,ls1046a-pcie-ep", "fsl,ls-pcie-ep"
+	"fsl,ls1088a-pcie-ep", "fsl,ls-pcie-ep"
+	"fsl,ls2088a-pcie-ep", "fsl,ls-pcie-ep"
 - reg: base addresses and lengths of the PCIe controller register blocks.
 - interrupts: A list of interrupt outputs of the controller. Must contain an
   entry for each entry in the interrupt-names property.
-- 
2.17.1

