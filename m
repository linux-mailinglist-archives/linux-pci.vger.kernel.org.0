Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2297C43C99A
	for <lists+linux-pci@lfdr.de>; Wed, 27 Oct 2021 14:26:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234725AbhJ0M3G (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 27 Oct 2021 08:29:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232754AbhJ0M3F (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 27 Oct 2021 08:29:05 -0400
Received: from michel.telenet-ops.be (michel.telenet-ops.be [IPv6:2a02:1800:110:4::f00:18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13C14C061745
        for <linux-pci@vger.kernel.org>; Wed, 27 Oct 2021 05:26:39 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed20:441:6c1a:bc30:46e])
        by michel.telenet-ops.be with bizsmtp
        id B0Se260062hfXWm060Sefv; Wed, 27 Oct 2021 14:26:38 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1mfi0r-008TlJ-QN; Wed, 27 Oct 2021 14:26:37 +0200
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1mfi0r-00DsBL-Cx; Wed, 27 Oct 2021 14:26:37 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Marek Vasut <marek.vasut+renesas@gmail.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc:     linux-pci@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        devicetree@vger.kernel.org,
        Yuya Hamamachi <yuya.hamamachi.sx@renesas.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] dt-bindings: pci: rcar-pci-ep: Document r8a7795
Date:   Wed, 27 Oct 2021 14:26:36 +0200
Message-Id: <e4acfe90021e45658e82ed042746707ace208a93.1635337518.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Yuya Hamamachi <yuya.hamamachi.sx@renesas.com>

Document the support for R-Car PCIe EP on R8A7795 SoC device.

Signed-off-by: Yuya Hamamachi <yuya.hamamachi.sx@renesas.com>
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 Documentation/devicetree/bindings/pci/rcar-pci-ep.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/pci/rcar-pci-ep.yaml b/Documentation/devicetree/bindings/pci/rcar-pci-ep.yaml
index 295840cf612f9377..32a3b7665ff5473c 100644
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

