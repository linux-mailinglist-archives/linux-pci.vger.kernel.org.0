Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1768A29FD3C
	for <lists+linux-pci@lfdr.de>; Fri, 30 Oct 2020 06:29:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725808AbgJ3F3P (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 30 Oct 2020 01:29:15 -0400
Received: from relmlor1.renesas.com ([210.160.252.171]:54405 "EHLO
        relmlie5.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725784AbgJ3F3N (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 30 Oct 2020 01:29:13 -0400
X-IronPort-AV: E=Sophos;i="5.77,432,1596466800"; 
   d="scan'208";a="61230119"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 30 Oct 2020 14:29:11 +0900
Received: from localhost.localdomain (unknown [10.166.252.89])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id 30352400F796;
        Fri, 30 Oct 2020 14:29:11 +0900 (JST)
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     bhelgaas@google.com, marek.vasut+renesas@gmail.com,
        robh+dt@kernel.org
Cc:     prabhakar.mahadev-lad.rj@bp.renesas.com, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: [PATCH v2 3/3] dt-bindings: pci: rcar-pci: Add device tree support for r8a774e1
Date:   Fri, 30 Oct 2020 14:29:05 +0900
Message-Id: <1604035745-22095-4-git-send-email-yoshihiro.shimoda.uh@renesas.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1604035745-22095-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
References: <1604035745-22095-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Add PCIe support for the RZ/G2H (a.k.a. R8A774E1).

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas.com>
Acked-by: Rob Herring <robh@kernel.org>
Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
---
 Documentation/devicetree/bindings/pci/rcar-pci-host.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/pci/rcar-pci-host.yaml b/Documentation/devicetree/bindings/pci/rcar-pci-host.yaml
index c93b0d1..4a2bcc01 100644
--- a/Documentation/devicetree/bindings/pci/rcar-pci-host.yaml
+++ b/Documentation/devicetree/bindings/pci/rcar-pci-host.yaml
@@ -31,6 +31,7 @@ properties:
               - renesas,pcie-r8a774a1     # RZ/G2M
               - renesas,pcie-r8a774b1     # RZ/G2N
               - renesas,pcie-r8a774c0     # RZ/G2E
+              - renesas,pcie-r8a774e1     # RZ/G2H
               - renesas,pcie-r8a7795      # R-Car H3
               - renesas,pcie-r8a7796      # R-Car M3-W
               - renesas,pcie-r8a77961     # R-Car M3-W+
-- 
2.7.4

