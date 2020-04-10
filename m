Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E45581A481B
	for <lists+linux-pci@lfdr.de>; Fri, 10 Apr 2020 18:01:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726626AbgDJQAv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 10 Apr 2020 12:00:51 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:57670 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726725AbgDJQAv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 10 Apr 2020 12:00:51 -0400
Received: from 185.80.35.16 (185.80.35.16) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.415)
 id 08258914799ae752; Fri, 10 Apr 2020 18:00:49 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PM <linux-pm@vger.kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>
Cc:     Linux ACPI <linux-acpi@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Hans De Goede <hdegoede@redhat.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 0/7] PM: sleep: core: Rearrange the handling of driver power management flags
Date:   Fri, 10 Apr 2020 17:46:27 +0200
Message-ID: <1888197.j9z7NJ8yPn@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Alan,

Following our recent discussion regarding the DPM_FLAG_* family of flags [1],
I have decided to follow some of your recommendations and make changes to the
core code handling those flags.

The purpose of this is basically to make the code more consistent internally,
easier to follow and better documented.

First of all, patch [1/7] changes the PM core to skip driver-level "late"
and "noirq" suspend callbacks for devices with SMART_SUSPEND set if they are
still runtime-suspended during the "late" system-wide suspend phase (without
the patch it does that only if subsystem-level late/noirq/early suspend/resume
callbacks are not present for the device, which is demonstrably inconsistent)
and updates the resume part of the code accordingly (it doesn't need to check
whether or not the subsystem-level callbacks are present any more).

The next patch, [2/7], is purely cosmetic and its only purpose is to reduce
the LOC number and move related pieces of code closer to each other.

Patch [3/7] changes the PM core so that it doesn't skip any subsystem-level
callbacks during system-wide resume (without the patch they may be skipped in
the "early resume" and "resume" phases due to LEAVE_SUSPENDED being set which
may be problematic) and to always run the driver's ->resume callback if the
corresponding subsystem-level callback is not present (without the patch it
may be skipped if LEAVE_SUSPENDED is set) to let it reverse the changes made
by the driver's ->suspend callback (which always runs too) if need be.

Patches [4-6/7] rename one function in the PM core and two driver PM flags to
make their names better reflect their purpose.

Finally, patch [7/7] updates the documentation of the driver PM flags to
reflect the new code flows.

This patch series have been available in the git branch at

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 pm-sleep-core

for easier web and git access.

Cheers!


[1] https://lore.kernel.org/linux-pm/Pine.LNX.4.44L0.2003251631360.1724-100000@netrider.rowland.org/



