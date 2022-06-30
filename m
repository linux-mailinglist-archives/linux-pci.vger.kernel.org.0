Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A83356258A
	for <lists+linux-pci@lfdr.de>; Thu, 30 Jun 2022 23:49:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237388AbiF3Vs7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 30 Jun 2022 17:48:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234947AbiF3Vs6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 30 Jun 2022 17:48:58 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3E544F194
        for <linux-pci@vger.kernel.org>; Thu, 30 Jun 2022 14:48:56 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id g4so744856ybg.9
        for <linux-pci@vger.kernel.org>; Thu, 30 Jun 2022 14:48:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZN5bjp+CSDFhFhbJsMFmtuRpQ8ns1bw5njEINAKKyLk=;
        b=J7oaHJZT3Fs9hj/qcvtSz8rvN2LErR8B66dk9tOh5cGjlZZdzRCh6uYuX1rq+s9sPE
         5LBznQs1KlXahSAO2fMu9CVd8U/xFTD5COoswvJXqfsd11NuaknT9O0J/BhK1snAxjL9
         wS88v9/n0JiqV1DtiZ6pCBNR8ZGE/dif8sgqPWL7eCP6Gw35aSfJhm1MfyJlpDW85Sxb
         flMxDOQhFUxJM0YOze5thFgCSaHux5ObQ5hBrBIj80dYWrUnWEjaRvD4OaLuB4DvLeyi
         MFtJxYG9O8nFSXWsdlyb4yGNGWwI5KggQgJDndhzsrpcFKmT1agUjK3MwC43+shMF82n
         +LBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZN5bjp+CSDFhFhbJsMFmtuRpQ8ns1bw5njEINAKKyLk=;
        b=WuqyKtHzPwxPUvp2w+eUx3nrFj7LcOyo581sedd1lsIocMwO7fq3CGxFeIgDJV9X4d
         4nkigFgAR/wiPt/8Fdm5hS19wI1QmCUsUZL/IIQxnzb1CFu+1l+yGOQ8CcFA0NLSrUOZ
         llTx0fb0IiyB5dGhv/oYvY9yNp28VD7tqOB/L4GGvOuDiyeULf07VucQySPBUICKfK5i
         ZYKxDB+h3tWzYz/NIbJmy4ccrOkgmfGhUUio+AIE9XTFamQ0o7eFNueH/c7pbLZUZbdX
         WCBF1kOWT+IeBzdAu+w7w0/u4deMbN/FD6sZKxyAvW/Qf72A03D+/3slJVwXXAcDqlCo
         xqrw==
X-Gm-Message-State: AJIora99M79gpY8KpouV6dvt82lnb/JQlVwuRV5PDg9dmPyznTzuxRKN
        QcmJvK0PTd43bEvQXUXoYhkGdog4CcWJD6Qgt53VOw==
X-Google-Smtp-Source: AGRyM1t9VUuKPcYUfrI0T0KrCLOpyLtHS296XpXo8w+wslfbw9jclNlMK6VKWdORdjtq5OpxBXf5KlirrhUXTZFHkC4=
X-Received: by 2002:a25:9947:0:b0:663:ec43:61eb with SMTP id
 n7-20020a259947000000b00663ec4361ebmr11686355ybo.115.1656625736052; Thu, 30
 Jun 2022 14:48:56 -0700 (PDT)
MIME-Version: 1.0
References: <62bdec26.1c69fb81.46bc5.2d67@mx.google.com> <Yr3vEDDulZj1Dplv@sirena.org.uk>
In-Reply-To: <Yr3vEDDulZj1Dplv@sirena.org.uk>
From:   Saravana Kannan <saravanak@google.com>
Date:   Thu, 30 Jun 2022 14:48:19 -0700
Message-ID: <CAGETcx88M3Use8crFMTU=By3UVjjaJuP1_Ah7zsy_w=pNxc+6w@mail.gmail.com>
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

