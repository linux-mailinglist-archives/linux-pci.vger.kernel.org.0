Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD5756EA6E1
	for <lists+linux-pci@lfdr.de>; Fri, 21 Apr 2023 11:26:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231318AbjDUJ0y (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 21 Apr 2023 05:26:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230052AbjDUJ0x (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 21 Apr 2023 05:26:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 836EE76A6;
        Fri, 21 Apr 2023 02:26:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 20E8264F43;
        Fri, 21 Apr 2023 09:26:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64FF0C433D2;
        Fri, 21 Apr 2023 09:26:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682069210;
        bh=V4sdsVOUsepYZTjE1sLvK3nR6G8EVYU9R8GdYObEEvc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=My36iI0dhWRkKXWHsstC4Ri45laeNZFmNEJZVDi9qspdjYu1xSzngDfgnr6Myz6YH
         dr/J7zgKIjoaDHda2XgoIPuuzjb2Dv5VQaEPXXtCSD3y680WhzBILiaoaxL0CbcYoD
         4H8g3c7MrI1QaSMPY4VcuYWPxG4mEziKqkkDCTDbAbIj06Rq/aIxfW1ywCTNOuY33y
         NUcvo1lnHuZk/Be3JojEF2x3j2IJBWRxDGIqz2x4cEHCSVvKJfekOepR3Kj04VDYDt
         YAI7KjKZYQqoDWkfDhwP1/INht5r5iKRcV1NmZyMeUDiEC2YpBWizPHVrcBWTVrtWj
         me735zoPNvQIA==
Date:   Fri, 21 Apr 2023 11:26:42 +0200
From:   Lorenzo Pieralisi <lpieralisi@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Rick Wertenbroek <rick.wertenbroek@gmail.com>,
        alberto.dassatti@heig-vd.ch, xxm@rock-chips.com,
        dlemoal@kernel.org, Shawn Lin <shawn.lin@rock-chips.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Caleb Connolly <kc@postmarketos.org>,
        Corentin Labbe <clabbe@baylibre.com>,
        Brian Norris <briannorris@chromium.org>,
        Johan Jonker <jbx6244@gmail.com>,
        Judy Hsiao <judyhsiao@chromium.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Hugh Cole-Baker <sigmaris@gmail.com>,
        Arnaud Ferraris <arnaud.ferraris@collabora.com>,
        linux-pci@vger.kernel.org, linux-rockchip@lists.infradead.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 06/11] dt-bindings: PCI: Update the RK3399 example to
 a valid one
Message-ID: <ZEJW0giyXAlNMYTz@lpieralisi>
References: <20230418074700.1083505-1-rick.wertenbroek@gmail.com>
 <20230418074700.1083505-7-rick.wertenbroek@gmail.com>
 <172c46b7-256e-b09d-3940-880fa8989b49@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <172c46b7-256e-b09d-3940-880fa8989b49@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Apr 19, 2023 at 10:01:25PM +0200, Krzysztof Kozlowski wrote:
> On 18/04/2023 09:46, Rick Wertenbroek wrote:
> > Update the example in the documentation to a valid example.
> > Address for mem-base was invalid, it pointed to address
> > 0x8000'0000 which is the upper region of the DDR which
> > is not necessarily populated depending on the board.
> > This address should point to the base of the memory
> > window region of the controller which is 0xfa00'0000.
> > Add missing pinctrl.
> > 
> > Signed-off-by: Rick Wertenbroek <rick.wertenbroek@gmail.com>
> > ---
> >  .../devicetree/bindings/pci/rockchip,rk3399-pcie-ep.yaml      | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/pci/rockchip,rk3399-pcie-ep.yaml b/Documentation/devicetree/bindings/pci/rockchip,rk3399-pcie-ep.yaml
> > index 88386a6d7011..6b62f6f58efe 100644
> > --- a/Documentation/devicetree/bindings/pci/rockchip,rk3399-pcie-ep.yaml
> > +++ b/Documentation/devicetree/bindings/pci/rockchip,rk3399-pcie-ep.yaml
> > @@ -47,7 +47,7 @@ examples:
> >  
> >          pcie-ep@f8000000 {
> >              compatible = "rockchip,rk3399-pcie-ep";
> > -            reg = <0x0 0xfd000000 0x0 0x1000000>, <0x0 0x80000000 0x0 0x20000>;
> > +            reg = <0x0 0xfd000000 0x0 0x1000000>, <0x0 0xfa000000 0x0 0x2000000>;
> >              reg-names = "apb-base", "mem-base";
> >              clocks = <&cru ACLK_PCIE>, <&cru ACLK_PERF_PCIE>,
> >                <&cru PCLK_PCIE>, <&cru SCLK_PCIE_PM>;
> > @@ -63,6 +63,8 @@ examples:
> >              phys = <&pcie_phy 0>, <&pcie_phy 1>, <&pcie_phy 2>, <&pcie_phy 3>;
> >              phy-names = "pcie-phy-0", "pcie-phy-1", "pcie-phy-2", "pcie-phy-3";
> >              rockchip,max-outbound-regions = <16>;
> > +            pinctrl-names = "default";
> > +            pinctrl-0 = <&pcie_clkreqnb_cpm>;
> 
> This is just example of the binding, you do not need to fill all
> unrelated (generic) properties like pinctrl.

Should I merge it as-is ?

Thanks,
Lorenzo

> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> Best regards,
> Krzysztof
> 
