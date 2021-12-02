Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93379465B4C
	for <lists+linux-pci@lfdr.de>; Thu,  2 Dec 2021 01:46:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344437AbhLBAuI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 1 Dec 2021 19:50:08 -0500
Received: from inva020.nxp.com ([92.121.34.13]:41266 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1354928AbhLBAuH (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 1 Dec 2021 19:50:07 -0500
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 731DC1A0045;
        Thu,  2 Dec 2021 01:46:45 +0100 (CET)
Received: from smtp.na-rdc02.nxp.com (usphx01srsp001v.us-phx01.nxp.com [134.27.49.11])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 3612B1A1482;
        Thu,  2 Dec 2021 01:46:45 +0100 (CET)
Received: from right.am.freescale.net (right.am.freescale.net [10.81.116.142])
        by usphx01srsp001v.us-phx01.nxp.com (Postfix) with ESMTP id 58F134043C;
        Wed,  1 Dec 2021 17:46:44 -0700 (MST)
From:   Li Yang <leoyang.li@nxp.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
Cc:     Rob Herring <robh@kernel.org>
Subject: [PATCH v2 1/4] dt-bindings: pci: layerscape-pci: Add a optional property big-endian
Date:   Wed,  1 Dec 2021 18:46:33 -0600
Message-Id: <20211202004636.5276-2-leoyang.li@nxp.com>
X-Mailer: git-send-email 2.25.1.377.g2d2118b
In-Reply-To: <20211202004636.5276-1-leoyang.li@nxp.com>
References: <20211202004636.5276-1-leoyang.li@nxp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>

This property is to indicate the endianness when accessing the
PEX_LUT and PF register block, so if these registers are
implemented in big-endian, specify this property.

Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/pci/layerscape-pci.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/layerscape-pci.txt b/Documentation/devicetree/bindings/pci/layerscape-pci.txt
index f36efa73a470..215d2ee65c83 100644
--- a/Documentation/devicetree/bindings/pci/layerscape-pci.txt
+++ b/Documentation/devicetree/bindings/pci/layerscape-pci.txt
@@ -40,6 +40,10 @@ Required properties:
   of the data transferred from/to the IP block. This can avoid the software
   cache flush/invalid actions, and improve the performance significantly.
 
+Optional properties:
+- big-endian: If the PEX_LUT and PF register block is in big-endian, specify
+  this property.
+
 Example:
 
 	pcie@3400000 {
-- 
2.25.1

