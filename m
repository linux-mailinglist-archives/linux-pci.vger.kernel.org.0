Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B8101CB65E
	for <lists+linux-pci@lfdr.de>; Fri,  4 Oct 2019 10:36:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731153AbfJDIgA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 4 Oct 2019 04:36:00 -0400
Received: from relmlor1.renesas.com ([210.160.252.171]:29757 "EHLO
        relmlie5.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726024AbfJDIf7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 4 Oct 2019 04:35:59 -0400
X-IronPort-AV: E=Sophos;i="5.67,255,1566831600"; 
   d="scan'208";a="28287603"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 04 Oct 2019 17:35:57 +0900
Received: from fabrizio-dev.ree.adwin.renesas.com (unknown [10.226.36.196])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id E738041E561A;
        Fri,  4 Oct 2019 17:35:52 +0900 (JST)
From:   Fabrizio Castro <fabrizio.castro@bp.renesas.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     Fabrizio Castro <fabrizio.castro@bp.renesas.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Simon Horman <horms@verge.net.au>,
        Magnus Damm <magnus.damm@gmail.com>, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>, xu_shunji@hoperun.com
Subject: [PATCH 3/7] dt-bindings: PCI: rcar: Add device tree support for r8a774b1
Date:   Fri,  4 Oct 2019 09:35:29 +0100
Message-Id: <1570178133-21532-4-git-send-email-fabrizio.castro@bp.renesas.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1570178133-21532-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1570178133-21532-1-git-send-email-fabrizio.castro@bp.renesas.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add PCIe support for the RZ/G2N (a.k.a. R8A774B1).

Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
---
 Documentation/devicetree/bindings/pci/rcar-pci.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/pci/rcar-pci.txt b/Documentation/devicetree/bindings/pci/rcar-pci.txt
index 45bba9f..12702c8 100644
--- a/Documentation/devicetree/bindings/pci/rcar-pci.txt
+++ b/Documentation/devicetree/bindings/pci/rcar-pci.txt
@@ -4,6 +4,7 @@ Required properties:
 compatible: "renesas,pcie-r8a7743" for the R8A7743 SoC;
 	    "renesas,pcie-r8a7744" for the R8A7744 SoC;
 	    "renesas,pcie-r8a774a1" for the R8A774A1 SoC;
+	    "renesas,pcie-r8a774b1" for the R8A774B1 SoC;
 	    "renesas,pcie-r8a774c0" for the R8A774C0 SoC;
 	    "renesas,pcie-r8a7779" for the R8A7779 SoC;
 	    "renesas,pcie-r8a7790" for the R8A7790 SoC;
-- 
2.7.4

