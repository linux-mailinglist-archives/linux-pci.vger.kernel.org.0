Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 10AC817770E
	for <lists+linux-pci@lfdr.de>; Tue,  3 Mar 2020 14:30:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727894AbgCCNa2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 3 Mar 2020 08:30:28 -0500
Received: from smtp-fw-6002.amazon.com ([52.95.49.90]:21163 "EHLO
        smtp-fw-6002.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728068AbgCCNa2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 3 Mar 2020 08:30:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1583242227; x=1614778227;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Gz6pfLMfGNZpaFxwlrBNkkqcP/vdNODzuYge/T20qto=;
  b=HQBCxKOHQt8BFgjPadIT56uojQmu9TgLHXc+f6XvVhqYcTnhr86m2Cm4
   nQp4syemLJjggSq940AbPPli52Y6yA7wDOkHbNlBjCvJZlaAE3TN/ZQLv
   CK0Ov0hJ2wTN7CPn/bbbm5XrXoU8VDlAkpZFnCVbari7I3ed7s6apYbXc
   o=;
IronPort-SDR: FHWoXQAaMNLcqoTOhhHlOg33oQbd0JRg7pw5S6KyEKhcilo89yKsSNHnrucJPkxcNe0PNN2cuY
 EATC/f881HJA==
X-IronPort-AV: E=Sophos;i="5.70,511,1574121600"; 
   d="scan'208";a="19279361"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-2a-22cc717f.us-west-2.amazon.com) ([10.43.8.6])
  by smtp-border-fw-out-6002.iad6.amazon.com with ESMTP; 03 Mar 2020 13:30:01 +0000
Received: from EX13MTAUEA002.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan3.pdx.amazon.com [10.170.41.166])
        by email-inbound-relay-2a-22cc717f.us-west-2.amazon.com (Postfix) with ESMTPS id 88C55A2785;
        Tue,  3 Mar 2020 13:30:00 +0000 (UTC)
Received: from EX13D12EUA004.ant.amazon.com (10.43.165.162) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1236.3; Tue, 3 Mar 2020 13:29:49 +0000
Received: from EX13MTAUEE002.ant.amazon.com (10.43.62.24) by
 EX13D12EUA004.ant.amazon.com (10.43.165.162) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 3 Mar 2020 13:29:48 +0000
Received: from u961addbe640f56.ant.amazon.com (10.28.84.111) by
 mail-relay.amazon.com (10.43.62.224) with Microsoft SMTP Server id
 15.0.1367.3 via Frontend Transport; Tue, 3 Mar 2020 13:29:46 +0000
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
Subject: [PATCH v3 03/17] PCI: Use pci_bridge_wait_for_secondary_bus after SBR
Date:   Tue, 3 Mar 2020 14:28:38 +0100
Message-ID: <20200303132852.13184-4-stanspas@amazon.com>
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

So far, pci_bridge_wait_for_secondary_bus() was only invoked by PM code
after (runtime) resume of devices, but it naturally makes sense for
handling post-SBR waiting as well.

It uses the PCI_PM_D3COLD_WAIT value (100ms), potentially overridden on
a per-device basis to a lower-value, as the basis for determining
how long to wait, and handles special cases such as legacy PCI devices
(requiring Trhfa), and the different starting points for the waiting
time depending on PCIe port speed.

On PCI Express, there will be cases where the new code sleeps far less
than the 1s being replaced by this patch. This should be okay, because
PCI Express Base Specification Revision 5.0 Version 1.0 (May 22, 2019)
in Section 6.6.1 "Conventional Reset" only notes 100ms as the minimum
waiting time. After this time, the OS is permitted to issue
Configuration Requests, but it is possible that the device responds
with Configuration Request Retry Status (CRS) Completions, rather than
Successful Completion. Returning CRS can go on for up to 1 second after
a Conventional Reset (such as SBR) before the OS can consider the device
broken. This additional wait is handled by pci_dev_wait.

Currently, the only callchain that lands in the function modified by
this patch starts at pci_bridge_secondary_bus_reset which invokes
one out of two versions of pcibios_reset_secondary_bus that both end
with a call to pci_reset_secondary_bus.
Afterwards, pci_bridge_secondary_bus_reset always invokes pci_dev_wait.

Signed-off-by: Stanislav Spassov <stanspas@amazon.de>
---
 drivers/pci/pci.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index ac8504d75c32..c1a866f733e9 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -4800,14 +4800,7 @@ void pci_reset_secondary_bus(struct pci_dev *dev)
 	ctrl &= ~PCI_BRIDGE_CTL_BUS_RESET;
 	pci_write_config_word(dev, PCI_BRIDGE_CONTROL, ctrl);
 
-	/*
-	 * Trhfa for conventional PCI is 2^25 clock cycles.
-	 * Assuming a minimum 33MHz clock this results in a 1s
-	 * delay before we can consider subordinate devices to
-	 * be re-initialized.  PCIe has some ways to shorten this,
-	 * but we don't make use of them yet.
-	 */
-	ssleep(1);
+	pci_bridge_wait_for_secondary_bus(dev);
 }
 
 void __weak pcibios_reset_secondary_bus(struct pci_dev *dev)
-- 
2.25.1




Amazon Development Center Germany GmbH
Krausenstr. 38
10117 Berlin
Geschaeftsfuehrung: Christian Schlaeger, Jonathan Weiss
Eingetragen am Amtsgericht Charlottenburg unter HRB 149173 B
Sitz: Berlin
Ust-ID: DE 289 237 879



