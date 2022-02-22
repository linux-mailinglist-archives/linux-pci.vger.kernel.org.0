Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 535694BFD85
	for <lists+linux-pci@lfdr.de>; Tue, 22 Feb 2022 16:51:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233688AbiBVPwK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 22 Feb 2022 10:52:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230341AbiBVPwF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 22 Feb 2022 10:52:05 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AED31CFCE;
        Tue, 22 Feb 2022 07:51:39 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BE40E616B1;
        Tue, 22 Feb 2022 15:51:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5E87C340E8;
        Tue, 22 Feb 2022 15:51:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645545098;
        bh=+jMY7Fmff/vHRcGElzdiiNPW97CbApnkgNqfokKetjw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=R49uH4LFvGKHUM7mCK4b+CU8bF13ECiB/TL7sGGMZN6rkL8/bIBQhAJuF2Hd+lvFN
         XCn2TVjBf3bUEWH8rMwBFq6xXA2i1n5Jd8XFe/QzNripL6YBEaXT+UcnPfFW2HO3ee
         /7fstW67qcoNytjhFSrP8Pl6sMKtxKV4O3e+IFC9ciRlNe3hbYtuTo/phJ/alJzvw/
         9xxHNLsZPa0XnIr5nOMsp+fRplN+nxXYu8iCSqcvo/FFw/3+gkoUP1DTg+ZLSf5HuE
         du7syMclUG3gEg8puYTy8diLdQu+JUQ3GzWB5uUBZeKSPQDp4Y6LBbGUVv2mrX1FAJ
         XPPMeAhqzwC9g==
Received: by pali.im (Postfix)
        id 8AE28FDB; Tue, 22 Feb 2022 16:51:37 +0100 (CET)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
        Russell King <rmk+kernel@armlinux.org.uk>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v4 04/12] dt-bindings: PCI: mvebu: Add num-lanes property
Date:   Tue, 22 Feb 2022 16:50:22 +0100
Message-Id: <20220222155030.988-5-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220222155030.988-1-pali@kernel.org>
References: <20220222155030.988-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Controller driver needs to correctly configure PCIe link if it contains 1
or 4 SerDes PCIe lanes. Therefore add a new 'num-lanes' DT property for
mvebu PCIe controller. Property 'num-lanes' seems to be de-facto standard
way how number of lanes is specified in other PCIe controllers.

Signed-off-by: Pali Rohár <pali@kernel.org>
Acked-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/pci/mvebu-pci.txt | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/mvebu-pci.txt b/Documentation/devicetree/bindings/pci/mvebu-pci.txt
index 6173af6885f8..24225852bce0 100644
--- a/Documentation/devicetree/bindings/pci/mvebu-pci.txt
+++ b/Documentation/devicetree/bindings/pci/mvebu-pci.txt
@@ -77,6 +77,7 @@ and the following optional properties:
 - marvell,pcie-lane: the physical PCIe lane number, for ports having
   multiple lanes. If this property is not found, we assume that the
   value is 0.
+- num-lanes: number of SerDes PCIe lanes for this link (1 or 4)
 - reset-gpios: optional GPIO to PERST#
 - reset-delay-us: delay in us to wait after reset de-assertion, if not
   specified will default to 100ms, as required by the PCIe specification.
@@ -141,6 +142,7 @@ pcie-controller {
 		interrupt-map = <0 0 0 0 &mpic 58>;
 		marvell,pcie-port = <0>;
 		marvell,pcie-lane = <0>;
+		num-lanes = <1>;
 		/* low-active PERST# reset on GPIO 25 */
 		reset-gpios = <&gpio0 25 1>;
 		/* wait 20ms for device settle after reset deassertion */
@@ -161,6 +163,7 @@ pcie-controller {
 		interrupt-map = <0 0 0 0 &mpic 59>;
 		marvell,pcie-port = <0>;
 		marvell,pcie-lane = <1>;
+		num-lanes = <1>;
 		clocks = <&gateclk 6>;
 	};
 
@@ -177,6 +180,7 @@ pcie-controller {
 		interrupt-map = <0 0 0 0 &mpic 60>;
 		marvell,pcie-port = <0>;
 		marvell,pcie-lane = <2>;
+		num-lanes = <1>;
 		clocks = <&gateclk 7>;
 	};
 
@@ -193,6 +197,7 @@ pcie-controller {
 		interrupt-map = <0 0 0 0 &mpic 61>;
 		marvell,pcie-port = <0>;
 		marvell,pcie-lane = <3>;
+		num-lanes = <1>;
 		clocks = <&gateclk 8>;
 	};
 
@@ -209,6 +214,7 @@ pcie-controller {
 		interrupt-map = <0 0 0 0 &mpic 62>;
 		marvell,pcie-port = <1>;
 		marvell,pcie-lane = <0>;
+		num-lanes = <1>;
 		clocks = <&gateclk 9>;
 	};
 
@@ -225,6 +231,7 @@ pcie-controller {
 		interrupt-map = <0 0 0 0 &mpic 63>;
 		marvell,pcie-port = <1>;
 		marvell,pcie-lane = <1>;
+		num-lanes = <1>;
 		clocks = <&gateclk 10>;
 	};
 
@@ -241,6 +248,7 @@ pcie-controller {
 		interrupt-map = <0 0 0 0 &mpic 64>;
 		marvell,pcie-port = <1>;
 		marvell,pcie-lane = <2>;
+		num-lanes = <1>;
 		clocks = <&gateclk 11>;
 	};
 
@@ -257,6 +265,7 @@ pcie-controller {
 		interrupt-map = <0 0 0 0 &mpic 65>;
 		marvell,pcie-port = <1>;
 		marvell,pcie-lane = <3>;
+		num-lanes = <1>;
 		clocks = <&gateclk 12>;
 	};
 
@@ -273,6 +282,7 @@ pcie-controller {
 		interrupt-map = <0 0 0 0 &mpic 99>;
 		marvell,pcie-port = <2>;
 		marvell,pcie-lane = <0>;
+		num-lanes = <1>;
 		clocks = <&gateclk 26>;
 	};
 
@@ -289,6 +299,7 @@ pcie-controller {
 		interrupt-map = <0 0 0 0 &mpic 103>;
 		marvell,pcie-port = <3>;
 		marvell,pcie-lane = <0>;
+		num-lanes = <1>;
 		clocks = <&gateclk 27>;
 	};
 };
-- 
2.20.1

