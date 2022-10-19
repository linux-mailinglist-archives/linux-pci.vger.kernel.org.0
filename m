Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E277C60441C
	for <lists+linux-pci@lfdr.de>; Wed, 19 Oct 2022 13:58:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229773AbiJSL6T (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 19 Oct 2022 07:58:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232226AbiJSL5s (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 19 Oct 2022 07:57:48 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72A90BE37;
        Wed, 19 Oct 2022 04:35:44 -0700 (PDT)
X-UUID: 34acd60cc80d4990bce2455bf390b3c9-20221019
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=cSeJUyFSeok6ngFkYCaH8KpME5/ESKjKnL4imI8pLTw=;
        b=PDKa1XaV8UieJrHHR+UTXbQfm/hVyCdohgzFGftdl4QG0iB/Y+peIH+ElM7++SmmjGgqaa2bjTvii+OiGLmDKspaOy2zeu//65yP/sNEhMvotYiVzEjrM6BVXnFakiFjQueBqRm+go/nQPtHXo/j0WFDkpv1aFFmRm5EiICoFEU=;
X-CID-UNFAMILIAR: 1
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.12,REQID:6ebdbc00-af9e-4b5b-a14d-21d30de43647,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:54,FILE:0,BULK:28,RULE:Release_Ham,ACTIO
        N:release,TS:82
X-CID-INFO: VERSION:1.1.12,REQID:6ebdbc00-af9e-4b5b-a14d-21d30de43647,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:54,FILE:0,BULK:28,RULE:Spam_GS981B3D,ACTIO
        N:quarantine,TS:82
X-CID-META: VersionHash:62cd327,CLOUDID:846449a4-ebb2-41a8-a87c-97702aaf2e20,B
        ulkID:22101906415932MWZJGX,BulkQuantity:83,Recheck:0,SF:38|28|16|19|48|102
        ,TC:nil,Content:0,EDM:-3,IP:nil,URL:11|1,File:nil,Bulk:40|20,QS:nil,BEC:ni
        l,COL:0
X-UUID: 34acd60cc80d4990bce2455bf390b3c9-20221019
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <irui.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1757139302; Wed, 19 Oct 2022 16:56:52 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3;
 Wed, 19 Oct 2022 16:56:50 +0800
Received: from mhfsdcap04 (10.17.3.154) by mtkmbs11n2.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.15 via Frontend
 Transport; Wed, 19 Oct 2022 16:56:49 +0800
Message-ID: <e710546052b93ee2e77b1aeae3f7e4631e884f9f.camel@mediatek.com>
Subject: Re: [PATCH v1 3/3] arm64: dts: mt8195: Add venc node
From:   Irui Wang <irui.wang@mediatek.com>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Tinghan Shen <tinghan.shen@mediatek.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Jianjun Wang <jianjun.wang@mediatek.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     <linux-pci@vger.kernel.org>, <linux-mediatek@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Date:   Wed, 19 Oct 2022 16:56:49 +0800
In-Reply-To: <01ef8a2d-091f-5428-2cb8-41ba3e137a06@collabora.com>
References: <20221017070858.13902-1-tinghan.shen@mediatek.com>
         <20221017070858.13902-4-tinghan.shen@mediatek.com>
         <01ef8a2d-091f-5428-2cb8-41ba3e137a06@collabora.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
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

On Wed, 2022-10-19 at 10:51 +0200, AngeloGioacchino Del Regno wrote:
> Il 17/10/22 09:08, Tinghan Shen ha scritto:
> > Add venc node for mt8195 SoC.
> > 
> > Signed-off-by: Irui Wang <irui.wang@mediatek.com>
> > Signed-off-by: Tinghan Shen <tinghan.shen@mediatek.com>
> > ---
> >   arch/arm64/boot/dts/mediatek/mt8195.dtsi | 24
> > ++++++++++++++++++++++++
> >   1 file changed, 24 insertions(+)
> > 
> > diff --git a/arch/arm64/boot/dts/mediatek/mt8195.dtsi
> > b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
> > index 903e92d6156f..7cf2f7ef4ec6 100644
> > --- a/arch/arm64/boot/dts/mediatek/mt8195.dtsi
> > +++ b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
> > @@ -2163,6 +2163,30 @@
> >   			power-domains = <&spm
> > MT8195_POWER_DOMAIN_VENC>;
> >   		};
> >   
> > +		venc: venc@1a020000 {
> 
> As Krzysztof also said, this is video-codec@1a020000.
> 
> Also, there's one more thing... MT8195 has two video encoder cores,
> but this
> node is only for the first one. There's a second instance at
> 0x1b020000: please
> add it.
Dear Angelo,

The second video encoder core 0x1b020000 is not ready in driver, there
is only one core 0x1a020000 used, so we don't need add it in current
patch now.

Thanks
Best Regards
> 
> Regards,
> Angelo
> 

