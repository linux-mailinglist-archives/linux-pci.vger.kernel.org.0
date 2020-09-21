Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40339273562
	for <lists+linux-pci@lfdr.de>; Mon, 21 Sep 2020 23:58:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726644AbgIUV6s (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 21 Sep 2020 17:58:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:33212 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726452AbgIUV6s (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 21 Sep 2020 17:58:48 -0400
Received: from localhost (52.sub-72-107-123.myvzw.com [72.107.123.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 86BB323A60;
        Mon, 21 Sep 2020 21:58:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600725527;
        bh=FsOhUEaN2eYitnbmPGP9QWhgGMr0pTGOaY9Qi3p3COo=;
        h=Date:From:To:Cc:Subject:From;
        b=ZedIIg+dTIci96FHGwcH55d/YLkmS62Tyw6CgpUoK9voMrFD1VKX4QpGi+4Q4RD6/
         eTQw7a+xJWVF3gVeF9cZQNvdP6kp6tQfnZxufbavYDLhIvctyt1sYqivERxGYhAa/e
         Tkl4bLOPEoo0EtIeHEzGIQeyWOPRSRsSkKmZ/WAY=
Date:   Mon, 21 Sep 2020 16:58:46 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Karol Herbst <kherbst@redhat.com>,
        Lyude Paul <lyude@redhat.com>,
        Patrick Volkerding <volkerdi@gmail.com>,
        Lukas Wunner <lukas@wunner.de>,
        Ben Skeggs <bskeggs@redhat.com>,
        Todd Brandt <todd.e.brandt@linux.intel.com>,
        linux-pci@vger.kernel.org
Subject: [bugzilla-daemon@bugzilla.kernel.org: [Bug 209323] New: pcieport
 devices take longer than 1 second in resume]
Message-ID: <20200921215846.GA2137712@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Is this related to https://lore.kernel.org/r/20200831093147.36775-1-mika.westerberg@linux.intel.com/ ?

----- Forwarded message from bugzilla-daemon@bugzilla.kernel.org -----

Date: Fri, 18 Sep 2020 21:20:38 +0000
From: bugzilla-daemon@bugzilla.kernel.org
To: bjorn@helgaas.com
Subject: [Bug 209323] New: pcieport devices take longer than 1 second in resume
Message-ID: <bug-209323-41252@https.bugzilla.kernel.org/>

https://bugzilla.kernel.org/show_bug.cgi?id=209323

            Bug ID: 209323
           Summary: pcieport devices take longer than 1 second in resume
           Product: Drivers
           Version: 2.5
    Kernel Version: 5.8.0
          Hardware: All
                OS: Linux
              Tree: Mainline
            Status: NEW
          Severity: normal
          Priority: P1
         Component: PCI
          Assignee: drivers_pci@kernel-bugs.osdl.org
          Reporter: todd.e.brandt@linux.intel.com
            Blocks: 178231
        Regression: No

Created attachment 292541
  --> https://bugzilla.kernel.org/attachment.cgi?id=292541&action=edit
otcpl-dell-9380-cfl_freeze.html

pcieport devices are taking longer than 1 second across several machines. This
bug is there to monitor which machines and kernel release this happens on.


Referenced Bugs:

https://bugzilla.kernel.org/show_bug.cgi?id=178231
[Bug 178231] Meta-bug: Linux suspend-to-mem and freeze performance optimization
-- 
You are receiving this mail because:
You are watching the assignee of the bug.

----- End forwarded message -----
