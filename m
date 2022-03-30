Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B1084EBA1F
	for <lists+linux-pci@lfdr.de>; Wed, 30 Mar 2022 07:24:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242952AbiC3FZd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 30 Mar 2022 01:25:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236131AbiC3FZa (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 30 Mar 2022 01:25:30 -0400
Received: from mx.socionext.com (mx.socionext.com [202.248.49.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 39FF915DAB8;
        Tue, 29 Mar 2022 22:23:38 -0700 (PDT)
Received: from unknown (HELO iyokan2-ex.css.socionext.com) ([172.31.9.54])
  by mx.socionext.com with ESMTP; 30 Mar 2022 14:23:37 +0900
Received: from mail.mfilter.local (m-filter-1 [10.213.24.61])
        by iyokan2-ex.css.socionext.com (Postfix) with ESMTP id DD8DA2058B50;
        Wed, 30 Mar 2022 14:23:37 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Wed, 30 Mar 2022 14:23:37 +0900
Received: from plum.e01.socionext.com (unknown [10.212.243.119])
        by kinkan2.css.socionext.com (Postfix) with ESMTP id 51085B62B7;
        Wed, 30 Mar 2022 14:23:37 +0900 (JST)
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Subject: [PATCH v2 2/2] arm64: dts: uniphier: Remove compatible "snps,dw-pcie" from pcie node
Date:   Wed, 30 Mar 2022 14:23:34 +0900
Message-Id: <1648617814-9217-3-git-send-email-hayashi.kunihiko@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1648617814-9217-1-git-send-email-hayashi.kunihiko@socionext.com>
References: <1648617814-9217-1-git-send-email-hayashi.kunihiko@socionext.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

UniPhier PCIe host controller doesn't use "snps,dw-pcie" compatible, so
this is no longer needed. Remove the compatible string from the pcie node
to fix the following warning.

  uniphier-ld20-akebi96.dtb: pcie@66000000: compatible: ['socionext,uniphier-pcie', 'snps,dw-pcie'] is too long
      From schema: Documentation/devicetree/bindings/pci/socionext,uniphier-pcie.yaml

Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
---
 arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi | 2 +-
 arch/arm64/boot/dts/socionext/uniphier-pxs3.dtsi | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi b/arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi
index 8f2c1c1e2c64..6c774ee6ec9b 100644
--- a/arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi
+++ b/arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi
@@ -895,7 +895,7 @@ usb_ssphy1: ss-phy@310 {
 		};
 
 		pcie: pcie@66000000 {
-			compatible = "socionext,uniphier-pcie", "snps,dw-pcie";
+			compatible = "socionext,uniphier-pcie";
 			status = "disabled";
 			reg-names = "dbi", "link", "config";
 			reg = <0x66000000 0x1000>, <0x66010000 0x10000>,
diff --git a/arch/arm64/boot/dts/socionext/uniphier-pxs3.dtsi b/arch/arm64/boot/dts/socionext/uniphier-pxs3.dtsi
index be97da132258..b87f6fc85902 100644
--- a/arch/arm64/boot/dts/socionext/uniphier-pxs3.dtsi
+++ b/arch/arm64/boot/dts/socionext/uniphier-pxs3.dtsi
@@ -792,7 +792,7 @@ usb1_ssphy0: ss-phy@300 {
 		};
 
 		pcie: pcie@66000000 {
-			compatible = "socionext,uniphier-pcie", "snps,dw-pcie";
+			compatible = "socionext,uniphier-pcie";
 			status = "disabled";
 			reg-names = "dbi", "link", "config";
 			reg = <0x66000000 0x1000>, <0x66010000 0x10000>,
-- 
2.25.1

