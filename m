Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 401CE177723
	for <lists+linux-pci@lfdr.de>; Tue,  3 Mar 2020 14:31:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729436AbgCCNbH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 3 Mar 2020 08:31:07 -0500
Received: from smtp-fw-6001.amazon.com ([52.95.48.154]:35902 "EHLO
        smtp-fw-6001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728661AbgCCNbH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 3 Mar 2020 08:31:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1583242266; x=1614778266;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=l0e3JJTqLxOZqhNDS1pf36rN/WmV38VFKlUXk+nl89w=;
  b=CDglZWsUtSTdOg4/8TJPdnGz4adZoF9M62aro85lkSA0GeKtKnE5RFqF
   Dbee35FEpH5Ey+yvQQQvO5ARYsQJgLqr1o5ZF04UI2KZsR3igEk9ToOAS
   Kgg/VBIFSciFOY/KXeiMd5r6PZ70KUI1AHKrFyH5agMq1QKfCMHVEKM2S
   U=;
IronPort-SDR: YLyNGElTUdCgotd3cjqef6Tug0NLgJBtO6qkiCqITQ7GTTXbZiBam6S3lrwNvArSub5qRwUssN
 G6zju1ivgj7Q==
X-IronPort-AV: E=Sophos;i="5.70,511,1574121600"; 
   d="scan'208";a="20718021"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-2a-69849ee2.us-west-2.amazon.com) ([10.43.8.6])
  by smtp-border-fw-out-6001.iad6.amazon.com with ESMTP; 03 Mar 2020 13:31:05 +0000
Received: from EX13MTAUEA002.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan2.pdx.amazon.com [10.170.41.162])
        by email-inbound-relay-2a-69849ee2.us-west-2.amazon.com (Postfix) with ESMTPS id 68482A3445;
        Tue,  3 Mar 2020 13:31:01 +0000 (UTC)
Received: from EX13D12EUA001.ant.amazon.com (10.43.165.48) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1236.3; Tue, 3 Mar 2020 13:30:40 +0000
Received: from EX13MTAUEE002.ant.amazon.com (10.43.62.24) by
 EX13D12EUA001.ant.amazon.com (10.43.165.48) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 3 Mar 2020 13:30:38 +0000
Received: from u961addbe640f56.ant.amazon.com (10.28.84.111) by
 mail-relay.amazon.com (10.43.62.224) with Microsoft SMTP Server id
 15.0.1367.3 via Frontend Transport; Tue, 3 Mar 2020 13:30:36 +0000
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
Subject: [PATCH v3 16/17] PCI: Add CRS handling to pci_dev_wait()
Date:   Tue, 3 Mar 2020 14:28:51 +0100
Message-ID: <20200303132852.13184-17-stanspas@amazon.com>
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

The PCI Express specification dictates minimal amounts of time that the
host needs to wait after triggering different kinds of resets before it
is allowed to attempt accessing the device. After this waiting period,
devices are required to be responsive to Configuration Space reads.
However, if a device needs more time to actually complete the reset
operation internally, it may respond to the read with a Completion
Request Retry Status (CRS), and keep doing so on subsequent reads
for as long as necessary. If the device is broken, it may even keep
responding with CRS indefinitely.

The specification also mandates that any Root Port that supports CRS
and has CRS Software Visibility (CRS SV) enabled will synthesize the
special value 0x0001 for the Vendor ID and set any other bits to 1
upon receiving a CRS Completion for a Configuration Read Request that
includes both bytes of the Vendor ID (offset 0).

IF CRS is supported by Root Port but CRS SV is not enabled, the request
is retried autonomously by the Root Port. Platform-specific configuration
registers may exist to limit the number of or time taken by such retries.

If CRS is not supported, or a different register (not Vendor ID) is
polled, or the device is responding with CA/UR Completions (rather than
CRS), the behavior is platform-dependent, but generally the Root Port
synthesizes ~0 to complete the software read.

