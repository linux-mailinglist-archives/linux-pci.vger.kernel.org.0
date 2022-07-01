Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7585A5627F3
	for <lists+linux-pci@lfdr.de>; Fri,  1 Jul 2022 03:03:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231906AbiGABCq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 30 Jun 2022 21:02:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229647AbiGABCp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 30 Jun 2022 21:02:45 -0400
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 148E5599DC
        for <linux-pci@vger.kernel.org>; Thu, 30 Jun 2022 18:02:41 -0700 (PDT)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-2ef5380669cso9476397b3.9
        for <linux-pci@vger.kernel.org>; Thu, 30 Jun 2022 18:02:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5e2VOFezjxqspoL1d+0n+t2eO3x2RETtacSMN5zGdAs=;
        b=DsTv+bcUYNl2fnBIUQ6Ro+r6VNjE0cbQFXA4vyDI5HQqsh4HPnaE2QRJLCe7v9S8BY
         /sPM6wwB4Thmd9ctc71kf5zNualdBzDI6pzuSH459ZT6uGsbbeVr1zkhsrR+9SCGrkga
         eFzxQdtX2LTtB0U0e+oAHULZ6H3/8wxj482TXtyUaG0bxrzPX3x3nOVIL6kCog6d5gcg
         LmMqOOaAwAH0GSveeP9usrtvR9mS1vCO9kL3m2e9ANdbcSFg50/oCi3Dy/o2rg1RtfgE
         N/MvAq/ur9OAzHma+pmZ1GlbMoV3k8KvhiBi/O3LEVCA5tZnGyDDaTwqWz6XghYiU8PM
         XgFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5e2VOFezjxqspoL1d+0n+t2eO3x2RETtacSMN5zGdAs=;
        b=O1hlnW/mDacefRrqI7okDSMx1QjrzMnhVkocFxnNIuV5siywI9zmR/P/foYjIuYRcp
         c+WH0kOmIroANDY0jvjZCjNWFnD97/I8KhogEVyMLdNDI7NH6vAQ5gfWyLRFqMu/pNjG
         ma3P39cw1FI4b+H71Eob5XMmJ/VTKI9cEjJN9y57Vf/8Oa553YVApCZb2XiVJbYELeEi
         jq2xmNjRusnStNHbxjdg2w/qY6W466bedu7nkuk+eCPyJiuw8DkxzaJYCDa9QzJ9lTMc
         MuaIa1jgtEz2prmIuqLCpiLYGXwMnZuwOL1LEOaCwzdenzYb+oios11fgdhHCEBCqAlb
         0N+Q==
X-Gm-Message-State: AJIora/kfos/yOwmTe88/WeC2+4STuxSFqJFQ2r564MODeWIyJNOV54t
        C/9rqr5jlJVUCw1QaRJ2d45OV9HcCZybxwuVMYNi1A==
X-Google-Smtp-Source: AGRyM1ubQ0A0CmfYu3uw1vNRx0QpThx7NPDmiZeEC/WVv0cqnsx6dmYl28Rt8jXrA27ZBF8EDUPrq9vbignfaImDp8s=
X-Received: by 2002:a0d:eace:0:b0:317:87ac:b3a8 with SMTP id
 t197-20020a0deace000000b0031787acb3a8mr14172406ywe.126.1656637360041; Thu, 30
 Jun 2022 18:02:40 -0700 (PDT)
MIME-Version: 1.0
References: <62bdec26.1c69fb81.46bc5.2d67@mx.google.com> <Yr3vEDDulZj1Dplv@sirena.org.uk>
 <CAGETcx88M3Use8crFMTU=By3UVjjaJuP1_Ah7zsy_w=pNxc+6w@mail.gmail.com>
In-Reply-To: <CAGETcx88M3Use8crFMTU=By3UVjjaJuP1_Ah7zsy_w=pNxc+6w@mail.gmail.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Thu, 30 Jun 2022 18:02:04 -0700
Message-ID: <CAGETcx_s+ui9wWA7OawojPbY95bLZE5pSmpK-34_kLZTzjf9Ew@mail.gmail.com>
Subject: Re: next/master bisection: baseline.bootrr.imx6q-pcie-pcie0-probed on kontron-pitx-imx8m
To:     Mark Brown <broonie@kernel.org>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        kernelci-results@groups.io, bot@kernelci.org,
        gtucker@collabora.com, Michael Walle <michael@walle.cc>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jun 30, 2022 at 2:48 PM Saravana Kannan <saravanak@google.com> wrote:
