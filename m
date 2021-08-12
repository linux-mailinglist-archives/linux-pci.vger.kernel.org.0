Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CCB43E9FFC
	for <lists+linux-pci@lfdr.de>; Thu, 12 Aug 2021 09:56:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234949AbhHLH40 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 12 Aug 2021 03:56:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:59632 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234245AbhHLH4X (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 12 Aug 2021 03:56:23 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8BDDF60FC4;
        Thu, 12 Aug 2021 07:55:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628754958;
        bh=ii0nBQbue9NAVogxJU47bDMTGMtwHme2vnmmfk4oB34=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rZH0tmH5GxzvIjQDpuckvBU43dj/DjkL2xAFP3Shp3lskxT6DkTBm+L/EPLAnENBZ
         gHJ9iH43CXzrzmwdo3rsAGdtV4hxDiv8QH15hYMroLWaC+Frd+3V4NiwyyRWV23nOi
         Om6vJPp/8DUIfVR58Kd8TTaIGYAnCCI8ZLc6tcct0CuVtbM08LdDR7GzjrIPJQZR44
         jvZffzhx3/3A+ADXtd0ShjpBBzCrfcvJ+BiL6CYHT8Ytdw16MOx8pb4DgSpShaKlig
         z/dqHqJ9jEKSOndkpYCI2t38dRGy4ff2E18ze8vvXsiPr9eIhXVcB2GVudEHRFqEvK
         9cXm7qp+ykXwg==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1mE5ZE-00DZ41-NH; Thu, 12 Aug 2021 09:55:56 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Binghui Wang <wangbinghui@hisilicon.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Xiaowei Song <songxiaowei@hisilicon.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: [PATCH 2/2] dt-bindings: PCI: kirin: fix HiKey970 example
Date:   Thu, 12 Aug 2021 09:55:52 +0200
Message-Id: <655e21422a14620ae2d55335eb72bcaa66f5384d.1628754620.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1628754620.git.mchehab+huawei@kernel.org>
References: <cover.1628754620.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The given example doesn't produce all of_nodes at sysfs.
Update it to reflect what's actually working.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 .../bindings/pci/hisilicon,kirin-pcie.yaml    | 64 +++++++++++--------
 1 file changed, 36 insertions(+), 28 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/hisilicon,kirin-pcie.yaml b/Documentation/devicetree/bindings/pci/hisilicon,kirin-pcie.yaml
index d05deebe9dbb..668a09e27139 100644
--- a/Documentation/devicetree/bindings/pci/hisilicon,kirin-pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/hisilicon,kirin-pcie.yaml
@@ -97,7 +97,6 @@ examples:
               <0x0 0xfc180000 0x0 0x1000>,
               <0x0 0xf5000000 0x0 0x2000>;
         reg-names = "dbi", "apb", "config";
-        msi-parent = <&its_pcie>;
         #address-cells = <3>;
         #size-cells = <2>;
         device_type = "pci";
@@ -116,43 +115,52 @@ examples:
                         <0x0 0 0 4 &gic GIC_SPI 285 IRQ_TYPE_LEVEL_HIGH>;
         reset-gpios = <&gpio7 0 0>;
         hisilicon,clken-gpios = <&gpio27 3 0>, <&gpio17 0 0>, <&gpio20 6 0>;
-
-        pcie@0 { // Lane 0: PCIe switch: Bus 1, Device 0
-          reg = <0 0 0 0 0>;
+        pcie@0,0 { // Lane 0: PCIe switch: Bus 1, Device 0
+          reg = <0x80 0 0 0 0>;
           compatible = "pciclass,0604";
           device_type = "pci";
           #address-cells = <3>;
           #size-cells = <2>;
           ranges;
-          pcie@1,0 { // Lane 4: M.2
-            reg = <0x800 0 0 0 0>;
+          msi-parent = <&its_pcie>;
+
+          pcie@0,0 { // Lane 0: upstream
+            reg = <0 0 0 0 0>;
             compatible = "pciclass,0604";
             device_type = "pci";
-            reset-gpios = <&gpio3 1 0>;
-            clkreq-gpios = <&gpio27 3 0 >;
-            #address-cells = <3>;
-            #size-cells = <2>;
-            ranges;
-          };
-          pcie@5,0 { // Lane 5: Mini PCIe
-            reg = <0x2800 0 0 0 0>;
-            compatible = "pciclass,0604";
-            device_type = "pci";
-            reset-gpios = <&gpio27 4 0 >;
-            clkreq-gpios = <&gpio17 0 0 >;
-            #address-cells = <3>;
-            #size-cells = <2>;
-            ranges;
-          };
-          pcie@7,0 { // Lane 6: Ethernet
-            reg = <0x3800 0 0 0 0>;
-            compatible = "pciclass,0604";
-            device_type = "pci";
-            reset-gpios = <&gpio25 2 0 >;
-            clkreq-gpios = <&gpio20 6 0 >;
             #address-cells = <3>;
             #size-cells = <2>;
             ranges;
+
+            pcie@1,0 { // Lane 4: M.2
+              reg = <0x0800 0 0 0 0>;
+              compatible = "pciclass,0604";
+              device_type = "pci";
+              reset-gpios = <&gpio3 1 0>;
+              #address-cells = <3>;
+              #size-cells = <2>;
+              ranges;
+            };
+
+            pcie@5,0 { // Lane 5: Mini PCIe
+              reg = <0x2800 0 0 0 0>;
+              compatible = "pciclass,0604";
+              device_type = "pci";
+              reset-gpios = <&gpio27 4 0 >;
+              #address-cells = <3>;
+              #size-cells = <2>;
+              ranges;
+            };
+
+            pcie@7,0 { // Lane 6: Ethernet
+              reg = <0x03800 0 0 0 0>;
+              compatible = "pciclass,0604";
+              device_type = "pci";
+              reset-gpios = <&gpio25 2 0 >;
+              #address-cells = <3>;
+              #size-cells = <2>;
+              ranges;
+            };
           };
         };
       };
-- 
2.31.1

