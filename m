Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D829605553
	for <lists+linux-pci@lfdr.de>; Thu, 20 Oct 2022 04:11:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229610AbiJTCLG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 19 Oct 2022 22:11:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229775AbiJTCLE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 19 Oct 2022 22:11:04 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDB20164BEC;
        Wed, 19 Oct 2022 19:11:02 -0700 (PDT)
X-UUID: 98f5b9142ff349de9ac6a3e910a87808-20221020
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=JaIR81W7uRC3RHrO6DoWqaK6YpTRAbe3E0L77VhfzRA=;
        b=GY5OXJHiGC3wCbJ/uUXv0sru4cUlpNZz0lQ8EctPjyqqOoph1SPRm1UOgXl/j2tWQCH2oopP02XnVFaJWmm8LvsjhrvglZiFSD3H5wWtNDqhSS2Tg3wTrEJEj6OA79RBjUtE2tF6tk9eHWZ4m2ZSBlGM4WefNpG+u6+k+SP3JFg=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.12,REQID:4288b337-0a83-4b1b-a778-9d389e66fb46,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:62cd327,CLOUDID:0c6f5ba4-ebb2-41a8-a87c-97702aaf2e20,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: 98f5b9142ff349de9ac6a3e910a87808-20221020
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <jianjun.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1432779166; Thu, 20 Oct 2022 10:10:57 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.186) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Thu, 20 Oct 2022 10:10:56 +0800
Received: from mhfsdcap04 (10.17.3.154) by mtkmbs11n1.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.15 via Frontend
 Transport; Thu, 20 Oct 2022 10:10:55 +0800
Message-ID: <ccb830693f467b59d829c7929ea3b47b2d4c029f.camel@mediatek.com>
Subject: Re: [PATCH v1 2/3] arm64: dts: mt8195: Add pcie and pcie phy nodes
From:   Jianjun Wang <jianjun.wang@mediatek.com>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Tinghan Shen <tinghan.shen@mediatek.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     <linux-pci@vger.kernel.org>, <linux-mediatek@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Date:   Thu, 20 Oct 2022 10:10:55 +0800
In-Reply-To: <c30fbc60-bcdf-71f5-0db7-bd9bb27ddd37@collabora.com>
References: <20221017070858.13902-1-tinghan.shen@mediatek.com>
         <20221017070858.13902-3-tinghan.shen@mediatek.com>
         <c30fbc60-bcdf-71f5-0db7-bd9bb27ddd37@collabora.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Angelo,

Thanks for your review.

On Wed, 2022-10-19 at 10:55 +0200, AngeloGioacchino Del Regno wrote:
> Il 17/10/22 09:08, Tinghan Shen ha scritto:
> > Add pcie and pcie phy nodes for mt8195.
> > 
> > Signed-off-by: Jianjun Wang <jianjun.wang@mediatek.com>
> > Signed-off-by: Tinghan Shen <tinghan.shen@mediatek.com>
> > ---
> >   arch/arm64/boot/dts/mediatek/mt8195.dtsi | 143
> > +++++++++++++++++++++++
> >   1 file changed, 143 insertions(+)
> > 
> > diff --git a/arch/arm64/boot/dts/mediatek/mt8195.dtsi
> > b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
> > index d03f0c2b8233..903e92d6156f 100644
> > --- a/arch/arm64/boot/dts/mediatek/mt8195.dtsi
> > +++ b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
> > @@ -1182,6 +1182,104 @@
> >   			status = "disabled";
> >   		};
> >   
> > +		pcie0: pcie@112f0000 {
> > +			compatible = "mediatek,mt8195-pcie",
> > +				     "mediatek,mt8192-pcie";
> 
> ..snip..
> 
> > +
> > +			phys = <&pciephy>;
> > +			phy-names = "pcie-phy";
> > +
> > +			power-domains = <&spm
> > MT8195_POWER_DOMAIN_PCIE_MAC_P0>;
> 
> You're missing the resets:
> 
> 			resets = <&infracfg_ao
> MT8195_INFRA_RST2_PCIE_P0_SWRST>;
> 			reset-names = "mac";
> 
> > +
> > +			#interrupt-cells = <1>;
> > +			interrupt-map-mask = <0 0 0 7>;
> 
> ..snip..
> 
> > +		};
> > +
> > +		pcie1: pcie@112f8000 {
> > +			compatible = "mediatek,mt8195-pcie",
> > +				     "mediatek,mt8192-pcie";
> 
> ..snip..
> 
> > +			power-domains = <&spm
> > MT8195_POWER_DOMAIN_PCIE_MAC_P1>;
> 
> Here too:
> 			resets = <&infracfg_ao
> MT8195_INFRA_RST2_USBSIF_P1_SWRST>,

Reset the combo-phy in PCIe driver will cause side effect on USB2 port,
so this reset cannot be added.

We will fix others in the next version.

Thanks.
> 				 <&infracfg_ao
> MT8195_INFRA_RST2_PCIE_P1_SWRST>;
> 			reset-names = "phy", "mac";
> 
> > +
> > +			#interrupt-cells = <1>;
> 
> ..snip..
> 
> > @@ -1241,6 +1339,34 @@
> >   				reg = <0x189 0x2>;
> >   				bits = <7 5>;
> >   			};
> > +			pciephy_rx_ln1: pciephy-rx-ln1@190 {
> > +				reg = <0x190 0x1>;
> > +				bits = <0 4>;
> > +			};
> > +			pciephy_tx_ln1_nmos: pciephy-tx-ln1-nmos@190 {
> 
> Please run dtbs_check and try to build the kernel before pushing
> commits upstream.
> This will give you a not-so-nice warning and that shall not happen.
> 
> You can solve it by naming these nodes like:
> pciephy-rx-ln1@190,1
> pciephy-tx-ln1-nmos@190,2
> 
> ...etc
> 
> Regards,
> Angelo
> 
> 

