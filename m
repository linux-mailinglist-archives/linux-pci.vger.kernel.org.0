Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 29F3619E7C5
	for <lists+linux-pci@lfdr.de>; Sat,  4 Apr 2020 23:40:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726423AbgDDVkB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 4 Apr 2020 17:40:01 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:41229 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726408AbgDDVkB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 4 Apr 2020 17:40:01 -0400
Received: by mail-ed1-f65.google.com with SMTP id v1so13920725edq.8
        for <linux-pci@vger.kernel.org>; Sat, 04 Apr 2020 14:39:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=S4FzW5l3F/MRzKf5qeak8f9n/lCbfbMKbWS8sG9Zeoo=;
        b=JO+JwHOmrvATaofgtRdKb3jleiP4gG1QSSTamy777EARGNTtY0l9/OCW8+AYODcQqt
         Il6Phhb9E1h7JQk4p0wmBRAkT+GJjlnHEz7aU9JN6RwFdKIHhP1sL8pCqsMF2b515HSK
         gKwCZuDKTd1T1s7pt6ME3WnrJjV4DMwjDcV5fc16XsANoNfLb93SuxtinZFrYspS7E3l
         TDw7oozt4N+DTJLvx/EeazKPszZ6xHxEfzAibyTINUmUgLzkLOlf5PGuhmvBIq8FKrLz
         3dDc0TRJZqo1RmLA94+ONIURdMtDP0KpJ2BCOnfQODH33ObR5mAfdYpnQ2JbKmBzYm73
         /Uxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=S4FzW5l3F/MRzKf5qeak8f9n/lCbfbMKbWS8sG9Zeoo=;
        b=g9NxuxPQ3aGNxxnOJBKCE9OjlNzWFWjxQF/mYXhF2tGlCvILmPifkQlXZX8U6ZhWiT
         pXCQ3yfPE7+7lWcblX6U/WbXFyfPVMYFjcq49PFeuciZeuBAlBBpYCdAegp/KdJPsX76
         MAf7rR0Md73o3vjlVh7LyzW0tyznGHXohLYOZm/VpQPgHXxd8d17CztcY2CKLAHfCbzQ
         H+eQ2hVV06xLH4MxLfWaMLQqWuCrDnC9PtQEsbJ4I6VM7fO93Vx5sWct5KKn42MvLKRV
         JofXXJuDWvmB998T2zs9ALmY87zDkzMYUxg2e7DWVnguAqTE/F8WveKC4XJ+kDGX8RRF
         1dcQ==
X-Gm-Message-State: AGi0Pua5HrC7zn7jS9DUlsjmBREVQnrDhXRoTPabCi75PuU9JXcCrbwL
        a/vnzCkEFxG9Bf7vpxb+aj6CGpuWHxwwUl+N8Bg=
X-Google-Smtp-Source: APiQypIAX5Od1h0t4AhnxTAKodVW5H1Ig+BShJXKgYoUGf0OLLOY/+hf7bFtl6Dr03hHstJeHJfT2b7o4EmF5DqDgPE=
X-Received: by 2002:a17:907:6e9:: with SMTP id yh9mr2152430ejb.272.1586036399226;
 Sat, 04 Apr 2020 14:39:59 -0700 (PDT)
MIME-Version: 1.0
References: <CAEzXK1qmYkpHzhbBmYG_Mvk+s6-NAJO-17+VW9fm-=trSZ-v5Q@mail.gmail.com>
 <20200404013233.GA30614@google.com>
In-Reply-To: <20200404013233.GA30614@google.com>
From:   =?UTF-8?B?THXDrXMgTWVuZGVz?= <luis.p.mendes@gmail.com>
Date:   Sat, 4 Apr 2020 22:39:47 +0100
Message-ID: <CAEzXK1pNiy_pjDh_=2XKpKUwEfO39rFubkviZyT_7DqEaQ7z5w@mail.gmail.com>
Subject: Re: Problem with PCIe enumeration of Google/Coral TPU Edge module on Linux
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn,

Thanks again for your help.

Ok... I've tested your theory on this system and still no changes. The
BARs 0 and 1 are still not assigned. I should note that this issue
does not occur only on this particular armhf system, but also on a
Toradex Apalis IMX8QM, which in this case is an arm64 device and
doesn't make use of the mvebu infrastructure.

