Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 640155176A6
	for <lists+linux-pci@lfdr.de>; Mon,  2 May 2022 20:39:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351299AbiEBSmj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 2 May 2022 14:42:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231752AbiEBSmg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 2 May 2022 14:42:36 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76B4D7645
        for <linux-pci@vger.kernel.org>; Mon,  2 May 2022 11:39:06 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id c15so19421149ljr.9
        for <linux-pci@vger.kernel.org>; Mon, 02 May 2022 11:39:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=VY74pSb44aXaB5Q/ACtIOW5Tcs+anB1Z5G3riabqw6I=;
        b=EFMI8iBz3AEwusat5ro5bkbFAA0UYW5zy1phWCVHYnuiCSCqrBPTx/tFpe5A+5btFv
         5+pjUmm3lKrp06RUJ46bylbdOiijgjTQett/UmSx93qTM8Kg8Puz7cpafk5JkcvS730C
         ayPYY8Fvt8/jS3A4hR/MuDOAcfJWWoQ1q/lezKpMNYP2h3kzAOA9glJrH4OQVG8cFvCn
         hy+9hHv5BIWOoyDEdJLHVn9DtE5/SlFMQJIMD1dPQnDT62hCh/X1RiNqLVGd5KnIbTfu
         A0ss6ZLITN+844uyEp9ndZeG8juC+wNxlueia8AjlBjziuPnSp9245Rcle/M79UPHOmw
         gw5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=VY74pSb44aXaB5Q/ACtIOW5Tcs+anB1Z5G3riabqw6I=;
        b=WfDscqTpX8JzBMdtNWdbhoDA4pQlTgx8fOMwpUl0j2XK0YFGs8nQ4IndThnpY45/oy
         7cJWfc+5Opf3t0UmL/9Zv6gfZOAWISTyN2EdknrRNT9bvfFwin+epmRFO4ZFFQFeGQJ7
         E0B/FeH5QZg0XnPfh6KFXJSTl0cO0OQt8k4SJMPCv3iIrnv2Iqu/hnDpCsU2c83T6ivr
         ohfrRYbqYEIb/0m9+eH+sssDq9L4RSf4z3iOO6byJ9UJDYZza2/AhXS1mtD/LMK/OAqj
         47HG/Z+xDrYLMMwM4LwZHaybUy6idHZjaO9IK8sWf5MoT9NDn35esrzCkXPub0h+Dr6d
         lYSg==
X-Gm-Message-State: AOAM531fhiS6kj8q1pW1pRG/025lKCMGaaaYWmXarNzohagGeeXtpD1W
        nIooiwIiJiBsDdikjldFQFREcGQuWyN+5aKzue+BXen2
X-Google-Smtp-Source: ABdhPJyB2zyIza0RGWQzI2l5qkil3PnQb//0VdFKk7mymMBttAiiGKy+UmC1sdmZ+reA41z2FZzpMIgs/tEFt6Zg+s0=
X-Received: by 2002:a2e:a811:0:b0:24e:fb1a:e49f with SMTP id
 l17-20020a2ea811000000b0024efb1ae49fmr7932505ljq.284.1651516743644; Mon, 02
 May 2022 11:39:03 -0700 (PDT)
MIME-Version: 1.0
References: <bug-215925-41252@https.bugzilla.kernel.org/>
In-Reply-To: <bug-215925-41252@https.bugzilla.kernel.org/>
Reply-To: bjorn@helgaas.com
From:   Bjorn Helgaas <bjorn.helgaas@gmail.com>
Date:   Mon, 2 May 2022 13:38:51 -0500
Message-ID: <CABhMZUWjZCwK1_qT2ghTSu2dguJBzBTpiTqKohyA72OSGMsaeg@mail.gmail.com>
Subject: Re: [Bug 215925] New: PCIe regression on Raspberry Pi Compute Module
 4 (CM4) breaks booting
To:     Linux PCI <linux-pci@vger.kernel.org>
Cc:     Bjorn Helgaas <bjorn@helgaas.com>,
        Jim Quinlan <jim2101024@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, Apr 30, 2022 at 2:53 PM <bugzilla-daemon@kernel.org> wrote:
>
> https://bugzilla.kernel.org/show_bug.cgi?id=3D215925
>
>             Bug ID: 215925
>            Summary: PCIe regression on Raspberry Pi Compute Module 4 (CM4=
)
>                     breaks booting
>            Product: Drivers
>            Version: 2.5
>     Kernel Version: v5.17-rc1
>           Hardware: ARM
>                 OS: Linux
>               Tree: Mainline
>             Status: NEW
>           Severity: normal
>           Priority: P1
>          Component: PCI
>           Assignee: drivers_pci@kernel-bugs.osdl.org
>           Reporter: kibi@debian.org
>         Regression: No
>
> Catching up with latest kernel releases in Debian, it turned out that my
> Raspberry Pi Compute Module 4, mounted on an official Compute Module 4 IO
> Board,
> and booting from an SD card, no longer boots: this means a black screen o=
n the
> HDMI output, and no output on the serial console.
>
> Trying various releases, I confirmed that v5.16 was fine, and v5.17-rc1 w=
as the
> first (pre)release that wasn't.
>
> After some git bisect, it turns out the cause seems to be the following c=
ommit
> (https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commi=
t/?id=3D830aa6f29f07a4e2f1a947dfa72b3ccddb46dd21):
>
> ```
> commit 830aa6f29f07a4e2f1a947dfa72b3ccddb46dd21
> Author: Jim Quinlan <jim2101024@gmail.com>
> Date:   Thu Jan 6 11:03:27 2022 -0500
>
>     PCI: brcmstb: Split brcm_pcie_setup() into two funcs
> ```
>
> Starting with this commit, the kernel panics early (before 0.30 seconds),=
 with
> an `Asynchronous SError Interrupt`. The backtrace references various
> `brcm_pcie_*` functions; I can share a picture or try and transcribe it
> manually if that helps (nothing on the serial console=E2=80=A6).
>
> This commit is part of a branch that was ultimately merged as
> d0a231f01e5b25bacd23e6edc7c979a18a517b2b; starting with this commit, ther=
e's
> not even a backtrace anymore, the screen stays black after the usual =E2=
=80=9Cboot-up
> rainbow=E2=80=9D, and there's still nothing on the serial console.
>
> I confirmed that 88db8458086b1dcf20b56682504bdb34d2bca0e2 (on the master =
side)
> was still booting properly, and that 87c71931633bd15e9cfd51d4a4d9cd685e8c=
db55
> (from the branch being merged into master) is the last commit showing the
> panic.
>
> Since d0a231f01e5b25bacd23e6edc7c979a18a517b2b is a merge commit that inc=
ludes
> conflict resolutions in drivers/pci/controller/pcie-brcmstb.c, I suppose =
this
> could be consistent with the initial panic being =E2=80=9Cupgraded=E2=80=
=9D into an even more
> serious issue.
>
> I've also verified that latest master (v5.18-rc4-396-g57ae8a492116) is st=
ill
> affected by this issue.
>
> The regular Raspberry Pi 4 B doesn't seem to be affected by this issue: t=
he
> exact same image on the same SD card (with latest master) boots fine on i=
t.
