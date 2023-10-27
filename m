Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F02327D9EB1
	for <lists+linux-pci@lfdr.de>; Fri, 27 Oct 2023 19:16:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235048AbjJ0RQn convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Fri, 27 Oct 2023 13:16:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235211AbjJ0RQc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 27 Oct 2023 13:16:32 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9336F7A9C;
        Fri, 27 Oct 2023 10:07:34 -0700 (PDT)
Received: from i53875a19.versanet.de ([83.135.90.25] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1qwQIX-0001eX-MH; Fri, 27 Oct 2023 19:07:01 +0200
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     Rob Herring <robh@kernel.org>,
        Niklas Cassel <Niklas.Cassel@wdc.com>
Cc:     Niklas Cassel <nks@flawful.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?B?V2lsY3p5xYRza2k=?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Simon Xue <xxm@rock-chips.com>,
        Damien Le Moal <dlemoal@kernel.org>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Serge Semin <fancer.lancer@gmail.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-rockchip@lists.infradead.org" 
        <linux-rockchip@lists.infradead.org>
Subject: Re: [PATCH v3 1/6] dt-bindings: PCI: dwc: rockchip: Add mandatory atu reg
Date:   Fri, 27 Oct 2023 19:07:00 +0200
Message-ID: <3040634.xgJ6IN8ObU@diego>
In-Reply-To: <ZTvh51PGCBhSjURY@x1-carbon>
References: <20231027145422.40265-1-nks@flawful.org>
 <CAL_JsqJh6aJb7_qsVnVNEABBg2utf0FPN+qYyOfsF2dAfZpd0w@mail.gmail.com>
 <ZTvh51PGCBhSjURY@x1-carbon>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_PASS,
        T_SPF_HELO_TEMPERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Niklas,

Am Freitag, 27. Oktober 2023, 18:14:32 CEST schrieb Niklas Cassel:
> On Fri, Oct 27, 2023 at 10:58:28AM -0500, Rob Herring wrote:
> > On Fri, Oct 27, 2023 at 9:56 AM Niklas Cassel <nks@flawful.org> wrote:
> > >
> > > From: Niklas Cassel <niklas.cassel@wdc.com>
> > >
> > > Even though rockchip-dw-pcie.yaml inherits snps,dw-pcie.yaml
> > > using:
> > >
> > > allOf:
> > >   - $ref: /schemas/pci/snps,dw-pcie.yaml#
> > >
> > > and snps,dw-pcie.yaml does have the atu reg defined, in order to be
> > > able to use this reg, while still making sure 'make CHECK_DTBS=y'
> > > pass, we need to add this reg to rockchip-dw-pcie.yaml.
> > >
> > > All compatible strings (rockchip,rk3568-pcie and rockchip,rk3588-pcie)
> > > should have this reg.
> > >
> > > The regs in the example are updated to actually match pcie3x2 on rk3568.
> > 
> > Breaking compatibility on these platforms is okay because ...?
> 
> I don't follow, could you please elaborate?

you're adding the atu reg unconditionally as required element.

Newer kernel versions (strongly) _should_ work with older devicetrees.
So a kernel with that change should also work with a dtb build from the
old style.

DTBs are essentially part of the device firmware, so while some devices
can update theirs easily, you can't really require a dtb update.

I guess you could something like:

   reg-names:
     oneOf:
       - deprecated: true
         items:
         - const: dbi
         - const: apb
         - const: config
       - items:
         - const: dbi
         - const: apb
         - const: config
         - const: atu
 
(may not be accurate and to spec yet)


