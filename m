Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C76E29CD86
	for <lists+linux-pci@lfdr.de>; Wed, 28 Oct 2020 03:06:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725871AbgJ1CGD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 27 Oct 2020 22:06:03 -0400
Received: from relmlor1.renesas.com ([210.160.252.171]:21183 "EHLO
        relmlie5.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725832AbgJ1CGC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 27 Oct 2020 22:06:02 -0400
X-IronPort-AV: E=Sophos;i="5.77,425,1596466800"; 
   d="scan'208";a="60995345"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 28 Oct 2020 11:06:00 +0900
Received: from localhost.localdomain (unknown [10.166.252.89])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id 7ED69417A611;
        Wed, 28 Oct 2020 11:06:00 +0900 (JST)
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     bhelgaas@google.com, marek.vasut+renesas@gmail.com,
        robh+dt@kernel.org
Cc:     prabhakar.mahadev-lad.rj@bp.renesas.com, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: [PATCH 2/3] dt-bindings: pci: rcar-pci-host: document r8a77965 bindings
Date:   Wed, 28 Oct 2020 11:05:50 +0900
Message-Id: <1603850751-32762-3-git-send-email-yoshihiro.shimoda.uh@renesas.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1603850751-32762-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
References: <1603850751-32762-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Document the R-Car M3-N (R8A77965) SoC in the R-Car PCIe bindings.

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
---
 Documentation/devicetree/bindings/pci/rcar-pci-host.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/pci/rcar-pci-host.yaml b/Documentation/devicetree/bindings/pci/rcar-pci-host.yaml
index d286454..1c6a03b 100644
--- a/Documentation/devicetree/bindings/pci/rcar-pci-host.yaml
+++ b/Documentation/devicetree/bindings/pci/rcar-pci-host.yaml
@@ -31,6 +31,7 @@ properties:
             - renesas,pcie-r8a7795      # R-Car H3
             - renesas,pcie-r8a7796      # R-Car M3-W
             - renesas,pcie-r8a77961     # R-Car M3-W+
+            - renesas,pcie-r8a77965     # R-Car M3-N
             - renesas,pcie-r8a77980     # R-Car V3H
             - renesas,pcie-r8a77990     # R-Car E3
         - const: renesas,pcie-rcar-gen3 # R-Car Gen3 and RZ/G2
-- 
2.7.4

