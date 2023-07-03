Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C0AC7460A3
	for <lists+linux-pci@lfdr.de>; Mon,  3 Jul 2023 18:22:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230073AbjGCQWC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 3 Jul 2023 12:22:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbjGCQWC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 3 Jul 2023 12:22:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EFE1AD;
        Mon,  3 Jul 2023 09:22:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 93E8760FBC;
        Mon,  3 Jul 2023 16:21:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C142EC433C9;
        Mon,  3 Jul 2023 16:21:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688401319;
        bh=vgOJfFEIDfdRkuFQPBdlwrwSFvJWLpp+9lkvO+4Uylw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=dazKdJY2e/WIRBKy3jXvSi37rbBPFup6sqCFVlh4JTzH4d0DGeVb/SxxkdEMr5gO1
         x/CO12NK2Dg6ctrBfDmnXvt4mXV4yrl5mfGXXqLQIXuimFCU+UIX/drsJq/sHscVWE
         KpwQlkYZHYsTfY4+ZkKrEZBHdg/BgY331kc9MQ+Va4t/8F7D60PDN3c1ZSxytlnJTm
         69ERyDnPz2cEVMq9DAymBzouppAFJc8LBa5cx+bI80mBboqb9rmov68pPof9TjtqYT
         WPm8f+5P8avwKFGzWHZUlSrVsrGimUHvuiI8ocK4q6/E2/wwdYzJ9b61D2cBbPtph+
         7eZ///LiXr7aA==
Date:   Mon, 3 Jul 2023 11:21:56 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Achal Verma <a-verma1@ti.com>
Cc:     Vignesh Raghavendra <vigneshr@ti.com>,
        Tom Joseph <tjoseph@cadence.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof Wilczy_ski <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-omap@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: j721e: Fix delay before PERST# deassert
Message-ID: <20230703162156.GA525196@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230703112914.68806-1-a-verma1@ti.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

In subject, "Fix" doesn't convey much information.  Does it increase?
Decrease?  How much time are we talking about?  PERST# deassert is at
one end of the delay; what event is at the other end?

Some of these useful bits of information could appear in the subject
line.

On Mon, Jul 03, 2023 at 04:59:14PM +0530, Achal Verma wrote:
> As per the PCIe Card Electromechanical specification REV. 3.0, PERST#

I think the current rev of this spec is r5.0.  Can you cite that
instead?  I think the relevant section is r5.0, sec 2.9.2.

> signal should be de-asserted after minimum 100ms from the time power-rails
> become stable. Current delay of 100us is observed to be not enough on some
> custom platform implemented using TI's K3 SOCs.

Is this delay for the benefit of the Root Port or for the attached
Endpoint?  If the latter, my guess is that some Endpoints might
tolerate the current shorter delay, while others might require more,
and it doesn't sound like "TI's K3 SoC" would be relevant here.

> So, to ensure 100ms delay to give sufficient time for power-rails and
> refclk to become stable, change delay from 100us to 100ms.
> 
> From PCIe Card Electromechanical specification REV. 3.0 section 2.6.2:
> TPVPERL: Power stable to PERST# inactive - 100ms
> T-PERST-CLK: REFCLK stable before PERST# inactive - 100 usec.

Numbers like 100ms that come from the PCIe specs should have #defines
for them.  If we don't have one already, can you add one, please?

> Fixes: f3e25911a430 ("PCI: j721e: Add TI J721E PCIe driver")
> Signed-off-by: Achal Verma <a-verma1@ti.com>
> ---
>  drivers/pci/controller/cadence/pci-j721e.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/pci/controller/cadence/pci-j721e.c b/drivers/pci/controller/cadence/pci-j721e.c
> index e70213c9060a..fa2b4c11d2c4 100644
> --- a/drivers/pci/controller/cadence/pci-j721e.c
> +++ b/drivers/pci/controller/cadence/pci-j721e.c
> @@ -499,13 +499,12 @@ static int j721e_pcie_probe(struct platform_device *pdev)
>  		/*
>  		 * "Power Sequencing and Reset Signal Timings" table in
>  		 * PCI EXPRESS CARD ELECTROMECHANICAL SPECIFICATION, REV. 3.0
> -		 * indicates PERST# should be deasserted after minimum of 100us
> -		 * once REFCLK is stable. The REFCLK to the connector in RC
> -		 * mode is selected while enabling the PHY. So deassert PERST#
> -		 * after 100 us.
> +		 * indicates PERST# should be deasserted after minimum of 100ms
> +		 * after power rails achieve specified operating limits and
> +		 * within this period reference clock should also become stable.
>  		 */
>  		if (gpiod) {
> -			usleep_range(100, 200);
> +			msleep(100);
>  			gpiod_set_value_cansleep(gpiod, 1);
>  		}
>  
> -- 
> 2.25.1
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
