Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E15D074A37D
	for <lists+linux-pci@lfdr.de>; Thu,  6 Jul 2023 19:58:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232123AbjGFR57 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 6 Jul 2023 13:57:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjGFR57 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 6 Jul 2023 13:57:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4904C199F;
        Thu,  6 Jul 2023 10:57:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D8B4461140;
        Thu,  6 Jul 2023 17:57:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F233C433C8;
        Thu,  6 Jul 2023 17:57:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688666277;
        bh=F0YCEMz+odMRbJqorHQE3V8C/7tKkwnudxHV68TPaNk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=tyg0mflToQ+t1YTLf03Rb3HotFd44LCSdV8mOF8CDfjjcIVAGSfNnmOZrwy5Rt599
         9aiRQenEh7raYpqYohB2snebRwfWrcCN/W37GB9WxUSixwIwYpGbnvtgRqcKQPLHvj
         abMtiXbemSry0vIk5shP5vhSBychVo3kExxy8v4C+ch+pWAYn3sJ7MOD/SDvRuQQdR
         Pz0xdmnXCUY39qFwdGS6CkBQ1o4yhNNfK+h8NDX8DCYMRsO3vitatFcYgXQzkH+ofr
         1WZ8l6R3nFu1hxuDpz5AxfT21Llp+DGn/cH5RQkeU+IDzbQ/cQGXGJJ/fQSoNiYXWO
         ZcJKRIQDkGmew==
Date:   Thu, 6 Jul 2023 12:57:55 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Achal Verma <a-verma1@ti.com>
Cc:     Vignesh Raghavendra <vigneshr@ti.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof Wilczy_ski <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-omap@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] PCI: j721e: Delay 100ms T_PVPERL from power stable to
 PERST# inactive
Message-ID: <20230706175755.GA104094@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230706043438.407600-1-a-verma1@ti.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jul 06, 2023 at 10:04:38AM +0530, Achal Verma wrote:
> As per the PCIe Card Electromechanical specification REV. 5.0, PERST#
> signal should be de-asserted after minimum 100ms from the time power-rails
> become stable.
> So, to ensure 100ms delay to give sufficient time for power-rails and
> refclk to become stable, change delay from 100us to 100ms.

Looks like the above is intended to be two paragraphs.  Add a blank
line between, or rewrap into a single paragraph if you prefer that.

> From PCIe Card Electromechanical specification REV. 5.0 section 2.9.2:
> TPVPERL: Power stable to PERST# inactive - 100ms
> T-PERST-CLK: REFCLK stable before PERST# inactive - 100 usec.

Is T-PERST-CLK relevant here?  Omit if not.

> Fixes: f3e25911a430 ("PCI: j721e: Add TI J721E PCIe driver")
> Signed-off-by: Achal Verma <a-verma1@ti.com>
> ---
>  drivers/pci/controller/cadence/pci-j721e.c | 11 +++++------
>  drivers/pci/pci.h                          |  2 ++
>  2 files changed, 7 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/pci/controller/cadence/pci-j721e.c b/drivers/pci/controller/cadence/pci-j721e.c
> index e70213c9060a..a3c8273b7320 100644
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
>  		 */
>  		if (gpiod) {
> -			usleep_range(100, 200);
> +			msleep(PCI_TPVPERL_DELAY);
>  			gpiod_set_value_cansleep(gpiod, 1);
>  		}
>  
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index a4c397434057..7482cff16fef 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -13,6 +13,8 @@
>  
>  #define PCIE_LINK_RETRAIN_TIMEOUT_MS	1000
>  
> +#define PCI_TPVPERL_DELAY	100	/* msec; see PCIe r5.0, sec 2.9.2 */

Perhaps make the name "PCIE_..." since this is a PCIe-specific time.

Also add "_MS" to the name so it's easy to verify that users are using
the correct mechanism (usleep/msleep/etc).

Otherwise looks good to me, thanks!

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
