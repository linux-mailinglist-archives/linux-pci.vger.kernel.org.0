Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5CFF688464
	for <lists+linux-pci@lfdr.de>; Thu,  2 Feb 2023 17:27:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231245AbjBBQ1Y (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 2 Feb 2023 11:27:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230048AbjBBQ1Y (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 2 Feb 2023 11:27:24 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 449BF7EC9;
        Thu,  2 Feb 2023 08:27:23 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C759261BFD;
        Thu,  2 Feb 2023 16:27:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3235DC433EF;
        Thu,  2 Feb 2023 16:27:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675355242;
        bh=KAID/43LV8fnWPbpvfRxUeuPiOSiX7Lxy8rNPtJIo2I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZnIvcsckYTW4sIz6Q6+EgYVa9goHm//DMFQiTHzw13FkmjOv0OwQjl0kCyFdeQL3I
         NB0JG67O5JhQ7Rumm14F/+dDR8eyKuXyHm+L5Fb2ZnOTmUoNgqVOr2YaHHLatVlFXn
         2FGWscU+HsFtrJtPKrvWHSukLSgu7v4GQPhtS35DM3wJEc2cKyeb513P8alnlZxvHE
         Rb/aQ7r31izX1LiTw5XIpqTSWZMHZJK12ct9bOdsIObkjhgdbI3BJ3eL4wIqTRhDe6
         nHbdsBv0aLtFKBap1U7fL4y3/y61dQ8o/57Vdm7dmzcVcDojlrks9gHZ7Fo9boaCD9
         Vi5iV3tV19x/w==
Date:   Thu, 2 Feb 2023 17:27:17 +0100
From:   Lorenzo Pieralisi <lpieralisi@kernel.org>
To:     Sergio Paracuellos <sergio.paracuellos@gmail.com>
Cc:     linux-pci@vger.kernel.org, bhelgaas@google.com, robh@kernel.org,
        kw@linux.com, matthias.bgg@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] PCI: mt7621: Sleep a bit after power on the PCIs phy
 ports
Message-ID: <Y9vkZb963iK1yPVL@lpieralisi>
References: <20221231074041.264738-1-sergio.paracuellos@gmail.com>
 <CAMhs-H8sSvn5bfHde-RT0ejqpCujCWvgRFJLtbLXqPcnvGdgtQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMhs-H8sSvn5bfHde-RT0ejqpCujCWvgRFJLtbLXqPcnvGdgtQ@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jan 23, 2023 at 09:55:20AM +0100, Sergio Paracuellos wrote:
> Hi!
> 
> On Sat, Dec 31, 2022 at 8:40 AM Sergio Paracuellos
> <sergio.paracuellos@gmail.com> wrote:
> >
> > Some devices like ZBT WE1326 and ZBT WF3526-P and some Netgear models need
> > to sleep a bit after call to mt7621_pcie_init_port() driver function to get
> > into reliable boots for both warm and hard resets. The needed time for these
> > devices to always detect the ports seems to be from 75 to 100 milliseconds.
> > There is no datasheet or something similar to really understand why this
> > extra time is needed in these devices but not in most of the boards which
> > use mt7621 SoC. This issue has been reported by openWRT community and the
> > complete discussion is in [0]. The selected time of 100 milliseconds has
> > been also tested in these devices ending up in an always working platform.
> > Hence, properly add the extra 100 milliseconds msleep() function call to make
> > also these devices work.
> >
> > [0]: https://github.com/openwrt/openwrt/pull/11220
> >
> > Signed-off-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
> > ---
> > Hi Bjorn / Lorenzo,
> >
> > As per Lorenzo comments in v1[0] here it is the patch with changes in commit
> > message and introducing a new definition for this needed extra delay time.
> > I wish you the best new year for you both.
> >
> > Changes in v2:
> > - Add a new define 'INIT_PORTS_DELAY_MS' avoiding to reuse 'PERST_DELAY_MS'.
> > - Rewrite commit message and add a link to openWRT discussion.
> >
> > Previous patch lore link:
> > [0]: https://lore.kernel.org/lkml/20221209071703.2891714-1-sergio.paracuellos@gmail.com/T/
> >
> > Thanks,
> >     Sergio Paracuellos
> >
> >  drivers/pci/controller/pcie-mt7621.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/drivers/pci/controller/pcie-mt7621.c b/drivers/pci/controller/pcie-mt7621.c
> > index ee7aad09d627..63a5f4463a9f 100644
> > --- a/drivers/pci/controller/pcie-mt7621.c
> > +++ b/drivers/pci/controller/pcie-mt7621.c
> > @@ -60,6 +60,7 @@
> >  #define PCIE_PORT_LINKUP               BIT(0)
> >  #define PCIE_PORT_CNT                  3
> >
> > +#define INIT_PORTS_DELAY_MS            100
> >  #define PERST_DELAY_MS                 100
> >
> >  /**
> > @@ -369,6 +370,7 @@ static int mt7621_pcie_init_ports(struct mt7621_pcie *pcie)
> >                 }
> >         }
> >
> > +       msleep(INIT_PORTS_DELAY_MS);
> >         mt7621_pcie_reset_ep_deassert(pcie);
> >
> >         tmp = NULL;
> > --
> > 2.25.1
> >
> 
> Gentle ping on this patch :-).

I was about to merge it - there are a couple of things that I don't
like.

First one is the comment, "Sleep a bit" does not mean anything. I'd
rather say "delay port initialization" or something like that, be
precise please.

More importantly, this is a fix but it is not clear from the commit
log. Please report what's wrong in the commit log.

I will rework the commit log and merge it then (if you want to avoid
another version just post an updated log here and I will merge it).

Thanks,
Lorenzo
