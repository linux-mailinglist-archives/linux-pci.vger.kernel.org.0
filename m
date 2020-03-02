Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A5CFA176302
	for <lists+linux-pci@lfdr.de>; Mon,  2 Mar 2020 19:45:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727372AbgCBSpx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 2 Mar 2020 13:45:53 -0500
Received: from smtp-fw-6002.amazon.com ([52.95.49.90]:56061 "EHLO
        smtp-fw-6002.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727388AbgCBSpx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 2 Mar 2020 13:45:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1583174753; x=1614710753;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=SXJONBdcDukonc95OMH4eVS6Q98vylWW4QxZSA+zyc4=;
  b=u1HGjJo1RaNze1C56b/3IprbDCuWg2yjPzhBDNm92ZhqfpQvmLykHWau
   fGhF7y0LOxPi/p8ihKtnx2UmEBqLBMOOJ7Xlj3qtmmovtuJiR2OpG9kVM
   821EVEBzyTkbZ30ufw5zk6yZhG7l4+isDELzUgE3ayTHnVoPqcSSaC8Wb
   4=;
IronPort-SDR: uj46hkOYu2rGamAQBTIbse7bMfFb7S7z6rgp9/EaUJW7hBitSpO+zr4/SiTDfq/45ZG/0PNQ30
 Y/Bxx+nW4jBw==
X-IronPort-AV: E=Sophos;i="5.70,507,1574121600"; 
   d="scan'208";a="19141882"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-2b-81e76b79.us-west-2.amazon.com) ([10.43.8.6])
  by smtp-border-fw-out-6002.iad6.amazon.com with ESMTP; 02 Mar 2020 18:45:39 +0000
Received: from EX13MTAUEA002.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan3.pdx.amazon.com [10.170.41.166])
        by email-inbound-relay-2b-81e76b79.us-west-2.amazon.com (Postfix) with ESMTPS id 24D64A04F0;
        Mon,  2 Mar 2020 18:45:38 +0000 (UTC)
Received: from EX13D12EUA003.ant.amazon.com (10.43.165.147) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1236.3; Mon, 2 Mar 2020 18:45:18 +0000
Received: from EX13MTAUWB001.ant.amazon.com (10.43.161.207) by
 EX13D12EUA003.ant.amazon.com (10.43.165.147) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Mon, 2 Mar 2020 18:45:16 +0000
Received: from u961addbe640f56.ant.amazon.com (10.28.84.111) by
 mail-relay.amazon.com (10.43.161.249) with Microsoft SMTP Server id
 15.0.1367.3 via Frontend Transport; Mon, 2 Mar 2020 18:45:13 +0000
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
Subject: [PATCH v2 01/17] PCI: Fall back to slot/bus reset if softer methods timeout
Date:   Mon, 2 Mar 2020 19:44:13 +0100
Message-ID: <20200302184429.12880-2-stanspas@amazon.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200302184429.12880-1-stanspas@amazon.com>
References: <20200302184429.12880-1-stanspas@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Stanislav Spassov <stanspas@amazon.de>

Previously, if a device never came back (i.e., never started returning
Successful Completions for Configuration Requests) after a reset, they
would return -ENOTTY, causing __pci_reset_function_locked to move on
to the next reset method.

However, up until slot/bus reset, all of them rely on the device being
responsive and are therefore not safe to attempt in this situation.

This patch introduces ETIMEDOUT as a new, specially handled return value
for the reset methods (which all end in "return pci_dev_wait"), to allow
skipping to slot/bus reset where appropriate.

Signed-off-by: Stanislav Spassov <stanspas@amazon.de>
---
 drivers/pci/pci.c | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index d828ca835a98..ac8504d75c32 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -1043,7 +1043,7 @@ static int pci_dev_wait(struct pci_dev *dev, char *reset_type, int timeout)
 		if (delay > timeout) {
 			pci_warn(dev, "not ready %dms after %s; giving up\n",
 				 delay - 1, reset_type);
-			return -ENOTTY;
+			return -ETIMEDOUT;
 		}
 
 		if (delay > 1000)
@@ -4845,6 +4845,7 @@ static int pci_parent_bus_reset(struct pci_dev *dev, int probe)
 	if (probe)
 		return 0;
 
+	/* XXX: Shouldn't this lock the bus? */
 	return pci_bridge_secondary_bus_reset(dev->bus->self);
 }
 
@@ -4979,25 +4980,37 @@ int __pci_reset_function_locked(struct pci_dev *dev)
 	/*
 	 * A reset method returns -ENOTTY if it doesn't support this device
 	 * and we should try the next method.
+	 * It returns -ETIMEDOUT if the device never became responsive after
+	 * the reset: we jump to the reset types that do not rely on config
+	 * space access (if any are left).
 	 *
-	 * If it returns 0 (success), we're finished.  If it returns any
-	 * other error, we're also finished: this indicates that further
-	 * reset mechanisms might be broken on the device.
+	 * If it returns 0 (success), we are finished.
+	 * If it returns any other error, we are finished (something must have
+	 * went terribly wrong and it is not safe to continue reset attempts).
 	 */
 	rc = pci_dev_specific_reset(dev, 0);
+	if (rc == -ETIMEDOUT)
+		goto unresponsive;
 	if (rc != -ENOTTY)
 		return rc;
 	if (pcie_has_flr(dev)) {
 		rc = pcie_flr(dev);
+		if (rc == -ETIMEDOUT)
+			goto unresponsive;
 		if (rc != -ENOTTY)
 			return rc;
 	}
 	rc = pci_af_flr(dev, 0);
+	if (rc == -ETIMEDOUT)
+		goto unresponsive;
 	if (rc != -ENOTTY)
 		return rc;
 	rc = pci_pm_reset(dev, 0);
+	if (rc == -ETIMEDOUT)
+		goto unresponsive;
 	if (rc != -ENOTTY)
 		return rc;
+unresponsive:
 	rc = pci_dev_reset_slot_function(dev, 0);
 	if (rc != -ENOTTY)
 		return rc;
-- 
2.25.1




Amazon Development Center Germany GmbH
Krausenstr. 38
10117 Berlin
Geschaeftsfuehrung: Christian Schlaeger, Jonathan Weiss
Eingetragen am Amtsgericht Charlottenburg unter HRB 149173 B
Sitz: Berlin
Ust-ID: DE 289 237 879



