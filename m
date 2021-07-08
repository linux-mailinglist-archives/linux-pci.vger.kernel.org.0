Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 762083C168E
	for <lists+linux-pci@lfdr.de>; Thu,  8 Jul 2021 17:50:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232048AbhGHPxG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 8 Jul 2021 11:53:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:59320 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231139AbhGHPxF (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 8 Jul 2021 11:53:05 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8D90261621;
        Thu,  8 Jul 2021 15:50:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625759423;
        bh=xEtFsGe/nvgIp++LyqaQ4D6RN/JlX1hRQoJR0nM7xCg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=m8s5yUQeTgWi8eo5peF7561VxDxeM742XOxEdZ/F/mclKn9KSdEm71YCmAoFqeN49
         byHn/3F1JaoVuZa5IHbj1s92KeGusY5M9oWAkTV7gZV1DdMnPyLWskP7ZineKHFGqd
         jAaKx2HzgzXGq4qPs7KsYdAkqMSsnassAnyCH76H2SkRfs1Fo7LGwMtV0lT9zOhGPW
         VWqKIht1zLjLdEXXhYcHxDm9I5Aeb6+ORsCE59KcZxeAlkJqny0ewiM8v1uzZha78D
         lGCa5Fik3MGkkOKl9K4t+gYNVa9QYYGFJqTzxugZnh4k8UvKahAHxEqXRjrdCvO43f
         i67eh73Vskq3w==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1m1WI4-008VVC-Hx; Thu, 08 Jul 2021 17:50:16 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Manivannan Sadhasivam <mani@kernel.org>,
        Rob Herring <robh@kernel.org>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Binghui Wang <wangbinghui@hisilicon.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Xiaowei Song <songxiaowei@hisilicon.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: [PATCH RFC 4/7] bindings: kirin-pcie.txt: drop PHY properties
Date:   Thu,  8 Jul 2021 17:50:11 +0200
Message-Id: <de0710266c8838f52551dad59896d045c46e9202.1625758732.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1625758732.git.mchehab+huawei@kernel.org>
References: <cover.1625758732.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

There are several properties there that belong to the PHY
interface. Drop them, as a new binding file will describe
the PHY properties for Kirin 960.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 .../devicetree/bindings/pci/kirin-pcie.txt    | 19 ++++++-------------
 1 file changed, 6 insertions(+), 13 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/kirin-pcie.txt b/Documentation/devicetree/bindings/pci/kirin-pcie.txt
index 71cac2b74002..21fb41a3ee3b 100644
--- a/Documentation/devicetree/bindings/pci/kirin-pcie.txt
+++ b/Documentation/devicetree/bindings/pci/kirin-pcie.txt
@@ -10,13 +10,11 @@ Additional properties are described here:
 Required properties
 - compatible:
 	"hisilicon,kirin960-pcie"
-- reg: Should contain rc_dbi, apb, phy, config registers location and length.
+- reg: Should contain rc_dbi, apb, config registers location and length.
 - reg-names: Must include the following entries:
   "dbi": controller configuration registers;
   "apb": apb Ctrl register defined by Kirin;
-  "phy": apb PHY register defined by Kirin;
   "config": PCIe configuration space registers.
-- reset-gpios: The GPIO to generate PCIe PERST# assert and deassert signal.
 
 Optional properties:
 
@@ -25,8 +23,8 @@ Example based on kirin960:
 	pcie@f4000000 {
 		compatible = "hisilicon,kirin960-pcie";
 		reg = <0x0 0xf4000000 0x0 0x1000>, <0x0 0xff3fe000 0x0 0x1000>,
-		      <0x0 0xf3f20000 0x0 0x40000>, <0x0 0xF4000000 0 0x2000>;
-		reg-names = "dbi","apb","phy", "config";
+		      <0x0 0xF4000000 0 0x2000>;
+		reg-names = "dbi","apb", "config";
 		bus-range = <0x0  0x1>;
 		#address-cells = <3>;
 		#size-cells = <2>;
@@ -39,12 +37,7 @@ Example based on kirin960:
 				<0x0 0 0 2 &gic 0 0 0  283 4>,
 				<0x0 0 0 3 &gic 0 0 0  284 4>,
 				<0x0 0 0 4 &gic 0 0 0  285 4>;
-		clocks = <&crg_ctrl HI3660_PCIEPHY_REF>,
-			 <&crg_ctrl HI3660_CLK_GATE_PCIEAUX>,
-			 <&crg_ctrl HI3660_PCLK_GATE_PCIE_PHY>,
-			 <&crg_ctrl HI3660_PCLK_GATE_PCIE_SYS>,
-			 <&crg_ctrl HI3660_ACLK_GATE_PCIE>;
-		clock-names = "pcie_phy_ref", "pcie_aux",
-			      "pcie_apb_phy", "pcie_apb_sys", "pcie_aclk";
-		reset-gpios = <&gpio11 1 0 >;
+		clocks = <&crg_ctrl HI3660_CLK_GATE_PCIEAUX>,
+			 <&crg_ctrl HI3660_PCLK_GATE_PCIE_SYS>;
+		clock-names = "pcie_aux", "pcie_apb_sys";
 	};
-- 
2.31.1

