Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2624822114D
	for <lists+linux-pci@lfdr.de>; Wed, 15 Jul 2020 17:41:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725770AbgGOPiH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 15 Jul 2020 11:38:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726848AbgGOPiF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 15 Jul 2020 11:38:05 -0400
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFC25C061755
        for <linux-pci@vger.kernel.org>; Wed, 15 Jul 2020 08:38:05 -0700 (PDT)
Received: by mail-il1-x12c.google.com with SMTP id h16so2332115ilj.11
        for <linux-pci@vger.kernel.org>; Wed, 15 Jul 2020 08:38:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WfIdeZLZov6NfnmmqQlv+Rb5MpsRzDo+FOzJR5t4gYs=;
        b=FZDdVDJVoiLHHzBHe0aiqJLbmNlC5iFh+SkgJid8YYrKUrtn5IIpqkkHxbpsO0BySp
         smbOSz9A1X2dJzpEWh/Da6y1WA2oHs20ODbqX5GILpc2tesIM9rkvrG8BRNGet3UbnWP
         PqCrbtSwGqB+tdxzVM83L2Bdn1hHSMwxg57uooz9i+FqavIrMK0RNhqIori25jLjcmZW
         lbkCd8E7f64sNSnYZXht8XHFVYVKwGKPSXwZIt0wjdIFsvAx3623oR82Gv3NpS+0mDLw
         vigttZlP4vpQlVNufIFNphlm8dnsk74Z5kW0AbOwi7N8AyE5ycFuoI9kZPTHJodHnE77
         2OKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WfIdeZLZov6NfnmmqQlv+Rb5MpsRzDo+FOzJR5t4gYs=;
        b=TPUuK+wlz+/7fecF/hSp0o3wCHm5z6mc5gTCrHrqaHp/4uEk3tr/ccQu7UBonCAVVR
         YJcI4mKAHiAKxDOQYcmhIoo3Yv5fTudeb+fFcynoT6nUFwm/FA+n/tvkcJBX0iBGw8We
         j9/uFbSzdyAi5FbBeAlrfZ8rJ67prTaTJaQq+1MchYzo9BeRG+KXlc/43oaf9+XDm0GT
         q5ftAaF348yKanT+OOWSQZ0uv/rTPXiuMIIE0mQf1dypIr797ByqT10b6OIRCf7/BhEZ
         5vjGoezwGH74kfd6y6Cgmu8vB3q4XX1bxpRHunLJ2dKtJoe25HqrgSlYzC0Cw3XjvCzn
         slzQ==
X-Gm-Message-State: AOAM533ZUZExLvR7JuiD6sO+sQy3V4wvpJrO+PtDAGcPfphEP1M0QmgJ
        2T5BBiNP4JiJSmKKHCrPyHOjkRLSmBx6uPQmhi5wes/X2w==
X-Google-Smtp-Source: ABdhPJxud2/xIlpsVfp7fb8qx4o80lN+0L3wBqYefFShxcH/lWMl7pHBhLw9qMKvJ6fWnwdbgV2B8bJ28ovfgpeXfmU=
X-Received: by 2002:a92:6a02:: with SMTP id f2mr102523ilc.68.1594827484238;
 Wed, 15 Jul 2020 08:38:04 -0700 (PDT)
MIME-Version: 1.0
References: <5f99bc07-9b56-04c0-f022-3cbde3af5bb4@gmail.com>
In-Reply-To: <5f99bc07-9b56-04c0-f022-3cbde3af5bb4@gmail.com>
From:   Bjorn Helgaas <bhelgaas@google.com>
Date:   Wed, 15 Jul 2020 10:37:53 -0500
Message-ID: <CAErSpo5sTeK_my1dEhWp7aHD0xOp87+oHYWkTjbL7ALgDbXo-Q@mail.gmail.com>
Subject: Fwd: Hybrid graphics regression in 5.4.49+ [bisected]
To:     Linux PCI <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     Bjorn Helgaas <bjorn@helgaas.com>,
        Patrick Volkerding <volkerdi@gmail.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

---------- Forwarded message ---------
From: Patrick Volkerding <volkerdi@gmail.com>
Date: Tue, Jul 14, 2020 at 2:22 PM
Subject: Hybrid graphics regression in 5.4.49+ [bisected]
To: Bjorn Helgaas <bhelgaas@google.com>, Mika Westerberg
<mika.westerberg@linux.intel.com>
Cc: Patrick Volkerding <volkerdi@gmail.com>


