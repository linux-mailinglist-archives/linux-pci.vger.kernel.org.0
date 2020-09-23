Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B2BF275CB3
	for <lists+linux-pci@lfdr.de>; Wed, 23 Sep 2020 18:03:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726681AbgIWQDa (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 23 Sep 2020 12:03:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:35654 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726761AbgIWQDa (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 23 Sep 2020 12:03:30 -0400
Received: from localhost (52.sub-72-107-123.myvzw.com [72.107.123.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1033A214F1;
        Wed, 23 Sep 2020 16:03:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600877009;
        bh=9l/nrbnWUjMS39tgMqGNaBSTyJVZza8YTM6Xjn+ycYY=;
        h=Date:From:To:Cc:Subject:From;
        b=WYl2FawGX2+QKlnFsTqAaXa8CepNhpyp/R+w3kW9XcSchavbM7bYh2y7qq1E6GaGN
         P10B6R+XuJTi/uDJHzZCy1ano93li/Xbw9aJQi5q4StyW4kxWcO9iX7Snm2zQ1q4nM
         1dCH74jjZhMh9MQki5h8oNAQS1JiIxguuJO1lyEI=
Date:   Wed, 23 Sep 2020 11:03:27 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     linux-pci@vger.kernel.org
Cc:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Joerg Roedel <jroedel@suse.de>,
        Lalithambika Krishnakumar <lalithambika.krishnakumar@intel.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Rajat Jain <rajatja@google.com>,
        linux-nvme@lists.infradead.org, iommu@lists.linux-foundation.org
Subject: [bugzilla-daemon@bugzilla.kernel.org: [Bug 209149] New: "iommu/vt-d:
 Enable PCI ACS for platform opt in hint" makes NVMe config space not
 accessible after S3]
Message-ID: <20200923160327.GA2267374@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc IOMMU and NVMe folks]

Sorry, I forgot to forward this to linux-pci when it was first
reported.

Apparently this happens with v5.9-rc3, and may be related to
50310600ebda ("iommu/vt-d: Enable PCI ACS for platform opt in hint"),
which appeared in v5.8-rc3.

There are several dmesg logs and proposed patches in the bugzilla, but
no analysis yet of what the problem is.  From the first dmesg
attachment (https://bugzilla.kernel.org/attachment.cgi?id=292327):

  [   50.434945] PM: suspend entry (deep)
  [   50.802086] nvme 0000:01:00.0: saving config space at offset 0x0 (reading 0x11e0f)
  [   50.842775] ACPI: Preparing to enter system sleep state S3
  [   50.858922] ACPI: Waking up from system sleep state S3
  [   50.883622] nvme 0000:01:00.0: can't change power state from D3hot to D0 (config space inaccessible)
  [   50.947352] nvme 0000:01:00.0: restoring config space at offset 0x0 (was 0xffffffff, writing 0x11e0f)
  [   50.947816] pcieport 0000:00:1b.0: DPC: containment event, status:0x1f01 source:0x0000
  [   50.947817] pcieport 0000:00:1b.0: DPC: unmasked uncorrectable error detected
  [   50.947829] pcieport 0000:00:1b.0: PCIe Bus Error: severity=Uncorrected (Non-Fatal), type=Transaction Layer, (Receiver ID)
  [   50.947830] pcieport 0000:00:1b.0:   device [8086:06ac] error status/mask=00200000/00010000
  [   50.947831] pcieport 0000:00:1b.0:    [21] ACSViol                (First)
  [   50.947841] pcieport 0000:00:1b.0: AER: broadcast error_detected message
  [   50.947843] nvme nvme0: frozen state error detected, reset controller

I suspect the nvme "can't change power state" and restore config space
errors are a consequence of the DPC event.  If DPC disables the link,
the device is inaccessible.

I don't know what caused the ACS Violation.  The AER TLP Header Log
might have a clue, but unfortunately we didn't print it.

Tangent:

  The fact that we didn't print the AER TLP Header log looks like
  a bug in itself.  PCIe r5.0, sec 6.2.7, table 6-5, says many
  errors, including ACS Violation, should log the TLP header.  But
  aer_get_device_error_info() only reads the log for error bits in
  AER_LOG_TLP_MASKS, which doesn't include PCI_ERR_UNC_ACSV.

  I don't think there's a "TLP Header Log Valid" bit, and it's ugly to
  have to update AER_LOG_TLP_MASKS if new errors are added.  I think
  maybe we should always print the header log.

----- Forwarded message from bugzilla-daemon@bugzilla.kernel.org -----

Date: Fri, 04 Sep 2020 14:31:20 +0000
From: bugzilla-daemon@bugzilla.kernel.org
To: bjorn@helgaas.com
Subject: [Bug 209149] New: "iommu/vt-d: Enable PCI ACS for platform opt in
	hint" makes NVMe config space not accessible after S3
Message-ID: <bug-209149-41252@https.bugzilla.kernel.org/>

https://bugzilla.kernel.org/show_bug.cgi?id=209149

            Bug ID: 209149
           Summary: "iommu/vt-d: Enable PCI ACS for platform opt in hint"
                    makes NVMe config space not accessible after S3
           Product: Drivers
           Version: 2.5
    Kernel Version: mainline
          Hardware: All
                OS: Linux
              Tree: Mainline
            Status: NEW
          Severity: normal
          Priority: P1
         Component: PCI
          Assignee: drivers_pci@kernel-bugs.osdl.org
          Reporter: kai.heng.feng@canonical.com
        Regression: No

Here's the error:
[   50.947816] pcieport 0000:00:1b.0: DPC: containment event, status:0x1f01
source:0x0000
[   50.947817] pcieport 0000:00:1b.0: DPC: unmasked uncorrectable error
detected
[   50.947829] pcieport 0000:00:1b.0: PCIe Bus Error: severity=Uncorrected
(Non-Fatal), type=Transaction Layer, (Receiver ID)
[   50.947830] pcieport 0000:00:1b.0:   device [8086:06ac] error
status/mask=00200000/00010000
[   50.947831] pcieport 0000:00:1b.0:    [21] ACSViol                (First)
[   50.947841] pcieport 0000:00:1b.0: AER: broadcast error_detected message
[   50.947843] nvme nvme0: frozen state error detected, reset controller

-- 
You are receiving this mail because:
You are watching the assignee of the bug.

----- End forwarded message -----
