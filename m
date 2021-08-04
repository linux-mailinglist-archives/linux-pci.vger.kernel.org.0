Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD6E53DFBE8
	for <lists+linux-pci@lfdr.de>; Wed,  4 Aug 2021 09:19:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235699AbhHDHT3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 4 Aug 2021 03:19:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:56720 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235773AbhHDHTN (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 4 Aug 2021 03:19:13 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5D50060F94;
        Wed,  4 Aug 2021 07:19:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628061541;
        bh=JQBY01HlySg61KGcooyIwhgyIlhQj6EZr5kggVNvmjA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=D1ZzqlffDZu+RJoZwbSkgajx8qG7nRNRIYw+eh7vZYxO6o1bgXe01piAvyTOz1FGH
         QOUoLrYnFrBOnAEc7hJ298OWK9e+plUAjpdKAAy9dZvPnW5LQgaV28QsBdUyeLygyT
         HGJW7SVv8qsdGFtIROLu/LEnYmXHVkYWHORzb2FMe5MbKMKbUnbG/uQ3l9mRLFLOU8
         iZ0qN+Pa7KsEQYb0Hc1TKCRpLWjf++rqjFq17Nl6NIrVOrywavR59YiiK7veOyYOWS
         VCCEAFrHz0y4ZySLwMC8DnOXEcouWtLW1GpYga9NdRiKRwIKblKTEYdDhQsHibSCXX
         zVEev/oz9izjg==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1mBBB5-000BlD-5Y; Wed, 04 Aug 2021 09:18:59 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, Rob Herring <robh@kernel.org>
Subject: [PATCH v4 1/4] dt-bindings: PCI: kirin: Fix compatible string
Date:   Wed,  4 Aug 2021 09:18:54 +0200
Message-Id: <668a85cb5ec5c59b1c96d3e87e6acc773f13f6e3.1628061310.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1628061310.git.mchehab+huawei@kernel.org>
References: <cover.1628061310.git.mchehab+huawei@kernel.org>
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

