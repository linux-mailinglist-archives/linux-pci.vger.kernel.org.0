Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0617C3C6593
	for <lists+linux-pci@lfdr.de>; Mon, 12 Jul 2021 23:46:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230229AbhGLVtk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 12 Jul 2021 17:49:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:51678 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229500AbhGLVtj (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 12 Jul 2021 17:49:39 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6D82561106;
        Mon, 12 Jul 2021 21:46:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626126410;
        bh=D+ZGOha9YIyNnfYr6FuOOJKEz9zpdtF5nyb6I85glxg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nxsj0WCalAveF801CqzH6x8w5UJ77zrTxIHYYMZ3nUxqdjw07QmJ2A5DU4ZQtO2KZ
         Y/+qBWBTtPePfZJfzX+6QxYQ1UPOgc6L+ldW0BYM3mrXeJyus/AcvaVuXqs+TWqQ8/
         MwnIjzeas2crQU7ohomJSTK6oNzocLgalzlyBFC0pL4EOIFDnGgpmE792jP3nt+GCj
         ovC6V6SA5XAbvBEs/iYgAh8ghzNwBq3auYgGLuJgZcSMIP8ZmPoZxPSq/wwqti80xl
         D1bEj/MNLrtGA4MHArQdCYcXHmrRCnxqoOaDZsoeX/WkkiO3BnOVLfQVoPZS7lzaK2
         JLWd6yaF70u5g==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1m33lI-005VRN-8x; Mon, 12 Jul 2021 23:46:48 +0200
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
Subject: [PATCH v4 4/8] dt-bindings: PCI: kirin: Drop PHY properties
Date:   Mon, 12 Jul 2021 23:46:42 +0200
Message-Id: <a04c9c92187ceaee0fd4b8d4721e2a3275d97518.1626126198.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1626126198.git.mchehab+huawei@kernel.org>
References: <cover.1626126198.git.mchehab+huawei@kernel.org>
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

