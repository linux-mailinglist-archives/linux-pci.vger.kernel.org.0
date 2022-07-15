Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62742576A70
	for <lists+linux-pci@lfdr.de>; Sat, 16 Jul 2022 01:12:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231699AbiGOXM1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 15 Jul 2022 19:12:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231540AbiGOXM0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 15 Jul 2022 19:12:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A29C26D54E;
        Fri, 15 Jul 2022 16:12:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 41E7C61AE1;
        Fri, 15 Jul 2022 23:12:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69F26C34115;
        Fri, 15 Jul 2022 23:12:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657926744;
        bh=gWF6p/e5bQgEu3Lm9V/vPDeCZtniM/aHoIU18lhyAl0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=q/dv42xM7AWBcJ4xHFeFxaqhUMC7SW2RV25TqCrYpVNi+TX6+NED1tSe28INHHyRD
         HAs0r5sTycWwEy3ub2cOLt5KOc5EBJRU/+ip3GM1yEcreOoo0yarTSs99xe4y8wrt1
         D9n5QmpHVpB9AJcf80jBDl8J+99LRRqQYjIirIWeBUB15u62acG5vbIlT8KHDiTle+
         TiSP84Hf5Bo99ObHNLd6T8yyD6VDRFF9VVbFT9rcIHpGYrjDI0Nkb32YYwWPaAIPwU
         IFr4VXmq6vvFwJxjfh4ebVSq11DWrhAS5d4nND/m082Mod/7sZxiVHJqkN5Ubr2UZK
         PorvGJaJ8O52A==
Date:   Fri, 15 Jul 2022 18:12:22 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        linux-pci@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-phy@lists.infradead.org, Jingoo Han <jingoohan1@gmail.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Kishon Vijay Abraham I <kishon@ti.com>
Subject: Re: [PATCH 1/2] phy: samsung: phy-exynos-pcie: sanitize
 init/power_on callbacks
Message-ID: <20220715231222.GA1210037@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220715224303.GA1207726@bhelgaas>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jul 15, 2022 at 05:43:03PM -0500, Bjorn Helgaas wrote:
> On Fri, Jul 15, 2022 at 05:05:30PM +0530, Vinod Koul wrote:
> > On 12-07-22, 15:12, Bjorn Helgaas wrote:
> > > On Tue, Jul 05, 2022 at 11:55:23AM +0530, Vinod Koul wrote:
> > > > On 29-06-22, 00:04, Marek Szyprowski wrote:
> > > > > The exynos-pcie driver called phy_power_on() and then phy_init() for some
> > > > > historical reasons. However the generic PHY framework assumes that the
> > > > > proper sequence is to call phy_init() first, then phy_power_on(). The
> > > > > operations done by both functions should be considered as one action and
> > > > > as such they are called by the exynos-pcie driver (without doing anything
> > > > > between them). The initialization is just a sequence of register writes,
> > > > > which cannot be altered, without breaking the hardware operation.
> > > > > 
> > > > > To match the generic PHY framework requirement, simply move all register
> > > > > writes to the phy_init()/phy_exit() and drop power_on()/power_off()
> > > > > callbacks. This way the driver will also work with the old (incorrect)
> > > > > PHY initialization call sequence.
> > > > 
> > > > Is the plan to merge thru pcie tree?
> > > 
> > > I guess these patches should go together.  I don't see any major
> > > exynos series pending, but I do have two minor pci-exynos.c patches in
> > > the queue.
> > > 
> > > If you ack it (after resolution of your question below) I'd be happy
> > > to take both if it doesn't cause trouble for you.
> > 
> > Done now.
> 
> Is this an ack?
> 
> I didn't see any response to your question (added back below).  Are
> you happy with the patch as-is?

Oops, sorry, I missed your ack [1].  That was more recent than your
question, so I assume you're ok with the patch as-is.

I *would* like an ack from the maintainer, but I'm not sure whether
Jingoo is still paying attention to pci-exynos.c.

[1] https://lore.kernel.org/r/YtFQ67MmloipjNzj@matsya

> > > > > @@ -51,6 +51,13 @@ static int exynos5433_pcie_phy_init(struct phy *phy)
> > > > >  {
> > > > >       struct exynos_pcie_phy *ep = phy_get_drvdata(phy);
> > > > >
> > > > > +     regmap_update_bits(ep->pmureg, EXYNOS5433_PMU_PCIE_PHY_OFFSET,
> > > > > +                        BIT(0), 1);
> > > > > +     regmap_update_bits(ep->fsysreg, PCIE_EXYNOS5433_PHY_GLOBAL_RESET,
> > > > > +                        PCIE_APP_REQ_EXIT_L1_MODE, 0);
> > > > > +     regmap_update_bits(ep->fsysreg, PCIE_EXYNOS5433_PHY_L1SUB_CM_CON,
> > > > > +                        PCIE_REFCLK_GATING_EN, 0);
> > > > > +
> > > > 
> > > > why not retain exynos5433_pcie_phy_power_on() and call it from here and
> > > > drop in ops. It would be clear to reader that these are for turning on
> > > > the phy...
