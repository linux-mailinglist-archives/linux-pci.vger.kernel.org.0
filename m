Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 37577A4DA2
	for <lists+linux-pci@lfdr.de>; Mon,  2 Sep 2019 05:28:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729353AbfIBD1r (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 1 Sep 2019 23:27:47 -0400
Received: from inva020.nxp.com ([92.121.34.13]:32918 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729343AbfIBD1q (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 1 Sep 2019 23:27:46 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 337861A064C;
        Mon,  2 Sep 2019 05:27:45 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 7A0AC1A0640;
        Mon,  2 Sep 2019 05:27:36 +0200 (CEST)
Received: from titan.ap.freescale.net (TITAN.ap.freescale.net [10.192.208.233])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id D4D8E40314;
        Mon,  2 Sep 2019 11:27:25 +0800 (SGT)
From:   Xiaowei Bao <xiaowei.bao@nxp.com>
To:     robh+dt@kernel.org, mark.rutland@arm.com, shawnguo@kernel.org,
        leoyang.li@nxp.com, kishon@ti.com, lorenzo.pieralisi@arm.com,
        minghuan.Lian@nxp.com, mingkai.hu@nxp.com, roy.zang@nxp.com,
        jingoohan1@gmail.com, gustavo.pimentel@synopsys.com,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org
Cc:     arnd@arndb.de, gregkh@linuxfoundation.org, zhiqiang.hou@nxp.com,
        Xiaowei Bao <xiaowei.bao@nxp.com>
Subject: [PATCH v3 05/11] dt-bindings: pci: layerscape-pci: add compatible strings for ls1088a and ls2088a
Date:   Mon,  2 Sep 2019 11:17:10 +0800
Message-Id: <20190902031716.43195-6-xiaowei.bao@nxp.com>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20190902031716.43195-1-xiaowei.bao@nxp.com>
References: <20190902031716.43195-1-xiaowei.bao@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add compatible strings for ls1088a and ls2088a.

Signed-off-by: Xiaowei Bao <xiaowei.bao@nxp.com>
---
v2:
 - No change.
v3:
 - Use one valid combination of compatible strings.

 Documentation/devicetree/bindings/pci/layerscape-pci.txt | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/pci/layerscape-pci.txt b/Documentation/devicetree/bindings/pci/layerscape-pci.txt
index e20ceaa..762ae41 100644
--- a/Documentation/devicetree/bindings/pci/layerscape-pci.txt
+++ b/Documentation/devicetree/bindings/pci/layerscape-pci.txt
@@ -22,7 +22,9 @@ Required properties:
         "fsl,ls1043a-pcie"
         "fsl,ls1012a-pcie"
   EP mode:
-	"fsl,ls1046a-pcie-ep", "fsl,ls-pcie-ep"
+	"fsl,ls1046a-pcie-ep" "fsl,ls-pcie-ep"
+	"fsl,ls1088a-pcie-ep" "fsl,ls-pcie-ep"
+	"fsl,ls2088a-pcie-ep" "fsl,ls-pcie-ep"
 - reg: base addresses and lengths of the PCIe controller register blocks.
 - interrupts: A list of interrupt outputs of the controller. Must contain an
   entry for each entry in the interrupt-names property.
-- 
2.9.5

