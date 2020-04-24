Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B08751B7A1B
	for <lists+linux-pci@lfdr.de>; Fri, 24 Apr 2020 17:44:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727837AbgDXPjY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 24 Apr 2020 11:39:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:36896 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728584AbgDXPjX (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 24 Apr 2020 11:39:23 -0400
Received: from pali.im (pali.im [31.31.79.79])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EC16E20776;
        Fri, 24 Apr 2020 15:39:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587742763;
        bh=EVFjn07kmFor7UKViXp0cTbAK/KeKBmBXH77UZhMUfU=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=bwhocbOCwXOFvjgUJn7FYFi0mC8xWKKyhkFwM8FGb7rzYETqZSaRu+0CSbPuMv9S5
         HoioX0aisvqfeTWZ2F+5sh2bxvwxOzqe3XOmwAj9Rx7wPc46y0+xbnVB0L9h/FWOD0
         7Z+EAXLp+JvurcVhZdqYkfra/V50MUU+diWIwTpE=
Received: by pali.im (Postfix)
        id 1F1D9A19; Fri, 24 Apr 2020 17:39:21 +0200 (CEST)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     linux-pci@vger.kernel.org, Jason Cooper <jason@lakedaemon.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        Remi Pommarel <repk@triplefau.lt>,
        Tomasz Maciej Nowak <tmn505@gmail.com>,
        Xogium <contact@xogium.me>, Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <marek.behun@nic.cz>,
        Bjorn Helgaas <helgaas@kernel.org>
Subject: [PATCH v3 09/12] dt-bindings: PCI: aardvark: Describe new properties
Date:   Fri, 24 Apr 2020 17:38:55 +0200
Message-Id: <20200424153858.29744-10-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200424153858.29744-1-pali@kernel.org>
References: <20200424153858.29744-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Marek Behún <marek.behun@nic.cz>

Document the possibility to reference a PHY and reset-gpios and to set
max-link-speed property.

Signed-off-by: Marek Behún <marek.behun@nic.cz>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: devicetree@vger.kernel.org
---
 Documentation/devicetree/bindings/pci/aardvark-pci.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/aardvark-pci.txt b/Documentation/devicetree/bindings/pci/aardvark-pci.txt
index 310ef7145c47..2b8ca920a7fa 100644
--- a/Documentation/devicetree/bindings/pci/aardvark-pci.txt
+++ b/Documentation/devicetree/bindings/pci/aardvark-pci.txt
@@ -19,6 +19,9 @@ contain the following properties:
  - interrupt-map-mask and interrupt-map: standard PCI properties to
    define the mapping of the PCIe interface to interrupt numbers.
  - bus-range: PCI bus numbers covered
+ - phys: the PCIe PHY handle
+ - max-link-speed: see pci.txt
+ - reset-gpios: see pci.txt
 
 In addition, the Device Tree describing an Aardvark PCIe controller
 must include a sub-node that describes the legacy interrupt controller
@@ -48,6 +51,7 @@ Example:
 				<0 0 0 2 &pcie_intc 1>,
 				<0 0 0 3 &pcie_intc 2>,
 				<0 0 0 4 &pcie_intc 3>;
+		phys = <&comphy1 0>;
 		pcie_intc: interrupt-controller {
 			interrupt-controller;
 			#interrupt-cells = <1>;
-- 
2.20.1

