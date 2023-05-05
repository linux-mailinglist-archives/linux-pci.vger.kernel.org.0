Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2122C6F7D51
	for <lists+linux-pci@lfdr.de>; Fri,  5 May 2023 08:57:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229577AbjEEG5Q (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 5 May 2023 02:57:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230402AbjEEG5P (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 5 May 2023 02:57:15 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84F051AE
        for <linux-pci@vger.kernel.org>; Thu,  4 May 2023 23:57:13 -0700 (PDT)
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 4A7C63F32E
        for <linux-pci@vger.kernel.org>; Fri,  5 May 2023 06:57:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1683269828;
        bh=8Ffn34QdIPteAhuo1D55q6Psg3jmIbfrccXTKRJ40S0=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=NfU3WA7eujrzWkerGNvcJDIU6KMltE1nGL52dRJy2EaaNhhBGEopPNMsJbYDnAQaQ
         Rl5AeShfZbxEjWlUD3Rn4J5kuoczccJ26D5QWzvucWus4lH41p6AdSqtAmihDmkHcy
         Cr2GM9QFInxdHk6mgU8Y1T7ya6CI0arZS8RaYyCT+ed6Zc0eeoYJXIHWT70k4JKD7z
         kOO/7u2yyBNv5Mv7R1XQAr/Pz/z/XGI8HOZY0lm9h/i2Cq0Pno+m/4ijo/S308MvX0
         z+ExvgsVOQTJEmGpN6FRMsAqsbN84QqPuMKNfR/Xhe3WrLc+IiYWqNBoFQAQUEkSAs
         e8Xq8tTmuKARw==
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-24e43240e9fso676848a91.3
        for <linux-pci@vger.kernel.org>; Thu, 04 May 2023 23:57:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683269827; x=1685861827;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8Ffn34QdIPteAhuo1D55q6Psg3jmIbfrccXTKRJ40S0=;
        b=bNqyuJ43DqeZeyczIf8oeV7qT7+Z2dcsFufXx20+RZE3K0BgMWtWwMzn4iFEU7nRrq
         P9bjNnVkLskNx6cbSqqtfPJtd4xJqca+gCLo4SAtOocGnSBZTwuVWAb5M4WP6eikjWQ6
         x0IabvyQ4LswLhVQMXn+eAneOHJDxFLX8E5FHRySnzZ0Nc4Vxh+0ZhJVfPYW9tIPt6A1
         2Wftb2pZLXk08d3gDsNMNWzl2yZg09w0gqaMelMYc42u5MAspDhmbVAF6ykzg7R2G9ii
         roGpcJIUG+zyLGjrwRAveiXaxgMjUUOaLmDcUhHaaVSyKXQU8ZBkx5biHS9Seku8yroo
         ceIA==
X-Gm-Message-State: AC+VfDyPv/sY4uQgBXE77zPnMsapr0q7L/AY8RaDvr4wHZXpp5M9E/0s
        zgi8VL9BUlf+bNiBicHVeqxsIXuz4WVhdF/Ptzsbognv5jyNF+CforS0aRKGBetBf/9tlFFVrNl
        iIUKeSDbUHxTbJsHLj4NyOcxcyzFBpvHh/ZC5Vq3P1sZpVL7Disuqfw==
X-Received: by 2002:a17:90b:b15:b0:246:bb61:4a56 with SMTP id bf21-20020a17090b0b1500b00246bb614a56mr484463pjb.27.1683269826877;
        Thu, 04 May 2023 23:57:06 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ53iTMBSNhcrnIPyTfvwZ8N19AD181tDNAR5buVj0cJloI3cWhtExnX2UdH5CGdk2teqlzLhTHDhq/f/wafQfw=
X-Received: by 2002:a17:90b:b15:b0:246:bb61:4a56 with SMTP id
 bf21-20020a17090b0b1500b00246bb614a56mr484451pjb.27.1683269826445; Thu, 04
 May 2023 23:57:06 -0700 (PDT)
MIME-Version: 1.0
References: <20230411204229.GA4168208@bhelgaas> <20230504152344.GA857680@bhelgaas>
In-Reply-To: <20230504152344.GA857680@bhelgaas>
From:   Koba Ko <koba.ko@canonical.com>
Date:   Fri, 5 May 2023 08:56:54 +0200
Message-ID: <CAJB-X+Vu8HJSNza896ELGrUKk64gPH=MjbYQMSxW6Xiw4MSiJw@mail.gmail.com>
Subject: Re: [Bug 217321] New: Intel platforms can't sleep deeper than PC3
 during long idle
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org, Vidya Sagar <vidyas@nvidia.com>,
        Ajay Agarwal <ajayagarwal@google.com>,
        Tasev Nikola <tasev.stefanoska@skynet.be>,
        Mark Enriquez <enriquezmark36@gmail.com>,
        Thomas Witt <kernel@witt.link>, regressions@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, May 4, 2023 at 5:23=E2=80=AFPM Bjorn Helgaas <helgaas@kernel.org> w=
rote:
>
> [+cc Koba, Ajay, Tasev, Mark, Thomas, regressions list]
>
> On Tue, Apr 11, 2023 at 03:42:29PM -0500, Bjorn Helgaas wrote:
> > On Tue, Apr 11, 2023 at 08:32:04AM +0000, bugzilla-daemon@kernel.org wr=
ote:
> > > https://bugzilla.kernel.org/show_bug.cgi?id=3D217321
> > > ...
> > >         Regression: No
> > >
> > > [Symptom]
> > > Intel cpu can't sleep deeper than pc=CB=87 during long idle
> > > ~~~
> > > Pkg%pc2 Pkg%pc3 Pkg%pc6 Pkg%pc7 Pkg%pc8 Pkg%pc9 Pk%pc10
> > > 15.08   75.02   0.00    0.00    0.00    0.00    0.00
> > > 15.09   75.02   0.00    0.00    0.00    0.00    0.00
> > > ^CPkg%pc2       Pkg%pc3 Pkg%pc6 Pkg%pc7 Pkg%pc8 Pkg%pc9 Pk%pc10
> > > 15.38   68.97   0.00    0.00    0.00    0.00    0.00
> > > 15.38   68.96   0.00    0.00    0.00    0.00    0.00
> > > ~~~
> > > [How to Reproduce]
> > > 1. run turbostat to monitor
> > > 2. leave machine idle
> > > 3. turbostat show cpu only go into pc2~pc3.
> > >
> > > [Misc]
> > > The culprit are this
> > > a7152be79b62) Revert "PCI/ASPM: Save L1 PM Substates Capability for
> > > suspend/resume=E2=80=9D
> > >
> > > if revert a7152be79b62, the issue is gone
> >
> > Relevant commits:
> >
> >   4ff116d0d5fd ("PCI/ASPM: Save L1 PM Substates Capability for suspend/=
resume")
> >   a7152be79b62 ("Revert "PCI/ASPM: Save L1 PM Substates Capability for =
suspend/resume"")
> >
> > 4ff116d0d5fd appeared in v6.1-rc1.  Prior to 4ff116d0d5fd, ASPM L1 PM
> > Substates configuration was not preserved across suspend/resume, so
> > the system *worked* after resume, but used more power than expected.
> >
> > But 4ff116d0d5fd caused resume to fail completely on some systems, so
> > a7152be79b62 reverted it.  With a7152be79b62 reverted, ASPM L1 PM
> > Substates configuration is likely not preserved across suspend/resume.
> > a7152be79b62 appeared in v6.2-rc8 and was backported to the v6.1
> > stable series starting with v6.1.12.
> >
> > KobaKo, you don't mention any suspend/resume in this bug report, but
> > neither patch should make any difference unless suspend/resume is
> > involved.  Does the platform sleep as expected *before* suspend, but
> > fail to sleep after resume?
> >
> > Or maybe some individual device was suspended via runtime power
> > management, and that device lost its L1 PM Substates config?  I don't
> > know if there's a way to disable runtime PM easily.
>
> Koba, per your bugzilla update, the issue happens even without
> suspend/resume.  And we don't know whether some particular device is
> responsible.
>
> But if we save/restore L1SS state, we can sleep deeper than PC3.  If
> we don't preserve L1SS state, we can't.
>
> We definitely want to preserve the L1SS state, but we can't simply
> apply 4ff116d0d5fd ("PCI/ASPM: Save L1 PM Substates Capability for
> suspend/resume") again because it caused its own regressions [1,2,3]
>
> So somebody needs to figure out what was wrong with 4ff116d0d5fd, fix
> it, verify that it doesn't cause the issues reported by Tasev, Thomas,
> and Mark, and then we can apply it.
>
> Bjorn

Good days, discussed with Kai-Heng and he mentioned  the GPU may not
be pulled off the power.
then the GPU needs L1ss to get into power saving.

I will investigate further on this way.

>
> [1] https://git.kernel.org/linus/a7152be79b62
> [2] https://bugzilla.kernel.org/show_bug.cgi?id=3D216782
> [3] https://bugzilla.kernel.org/show_bug.cgi?id=3D216877
