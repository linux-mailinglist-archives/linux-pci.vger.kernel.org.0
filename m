Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A9E7C7C956
	for <lists+linux-pci@lfdr.de>; Wed, 31 Jul 2019 18:58:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729983AbfGaQ6j (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 31 Jul 2019 12:58:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:44526 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727487AbfGaQ6j (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 31 Jul 2019 12:58:39 -0400
Received: from localhost (173-25-83-245.client.mchsi.com [173.25.83.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 41F16206B8;
        Wed, 31 Jul 2019 16:58:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564592318;
        bh=GK34hMoIqS1LKB9/No990zj8xBhgXxjxz3Ly73DSymU=;
        h=Date:From:To:Cc:Subject:From;
        b=TxlVBaEuhFsldFgAeHf8Y1D6LI9uq6ZOcqm8JNesR4uKorcJy3Q7I9yA37uouUgk+
         9AzugpCizac2aJ6E2oHOSrntgaDHaW0WSHBlD1iyMD1HwlAI+P6vOV/jxrNIS2O+UB
         yuMudGiZVvcz3XXYdO2WYKpaGQazBDYiE6IX0iio=
Date:   Wed, 31 Jul 2019 11:58:36 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     AceLan Kao <acelan@gmail.com>, linux-pci@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: [bugzilla-daemon@bugzilla.kernel.org: [Bug 204385] New: Failed to
 resume from S3 with thunderbolt daisy chain]
Message-ID: <20190731165836.GB151852@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

AceLan, before suspending, can you please run "sudo lspci -vv" and
attach the complete output to the bugzilla?

----- Forwarded message from bugzilla-daemon@bugzilla.kernel.org -----

Date: Wed, 31 Jul 2019 02:58:33 +0000
From: bugzilla-daemon@bugzilla.kernel.org
To: bugzilla.pci@gmail.com
Subject: [Bug 204385] New: Failed to resume from S3 with thunderbolt daisy
	chain
Message-ID: <bug-204385-193951@https.bugzilla.kernel.org/>

https://bugzilla.kernel.org/show_bug.cgi?id=204385

            Bug ID: 204385
           Summary: Failed to resume from S3 with thunderbolt daisy chain
           Product: Drivers
           Version: 2.5
    Kernel Version: 5.3.0-rc2
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

Created attachment 284047
  --> https://bugzilla.kernel.org/attachment.cgi?id=284047&action=edit
dmesg.log

The system can't resume while connecting to a tbt storage and a tbt monitor
over Thunderbolt port(daisy-chaining)

Dell Precision 5540 --> Dell WD19TB Thunderbolt Dock --> ASUS-Display PA27AC
--> HP P800 Thunderbolt Storage

Reproduce steps:
1. Connect Dell WD19TB Thunderbolt Dock to your system(thunderbolt port)
2. Connect ASUS-Display PA27AC(thuderbolt port) to WD19TB(thunderbolt port)
3. Connect HP P800 thunderbolt storage to PA27AC display(thunderbolt port)
4. mount and access files on HP P800
5. enter S3(echo deep | sudo tee /sys/power/mem_sleep && systemctl suspend) and
resume
6. it hangs

It works well if laptop
1. connects to HP P800 directly
2. or connects to ASUS monitor directly
3. or connects to ASUS monitor -> HP P800
4. or connects to WD19TB -> HP P800
5. or connects to WD19TB -> ASUS monitor

-- 
You are receiving this mail because:
You are watching the assignee of the bug.

----- End forwarded message -----
