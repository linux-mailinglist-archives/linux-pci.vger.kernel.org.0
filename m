Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D9F33DB60A
	for <lists+linux-pci@lfdr.de>; Fri, 30 Jul 2021 11:34:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238355AbhG3Jec (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 30 Jul 2021 05:34:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:51848 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238346AbhG3Jeb (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 30 Jul 2021 05:34:31 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E44F3603E9;
        Fri, 30 Jul 2021 09:34:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627637666;
        bh=JQBY01HlySg61KGcooyIwhgyIlhQj6EZr5kggVNvmjA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZXykv52/VN5A0CYI2zxubB+xCWrzczbgeBp8ztubpDQErx9FWWA2ijsOOLAJjTElH
         aqtHvudb0elJmJRYpOV5rnWZBB755YRvGMMJ+lrdovk8fDZFUaHuhtBIf3XCoAYn53
         pEhrMJ7lw61/lJ4b90YRQPA6rDmJNAk+xkXZ5UEGvsUM5y2pNm3IYNW9P8yU8ncxAd
         X6PVKnJ75DOdCRAHR0FW/ccyzXbGsgpV36DjEN74ZVa5xweN204tw0fAU/GxHvviEL
         AfCV0isoJBYdO6jEBhhipoqgfc2ZYca/XVELWwRbanxKZa7CiFIyNiEkkrWTiH5r5j
         jMTDuki5X27Vg==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1m9OuO-006qw3-GP; Fri, 30 Jul 2021 11:34:24 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: [PATCH v2 1/4] dt-bindings: PCI: kirin: Fix compatible string
Date:   Fri, 30 Jul 2021 11:34:18 +0200
Message-Id: <3e3e29a88f8e71eb228edf33d70cbe70db431408.1627637448.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1627637448.git.mchehab+huawei@kernel.org>
References: <cover.1627637448.git.mchehab+huawei@kernel.org>
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