On Thu, Jun 30, 2022 at 11:44 AM Mark Brown <broonie@kernel.org> wrote:
>
> On Thu, Jun 30, 2022 at 11:32:06AM -0700, KernelCI bot wrote:
>
> The KernelCI bisection bot identified a failure to probe the PCI bus on
> kontron-pitx-imx8m in -next resulting from commit (5a46079a96451 PM:
> domains: Delete usage of driver_deferred_probe_check_state()) with at
> least an arm64 defconfig+64K_PAGES.
>
> The only logging I see from PCI in the failing boot is:
>
>    <6>[    0.580973] PCI: CLS 0 bytes, default 64
>
> there's none of the host bridge enumeration starting with
>
>   <6>[    2.394399] imx6q-pcie 33800000.pcie: host bridge /soc@0/pcie@33800000 ranges:
>   <6>[    2.396012] imx6q-pcie 33c00000.pcie: host bridge /soc@0/pcie@33c00000 ranges:
>
> that is seen with working boots.
>
> I've left the full bot report below, it's got a Reported-by tag, links
> to more details including full boot logs and more.  The bot checked that
> reverting the patch seems to fix the problem.

Thanks for the report. I'll look into this alongside the issue Tony reported.

-Saravana

> > * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
> > * This automated bisection report was sent to you on the basis  *
> > * that you may be involved with the breaking commit it has      *
> > * found.  No manual investigation has been done to verify it,   *
> > * and the root cause of the problem may be somewhere else.      *
> > *                                                               *
> > * If you do send a fix, please include this trailer:            *
> > *   Reported-by: "kernelci.org bot" <bot@kernelci.org>          *
> > *                                                               *
> > * Hope this helps!                                              *
> > * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
> >
> > next/master bisection: baseline.bootrr.imx6q-pcie-pcie0-probed on kontron-pitx-imx8m
> >
> > Summary:
> >   Start:      6cc11d2a17592 Add linux-next specific files for 20220630
> >   Plain log:  https://storage.kernelci.org/next/master/next-20220630/arm64/defconfig+CONFIG_ARM64_64K_PAGES=y/gcc-10/lab-kontron/baseline-kontron-pitx-imx8m.txt
> >   HTML log:   https://storage.kernelci.org/next/master/next-20220630/arm64/defconfig+CONFIG_ARM64_64K_PAGES=y/gcc-10/lab-kontron/baseline-kontron-pitx-imx8m.html
> >   Result:     5a46079a96451 PM: domains: Delete usage of driver_deferred_probe_check_state()
> >
> > Checks:
> >   revert:     PASS
> >   verify:     PASS
> >
> > Parameters:
> >   Tree:       next
> >   URL:        https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
> >   Branch:     master
> >   Target:     kontron-pitx-imx8m
> >   CPU arch:   arm64
> >   Lab:        lab-kontron
> >   Compiler:   gcc-10
> >   Config:     defconfig+CONFIG_ARM64_64K_PAGES=y
> >   Test case:  baseline.bootrr.imx6q-pcie-pcie0-probed
> >
> > Breaking commit found:
> >
> > -------------------------------------------------------------------------------
> > commit 5a46079a96451cfb15e4f5f01f73f7ba24ef851a
> > Author: Saravana Kannan <saravanak@google.com>
> > Date:   Wed Jun 1 00:06:57 2022 -0700
> >
> >     PM: domains: Delete usage of driver_deferred_probe_check_state()
> >
> >     Now that fw_devlink=on by default and fw_devlink supports
> >     "power-domains" property, the execution will never get to the point
> >     where driver_deferred_probe_check_state() is called before the supplier
> >     has probed successfully or before deferred probe timeout has expired.
> >
> >     So, delete the call and replace it with -ENODEV.
> >
> >     Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>
> >     Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
> >     Signed-off-by: Saravana Kannan <saravanak@google.com>
> >     Link: https://lore.kernel.org/r/20220601070707.3946847-2-saravanak@google.com
> >     Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> >
> > diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> > index 739e52cd4aba5..3e86772d5fac5 100644
> > --- a/drivers/base/power/domain.c
> > +++ b/drivers/base/power/domain.c
> > @@ -2730,7 +2730,7 @@ static int __genpd_dev_pm_attach(struct device *dev, struct device *base_dev,
> >               mutex_unlock(&gpd_list_lock);
> >               dev_dbg(dev, "%s() failed to find PM domain: %ld\n",
> >                       __func__, PTR_ERR(pd));
> > -             return driver_deferred_probe_check_state(base_dev);
> > +             return -ENODEV;
> >       }
> >
> >       dev_dbg(dev, "adding to PM domain %s\n", pd->name);
> > -------------------------------------------------------------------------------
> >
> >
> > Git bisection log:
> >
> > -------------------------------------------------------------------------------
> > git bisect start
> > # good: [d9b2ba67917c18822c6a09af41c32fa161f1606b] Merge tag 'platform-drivers-x86-v5.19-3' of git://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86
> > git bisect good d9b2ba67917c18822c6a09af41c32fa161f1606b
> > # bad: [6cc11d2a1759275b856e464265823d94aabd5eaf] Add linux-next specific files for 20220630
> > git bisect bad 6cc11d2a1759275b856e464265823d94aabd5eaf
> > # good: [7391068f14aafb8c5bb9d5aeb07ecfa55c89be42] Merge branch 'drm-next' of https://gitlab.freedesktop.org/agd5f/linux
> > git bisect good 7391068f14aafb8c5bb9d5aeb07ecfa55c89be42
> > # good: [17daf6a2ab5178cf52a20d1c85470ea4638d4310] Merge branch 'next' of git://git.kernel.org/pub/scm/virt/kvm/kvm.git
> > git bisect good 17daf6a2ab5178cf52a20d1c85470ea4638d4310
> > # bad: [a143ea0f3ce59385089e6e7b71b04fd0b5621bd8] Merge branch 'for-next' of git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git
> > git bisect bad a143ea0f3ce59385089e6e7b71b04fd0b5621bd8
> > # bad: [57b6609eb7251280cf9f34fdebf1244f10673749] Merge branch 'icc-next' of git://git.kernel.org/pub/scm/linux/kernel/git/djakov/icc.git
> > git bisect bad 57b6609eb7251280cf9f34fdebf1244f10673749
> > # bad: [eb3fd63a935b759df99bfe4a6b13c820204f81d3] Merge branch 'usb-next' of git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git
> > git bisect bad eb3fd63a935b759df99bfe4a6b13c820204f81d3
> > # good: [048914d1bed271f04f726b7f78d0bef8cd1809f5] Merge branch 'for-next' of git://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-hsi.git
> > git bisect good 048914d1bed271f04f726b7f78d0bef8cd1809f5
> > # good: [40a959d7042bb7711e404ad2318b30e9f92c6b9b] usb: host: ohci-ppc-of: Fix refcount leak bug
> > git bisect good 40a959d7042bb7711e404ad2318b30e9f92c6b9b
> > # good: [849f35422319a46c2a52289e2d5c85eb3346a921] Merge tag 'thunderbolt-for-v5.20-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/westeri/thunderbolt into usb-next
> > git bisect good 849f35422319a46c2a52289e2d5c85eb3346a921
> > # bad: [a52ed4866d2b90dd5e4ae9dabd453f3ed8fa3cbc] mwifiex: fix sleep in atomic context bugs caused by dev_coredumpv
> > git bisect bad a52ed4866d2b90dd5e4ae9dabd453f3ed8fa3cbc
> > # bad: [f516d01b9df2782b9399c44fa1d21c3d09211f8a] Revert "driver core: Set default deferred_probe_timeout back to 0."
> > git bisect bad f516d01b9df2782b9399c44fa1d21c3d09211f8a
> > # bad: [f8217275b57aa48d98cc42051c2aac34152718d6] net: mdio: Delete usage of driver_deferred_probe_check_state()
> > git bisect bad f8217275b57aa48d98cc42051c2aac34152718d6
> > # bad: [24a026f85241a01bbcfe1b263caeeaa9a79bab40] pinctrl: devicetree: Delete usage of driver_deferred_probe_check_state()
> > git bisect bad 24a026f85241a01bbcfe1b263caeeaa9a79bab40
> > # bad: [5a46079a96451cfb15e4f5f01f73f7ba24ef851a] PM: domains: Delete usage of driver_deferred_probe_check_state()
> > git bisect bad 5a46079a96451cfb15e4f5f01f73f7ba24ef851a
> > # first bad commit: [5a46079a96451cfb15e4f5f01f73f7ba24ef851a] PM: domains: Delete usage of driver_deferred_probe_check_state()
> > -------------------------------------------------------------------------------
> >
> >
> > -=-=-=-=-=-=-=-=-=-=-=-
> > Groups.io Links: You receive all messages sent to this group.
> > View/Reply Online (#28727): https://groups.io/g/kernelci-results/message/28727
> > Mute This Topic: https://groups.io/mt/92093224/1131744
> > Group Owner: kernelci-results+owner@groups.io
> > Unsubscribe: https://groups.io/g/kernelci-results/unsub [broonie@kernel.org]
> > -=-=-=-=-=-=-=-=-=-=-=-
> >
> >