>
> On Thu, Jun 30, 2022 at 11:44 AM Mark Brown <broonie@kernel.org> wrote:
> >
> > On Thu, Jun 30, 2022 at 11:32:06AM -0700, KernelCI bot wrote:
> >
> > The KernelCI bisection bot identified a failure to probe the PCI bus on
> > kontron-pitx-imx8m in -next resulting from commit (5a46079a96451 PM:
> > domains: Delete usage of driver_deferred_probe_check_state()) with at
> > least an arm64 defconfig+64K_PAGES.
> >
> > The only logging I see from PCI in the failing boot is:
> >
> >    <6>[    0.580973] PCI: CLS 0 bytes, default 64
> >
> > there's none of the host bridge enumeration starting with
> >
> >   <6>[    2.394399] imx6q-pcie 33800000.pcie: host bridge /soc@0/pcie@33800000 ranges:
> >   <6>[    2.396012] imx6q-pcie 33c00000.pcie: host bridge /soc@0/pcie@33c00000 ranges:
> >
> > that is seen with working boots.
> >
> > I've left the full bot report below, it's got a Reported-by tag, links
> > to more details including full boot logs and more.  The bot checked that
> > reverting the patch seems to fix the problem.
>
> Thanks for the report. I'll look into this alongside the issue Tony reported.

Hi Mark,

I think the root cause is the same as the issue I debugged here:
https://lore.kernel.org/lkml/CAGETcx_1qa=gGT4LVkyPpcA1vFM9FzuJE+0DhL_nFyg5cbFjVg@mail.gmail.com/

The patch attached to that email will probably fix this issue. I
haven't dealt with Kernel CI bot before. Is there a way to get it to
test a patch?

Thanks,
Saravana

