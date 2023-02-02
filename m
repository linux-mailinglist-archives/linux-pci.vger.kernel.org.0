Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 933196882E0
	for <lists+linux-pci@lfdr.de>; Thu,  2 Feb 2023 16:42:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230094AbjBBPmW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 2 Feb 2023 10:42:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231707AbjBBPmW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 2 Feb 2023 10:42:22 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3721027D46;
        Thu,  2 Feb 2023 07:41:59 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 56B6E61B8C;
        Thu,  2 Feb 2023 15:41:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FFF7C433D2;
        Thu,  2 Feb 2023 15:40:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675352460;
        bh=SnokYtP0nj6+SdMUZyE/P5z1gQHBzL3/1Otl7bzbNK0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qeFYPex0TzA+VS5gBR3VY20pInVwSOxzIE9DS2E/rVorWjdplJ7T6z4Jt7mTCUIEb
         nD8qA26Zqm7KB9hK0gNg2i2WvyDVSnkPDzwrlp5DrsPf375ACqitNM/AtlZJK6zEuy
         6k29M0fgNmDAK3DlYrpiYat5Qi3YbNb/yBo0ePq/+QciRgfIWjr9JMiYFYFpbDCIK3
         XAIvyjPMErvq8IPmbZV5ikztXtZatwsjnGubkenVLMsgr+8Wpr2G2p8RbZpmbRJHZG
         ziPS3ZEQebz72j0/bvhKDjkYiMat5pTuNd9PXdJhfOwZ1SbGcOQgN8aSjYW415iJZ8
         uTazh+EWqSZSA==
Date:   Thu, 2 Feb 2023 16:40:54 +0100
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
Message-ID: <Y9vZhv2+F4e/Asko@lpieralisi>
References: <20230113084516.31888-1-lukas.bulwahn@gmail.com>
 <CAMuHMdX_TPgXO2KYNdD5rRzuE9m6_JxfW-otWzw7r7Wptq_rOQ@mail.gmail.com>
 <Y8GHICwCNRsYCva8@lpieralisi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y8GHICwCNRsYCva8@lpieralisi>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jan 13, 2023 at 05:30:24PM +0100, Lorenzo Pieralisi wrote:
> On Fri, Jan 13, 2023 at 10:05:09AM +0100, Geert Uytterhoeven wrote:
> > Hi Lukas,
> > 
> > On Fri, Jan 13, 2023 at 9:52 AM Lukas Bulwahn <lukas.bulwahn@gmail.com> wrote:
> > > Defines prefixed with "CONFIG" should be limited to proper Kconfig options,
> > > that are introduced in a Kconfig file.
> > >
> > > Here, a definition for a bitmask to configure the SEND_ENABLE mode is named
> > > CONFIG_SEND_ENABLE.
> > >
> > > Rename this local definition to CONFIGURE_SEND_ENABLE to avoid defines
> > > prefixed with "CONFIG".
> > >
> > > No functional change.
> > >
> > > Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> > 
> > Thanks for your patch!
> > 
> > > --- a/drivers/pci/controller/pcie-rcar.h
> > > +++ b/drivers/pci/controller/pcie-rcar.h
> > > @@ -11,7 +11,7 @@
> > >
> > >  #define PCIECAR                        0x000010
> > >  #define PCIECCTLR              0x000018
> > > -#define  CONFIG_SEND_ENABLE    BIT(31)
> > > +#define  CONFIGURE_SEND_ENABLE BIT(31)
> > 
> > The R-Car Gen3 rev. 2.30 Hardware User's Manual calls the bit "CCIE".
> > 
> > Hence if I would have written the driver, I would have used
> > 
> >     #define PCIECCTLR_CCIE     BIT(31)   /* Configuration Send Enable */
> 
> Should I change it when I merge it ? That makes sense actually.

If I don't hear from anybody I will make the change above and merge it.

Thanks,
Lorenzo

> 
> Thanks,
> Lorenzo
> 
> > >  #define  TYPE0                 (0 << 8)
> > >  #define  TYPE1                 BIT(8)
> > >  #define PCIECDR                        0x000020
> > 
> > Gr{oetje,eeting}s,
> > 
> >                         Geert
> > 
> > --
> > Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
> > 
> > In personal conversations with technical people, I call myself a hacker. But
> > when I'm talking to journalists I just say "programmer" or something like that.
> >                                 -- Linus Torvalds
