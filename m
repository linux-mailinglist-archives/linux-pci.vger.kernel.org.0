Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8EFA669E3A
	for <lists+linux-pci@lfdr.de>; Fri, 13 Jan 2023 17:36:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230351AbjAMQge (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 13 Jan 2023 11:36:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230141AbjAMQgM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 13 Jan 2023 11:36:12 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70A0EA83E6;
        Fri, 13 Jan 2023 08:30:33 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CB6366226E;
        Fri, 13 Jan 2023 16:30:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC89BC433D2;
        Fri, 13 Jan 2023 16:30:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673627432;
        bh=j52NZSUcbPH04wq22NuEeLM/pe4Wo9omP1Wcc2GeDRk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tMxoK32yQiH3wR0wEpYOfAevbRha36rHH02Gwf6dMMQKX445c/KNCED5XVxbzyH1p
         cZVF5t2pOLb1VATvIhZiIj7J/xrBmFaj6BbDNNdeK9VLyoPSAYjgSqx71rzc2/ylXX
         Nf0MSQ8ci05/Fb6k+LziWXY6Ye4bJtNRAIDHAM30HywOdDz3r19ozJfHuiMG1WzTZH
         IsLmQ4dQcv6j6ekU/3NsxV14hU4xAPWnKz41p8wgsGMKZuLbINEyFKlaEspHssqhVK
         deO+FKx0GbCSnFzjDLDjUcZIDAA7n8POhuifnavTnfTbdARoyW3HKavsZ/FOLkObMQ
         Ivfoh9AC3Jbsw==
Date:   Fri, 13 Jan 2023 17:30:24 +0100
From:   Lorenzo Pieralisi <lpieralisi@kernel.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: rcar: avoid defines prefixed with CONFIG
Message-ID: <Y8GHICwCNRsYCva8@lpieralisi>
References: <20230113084516.31888-1-lukas.bulwahn@gmail.com>
 <CAMuHMdX_TPgXO2KYNdD5rRzuE9m6_JxfW-otWzw7r7Wptq_rOQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdX_TPgXO2KYNdD5rRzuE9m6_JxfW-otWzw7r7Wptq_rOQ@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jan 13, 2023 at 10:05:09AM +0100, Geert Uytterhoeven wrote:
> Hi Lukas,
> 
> On Fri, Jan 13, 2023 at 9:52 AM Lukas Bulwahn <lukas.bulwahn@gmail.com> wrote:
> > Defines prefixed with "CONFIG" should be limited to proper Kconfig options,
> > that are introduced in a Kconfig file.
> >
> > Here, a definition for a bitmask to configure the SEND_ENABLE mode is named
> > CONFIG_SEND_ENABLE.
> >
> > Rename this local definition to CONFIGURE_SEND_ENABLE to avoid defines
> > prefixed with "CONFIG".
> >
> > No functional change.
> >
> > Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> 
> Thanks for your patch!
> 
> > --- a/drivers/pci/controller/pcie-rcar.h
> > +++ b/drivers/pci/controller/pcie-rcar.h
> > @@ -11,7 +11,7 @@
> >
> >  #define PCIECAR                        0x000010
> >  #define PCIECCTLR              0x000018
> > -#define  CONFIG_SEND_ENABLE    BIT(31)
> > +#define  CONFIGURE_SEND_ENABLE BIT(31)
> 
> The R-Car Gen3 rev. 2.30 Hardware User's Manual calls the bit "CCIE".
> 
> Hence if I would have written the driver, I would have used
> 
>     #define PCIECCTLR_CCIE     BIT(31)   /* Configuration Send Enable */

Should I change it when I merge it ? That makes sense actually.

Thanks,
Lorenzo

> >  #define  TYPE0                 (0 << 8)
> >  #define  TYPE1                 BIT(8)
> >  #define PCIECDR                        0x000020
> 
> Gr{oetje,eeting}s,
> 
>                         Geert
> 
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
> 
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds
