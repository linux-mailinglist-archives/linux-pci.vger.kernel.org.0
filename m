Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA368550AD7
	for <lists+linux-pci@lfdr.de>; Sun, 19 Jun 2022 15:20:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234686AbiFSNUq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 19 Jun 2022 09:20:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234547AbiFSNUp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 19 Jun 2022 09:20:45 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DEACBD4;
        Sun, 19 Jun 2022 06:20:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3B6F3B80D33;
        Sun, 19 Jun 2022 13:20:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAA2DC34114;
        Sun, 19 Jun 2022 13:20:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655644842;
        bh=/2u5fntWSZiEpUCmtTS07g312l9PpA2KzIK3S5qIcno=;
        h=Date:From:To:Cc:Subject:From;
        b=E25XDRZZuiPhSrj3BRycG3Yhmd2uoLb65l/lXVT7SHCzjzj0jeLHFLwzv9IDPVW2c
         rM6uErDiqbEVLGQoAq4HeF5wgsNui6yAPV/aDHxx9KKK0YwDcx8z/GZuTIHGUVWwaD
         d+BQqmuyILdomSEJUcavWX1GlkN4vrEYIC70GOnMZmSTWWt5bwjSG+wXZPhnnRWsCI
         UQqGX6CF1tB7B80maW2dkOuvqj4gbKSBVh1xASbtXSQwiR5RtZq0NwoWwCzZuUn2sJ
         Dy1LoqCCfcFnJAr8jGscFa2EFlCW4cFhefFAoJ4fN9q6RygY569qLQHdyOzqJLtR+r
         Mi6AO4KCjyZ6A==
Date:   Sun, 19 Jun 2022 08:20:39 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>
Cc:     Leo Savernik <l.savernik@aon.at>, linux-nvme@lists.infradead.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [bugzilla-daemon@kernel.org: [Bug 216147] New: NVMe quirk needed for
 multiple Micron MTFDKBA2T0TFH SSDs]
Message-ID: <20220619132039.GA1243474@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Thanks very much for the testing and report, Leo!  I'm forwarding it
to the NVMe folks who would take care of this.  I checked current
upstream (v5.19-rc1), and indeed this quirk does not appear there.

----- Forwarded message from bugzilla-daemon@kernel.org -----

Date: Sun, 19 Jun 2022 08:58:10 +0000
From: bugzilla-daemon@kernel.org
To: bjorn@helgaas.com
Subject: [Bug 216147] New: NVMe quirk needed for multiple Micron MTFDKBA2T0TFH SSDs
Message-ID: <bug-216147-41252@https.bugzilla.kernel.org/>

https://bugzilla.kernel.org/show_bug.cgi?id=216147

            Bug ID: 216147
           Summary: NVMe quirk needed for multiple Micron MTFDKBA2T0TFH
                    SSDs
           Product: Drivers
           Version: 2.5
    Kernel Version: 5.15.48
          Hardware: AMD
                OS: Linux
              Tree: Mainline
            Status: NEW
          Severity: normal
          Priority: P1
         Component: PCI
          Assignee: drivers_pci@kernel-bugs.osdl.org
          Reporter: l.savernik@aon.at
        Regression: No

Created attachment 301221
  --> https://bugzilla.kernel.org/attachment.cgi?id=301221&action=edit
Adding NVME_QUIRK_IGNORE_DEV_SUBNQN for Micron MTFDKBA2T0TFH

Even though first noticed on an Ubuntu kernel, I dare to report this against
upstream as this hardware combination malfunction seems not to be known yet (I
did not find distribution-specific patches for this issue). Therefore, IMHO,
the fix should be included upstream to make these devices work on every kernel
deployment.

My brand new Lenovo Notebook contains three NVMe 2T disks. When booting with
Kernel 5.15.0, I receive the following dmesg output:

...
Jun 09 03:33:08 kubuntu kernel: nvme 0000:04:00.0: platform quirk: setting
simple suspend
Jun 09 03:33:08 kubuntu kernel: nvme nvme0: pci function 0000:04:00.0
Jun 09 03:33:08 kubuntu kernel: nvme 0000:06:00.0: platform quirk: setting
simple suspend
Jun 09 03:33:08 kubuntu kernel: nvme nvme1: pci function 0000:06:00.0
Jun 09 03:33:08 kubuntu kernel: nvme 0000:05:00.0: platform quirk: setting
simple suspend
Jun 09 03:33:08 kubuntu kernel: nvme nvme2: pci function 0000:05:00.0
...
Jun 09 03:33:08 kubuntu kernel: nvme nvme1: Duplicate cntlid 0 with nvme0,
rejecting
Jun 09 03:33:08 kubuntu kernel: nvme nvme1: Removing after probe failure
status: -22
Jun 09 03:33:08 kubuntu kernel: nvme nvme2: Duplicate cntlid 0 with nvme0,
rejecting
Jun 09 03:33:08 kubuntu kernel: nvme nvme2: Removing after probe failure
status: -22
Jun 09 03:33:08 kubuntu kernel: pps pps0: new PPS source ptp0
Jun 09 03:33:08 kubuntu kernel: igc 0000:0b:00.0 (unnamed net_device)
(uninitialized): PHC added
Jun 09 03:33:08 kubuntu kernel: nvme nvme0: 16/0/0 default/read/poll queues
Jun 09 03:33:08 kubuntu kernel:  nvme0n1: p1 p2 p3
...

nvme0 is properly detected, however nvme1 and nvme2 are both rejected with
"Duplicate cntlid 0 with nvme0" error message.

lspci properly enumerates all of the 3 devices:
04:00.0 Non-Volatile memory controller: Micron Technology Inc Device 5407
05:00.0 Non-Volatile memory controller: Micron Technology Inc Device 5407
06:00.0 Non-Volatile memory controller: Micron Technology Inc Device 5407

Consequentially, I cannot make use of nvme1 and nvme2. A quirk setting was
proposed for a Samsung device [1] which was finally applied to the kernel [2].

[1] https://lkml.kernel.org/lkml/20210118113356.833556252@linuxfoundation.org/
[2] https://lkml.org/lkml/2021/1/18/1172

I wrote up a modified patch for Micron MTFDKBA2T0TFH devices, tested the patch
and could make all three NVMe devices work flawlessly under Linux 5.15.0.

I also checked this patch against 5.15.48, it applies cleanly.

I suggest this patch be applied to latest longterm 5.15.x as well as latest
Mainline as only one device has been added to the quirk table since, and the
format of the quirktable was not changed in the meantime.

The proposed patch itself (also see attachment):

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index b925a5f4afc3..2e5c33f3b868 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -3372,5 +3372,7 @@ static const struct pci_device_id nvme_id_table[] = {
NVME_QUIRK_128_BYTES_SQES |
                                NVME_QUIRK_NO_DEEPEST_PS |
                                NVME_QUIRK_IGNORE_DEV_SUBNQN, },
+       { PCI_DEVICE(0x1344, 0x5407), /* Micron Technology Inc NVMe SSD */
+               .driver_data = NVME_QUIRK_IGNORE_DEV_SUBNQN },
        { PCI_DEVICE_CLASS(PCI_CLASS_STORAGE_EXPRESS, 0xffffff) },
        { 0, }
 };

-- 
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.

----- End forwarded message -----
