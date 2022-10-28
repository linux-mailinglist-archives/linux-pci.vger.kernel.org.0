Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B998610D86
	for <lists+linux-pci@lfdr.de>; Fri, 28 Oct 2022 11:43:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229802AbiJ1Jnh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 28 Oct 2022 05:43:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229691AbiJ1Jna (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 28 Oct 2022 05:43:30 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B219D1911FA;
        Fri, 28 Oct 2022 02:43:29 -0700 (PDT)
X-UUID: c74a935848be4576b982fcd3366d7d0d-20221028
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=VBfEs4tVvu1FX5R5hBpYfxbDL/kM262uozbK/j71Z48=;
        b=Yj0MOlR7Br3oUOwQ2mrvN5LT0AFplbI2MQBJjrpMz9zXJfO9GtMkEnmZ/XO4MHXPmTff/fDsuOqWTQVYfh9RyVBTsLBX/W/ZqtaIQPSGi6R/lPTDTLfxwZ5GhUtgmrivGwvt0haMZG4C7cSrCvZPXcLhnd5EMFpUFxa3ujBch2c=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.12,REQID:58a2435f-ca74-476e-babe-1a6170129bbb,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:95
X-CID-INFO: VERSION:1.1.12,REQID:58a2435f-ca74-476e-babe-1a6170129bbb,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Spam_GS981B3D,ACTION
        :quarantine,TS:95
X-CID-META: VersionHash:62cd327,CLOUDID:3da5bfea-84ac-4628-a416-bc50d5503da6,B
        ulkID:221028174327F2KFD9HJ,BulkQuantity:0,Recheck:0,SF:38|28|17|19|48,TC:n
        il,Content:0,EDM:-3,IP:nil,URL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: c74a935848be4576b982fcd3366d7d0d-20221028
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <tinghan.shen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 2090798610; Fri, 28 Oct 2022 17:43:26 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.194) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Fri, 28 Oct 2022 17:43:22 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Fri, 28 Oct 2022 17:43:22 +0800
From:   Tinghan Shen <tinghan.shen@mediatek.com>
To:     Ryder Lee <ryder.lee@mediatek.com>,
        Jianjun Wang <jianjun.wang@mediatek.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     <linux-pci@vger.kernel.org>, <linux-mediatek@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        Tinghan Shen <tinghan.shen@mediatek.com>,
        Irui Wang <irui.wang@mediatek.com>
Subject: [PATCH v4 3/3] arm64: dts: mt8195: Add venc node
Date:   Fri, 28 Oct 2022 17:43:17 +0800
Message-ID: <20221028094317.29270-4-tinghan.shen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20221028094317.29270-1-tinghan.shen@mediatek.com>
References: <20221028094317.29270-1-tinghan.shen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add venc node for mt8195 SoC.

Signed-off-by: Irui Wang <irui.wang@mediatek.com>
Signed-off-by: Tinghan Shen <tinghan.shen@mediatek.com>
---
 arch/arm64/boot/dts/mediatek/mt8195.dtsi | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8195.dtsi b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
index 97de03267884..2a29ec3bfdd7 100644
--- a/arch/arm64/boot/dts/mediatek/mt8195.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
@@ -2109,6 +2109,30 @@
 			power-domains = <&spm MT8195_POWER_DOMAIN_VENC>;
 		};
 
+		venc: video-codec@1a020000 {
+			compatible = "mediatek,mt8195-vcodec-enc";
+			reg = <0 0x1a020000 0 0x10000>;
+			iommus = <&iommu_vdo M4U_PORT_L19_VENC_RCPU>,
+				 <&iommu_vdo M4U_PORT_L19_VENC_REC>,
+				 <&iommu_vdo M4U_PORT_L19_VENC_BSDMA>,
+				 <&iommu_vdo M4U_PORT_L19_VENC_SV_COMV>,
+				 <&iommu_vdo M4U_PORT_L19_VENC_RD_COMV>,
+				 <&iommu_vdo M4U_PORT_L19_VENC_CUR_LUMA>,
+				 <&iommu_vdo M4U_PORT_L19_VENC_CUR_CHROMA>,
+				 <&iommu_vdo M4U_PORT_L19_VENC_REF_LUMA>,
+				 <&iommu_vdo M4U_PORT_L19_VENC_REF_CHROMA>;
+			interrupts = <GIC_SPI 341 IRQ_TYPE_LEVEL_HIGH 0>;
+			mediatek,scp = <&scp>;
+			clocks = <&vencsys CLK_VENC_VENC>;
+			clock-names = "venc_sel";
+			assigned-clocks = <&topckgen CLK_TOP_VENC>;
+			assigned-clock-parents = <&topckgen CLK_TOP_UNIVPLL_D4>;
+			power-domains = <&spm MT8195_POWER_DOMAIN_VENC>;
+			#address-cells = <2>;
+			#size-cells = <2>;
+			dma-ranges = <0x1 0x0 0x0 0x40000000 0x0 0xfff00000>;
+		};
+
 		vencsys_core1: clock-controller@1b000000 {
 			compatible = "mediatek,mt8195-vencsys_core1";
 			reg = <0 0x1b000000 0 0x1000>;
-- 
2.18.0

