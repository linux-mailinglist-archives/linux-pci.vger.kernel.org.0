Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B39687585AA
	for <lists+linux-pci@lfdr.de>; Tue, 18 Jul 2023 21:38:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229797AbjGRTik (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 18 Jul 2023 15:38:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229705AbjGRTij (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 18 Jul 2023 15:38:39 -0400
Received: from smtp.dudau.co.uk (dliviu.plus.com [80.229.23.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E8C87198D;
        Tue, 18 Jul 2023 12:38:37 -0700 (PDT)
Received: from mail.dudau.co.uk (bart.dudau.co.uk [192.168.14.2])
        by smtp.dudau.co.uk (Postfix) with SMTP id 1735441A7003;
        Tue, 18 Jul 2023 20:38:36 +0100 (BST)
Received: by mail.dudau.co.uk (sSMTP sendmail emulation); Tue, 18 Jul 2023 20:38:36 +0100
Date:   Tue, 18 Jul 2023 20:38:36 +0100
From:   Liviu Dudau <liviu@dudau.co.uk>
To:     Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     linux-phy@lists.infradead.org, linux-rockchip@lists.infradead.org,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Serge Semin <fancer.lancer@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Simon Xue <xxm@rock-chips.com>, John Clark <inindev@gmail.com>,
        Qu Wenruo <wqu@suse.com>, devicetree@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kernel@collabora.com
Subject: Re: [PATCH v2 2/2] arm64: dts: rockchip: rk3588: add PCIe3 support
Message-ID: <ZLbqPB5yP7Kn6FT6@bart.dudau.co.uk>
References: <20230717173512.65169-1-sebastian.reichel@collabora.com>
 <20230717173512.65169-3-sebastian.reichel@collabora.com>
 <ZLarQUvUK3v3m6Cg@bart.dudau.co.uk>
 <20230718160137.sfitnkl6gmyi75jx@mercury.elektranox.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230718160137.sfitnkl6gmyi75jx@mercury.elektranox.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jul 18, 2023 at 06:01:37PM +0200, Sebastian Reichel wrote:
> Hi Liviu,
> 
> On Tue, Jul 18, 2023 at 04:09:53PM +0100, Liviu Dudau wrote:
> > On Mon, Jul 17, 2023 at 07:35:12PM +0200, Sebastian Reichel wrote:
> > > Add both PCIe3 controllers together with the shared PHY.
> > > 
> > > Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> > > ---
> > >  arch/arm64/boot/dts/rockchip/rk3588.dtsi | 120 +++++++++++++++++++++++
> > >  1 file changed, 120 insertions(+)
> > > 
> > > diff --git a/arch/arm64/boot/dts/rockchip/rk3588.dtsi b/arch/arm64/boot/dts/rockchip/rk3588.dtsi
> > > index 88d702575db2..8f210f002fac 100644
> > > --- a/arch/arm64/boot/dts/rockchip/rk3588.dtsi
> > > +++ b/arch/arm64/boot/dts/rockchip/rk3588.dtsi
> > > @@ -7,6 +7,11 @@
> > >  #include "rk3588-pinctrl.dtsi"
> > >  
> > >  / {
> > > +	pcie30_phy_grf: syscon@fd5b8000 {
> > > +		compatible = "rockchip,rk3588-pcie3-phy-grf", "syscon";
> > > +		reg = <0x0 0xfd5b8000 0x0 0x10000>;
> > > +	};
> > > +
> > >  	pipe_phy1_grf: syscon@fd5c0000 {
> > >  		compatible = "rockchip,rk3588-pipe-phy-grf", "syscon";
> > >  		reg = <0x0 0xfd5c0000 0x0 0x100>;
> > 
> > What tree is based this on? Even after applying your PCIe2 series I don't have the above
> > node so the patch doesn't apply to mainline.
> 
> You are missing naneng-combphy support:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip.git/commit/?h=v6.6-armsoc/dts64&id=6ebd55b3bba383e0523b0c014f17c97f3ce80708

Thanks! It looks like the PCIe2 commit that adds support to rk3588(s).dtsi
files is also missing an #include <dt-bindings/phy/phy.h> for the PHY_TYPE_PCIE
use, otherwise the DTS fail to compile.

Best regards,
Liviu

> 
> -- Sebastian



-- 
Everyone who uses computers frequently has had, from time to time,
a mad desire to attack the precocious abacus with an axe.
       	   	      	     	  -- John D. Clark, Ignition!
