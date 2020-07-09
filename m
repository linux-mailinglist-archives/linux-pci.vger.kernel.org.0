Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 342B421A7A2
	for <lists+linux-pci@lfdr.de>; Thu,  9 Jul 2020 21:17:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726215AbgGITRZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 9 Jul 2020 15:17:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:48078 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726116AbgGITRY (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 9 Jul 2020 15:17:24 -0400
Received: from localhost (mobile-166-175-191-139.mycingular.net [166.175.191.139])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 03BF82078B;
        Thu,  9 Jul 2020 19:17:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594322244;
        bh=yzF+W3NuN5vHb++Eg1LQozRb7Fnun3QKYsoWUnQhzUE=;
        h=Date:From:To:Cc:Subject:From;
        b=gCdmvTrnzGIBRoy4hFgZ+BfEmqkT/cSJ/Bu1ILlPEUpcyxKfT1McFFER3/97eUY9k
         EQU7VL7vbC1FrjAlSQenhcPoaNZfw+jqLXei6s5ihxh/sGCcOCVgOIGUEPehnnxZig
         dFXI9Ud4J74JkiJKle4uF7vVODVTwYXy7t7GAHh4=
Date:   Thu, 9 Jul 2020 14:17:22 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Sean V Kelley <sean.v.kelley@linux.intel.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Berni <bernhard@turmann.eu>
Subject: [bugzilla-daemon@bugzilla.kernel.org: [Bug 208507] New: BISECTED:
 i2c timeout loading module ddbridge with commit
 d2345d1231d80ecbea5fb764eb43123440861462]
Message-ID: <20200709191722.GA6054@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Bisected to Debian commit d2345d1231d8, which is a backport of the
upstream commit b88bf6c3b6ff ("PCI: Add boot interrupt quirk mechanism
for Xeon chipsets").

Reporter confirmed that reverting the Debian backport from 4.19.132
fixes the problem.

----- Forwarded message from bugzilla-daemon@bugzilla.kernel.org -----

Date: Thu, 09 Jul 2020 15:01:11 +0000
From: bugzilla-daemon@bugzilla.kernel.org
To: bjorn@helgaas.com
Subject: [Bug 208507] New: BISECTED: i2c timeout loading module ddbridge with
	commit d2345d1231d80ecbea5fb764eb43123440861462
Message-ID: <bug-208507-41252@https.bugzilla.kernel.org/>

https://bugzilla.kernel.org/show_bug.cgi?id=208507

            Bug ID: 208507
           Summary: BISECTED: i2c timeout loading module ddbridge with
                    commit d2345d1231d80ecbea5fb764eb43123440861462
           Product: Drivers
           Version: 2.5
    Kernel Version: 4.19.132
          Hardware: x86-64
                OS: Linux
              Tree: Mainline
            Status: NEW
          Severity: normal
          Priority: P1
         Component: PCI
          Assignee: drivers_pci@kernel-bugs.osdl.org
          Reporter: bernhard@turmann.eu
        Regression: Yes

Created attachment 290179
  --> https://bugzilla.kernel.org/attachment.cgi?id=290179&action=edit
dmesg on 4.19.132

OS: Debian 10.4 Buster
CPU: Intel(R) Xeon(R) CPU D-1541 @ 2.10GHz
Hardware: Supermicro  Super Server
Mainboard: Supermicro X10SDV
DVB card: Digital Devices Cine S2 V7 Advanced DVB adapter

Issue:
=====
Loading kernel module ddbridge fails with i2c timeouts, see attached dmesg. The
dvb media adapter is unusable.
This happened after Linux kernel upgrade from 4.19.98-1+deb10u1 to
4.19.118-2+deb10u1.

A git bisect based on the Debian kernel repo on branch buster identified as
first bad commit: [1fb0eb795661ab9e697c3a053b35aa4dc3b81165] Update to
4.19.116.

Another git bisect based on upstream Linux kernel repo on branch v4.19.y
identified as first bad commit: [d2345d1231d80ecbea5fb764eb43123440861462] PCI:
Add boot interrupt quirk mechanism for Xeon chipsets.

Other affected Debian kernel version: 5.6.14+2~bpo10+1
I tested this version via buster-backports, because so far I was unable to
build my own kernel from 5.6.y or even 5.7.y.

Workaround:
==========
Reverting the mentioned commit d2345d1231d80ecbea5fb764eb43123440861462 on top
of 4.19.132 is fixing the problem. Reverting the same commit on 4.19.118 or
4.19.116 is also fixing the problem.

It seems, I can only add one attachment now, so I will add more attachments
later after bug is submitted.

Thanks and Regards
Berni

-- 
You are receiving this mail because:
You are watching the assignee of the bug.

----- End forwarded message -----
