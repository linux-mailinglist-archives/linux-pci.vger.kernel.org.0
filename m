Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 703C94F267E
	for <lists+linux-pci@lfdr.de>; Tue,  5 Apr 2022 10:04:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231941AbiDEIDq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 5 Apr 2022 04:03:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233812AbiDEH5p (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 5 Apr 2022 03:57:45 -0400
Received: from mx.socionext.com (mx.socionext.com [202.248.49.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 70DFF5159C;
        Tue,  5 Apr 2022 00:51:29 -0700 (PDT)
Received: from unknown (HELO iyokan2-ex.css.socionext.com) ([172.31.9.54])
  by mx.socionext.com with ESMTP; 05 Apr 2022 16:51:17 +0900
Received: from mail.mfilter.local (m-filter-1 [10.213.24.61])
        by iyokan2-ex.css.socionext.com (Postfix) with ESMTP id 39C472058B50;
        Tue,  5 Apr 2022 16:51:17 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Tue, 5 Apr 2022 16:51:17 +0900
Received: from plum.e01.socionext.com (unknown [10.212.243.119])
        by kinkan2.css.socionext.com (Postfix) with ESMTP id CDAE7B6389;
        Tue,  5 Apr 2022 16:51:16 +0900 (JST)
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
To:     Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Subject: [PATCH 3/3] ARM: dts: uniphier: Remove compatible "snps,dw-pcie-ep" from Pro5 pcie-ep node
Date:   Tue,  5 Apr 2022 16:51:02 +0900
Message-Id: <1649145062-29833-4-git-send-email-hayashi.kunihiko@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1649145062-29833-1-git-send-email-hayashi.kunihiko@socionext.com>
References: <1649145062-29833-1-git-send-email-hayashi.kunihiko@socionext.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

UniPhier PCIe endpoint controller doesn't use "snps,dw-pcie-ep" compatible,
so this is no longer needed. Remove the compatible string from the pcie-ep
node to fix the following warning.

  uniphier-pro5-epcore.dtb: pcie@66000000: compatible: ['socionext,uniphier-pro5-pcie-ep', 'snps,dw-pcie-ep'] is too long
      From schema: Documentation/devicetree/bindings/pci/socionext,uniphier-pcie-ep.yaml

Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
---
 arch/arm/boot/dts/uniphier-pro5.dtsi | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/uniphier-pro5.dtsi b/arch/arm/boot/dts/uniphier-pro5.dtsi
index 3525125832dd..d79f94689ca2 100644
--- a/arch/arm/boot/dts/uniphier-pro5.dtsi
+++ b/arch/arm/boot/dts/uniphier-pro5.dtsi
@@ -614,8 +614,7 @@ usb1_ssphy0: ss-phy@380 {
 		};
 
 		pcie_ep: pcie-ep@66000000 {
-			compatible = "socionext,uniphier-pro5-pcie-ep",
-				     "snps,dw-pcie-ep";
+			compatible = "socionext,uniphier-pro5-pcie-ep";
 			status = "disabled";
 			reg-names = "dbi", "dbi2", "link", "addr_space";
 			reg = <0x66000000 0x1000>, <0x66001000 0x1000>,
-- 
2.25.1

