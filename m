Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4FBDD127883
	for <lists+linux-pci@lfdr.de>; Fri, 20 Dec 2019 10:53:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727185AbfLTJxb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 20 Dec 2019 04:53:31 -0500
Received: from mga01.intel.com ([192.55.52.88]:8042 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727167AbfLTJxb (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 20 Dec 2019 04:53:31 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Dec 2019 01:53:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,335,1571727600"; 
   d="scan'208";a="206500229"
Received: from sgsxdev004.isng.intel.com (HELO localhost) ([10.226.88.13])
  by orsmga007.jf.intel.com with ESMTP; 20 Dec 2019 01:53:27 -0800
From:   Dilip Kota <eswara.kota@linux.intel.com>
To:     lorenzo.pieralisi@arm.com, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     jingoohan1@gmail.com, gustavo.pimentel@synopsys.com,
        andrew.murray@arm.com, robh@kernel.org,
        linux-kernel@vger.kernel.org, andriy.shevchenko@intel.com,
        cheol.yong.kim@intel.com, chuanhua.lei@linux.intel.com,
        qi-ming.wu@intel.com, Dilip Kota <eswara.kota@linux.intel.com>
Subject: [PATCH 1/1] dt-bindings: PCI: intel: Fix dt_binding_check compilation failure
Date:   Fri, 20 Dec 2019 17:53:24 +0800
Message-Id: <3319036bb29e0b25fc3b85293301e32aee0540dc.1576833842.git.eswara.kota@linux.intel.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Remove <dt-bindings/clock/intel,lgm-clk.h> dependency as
it is not present in the mainline tree. Use numeric value
instead of LGM_GCLK_PCIE10 macro.

Signed-off-by: Dilip Kota <eswara.kota@linux.intel.com>
---
 Documentation/devicetree/bindings/pci/intel-gw-pcie.yaml | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/intel-gw-pcie.yaml b/Documentation/devicetree/bindings/pci/intel-gw-pcie.yaml
index db605d8a387d..a7da5141b8e0 100644
--- a/Documentation/devicetree/bindings/pci/intel-gw-pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/intel-gw-pcie.yaml
@@ -107,7 +107,6 @@ additionalProperties: false
 examples:
   - |
     #include <dt-bindings/gpio/gpio.h>
-    #include <dt-bindings/clock/intel,lgm-clk.h>
     pcie10: pcie@d0e00000 {
       compatible = "intel,lgm-pcie", "snps,dw-pcie";
       device_type = "pci";
@@ -129,7 +128,7 @@ examples:
                       <0 0 0 4 &ioapic1 30 1>;
       ranges = <0x02000000 0 0xd4000000 0xd4000000 0 0x04000000>;
       resets = <&rcu0 0x50 0>;
-      clocks = <&cgu0 LGM_GCLK_PCIE10>;
+      clocks = <&cgu0 120>;
       phys = <&cb0phy0>;
       phy-names = "pcie";
       reset-assert-ms = <500>;
-- 
2.11.0

