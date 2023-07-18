Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2ACBF75816E
	for <lists+linux-pci@lfdr.de>; Tue, 18 Jul 2023 17:55:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233762AbjGRPzW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 18 Jul 2023 11:55:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233763AbjGRPzV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 18 Jul 2023 11:55:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA4781705;
        Tue, 18 Jul 2023 08:55:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6D76A61632;
        Tue, 18 Jul 2023 15:55:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A56FC433B9;
        Tue, 18 Jul 2023 15:55:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689695717;
        bh=XkxaNzMQrlndpmaZ6Ahex4//qnr2RKplzVyK9NA4FAs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=bX5cTij+x74/dC4QWY3+zwYhnrlKfd4bd+c6mzDOa1cLDbU2o7xP5r85fBjHD2z9I
         l8TmTQP14ByqW0OOZzgqxP0yQ4VCdLyacPMuTzUQYHnWsP3oJujRfnJHnbtNyOcLFy
         b8gCnLR3hqFkOXSNmDgQWr9gqJxdrnyzkh0GoR9B6zBxq/d8yGXnMwmliYrvOmzgJ3
         6Igf/XmWqlfRWEfIFOgaVN6lkZFLONHsUmCqxq0l15oTbyqqbXsLg2q3OjAu8lctd9
         aI3mVU9RGSMJisZFb2m48ABZzssm9K5kx0nd6TanKixpFU/aqPWbrM8P83HLAWlr+p
         +jQiEa1Ec8lsA==
Date:   Tue, 18 Jul 2023 10:55:15 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Achal Verma <a-verma1@ti.com>
Cc:     Vignesh Raghavendra <vigneshr@ti.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof Wilczy_ski <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-omap@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] PCI: j721e: Delay 100ms T_PVPERL from power stable to
 PERST# inactive
Message-ID: <20230718155515.GA483233@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230707095119.447952-1-a-verma1@ti.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jul 07, 2023 at 03:21:19PM +0530, Achal Verma wrote:
> As per the PCIe Card Electromechanical specification REV. 5.0, PERST#
> signal should be de-asserted after minimum 100ms from the time power-rails
> become stable. So, to ensure 100ms delay to give sufficient time for
> power-rails and refclk to become stable, change delay from 100us to 100ms.
> 
> From PCIe Card Electromechanical specification REV. 5.0 section 2.9.2:
> TPVPERL: Power stable to PERST# inactive - 100ms
> 
> Fixes: f3e25911a430 ("PCI: j721e: Add TI J721E PCIe driver")
> Signed-off-by: Achal Verma <a-verma1@ti.com>
> ---
> 
> Changes from v2:
> * Fix commit message.
> 
> Change from v1:
> * Add macro for delay value.
> 
>  drivers/pci/controller/cadence/pci-j721e.c | 11 +++++------
>  drivers/pci/pci.h                          |  2 ++
>  2 files changed, 7 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/pci/controller/cadence/pci-j721e.c b/drivers/pci/controller/cadence/pci-j721e.c
> index e70213c9060a..32b6a7dc3cff 100644
> --- a/drivers/pci/controller/cadence/pci-j721e.c
> +++ b/drivers/pci/controller/cadence/pci-j721e.c
> @@ -498,14 +498,13 @@ static int j721e_pcie_probe(struct platform_device *pdev)
>  
>  		/*
>  		 * "Power Sequencing and Reset Signal Timings" table in
> -		 * PCI EXPRESS CARD ELECTROMECHANICAL SPECIFICATION, REV. 3.0
> -		 * indicates PERST# should be deasserted after minimum of 100us
> -		 * once REFCLK is stable. The REFCLK to the connector in RC
> -		 * mode is selected while enabling the PHY. So deassert PERST#
> -		 * after 100 us.
> +		 * PCI EXPRESS CARD ELECTROMECHANICAL SPECIFICATION, REV. 5.0
> +		 * indicates PERST# should be deasserted after minimum of 100ms
> +		 * after power rails achieve specified operating limits and
> +		 * within this period reference clock should also become stable.

I think the problem is not that the current code is *wrong*, because
we do need to observe T_PERST-CLK, but that it failed to *also*
account for T_PVPERL.

There are two delays before deasserting PERST#:

  T_PVPERL: delay after power becomes stable
  T_PERST-CLK: delay after REFCLK becomes stable

I assume power is enabled by phy_power_on(), and REFCLK is enabled by
clk_prepare_enable():

  cdns_pcie_init_phy
    cdns_pcie_enable_phy
      phy_power_on             <-- power becomes stable
  clk_prepare_enable           <-- REFCLK becomes stable
  if (gpiod)
    usleep_range
    gpiod_set_value_cansleep(gpiod, 1)   <-- deassert PERST#

I don't actually know if phy_power_on() guarantees that power is
stable before it returns.  But I guess that's our assumption?
Similarly for clk_prepare_enable().

In any case, we have to observe both delays.  They overlap, and
T_PVPERL is 1000 times longer than T_PERST-CLK, so there might be
enough slop in an msleep(100) to cover both, but I think I would do
the simple-minded:

  msleep(PCIE_TPVPERL_MS);
  usleep_range(PCIE_TPERST_CLK_US, 2 * PCIE_TPERST_CLK_US);

This is slightly more conservative than necessary because they
overlap, but at least it shows that we thought about both of them.

>  		if (gpiod) {
> -			usleep_range(100, 200);
> +			msleep(PCIE_TPVPERL_DELAY_MS);
>  			gpiod_set_value_cansleep(gpiod, 1);

I wish this local variable were named something like "perst_gpiod"
instead of "gpiod".  We already know from its use in
gpiod_set_value_cansleep() that it's a GPIO.  What's NOT obvious from
the context is that this is the PERST# signal.

Tangent: it looks like the DT "reset" property that I'm assuming
controls PERST# is optional.  How do we enforce these delays if that
property is missing?

> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index a4c397434057..6ab2367e5867 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -13,6 +13,8 @@
>  
>  #define PCIE_LINK_RETRAIN_TIMEOUT_MS	1000
>  
> +#define PCIE_TPVPERL_DELAY_MS	100	/* see PCIe CEM r5.0, sec 2.9.2 */
> +
>  extern const unsigned char pcie_link_speed[];
>  extern bool pci_early_dump;
>  
> -- 
> 2.25.1
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
