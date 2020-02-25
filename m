Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D24ED16B622
	for <lists+linux-pci@lfdr.de>; Tue, 25 Feb 2020 01:00:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728493AbgBYAAs (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 24 Feb 2020 19:00:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:35742 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728087AbgBYAAr (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 24 Feb 2020 19:00:47 -0500
Received: from localhost (mobile-166-175-186-165.mycingular.net [166.175.186.165])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 02E512072D;
        Tue, 25 Feb 2020 00:00:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582588847;
        bh=gwS/i+DWi3hdA8lPEyvHJTerkxuBZv1xV2gPBKS2M5w=;
        h=Date:From:To:Cc:Subject:From;
        b=g9eLU5CbKhXJP4dy9vd1i8Akt4dC2/E0I6fCfPKpy4QlwiNDvCy7WUN4XxdH/cORF
         Z9Eygk0MUX1d2RxZ4QthQ1d/E3aQ+ye7GYqdYubR20HGUlAWRBGQAKqQQTTI8NfwE1
         zajmtbaYj2Ba25NKvNx/2/wBGo9Jp/reAZ/usTHI=
Date:   Mon, 24 Feb 2020 18:00:45 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     linux-pci@vger.kernel.org
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        email-ext@laposte.net
Subject: [bugzilla-daemon@bugzilla.kernel.org: [Bug 206657] New: Lenovo C940
 freeze during Thunderbolt3 dock connection/disconnection unless plugged
 before boot]
Message-ID: <20200225000045.GA153739@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

----- Forwarded message from bugzilla-daemon@bugzilla.kernel.org -----

Date: Mon, 24 Feb 2020 20:55:05 +0000
From: bugzilla-daemon@bugzilla.kernel.org
To: bjorn@helgaas.com
Subject: [Bug 206657] New: Lenovo C940 freeze during Thunderbolt3 dock
	connection/disconnection unless plugged before boot
Message-ID: <bug-206657-41252@https.bugzilla.kernel.org/>

https://bugzilla.kernel.org/show_bug.cgi?id=206657

            Bug ID: 206657
           Summary: Lenovo C940 freeze during Thunderbolt3 dock
                    connection/disconnection unless plugged before boot
           Product: Drivers
           Version: 2.5
    Kernel Version: 5.6-rc2
          Hardware: All
                OS: Linux
              Tree: Mainline
            Status: NEW
          Severity: normal
          Priority: P1
         Component: PCI
          Assignee: drivers_pci@kernel-bugs.osdl.org
          Reporter: email-ext@laposte.net
        Regression: No

Created attachment 287591
  --> https://bugzilla.kernel.org/attachment.cgi?id=287591&action=edit
Dmesg log when disconnecting dock

Hello,

I have a Lenovo C940 under Manjaro with unstable packages and Kernel 5.6-rc2
using a OWC Thunderbolt3 dock. If I connect the dock before boot, it will work
correctly. However, if a connect/disconnect it after boot it won't be recognize
and will lead soon after to system crash. The gnome icons start to disappear
and when using commands on terminal input/output failure errors appear.

I found another bug which seems related to mine, but in my case it leads to
system crash:
https://bugzilla.kernel.org/show_bug.cgi?id=206459. 

I am encountering another problem with USB-C drive on thunderbolt3 ports
working if connected before boot and not otherwise. But without leading to
system crash:
https://bugzilla.kernel.org/show_bug.cgi?id=206649

I joined dmesg where disconnection starts at time 185 with some errors occuring
just after like:
[  184.038519] usb usb6: USB disconnect, device number 1
[  184.038523] usb 6-3: USB disconnect, device number 2
[  184.167256] usb 5-4: Not enough bandwidth for altsetting 1
[  184.167260] usb 5-4: 1:1: usb_set_interface failed (-19)

Also the journalctl shows some errors:

fév 23 17:55:06 pc-de-user kernel: usb usb6: USB disconnect, device number 1
fév 23 17:55:06 pc-de-user kernel: usb 6-3: USB disconnect, device number 2
fév 23 17:55:06 pc-de-user kernel: usb 5-4: Not enough bandwidth for altsetting
1
fév 23 17:55:06 pc-de-user kernel: usb 5-4: 1:1: usb_set_interface failed (-19)

Then the system crashes showing "input/output failures" just by using some
commands like "ls" or "cat".

-- 
You are receiving this mail because:
You are watching the assignee of the bug.

----- End forwarded message -----