Hello,

I ran into a problem recently with a laptop with hybrid graphics. Here
are the specs of the machine:

OS: Slackware 14.2 x86_64 (post 14.2 -current) x86_64
Host: 20QV000GUS ThinkPad X1 Extreme 2nd
CPU: Intel i7-9850H (12) @ 4.600GHz
GPU: NVIDIA GeForce GTX 1650 Mobile / Max-Q
GPU: Intel UHD Graphics 630

The graphics are set to hybrid in the BIOS, and no proprietary drivers
are in use.

With 5.4.48, starting X from a console works as expected and the Intel
UHD Graphics 630 is used.

Starting with 5.4.49, attempting to start X from a console causes the
machine to become unresponsive, and thousands of these messages are
found in the syslog:

Jul  1 14:39:26 z-mp kernel: [ 1657.318941] nouveau 0000:01:00.0: fifo:
PBDMA0: 01000000 [] ch 0 [00ff992000 DRM] subc 0 mthd 0008 data 00000000

A git bisect between 5.4.48 and 5.4.49 pointed to the commit
[828b192c57e8f4fee77f7a34bd19c1b58b049dad] PCI/PM: Assume ports without
DLL Link Active train links in 100 ms.

The commit reverts cleanly from 5.4.51, and then that kernel works as
expected. Additionally I should note that an unmodified kernel 5.7.7
also works as expected.

Happy to help test any proposed fix.

Here's the git bisect log:

git bisect start
# good: [67cb016870e2fa9ffc8d34cf20db5331e6f2cf4d] Linux 5.4.48
git bisect good 67cb016870e2fa9ffc8d34cf20db5331e6f2cf4d
# good: [67cb016870e2fa9ffc8d34cf20db5331e6f2cf4d] Linux 5.4.48
git bisect good 67cb016870e2fa9ffc8d34cf20db5331e6f2cf4d
# bad: [99705220b22ca116457edeae51ae817d056a6622] net: core:
device_rename: Use rwsem instead of a seqcount
git bisect bad 99705220b22ca116457edeae51ae817d056a6622
# bad: [7454c171a88c188583bbfe17db1f9e6e75723b5f] tty: n_gsm: Fix bogus
i++ in gsm_data_kick
git bisect bad 7454c171a88c188583bbfe17db1f9e6e75723b5f
# good: [390f1688fb4648474b29c8ea6c2c710b689cd669] f2fs: handle readonly
filesystem in f2fs_ioc_shutdown()
git bisect good 390f1688fb4648474b29c8ea6c2c710b689cd669
# good: [9eb54d0e8962d2f5d7a430f3a245037c990e3b42] PCI: v3-semi: Fix a
memory leak in v3_pci_probe() error handling paths
git bisect good 9eb54d0e8962d2f5d7a430f3a245037c990e3b42
# good: [4536dbe64bd17b7d16cb0da56a15616dda247940] USB: ohci-sm501: fix
error return code in ohci_hcd_sm501_drv_probe()
git bisect good 4536dbe64bd17b7d16cb0da56a15616dda247940
# bad: [b1bc8753eefc82b79e285977c6177c67bc17344e] ipmi: use vzalloc
instead of kmalloc for user creation
git bisect bad b1bc8753eefc82b79e285977c6177c67bc17344e
# good: [860b8717f7247384e500ba15c89e9b5327d00423] tty: n_gsm: Fix
waking up upper tty layer when room available
git bisect good 860b8717f7247384e500ba15c89e9b5327d00423
# good: [c6737f3a1b01120ce0991bb0b6b4c8da2b086f1e] HID: Add quirks for
Trust Panora Graphic Tablet
git bisect good c6737f3a1b01120ce0991bb0b6b4c8da2b086f1e
# bad: [5c2207ba2394ee6c2dd7383890818aca89ff4b9b] habanalabs: increase
timeout during reset
git bisect bad 5c2207ba2394ee6c2dd7383890818aca89ff4b9b
# bad: [828b192c57e8f4fee77f7a34bd19c1b58b049dad] PCI/PM: Assume ports
without DLL Link Active train links in 100 ms
git bisect bad 828b192c57e8f4fee77f7a34bd19c1b58b049dad
# first bad commit: [828b192c57e8f4fee77f7a34bd19c1b58b049dad] PCI/PM:
Assume ports without DLL Link Active train links in 100 ms

Best regards,

Pat
