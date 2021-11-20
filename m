Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94289457A0B
	for <lists+linux-pci@lfdr.de>; Sat, 20 Nov 2021 01:16:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236504AbhKTATg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 19 Nov 2021 19:19:36 -0500
Received: from inva021.nxp.com ([92.121.34.21]:59988 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236442AbhKTATa (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 19 Nov 2021 19:19:30 -0500
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id E588A201809;
        Sat, 20 Nov 2021 01:16:26 +0100 (CET)
Received: from smtp.na-rdc02.nxp.com (usphx01srsp001v.us-phx01.nxp.com [134.27.49.11])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id A8838200A97;
        Sat, 20 Nov 2021 01:16:26 +0100 (CET)
Received: from right.am.freescale.net (right.am.freescale.net [10.81.116.142])
        by usphx01srsp001v.us-phx01.nxp.com (Postfix) with ESMTP id C7B4B40BF7;
        Fri, 19 Nov 2021 17:16:25 -0700 (MST)
From:   Li Yang <leoyang.li@nxp.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
Cc:     Xiaowei Bao <xiaowei.bao@nxp.com>, Li Yang <leoyang.li@nxp.com>
Subject: [PATCH 3/4] dt-bindings: pci: layerscape-pci: Add EP mode compatible strings for ls1028a
Date:   Fri, 19 Nov 2021 18:16:20 -0600
Message-Id: <20211120001621.21246-4-leoyang.li@nxp.com>
X-Mailer: git-send-email 2.25.1.377.g2d2118b
In-Reply-To: <20211120001621.21246-1-leoyang.li@nxp.com>
References: <20211120001621.21246-1-leoyang.li@nxp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Xiaowei Bao <xiaowei.bao@nxp.com>

Add EP mode compatible string for ls1028a.

Signed-off-by: Xiaowei Bao <xiaowei.bao@nxp.com>
Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
Signed-off-by: Li Yang <leoyang.li@nxp.com>
---
 Documentation/devicetree/bindings/pci/layerscape-pci.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/pci/layerscape-pci.txt b/Documentation/devicetree/bindings/pci/layerscape-pci.txt
index f1115fcd8088..8fd6039a826b 100644
--- a/Documentation/devicetree/bindings/pci/layerscape-pci.txt
+++ b/Documentation/devicetree/bindings/pci/layerscape-pci.txt
@@ -23,6 +23,7 @@ Required properties:
         "fsl,ls1012a-pcie"
         "fsl,ls1028a-pcie"
   EP mode:
+	"fsl,ls1028a-pcie-ep", "fsl,ls-pcie-ep"
 	"fsl,ls1046a-pcie-ep", "fsl,ls-pcie-ep"
 	"fsl,ls1088a-pcie-ep", "fsl,ls-pcie-ep"
 	"fsl,ls2088a-pcie-ep", "fsl,ls-pcie-ep"
-- 
2.25.1

