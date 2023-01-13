Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E95E6693E5
	for <lists+linux-pci@lfdr.de>; Fri, 13 Jan 2023 11:19:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240856AbjAMKTL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 13 Jan 2023 05:19:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241039AbjAMKSn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 13 Jan 2023 05:18:43 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D11A6B596;
        Fri, 13 Jan 2023 02:18:41 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id m21so30538706edc.3;
        Fri, 13 Jan 2023 02:18:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=kzDOK1JJgHEyW0UkKAsgNd5XNzteE1HhYTj65aQgafA=;
        b=flhQ/myVHK6JKteIP002IwYUQ1HLE+TmwKWGqM44yzp/wk8RhnYAAPRjqXegQMU8if
         d6UkFENK/I2Ko4Cb15fraqKWzsmk3OYAbY+jKgaNgczi/cP/YUAJOpFRBXFEhG/amnDM
         MKt96Tk+X16N9/QqPHILjSezJSRLF6NKMxI4CbKjK0YPFaPqzaZIQdlh45W4JTxdQe7Q
         Ujc6FxGNYml+oEhvlLnVApd2aS3tQUewdiS9+lDC7hrYBIVDa5bRcGrhPtD2+i8PajKn
         Mpe6V3OYsmoY/ds0Lt5Fw2llEK7vENozV9/3+oyJqCSmilDe6yDMCoCbTW9q6xCyyYCT
         Jy4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kzDOK1JJgHEyW0UkKAsgNd5XNzteE1HhYTj65aQgafA=;
        b=Fu0SlLUABAV0baO0qzaCj/Wl19GIrg7i2yVI+1XjHQF5xlzvYwpl/jjDUJYN5qvPZM
         kGC3Tg2VJAYhuSmd94spoRcFXWsv9SFqRUZpXI64hG+PlM0pBgDnMMAijTHITtcuZxsF
         xaoWf+shoGWSd09IcI3S/IeC8BYWuMkZgsyv8Nw/mAeogWy8ZT3lmPERxbyHPsSOoUmZ
         PxGOiaMI6m3/HS/XSzPEIf5AIAxFFpOYzhFIEPCzq6bjtz52R23LsRpsS/A+ALMp0Wsu
         W5FKbO7mY4skp98aQJ+HR5PzBMCmhTaG4MOGZuXFE+2ke+x3Wli0odkYT9Itpn8SSKwl
         xmiA==
X-Gm-Message-State: AFqh2kqqiCAQMk5sal9Ch77Zs3tEB9lgZnuUiMszSt6uR7Yxd1AcDSHC
        KXflTkRaynoVgTAEoDaGKtx2U2UQbHlQoDqXo9Kre3MWAkI=
X-Google-Smtp-Source: AMrXdXvp/ij2CcKdAeoXa+bxrKAsBQX0J149SYtq9TQsQyh6L5bKkEtpxP6cToqRfrtaE1cNii7nZUYGchM8ODW9oZk=
X-Received: by 2002:a05:6402:40d3:b0:48e:c1a0:119f with SMTP id
 z19-20020a05640240d300b0048ec1a0119fmr3971521edb.115.1673605119927; Fri, 13
 Jan 2023 02:18:39 -0800 (PST)
MIME-Version: 1.0
References: <20221228120248.GA508080@bhelgaas> <20230112200819.GA1785077@bhelgaas>
In-Reply-To: <20230112200819.GA1785077@bhelgaas>
From:   Zeno Davatz <zdavatz@gmail.com>
Date:   Fri, 13 Jan 2023 11:18:29 +0100
Message-ID: <CAOkhzLU_F9O0TxUzkb9YdHr357O3muj9V7GLTLsWzHm5mUsr-w@mail.gmail.com>
Subject: Re: [Bug 216859] New: PCI bridge to bus boot hang at enumeration
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Takashi Iwai <tiwai@suse.de>, Jaroslav Kysela <perex@perex.cz>,
        alsa-devel@alsa-project.org
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

Dear Bjorn

On Thu, Jan 12, 2023 at 9:08 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> [+cc sound folks]
>
> On Wed, Dec 28, 2022 at 06:02:48AM -0600, Bjorn Helgaas wrote:
> > On Wed, Dec 28, 2022 at 08:37:52AM +0000, bugzilla-daemon@kernel.org wrote:
> > > https://bugzilla.kernel.org/show_bug.cgi?id=216859
> >
> > >            Summary: PCI bridge to bus boot hang at enumeration
> > >     Kernel Version: 6.1-rc1
> > > ...
> >
> > > With Kernel 6.1-rc1 the enumeration process stopped working for me,
> > > see attachments.
> > >
> > > The enumeration works fine with Kernel 6.0 and below.
> > >
> > > Same problem still exists with v6.1. and v6.2.-rc1
> >
> > Thank you very much for your report, Zeno!
> >
> > v6.0 works, v6.1-rc1 fails.  Would you mind booting v6.1-rc1 with the
> > "ignore_loglevel initcall_debug" kernel parameters and taking a photo
> > when it hangs?
> >
> > How did you conclude that the hang is related to a PCI bridge?  I see
> > recent PCI messages in the photo, but it looks like the last message
> > is from NFS, so I'm wondering if I'm missing some context.  The v6.0
> > dmesg shows several other ntfs, fuse, JFS, etc messages before more
> > PCI-related things.  Anyway, the "initcall_debug" might help us narrow
> > it down a bit.
>
> Thanks very much for the bisection (complete log at [1])!
>
> The bisection claims the first bad commit is:
>
>   833477fce7a1 ("Merge tag 'sound-6.1-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound")
>
> with parents:
>
>   7e6739b9336e ("Merge tag 'drm-next-2022-10-05' of git://anongit.freedesktop.org/drm/drm")
>   86a4d29e7554 ("Merge tag 'asoc-v6.1' of https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound into for-linus")
>
> Both 7e6739b9336e and 86a4d29e7554 tested "good" during the bisection.
>
> There is a minor conflict when merging 86a4d29e7554 into the upstream,
> but I can't imagine that being resolved incorrectly.
>
> Would you mind turning off CONFIG_SOUND in your .config and testing
> 833477fce7a1 again?  I'm a little skeptical that the hang would be
> sound-related, but I guess it's a place to start.
>
> Bjorn
>
> [1] https://bugzilla.kernel.org/show_bug.cgi?id=216859#c35

Booting without sound into the commit 833477fce7a1 did not help. Same hang.

Best
Zeno
