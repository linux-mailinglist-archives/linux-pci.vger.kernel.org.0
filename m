Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D93CCCB64F
	for <lists+linux-pci@lfdr.de>; Fri,  4 Oct 2019 10:35:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730320AbfJDIfu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 4 Oct 2019 04:35:50 -0400
Received: from relmlor1.renesas.com ([210.160.252.171]:29757 "EHLO
        relmlie5.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726024AbfJDIft (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 4 Oct 2019 04:35:49 -0400
X-IronPort-AV: E=Sophos;i="5.67,255,1566831600"; 
   d="scan'208";a="28287578"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 04 Oct 2019 17:35:47 +0900
Received: from fabrizio-dev.ree.adwin.renesas.com (unknown [10.226.36.196])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id 2F3A941E71A3;
        Fri,  4 Oct 2019 17:35:41 +0900 (JST)
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
Subject: [PATCH 1/7] dt-bindings: watchdog: renesas-wdt: Document r8a774b1 support
Date:   Fri,  4 Oct 2019 09:35:27 +0100
Message-Id: <1570178133-21532-2-git-send-email-fabrizio.castro@bp.renesas.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1570178133-21532-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1570178133-21532-1-git-send-email-fabrizio.castro@bp.renesas.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

RZ/G2N (a.k.a. R8A774B1) watchdog implementation is compatible
with R-Car Gen3, therefore add the relevant documentation.

Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
---
 Documentation/devicetree/bindings/watchdog/renesas,wdt.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/watchdog/renesas,wdt.txt b/Documentation/devicetree/bindings/watchdog/renesas,wdt.txt
index 9f365c1..a5bf04d 100644
--- a/Documentation/devicetree/bindings/watchdog/renesas,wdt.txt
+++ b/Documentation/devicetree/bindings/watchdog/renesas,wdt.txt
@@ -10,6 +10,7 @@ Required properties:
 		 - "renesas,r8a7745-wdt" (RZ/G1E)
 		 - "renesas,r8a77470-wdt" (RZ/G1C)
 		 - "renesas,r8a774a1-wdt" (RZ/G2M)
+		 - "renesas,r8a774b1-wdt" (RZ/G2N)
 		 - "renesas,r8a774c0-wdt" (RZ/G2E)
 	         - "renesas,r8a7790-wdt" (R-Car H2)
 	         - "renesas,r8a7791-wdt" (R-Car M2-W)
-- 
2.7.4

