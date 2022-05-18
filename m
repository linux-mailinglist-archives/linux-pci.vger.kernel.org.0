Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E64F352C3C4
	for <lists+linux-pci@lfdr.de>; Wed, 18 May 2022 21:50:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242140AbiERTrf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 18 May 2022 15:47:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242129AbiERTrf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 18 May 2022 15:47:35 -0400
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D867A1DE55E
        for <linux-pci@vger.kernel.org>; Wed, 18 May 2022 12:47:32 -0700 (PDT)
Received: by mail-ot1-x32c.google.com with SMTP id y20-20020a056830071400b00606a2ebd91bso2089239ots.5
        for <linux-pci@vger.kernel.org>; Wed, 18 May 2022 12:47:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=RB4HktPhq8nwUR2IK5UQ96thkQy1bGRMkPqt88ASV1Q=;
        b=XCToMuN5wN4cVkXB2m8C9vyQcrKLT5F48aWv1SX4mgvA4Y5SPpIGNBt+DqSGspJYzn
         mu7evea2yjSsWxIE6EX6NSu/da9++tN4WSn6UZ17QpkiHjbYHsMsDgtTMhCdwGQ93a4U
         126bPXs4u9VIoVONrlKurid1H4rV5kKA0mQL/Itl0oEXltDEq3Drt6Oh/KedBRMWIJFd
         Oc7b5VLw/SNGWnbIz84ZDvzpelib2I8kpEJbK9xdUrbrFYToy7bqCtVOcThOUGPlLPO9
         gsKmPKrLpD1fzvJUmv9hwouScKd2NEC9qsYwnfvyLM4nYj/61ncdq8i0Ttnxh7EHaPQF
         NjyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=RB4HktPhq8nwUR2IK5UQ96thkQy1bGRMkPqt88ASV1Q=;
        b=iGx5eTDQ6xmYb01ISgIKfmWE9LiryaR7QBWEcUqRI2ebDDYixHulXjl5iq4u3r19+9
         VU7aw6zv+WQyVAUS5uKwDE6wgeATsALN1jgMx95hmd4n5b862+sS3Ps5UAUmH6t/uzOY
         YfWvuENRqzsoOdsZiO6rhzQIOeaAsfc7xybxdgUGtKCk/NRuEzzxtIAJIGWmwU87V/RR
         DwvesTRtF/iGrAywylklL9o6G4OjkGDhNCik3+u+mUr2jEUqiTM92I9MReAZz2z97WNl
         RDxfM46XuIpJdZVr9oxDwxzJmyISoFG6iICwjbIvHBa914JfQ6nySGAHjG/I2Qin5rGh
         DJwQ==
X-Gm-Message-State: AOAM531WhtPAdCEYVz6m7Qg7ozxoRrciEkGgMLv0agf1PQ6Fs8qAbKth
        KfG8QE9KoFXFsGLJQAJQJGSLTXPsDeSlGPXYfZA=
X-Google-Smtp-Source: ABdhPJwYTyk/ZRYH/A4EF5Ndl+Uv7EKJV0R6JXcKAestWqwBKFBdZjjof433iLHqZZH4Sr47MdbxglxsbWAY3AiJMJc=
X-Received: by 2002:a9d:7f85:0:b0:606:1305:f8ca with SMTP id
 t5-20020a9d7f85000000b006061305f8camr564922otp.96.1652903252125; Wed, 18 May
 2022 12:47:32 -0700 (PDT)
MIME-Version: 1.0
References: <bug-215925-41252@https.bugzilla.kernel.org/> <CABhMZUWjZCwK1_qT2ghTSu2dguJBzBTpiTqKohyA72OSGMsaeg@mail.gmail.com>
 <3aa008b9-e477-3e6d-becb-13e28ea91f10@leemhuis.info> <CANCKTBuOjJk6SRTHs+tXXWaC9cGsxkp9PM2rwpf+hs50S+cBfQ@mail.gmail.com>
