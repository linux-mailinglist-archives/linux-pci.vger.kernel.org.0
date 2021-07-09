Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 326643C2256
	for <lists+linux-pci@lfdr.de>; Fri,  9 Jul 2021 12:41:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230091AbhGIKog (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 9 Jul 2021 06:44:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:47528 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229863AbhGIKoe (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 9 Jul 2021 06:44:34 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 34FD9613D3;
        Fri,  9 Jul 2021 10:41:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625827311;
        bh=D+ZGOha9YIyNnfYr6FuOOJKEz9zpdtF5nyb6I85glxg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=An8RPckRGPoa6R+tY/aceyDL2qxuh9qQ4zUTILbWKiB2Lq+SrlpIf24Vpw9rhNfrd
         xkrUOtYJt4ph+fPbUkBijEXPn4vV9rZrsgaWhEBbliuU7mDN/0ROHTbi9mHcNT9/An
         tKxceuF7NuMh4M9zD5XPINq47w4/gLXgdI0GzmN58ZQ+hPuRzkGDR/OiFHCk3LnWSU
         BUuq7EUYjzMC5N2j4W9yAJZFzOqo9ICORynT96ATKDhAu78ys3G9Wp+EIyTm3O5fac
         69kBiOlwxbWf0oCrlm2jZB5+teoy9VqY0LC/XFwRPBKrPxmfFIZws+6//EnH7FJ7MW
         TZ4mZa+qxSsSw==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1m1nx7-00B5Fe-9z; Fri, 09 Jul 2021 12:41:49 +0200
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
Subject: [PATCH v3 4/9] dt-bindings: PCI: kirin: drop PHY properties
Date:   Fri,  9 Jul 2021 12:41:40 +0200
Message-Id: <2c5920d1a7a826ecfd480e7cb3b3230b0290d1e5.1625826353.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1625826353.git.mchehab+huawei@kernel.org>
References: <cover.1625826353.git.mchehab+huawei@kernel.org>
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
 .../devicetree/bindings/pci/kirin-pcie.txt       | 16 +++-------------
 1 file changed, 3 insertions(+), 13 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/kirin-pcie.txt b/Documentation/devicetree/bindings/pci/kirin-pcie.txt
index 71cac2b74002..a93a8cfa1afb 100644
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
@@ -39,12 +37,4 @@ Example based on kirin960:
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
 	};
-- 
2.31.1

