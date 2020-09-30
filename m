Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33FC827E071
	for <lists+linux-pci@lfdr.de>; Wed, 30 Sep 2020 07:38:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728061AbgI3FgU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 30 Sep 2020 01:36:20 -0400
Received: from mx.socionext.com ([202.248.49.38]:57167 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725306AbgI3FgT (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 30 Sep 2020 01:36:19 -0400
Received: from unknown (HELO iyokan-ex.css.socionext.com) ([172.31.9.54])
  by mx.socionext.com with ESMTP; 30 Sep 2020 14:36:11 +0900
Received: from mail.mfilter.local (m-filter-2 [10.213.24.62])
        by iyokan-ex.css.socionext.com (Postfix) with ESMTP id D11D460060;
        Wed, 30 Sep 2020 14:36:11 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Wed, 30 Sep 2020 14:36:11 +0900
Received: from plum.e01.socionext.com (unknown [10.213.132.32])
        by kinkan.css.socionext.com (Postfix) with ESMTP id 280871A0509;
        Wed, 30 Sep 2020 14:36:11 +0900 (JST)
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Murali Karicheri <m-karicheri2@ti.com>
Cc:     linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Subject: [PATCH v3 2/4] dt-bindings: PCI: uniphier-ep: Add iATU register description
Date:   Wed, 30 Sep 2020 14:36:05 +0900
Message-Id: <1601444167-11316-3-git-send-email-hayashi.kunihiko@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1601444167-11316-1-git-send-email-hayashi.kunihiko@socionext.com>
References: <1601444167-11316-1-git-send-email-hayashi.kunihiko@socionext.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

In the dt-bindings, "atu" reg-names is required to get the register space
for iATU in Synopsis DWC version 4.80 or later.

Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
---
 .../bindings/pci/socionext,uniphier-pcie-ep.yaml     | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/socionext,uniphier-pcie-ep.yaml b/Documentation/devicetree/bindings/pci/socionext,uniphier-pcie-ep.yaml
index f0558b9..f4292d2 100644
--- a/Documentation/devicetree/bindings/pci/socionext,uniphier-pcie-ep.yaml
+++ b/Documentation/devicetree/bindings/pci/socionext,uniphier-pcie-ep.yaml
@@ -23,14 +23,22 @@ properties:
     const: socionext,uniphier-pro5-pcie-ep
 
   reg:
-    maxItems: 4
+    minItems: 4
+    maxItems: 5
 
   reg-names:
-    items:
-      - const: dbi
-      - const: dbi2
-      - const: link
-      - const: addr_space
+    oneOf:
+      - items:
+        - const: dbi
+        - const: dbi2
+        - const: link
+        - const: addr_space
+      - items:
+        - const: dbi
+        - const: dbi2
+        - const: link
+        - const: addr_space
+        - const: atu
 
   clocks:
     maxItems: 2
-- 
2.7.4