In-Reply-To: <CANCKTBuOjJk6SRTHs+tXXWaC9cGsxkp9PM2rwpf+hs50S+cBfQ@mail.gmail.com>
From:   Jim Quinlan <jim2101024@gmail.com>
Date:   Wed, 18 May 2022 15:47:20 -0400
Message-ID: <CANCKTBsvL8AJ-O54+Wque_A2O6XZTPZO5Jw+xUoviXC84+8WWw@mail.gmail.com>
Subject: Re: [Bug 215925] New: PCIe regression on Raspberry Pi Compute Module
 4 (CM4) breaks booting
To:     Thorsten Leemhuis <regressions@leemhuis.info>
Cc:     Cyril Brulebois <kibi@debian.org>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
        Linux PCI <linux-pci@vger.kernel.org>, bjorn@helgaas.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello,
I have just sent a pullrequest to linu-pci@vger@kernel.org to address
this regression.
Please let me know if I have to do anything else besides addressing
reviewers concerns
for this pullreq.
Thanks,
Jim Quinlan
Broadcom STB



On Mon, May 16, 2022 at 5:05 PM Jim Quinlan <jim2101024@gmail.com> wrote:
>
> Hi Bjorn, Thorsten,
>
> I apologize -- I did not see this email until now; I think I have to
> work on my gmail filters and labels.
>
> I've just made a post on the Bugzilla website regarding this
> regression and have ideas on what may be causing the problem.
> Unfortunately, the error cannot be reproduced on my RPi4 or Broadcom
> STB version of the 2711.
> Hopefully Cyril can help me identify the issue.
>
> I will try to get a Fixup ASAP.
>
> Regards,
> Jim Quinlan
> Broadcom STB
>
> On Mon, May 9, 2022 at 3:44 AM Thorsten Leemhuis
> <regressions@leemhuis.info> wrote:
> >
> > Hi, this is your Linux kernel regression tracker. Partly top-posting to
> > mnake this easily accessible.
> >
> > Jim, what's up here? The regression was reported more than a week ago
> > and it seems nothing happened since then. Or was there progress and I
> > just missed it?
> >
> > Anyway:
> >
> > [TLDR: I'm adding this regression report to the list of tracked
> > regressions; all text from me you find below is based on a few template=
s
> > paragraphs you might have encountered already already in similar form.]
> >
> > On 02.05.22 20:38, Bjorn Helgaas wrote:
> > > On Sat, Apr 30, 2022 at 2:53 PM <bugzilla-daemon@kernel.org> wrote:
> > >>
> > >> https://bugzilla.kernel.org/show_bug.cgi?id=3D215925
> > >>
> > >>             Bug ID: 215925
> > >>            Summary: PCIe regression on Raspberry Pi Compute Module 4=
 (CM4)
> > >>                     breaks booting
> > >>            Product: Drivers
> > >>            Version: 2.5
> > >>     Kernel Version: v5.17-rc1
> > >>           Hardware: ARM
> > >>                 OS: Linux
> > >>               Tree: Mainline
> > >>             Status: NEW
> > >>           Severity: normal
> > >>           Priority: P1
> > >>          Component: PCI
> > >>           Assignee: drivers_pci@kernel-bugs.osdl.org
> > >>           Reporter: kibi@debian.org
> > >>         Regression: No
> > >>
> > >> Catching up with latest kernel releases in Debian, it turned out tha=
t my
> > >> Raspberry Pi Compute Module 4, mounted on an official Compute Module=
 4 IO
