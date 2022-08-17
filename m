Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C85E5977C4
	for <lists+linux-pci@lfdr.de>; Wed, 17 Aug 2022 22:23:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241395AbiHQUUJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 17 Aug 2022 16:20:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237975AbiHQUUI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 17 Aug 2022 16:20:08 -0400
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 931029C1F0;
        Wed, 17 Aug 2022 13:20:07 -0700 (PDT)
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id A6760200255;
        Wed, 17 Aug 2022 22:20:05 +0200 (CEST)
Received: from smtp.na-rdc02.nxp.com (usphx01srsp001v.us-phx01.nxp.com [134.27.49.11])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 69D2E20024C;
        Wed, 17 Aug 2022 22:20:05 +0200 (CEST)
Received: from right.am.freescale.net (right.am.freescale.net [10.81.116.134])
        by usphx01srsp001v.us-phx01.nxp.com (Postfix) with ESMTP id 38B7D40AA2;
        Wed, 17 Aug 2022 13:20:04 -0700 (MST)
From:   Li Yang <leoyang.li@nxp.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Li Yang <leoyang.li@nxp.com>, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: pci: layerscape-pci: Add new compatible string for lx2160a Rev2
Date:   Wed, 17 Aug 2022 15:19:46 -0500
Message-Id: <20220817201946.21141-1-leoyang.li@nxp.com>
X-Mailer: git-send-email 2.25.1.377.g2d2118b
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The lx2160a Rev2 uses a different controller from Rev1.  It is
compatible with fsl,ls2088a-pcie, but also define a new SoC specific
compatible string for it for future proof.

Signed-off-by: Li Yang <leoyang.li@nxp.com>
---
 Documentation/devicetree/bindings/pci/layerscape-pci.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/pci/layerscape-pci.txt b/Documentation/devicetree/bindings/pci/layerscape-pci.txt
index ee8a4791a78b..43c3c8792cb2 100644
--- a/Documentation/devicetree/bindings/pci/layerscape-pci.txt
+++ b/Documentation/devicetree/bindings/pci/layerscape-pci.txt
@@ -22,6 +22,7 @@ Required properties:
         "fsl,ls1043a-pcie"
         "fsl,ls1012a-pcie"
         "fsl,ls1028a-pcie"
+	"fsl,lx2160ar2-pcie", "fsl,ls2088a-pcie"
   EP mode:
 	"fsl,ls1028a-pcie-ep", "fsl,ls-pcie-ep"
 	"fsl,ls1046a-pcie-ep", "fsl,ls-pcie-ep"
-- 
2.37.1

