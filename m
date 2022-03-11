Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 280554D6B36
	for <lists+linux-pci@lfdr.de>; Sat, 12 Mar 2022 01:04:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229573AbiCKX5J (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 11 Mar 2022 18:57:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbiCKX5I (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 11 Mar 2022 18:57:08 -0500
X-Greylist: delayed 378 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 11 Mar 2022 15:56:04 PST
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ABC6FE406;
        Fri, 11 Mar 2022 15:56:04 -0800 (PST)
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id B2F07201315;
        Sat, 12 Mar 2022 00:49:45 +0100 (CET)
Received: from smtp.na-rdc02.nxp.com (usphx01srsp001v.us-phx01.nxp.com [134.27.49.11])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 77DFA201323;
        Sat, 12 Mar 2022 00:49:45 +0100 (CET)
Received: from right.am.freescale.net (right.am.freescale.net [10.81.116.142])
        by usphx01srsp001v.us-phx01.nxp.com (Postfix) with ESMTP id 5A42840577;
        Fri, 11 Mar 2022 16:49:44 -0700 (MST)
From:   Li Yang <leoyang.li@nxp.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     Hou Zhiqiang <Zhiqiang.Hou@nxp.com>, Rob Herring <robh@kernel.org>,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/4] dt-bindings: pci: layerscape-pci: Update the description of SCFG property
Date:   Fri, 11 Mar 2022 17:49:36 -0600
Message-Id: <20220311234938.8706-3-leoyang.li@nxp.com>
X-Mailer: git-send-email 2.25.1.377.g2d2118b
In-Reply-To: <20220311234938.8706-1-leoyang.li@nxp.com>
References: <20220311234938.8706-1-leoyang.li@nxp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>

Update the description of the second entry of 'fsl,pcie-scfg' property,
as the LS1043A PCIe controller also has some control registers in SCFG
block, while it has 3 controllers.

Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/pci/layerscape-pci.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/pci/layerscape-pci.txt b/Documentation/devicetree/bindings/pci/layerscape-pci.txt
index 215d2ee65c83..f1115fcd8088 100644
--- a/Documentation/devicetree/bindings/pci/layerscape-pci.txt
+++ b/Documentation/devicetree/bindings/pci/layerscape-pci.txt
@@ -34,7 +34,7 @@ Required properties:
   "intr": The interrupt that is asserted for controller interrupts
 - fsl,pcie-scfg: Must include two entries.
   The first entry must be a link to the SCFG device node
-  The second entry must be '0' or '1' based on physical PCIe controller index.
+  The second entry is the physical PCIe controller index starting from '0'.
   This is used to get SCFG PEXN registers
 - dma-coherent: Indicates that the hardware IP block can ensure the coherency
   of the data transferred from/to the IP block. This can avoid the software
-- 
2.25.1

