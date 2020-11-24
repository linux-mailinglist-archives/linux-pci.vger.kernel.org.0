Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E90602C1DC4
	for <lists+linux-pci@lfdr.de>; Tue, 24 Nov 2020 06:55:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727976AbgKXFyJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 24 Nov 2020 00:54:09 -0500
Received: from relmlor2.renesas.com ([210.160.252.172]:59419 "EHLO
        relmlie6.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727193AbgKXFyJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 24 Nov 2020 00:54:09 -0500
X-IronPort-AV: E=Sophos;i="5.78,365,1599490800"; 
   d="scan'208";a="63462355"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 24 Nov 2020 14:49:05 +0900
Received: from localhost.localdomain (unknown [10.166.15.86])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id 0F1AE4201A27;
        Tue, 24 Nov 2020 14:49:05 +0900 (JST)
From:   Yuya Hamamachi <yuya.hamamachi.sx@renesas.com>
To:     linux-pci@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Yuya Hamamachi <yuya.hamamachi.sx@renesas.com>
Subject: [PATCH 1/2] dt-bindings: pci: rcar-pci-ep: Document r8a7795
Date:   Tue, 24 Nov 2020 14:42:17 +0900
Message-Id: <20201124054218.3005-2-yuya.hamamachi.sx@renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201124054218.3005-1-yuya.hamamachi.sx@renesas.com>
References: <20201124054218.3005-1-yuya.hamamachi.sx@renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Document the support for R-Car PCIe EP on R8A7795 SoC device.

Signed-off-by: Yuya Hamamachi <yuya.hamamachi.sx@renesas.com>
---
 Documentation/devicetree/bindings/pci/rcar-pci-ep.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/pci/rcar-pci-ep.yaml b/Documentation/devicetree/bindings/pci/rcar-pci-ep.yaml
index 84eeb7fe6e01..fb97f4ea0e63 100644
--- a/Documentation/devicetree/bindings/pci/rcar-pci-ep.yaml
+++ b/Documentation/devicetree/bindings/pci/rcar-pci-ep.yaml
@@ -19,6 +19,7 @@ properties:
           - renesas,r8a774b1-pcie-ep     # RZ/G2N
           - renesas,r8a774c0-pcie-ep     # RZ/G2E
           - renesas,r8a774e1-pcie-ep     # RZ/G2H
+          - renesas,r8a7795-pcie-ep      # R-Car H3
       - const: renesas,rcar-gen3-pcie-ep # R-Car Gen3 and RZ/G2
 
   reg:
-- 
2.25.1

