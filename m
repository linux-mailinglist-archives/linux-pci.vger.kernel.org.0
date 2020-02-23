Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 09EF316978A
	for <lists+linux-pci@lfdr.de>; Sun, 23 Feb 2020 13:22:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726023AbgBWMWI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 23 Feb 2020 07:22:08 -0500
Received: from smtp-fw-9101.amazon.com ([207.171.184.25]:45589 "EHLO
        smtp-fw-9101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726308AbgBWMWI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 23 Feb 2020 07:22:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1582460527; x=1613996527;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Oi4U7lNb3iEL3XkkHqiUaqIeH88E0voXgDi5P1troPk=;
  b=lZAIt/RerD32pxu4QUPwjIyH44y7m5/4PJG7UPhPzfFDYq+BPcP5Fd+U
   U+0O1ry8ObTzCWEsy29zGneVTxpONGwRWaVu7D8jYsAUL+8jHpA8MzFPT
   8izVjcsKcD7qAE7k1tsmaSAis/sJCGPGnr3CwzAbg3MeKwHmfY3N8EpE3
   c=;
IronPort-SDR: mAdSPJxwu5Z3OxFj8xqettTsmP2uZK0TiqcJZZejie8kpZKGHwvmv8jYwEtdXdIpCmM1l6Q/KB
 oy43eVG05Prw==
X-IronPort-AV: E=Sophos;i="5.70,476,1574121600"; 
   d="scan'208";a="18523238"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-2c-2225282c.us-west-2.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-9101.sea19.amazon.com with ESMTP; 23 Feb 2020 12:22:05 +0000
Received: from EX13MTAUEA002.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan3.pdx.amazon.com [10.170.41.166])
        by email-inbound-relay-2c-2225282c.us-west-2.amazon.com (Postfix) with ESMTPS id D8FFCA270E;
        Sun, 23 Feb 2020 12:22:04 +0000 (UTC)
Received: from EX13D09EUC001.ant.amazon.com (10.43.164.146) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1236.3; Sun, 23 Feb 2020 12:22:03 +0000
Received: from EX13MTAUEA001.ant.amazon.com (10.43.61.82) by
 EX13D09EUC001.ant.amazon.com (10.43.164.146) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Sun, 23 Feb 2020 12:22:02 +0000
Received: from u961addbe640f56.ant.amazon.com (10.28.84.111) by
 mail-relay.amazon.com (10.43.61.243) with Microsoft SMTP Server id
 15.0.1367.3 via Frontend Transport; Sun, 23 Feb 2020 12:22:01 +0000
From:   Stanislav Spassov <stanspas@amazon.com>
To:     <linux-pci@vger.kernel.org>
CC:     Stanislav Spassov <stanspas@amazon.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        =?UTF-8?q?Jan=20H=20=2E=20Sch=C3=B6nherr?= <jschoenh@amazon.de>,
        Wei Wang <wawei@amazon.de>
Subject: [PATCH 3/3] PCI: Add CRS handling to pci_dev_wait()
Date:   Sun, 23 Feb 2020 13:20:57 +0100
Message-ID: <20200223122057.6504-4-stanspas@amazon.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200223122057.6504-1-stanspas@amazon.com>
References: <20200223122057.6504-1-stanspas@amazon.com>
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
is retried autonomosly by the Root Port. Platform-specific configuration
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
 drivers/pci/pci.c | 128 +++++++++++++++++++++++++++++++++++++---------
 1 file changed, 105 insertions(+), 23 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index a554818968ed..e8bce8da9402 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -1041,44 +1041,126 @@ static int pci_dev_get_reset_ready_poll_ms(struct pci_dev *dev)
 	return pcie_reset_ready_poll_ms;
 }
 
