Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6D85A17CF63
	for <lists+linux-pci@lfdr.de>; Sat,  7 Mar 2020 18:21:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726116AbgCGRVS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 7 Mar 2020 12:21:18 -0500
Received: from smtp-fw-6001.amazon.com ([52.95.48.154]:49686 "EHLO
        smtp-fw-6001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726109AbgCGRVS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 7 Mar 2020 12:21:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1583601677; x=1615137677;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=wp1srcZz+c4pufjKhqF12RrK2cgk334AwrOVe4A37rw=;
  b=I/SOaXI35KSBhauMS7aI7fyWcbJKv5+NAY7+Wt7FtAALr6jK0MiIA3qq
   Hfnv9U0pU241Bq33ApQUAI2U0nrTByyDwi7udjSsVbHIJiU7ckDxoLgP7
   l/HyRm7HjAycp1co9cWvg/UvyuRU4hYwqJ9AJ5kBGPNIl2kNxvcoishyD
   Q=;
IronPort-SDR: X1GH5KzOMRj0ZmroU1PxwsCCRMq/lwmgmWaeUlwltS4uDPVFDUzK4mLzm7MJG8y5DRAKZrytya
 gnQR8eYSazAw==
X-IronPort-AV: E=Sophos;i="5.70,526,1574121600"; 
   d="scan'208";a="21473155"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-1e-a70de69e.us-east-1.amazon.com) ([10.43.8.6])
  by smtp-border-fw-out-6001.iad6.amazon.com with ESMTP; 07 Mar 2020 17:21:05 +0000
Received: from EX13MTAUEA002.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan2.iad.amazon.com [10.40.159.162])
        by email-inbound-relay-1e-a70de69e.us-east-1.amazon.com (Postfix) with ESMTPS id 705A5A2CE4;
        Sat,  7 Mar 2020 17:21:01 +0000 (UTC)
Received: from EX13D12EUC002.ant.amazon.com (10.43.164.134) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1236.3; Sat, 7 Mar 2020 17:21:00 +0000
Received: from EX13MTAUEE002.ant.amazon.com (10.43.62.24) by
 EX13D12EUC002.ant.amazon.com (10.43.164.134) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Sat, 7 Mar 2020 17:20:59 +0000
Received: from u961addbe640f56.ant.amazon.com (10.28.84.111) by
 mail-relay.amazon.com (10.43.62.224) with Microsoft SMTP Server id
 15.0.1367.3 via Frontend Transport; Sat, 7 Mar 2020 17:20:56 +0000
From:   Stanislav Spassov <stanspas@amazon.com>
To:     <linux-pci@vger.kernel.org>
CC:     Stanislav Spassov <stanspas@amazon.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        =?UTF-8?q?Jan=20H=20=2E=20Sch=C3=B6nherr?= <jschoenh@amazon.de>,
        Jonathan Corbet <corbet@lwn.net>,
        Ashok Raj <ashok.raj@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        "Sinan Kaya" <okaya@kernel.org>, Rajat Jain <rajatja@google.com>
Subject: [PATCH v4 0/3] Improve PCI device post-reset readiness polling
Date:   Sat, 7 Mar 2020 18:20:41 +0100
Message-ID: <20200307172044.29645-1-stanspas@amazon.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Stanislav Spassov <stanspas@amazon.de>

The first version of this patch series can be found here:
https://lore.kernel.org/linux-pci/20200223122057.6504-1-stanspas@amazon.com

The goal of this patch series is to solve an issue where pci_dev_wait
can cause system crashes. After a reset, a hung device may keep
responding with CRS completions indefinitely. If CRS Software Visibility
is enabled on the Root Port, attempting to read any register other than
PCI_VENDOR_ID will cause the Root Port to autonomously retry the request
without reporting back to the CPU core. Unless the number of retries or
the amount of time spent retrying is limited by platform-specific means,
this scenario leads to low-level platform timeouts (such as a TOR
Timeout), which can easily escalate to a crash.

Feedback on the v1 inspired a lot of additional improvements all around the
device reset codepaths and reducing post-reset delays. These improvements
were published as part of v2 (v3 is just small build fixes).

It looks like there is immediate demand specifically for the CRS work,
so I am once again reducing the series to just that. The reset will be
posted as a separate patch series that will likely require more time and
iterations to stabilize.

Changes since v3:
- In pci_dev_wait(), added "timeout -= waited" to account the time spent
  polling PCI_VENDOR_ID before falling back to polling PCI_COMMAND if
  device readiness could not be positively established via CRS (i.e.,
  if we stopped receiving CRS completions but did not receive a valid
  vendor ID due to dealing with an SR-IOV VF, or due to a different error)
- Simplified the commit message of "PCI: Add CRS handling to pci_dev_wait()"
  to avoid confusion as to when Root Ports will autonomously retry requests
  that resulted in CRS completions.

Stanislav Spassov (3):
  PCI: Refactor polling loop out of pci_dev_wait
  PCI: Cache CRS Software Visibiliy in struct pci_dev
  PCI: Add CRS handling to pci_dev_wait()

 drivers/pci/pci.c   | 109 +++++++++++++++++++++++++++++++++++---------
 drivers/pci/probe.c |   8 +++-
 include/linux/pci.h |   3 ++
 3 files changed, 98 insertions(+), 22 deletions(-)


base-commit: bb6d3fb354c5ee8d6bde2d576eb7220ea09862b9
-- 
2.25.1




Amazon Development Center Germany GmbH
Krausenstr. 38
10117 Berlin
Geschaeftsfuehrung: Christian Schlaeger, Jonathan Weiss
Eingetragen am Amtsgericht Charlottenburg unter HRB 149173 B
Sitz: Berlin
Ust-ID: DE 289 237 879



