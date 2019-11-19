Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DE00910271D
	for <lists+linux-pci@lfdr.de>; Tue, 19 Nov 2019 15:44:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728276AbfKSOnx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 19 Nov 2019 09:43:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:59128 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727693AbfKSOnw (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 19 Nov 2019 09:43:52 -0500
Received: from localhost.localdomain (unknown [118.189.143.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8C2AD20891;
        Tue, 19 Nov 2019 14:43:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574174630;
        bh=xlCB2NOHd/yTkvOyVHqvWxkdfMebhvc+db3L014iAWw=;
        h=From:To:Cc:Subject:Date:From;
        b=0j/LRqrcg/xOzpjnzUqmHOPzP+ABzba43oGZjfah4WMWN4BlqcLKYdYKaRpAmYmq9
         P5t8TLBYWEhfIBYqP/qUf2Ak9XrukeTWsCIKYbRvKJtEfhgI/v9bGnnJQ+nGNWCi48
         iPSyMjeRJM5IoiwUJZRMAma2JrI1yS/bKM1QPDBY=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        etnaviv@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
        linux-media@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-tegra@vger.kernel.org
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH] dt-bindings: power: Fix path to power-domain.txt bindings
Date:   Tue, 19 Nov 2019 22:43:15 +0800
Message-Id: <20191119144315.11261-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

With split of power domain controller bindings to power-domain.yaml, the
consumer part was renamed to power-domain.txt.  Update the references in
other bindings.

Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
Fixes: abb4805e343a ("dt-bindings: power: Convert Samsung Exynos Power Domain bindings to json-schema")
Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 Documentation/devicetree/bindings/clock/clk-exynos-audss.txt  | 2 +-
 Documentation/devicetree/bindings/clock/exynos5433-clock.txt  | 2 +-
 .../devicetree/bindings/clock/renesas,r8a7778-cpg-clocks.txt  | 2 +-
 .../devicetree/bindings/clock/renesas,r8a7779-cpg-clocks.txt  | 2 +-
 .../bindings/clock/renesas,rcar-gen2-cpg-clocks.txt           | 2 +-
 .../devicetree/bindings/clock/renesas,rz-cpg-clocks.txt       | 2 +-
 .../devicetree/bindings/display/etnaviv/etnaviv-drm.txt       | 2 +-
 Documentation/devicetree/bindings/display/msm/dpu.txt         | 2 +-
 Documentation/devicetree/bindings/display/msm/mdp5.txt        | 2 +-
 Documentation/devicetree/bindings/dsp/fsl,dsp.yaml            | 2 +-
 Documentation/devicetree/bindings/media/imx7-mipi-csi2.txt    | 2 +-
 .../devicetree/bindings/media/mediatek-jpeg-decoder.txt       | 2 +-
 Documentation/devicetree/bindings/media/mediatek-mdp.txt      | 2 +-
 Documentation/devicetree/bindings/opp/qcom-nvmem-cpufreq.txt  | 2 +-
 Documentation/devicetree/bindings/pci/pci-keystone.txt        | 2 +-
 Documentation/devicetree/bindings/phy/ti,phy-am654-serdes.txt | 2 +-
 Documentation/devicetree/bindings/power/qcom,rpmpd.txt        | 2 +-
 Documentation/devicetree/bindings/power/renesas,rcar-sysc.txt | 2 +-
 .../devicetree/bindings/usb/nvidia,tegra124-xusb.txt          | 4 ++--
 19 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/Documentation/devicetree/bindings/clock/clk-exynos-audss.txt b/Documentation/devicetree/bindings/clock/clk-exynos-audss.txt
index 6030afb10b5c..e6c6b43e9770 100644
--- a/Documentation/devicetree/bindings/clock/clk-exynos-audss.txt
+++ b/Documentation/devicetree/bindings/clock/clk-exynos-audss.txt
@@ -36,7 +36,7 @@ Required Properties:
 Optional Properties:
 
   - power-domains: a phandle to respective power domain node as described by
-    generic PM domain bindings (see power/power_domain.txt for more
+    generic PM domain bindings (see power/power-domain.txt for more
     information).
 
 The following is the list of clocks generated by the controller. Each clock is
diff --git a/Documentation/devicetree/bindings/clock/exynos5433-clock.txt b/Documentation/devicetree/bindings/clock/exynos5433-clock.txt
index 183c327a7d6b..972d4e45f8c1 100644
--- a/Documentation/devicetree/bindings/clock/exynos5433-clock.txt
+++ b/Documentation/devicetree/bindings/clock/exynos5433-clock.txt
@@ -178,7 +178,7 @@ Required Properties:
 
 Optional properties:
   - power-domains: a phandle to respective power domain node as described by
-	generic PM domain bindings (see power/power_domain.txt for more
+	generic PM domain bindings (see power/power-domain.txt for more
 	information).
 
 Each clock is assigned an identifier and client nodes can use this identifier
diff --git a/Documentation/devicetree/bindings/clock/renesas,r8a7778-cpg-clocks.txt b/Documentation/devicetree/bindings/clock/renesas,r8a7778-cpg-clocks.txt
index 7cc4c0330b53..46ecbbce277c 100644
--- a/Documentation/devicetree/bindings/clock/renesas,r8a7778-cpg-clocks.txt
+++ b/Documentation/devicetree/bindings/clock/renesas,r8a7778-cpg-clocks.txt
@@ -17,7 +17,7 @@ Required Properties:
 SoC devices that are part of the CPG/MSTP Clock Domain and can be power-managed
 through an MSTP clock should refer to the CPG device node in their
 "power-domains" property, as documented by the generic PM domain bindings in
-Documentation/devicetree/bindings/power/power_domain.txt.
+Documentation/devicetree/bindings/power/power-domain.txt.
 
 
 Examples
diff --git a/Documentation/devicetree/bindings/clock/renesas,r8a7779-cpg-clocks.txt b/Documentation/devicetree/bindings/clock/renesas,r8a7779-cpg-clocks.txt
index 8c81547c29f5..cb32b4f41046 100644
--- a/Documentation/devicetree/bindings/clock/renesas,r8a7779-cpg-clocks.txt
+++ b/Documentation/devicetree/bindings/clock/renesas,r8a7779-cpg-clocks.txt
@@ -19,7 +19,7 @@ Required Properties:
 SoC devices that are part of the CPG/MSTP Clock Domain and can be power-managed
 through an MSTP clock should refer to the CPG device node in their
 "power-domains" property, as documented by the generic PM domain bindings in
-Documentation/devicetree/bindings/power/power_domain.txt.
+Documentation/devicetree/bindings/power/power-domain.txt.
 
 
 Examples
diff --git a/Documentation/devicetree/bindings/clock/renesas,rcar-gen2-cpg-clocks.txt b/Documentation/devicetree/bindings/clock/renesas,rcar-gen2-cpg-clocks.txt
index f8c05bb4116e..58f9054704c2 100644
--- a/Documentation/devicetree/bindings/clock/renesas,rcar-gen2-cpg-clocks.txt
+++ b/Documentation/devicetree/bindings/clock/renesas,rcar-gen2-cpg-clocks.txt
@@ -28,7 +28,7 @@ Required Properties:
 SoC devices that are part of the CPG/MSTP Clock Domain and can be power-managed
 through an MSTP clock should refer to the CPG device node in their
 "power-domains" property, as documented by the generic PM domain bindings in
-Documentation/devicetree/bindings/power/power_domain.txt.
+Documentation/devicetree/bindings/power/power-domain.txt.
 
 
 Examples
diff --git a/Documentation/devicetree/bindings/clock/renesas,rz-cpg-clocks.txt b/Documentation/devicetree/bindings/clock/renesas,rz-cpg-clocks.txt
index 8ff3e2774ed8..9f32528e7245 100644
--- a/Documentation/devicetree/bindings/clock/renesas,rz-cpg-clocks.txt
+++ b/Documentation/devicetree/bindings/clock/renesas,rz-cpg-clocks.txt
@@ -21,7 +21,7 @@ Required Properties:
 SoC devices that are part of the CPG/MSTP Clock Domain and can be power-managed
 through an MSTP clock should refer to the CPG device node in their
 "power-domains" property, as documented by the generic PM domain bindings in
-Documentation/devicetree/bindings/power/power_domain.txt.
+Documentation/devicetree/bindings/power/power-domain.txt.
 
 
 Examples
diff --git a/Documentation/devicetree/bindings/display/etnaviv/etnaviv-drm.txt b/Documentation/devicetree/bindings/display/etnaviv/etnaviv-drm.txt
index 640592e8ab2e..76d25d1499f7 100644
--- a/Documentation/devicetree/bindings/display/etnaviv/etnaviv-drm.txt
+++ b/Documentation/devicetree/bindings/display/etnaviv/etnaviv-drm.txt
@@ -20,7 +20,7 @@ Required properties:
 
 Optional properties:
 - power-domains: a power domain consumer specifier according to
-  Documentation/devicetree/bindings/power/power_domain.txt
+  Documentation/devicetree/bindings/power/power-domain.txt
 - #cooling-cells: : If used as a cooling device, must be <2>
 
 example:
diff --git a/Documentation/devicetree/bindings/display/msm/dpu.txt b/Documentation/devicetree/bindings/display/msm/dpu.txt
index a61dd40f3792..3ef875e94845 100644
--- a/Documentation/devicetree/bindings/display/msm/dpu.txt
+++ b/Documentation/devicetree/bindings/display/msm/dpu.txt
@@ -13,7 +13,7 @@ Required properties:
 - reg-names: register region names. The following region is required:
   * "mdss"
 - power-domains: a power domain consumer specifier according to
-  Documentation/devicetree/bindings/power/power_domain.txt
+  Documentation/devicetree/bindings/power/power-domain.txt
 - clocks: list of clock specifiers for clocks needed by the device.
 - clock-names: device clock names, must be in same order as clocks property.
   The following clocks are required:
diff --git a/Documentation/devicetree/bindings/display/msm/mdp5.txt b/Documentation/devicetree/bindings/display/msm/mdp5.txt
index 4e11338548aa..1cce2a61cb8e 100644
--- a/Documentation/devicetree/bindings/display/msm/mdp5.txt
+++ b/Documentation/devicetree/bindings/display/msm/mdp5.txt
@@ -19,7 +19,7 @@ Required properties:
 - #interrupt-cells: specifies the number of cells needed to encode an interrupt
   source, should be 1.
 - power-domains: a power domain consumer specifier according to
-  Documentation/devicetree/bindings/power/power_domain.txt
+  Documentation/devicetree/bindings/power/power-domain.txt
 - clocks: device clocks. See ../clocks/clock-bindings.txt for details.
 - clock-names: the following clocks are required.
   * "iface"
diff --git a/Documentation/devicetree/bindings/dsp/fsl,dsp.yaml b/Documentation/devicetree/bindings/dsp/fsl,dsp.yaml
index f04870d84542..e71cff583cf0 100644
--- a/Documentation/devicetree/bindings/dsp/fsl,dsp.yaml
+++ b/Documentation/devicetree/bindings/dsp/fsl,dsp.yaml
@@ -36,7 +36,7 @@ properties:
   power-domains:
     description:
       List of phandle and PM domain specifier as documented in
-      Documentation/devicetree/bindings/power/power_domain.txt
+      Documentation/devicetree/bindings/power/power-domain.txt
     maxItems: 4
 
   mboxes:
diff --git a/Documentation/devicetree/bindings/media/imx7-mipi-csi2.txt b/Documentation/devicetree/bindings/media/imx7-mipi-csi2.txt
index 71fd74ed3ec8..0b2bbd64d18b 100644
--- a/Documentation/devicetree/bindings/media/imx7-mipi-csi2.txt
+++ b/Documentation/devicetree/bindings/media/imx7-mipi-csi2.txt
@@ -17,7 +17,7 @@ Required properties:
 - clock-names   : must contain "pclk", "wrap" and "phy" entries, matching
                   entries in the clock property;
 - power-domains : a phandle to the power domain, see
-          Documentation/devicetree/bindings/power/power_domain.txt for details.
+          Documentation/devicetree/bindings/power/power-domain.txt for details.
 - reset-names   : should include following entry "mrst";
 - resets        : a list of phandle, should contain reset entry of
                   reset-names;
diff --git a/Documentation/devicetree/bindings/media/mediatek-jpeg-decoder.txt b/Documentation/devicetree/bindings/media/mediatek-jpeg-decoder.txt
index 044b11913c49..51f890c64004 100644
--- a/Documentation/devicetree/bindings/media/mediatek-jpeg-decoder.txt
+++ b/Documentation/devicetree/bindings/media/mediatek-jpeg-decoder.txt
@@ -14,7 +14,7 @@ Required properties:
   Documentation/devicetree/bindings/clock/clock-bindings.txt for details.
 - clock-names: must contain "jpgdec-smi" and "jpgdec".
 - power-domains: a phandle to the power domain, see
-  Documentation/devicetree/bindings/power/power_domain.txt for details.
+  Documentation/devicetree/bindings/power/power-domain.txt for details.
 - mediatek,larb: must contain the local arbiters in the current Socs, see
   Documentation/devicetree/bindings/memory-controllers/mediatek,smi-larb.txt
   for details.
diff --git a/Documentation/devicetree/bindings/media/mediatek-mdp.txt b/Documentation/devicetree/bindings/media/mediatek-mdp.txt
index 0d03e3ae2be2..988898f44bac 100644
--- a/Documentation/devicetree/bindings/media/mediatek-mdp.txt
+++ b/Documentation/devicetree/bindings/media/mediatek-mdp.txt
@@ -17,7 +17,7 @@ Required properties (all function blocks, child node):
 - clocks: device clocks, see
   Documentation/devicetree/bindings/clock/clock-bindings.txt for details.
 - power-domains: a phandle to the power domain, see
-  Documentation/devicetree/bindings/power/power_domain.txt for details.
+  Documentation/devicetree/bindings/power/power-domain.txt for details.
 
 Required properties (DMA function blocks, child node):
 - compatible: Should be one of
diff --git a/Documentation/devicetree/bindings/opp/qcom-nvmem-cpufreq.txt b/Documentation/devicetree/bindings/opp/qcom-nvmem-cpufreq.txt
index 4751029b9b74..de58cbee3dca 100644
--- a/Documentation/devicetree/bindings/opp/qcom-nvmem-cpufreq.txt
+++ b/Documentation/devicetree/bindings/opp/qcom-nvmem-cpufreq.txt
@@ -27,7 +27,7 @@ In 'cpu' nodes:
 - power-domains: A phandle pointing to the PM domain specifier which provides
 		the performance states available for active state management.
 		Please refer to the power-domains bindings
-		Documentation/devicetree/bindings/power/power_domain.txt
+		Documentation/devicetree/bindings/power/power-domain.txt
 		and also examples below.
 - power-domain-names: Should be
 	- 'cpr' for qcs404.
diff --git a/Documentation/devicetree/bindings/pci/pci-keystone.txt b/Documentation/devicetree/bindings/pci/pci-keystone.txt
index 47202a2938f2..4c592504bb69 100644
--- a/Documentation/devicetree/bindings/pci/pci-keystone.txt
+++ b/Documentation/devicetree/bindings/pci/pci-keystone.txt
@@ -88,7 +88,7 @@ num-ob-windows: As specified in
 num-lanes: As specified in
 	   Documentation/devicetree/bindings/pci/designware-pcie.txt
 power-domains: As documented by the generic PM domain bindings in
-	       Documentation/devicetree/bindings/power/power_domain.txt.
+	       Documentation/devicetree/bindings/power/power-domain.txt.
 ti,syscon-pcie-mode: phandle to the device control module required to configure
 		      PCI in either RC mode or EP mode.
 
diff --git a/Documentation/devicetree/bindings/phy/ti,phy-am654-serdes.txt b/Documentation/devicetree/bindings/phy/ti,phy-am654-serdes.txt
index 64b286d2d398..3fff2c2e1500 100644
--- a/Documentation/devicetree/bindings/phy/ti,phy-am654-serdes.txt
+++ b/Documentation/devicetree/bindings/phy/ti,phy-am654-serdes.txt
@@ -17,7 +17,7 @@ Required properties:
 		1 - PCIe0 Lane1
 		2 - ICSS2 SGMII Lane1
  - power-domains: As documented by the generic PM domain bindings in
-	Documentation/devicetree/bindings/power/power_domain.txt.
+	Documentation/devicetree/bindings/power/power-domain.txt.
  - clocks: List of clock-specifiers representing the input to the SERDES.
 	Should have 3 items representing the left input clock, external
 	reference clock and right input clock in that order.
diff --git a/Documentation/devicetree/bindings/power/qcom,rpmpd.txt b/Documentation/devicetree/bindings/power/qcom,rpmpd.txt
index bc75bf49cdae..014be1448fab 100644
--- a/Documentation/devicetree/bindings/power/qcom,rpmpd.txt
+++ b/Documentation/devicetree/bindings/power/qcom,rpmpd.txt
@@ -13,7 +13,7 @@ Required Properties:
  - #power-domain-cells: number of cells in Power domain specifier
 	must be 1.
  - operating-points-v2: Phandle to the OPP table for the Power domain.
-	Refer to Documentation/devicetree/bindings/power/power_domain.txt
+	Refer to Documentation/devicetree/bindings/power/power-domain.txt
 	and Documentation/devicetree/bindings/opp/opp.txt for more details
 
 Refer to <dt-bindings/power/qcom-rpmpd.h> for the level values for
diff --git a/Documentation/devicetree/bindings/power/renesas,rcar-sysc.txt b/Documentation/devicetree/bindings/power/renesas,rcar-sysc.txt
index 712caa5726f7..442768f68b49 100644
--- a/Documentation/devicetree/bindings/power/renesas,rcar-sysc.txt
+++ b/Documentation/devicetree/bindings/power/renesas,rcar-sysc.txt
@@ -44,7 +44,7 @@ Example:
 
 Devices residing in a power area must refer to that power area, as documented
 by the generic PM domain bindings in
-Documentation/devicetree/bindings/power/power_domain.txt.
+Documentation/devicetree/bindings/power/power-domain.txt.
 
 Required properties:
   - power-domains: A phandle and symbolic PM domain specifier, as defined in
diff --git a/Documentation/devicetree/bindings/usb/nvidia,tegra124-xusb.txt b/Documentation/devicetree/bindings/usb/nvidia,tegra124-xusb.txt
index 5bfcc0b4d6b9..ac6b272c4bbf 100644
--- a/Documentation/devicetree/bindings/usb/nvidia,tegra124-xusb.txt
+++ b/Documentation/devicetree/bindings/usb/nvidia,tegra124-xusb.txt
@@ -64,12 +64,12 @@ For Tegra210:
 For Tegra210 and Tegra186:
 - power-domains: A list of PM domain specifiers that reference each power-domain
   used by the xHCI controller. This list must comprise of a specifier for the
-  XUSBA and XUSBC power-domains. See ../power/power_domain.txt and
+  XUSBA and XUSBC power-domains. See ../power/power-domain.txt and
   ../arm/tegra/nvidia,tegra20-pmc.txt for details.
 - power-domain-names: A list of names that represent each of the specifiers in
   the 'power-domains' property. Must include 'xusb_ss' and 'xusb_host' which
   represent the power-domains XUSBA and XUSBC, respectively. See
-  ../power/power_domain.txt for details.
+  ../power/power-domain.txt for details.
 
 Optional properties:
 --------------------
-- 
2.17.1

