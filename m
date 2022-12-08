Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4D9A6474B9
	for <lists+linux-pci@lfdr.de>; Thu,  8 Dec 2022 17:55:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230230AbiLHQz3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 8 Dec 2022 11:55:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230265AbiLHQz2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 8 Dec 2022 11:55:28 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9922176802;
        Thu,  8 Dec 2022 08:55:27 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4FA8EB82437;
        Thu,  8 Dec 2022 16:55:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDC0EC433D2;
        Thu,  8 Dec 2022 16:55:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670518525;
        bh=yBtV+NuqkDFfk82CWvSm04mo6CBnIuWYTKuRN6NUuaQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=o/rzSXE0uWwq5cISLxM3T9+MQufbYq8D8mHX2TwewdzsHqlyPpVbKv2s7R5qPxL+T
         3JBkpwICDexZ8ecasB+yQhsQbu5LmAXBQCmlwYupgrMMbBzNUp9SK2+mKoyNIG79Zd
         JBzaaMZjV/R5oi0t1dYbiZYA+nY8JOqWNmWaFuTpbgTmhzgoRJ6ROJidZsYBgV40kE
         WIupQV0qjBXVh+bm8+C2Cqmoabsn+g38voN9w5J+45vTOW/7rSFeGO5j98xl75H0Po
         XXpzAh2ghuGRKbukp7Dd6JE9EPy4wuVH9RsNgo4LK+Jy6iJ6iuiC4+uZpGKdmlCW33
         Lm848OAjIoyAw==
Date:   Thu, 8 Dec 2022 10:55:23 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Stephen Kitt <steve@sk2.org>
Cc:     linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci@vger.kernel.org, Jan Rueth <rueth@comsys.rwth-aachen.de>
Subject: Re: [PATCH] PCI/ASPM: Call pcie_aspm_sanity_check() as late as
 possible
Message-ID: <20221208165523.GA1548682@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221208090017.132db7bd@heffalump.sk2.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Dec 08, 2022 at 09:00:17AM +0100, Stephen Kitt wrote:
> Hi Bjorn,
> 
> On Wed, 7 Dec 2022 15:56:08 -0600, Bjorn Helgaas <helgaas@kernel.org> wrote:
> > On Thu, Oct 06, 2022 at 01:59:50PM +0200, Stephen Kitt wrote:
> > > In pcie_aspm_init_link_state(), a number of checks are made to
> > > determine whether the function should proceed, before the result of
> > > the call to pcie_aspm_sanity_check() is actually used. The latter
> > > function doesn't change any state, it only reports a result, so
> > > calling it later doesn't make any difference to the state of the
> > > devices or the information we have about them. But having the call
> > > early reportedly can cause null-pointer dereferences; see
> > > https://unix.stackexchange.com/q/322337 for one example with
> > > pcie_aspm=off (this was reported in 2016, but the relevant code hasn't
> > > changed since then).  
> > 
> > Thanks, Stephen!
> > 
> > That stackexchange report doesn't have much information, but it looks
> > similar to this old report from Jan Rueth, which I'm sorry to say I
> > never got resolved:
> > 
> >   https://bugzilla.kernel.org/show_bug.cgi?id=187731
> >   https://lore.kernel.org/all/4cec62c2-218a-672b-8c12-d44e8df56aae@comsys.rwth-aachen.de/#t
> > 
> > And Jan's patch is almost identical to yours :)
> > 
> > I hope to get this resolved, but I don't have time to work on it
> > before the upcoming merge window, which will probably open Sunday.
> > And then it's holiday time, so it may be January before I get back to
> > it.  I'm just dropping the links here as breadcrumbs for picking this
> > back up.
> 
> Thanks for the update! I was somewhat bemused by the dereference here, I’m
> reassured to see I’m not the only one. Unfortunately I don’t have hardware
> which exhibits this problem,

Yeah, that's a weird thing about this.  This shouldn't be a
platform-specific thing, but both stackexchange and Jan's patch
mention IBM x3850.  

Maybe both came from a single source, or maybe there's something
deeper going on.

> I submitted the patch because it seemed
> reasonably sensible even though as you say there is probably something else
> going on here. Of course if this approach is useful, Jan’s patch should go in
> rather than mine.
> 
> Anyway, it’s been six years, so a few more weeks won’t make any difference
> ;-).
> 
> Enjoy the holiday season!
> 
> Regards,
> 
> Stephen


