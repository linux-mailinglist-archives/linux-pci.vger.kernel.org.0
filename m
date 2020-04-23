Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA4411B618E
	for <lists+linux-pci@lfdr.de>; Thu, 23 Apr 2020 19:07:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729842AbgDWRHV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 23 Apr 2020 13:07:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:48938 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729840AbgDWRHV (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 23 Apr 2020 13:07:21 -0400
Received: from localhost (mobile-166-175-187-210.mycingular.net [166.175.187.210])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3E0BB2076C;
        Thu, 23 Apr 2020 17:07:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587661640;
        bh=yw9wJXzgI852NvRxPmOyJyXU9gysczH5+gd8R6BRqdg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=jRBGlpIAOMr0aJEhtE9qf9xmylLTnD1+54cwHWFclX7d4jCcl2dYjP2Ky/QQ44gSB
         cw+8hXorBVHvZRIKuHFLtZExR5YTTmPk8/qfasQtq4F55wkr9CzeWvU9INQJntPHzP
         74k2wAD7i4pxKssLvx8nwPa1cqjoK93h+egLbs1w=
Date:   Thu, 23 Apr 2020 12:07:18 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Hans De Goede <hdegoede@redhat.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v2 0/9] PM: sleep: core: Rearrange the handling of driver
 power management flags
Message-ID: <20200423170718.GA190576@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5673945.BT02kTCndr@kreacher>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, Apr 18, 2020 at 06:23:08PM +0200, Rafael J. Wysocki wrote:
> Hi,
> 
> This is an update including some fixes and extra patches based on the
> continuation of the discussion [1].
> 
> On Friday, April 10, 2020 5:46:27 PM CEST Rafael J. Wysocki wrote:
> > Hi Alan,
> > 
> > Following our recent discussion regarding the DPM_FLAG_* family of flags [1],
> > I have decided to follow some of your recommendations and make changes to the
> > core code handling those flags.
> > 
> > The purpose of this is basically to make the code more consistent internally,
> > easier to follow and better documented.
> > 
> > First of all, patch [1/7] changes the PM core to skip driver-level "late"
> > and "noirq" suspend callbacks for devices with SMART_SUSPEND set if they are
> > still runtime-suspended during the "late" system-wide suspend phase (without
> > the patch it does that only if subsystem-level late/noirq/early suspend/resume
> > callbacks are not present for the device, which is demonstrably inconsistent)
> > and updates the resume part of the code accordingly (it doesn't need to check
> > whether or not the subsystem-level callbacks are present any more).
> > 
> > The next patch, [2/7], is purely cosmetic and its only purpose is to reduce
> > the LOC number and move related pieces of code closer to each other.
> 
> The first two patches have not changed.
> 
> > Patch [3/7] changes the PM core so that it doesn't skip any subsystem-level
> > callbacks during system-wide resume (without the patch they may be skipped in
> > the "early resume" and "resume" phases due to LEAVE_SUSPENDED being set which
> > may be problematic) and to always run the driver's ->resume callback if the
> > corresponding subsystem-level callback is not present (without the patch it
> > may be skipped if LEAVE_SUSPENDED is set) to let it reverse the changes made
> > by the driver's ->suspend callback (which always runs too) if need be.
> 
> The difference between this one and patch [3/9] in the v2 is the fixed
> definition of dev_pm_may_skip_resume(), renamed to dev_pm_skip_resume() by
> one of the next patches.
> 
> Patch [4/9] changes the handling of the power.may_skip_resume flag to set it
> to 'true' by default and updates the subsystems aware of it to clear it when
> they don't want devices to stay in suspend.
> 
> > Patches [4-6/7] rename one function in the PM core and two driver PM flags to
> > make their names better reflect their purpose.
> 
> These are patches [5/9] and [7-8/9] in the v2 and patch [6/9] renames
> dev_pm_smart_suspend_and_suspended() to dev_pm_skip_suspend().
> 
> > Finally, patch [7/7] updates the documentation of the driver PM flags to
> > reflect the new code flows.
> 
> This patch [9/9] now and it has been updated to reflect the new code changes.
> 
> The pm-sleep-core branch:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
>   pm-sleep-core
> 
> contains the v2 now.

For the drivers/pci parts:

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

