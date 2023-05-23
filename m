Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B81270E7FC
	for <lists+linux-pci@lfdr.de>; Tue, 23 May 2023 23:50:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238727AbjEWVue (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 23 May 2023 17:50:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238624AbjEWVub (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 23 May 2023 17:50:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47B3410C7
        for <linux-pci@vger.kernel.org>; Tue, 23 May 2023 14:49:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 549F8611F0
        for <linux-pci@vger.kernel.org>; Tue, 23 May 2023 21:49:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DEC0C4339B;
        Tue, 23 May 2023 21:49:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684878544;
        bh=TnJ6jiYtBK7mcF14WGtDQDIOiNdcMlMjELE+BXkZbY4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=TB69PdLWUvfv6+L6MkDlF6NTd9hDwdwBHWlnxO8TMkvTJu4u7ZZKr/yzpOAWU7Cff
         2WEuWCU+iz6iH37ZasvPHnfyDnq8ejY6j1pl30jc7dGM9sHztqircMlesojoTShtMC
         smx/yMir4gOEJdukrQ7vOToXND6XPnCy/bjWMtTEzrqh2x20o+qDCI8ggdrz6ReNuY
         uoV4cBzwne4iKzipfKFLKw7WXcUF6ztevyZtx9kjxJ6wdiplrKE9iUXrQev81Fn2p6
         atoCjxgF2Gbx/QLxGahbXFtZkqTzBhmwSEMWuSQaRCHHsjbrk0UxLWit0Kl5uBTQ0i
         VIxmeFWmoPl0A==
Date:   Tue, 23 May 2023 16:49:02 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Linux regressions mailing list <regressions@lists.linux.dev>
Cc:     Koba Ko <koba.ko@canonical.com>, linux-pci@vger.kernel.org,
        Vidya Sagar <vidyas@nvidia.com>,
        Ajay Agarwal <ajayagarwal@google.com>,
        Tasev Nikola <tasev.stefanoska@skynet.be>,
        Mark Enriquez <enriquezmark36@gmail.com>,
        Thomas Witt <kernel@witt.link>
Subject: Re: [Bug 217321] New: Intel platforms can't sleep deeper than PC3
 during long idle
Message-ID: <ZG00zhXPMigJIISI@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <844f3819-c819-bc55-0518-0b1b9651825f@leemhuis.info>
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, May 22, 2023 at 01:45:55PM +0200, Linux regression tracking (Thorsten Leemhuis) wrote:
> On 05.05.23 08:56, Koba Ko wrote:
> > On Thu, May 4, 2023 at 5:23 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> >> [+cc Koba, Ajay, Tasev, Mark, Thomas, regressions list]
> >> On Tue, Apr 11, 2023 at 03:42:29PM -0500, Bjorn Helgaas wrote:
> >>> On Tue, Apr 11, 2023 at 08:32:04AM +0000, bugzilla-daemon@kernel.org wrote:
> >>>> https://bugzilla.kernel.org/show_bug.cgi?id=217321
> >>>> ...
> >>>>         Regression: No
> >>>>
> >>>> [Symptom]
> >>>> Intel cpu can't sleep deeper than pcˇ during long idle
> >>>> ~~~
> >>>> Pkg%pc2 Pkg%pc3 Pkg%pc6 Pkg%pc7 Pkg%pc8 Pkg%pc9 Pk%pc10
> >>>> 15.08   75.02   0.00    0.00    0.00    0.00    0.00
> >>>> 15.09   75.02   0.00    0.00    0.00    0.00    0.00
> >>>> ^CPkg%pc2       Pkg%pc3 Pkg%pc6 Pkg%pc7 Pkg%pc8 Pkg%pc9 Pk%pc10
> >>>> 15.38   68.97   0.00    0.00    0.00    0.00    0.00
> >>>> 15.38   68.96   0.00    0.00    0.00    0.00    0.00
> >>>> ~~~
> >>>> [How to Reproduce]
> >>>> 1. run turbostat to monitor
> >>>> 2. leave machine idle
> >>>> 3. turbostat show cpu only go into pc2~pc3.
> >>>>
> >>>> [Misc]
> >>>> The culprit are this
> >>>> a7152be79b62) Revert "PCI/ASPM: Save L1 PM Substates Capability for
> >>>> suspend/resume”
> >>>>
> >>>> if revert a7152be79b62, the issue is gone
> >>>
> >>> Relevant commits:
> >>>
> >>>   4ff116d0d5fd ("PCI/ASPM: Save L1 PM Substates Capability for suspend/resume")
> >>>   a7152be79b62 ("Revert "PCI/ASPM: Save L1 PM Substates Capability for suspend/resume"")
> >>>
> >>> 4ff116d0d5fd appeared in v6.1-rc1.  Prior to 4ff116d0d5fd, ASPM L1 PM
> >>> Substates configuration was not preserved across suspend/resume, so
> >>> the system *worked* after resume, but used more power than expected.
> >>>
> >>> But 4ff116d0d5fd caused resume to fail completely on some systems, so
> >>> a7152be79b62 reverted it.  With a7152be79b62 reverted, ASPM L1 PM
> >>> Substates configuration is likely not preserved across suspend/resume.
> >>> a7152be79b62 appeared in v6.2-rc8 and was backported to the v6.1
> >>> stable series starting with v6.1.12.
> >>>
> >>> KobaKo, you don't mention any suspend/resume in this bug report, but
> >>> neither patch should make any difference unless suspend/resume is
> >>> involved.  Does the platform sleep as expected *before* suspend, but
> >>> fail to sleep after resume?
> >>>
> >>> Or maybe some individual device was suspended via runtime power
> >>> management, and that device lost its L1 PM Substates config?  I don't
> >>> know if there's a way to disable runtime PM easily.
> >>
> >> Koba, per your bugzilla update, the issue happens even without
> >> suspend/resume.  And we don't know whether some particular device is
> >> responsible.
> >>
> >> But if we save/restore L1SS state, we can sleep deeper than PC3.  If
> >> we don't preserve L1SS state, we can't.
> >>
> >> We definitely want to preserve the L1SS state, but we can't simply
> >> apply 4ff116d0d5fd ("PCI/ASPM: Save L1 PM Substates Capability for
> >> suspend/resume") again because it caused its own regressions [1,2,3]
> >>
> >> So somebody needs to figure out what was wrong with 4ff116d0d5fd, fix
> >> it, verify that it doesn't cause the issues reported by Tasev, Thomas,
> >> and Mark, and then we can apply it.
> > 
> > Good days, discussed with Kai-Heng and he mentioned  the GPU may not
> > be pulled off the power.
> > then the GPU needs L1ss to get into power saving.
> > 
> > I will investigate further on this way.
> 
> Did anything come our of this?
> 
> FWIW, I'm considering to drop this from the list of tracked regressions.
> Yes, this is a regression, but it's caused by fix for another (worse)
> regression -- so there is nothing we can do for now anyway (and Koba
> seems motivated already to look properly into all of this). Or does
> anyone consider this to be a problem?

I would drop this from the regression list.

Yes, bz 217321 is a bug, and yes, 4ff116d0d5fd is a partial fix for
it, but 4ff116d0d5fd causes worse problems (it breaks resume from
suspend) than just living with bz 217321, which is a "mere" power
consumption issue.

I updated bz 217321 to drop the "regression" label there.

Bjorn
