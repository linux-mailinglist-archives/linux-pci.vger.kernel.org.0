Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E7276886F7
	for <lists+linux-pci@lfdr.de>; Thu,  2 Feb 2023 19:46:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232922AbjBBSp6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 2 Feb 2023 13:45:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232891AbjBBSpz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 2 Feb 2023 13:45:55 -0500
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com [IPv6:2001:4860:4864:20::2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E121D4DBE6;
        Thu,  2 Feb 2023 10:45:36 -0800 (PST)
Received: by mail-oa1-x2f.google.com with SMTP id 586e51a60fabf-163bd802238so3725593fac.1;
        Thu, 02 Feb 2023 10:45:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=nIrvURN3k7w+IGATVMpqkzuzBARhYpkMMK+JapZDevA=;
        b=QQtQs60rGf47hhw4J2kOYDEwQ0VbhhZfIgnVz7W0//NavO5oxl5Jvmxki0ZDVenrB9
         JzOX59wd4oyYTIaOyOticA7uVba8QOcAn6cwjbQWkCGi/CmhZ2rzBmz1wARxU8ty7FIv
         7sQKaxKiszzEvQtvbACv8kyFR58rpMs8F1JHw2lWX2zj5r8ygedzzckwFXYrjAmAG6eW
         6TNyouprcN9MvQxvSKbAbBKx2myptBgzFWEWCT8NylwSrgqvW+/rHjl9OGfpnAt8MqRO
         Bkh+Rl6UBtIvuqCyuBGCTDVbgvS1HDYqm+z3IEH3D0PHDtXFc0b6pVg4pWUWt+CfZAQM
         5mKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nIrvURN3k7w+IGATVMpqkzuzBARhYpkMMK+JapZDevA=;
        b=f/CHkEHygyzE+0stx0DisUHOgPwXx5TNF92HVcqgn0WqRM6DhXAJBEJqgmBNDMZnkC
         0rkcFN0R64mGbvAth6IWi9kwt9vhVtu+cEMxNir2s7dcP4yqVcf52BL+AVPI7L4+Pgp0
         kmimC/CU0vovSs5MYlRlZdMcV0YDj2V5RRzwdm82cr7CRvcESPlRGF7I5p/3XJKjfsMd
         v7y02cvKysO1z5Fqs+u9ZmI2BrE1UqqLVXY2Bt5l6eY5KqP0t6RSAdHTFdNdlyr1Bbc/
         7815ABkG1fznhm+qZWmrDvzmCE9EdMCRwW4KSl6hrmjuMCOels1hhe8Xj31H/UhFgttF
         mz6Q==
X-Gm-Message-State: AO0yUKU29SaE7NvTc0CNgyB9zjX6tBq5v/fmB9dbwUbDEEl9SakvNpVy
        4711MMYhPbWfNkxHzjRY9JfJXEWuXiwnYs1vQc0Gy0d4W/U=
X-Google-Smtp-Source: AK7set/2KchRLxRHrq3KW4zy+wnIyUeBOAJJCXz8Nhqf5uppJEFSoSYGcwfmWi3Nxk+V0SUy4YXgWV0F8IhwKJ6quOI=
X-Received: by 2002:a05:6870:b488:b0:163:88f9:2c51 with SMTP id
 y8-20020a056870b48800b0016388f92c51mr410916oap.144.1675363527707; Thu, 02 Feb
 2023 10:45:27 -0800 (PST)
MIME-Version: 1.0
References: <20221231074041.264738-1-sergio.paracuellos@gmail.com>
 <CAMhs-H8sSvn5bfHde-RT0ejqpCujCWvgRFJLtbLXqPcnvGdgtQ@mail.gmail.com> <Y9vkZb963iK1yPVL@lpieralisi>
In-Reply-To: <Y9vkZb963iK1yPVL@lpieralisi>
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
Date:   Thu, 2 Feb 2023 19:45:16 +0100
Message-ID: <CAMhs-H91tLmej0+cK3drGCdP++AEux5ub+hG7XLTktF6+JUBmg@mail.gmail.com>
Subject: Re: [PATCH v2] PCI: mt7621: Sleep a bit after power on the PCIs phy ports
To:     Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc:     linux-pci@vger.kernel.org, bhelgaas@google.com, robh@kernel.org,
        kw@linux.com, matthias.bgg@gmail.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Lorenzo,

Thanks for your comments.

On Thu, Feb 2, 2023 at 5:27 PM Lorenzo Pieralisi <lpieralisi@kernel.org> wrote:
>
> On Mon, Jan 23, 2023 at 09:55:20AM +0100, Sergio Paracuellos wrote:
> > Hi!
> >
> > On Sat, Dec 31, 2022 at 8:40 AM Sergio Paracuellos
> > <sergio.paracuellos@gmail.com> wrote:
> > >
> > > Some devices like ZBT WE1326 and ZBT WF3526-P and some Netgear models need
> > > to sleep a bit after call to mt7621_pcie_init_port() driver function to get
> > > into reliable boots for both warm and hard resets. The needed time for these
> > > devices to always detect the ports seems to be from 75 to 100 milliseconds.
> > > There is no datasheet or something similar to really understand why this
> > > extra time is needed in these devices but not in most of the boards which
> > > use mt7621 SoC. This issue has been reported by openWRT community and the
> > > complete discussion is in [0]. The selected time of 100 milliseconds has
> > > been also tested in these devices ending up in an always working platform.
> > > Hence, properly add the extra 100 milliseconds msleep() function call to make
> > > also these devices work.
> > >
> > > [0]: https://github.com/openwrt/openwrt/pull/11220
> > >
> > > Signed-off-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
> > > ---
> > > Hi Bjorn / Lorenzo,
> > >
> > > As per Lorenzo comments in v1[0] here it is the patch with changes in commit
> > > message and introducing a new definition for this needed extra delay time.
> > > I wish you the best new year for you both.
> > >
> > > Changes in v2:
> > > - Add a new define 'INIT_PORTS_DELAY_MS' avoiding to reuse 'PERST_DELAY_MS'.
> > > - Rewrite commit message and add a link to openWRT discussion.
> > >
> > > Previous patch lore link:
> > > [0]: https://lore.kernel.org/lkml/20221209071703.2891714-1-sergio.paracuellos@gmail.com/T/
> > >
> > > Thanks,
> > >     Sergio Paracuellos
> > >
> > >  drivers/pci/controller/pcie-mt7621.c | 2 ++
> > >  1 file changed, 2 insertions(+)
> > >
> > > diff --git a/drivers/pci/controller/pcie-mt7621.c b/drivers/pci/controller/pcie-mt7621.c
> > > index ee7aad09d627..63a5f4463a9f 100644
> > > --- a/drivers/pci/controller/pcie-mt7621.c
> > > +++ b/drivers/pci/controller/pcie-mt7621.c
> > > @@ -60,6 +60,7 @@
> > >  #define PCIE_PORT_LINKUP               BIT(0)
> > >  #define PCIE_PORT_CNT                  3
> > >
> > > +#define INIT_PORTS_DELAY_MS            100
> > >  #define PERST_DELAY_MS                 100
> > >
> > >  /**
> > > @@ -369,6 +370,7 @@ static int mt7621_pcie_init_ports(struct mt7621_pcie *pcie)
> > >                 }
> > >         }
> > >
> > > +       msleep(INIT_PORTS_DELAY_MS);
> > >         mt7621_pcie_reset_ep_deassert(pcie);
> > >
> > >         tmp = NULL;
> > > --
> > > 2.25.1
> > >
> >
> > Gentle ping on this patch :-).
>
> I was about to merge it - there are a couple of things that I don't
> like.
>
> First one is the comment, "Sleep a bit" does not mean anything. I'd
> rather say "delay port initialization" or something like that, be
> precise please.

How about:

PCI: mt7621: delay phy ports initialization

>
> More importantly, this is a fix but it is not clear from the commit
> log. Please report what's wrong in the commit log.

The problem is that PCI ports are not detected properly without this
delay for those devices so plugged
cards on them do not work at all. I don't really know how to write the
commit log clearer but I'll try adding
this cards plugged not working stuff :-)

We can add maybe also if you want:

Fixes: 2bdd5238e756 ("PCI: mt7621: Add MediaTek MT7621 PCIe host
controller driver")

>
> I will rework the commit log and merge it then (if you want to avoid
> another version just post an updated log here and I will merge it).

Some devices like ZBT WE1326 and ZBT WF3526-P and some Netgear models need
to sleep a bit after calling the mt7621_pcie_init_port() driver function to get
into reliable boots for both warm and hard resets. The needed time for these
devices to always detect the ports seems to be from 75 to 100 milliseconds.
Without ports properly detected no card plugged into the PCI's work at all.
There is no datasheet or something similar to really understand why this
extra time is needed in these devices but not in most of the boards which
use mt7621 SoC. This issue has been reported by openWRT community and the
complete discussion is in [0]. The selected time of 100 milliseconds has
been also tested in these devices ending up in an always working platform.
Hence, properly add the extra 100 milliseconds msleep() function call to make
also these devices work.

[0]: https://github.com/openwrt/openwrt/pull/11220

>
> Thanks,
> Lorenzo

Thanks,
    Sergio Paracuellos
