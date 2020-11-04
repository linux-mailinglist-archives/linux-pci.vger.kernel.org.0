Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6059C2A5C83
	for <lists+linux-pci@lfdr.de>; Wed,  4 Nov 2020 02:58:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730475AbgKDB6b (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 3 Nov 2020 20:58:31 -0500
Received: from relmlor1.renesas.com ([210.160.252.171]:24332 "EHLO
        relmlie5.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730291AbgKDB6a (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 3 Nov 2020 20:58:30 -0500
X-IronPort-AV: E=Sophos;i="5.77,449,1596466800"; 
   d="scan'208";a="61594045"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 04 Nov 2020 10:58:28 +0900
Received: from localhost.localdomain (unknown [10.166.252.89])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id BED4D4151D43;
        Wed,  4 Nov 2020 10:58:28 +0900 (JST)
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     bhelgaas@google.com, marek.vasut+renesas@gmail.com,
        robh+dt@kernel.org
Cc:     prabhakar.mahadev-lad.rj@bp.renesas.com, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: [PATCH v3 2/3] dt-bindings: PCI: rcar-pci-host: Document r8a77965 bindings
Date:   Wed,  4 Nov 2020 10:58:15 +0900
Message-Id: <1604455096-13923-3-git-send-email-yoshihiro.shimoda.uh@renesas.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1604455096-13923-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
References: <1604455096-13923-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Document the R-Car M3-N (R8A77965) SoC in the R-Car PCIe bindings.

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 Documentation/devicetree/bindings/pci/rcar-pci-host.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/pci/rcar-pci-host.yaml b/Documentation/devicetree/bindings/pci/rcar-pci-host.yaml
index 40c38a6..c93b0d1 100644
--- a/Documentation/devicetree/bindings/pci/rcar-pci-host.yaml
+++ b/Documentation/devicetree/bindings/pci/rcar-pci-host.yaml
@@ -34,6 +34,7 @@ properties:
               - renesas,pcie-r8a7795      # R-Car H3
               - renesas,pcie-r8a7796      # R-Car M3-W
               - renesas,pcie-r8a77961     # R-Car M3-W+
+              - renesas,pcie-r8a77965     # R-Car M3-N
               - renesas,pcie-r8a77980     # R-Car V3H
               - renesas,pcie-r8a77990     # R-Car E3
           - const: renesas,pcie-rcar-gen3 # R-Car Gen3 and RZ/G2
-- 
2.7.4

