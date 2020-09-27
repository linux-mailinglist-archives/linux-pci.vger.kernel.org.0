Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74C6027A10C
	for <lists+linux-pci@lfdr.de>; Sun, 27 Sep 2020 14:48:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726358AbgI0MsS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 27 Sep 2020 08:48:18 -0400
Received: from relmlor1.renesas.com ([210.160.252.171]:23330 "EHLO
        relmlie5.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726280AbgI0MsR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 27 Sep 2020 08:48:17 -0400
X-Greylist: delayed 301 seconds by postgrey-1.27 at vger.kernel.org; Sun, 27 Sep 2020 08:48:17 EDT
X-IronPort-AV: E=Sophos;i="5.77,310,1596466800"; 
   d="scan'208";a="58260698"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 27 Sep 2020 21:43:15 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id F2E5840065C4;
        Sun, 27 Sep 2020 21:43:12 +0900 (JST)
From:   Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     Marek Vasut <marek.vasut+renesas@gmail.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Rob Herring <robh+dt@kernel.org>, linux-pci@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [RESEND PATCH] dt-bindings: pci: rcar-pci: Add device tree support for r8a774e1
Date:   Sun, 27 Sep 2020 13:42:57 +0100
Message-Id: <20200927124257.29612-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add PCIe support for the RZ/G2H (a.k.a. R8A774E1).

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas.com>
Acked-by: Rob Herring <robh@kernel.org>
Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
---
Hi Lorenzo,

This patch is part of series [1] and is Acked the DT maintainers,
while rest of the patches have been picked up by the respective
maintainers, could you please pick this patch.

[1] https://www.spinics.net/lists/dmaengine/msg22971.html

Cheers,
Prabhakar
---
 Documentation/devicetree/bindings/pci/rcar-pci.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/pci/rcar-pci.txt b/Documentation/devicetree/bindings/pci/rcar-pci.txt
index 14d307deff06..8e495d6811a0 100644
--- a/Documentation/devicetree/bindings/pci/rcar-pci.txt
+++ b/Documentation/devicetree/bindings/pci/rcar-pci.txt
@@ -7,6 +7,7 @@ compatible: "renesas,pcie-r8a7742" for the R8A7742 SoC;
 	    "renesas,pcie-r8a774a1" for the R8A774A1 SoC;
 	    "renesas,pcie-r8a774b1" for the R8A774B1 SoC;
 	    "renesas,pcie-r8a774c0" for the R8A774C0 SoC;
+	    "renesas,pcie-r8a774e1" for the R8A774E1 SoC;
 	    "renesas,pcie-r8a7779" for the R8A7779 SoC;
 	    "renesas,pcie-r8a7790" for the R8A7790 SoC;
 	    "renesas,pcie-r8a7791" for the R8A7791 SoC;
-- 
2.17.1

