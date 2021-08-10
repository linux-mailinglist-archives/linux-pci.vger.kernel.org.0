Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B6143E85A1
	for <lists+linux-pci@lfdr.de>; Tue, 10 Aug 2021 23:47:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234645AbhHJVsF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 10 Aug 2021 17:48:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:51542 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234388AbhHJVsE (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 10 Aug 2021 17:48:04 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id F30386056B;
        Tue, 10 Aug 2021 21:47:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628632062;
        bh=wfH6ldLowlDtWjigLrVOdUDg6tP64KWTHklxRYd4VT8=;
        h=Date:From:To:Cc:Subject:From;
        b=GZ9n0zErFuZI5rGZsQV0RqkxJmu6XYnn1jrGAjamTtHqATbOz/3SyQZhaXmfMuxV1
         5zFn53aBL/AshPCVmCkuN3Vfv01ue+/RHqdV23ufnGwjn/o5vcT2H1RoXLxn/BdBUv
         cdI5SQkQfVKjDT3ZtqetGvw055ipjICgAHt+OFwKAPVmLRVBtT1u3zO52+qenoGm81
         FE2tZnt5eDRp2kztz63PiqawFfDqLkMwLCdijSUpmwB1ES57k2LZJJD40r32+nW/mW
         yBXiWLa8kcqeUcs+yEVd/ZK2XBgQBS0X7WsrCZuUtzTb0I3ZUL1JUD97XvmmtaXRqY
         Q/PmuoRi+Pdkw==
Date:   Tue, 10 Aug 2021 16:47:40 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     linux-pci@vger.kernel.org
Cc:     Sam Edwards <CFSworks@gmail.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org
Subject: [bugzilla-daemon@bugzilla.kernel.org: [Bug 214025] New: Better error
 message for PCI devices killed during boot?]
Message-ID: <20210810214740.GA2306774@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Rafael, linux-pci, linux-pm]

Sorry for the trouble this caused you, and thanks for the report.

I completely agree that these messages are not really useful to users.
After all your troubleshooting, were you able to do something to make
the NVMe device usable?

You mention ACPI powering off the device between PCI enumeration and
the driver's probe method.  Did you open a bug report about that, too?
I think we might need to explore that situation to resolve this.

The "config space inaccessible" message comes from
pci_raw_set_power_state(), and it means we got ~0 when reading the
Power Management Control/Status register.  That's not a valid value,
so I assume the device was in D3cold, where it can't respond to config
reads.

The fact that we enumerated the device means it was in at least D3hot,
where it *can* respond to config reads.  PCI cannot put a device into
D3cold directly; only ACPI or similar platform code can do that.

----- Forwarded message from bugzilla-daemon@bugzilla.kernel.org -----

Date: Tue, 10 Aug 2021 17:27:17 +0000
From: bugzilla-daemon@bugzilla.kernel.org
To: bjorn@helgaas.com
Subject: [Bug 214025] New: Better error message for PCI devices killed during
	boot?
Message-ID: <bug-214025-41252@https.bugzilla.kernel.org/>

https://bugzilla.kernel.org/show_bug.cgi?id=214025

            Bug ID: 214025
           Summary: Better error message for PCI devices killed during
                    boot?
           Product: Drivers
           Version: 2.5
    Kernel Version: 5.13.8
          Hardware: All
                OS: Linux
              Tree: Mainline
            Status: NEW
          Severity: low
          Priority: P1
         Component: PCI
          Assignee: drivers_pci@kernel-bugs.osdl.org
          Reporter: CFSworks@gmail.com
        Regression: No

Hello,

I recently finished troubleshooting an issue where some NVMe SSD on the PCIe
bus wasn't being initialized by the driver; the kernel log contained:

pci 0000:02:00.0: CLS mismatch (64 != 1020), using 64 bytes
...
nvme 0000:02:00.0: can't change power state from D3hot to D0 (config space
inaccessible)

The problem (which deserves its own bug report) was that ACPI initialization
was powering off the device between the time the PCI bus was scanned and the
time the driver was probing the device. The CLS value of 1020 came from the
register being read as 0xFF (255*4 = 1020) due to the config space being
inaccessible. However, to a user who doesn't have full intuition about PCI,
neither of these messages is particularly clear about what's really happening.

I'd have expected a (WARN/ERR) message saying something more like, "pci
0000:02:00.0: device has unexpectedly disappeared from the bus; removing"
implemented either as a check right before driver probing or at key stages of
the PCI device fixup process (such as when computing CLS). This check is
probably not necessary for hotplugged devices, since major platform power
management initialization won't happen between the hotplug event and driver
binding, but I strongly believe it's appropriate at boot when other subsystems
are liable to interfere with PCI devices.

An alternative to removing the device would be to keep it present in sysfs but
put it in some other state (D3cold?) and hold off on trying to bind the driver.
This hopefully increases the chance that the user sees that the device is
present but in an unusual state.

Thoughts?

-- 
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.

----- End forwarded message -----
