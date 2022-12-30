Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE432659952
	for <lists+linux-pci@lfdr.de>; Fri, 30 Dec 2022 15:23:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230016AbiL3OXd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 30 Dec 2022 09:23:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiL3OXc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 30 Dec 2022 09:23:32 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 119C5140DF;
        Fri, 30 Dec 2022 06:23:32 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A0E1761248;
        Fri, 30 Dec 2022 14:23:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24401C433EF;
        Fri, 30 Dec 2022 14:23:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672410211;
        bh=zcaJItLsKe5pMJZqTOQWiHFFXdoP5Zq9l+fpmkv75BM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IL9imOI5yxaBKHRdy+zq1GgoXmPkEJXV5D8d1W9ecXojlJjxEjqCsmVIoUnUENPvR
         akcm4AtHP6SEShZA3loFCdOD7O8S7L4cD32H+VCgbXALy7V3Gxhz2VHreZVPVpbWiB
         tudmvpT7nUDXsLd8/1pFkgxLjQg7OIquL5l9BvTu99xSZRonlPe4IBIFO9k7SAf5/x
         H1nO27xEpUFId47UsYnqc9vyTE6XaXAZSgE7dlIHEkHjt3uJPSDzzDdfLT5h8aps7J
         Y2WlXQYzIFJjsmFRSo65o2drraH1AvHGxIWgqzFDdeGr14iP0oxEi9L3RBVfSkc2cX
         tQDVseaLY6OMQ==
Date:   Fri, 30 Dec 2022 15:23:26 +0100
From:   Lorenzo Pieralisi <lpieralisi@kernel.org>
To:     Sergio Paracuellos <sergio.paracuellos@gmail.com>
Cc:     linux-pci@vger.kernel.org, bhelgaas@google.com, robh@kernel.org,
        kw@linux.com, matthias.bgg@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: mt7621: Sleep a bit after power on the PCIs phy
 ports
Message-ID: <Y670XhTSrs3n9c0H@lpieralisi>
References: <20221209071703.2891714-1-sergio.paracuellos@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221209071703.2891714-1-sergio.paracuellos@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Dec 09, 2022 at 08:17:03AM +0100, Sergio Paracuellos wrote:
> Some devices like ZBT WE1326 and ZBT WF3526-P need to sleep a bit after call
> to mt7621_pcie_init_port() driver function to get into reliable boots for
> both warn and hard resets. The needed time for these devices to always detect

s/warn/warm

> the ports seems to be from 75 to 100 milliseconds. Hence, properly add an
> extra 100 milliseconds msleep() call to make also these devices work.

This sounds empirical and it probably is, is it asking too much please
to add why this delay is *actually* needed ? I think it is important
to understand that to make sure that in the future developers have a
clue about why this code was added.

At the very least add a Link: tag to the openwrt discussion.

> Signed-off-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
> ---
> Hi Bjorn / Lorenzo,
> 
> I send previous patch here [0] related with this issue. Since after a bit
> of testing with these devices by openwrt community [1] we end up that there is
> no need of increasing PERST_DELAY_MS definition. This is also the reason
> of not sending a v2 for this but a new patch with the proper solution.

See above, please define "proper". I don't have a problem with defining
multiple delays as long as we can define with certainty what they are
there for.

> I preferred to just use the same PERST_DELAY_MS define also for this to
> not perform extra changes but the needed to the driver.

The problem is not adding more defines, the problem is defining what
the delay is there for. Reusing the macro may even turn out to be
misleading if that has nothing to do with PERST - that's what Bjorn
pointed out already.

> If you prefer me to write new definitions for all the sleep paths you
> pointed out in [0], just let me know and I will send them also.

Yes, see above.

Thanks,
Lorenzo

> Thanks in advance for your time.
> 
> Best regards,
>     Sergio Paracuellos
> 
> [0]: https://lore.kernel.org/linux-pci/20221119110837.2419466-1-sergio.paracuellos@gmail.com/T/#u
> [1]: https://github.com/openwrt/openwrt/pull/11220
> 
>  drivers/pci/controller/pcie-mt7621.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/pci/controller/pcie-mt7621.c b/drivers/pci/controller/pcie-mt7621.c
> index 4bd1abf26008..3311ca64b315 100644
> --- a/drivers/pci/controller/pcie-mt7621.c
> +++ b/drivers/pci/controller/pcie-mt7621.c
> @@ -369,6 +369,7 @@ static int mt7621_pcie_init_ports(struct mt7621_pcie *pcie)
>  		}
>  	}
>  
> +	msleep(PERST_DELAY_MS);
>  	mt7621_pcie_reset_ep_deassert(pcie);
>  
>  	tmp = NULL;
> -- 
> 2.25.1
> 