Previously, pci_dev_wait() avoided taking advantage of CRS. However,
on platforms where no limit/timeout can be configured as explained
above, a device responding with CRS for too long (e.g. because it is
stuck and cannot complete its reset) may trigger more severe error
conditions (e.g. TOR timeout, 3-strike CPU CATERR), because the Root
Port never reports back to the lower-level component requesting the
transaction.

This patch introduces special handling when CRS is available, and
otherwise falls back to the previous behavior of polling COMMAND.

Signed-off-by: Stanislav Spassov <stanspas@amazon.de>
---
 drivers/pci/pci.c | 52 +++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 44 insertions(+), 8 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index f1ba931b0ead..1a504419e0de 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -1081,18 +1081,54 @@ static int pci_dev_wait(struct pci_dev *dev, enum pci_init_event event)
 {
 	const char *event_name = pci_init_event_name(event);
 	int timeout = dev->reset_ready_poll_ms;
+	int waited = 0;
+	int rc = 0;
+
 
 	/*
 	 * After reset, the device should not silently discard config
 	 * requests, but it may still indicate that it needs more time by
-	 * responding to them with CRS completions.  The Root Port will
-	 * generally synthesize ~0 data to complete the read (except when
-	 * CRS SV is enabled and the read was for the Vendor ID; in that
-	 * case it synthesizes 0x0001 data).
-	 *
-	 * Wait for the device to return a non-CRS completion.  Read the
-	 * Command register instead of Vendor ID so we don't have to
-	 * contend with the CRS SV value.
+	 * responding to them with CRS completions. For such completions:
+	 * - If CRS SV is enabled on the Root Port, and the read request
+	 *   covers both bytes of the Vendor ID register, the Root Port
+	 *   will synthesize the value 0x0001 (and set any extra requested
+	 *   bytes to 0xff)
+	 * - If CRS SV is not enabled on the Root Port, the Root Port must
+	 *   re-issue the Configuration Request as a new Request.
+	 *   Depending on platform-specific Root Complex configurations,
+	 *   the Root Port may stop retrying after a set number of attempts,
+	 *   or a configured timeout is hit, or continue indefinitely
+	 *   (ultimately resulting in non-PCI-specific platform errors, such as
+	 *   a TOR timeout).
+	 */
+	if (dev->crssv_enabled) {
+		u32 id;
+
+		rc = pci_dev_poll_until_not_equal(dev, PCI_VENDOR_ID, 0xffff,
+						  0x0001, event_name, timeout,
+						  &waited, &id);
+		if (rc)
+			return rc;
+
+		/*
+		 * If Vendor/Device ID is valid, the device must be ready.
+		 * Note: SR-IOV VFs return ~0 for reads to Vendor/Device
+		 * ID and will not be recognized as ready by this check.
+		 */
+		if (id != 0x0000ffff && id != 0xffff0000 &&
+		    id != 0x00000000 && id != 0xffffffff)
+			return 0;
+	}
+
+	/*
+	 * Root Ports will generally indicate error scenarios (e.g.
+	 * internal timeouts, or received Completion with CA/UR) by
+	 * synthesizing an 'all bits set' value (~0).
+	 * In case CRS is not supported/enabled, as well as for SR-IOV VFs,
+	 * fall back to polling a different register that cannot validly
+	 * contain ~0. As of PCIe 5.0, bits 11-15 of COMMAND are still RsvdP
+	 * and must return 0 when read.
+	 * XXX: These bits might become meaningful in the future
 	 */
 	return pci_dev_poll_until_not_equal(dev, PCI_COMMAND, ~0, ~0,
 					    event_name, timeout, NULL,
-- 
2.25.1




Amazon Development Center Germany GmbH
Krausenstr. 38
10117 Berlin
Geschaeftsfuehrung: Christian Schlaeger, Jonathan Weiss
Eingetragen am Amtsgericht Charlottenburg unter HRB 149173 B
Sitz: Berlin
Ust-ID: DE 289 237 879



