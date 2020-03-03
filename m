Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A9EFE177724
	for <lists+linux-pci@lfdr.de>; Tue,  3 Mar 2020 14:31:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729437AbgCCNbH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 3 Mar 2020 08:31:07 -0500
Received: from smtp-fw-9101.amazon.com ([207.171.184.25]:31533 "EHLO
        smtp-fw-9101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729430AbgCCNbH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 3 Mar 2020 08:31:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1583242267; x=1614778267;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=NwisI3KTsm/OiywhsK6dC5HAgpMIY4oSgnpSsD8E7Hk=;
  b=TLmUNrgrSvTQ8GvkFQtp5HDjfmy+sN1tiNG84DurEcDf4QnxhG9LWqvs
   kcgQx/XDx2avLQh79eBr/Ta5mATHkgBqg6I7zYuzvErU55/G0/k2bkeMl
   /OpbCu3Dz3abhXCvne0ITUGoY3WQImyGfFsZmLMSASHHDtQNUXg5m11Za
   A=;
IronPort-SDR: Y0/7gX+4Lclg7Uo0HvObMxoar77IBMo0iWbtQeW+ZBm9cbbsxI0fFLcDZenZJ16U5zH8TbMB8X
 hMoiHtCKfzFw==
X-IronPort-AV: E=Sophos;i="5.70,511,1574121600"; 
   d="scan'208";a="20496361"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-2a-c5104f52.us-west-2.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-9101.sea19.amazon.com with ESMTP; 03 Mar 2020 13:31:03 +0000
Received: from EX13MTAUEA002.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan3.pdx.amazon.com [10.170.41.166])
        by email-inbound-relay-2a-c5104f52.us-west-2.amazon.com (Postfix) with ESMTPS id 59758A2BBB;
        Tue,  3 Mar 2020 13:31:02 +0000 (UTC)
Received: from EX13D04EUA002.ant.amazon.com (10.43.165.75) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1236.3; Tue, 3 Mar 2020 13:30:42 +0000
Received: from EX13MTAUEE002.ant.amazon.com (10.43.62.24) by
 EX13D04EUA002.ant.amazon.com (10.43.165.75) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 3 Mar 2020 13:30:41 +0000
Received: from u961addbe640f56.ant.amazon.com (10.28.84.111) by
 mail-relay.amazon.com (10.43.62.224) with Microsoft SMTP Server id
 15.0.1367.3 via Frontend Transport; Tue, 3 Mar 2020 13:30:39 +0000
From:   Stanislav Spassov <stanspas@amazon.com>
To:     <linux-pci@vger.kernel.org>
CC:     Stanislav Spassov <stanspas@amazon.de>,
        <linux-acpi@vger.kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        =?UTF-8?q?Jan=20H=20=2E=20Sch=C3=B6nherr?= <jschoenh@amazon.de>,
        "Jonathan Corbet" <corbet@lwn.net>,
        Ashok Raj <ashok.raj@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Sinan Kaya <okaya@kernel.org>, Rajat Jain <rajatja@google.com>,
        kbuild test robot <lkp@intel.com>
Subject: [PATCH v3 17/17] PCI: Lower PCIE_RESET_READY_POLL_MS from 1m to 1s
Date:   Tue, 3 Mar 2020 14:28:52 +0100
Message-ID: <20200303132852.13184-18-stanspas@amazon.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200303132852.13184-1-stanspas@amazon.com>
References: <20200303132852.13184-1-stanspas@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Stanislav Spassov <stanspas@amazon.de>

PCI Express Base specification r5.0 (May 22, 2019), sec 6.6.1 mentions
on more than one occasion that the appropriate waiting time before
deeming a device broken if it is not able to return Successful
Completion for valid Configuration Requests is 1 second after a
Conventional Reset (which should be the lengthiest of resets).

For devices that take longer than 1s to complete initialization, quirks
can override the waiting time via the reset_ready_poll_ms field in
struct pci_dev.

Note: This timeout is used in pci_dev_wait for the polling that happens
after we have already waited for the required post-reset times mandated
by the spec. All devices are expected to be responsive to Configuration
Requests at that point. "Completing initialization" here means that the
device is not only responsive, but actually returns Successful
Completions rather than CRS Completions (or any other error).

Signed-off-by: Stanislav Spassov <stanspas@amazon.de>
---
 drivers/pci/pci.h | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index d8043d4dbe2f..1c6722b5c3ee 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -113,8 +113,11 @@ int pci_bus_error_reset(struct pci_dev *dev);
 /* D0/D1->D2 and D2->D0 delay */
 #define PCI_PM_D2_DELAY		200
 
-/* Time to wait after a reset for device to become responsive */
-#define PCIE_RESET_READY_POLL_MS 60000
+/*
+ * Time to wait (in addition to the delays above) for a device to start
+ * returning Successful Completions before OS can deem it broken
+ */
+#define PCIE_RESET_READY_POLL_MS 1000
 
 /**
  * struct pci_platform_pm_ops - Firmware PM callbacks
-- 
2.25.1




Amazon Development Center Germany GmbH
Krausenstr. 38
10117 Berlin
Geschaeftsfuehrung: Christian Schlaeger, Jonathan Weiss
Eingetragen am Amtsgericht Charlottenburg unter HRB 149173 B
Sitz: Berlin
Ust-ID: DE 289 237 879