>
> > > * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
> > > * This automated bisection report was sent to you on the basis  *
> > > * that you may be involved with the breaking commit it has      *
> > > * found.  No manual investigation has been done to verify it,   *
> > > * and the root cause of the problem may be somewhere else.      *
> > > *                                                               *
> > > * If you do send a fix, please include this trailer:            *
> > > *   Reported-by: "kernelci.org bot" <bot@kernelci.org>          *
> > > *                                                               *
> > > * Hope this helps!                                              *
> > > * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
> > >
> > > next/master bisection: baseline.bootrr.imx6q-pcie-pcie0-probed on kontron-pitx-imx8m
> > >
> > > Summary:
> > >   Start:      6cc11d2a17592 Add linux-next specific files for 20220630
> > >   Plain log:  https://storage.kernelci.org/next/master/next-20220630/arm64/defconfig+CONFIG_ARM64_64K_PAGES=y/gcc-10/lab-kontron/baseline-kontron-pitx-imx8m.txt
> > >   HTML log:   https://storage.kernelci.org/next/master/next-20220630/arm64/defconfig+CONFIG_ARM64_64K_PAGES=y/gcc-10/lab-kontron/baseline-kontron-pitx-imx8m.html
> > >   Result:     5a46079a96451 PM: domains: Delete usage of driver_deferred_probe_check_state()
> > >
> > > Checks:
> > >   revert:     PASS
> > >   verify:     PASS
> > >
> > > Parameters:
> > >   Tree:       next
> > >   URL:        https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
> > >   Branch:     master
> > >   Target:     kontron-pitx-imx8m
> > >   CPU arch:   arm64
> > >   Lab:        lab-kontron
> > >   Compiler:   gcc-10
> > >   Config:     defconfig+CONFIG_ARM64_64K_PAGES=y
> > >   Test case:  baseline.bootrr.imx6q-pcie-pcie0-probed
> > >
> > > Breaking commit found:
> > >
> > > -------------------------------------------------------------------------------
> > > commit 5a46079a96451cfb15e4f5f01f73f7ba24ef851a
> > > Author: Saravana Kannan <saravanak@google.com>
> > > Date:   Wed Jun 1 00:06:57 2022 -0700
> > >
> > >     PM: domains: Delete usage of driver_deferred_probe_check_state()
> > >
> > >     Now that fw_devlink=on by default and fw_devlink supports
> > >     "power-domains" property, the execution will never get to the point
> > >     where driver_deferred_probe_check_state() is called before the supplier
> > >     has probed successfully or before deferred probe timeout has expired.
> > >
> > >     So, delete the call and replace it with -ENODEV.
> > >
> > >     Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > >     Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
> > >     Signed-off-by: Saravana Kannan <saravanak@google.com>
> > >     Link: https://lore.kernel.org/r/20220601070707.3946847-2-saravanak@google.com
> > >     Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > >
> > > diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> > > index 739e52cd4aba5..3e86772d5fac5 100644
> > > --- a/drivers/base/power/domain.c
> > > +++ b/drivers/base/power/domain.c
> > > @@ -2730,7 +2730,7 @@ static int __genpd_dev_pm_attach(struct device *dev, struct device *base_dev,
> > >               mutex_unlock(&gpd_list_lock);
> > >               dev_dbg(dev, "%s() failed to find PM domain: %ld\n",
> > >                       __func__, PTR_ERR(pd));
> > > -             return driver_deferred_probe_check_state(base_dev);
> > > +             return -ENODEV;
> > >       }
> > >
> > >       dev_dbg(dev, "adding to PM domain %s\n", pd->name);
> > > -------------------------------------------------------------------------------
> > >
> > >
> > > Git bisection log:
> > >
> > > -------------------------------------------------------------------------------
> > > git bisect start
> > > # good: [d9b2ba67917c18822c6a09af41c32fa161f1606b] Merge tag 'platform-drivers-x86-v5.19-3' of git://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86
> > > git bisect good d9b2ba67917c18822c6a09af41c32fa161f1606b
> > > # bad: [6cc11d2a1759275b856e464265823d94aabd5eaf] Add linux-next specific files for 20220630
> > > git bisect bad 6cc11d2a1759275b856e464265823d94aabd5eaf
> > > # good: [7391068f14aafb8c5bb9d5aeb07ecfa55c89be42] Merge branch 'drm-next' of https://gitlab.freedesktop.org/agd5f/linux
> > > git bisect good 7391068f14aafb8c5bb9d5aeb07ecfa55c89be42
> > > # good: [17daf6a2ab5178cf52a20d1c85470ea4638d4310] Merge branch 'next' of git://git.kernel.org/pub/scm/virt/kvm/kvm.git
> > > git bisect good 17daf6a2ab5178cf52a20d1c85470ea4638d4310
> > > # bad: [a143ea0f3ce59385089e6e7b71b04fd0b5621bd8] Merge branch 'for-next' of git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git
> > > git bisect bad a143ea0f3ce59385089e6e7b71b04fd0b5621bd8
> > > # bad: [57b6609eb7251280cf9f34fdebf1244f10673749] Merge branch 'icc-next' of git://git.kernel.org/pub/scm/linux/kernel/git/djakov/icc.git
> > > git bisect bad 57b6609eb7251280cf9f34fdebf1244f10673749
> > > # bad: [eb3fd63a935b759df99bfe4a6b13c820204f81d3] Merge branch 'usb-next' of git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git
> > > git bisect bad eb3fd63a935b759df99bfe4a6b13c820204f81d3
> > > # good: [048914d1bed271f04f726b7f78d0bef8cd1809f5] Merge branch 'for-next' of git://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-hsi.git
> > > git bisect good 048914d1bed271f04f726b7f78d0bef8cd1809f5
> > > # good: [40a959d7042bb7711e404ad2318b30e9f92c6b9b] usb: host: ohci-ppc-of: Fix refcount leak bug
> > > git bisect good 40a959d7042bb7711e404ad2318b30e9f92c6b9b
> > > # good: [849f35422319a46c2a52289e2d5c85eb3346a921] Merge tag 'thunderbolt-for-v5.20-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/westeri/thunderbolt into usb-next
> > > git bisect good 849f35422319a46c2a52289e2d5c85eb3346a921
> > > # bad: [a52ed4866d2b90dd5e4ae9dabd453f3ed8fa3cbc] mwifiex: fix sleep in atomic context bugs caused by dev_coredumpv
> > > git bisect bad a52ed4866d2b90dd5e4ae9dabd453f3ed8fa3cbc
> > > # bad: [f516d01b9df2782b9399c44fa1d21c3d09211f8a] Revert "driver core: Set default deferred_probe_timeout back to 0."
> > > git bisect bad f516d01b9df2782b9399c44fa1d21c3d09211f8a
> > > # bad: [f8217275b57aa48d98cc42051c2aac34152718d6] net: mdio: Delete usage of driver_deferred_probe_check_state()
> > > git bisect bad f8217275b57aa48d98cc42051c2aac34152718d6
> > > # bad: [24a026f85241a01bbcfe1b263caeeaa9a79bab40] pinctrl: devicetree: Delete usage of driver_deferred_probe_check_state()
> > > git bisect bad 24a026f85241a01bbcfe1b263caeeaa9a79bab40
> > > # bad: [5a46079a96451cfb15e4f5f01f73f7ba24ef851a] PM: domains: Delete usage of driver_deferred_probe_check_state()
> > > git bisect bad 5a46079a96451cfb15e4f5f01f73f7ba24ef851a
> > > # first bad commit: [5a46079a96451cfb15e4f5f01f73f7ba24ef851a] PM: domains: Delete usage of driver_deferred_probe_check_state()
> > > -------------------------------------------------------------------------------
> > >
> > >
> > > -=-=-=-=-=-=-=-=-=-=-=-
> > > Groups.io Links: You receive all messages sent to this group.
> > > View/Reply Online (#28727): https://groups.io/g/kernelci-results/message/28727
> > > Mute This Topic: https://groups.io/mt/92093224/1131744
> > > Group Owner: kernelci-results+owner@groups.io
> > > Unsubscribe: https://groups.io/g/kernelci-results/unsub [broonie@kernel.org]
> > > -=-=-=-=-=-=-=-=-=-=-=-
> > >
> > >
