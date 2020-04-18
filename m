Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22B181AF2A4
	for <lists+linux-pci@lfdr.de>; Sat, 18 Apr 2020 19:12:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727936AbgDRRMK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 18 Apr 2020 13:12:10 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:61994 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727883AbgDRRMA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 18 Apr 2020 13:12:00 -0400
Received: from 185.80.35.16 (185.80.35.16) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.415)
 id e15ac2bf6ca7d3cf; Sat, 18 Apr 2020 19:11:57 +0200
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
Subject: [PATCH v2 0/9] PM: sleep: core: Rearrange the handling of driver power management flags
Date:   Sat, 18 Apr 2020 18:23:08 +0200
Message-ID: <5673945.BT02kTCndr@kreacher>
In-Reply-To: <1888197.j9z7NJ8yPn@kreacher>
References: <1888197.j9z7NJ8yPn@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

This is an update including some fixes and extra patches based on the
continuation of the discussion [1].

On Friday, April 10, 2020 5:46:27 PM CEST Rafael J. Wysocki wrote:
> Hi Alan,
> 
> Following our recent discussion regarding the DPM_FLAG_* family of flags [1],
> I have decided to follow some of your recommendations and make changes to the
> core code handling those flags.
> 
> The purpose of this is basically to make the code more consistent internally,
> easier to follow and better documented.
> 
> First of all, patch [1/7] changes the PM core to skip driver-level "late"
> and "noirq" suspend callbacks for devices with SMART_SUSPEND set if they are
> still runtime-suspended during the "late" system-wide suspend phase (without
> the patch it does that only if subsystem-level late/noirq/early suspend/resume
> callbacks are not present for the device, which is demonstrably inconsistent)
> and updates the resume part of the code accordingly (it doesn't need to check
> whether or not the subsystem-level callbacks are present any more).
> 
> The next patch, [2/7], is purely cosmetic and its only purpose is to reduce
> the LOC number and move related pieces of code closer to each other.

The first two patches have not changed.

> Patch [3/7] changes the PM core so that it doesn't skip any subsystem-level
> callbacks during system-wide resume (without the patch they may be skipped in
> the "early resume" and "resume" phases due to LEAVE_SUSPENDED being set which
> may be problematic) and to always run the driver's ->resume callback if the
> corresponding subsystem-level callback is not present (without the patch it
> may be skipped if LEAVE_SUSPENDED is set) to let it reverse the changes made
> by the driver's ->suspend callback (which always runs too) if need be.

The difference between this one and patch [3/9] in the v2 is the fixed
definition of dev_pm_may_skip_resume(), renamed to dev_pm_skip_resume() by
one of the next patches.

Patch [4/9] changes the handling of the power.may_skip_resume flag to set it
to 'true' by default and updates the subsystems aware of it to clear it when
they don't want devices to stay in suspend.

> Patches [4-6/7] rename one function in the PM core and two driver PM flags to
> make their names better reflect their purpose.

These are patches [5/9] and [7-8/9] in the v2 and patch [6/9] renames
dev_pm_smart_suspend_and_suspended() to dev_pm_skip_suspend().

> Finally, patch [7/7] updates the documentation of the driver PM flags to
> reflect the new code flows.

This patch [9/9] now and it has been updated to reflect the new code changes.

The pm-sleep-core branch:

  git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
  pm-sleep-core

contains the v2 now.

Cheers!


[1] https://lore.kernel.org/linux-pm/Pine.LNX.4.44L0.2003251631360.1724-100000@netrider.rowland.org/



