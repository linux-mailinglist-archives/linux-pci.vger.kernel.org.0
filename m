Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AB39A1A4476
	for <lists+linux-pci@lfdr.de>; Fri, 10 Apr 2020 11:30:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726082AbgDJJam (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 10 Apr 2020 05:30:42 -0400
Received: from relmlor1.renesas.com ([210.160.252.171]:55928 "EHLO
        relmlie5.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725861AbgDJJam (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 10 Apr 2020 05:30:42 -0400
X-IronPort-AV: E=Sophos;i="5.72,366,1580742000"; 
   d="scan'208";a="44365938"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 10 Apr 2020 18:30:41 +0900
Received: from localhost.localdomain (unknown [10.166.252.89])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id 056A44201A35;
        Fri, 10 Apr 2020 18:30:41 +0900 (JST)
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     bhelgaas@google.com, robh+dt@kernel.org
Cc:     linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: [PATCH] dt-bindings: pci: rcar: add r8a77961 support
Date:   Fri, 10 Apr 2020 18:30:20 +0900
Message-Id: <1586511020-31833-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add support for r8a77961 (R-Car M3-W+).

To avoid confusion between R-Car M3-W (R8A77960) and R-Car M3-W+
(R8A77961), this patch also updates the comment of
"renesas,pcie-r8a7796".

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
---
 Documentation/devicetree/bindings/pci/rcar-pci.txt | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/pci/rcar-pci.txt b/Documentation/devicetree/bindings/pci/rcar-pci.txt
index 12702c8..1041c44a 100644
--- a/Documentation/devicetree/bindings/pci/rcar-pci.txt
+++ b/Documentation/devicetree/bindings/pci/rcar-pci.txt
@@ -11,7 +11,8 @@ compatible: "renesas,pcie-r8a7743" for the R8A7743 SoC;
 	    "renesas,pcie-r8a7791" for the R8A7791 SoC;
 	    "renesas,pcie-r8a7793" for the R8A7793 SoC;
 	    "renesas,pcie-r8a7795" for the R8A7795 SoC;
-	    "renesas,pcie-r8a7796" for the R8A7796 SoC;
+	    "renesas,pcie-r8a7796" for the R8A77960 SoC;
+	    "renesas,pcie-r8a77961" for the R8A77961 SoC;
 	    "renesas,pcie-r8a77980" for the R8A77980 SoC;
 	    "renesas,pcie-r8a77990" for the R8A77990 SoC;
 	    "renesas,pcie-rcar-gen2" for a generic R-Car Gen2 or
-- 
2.7.4

