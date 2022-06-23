Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B114F5570E4
	for <lists+linux-pci@lfdr.de>; Thu, 23 Jun 2022 04:09:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377666AbiFWCJR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 22 Jun 2022 22:09:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377594AbiFWCJQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 22 Jun 2022 22:09:16 -0400
Received: from mx.socionext.com (mx.socionext.com [202.248.49.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7D8091F2E0;
        Wed, 22 Jun 2022 19:09:15 -0700 (PDT)
Received: from unknown (HELO iyokan2-ex.css.socionext.com) ([172.31.9.54])
  by mx.socionext.com with ESMTP; 23 Jun 2022 11:09:15 +0900
Received: from mail.mfilter.local (m-filter-2 [10.213.24.62])
        by iyokan2-ex.css.socionext.com (Postfix) with ESMTP id E782A2058B4F;
        Thu, 23 Jun 2022 11:09:14 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Thu, 23 Jun 2022 11:09:14 +0900
Received: from plum.e01.socionext.com (unknown [10.212.243.119])
        by kinkan2.css.socionext.com (Postfix) with ESMTP id A064FB62E2;
        Thu, 23 Jun 2022 11:09:14 +0900 (JST)
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
To:     Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Subject: [PATCH v4 1/2] dt-bindings: PCI: designware-ep: Increase maxItems of reg and reg-names
Date:   Thu, 23 Jun 2022 11:09:01 +0900
Message-Id: <1655950142-2026-2-git-send-email-hayashi.kunihiko@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1655950142-2026-1-git-send-email-hayashi.kunihiko@socionext.com>
References: <1655950142-2026-1-git-send-email-hayashi.kunihiko@socionext.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

UniPhier PCIe EP controller has up to 5 register mappings (dbi, dbi2, link,
addr_space and atu), so maxItems of "reg" and "reg-names" should allow 5.

Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/pci/snps,dw-pcie-ep.yaml | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/snps,dw-pcie-ep.yaml b/Documentation/devicetree/bindings/pci/snps,dw-pcie-ep.yaml
index b78535040f04..f9390d729958 100644
--- a/Documentation/devicetree/bindings/pci/snps,dw-pcie-ep.yaml
+++ b/Documentation/devicetree/bindings/pci/snps,dw-pcie-ep.yaml
@@ -28,11 +28,11 @@ properties:
       versions.
       For designware core version >= 4.80, it may contain ATU address space.
     minItems: 2
-    maxItems: 4
+    maxItems: 5
 
   reg-names:
     minItems: 2
-    maxItems: 4
+    maxItems: 5
     items:
       enum: [dbi, dbi2, config, atu, addr_space, link, atu_dma, appl]
 
-- 
2.25.1

