Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C3153DE57F
	for <lists+linux-pci@lfdr.de>; Tue,  3 Aug 2021 06:39:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233897AbhHCEjO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 3 Aug 2021 00:39:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:44794 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233830AbhHCEjO (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 3 Aug 2021 00:39:14 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id AE1166023B;
        Tue,  3 Aug 2021 04:39:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627965543;
        bh=JQBY01HlySg61KGcooyIwhgyIlhQj6EZr5kggVNvmjA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sMOQUsf2A68wiHayEJXRTsGdgkPIWOdCMfdB9ThgIojQq6rfA4hErsQ4R76vhrNWi
         iJ66XoXg3aTw1zmIqsjhvrCXVW9qEWpBCKfOSEoV3mLybt+oyMXg1/kBshQUAfKS/J
         7vbbAc3+XoHktpDWyTxijqyHrbOaNkgD6Jz7vZ+EiHb0BX/s8wIT276aNsXIphpdB5
         pqmuI8D54REdsziOnavcW9jTtPYK91RXC9uDCH1ZlJBVA9vS92/SICiG7wJMR30g54
         zHi1Io0ywIkSUFwNUD3SCdvgbry9Tu9MD70ZJz1szmJkp/M5GJT9NjlgFVlRlXPDOO
         KNvwWZJyUnfWg==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1mAmCj-00D8KD-FZ; Tue, 03 Aug 2021 06:39:01 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, Rob Herring <robh@kernel.org>
Subject: [PATCH v3 1/4] dt-bindings: PCI: kirin: Fix compatible string
Date:   Tue,  3 Aug 2021 06:38:55 +0200
Message-Id: <3e3e29a88f8e71eb228edf33d70cbe70db431408.1627965261.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1627965261.git.mchehab+huawei@kernel.org>
References: <cover.1627965261.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The pcie-kirin driver doesn't declare a hisilicon,kirin-pcie.
Also, remove the useless comment after the description, as other
compat will be supported by the same driver in the future.

Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/devicetree/bindings/pci/kirin-pcie.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/kirin-pcie.txt b/Documentation/devicetree/bindings/pci/kirin-pcie.txt
index 7db30534498f..7adab8999a6a 100644
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