So I did issue the following commands:
# echo 1 > /sys/bus/pci/devices/0000\:00\:01.0/0000\:01\:00.0/remove
# echo 1 > /sys/bus/pci/devices/0000\:00\:01.0/dev_rescan"

And the dmesg update after the last command is:
[   61.124696] pci 0000:01:00.0: [1ac1:089a] type 00 class 0x0000ff
[   61.124732] pci 0000:01:00.0: reg 0x10: [mem 0x00000000-0x00003fff
64bit pref]
[   61.124743] pci 0000:01:00.0: reg 0x18: [mem 0x00000000-0x000fffff
64bit pref]
[   61.161258] pci_bus 0000:01: __pci_bus_size_bridges
[   61.161270] pci_bus 0000:01: pbus_size_mem: mask 0x2200 type 0x2200
0x2200 0x2200 min 0x0 add 0x0 b_res (null) parent (null)
[   61.161277] pci_bus 0000:01: pbus_size_mem: mask 0x200 type 0x200
0x200 0x200 min 0x0 add 0x0 b_res [mem 0xd0000000-0xd01fffff] parent
[mem 0xd0000000-0xefffffff]
[   61.161281] pci_bus 0000:02: __pci_bus_size_bridges
[   61.161286] pci_bus 0000:02: pbus_size_mem: mask 0x2200 type 0x2200
0x2200 0x2200 min 0x0 add 0x0 b_res (null) parent (null)
[   61.161291] pci_bus 0000:02: pbus_size_mem: mask 0x200 type 0x200
0x200 0x200 min 0x0 add 0x0 b_res [mem 0x00000000] parent (null)
[   61.161295] pci_bus 0000:00: __pci_bus_assign_resources
[   61.161298] pci_bus 0000:00: pbus_assign_resources_sorted
[   61.161302] pci 0000:00:01.0: __dev_sort_resources
[   61.161305] pci 0000:00:02.0: __dev_sort_resources
[   61.161308] __assign_resources_sorted
[   61.161311] pci 0000:00:01.0: __pci_bus_assign_resources
[   61.161314] pci 0000:00:01.0: pdev_assign_fixed_resources
[   61.161317] pci_bus 0000:01: __pci_bus_assign_resources
[   61.161319] pci_bus 0000:01: pbus_assign_resources_sorted
[   61.161323] pci 0000:01:00.0: __dev_sort_resources
[   61.161324] __assign_resources_sorted
[   61.161327] pci 0000:01:00.0: __pci_bus_assign_resources
[   61.161330] pci 0000:01:00.0: pdev_assign_fixed_resources
[   61.161333] pci 0000:00:01.0: PCI bridge to [bus 01]
[   61.161340] pci 0000:00:01.0:   bridge window [mem 0xd0000000-0xd01fffff=
]
[   61.161344] pci 0000:00:02.0: __pci_bus_assign_resources
[   61.161347] pci 0000:00:02.0: pdev_assign_fixed_resources
[   61.161350] pci_bus 0000:02: __pci_bus_assign_resources
[   61.161353] pci_bus 0000:02: pbus_assign_resources_sorted
[   61.161354] __assign_resources_sorted
[   61.161357] pci 0000:00:02.0: PCI bridge to [bus 02]

Lu=C3=ADs

On Sat, Apr 4, 2020 at 2:32 AM Bjorn Helgaas <helgaas@kernel.org> wrote:

>   pci 0000:02:00.0: [10ec:525a] type 00 class 0xff0000
>   pci 0000:02:00.0: reg 0x14: [mem 0x00000000-0x00000fff]
>   pci 0000:02:00.0: BAR 1: assigned [mem 0xf1100000-0xf1100fff]
>   pci 0000:02:00.0: BAR 1: error updating (0xf1100000 !=3D 0xffffffff)
>
> So we correctly detected the device, read the cleared BAR, and
> allocated space for it, and tried to update the BAR.  On my system the
> update failed, I think because of a power management issue (all config
> reads now return 0xffffffff).  But there have been a lot of power
> management fixes since the v5.2 kernel I'm running, so it's possible
> you'd have better luck.
>
> On your system, I think you would want something like:
>
>   # echo 1 > /sys/devices/pci0000:00/0000:00:01.0/0000:01:00.0/remove
>   # echo 1 > /sys/devices/pci0000:00/0000:00:01.0/rescan
>
