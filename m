Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF39576D7AA
	for <lists+linux-pci@lfdr.de>; Wed,  2 Aug 2023 21:24:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229926AbjHBTYu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 2 Aug 2023 15:24:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbjHBTYt (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 2 Aug 2023 15:24:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AE91119;
        Wed,  2 Aug 2023 12:24:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 27F6361AE1;
        Wed,  2 Aug 2023 19:24:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40F7BC433C7;
        Wed,  2 Aug 2023 19:24:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691004287;
        bh=ceVwIDyjSpFimVYJA8IpCtR5gV/pCzomVlAV3sy7vK8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=DVEWldMGeNvP66mevWA8PK/kEqqZkNcCybPk+5q6lc4jhziWzj+L4cr9l5j10oFWw
         MtWiCnFHp5OMEuBxN+GvukCdaRDJj/GO8ZJBOWcd4KK53IDFjCkY4vE5JLp8ZS5QBQ
         rkwaOJf/o4NCAkQaPOqojwL2eK2Be6GLt7URxpSmSb2f82l7Cl2ubCa5HsQuGpN3Up
         V0uTawhQ1GCiVUD/Tl2XksQxaQ1lZSDsswgp2fucwZJN7B53z21xjNMQmObtjUpicV
         eZLA/LOeD5v7pjJPxJ+uAEiyFyamxcpdn8Hptps3zDjVm2uQ2zeWNjrW/LyRFsNvY/
         Y1HsTEDpLRt6A==
Date:   Wed, 2 Aug 2023 14:24:45 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "Verma, Achal" <a-verma1@ti.com>
Cc:     Vignesh Raghavendra <vigneshr@ti.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof Wilczy_ski <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-omap@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [EXTERNAL] Re: [PATCH v3] PCI: j721e: Delay 100ms T_PVPERL from
 power stable to PERST# inactive
Message-ID: <20230802192445.GA64939@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8951d4fd-279d-8a78-65a3-daeb4befa899@ti.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Aug 02, 2023 at 02:38:02PM +0530, Verma, Achal wrote:
> On 7/18/2023 9:25 PM, Bjorn Helgaas wrote:
> > On Fri, Jul 07, 2023 at 03:21:19PM +0530, Achal Verma wrote:
> > > As per the PCIe Card Electromechanical specification REV. 5.0, PERST#
> > > signal should be de-asserted after minimum 100ms from the time power-rails
> > > become stable. So, to ensure 100ms delay to give sufficient time for
> > > power-rails and refclk to become stable, change delay from 100us to 100ms.
> > > 
> > >  From PCIe Card Electromechanical specification REV. 5.0 section 2.9.2:
> > > TPVPERL: Power stable to PERST# inactive - 100ms
> > > 
> > > Fixes: f3e25911a430 ("PCI: j721e: Add TI J721E PCIe driver")
> > > Signed-off-by: Achal Verma <a-verma1@ti.com>
> > > ---
> > > 
> > > Changes from v2:
> > > * Fix commit message.
> > > 
> > > Change from v1:
> > > * Add macro for delay value.
> > > 
> > >   drivers/pci/controller/cadence/pci-j721e.c | 11 +++++------
> > >   drivers/pci/pci.h                          |  2 ++
> > >   2 files changed, 7 insertions(+), 6 deletions(-)
> > > 
> > > diff --git a/drivers/pci/controller/cadence/pci-j721e.c b/drivers/pci/controller/cadence/pci-j721e.c
> > > index e70213c9060a..32b6a7dc3cff 100644
> > > --- a/drivers/pci/controller/cadence/pci-j721e.c
> > > +++ b/drivers/pci/controller/cadence/pci-j721e.c
> > > @@ -498,14 +498,13 @@ static int j721e_pcie_probe(struct platform_device *pdev)
> > >   		/*
> > >   		 * "Power Sequencing and Reset Signal Timings" table in
> > > -		 * PCI EXPRESS CARD ELECTROMECHANICAL SPECIFICATION, REV. 3.0
> > > -		 * indicates PERST# should be deasserted after minimum of 100us
> > > -		 * once REFCLK is stable. The REFCLK to the connector in RC
> > > -		 * mode is selected while enabling the PHY. So deassert PERST#
> > > -		 * after 100 us.
> > > +		 * PCI EXPRESS CARD ELECTROMECHANICAL SPECIFICATION, REV. 5.0
> > > +		 * indicates PERST# should be deasserted after minimum of 100ms
> > > +		 * after power rails achieve specified operating limits and
> > > +		 * within this period reference clock should also become stable.
> > 
> > I think the problem is not that the current code is *wrong*, because
> > we do need to observe T_PERST-CLK, but that it failed to *also*
> > account for T_PVPERL.
> > 
> > There are two delays before deasserting PERST#:
> > 
> >    T_PVPERL: delay after power becomes stable
> >    T_PERST-CLK: delay after REFCLK becomes stable
> > 
> > I assume power is enabled by phy_power_on(), and REFCLK is enabled by
> > clk_prepare_enable():
> > 
> >    cdns_pcie_init_phy
> >      cdns_pcie_enable_phy
> >        phy_power_on             <-- power becomes stable
> >    clk_prepare_enable           <-- REFCLK becomes stable
> >    if (gpiod)
> >      usleep_range
> >      gpiod_set_value_cansleep(gpiod, 1)   <-- deassert PERST#
> > 
> > I don't actually know if phy_power_on() guarantees that power is
> > stable before it returns.  But I guess that's our assumption?
> > Similarly for clk_prepare_enable().
> > 
> > In any case, we have to observe both delays.  They overlap, and
> > T_PVPERL is 1000 times longer than T_PERST-CLK, so there might be
> > enough slop in an msleep(100) to cover both, but I think I would do
> > the simple-minded:
> > 
> >    msleep(PCIE_TPVPERL_MS);
> >    usleep_range(PCIE_TPERST_CLK_US, 2 * PCIE_TPERST_CLK_US);
> > 
> I think adding 100us more is not required since as you said and as also
> mentioned in CEM spec, 100ms covers for both power rails and refclock to
> get stable and 2 consecutive sleep call looks different to me.
> But if still required (please let me know), will do the suggested change,
> along with other fixes you asked below.

If REFCLK is stable when clk_prepare_enable() returns, and we don't
start the msleep(PCIE_TPVPERL_MS) until then, it should be safe.  
Maybe mention T_PERST-CLK in a comment, e.g.,

  PCIe CEM r5.0, sec 2.2.1, requires both T_PVPERL (100ms) between
  power stable and PERST# inactive and T_PERST_CLK (100us) between
  REFCLK stable and PERST# inactive.  Starting the T_PVPERL delay
  after REFCLK is stable means that delay covers T_PERST_CLK as well.

Bjorn
