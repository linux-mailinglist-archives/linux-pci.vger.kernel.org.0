Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F3711B24CA
	for <lists+linux-pci@lfdr.de>; Tue, 21 Apr 2020 13:17:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728659AbgDULRI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 21 Apr 2020 07:17:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728655AbgDULRH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 21 Apr 2020 07:17:07 -0400
Received: from mail.nic.cz (mail.nic.cz [IPv6:2001:1488:800:400::400])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 116E6C0610D6;
        Tue, 21 Apr 2020 04:17:07 -0700 (PDT)
Received: from dellmb.labs.office.nic.cz (unknown [IPv6:2001:1488:fffe:6:cac7:3539:7f1f:463])
        by mail.nic.cz (Postfix) with ESMTP id E077014134C;
        Tue, 21 Apr 2020 13:17:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nic.cz; s=default;
        t=1587467824; bh=TjODP2p0xHK85UsY8rwEX0kLDdOh7cP4xysZrWqeBMk=;
        h=From:To:Date;
        b=bW+xIYgE/ItyZi0S0sFDccgmjfMvljn41ZJXsIy5o37PjLAr9ZgKsHNwcNCkvjn1t
         kwtZIE71D66U4bB447hVfE45jqWp8QWwsP80pa22z3IdWQK1Xs1ogQZUHTx5qd/eRG
         cNXwAVYuUp0F3RYdR+Ryk/PaVj43BuhsJE+hqsb0=
From:   =?UTF-8?q?Marek=20Beh=C3=BAn?= <marek.behun@nic.cz>
To:     linux-pci@vger.kernel.org
Cc:     Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Remi Pommarel <repk@triplefau.lt>,
        Tomasz Maciej Nowak <tmn505@gmail.com>,
        Xogium <contact@xogium.me>,
        =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <marek.behun@nic.cz>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Subject: [PATCH v2 7/9] dt-bindings: PCI: aardvark: describe new properties
Date:   Tue, 21 Apr 2020 13:16:59 +0200
Message-Id: <20200421111701.17088-8-marek.behun@nic.cz>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200421111701.17088-1-marek.behun@nic.cz>
References: <20200421111701.17088-1-marek.behun@nic.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on mail.nic.cz
X-Spam-Status: No, score=0.00
X-Spamd-Bar: /
X-Virus-Scanned: clamav-milter 0.101.4 at mail
X-Virus-Status: Clean
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

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
2.24.1

