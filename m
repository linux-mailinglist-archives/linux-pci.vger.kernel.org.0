Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 712DB3D0B2B
	for <lists+linux-pci@lfdr.de>; Wed, 21 Jul 2021 11:20:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235695AbhGUIUT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 21 Jul 2021 04:20:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:50696 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237204AbhGUH77 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 21 Jul 2021 03:59:59 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8923B6121F;
        Wed, 21 Jul 2021 08:39:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626856759;
        bh=JQBY01HlySg61KGcooyIwhgyIlhQj6EZr5kggVNvmjA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KHE86lzZy7C8Cy7F6ZjS5aHgZSDeltJdbkZ4cDoQxkLuzGn5ezWfDymILt8PbgyFQ
         U1pO15GuhQtVraeTkZpX7d6Rv29AUegXWoOKN71pF/gRZfazaTbeWvn5XAYG2dNRYy
         73PQzOSdIGHPTQNRBrQuWUTchsQMLvDjDqIfE7r69iLdhvQdhVqnd/va11htsI8DdD
         YhQBquGm1Ba4ikP5T/z2CbLy/Wkq08q4al+HgJwK445CGR8Nkk5XCvR0QrWqmP93PZ
         aq++iXSHkq+0Lclwa5xxVYRQYrcJ0W7ImHjNDaNsnL1ofLaceJsigjAZFTCpofahc0
         Q4E1VCx7BPdfg==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1m67l5-0022da-Et; Wed, 21 Jul 2021 10:39:15 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Vinod Koul <vkoul@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh@kernel.org>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: [PATCH v7 05/10] dt-bindings: PCI: kirin: Fix compatible string
Date:   Wed, 21 Jul 2021 10:39:07 +0200
Message-Id: <1b145c6be3c8e219a937a81b922b757470d9013d.1626855713.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1626855713.git.mchehab+huawei@kernel.org>
References: <cover.1626855713.git.mchehab+huawei@kernel.org>
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