-static int pci_dev_wait(struct pci_dev *dev, char *reset_type)
+static bool pci_crs_sv_enabled(struct pci_dev *dev)
+{
+	struct pci_dev *root_port = pcie_find_root_port(dev);
+	u16 root_control;
+
+	if (!root_port)
+		return false;
+
+	if (pcie_capability_read_word(root_port, PCI_EXP_RTCTL, &root_control))
+		return false;
+
+	return root_control & PCI_EXP_RTCTL_CRSSVE;
+}
+
+static int pci_dev_poll_until_ready(struct pci_dev *dev,
+				    int where,
+				    u32 mask,
+				    u32 bad_value,
+				    char *event,
+				    int timeout, int *waited,
+				    u32 *final_value)
 {
-	int timeout = pci_dev_get_reset_ready_poll_ms(dev);
 	int delay = 1;
-	u32 id;
+	u32 value;
 
-	/*
-	 * After reset, the device should not silently discard config
-	 * requests, but it may still indicate that it needs more time by
-	 * responding to them with CRS completions.  The Root Port will
-	 * generally synthesize ~0 data to complete the read (except when
-	 * CRS SV is enabled and the read was for the Vendor ID; in that
-	 * case it synthesizes 0x0001 data).
-	 *
-	 * Wait for the device to return a non-CRS completion.  Read the
-	 * Command register instead of Vendor ID so we don't have to
-	 * contend with the CRS SV value.
-	 */
-	pci_read_config_dword(dev, PCI_COMMAND, &id);
-	while (id == ~0) {
+	if (!event)
+		event = "<unknown event>";
+
+	if (pci_read_config_dword(dev, where, &value))
+		return -ENOTTY;
+
+	while ((value & mask) == bad_value) {
 		if (delay > timeout) {
 			pci_warn(dev, "not ready %dms after %s; giving up\n",
-				 delay - 1, reset_type);
-			return -ENOTTY;
+				 delay - 1, event);
+			return -ETIMEDOUT;
 		}
 
 		if (delay > 1000)
 			pci_info(dev, "not ready %dms after %s; waiting\n",
-				 delay - 1, reset_type);
+				 delay - 1, event);
 
 		msleep(delay);
 		delay *= 2;
-		pci_read_config_dword(dev, PCI_COMMAND, &id);
+
+		if (pci_read_config_dword(dev, where, &value))
+			return -ENOTTY;
 	}
 
 	if (delay > 1000)
-		pci_info(dev, "ready %dms after %s\n", delay - 1,
-			 reset_type);
+		pci_info(dev, "ready %dms after %s\n", delay - 1, event);
+
+	if (waited)
+		*waited = delay - 1;
+
+	if (final_value)
+		*final_value = value;
+
+	return 0;
+}
+
+static int pci_dev_wait_crs(struct pci_dev *dev, char *reset_type,
+			    int timeout, int *waited, u32 *id)
+{
+	return pci_dev_poll_until_ready(dev, PCI_VENDOR_ID, 0xffff, 0x0001,
+					reset_type, timeout, waited, id);
+}
+
+static int pci_dev_wait(struct pci_dev *dev, char *reset_type)
+{
+	int timeout = pci_dev_get_reset_ready_poll_ms(dev);
+	int waited = 0;
+
+	/*
+	 * After reset, the device should not silently discard config
+	 * requests, but it may still indicate that it needs more time by
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
+	 *   (ultimately resulting in non-PCI-specific errors, such as a
+	 *   TOR timeout).
+	 */
+	if (pci_crs_sv_enabled(dev)) {
+		u32 id;
+
+		if (pci_dev_wait_crs(dev, reset_type, timeout, &waited, &id))
+			return -ENOTTY;
+
+		timeout -= waited;
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
+	 */
+	if (pci_dev_poll_until_ready(dev, PCI_COMMAND, ~0, ~0,
+				     reset_type, timeout, NULL, NULL))
+		return -ENOTTY;
 
 	return 0;
 }
-- 
2.25.1




Amazon Development Center Germany GmbH
Krausenstr. 38
10117 Berlin
Geschaeftsfuehrung: Christian Schlaeger, Jonathan Weiss
Eingetragen am Amtsgericht Charlottenburg unter HRB 149173 B
Sitz: Berlin
Ust-ID: DE 289 237 879



