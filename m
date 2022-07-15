Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10C40576A18
	for <lists+linux-pci@lfdr.de>; Sat, 16 Jul 2022 00:43:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232360AbiGOWny (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 15 Jul 2022 18:43:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230429AbiGOWnc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 15 Jul 2022 18:43:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15DCC8E6D6;
        Fri, 15 Jul 2022 15:43:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9BA76618BF;
        Fri, 15 Jul 2022 22:43:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE14BC34115;
        Fri, 15 Jul 2022 22:43:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657924986;
        bh=+Ghj1AGYNiL5sUfl4veMNlQQN216yF6xPHyedaWdvTs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=aQZObKXCg15oT9Y3LaBxVR/Jm2Ol1m3/FYzwFErSEvorEhDs0YiXE3aZPL7kuOh6z
         wbf/M2G71nWJhdA3te5TPI4vBEUwvl5NWRu7fi9i56xNuF+hvwvZ3ikoaL+cPIdVWx
         etLgA83V+OdaVazN2ibIv37FVQB19Kv4whwblBvA3Zzbvccco/ucmDYh4N8RL2GNnC
         JW+2UdrhHaF2kUKmiBMePz3Kag8V7EPdE0g2qqjgMI9GW51FmkBg22t0xAShQ/RxNg
         i4yfmqEwpDXGMru1kV8rcu9wkw8+GUV1Tp44oBvpRx2C2aRmIgDtk7x/QsQi9Rw40e
         qDyAyR+jiNB/w==
Date:   Fri, 15 Jul 2022 17:43:03 -0500
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
Message-ID: <20220715224303.GA1207726@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YtFRAkt4onP4CZIj@matsya>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jul 15, 2022 at 05:05:30PM +0530, Vinod Koul wrote:
> On 12-07-22, 15:12, Bjorn Helgaas wrote:
> > On Tue, Jul 05, 2022 at 11:55:23AM +0530, Vinod Koul wrote:
> > > On 29-06-22, 00:04, Marek Szyprowski wrote:
> > > > The exynos-pcie driver called phy_power_on() and then phy_init() for some
> > > > historical reasons. However the generic PHY framework assumes that the
> > > > proper sequence is to call phy_init() first, then phy_power_on(). The
> > > > operations done by both functions should be considered as one action and
> > > > as such they are called by the exynos-pcie driver (without doing anything
> > > > between them). The initialization is just a sequence of register writes,
> > > > which cannot be altered, without breaking the hardware operation.
> > > > 
> > > > To match the generic PHY framework requirement, simply move all register
> > > > writes to the phy_init()/phy_exit() and drop power_on()/power_off()
> > > > callbacks. This way the driver will also work with the old (incorrect)
> > > > PHY initialization call sequence.
> > > 
> > > Is the plan to merge thru pcie tree?
> > 
> > I guess these patches should go together.  I don't see any major
> > exynos series pending, but I do have two minor pci-exynos.c patches in
> > the queue.
> > 
> > If you ack it (after resolution of your question below) I'd be happy
> > to take both if it doesn't cause trouble for you.
> 
> Done now.

Is this an ack?

I didn't see any response to your question (added back below).  Are
you happy with the patch as-is?

> > > > @@ -51,6 +51,13 @@ static int exynos5433_pcie_phy_init(struct phy *phy)
> > > >  {
> > > >       struct exynos_pcie_phy *ep = phy_get_drvdata(phy);
> > > >
> > > > +     regmap_update_bits(ep->pmureg, EXYNOS5433_PMU_PCIE_PHY_OFFSET,
> > > > +                        BIT(0), 1);
> > > > +     regmap_update_bits(ep->fsysreg, PCIE_EXYNOS5433_PHY_GLOBAL_RESET,
> > > > +                        PCIE_APP_REQ_EXIT_L1_MODE, 0);
> > > > +     regmap_update_bits(ep->fsysreg, PCIE_EXYNOS5433_PHY_L1SUB_CM_CON,
> > > > +                        PCIE_REFCLK_GATING_EN, 0);
> > > > +
> > > 
> > > why not retain exynos5433_pcie_phy_power_on() and call it from here and
> > > drop in ops. It would be clear to reader that these are for turning on
> > > the phy...
