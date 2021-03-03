Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 423DC32C2AD
	for <lists+linux-pci@lfdr.de>; Thu,  4 Mar 2021 01:05:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348618AbhCCU5U (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 3 Mar 2021 15:57:20 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:44125 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385724AbhCCRb4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 3 Mar 2021 12:31:56 -0500
Received: from mail-lf1-f71.google.com ([209.85.167.71])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1lHVL5-0008Oq-Lc
        for linux-pci@vger.kernel.org; Wed, 03 Mar 2021 17:31:11 +0000
Received: by mail-lf1-f71.google.com with SMTP id d3so8790182lfc.18
        for <linux-pci@vger.kernel.org>; Wed, 03 Mar 2021 09:31:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DNBkaiybkp5HfVaKwCc/cz5dVdgiPjvVtcAh48LuHW8=;
        b=WvjTFaBnAr/GPC5A8alkWnrpSt5kauGuDzRQm+0r+qJ+82/ePDsgV6QQ4VoSJw4ith
         HzKYEVYwl99VGK7nIfFTbWgg2Q1HQTwMiDHa7C65thpsWKNCorsBMHb1Rccdw4l2uRCf
         nS1rror2JNPDXdRykwUiy+O478Q65s1H0SUl0/A8ma7paOoDsOmvgGsiA0PZahPj0xN9
         bXc8Q1I7SOnrOAG3fD5yT3+SCloclttuWSmGjBVZsEXcFzXCKbMvcj74f6oxx8wj/NET
         q3yndXC7Xcr1TkSz57DCjDSEiWutDKyd3DXMsPLVS0bz0zb6RyVek2P9hPs78VPPOef/
         0hGw==
X-Gm-Message-State: AOAM530IPmf0QOy2+z1okZonJ3FSpsUMJ7uZnauIrTCpP0n4MnuXlZdh
        faYNBYbFVjqgs+ZnFVfCv0hzA0Cv0OcpAgF32n6xfpvkxZPTpFk2zk/l4G8w78+KowxqrVabEXM
        FGd6GUBYqvpJn1SKKZ1XN1FzmrhGoArg1Y7M+Zao/hdVhgGFbsvpyjA==
X-Received: by 2002:a05:6512:96e:: with SMTP id v14mr15662859lft.513.1614792671120;
        Wed, 03 Mar 2021 09:31:11 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzwDB2gLnzMHYUS8PnwUpgK+sKa6OMoNAAjLqjZZOeF1A8dr9tJmFr/ry2d9ljiLDBfgi1zl9R1kHciw7dYoPA=
X-Received: by 2002:a05:6512:96e:: with SMTP id v14mr15662849lft.513.1614792670901;
 Wed, 03 Mar 2021 09:31:10 -0800 (PST)
MIME-Version: 1.0
References: <bug-212039-41252@https.bugzilla.kernel.org/> <20210303172223.GA634698@bjorn-Precision-5520>
In-Reply-To: <20210303172223.GA634698@bjorn-Precision-5520>
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Date:   Thu, 4 Mar 2021 01:30:59 +0800
Message-ID: <CAAd53p7Ew8Pwis6=fLLthZJGfLjvVo1i5jeDG0YA=-9r7x23BQ@mail.gmail.com>
Subject: Re: [Bug 212039] New: PCI_COMMAND randomly flips to 0 after system
 resume, breaks the xHCI device
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Linux PCI <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Mar 4, 2021 at 1:22 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> [+to linux-pci]
>
> On Wed, Mar 03, 2021 at 05:08:37PM +0000, bugzilla-daemon@bugzilla.kernel.org wrote:
> > https://bugzilla.kernel.org/show_bug.cgi?id=212039
> >
> >             Bug ID: 212039
> >            Summary: PCI_COMMAND randomly flips to 0 after system resume,
> >                     breaks the xHCI device
> >            Product: Drivers
> >            Version: 2.5
> >     Kernel Version: mainline, linux-next
> >           Hardware: All
> >                 OS: Linux
> >               Tree: Mainline
> >             Status: NEW
> >           Severity: normal
> >           Priority: P1
> >          Component: PCI
> >           Assignee: drivers_pci@kernel-bugs.osdl.org
> >           Reporter: kai.heng.feng@canonical.com
> >         Regression: No
> >
> > After system resume, the read on PCI_COMMAND may randomly be 0 in
> > pci_read_config_word(), which is called by __pci_set_master().
>
> Comment #3 says this is not reproducible on Intel RVP.

This bug report is mainly for Intel internal use. A public bug is mandatory.

>
> What platform *does* it occur on? Does it always happen on that
> platform?

Tigerlake-H. Only a specific model (but all different configs) is affected.

>
> (You said "randomly" above, but I don't know it that means it happens
> on some platforms but not others, or it happens sometimes on a give
> platform but not always.)

As of now, it only happens to this specific model.

>
> > So it only enables Bus Master in next pci_read_config_word(),
> > disabling "Memory Space", "I/O Space" at the same time.
> >
> > This makes xHCI driver fail to access MMIO register, render USB
> > unusable.
>
> Apparently this only affect the xHCI device?  That's weird; the code
> that restores config registers after resume should be pretty generic,
> so a bug there should affect lots of devices.  But maybe there's some
> firmware component since it seems to happen on some platforms but not
> others.

Actually, more devices are affected. But this bug is most detrimental
to USB controller, because this model requires USB keyboard and mouse
to be useful. So I single it out as the main point for the bug report.

Kai-Heng
