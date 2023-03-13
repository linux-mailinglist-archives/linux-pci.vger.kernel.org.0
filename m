Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5962A6B77D9
	for <lists+linux-pci@lfdr.de>; Mon, 13 Mar 2023 13:43:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230234AbjCMMnO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 13 Mar 2023 08:43:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230086AbjCMMm6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 13 Mar 2023 08:42:58 -0400
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E043964A9A;
        Mon, 13 Mar 2023 05:42:23 -0700 (PDT)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32D6OxcN020021;
        Mon, 13 Mar 2023 05:42:15 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=pfpt0220; bh=aaeXNgwpp6Zy5Dgr92iuq1Nr5/oDxipG6De41HDKGy8=;
 b=NTn3jWp09n8JuQ+kjvl3KajPsPtttiqruRNqBSTTo+dMIQaE2141AMBthozypELFoEdq
 bua+aM+VqJ0Ob+WIET4Q3EJc2XXUGyPi9zKxGRZymuEaQoKcbVx8weGdUo7NWwt/CHNQ
 CsCxP4mpil/92K3IZq4/GmysuKtdXkQc9JCRFzzVEwBUGOjV/BMLauhOhKL/tNZR22lO
 JIDbCb1TWoJ9xqdTypP3J4YZO8jwjqAnOHJyHHQt9SP7YU8fK4HD/VRY6eBO4fQOs+Z2
 049oqaPhV8vn4TPbY1haQczMpxm4W/2WtEedF+VQ/tNIsu7t5rgHKYVSfp1tPbKZ0jFv Fw== 
Received: from dc5-exch01.marvell.com ([199.233.59.181])
        by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3p8t1t5gex-18
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 13 Mar 2023 05:42:14 -0700
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Mon, 13 Mar
 2023 05:41:14 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server id 15.0.1497.42 via Frontend
 Transport; Mon, 13 Mar 2023 05:41:14 -0700
Received: from jupiter073.il.marvell.com (unknown [10.5.116.85])
        by maili.marvell.com (Postfix) with ESMTP id 8459A5B6921;
        Mon, 13 Mar 2023 05:41:10 -0700 (PDT)
From:   Elad Nachman <enachman@marvell.com>
To:     <thomas.petazzoni@bootlin.com>, <bhelgaas@google.com>,
        <lpieralisi@kernel.org>, <robh@kernel.org>, <kw@linux.com>,
        <krzysztof.kozlowski+dt@linaro.org>, <linux-pci@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Elad Nachman <enachman@marvell.com>
Subject: [PATCH v4 4/8] dt-bindings: PCI: dwc: Add dma-ranges, region mask
Date:   Mon, 13 Mar 2023 14:40:12 +0200
Message-ID: <20230313124016.17102-5-enachman@marvell.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230313124016.17102-1-enachman@marvell.com>
References: <20230313124016.17102-1-enachman@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-GUID: eCJZqwhSSm_hjhuKhOV91Q5XDz7EC0Vg
X-Proofpoint-ORIG-GUID: eCJZqwhSSm_hjhuKhOV91Q5XDz7EC0Vg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-13_05,2023-03-13_01,2023-02-09_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Elad Nachman <enachman@marvell.com>

Add properties to support configurable DMA mask bits and region mask bits:

 1. configurable dma-ranges is needed for Marvell AC5/AC5X SOCs which
    have their physical DDR memory start at address 0x2_0000_0000.

 2. Configurable region mask bits is needed for the Marvell Armada
    7020/7040/8040 SOCs when the DT file places the PCIe window above the 4GB region.
    The Synopsis Designware PCIe IP in these SOCs is too old to specify the
    highest memory location supported by the PCIe, but practically supports
    such locations. Allow these locations to be specified in the DT file.

Signed-off-by: Elad Nachman <enachman@marvell.com>
---
v4:
   1) Fix commit message and its formatting

   2) Replace num-dmamask with dma-ranges

 .../devicetree/bindings/pci/snps,dw-pcie-common.yaml        | 5 +++++
 Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml     | 6 ++++++
 2 files changed, 11 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/snps,dw-pcie-common.yaml b/Documentation/devicetree/bindings/pci/snps,dw-pcie-common.yaml
index d87e13496834..3cb9af1aefeb 100644
--- a/Documentation/devicetree/bindings/pci/snps,dw-pcie-common.yaml
+++ b/Documentation/devicetree/bindings/pci/snps,dw-pcie-common.yaml
@@ -261,6 +261,11 @@ properties:
 
   dma-coherent: true
 
+  num-regionmask:
+    description: |
+      number of region limit mask bits to use, if different than default 32
+    maximum: 64
+
 additionalProperties: true
 
 ...
diff --git a/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml b/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml
index 1a83f0f65f19..ed7ae2a14804 100644
--- a/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml
@@ -197,6 +197,12 @@ properties:
       - contains:
           const: msi
 
+  dma-ranges:
+    description:
+      Defines the DMA mask for devices which due to non-standard HW address
+      assignment have their RAM starting address above the lower 32-bit region.
+      Since this is a mask, only the size attribute of the dma-ranges is used.
+
 additionalProperties: true
 
 required:
-- 
2.17.1

