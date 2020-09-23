Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E10A32760AC
	for <lists+linux-pci@lfdr.de>; Wed, 23 Sep 2020 21:00:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726498AbgIWTAs (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 23 Sep 2020 15:00:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:43822 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726419AbgIWTAs (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 23 Sep 2020 15:00:48 -0400
Received: from localhost (52.sub-72-107-123.myvzw.com [72.107.123.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 26916206FB;
        Wed, 23 Sep 2020 19:00:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600887647;
        bh=DWKaOatx9qcRZRRk4/D4mmrJ4HFrAX3SWBpB8qkbAJQ=;
        h=Date:From:To:Cc:Subject:From;
        b=rofC+2Bu7AD8FfwhwZK7SsrUp45MsLmPM4xBNOm963s/GkIVciY1EWSKMqFsajxfm
         taIQ4HNoQix2SsFCtaA55QEwtO0zZBKSoDBnsw0OWk1yR6GBr5n57ZM1+B6+Rr05FD
         +k65Le+tTjhUoPAu7ZsNw/m2ge/zYPBINFXWgL7Q=
Date:   Wed, 23 Sep 2020 14:00:45 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     linux-pci@vger.kernel.org
Cc:     "David E. Box" <david.e.box@linux.intel.com>,
        Jonathan Yong <jonathan.yong@intel.com>,
        Len Brown <lenb@kernel.org>
Subject: [bugzilla-daemon@bugzilla.kernel.org: [Bug 209361] New: PTMControl
 Enabled blocks Low Power Idle in 5% of s2idle attempts - Dell XPS-13 9300
 Ice Lake]
Message-ID: <20200923190045.GA2285394@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

----- Forwarded message from bugzilla-daemon@bugzilla.kernel.org -----

Date: Wed, 23 Sep 2020 15:22:47 +0000
From: bugzilla-daemon@bugzilla.kernel.org
To: bjorn@helgaas.com
Subject: [Bug 209361] New: PTMControl Enabled blocks Low Power Idle in 5% of
	s2idle attempts - Dell XPS-13 9300 Ice Lake
Message-ID: <bug-209361-41252@https.bugzilla.kernel.org/>

https://bugzilla.kernel.org/show_bug.cgi?id=209361

            Bug ID: 209361
           Summary: PTMControl Enabled blocks Low Power Idle in 5% of
                    s2idle attempts - Dell XPS-13 9300 Ice Lake
           Product: Drivers
           Version: 2.5
    Kernel Version: 5.9-rc5
          Hardware: All
                OS: Linux
              Tree: Mainline
            Status: NEW
          Severity: normal
          Priority: P1
         Component: PCI
          Assignee: drivers_pci@kernel-bugs.osdl.org
          Reporter: lenb@kernel.org
        Regression: No

System: Dell XPS-13 9300, Intel(R) Core(TM) i7-1065G7

Up through Linux 5.9-rc5, this system will typically get very good residency
in Low-Power-Idle upon s2idle.  But on 5% of attempts, it gets ZERO
residency in low-power-idle.

I have confirmed that this does not change if the time sleeping
is extended, or the time between experiments is extended.

David Box suggested disabling PTM.
Doing so resulted -- for the first time --
the system entering LPI on s2idle 100% of s2idle attempts
(770 attempts over 8 hours)

~/bin/pci_write8 0 0x1d 0 0x158 0
~/bin/pci_write8 0 0x1d 7 0x158 0

is what I used to disable PTM on my system
(write a 0, where pci_read8 previously showed the value 3)

This change is visible in the output of lspci as for both bridges:

< PTMControl: Enabled:+ RootSelected:+
> PTMControl: Enabled:- RootSelected:-

-- 
You are receiving this mail because:
You are watching the assignee of the bug.

----- End forwarded message -----
