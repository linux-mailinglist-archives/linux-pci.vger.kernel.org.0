Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61A2351A49B
	for <lists+linux-pci@lfdr.de>; Wed,  4 May 2022 17:54:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352908AbiEDP6U (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 4 May 2022 11:58:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352867AbiEDP6T (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 4 May 2022 11:58:19 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC98D4614E
        for <linux-pci@vger.kernel.org>; Wed,  4 May 2022 08:54:41 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id x17so3073412lfa.10
        for <linux-pci@vger.kernel.org>; Wed, 04 May 2022 08:54:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3H4PHGcmcD+NCKJdcFxPs3wW4ElbujkBimfkF3e+URM=;
        b=wzPHotuGedh31jRQr6oLxnKSgGm0pUbSOWzlWDVKvf5SurNBXuwBS1zf1XHsku3nYA
         u2RL+UY64tBWP9RD7n9N1ToLKcsH3HC2S/AjXKAELzKh1pndZXrsDVVXs9LFvt0fX0+C
         O/boUc5/+cO+IEzvYrD40t0//sxjKTL5enF/byZR54PbSwujJlNYqAJNHXWMa8EwGoHz
         V9zE5j1uqV8czPzatSQCtM6SWm0RMlMuO9a0a/tU+BirJu9ees19vHh6TxcvNz6d0IXf
         kv0FBc5LLB2eAOabKAHpVPvVRValB5OEGK7Mu25Qe2NbbajlygGpAcI7Y9eLLqlrPYFR
         Ak6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3H4PHGcmcD+NCKJdcFxPs3wW4ElbujkBimfkF3e+URM=;
        b=ft8f1+dQezj/bIz5gwLLkYRRTJ3ozgB1LfjlFsIKTv03kEFaRoCoSNpq7fX0gcBn90
         BOv6ZcZ0c8KNRVXdJlK/sCE5/pbuMoT0ejGNwazivqZp2WBSUabgLeF3DYClOE2pe+Gc
         2XYEg2pBMzoeFU0WdRjOqenc8fXM92XSW2BBPyDY920Db2sFcGmoIlaEdS+jQ9RBy+gs
         qzz6/m/ZDbwbPcO2MeKLRwZuuAe6ZG1xdzTY+dH4qPdDTByN1k5x/ouZK5Tcejwa3NSU
         cUPFFtV245tGSeTE0NiclsYYRfelFUzTpS+Qh68hwPg271NPCaewMyDroK3x+Usugb1f
         YCfA==
X-Gm-Message-State: AOAM533VoxQYY5hUSXhQZgfyqQiMkuRGTo11KsZun2LvGg2wKwccdbrz
        3tc2RNU2a9iBbb+uj3Rh8t2CBWpCrlbAkA==
X-Google-Smtp-Source: ABdhPJy2k2HB3KfJRFEQ2j/sT6Uag0ae/waYLlCpHmCdtKQItZhDaV/s17DneFU28x9fkOEDN2jBoQ==
X-Received: by 2002:a05:6512:234c:b0:473:c3ba:2cf1 with SMTP id p12-20020a056512234c00b00473c3ba2cf1mr1301333lfu.402.1651679680147;
        Wed, 04 May 2022 08:54:40 -0700 (PDT)
Received: from mutt (c-9b28e555.07-21-73746f28.bbcust.telenor.se. [85.229.40.155])
        by smtp.gmail.com with ESMTPSA id b25-20020ac25639000000b0047255d2119dsm1236703lff.204.2022.05.04.08.54.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 May 2022 08:54:39 -0700 (PDT)
Date:   Wed, 4 May 2022 17:54:36 +0200
From:   Anders Roxell <anders.roxell@linaro.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH v3 4/9] PCI/PM: Rework changing power states of PCI
 devices
Message-ID: <20220504155435.GB2697452@mutt>
References: <4419002.LvFx2qVVIh@kreacher>
 <11975904.O9o76ZdvQC@kreacher>
 <5838942.lOV4Wx5bFT@kreacher>
 <3687697.kQq0lBPeGt@kreacher>
 <YnFtjzGYwe28tVAA@dev-arch.thelio-3990X>
 <CAJZ5v0i1Ynt54yb7aMJorkYUvqkxhxOqvQJb8AdA7Ps1aBO5tg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJZ5v0i1Ynt54yb7aMJorkYUvqkxhxOqvQJb8AdA7Ps1aBO5tg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2022-05-04 14:59, Rafael J. Wysocki wrote:
> On Tue, May 3, 2022 at 7:59 PM Nathan Chancellor <nathan@kernel.org> wrote:
> >
> > Hi Rafael,
> >
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
> > boot. As far as I can tell, this might be NVMe related, which might make
> > getting a full log difficult, as journalctl won't have anywhere to save
> > it. I see:
> >
> > nvme nvme0: I/O 8 QID 0 timeout, completion polled
> >
> > then shortly afterwards:
> >
> > nvme nvme0: I/O 24 QID 0 timeout, completion polled
> > nvme nvme0: missing or invalid SUBNQN field
> >
> > then I am dropped into an emergency shell.
> 
> Thanks for the report!
> 
> > This is a log from the previous commit, which may give some hints about
> > the configuration of this particular system.
> >
> > https://gist.github.com/nathanchance/8a56f0939410cb187896e904c72e41e7/raw/b47b2620bdd32d43c7a3b209fcfd9e3d4668f058/good-boot.log
> >
> > If there is any additional debugging information I can provide or
> > patches I can try, please let me know!
> 
> Please see what happens if the "if (dev->current_state == PCI_D0)"
> check and the following "return 0" statement in pci_power_up() are
> commented out.

I've built an arm64 allmodconfig kernel on linux-next tag next-20220503, and tried to boot it.
This is the boot error I see [1].
I bisected down to this patch [2]

When I revert the following patches [3] the kernel boots fine.
I also tried next-20220504 and I saw the same issue.

Cheers,
Anders
[1] http://ix.io/3WT3
[2] http://ix.io/3WXT
[3] http://ix.io/3WXU
