Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B142852E8A9
	for <lists+linux-pci@lfdr.de>; Fri, 20 May 2022 11:21:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344185AbiETJVW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 20 May 2022 05:21:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236358AbiETJVV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 20 May 2022 05:21:21 -0400
X-Greylist: delayed 1434 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 20 May 2022 02:21:19 PDT
Received: from mo-csw-fb.securemx.jp (mo-csw-fb1516.securemx.jp [210.130.202.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0E542DAB6;
        Fri, 20 May 2022 02:21:19 -0700 (PDT)
Received: by mo-csw-fb.securemx.jp (mx-mo-csw-fb1516) id 24K8vQSw029845; Fri, 20 May 2022 17:57:26 +0900
Received: by mo-csw.securemx.jp (mx-mo-csw1516) id 24K8uskm030850; Fri, 20 May 2022 17:56:54 +0900
X-Iguazu-Qid: 34trvzMrv8epPT65NT
X-Iguazu-QSIG: v=2; s=0; t=1653037014; q=34trvzMrv8epPT65NT; m=wCqfnp8vQEQyhU528pIyqI4BbH8Xu5y1VmAO4hRtlXU=
Received: from imx12-a.toshiba.co.jp (imx12-a.toshiba.co.jp [61.202.160.135])
        by relay.securemx.jp (mx-mr1510) id 24K8uqbh040873
        (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 20 May 2022 17:56:53 +0900
From:   Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh@kernel.org>
Cc:     linux-pci@vger.kernel.org, yuji2.ishikawa@toshiba.co.jp,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
Subject: [PATCH] dt-bindings: pci: toshiba,visconti-pcie: Update the common clock properties
Date:   Fri, 20 May 2022 17:56:48 +0900
X-TSB-HOP2: ON
Message-Id: <20220520085648.620703-1-nobuhiro1.iwamatsu@toshiba.co.jp>
X-Mailer: git-send-email 2.36.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The clock for this driver switched to the common clock controller driver.
Therefore, update common clock properties for PCIe controller in the binding
document.

Signed-off-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
Acked-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/pci/toshiba,visconti-pcie.yaml         | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/pci/toshiba,visconti-pcie.yaml b/Documentation/devicetree/bindings/pci/toshiba,visconti-pcie.yaml
index 30b6396d83c8..b9d0484606cc 100644
--- a/Documentation/devicetree/bindings/pci/toshiba,visconti-pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/toshiba,visconti-pcie.yaml
@@ -69,6 +69,7 @@ unevaluatedProperties: false
 
 examples:
   - |
+    #include <dt-bindings/clock/toshiba,tmpv770x.h>
     #include <dt-bindings/interrupt-controller/irq.h>
     #include <dt-bindings/interrupt-controller/arm-gic.h>
 
@@ -102,7 +103,7 @@ examples:
                  0 0 0 2 &gic GIC_SPI 215 IRQ_TYPE_LEVEL_HIGH
                  0 0 0 3 &gic GIC_SPI 215 IRQ_TYPE_LEVEL_HIGH
                  0 0 0 4 &gic GIC_SPI 215 IRQ_TYPE_LEVEL_HIGH>;
-            clocks = <&extclk100mhz>, <&clk600mhz>, <&clk25mhz>;
+            clocks = <&extclk100mhz>, <&pismu TMPV770X_CLK_PCIE_MSTR>, <&pismu TMPV770X_CLK_PCIE_AUX>;
             clock-names = "ref", "core", "aux";
             max-link-speed = <2>;
         };
-- 
2.36.0


