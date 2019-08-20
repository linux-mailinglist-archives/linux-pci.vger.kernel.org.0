Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4D32896C75
	for <lists+linux-pci@lfdr.de>; Wed, 21 Aug 2019 00:37:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730273AbfHTWg5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 20 Aug 2019 18:36:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:33714 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730092AbfHTWg4 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 20 Aug 2019 18:36:56 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7C5EA2332A;
        Tue, 20 Aug 2019 22:36:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566340616;
        bh=vHNjSSVSLkQ4FtyXEmZ/IUZpcV2tVWWMJQiqbX6YNSM=;
        h=Date:From:To:Cc:Subject:From;
        b=iH3EZrPfq4Q6OL1qe3DdXBO735qkF7i3prEnOhjWtTaehSVhQPxKSkg10yWYnOaf0
         SEc16QIiixVhawiPKhkWGX55ZCPcL6eWzwMJIP5b9JIvbHSSZWPmjeq/6pdeIGtUtF
         yMd/1eMwxXFXoWBGdg3yFpTLFNTOrWfPuOkVRDow=
Date:   Tue, 20 Aug 2019 17:36:35 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     linux-pci@vger.kernel.org
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Lukas Wunner <lukas@wunner.de>,
        Mario Limonciello <mario_limonciello@dell.com>
Subject: [bugzilla-daemon@bugzilla.kernel.org: [Bug 204639] New: PCIEHP
 deadlock w/ Thunderbolt on ICL hardware]
Message-ID: <20190820223635.GE14450@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[Mario, the lspci attached to the bugzilla looks truncated]

----- Forwarded message from bugzilla-daemon@bugzilla.kernel.org -----

Date: Tue, 20 Aug 2019 16:50:09 +0000
From: bugzilla-daemon@bugzilla.kernel.org
To: bugzilla.pci@gmail.com
Subject: [Bug 204639] New: PCIEHP deadlock w/ Thunderbolt on ICL hardware
Message-ID: <bug-204639-193951@https.bugzilla.kernel.org/>

https://bugzilla.kernel.org/show_bug.cgi?id=204639

            Bug ID: 204639
           Summary: PCIEHP deadlock w/ Thunderbolt on ICL hardware
           Product: Drivers
           Version: 2.5
    Kernel Version: v5.3-rc5
          Hardware: All
                OS: Linux
              Tree: Mainline
            Status: NEW
          Severity: normal
          Priority: P1
         Component: PCI
          Assignee: drivers_pci@kernel-bugs.osdl.org
          Reporter: mario_limonciello@dell.com
        Regression: No

Created attachment 284535
  --> https://bugzilla.kernel.org/attachment.cgi?id=284535&action=edit
lspci

w/ 5.3rc5 I find that plugging in or unplugging a Thunderbolt dock (WD19TB)
into this ICL system will cause a deadlock.  At that point it's not possible to
use the dock anymore.

As a debugging tactic I did test applying
https://lore.kernel.org/patchwork/patch/1113961/ but it did not help the
behavior.

-- 
You are receiving this mail because:
You are watching the assignee of the bug.

----- End forwarded message -----
