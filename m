Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C86EA161D35
	for <lists+linux-pci@lfdr.de>; Mon, 17 Feb 2020 23:16:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726069AbgBQWQi (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 17 Feb 2020 17:16:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:46322 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725966AbgBQWQi (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 17 Feb 2020 17:16:38 -0500
Received: from localhost (mobile-166-175-186-165.mycingular.net [166.175.186.165])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DBD792072C;
        Mon, 17 Feb 2020 22:16:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581977797;
        bh=Wa3oMCbR6JOT61299277MzPIraBqpzZLGf9/ONDtbD0=;
        h=Date:From:To:Cc:Subject:From;
        b=ntdSpJceuJSgpwTK1K8pcJANPmqUDciWlYcFq74aipHqDJeSypsxWkclBVWaIRcJm
         OfVwJO25zGz6qGaSSSorSO0YppsEibtYoSDnOrlSvCJMXncHaaBU6/X5jd+3d05hJ0
         DeAF7iMDjYLAGWEF8rcBwxP9g3Hr+wAWncuzO5Fw=
Date:   Mon, 17 Feb 2020 16:16:35 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     linux-pci@vger.kernel.org
Cc:     Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: [bugzilla-daemon@bugzilla.kernel.org: [Bug 206459] New: thinkpad
 thunderbolt 3 dock gen2 pci memory allocation errors on Yoga C940 unless
 plugged in before boot]
Message-ID: <20200217221635.GA30914@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

----- Forwarded message from bugzilla-daemon@bugzilla.kernel.org -----

Date: Fri, 07 Feb 2020 19:52:30 +0000
From: bugzilla-daemon@bugzilla.kernel.org
To: bjorn@helgaas.com
Subject: [Bug 206459] New: thinkpad thunderbolt 3 dock gen2 pci memory
	allocation errors on Yoga C940 unless plugged in before boot
Message-ID: <bug-206459-41252@https.bugzilla.kernel.org/>

https://bugzilla.kernel.org/show_bug.cgi?id=206459

            Bug ID: 206459
           Summary: thinkpad thunderbolt 3 dock gen2 pci memory allocation
                    errors on Yoga C940 unless plugged in before boot
           Product: Drivers
           Version: 2.5
    Kernel Version: 5.5.2
          Hardware: Intel
                OS: Linux
              Tree: Mainline
            Status: NEW
          Severity: normal
          Priority: P1
         Component: PCI
          Assignee: drivers_pci@kernel-bugs.osdl.org
          Reporter: benoitg@coeus.ca
        Regression: No

Created attachment 287231
  --> https://bugzilla.kernel.org/attachment.cgi?id=287231&action=edit
acpidump

I have thinkpad thunderbolt 3 dock gen2 dock I am trying to use with a New
Lenovo Yoga C940-14IIL laptop.  Laptop is very recent hardware, with a 10th gen
intel cpu, and a bios with very few options :(

- The dock works fine when plugged-in before boot.
- The dock does NOT work when plugged after the system booted.
- The dock does NOT work when plugged-in at boot, subsequently unplugged and
plugged back in.
- The dock work fine in windows, in all the above scenarios

When it fails, it fails with memory allocation messages such as:

[ 342.507320] pci 0000:2b:00.0: BAR 14: no space for [mem size 0x0c200000]
[ 342.507323] pci 0000:2b:00.0: BAR 14: failed to assign [mem size 0x0c200000]

Things I tried:
- Ubuntu kernel 5.3.0-26, same symptoms
- Kernel mainline 5.4.12, same symptoms
- Kernel mainline 5.5.2, same symptoms, but gets a little further allocating
memory on the second pass.
- Plugging the dock after powering up the laptop, but at the grub screen before
boot. In this case the dock works fine after boot.

Other potentially useful information to narrow it down:

- The tests were done with only an ethernet cable and power plugged into the
dock to minimize the number of moving parts...

- Dock and laptop both have the very latest firmware as of 2020-02-07
cat /sys/bus/thunderbolt/devices/0-0/nvm_version
72.0
cat /sys/bus/thunderbolt/devices/0-3/nvm_version
50.0

- Unfortunately I cannot procure older firmware for the dock to know if the
laptop or the dock is the source of the problem (As this dock was released over
a year ago, and I cannot find any specific relevant problems with Linux)

- The screens connected to the displayports on the dock always work. But but
all other ports (USB, ethernet, sound fail) when plugged-in after boot.

- Doesn't seem to be a thunderbolt authorization problem:
tbtadm devices 
0-3     Lenovo  ThinkPad Thunderbolt 3 Dock     authorized      not in ACL

Originally reported to ubuntu in:
https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1860284

-- 
You are receiving this mail because:
You are watching the assignee of the bug.

----- End forwarded message -----
