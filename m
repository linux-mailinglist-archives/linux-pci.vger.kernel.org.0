Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D4C4626850
	for <lists+linux-pci@lfdr.de>; Sat, 12 Nov 2022 10:15:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234784AbiKLJPs (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 12 Nov 2022 04:15:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234508AbiKLJPm (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 12 Nov 2022 04:15:42 -0500
Received: from mxout1.routing.net (mxout1.routing.net [IPv6:2a03:2900:1:a::a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46D071582F;
        Sat, 12 Nov 2022 01:15:37 -0800 (PST)
Received: from mxbox3.masterlogin.de (unknown [192.168.10.78])
        by mxout1.routing.net (Postfix) with ESMTP id 028FF3FF3B;
        Sat, 12 Nov 2022 09:15:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailerdienst.de;
        s=20200217; t=1668244535;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wARWjXaekHXd+qoR6cih6bO82ffPMj6tdvVNWGcPmCQ=;
        b=lfZHMkUDmepqCe5Ny4OohuDOC/wbqoWmz9OCU/jQUCSrsjqifv7Yjdhu/T7k7o1xTPb1b1
        2VsMWWvIDWFVMeuOm4vNKp+9TtmOp06uyhr9o5Jg8EKAGEnSf1ug01q+UJ74fWrR0W6yOl
        jVQ5RjXuwG1Unq1rHquK9A11lhIYvfc=
Received: from frank-G5.. (fttx-pool-157.180.227.41.bambit.de [157.180.227.41])
        by mxbox3.masterlogin.de (Postfix) with ESMTPSA id E9A4A360D0E;
        Sat, 12 Nov 2022 09:15:33 +0000 (UTC)
From:   Frank Wunderlich <linux@fw-web.de>
To:     linux-mediatek@lists.infradead.org
Cc:     Frank Wunderlich <frank-w@public-files.de>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Jianjun Wang <jianjun.wang@mediatek.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Bo Jiao <Bo.Jiao@mediatek.com>, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-phy@lists.infradead.org, linux-usb@vger.kernel.org
Subject: [PATCH v4 01/11] arm64: dts: mt7986: move wed_pcie node
Date:   Sat, 12 Nov 2022 10:15:08 +0100
Message-Id: <20221112091518.7846-2-linux@fw-web.de>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221112091518.7846-1-linux@fw-web.de>
References: <20221112091518.7846-1-linux@fw-web.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mail-ID: 43985d64-a28d-4a3c-a1dc-63718da2295f
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Frank Wunderlich <frank-w@public-files.de>

Move the wed_pcie node to have node aligned by address.

Fixes: 00b9903996b3 ("arm64: dts: mediatek: mt7986: add support for Wireless Ethernet Dispatch")
Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
---
 arch/arm64/boot/dts/mediatek/mt7986a.dtsi | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt7986a.dtsi b/arch/arm64/boot/dts/mediatek/mt7986a.dtsi
index a22e10e89ab9..afc01abfa99c 100644
--- a/arch/arm64/boot/dts/mediatek/mt7986a.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt7986a.dtsi
@@ -112,6 +112,12 @@ infracfg: infracfg@10001000 {
 			#clock-cells = <1>;
 		};
 
+		wed_pcie: wed-pcie@10003000 {
+			compatible = "mediatek,mt7986-wed-pcie",
+				     "syscon";
+			reg = <0 0x10003000 0 0x10>;
+		};
+
 		topckgen: topckgen@1001b000 {
 			compatible = "mediatek,mt7986-topckgen", "syscon";
 			reg = <0 0x1001B000 0 0x1000>;
@@ -257,12 +263,6 @@ ethsys: syscon@15000000 {
 			 #reset-cells = <1>;
 		};
 
-		wed_pcie: wed-pcie@10003000 {
-			compatible = "mediatek,mt7986-wed-pcie",
-				     "syscon";
-			reg = <0 0x10003000 0 0x10>;
-		};
-
 		wed0: wed@15010000 {
 			compatible = "mediatek,mt7986-wed",
 				     "syscon";
-- 
2.34.1

