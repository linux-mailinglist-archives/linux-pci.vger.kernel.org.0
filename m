Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 66EEFCFF12
	for <lists+linux-pci@lfdr.de>; Tue,  8 Oct 2019 18:42:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726320AbfJHQmf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 8 Oct 2019 12:42:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:59420 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726138AbfJHQmf (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 8 Oct 2019 12:42:35 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 585F721721;
        Tue,  8 Oct 2019 16:42:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570552954;
        bh=dfD/LccKHp0lGS2CMziU/zHzVg9aO+PkYE7XNdSLakQ=;
        h=Date:From:To:Cc:Subject:From;
        b=p98flAXeCXBQgLiZzJetRTH7+rIT/X/w9J+8l1LGifrT06NcN1WlGQJTEBskih8JV
         tO5s4//CUpV+fzL5jYZBnm3Tj3vGfvqoRYoSpBn5HuHHX00pF1+pTatL/9+6/uB5ab
         qYolDYY7sVvYpCIF8jQ23Y/YlaVAHBjtRubvqhoQ=
Date:   Tue, 8 Oct 2019 11:42:32 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     linux-pci@vger.kernel.org
Cc:     Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        AceLan Kao <acelan@gmail.com>
Subject: [bugzilla-daemon@bugzilla.kernel.org: [Bug 205119] New: It takes
 long time to wake up from s2idle on Dell XPS 7390 2-in-1]
Message-ID: <20191008164232.GA173643@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

AceLan, do you know if this is a regression and if so, when it was
introduced?

----- Forwarded message from bugzilla-daemon@bugzilla.kernel.org -----

Date: Tue, 08 Oct 2019 02:56:27 +0000
From: bugzilla-daemon@bugzilla.kernel.org
To: bjorn@helgaas.com
Subject: [Bug 205119] New: It takes long time to wake up from s2idle on Dell
	XPS 7390 2-in-1
Message-ID: <bug-205119-41252@https.bugzilla.kernel.org/>

https://bugzilla.kernel.org/show_bug.cgi?id=205119

            Bug ID: 205119
           Summary: It takes long time to wake up from s2idle on Dell XPS
                    7390 2-in-1
           Product: Drivers
           Version: 2.5
    Kernel Version: 5.4-rc2
          Hardware: All
                OS: Linux
              Tree: Mainline
            Status: NEW
          Severity: normal
          Priority: P1
         Component: PCI
          Assignee: drivers_pci@kernel-bugs.osdl.org
          Reporter: acelan@gmail.com
        Regression: No

Created attachment 285395
  --> https://bugzilla.kernel.org/attachment.cgi?id=285395&action=edit
dmesg log

1. Enter s2idle at 28.39s
2. Press power button at 246.10s
3. The machine stuck until 412.30s and spit out thunderbolt warning messages
4. thunderbolt port keeps working after s2idle, plug-in Dell WD19TB
dock(472.45s), and the "boltctl list" shows the dock info correctly.

BTW, I also found that there are 2 tbt ports on the machine, and if I plug in
one TBT dock, and the wakeup time could be reduced by 80 seconds. And if I plug
in 2 docks in both TBT ports, the machine wakes up from s2idle quick enough as
the normal system.

I believe the 2 lines are related.
[  330.388604] thunderbolt 0000:00:0d.3: failed to send driver ready to ICM
[  412.308083] thunderbolt 0000:00:0d.2: failed to send driver ready to ICM

-- 
You are receiving this mail because:
You are watching the assignee of the bug.

----- End forwarded message -----
