Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4954C185473
	for <lists+linux-pci@lfdr.de>; Sat, 14 Mar 2020 04:45:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726766AbgCNDor (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 13 Mar 2020 23:44:47 -0400
Received: from inva020.nxp.com ([92.121.34.13]:60774 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726399AbgCNDoq (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 13 Mar 2020 23:44:46 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 6D3971A1983;
        Sat, 14 Mar 2020 04:44:45 +0100 (CET)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 974B61A1952;
        Sat, 14 Mar 2020 04:44:35 +0100 (CET)
Received: from titan.ap.freescale.net (titan.ap.freescale.net [10.192.208.233])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 1974A402F3;
        Sat, 14 Mar 2020 11:44:24 +0800 (SGT)
From:   Xiaowei Bao <xiaowei.bao@nxp.com>
To:     Zhiqiang.Hou@nxp.com, Minghuan.Lian@nxp.com, mingkai.hu@nxp.com,
        bhelgaas@google.com, robh+dt@kernel.org, shawnguo@kernel.org,
        leoyang.li@nxp.com, kishon@ti.com, lorenzo.pieralisi@arm.com,
        roy.zang@nxp.com, amurray@thegoodpenguin.co.uk,
        jingoohan1@gmail.com, gustavo.pimentel@synopsys.com,
        andrew.murray@arm.com, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org
Cc:     Xiaowei Bao <xiaowei.bao@nxp.com>
Subject: [PATCH v6 05/11] dt-bindings: pci: layerscape-pci: Add compatible strings for ls1088a and ls2088a
Date:   Sat, 14 Mar 2020 11:30:32 +0800
Message-Id: <20200314033038.24844-6-xiaowei.bao@nxp.com>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200314033038.24844-1-xiaowei.bao@nxp.com>
References: <20200314033038.24844-1-xiaowei.bao@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add compatible strings for ls1088a and ls2088a.

Signed-off-by: Xiaowei Bao <xiaowei.bao@nxp.com>
Acked-by: Rob Herring <robh@kernel.org>
---
v2:
 - No change.
v3:
 - Use one valid combination of compatible strings.
v4:
 - Add the comma between the two compatible.
v5:
 - No change.
v6:
 - No change.

 Documentation/devicetree/bindings/pci/layerscape-pci.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/layerscape-pci.txt b/Documentation/devicetree/bindings/pci/layerscape-pci.txt
index 99a386e..daa99f7 100644
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
2.9.5

