Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 774B16A0F1E
	for <lists+linux-pci@lfdr.de>; Thu, 23 Feb 2023 19:06:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230466AbjBWSGW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 23 Feb 2023 13:06:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230490AbjBWSGU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 23 Feb 2023 13:06:20 -0500
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B57F85AB48;
        Thu, 23 Feb 2023 10:06:13 -0800 (PST)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31NHUj4E027047;
        Thu, 23 Feb 2023 10:06:04 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=pfpt0220; bh=mlHi/Pr6AkJvbTefmm/F5tsWvHitizUD82E7QAHPtR0=;
 b=gOleKfJ9c4zg4oaYDhF8F4pJm3VZVyVhbuhea/ld3FPzzcFtD5T3AeaBQwwm/W5GIADz
 WJxYegeYoHuX2y2Y/1cWG/Q1yubuKZJQ2bPBCt2nsgtm/M6ffuWv8bcytzvfjjAt2gQH
 A0qJrFlT5sRhahEhnWEH1QWIngn0fCNGtsa81Nx5qVtPRQuyCPDdnUOC0Hsm75C9MtVD
 AAO/DgDFu+NRCb1oe8ZZzwQWgSbqMCWUTAEJaZ4T2EGvev7JsV6qyLLDeZzv+PPOfYCZ
 d1r+qOrU+5m4xjWNFJ5qsG2s016NMln0pLHVfOg6NPy5099HsI8zD8e+F5IGrNN+8tGl fg== 
Received: from dc5-exch02.marvell.com ([199.233.59.182])
        by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3nwy5h2cwc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 23 Feb 2023 10:06:03 -0800
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Thu, 23 Feb
 2023 10:06:02 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server id 15.0.1497.42 via Frontend
 Transport; Thu, 23 Feb 2023 10:06:02 -0800
Received: from jupiter073.il.marvell.com (unknown [10.5.116.85])
        by maili.marvell.com (Postfix) with ESMTP id 5A5DF3F709A;
        Thu, 23 Feb 2023 10:05:59 -0800 (PST)
From:   Elad Nachman <enachman@marvell.com>
To:     <thomas.petazzoni@bootlin.com>, <bhelgaas@google.com>,
        <lpieralisi@kernel.org>, <robh@kernel.org>, <kw@linux.com>,
        <krzysztof.kozlowski+dt@linaro.org>, <linux-pci@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Elad Nachman <enachman@marvell.com>
Subject: [PATCH v3 4/7] dt-bindings: PCI: dwc: add DMA, region mask bits
Date:   Thu, 23 Feb 2023 20:05:28 +0200
Message-ID: <20230223180531.15148-5-enachman@marvell.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230223180531.15148-1-enachman@marvell.com>
References: <20230223180531.15148-1-enachman@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-GUID: SK_ePFW_FMStnAg1H46EK2rEnVYzUGLn
X-Proofpoint-ORIG-GUID: SK_ePFW_FMStnAg1H46EK2rEnVYzUGLn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-23_11,2023-02-23_01,2023-02-09_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Elad Nachman <enachman@marvell.com>

Add properties to support configurable DMA mask bits
and region mask bits.
configurable DMA mask bits is needed for Marvell AC5/AC5X SOCs which
have their physical DDR memory start at address 0x2_0000_0000.
Configurable region mask bits is needed for the Marvell Armada
7020/7040/8040 SOCs when the DT file places the PCIe window above the
4GB region.
The Synopsis Designware PCIe IP in these SOCs is too old to specify the
highest memory location supported by the PCIe, but practically supports
such locations. Allow these locations to be specified in the DT file.
First DT property is called num-dmamask,
and can range between 33 and 64.
Second DT property is called num-regionmask,
and can range between 33 and 64.

Signed-off-by: Elad Nachman <enachman@marvell.com>
---
 .../devicetree/bindings/pci/snps,dw-pcie-common.yaml   | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/snps,dw-pcie-common.yaml b/Documentation/devicetree/bindings/pci/snps,dw-pcie-common.yaml
index d87e13496834..a1b06ff19ca7 100644
--- a/Documentation/devicetree/bindings/pci/snps,dw-pcie-common.yaml
+++ b/Documentation/devicetree/bindings/pci/snps,dw-pcie-common.yaml
@@ -261,6 +261,16 @@ properties:
 
   dma-coherent: true
 
+  num-dmamask:
+    description: |
+      number of dma mask bits to use, if different than default 32
+    maximum: 64
+
+  num-regionmask:
+    description: |
+      number of region limit mask bits to use, if different than default 32
+    maximum: 64
+
 additionalProperties: true
 
 ...
-- 
2.17.1

