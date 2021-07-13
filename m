Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7199A3C6A8C
	for <lists+linux-pci@lfdr.de>; Tue, 13 Jul 2021 08:28:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234154AbhGMGbh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 13 Jul 2021 02:31:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:51006 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233741AbhGMGbe (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 13 Jul 2021 02:31:34 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2C4446127C;
        Tue, 13 Jul 2021 06:28:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626157725;
        bh=D+ZGOha9YIyNnfYr6FuOOJKEz9zpdtF5nyb6I85glxg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Wrj4MToWGVVkh/vEXG4mIw8OzZ8nI6hdu8GzuIbBWHLYNR3pLq/UyMgnvHSDhUfzM
         yp8cKMB8Yz1Y/jQZH6rNsPId80Tw57v/5mYzic2cHQVkdv6WPKR1a5D3/s0Ld74njO
         1V5+rfuW+LzMrUDy08oWT+94TkiEMOWMbubgIxWv3u79ypuu8AmXFUJU8II8Y/IDpT
         LNkG96M+2tcibgkOv4rsnTg+Nm38VuHscFqR/66eOlZC78spAFGzIkZNhtjGOzPcdU
         zYcIXLp4YiZUvP7OU4sULVCR0bd+MpS6p6AqR+SZkBRLby8Bqt6+zHPbw28eW9Rs/+
         km4aNICQp0CCQ==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1m3BuM-005yPk-UM; Tue, 13 Jul 2021 08:28:42 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Manivannan Sadhasivam" <mani@kernel.org>,
        "Rob Herring" <robh@kernel.org>,
        Binghui Wang <wangbinghui@hisilicon.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Xiaowei Song <songxiaowei@hisilicon.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: [PATCH v5 4/8] dt-bindings: PCI: kirin: Drop PHY properties
Date:   Tue, 13 Jul 2021 08:28:37 +0200
Message-Id: <a04c9c92187ceaee0fd4b8d4721e2a3275d97518.1626157454.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1626157454.git.mchehab+huawei@kernel.org>
References: <cover.1626157454.git.mchehab+huawei@kernel.org>
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