> > >> Board,
> > >> and booting from an SD card, no longer boots: this means a black scr=
een on the
> > >> HDMI output, and no output on the serial console.
> > >>
> > >> Trying various releases, I confirmed that v5.16 was fine, and v5.17-=
rc1 was the
> > >> first (pre)release that wasn't.
> > >>
> > >> After some git bisect, it turns out the cause seems to be the follow=
ing commit
> > >> (https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/=
commit/?id=3D830aa6f29f07a4e2f1a947dfa72b3ccddb46dd21):
> > >>
> > >> ```
> > >> commit 830aa6f29f07a4e2f1a947dfa72b3ccddb46dd21
> > >> Author: Jim Quinlan <jim2101024@gmail.com>
> > >> Date:   Thu Jan 6 11:03:27 2022 -0500
> > >>
> > >>     PCI: brcmstb: Split brcm_pcie_setup() into two funcs
> > >> ```
> > >>
> > >> Starting with this commit, the kernel panics early (before 0.30 seco=
nds), with
> > >> an `Asynchronous SError Interrupt`. The backtrace references various
> > >> `brcm_pcie_*` functions; I can share a picture or try and transcribe=
 it
> > >> manually if that helps (nothing on the serial console=E2=80=A6).
> > >>
> > >> This commit is part of a branch that was ultimately merged as
> > >> d0a231f01e5b25bacd23e6edc7c979a18a517b2b; starting with this commit,=
 there's
> > >> not even a backtrace anymore, the screen stays black after the usual=
 =E2=80=9Cboot-up
> > >> rainbow=E2=80=9D, and there's still nothing on the serial console.
> > >>
> > >> I confirmed that 88db8458086b1dcf20b56682504bdb34d2bca0e2 (on the ma=
ster side)
> > >> was still booting properly, and that 87c71931633bd15e9cfd51d4a4d9cd6=
85e8cdb55
> > >> (from the branch being merged into master) is the last commit showin=
g the
> > >> panic.
> > >>
> > >> Since d0a231f01e5b25bacd23e6edc7c979a18a517b2b is a merge commit tha=
t includes
> > >> conflict resolutions in drivers/pci/controller/pcie-brcmstb.c, I sup=
pose this
> > >> could be consistent with the initial panic being =E2=80=9Cupgraded=
=E2=80=9D into an even more
> > >> serious issue.
> > >>
> > >> I've also verified that latest master (v5.18-rc4-396-g57ae8a492116) =
is still
> > >> affected by this issue.
> > >>
> > >> The regular Raspberry Pi 4 B doesn't seem to be affected by this iss=
ue: the
> > >> exact same image on the same SD card (with latest master) boots fine=
 on it.
> >
> > CCing the regression mailing list, as it should be in the loop for all
> > regressions, as explained here:
> > https://www.kernel.org/doc/html/latest/admin-guide/reporting-issues.htm=
l
> >
> > To be sure below issue doesn't fall through the cracks unnoticed, I'm
> > adding it to regzbot, my Linux kernel regression tracking bot:
> >
> > #regzbot ^introduced 830aa6f29f07a4e2f1a
> > #regzbot title pci: brcmstb: CM4 no longer boots from SD card
> > #regzbot ignore-activity
> > #regzbot from: Cyril Brulebois <kibi@debian.org>
> > #regzbot link: https://bugzilla.kernel.org/show_bug.cgi?id=3D215925
> >
> > This isn't a regression? This issue or a fix for it are already
> > discussed somewhere else? It was fixed already? You want to clarify whe=
n
> > the regression started to happen? Or point out I got the title or
> > something else totally wrong? Then just reply -- ideally with also
> > telling regzbot about it, as explained here:
> > https://linux-regtracking.leemhuis.info/tracked-regression/
> >
> > Reminder for developers: When fixing the issue, add 'Link:' tags
> > pointing to the report (the mail this one replied to), as the kernel's
> > documentation call for; above page explains why this is important for
> > tracked regressions.
> >
> > Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat=
)
> >
> > P.S.: As the Linux kernel's regression tracker I deal with a lot of
> > reports and sometimes miss something important when writing mails like
> > this. If that's the case here, don't hesitate to tell me in a public
> > reply, it's in everyone's interest to set the public record straight.
