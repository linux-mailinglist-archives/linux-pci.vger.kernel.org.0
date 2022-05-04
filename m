Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A04CE51ABFA
	for <lists+linux-pci@lfdr.de>; Wed,  4 May 2022 19:58:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359635AbiEDSCJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 4 May 2022 14:02:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377378AbiEDSAx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 4 May 2022 14:00:53 -0400
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D57F6631A;
        Wed,  4 May 2022 10:15:36 -0700 (PDT)
Received: by mail-yb1-f172.google.com with SMTP id m128so3508242ybm.5;
        Wed, 04 May 2022 10:15:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OFV/p74juyEoPxSYXHrzkAx2l6TnhNSxPpzNHi+zhs4=;
        b=4+b1SFPFX4jUr8n7X41dAVG7CcgfqSCIxnhZGEjv+FtmCuDSmycDybFkrhdgaHGWEU
         4QTrUmd8XHulaAZP1oVgWJh814JGp6K+D7qRLtWMbAvwKVZ96RjnL4n9x1Zgcdw8ZZuy
         ABd/nH8sXqXK0XE8KP+359Hewt9LfoRhl46gWAmwJlfm1qf5W9nvvwTeMgtFxR1OKSgQ
         EYJjerXyqkf6m9i68ubaJltVS2p0Kwl4a0n7FJTiGoI0O5gw4uO4lXvZwLe0DtUeB6yN
         D/KuDUO440NYwp50eVnvg2fjxLPuaLsIKVfeuXRHSH6aEWb5HJi5PIZ4oD62y4Ow4Kve
         WVIw==
X-Gm-Message-State: AOAM530JkiU2tX7wjZDuLau/eoMpoEHmyvO/JjFNtIuCMNoEFZ/17d1a
        MN8yh3dvLnbiHDzAEJ9c1Nn3htugiE46rJWv/C8=
X-Google-Smtp-Source: ABdhPJzjRfM0DpouS6xdyXwR/B26C26P2+1p0G7fDh2ZXfbBTY+AxBBIPZjUd3fdQqUDpXtFohq4/YXNynsvaWYmFMg=
X-Received: by 2002:a05:6902:187:b0:63d:9c95:edca with SMTP id
 t7-20020a056902018700b0063d9c95edcamr17647508ybh.81.1651684535365; Wed, 04
 May 2022 10:15:35 -0700 (PDT)
MIME-Version: 1.0
References: <YnFtjzGYwe28tVAA@dev-arch.thelio-3990X> <20220504165409.GA453565@bhelgaas>
In-Reply-To: <20220504165409.GA453565@bhelgaas>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 4 May 2022 19:15:24 +0200
Message-ID: <CAJZ5v0g7oN534uyNh4YBeArH8xqGxYCXrrqAz2jiH=D4cyx=+w@mail.gmail.com>
Subject: Re: [PATCH v3 4/9] PCI/PM: Rework changing power states of PCI devices
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Anders Roxell <anders.roxell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, May 4, 2022 at 7:03 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> [+cc Anders]
>
> On Tue, May 03, 2022 at 10:59:43AM -0700, Nathan Chancellor wrote:
> > On Thu, Apr 14, 2022 at 03:11:21PM +0200, Rafael J. Wysocki wrote:
> > > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > >
> > > There are some issues related to changing power states of PCI
> > > devices, mostly related to carrying out unnecessary actions in some
> > > places, and the code is generally hard to follow.
> > >
> > >  1. pci_power_up() has two callers, pci_set_power_state() and
> > >     pci_pm_default_resume_early().  The latter updates the current
> > >     power state of the device right after calling pci_power_up()
> > >     and it restores the entire config space of the device right
> > >     after that, so pci_power_up() itself need not read the
> > >     PCI_PM_CTRL register or restore the BARs after programming the
> > >     device into D0 in that case.
> > >
> > >  2. It is generally hard to get a clear view of the pci_power_up()
> > >     code flow, especially in some corner cases, due to all of the
> > >     involved PCI_PM_CTRL register reads and writes occurring in
> > >     pci_platform_power_transition() and in pci_raw_set_power_state(),
> > >     some of which are redundant.
> > >
> > >  3. The transitions from low-power states to D0 and the other way
> > >     around are unnecessarily tangled in pci_raw_set_power_state()
> > >     which causes it to use a redundant local variable and makes it
> > >     rather hard to follow.
> > >
> > > To address the above shortcomings, make the following changes:
> > >
> > >  a. Remove the code handling transitions into D0
> > >     from pci_raw_set_power_state() and rename it as
> > >     pci_set_low_power_state().
> > >
> > >  b. Add the code handling transitions into D0 directly
> > >     to pci_power_up() and to a new wrapper function
> > >     pci_set_full_power_state() calling it internally that is
> > >     only used in pci_set_power_state().
> > >
> > >  c. Make pci_power_up() avoid redundant PCI_PM_CTRL register reads
> > >     and make it work in the same way for transitions from any
> > >     low-power states (transitions from D1 and D2 are handled
> > >     slightly differently before the change).
> > >
> > >  d. Put the restoration of the BARs and the PCI_PM_CTRL
> > >     register read confirming the power state change into
> > >     pci_set_full_power_state() to avoid doing that in
> > >     pci_pm_default_resume_early() unnecessarily.
> > >
> > > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> >
> > This change as commit 5bffe4c611f5 ("PCI/PM: Rework changing power
> > states of PCI devices") causes my AMD-based system to fail to fully
> > boot.
>
> I dropped 5bffe4c611f5 and subsequent pci/pm patches temporarily while
> this gets worked out.

OK

It looks like I missed something subtle that triggers on a subset of
systems only.
