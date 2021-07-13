Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BA0C3C6A88
	for <lists+linux-pci@lfdr.de>; Tue, 13 Jul 2021 08:28:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234095AbhGMGbg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 13 Jul 2021 02:31:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:51012 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233894AbhGMGbe (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 13 Jul 2021 02:31:34 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3004861288;
        Tue, 13 Jul 2021 06:28:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626157725;
        bh=sEi0ifqdSJujS+O4xXc7C5cCdEC25XeRG+JKalDhaK8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=l4yMS2lwWlm87gGtPVERlraBDD2Hns4UqWn4xJrnGDXLZZi+QQEaZgfQgMLoMgYPn
         PQd1gdIBey+wRU4qH1ctFHseWlnIkggHo9IUB+lpx0UQiXMWfaMEyzr9sqmiEv4z03
         BzrLAEcPIo7ijLVNDBBNmeB6+Vb1cqTpHRS/+ZnLU0FYmwe5anXEg9zE//vkp3GXMD
         x3Wlvzp8goCCq5Nkb3qgxOXZi+LUJoTprdLUwjdZrtSRgXuh/zyMh9vxKHgUo6Zi6A
         fnGSU+PTIFAvfG/zh5rsMGCI7sND9AVw9zCNzesRCwnZdPCJiylke2Todsc4rNq8zn
         0VKdzulb7EzNg==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1m3BuM-005yPe-Sc; Tue, 13 Jul 2021 08:28:42 +0200
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
Subject: [PATCH v5 3/8] dt-bindings: PCI: kirin: Fix compatible string
Date:   Tue, 13 Jul 2021 08:28:36 +0200
Message-Id: <083e622bb8f3d529128b9d63bef9b75b98d4b1f1.1626157454.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1626157454.git.mchehab+huawei@kernel.org>
References: <cover.1626157454.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The pcie-kirin driver doesn't declare a hisilicon,kirin-pcie.
Also, remove the useless comment after the description, as other
compat will be supported by the same driver in the future.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/devicetree/bindings/pci/kirin-pcie.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/kirin-pcie.txt b/Documentation/devicetree/bindings/pci/kirin-pcie.txt
index 6bbe43818ad5..71cac2b74002 100644
--- a/Documentation/devicetree/bindings/pci/kirin-pcie.txt
+++ b/Documentation/devicetree/bindings/pci/kirin-pcie.txt
@@ -9,7 +9,7 @@ Additional properties are described here:
 
 Required properties
 - compatible:
-	"hisilicon,kirin960-pcie" for PCIe of Kirin960 SoC
+	"hisilicon,kirin960-pcie"
 - reg: Should contain rc_dbi, apb, phy, config registers location and length.
 - reg-names: Must include the following entries:
   "dbi": controller configuration registers;
@@ -23,7 +23,7 @@ Optional properties:
 Example based on kirin960:
 
 	pcie@f4000000 {
-		compatible = "hisilicon,kirin-pcie";
+		compatible = "hisilicon,kirin960-pcie";
 		reg = <0x0 0xf4000000 0x0 0x1000>, <0x0 0xff3fe000 0x0 0x1000>,
 		      <0x0 0xf3f20000 0x0 0x40000>, <0x0 0xF4000000 0 0x2000>;
 		reg-names = "dbi","apb","phy", "config";
-- 
2.31.1

