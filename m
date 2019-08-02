Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4EEA58028A
	for <lists+linux-pci@lfdr.de>; Sat,  3 Aug 2019 00:08:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729540AbfHBWIT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 2 Aug 2019 18:08:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:40350 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726781AbfHBWIT (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 2 Aug 2019 18:08:19 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 830912087C;
        Fri,  2 Aug 2019 22:08:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564783697;
        bh=bJSkPBWAvI7uWMOqOTnD/uGDiwHKAHKRoxZ6f+pu34I=;
        h=Date:From:To:Cc:Subject:From;
        b=lg9bbtBq8CgCiKO0bk9yrn/pC59FH7cEnGpR9n8ugs+lBgTyp16BLULz/RJA42ZBR
         3l5iK4RnfMd0oxRM/SRG6iqZzOPNvLU7A/zShQT3hDgSvVid5RsZ/v8tv5meY4YUcm
         h1fM8620xK3U/NNtPaYmYjeLuRjJMcuJyLN2/gn8=
Date:   Fri, 2 Aug 2019 17:08:16 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     linux-pci@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Matthias Andree <matthias.andree@gmx.de>
Subject: [bugzilla-daemon@bugzilla.kernel.org: [Bug 204413] New: "PCI: Add
 missing link delays" causes regression on resume from suspend to ram]
Message-ID: <20190802220816.GM151852@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Mika, Rafael, linux-pci]

Hi Matthias,

Thanks a lot for this report!

Mika, this bisected to upstream c2bf1fc212f7 ("PCI: Add missing link
delays required by the PCIe spec").

Matthias, would you mind opening a separate report for the spurious
PME issue you mentioned with 5.2.5?  Seems like we should try to
figure that one out, too.


----- Forwarded message from bugzilla-daemon@bugzilla.kernel.org -----

Date: Fri, 02 Aug 2019 16:26:45 +0000
From: bugzilla-daemon@bugzilla.kernel.org
To: bugzilla.pci@gmail.com
Subject: [Bug 204413] New: "PCI: Add missing link delays" causes regression on resume from suspend to ram
Message-ID: <bug-204413-193951@https.bugzilla.kernel.org/>

https://bugzilla.kernel.org/show_bug.cgi?id=204413

            Bug ID: 204413
           Summary: "PCI: Add missing link delays" causes regression on
                    resume from suspend to ram
           Product: Drivers
           Version: 2.5
    Kernel Version: 5.1.20, 5.2.5, 5.3-rc1?
          Hardware: All
                OS: Linux
              Tree: Mainline
            Status: NEW
          Severity: normal
          Priority: P1
         Component: PCI
          Assignee: drivers_pci@kernel-bugs.osdl.org
          Reporter: matthias.andree@gmx.de
        Regression: Yes

Description of problem:
vanilla 5.1.20 on x86_64 fails to wake from suspend (STR),
Fedora and vanilla 5.1.19 and prior were fine. 
5.2.5 (from Fedora's-200.fc30) also fails in a different way (spurious PME
interrupts on pcie).

How reproducible:
always

Steps to Reproduce:
1. boot Fedora 30 and log into GNOME desktop
2. click pause symbol to suspend the computer to RAM, wait until suspended
3. press key on keyboard, or power button

Actual results:
computer tries to wake up, HDD LED blinks a bit, but console does not wake.
Other computer on network cannot ping the waking computer.

"sync" hangs in D deep sleep for long amounts of time. 

Expected results:
computer wakes up properly and continues to use its devices.

Additional info:
PM tracing was enabled, the next boot returned
[    0.827930] PM:   hash matches drivers/base/power/main.c:1021

It appears that suspend to disk still works.

Computer has an NVIDIA GeForce 1060 PCIe graphics board, but 5.1.19 and prior
would suspend properly, and the 5.1.20 and 5.2.5 suspend issues also occur if
nvidia kernel modules are renamed out of the way and nouveau remains blocked,
so it's not an nvidia driver issue.

I have "git bisect"ed this on the vanilla stable kernel, the stable/linux-5.1.y
branch (because I have had starting points 5.1.19 and 5.1.20 there).
The failure-inducing commit on the branch is
3c795a8e3481e4dec071b5956e7177e816f6e7f1 (see below), which got picked from 
master's c2bf1fc212f7e6f25ace1af8f0b3ac061ea48ba5, (merged through
cf2d213e49fdf47e4c10dc629a3659e0026a54b8, v5.3-rc1~167)
and also got picked to stable/linux-5.2.y
5817d78eba34f6c86f5462ae2c5212f80a013357 (v5.2.3~291).

Sasha Levin's signoff is only on the stable branches, not on master.

------------------------------------------------------------
commit 3c795a8e3481e4dec071b5956e7177e816f6e7f1 (refs/bisect/bad)
Author: Mika Westerberg <mika.westerberg@linux.intel.com>  2019-06-12 12:57:38
Committer: Greg Kroah-Hartman <gregkh@linuxfoundation.org>  2019-07-26 09:12:37
Parent: 70cc29dba925b8a99a4917c2b5fa6702d0d496d1 (bpf: fix callees pruning
callers)
Child:  a98c15177f72ae3c0a736bb324e66c279bf94899 (net: netsec: initialize tx
ring on ndo_open)
Branch: remotes/stable/linux-5.1.y
Follows: v5.1.19
Precedes: v5.1.20

    PCI: Add missing link delays required by the PCIe spec

    [ Upstream commit c2bf1fc212f7e6f25ace1af8f0b3ac061ea48ba5 ]

    Currently Linux does not follow PCIe spec regarding the required delays
    after reset. A concrete example is a Thunderbolt add-in-card that
    consists of a PCIe switch and two PCIe endpoints:

      +-1b.0-[01-6b]----00.0-[02-6b]--+-00.0-[03]----00.0 TBT controller
                                      +-01.0-[04-36]-- DS hotplug port
                                      +-02.0-[37]----00.0 xHCI controller
                                      \-04.0-[38-6b]-- DS hotplug port

    The root port (1b.0) and the PCIe switch downstream ports are all PCIe
    gen3 so they support 8GT/s link speeds.

    We wait for the PCIe hierarchy to enter D3cold (runtime):

      pcieport 0000:00:1b.0: power state changed by ACPI to D3cold

    When it wakes up from D3cold, according to the PCIe 4.0 section 5.8 the
    PCIe switch is put to reset and its power is re-applied. This means that
    we must follow the rules in PCIe 4.0 section 6.6.1.
[...]
    Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
    Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
    Signed-off-by: Sasha Levin <sashal@kernel.org>

 drivers/pci/pci.c               | 29 +++++++++++++++++++----------
 drivers/pci/pci.h               |  1 +
 drivers/pci/pcie/portdrv_core.c | 66
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 86 insertions(+), 10 deletions(-)

-- 
You are receiving this mail because:
You are watching the assignee of the bug.

----- End forwarded message -----
