Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BDBBD17CF65
	for <lists+linux-pci@lfdr.de>; Sat,  7 Mar 2020 18:21:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726174AbgCGRVm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 7 Mar 2020 12:21:42 -0500
Received: from smtp-fw-9102.amazon.com ([207.171.184.29]:59258 "EHLO
        smtp-fw-9102.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726109AbgCGRVm (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 7 Mar 2020 12:21:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1583601700; x=1615137700;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=AV9Cs1W7Saj9rP6tXuDZlO4fggKNzxo4CeWdS2NgJVA=;
  b=uGF5u/fU/OdYqKUifXn2Bdtl5d4H6lYC4YVidP5mUuaY0GVSFCXWF+8q
   mqfqjxpqcMKWvnCAElMGvE9g+kPxYBCjF4rLYC7oizREd+rkVsmaWbw/s
   VweoRJ8QgUpjMDq1QBoyu/or9EibRI3DftutdgZV+JIk4EhBNcMjXDeS0
   Q=;
IronPort-SDR: oJ7e01Vy8Q/m+RATSO4niv4uFrpLMYaq9871dfcOS0vKTYupCXtWinQf8P9b16YBkZ0E6dIXut
 ze8TKCnXOYTw==
X-IronPort-AV: E=Sophos;i="5.70,526,1574121600"; 
   d="scan'208";a="29836567"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-1e-27fb8269.us-east-1.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-9102.sea19.amazon.com with ESMTP; 07 Mar 2020 17:21:37 +0000
Received: from EX13MTAUEA002.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan3.iad.amazon.com [10.40.159.166])
        by email-inbound-relay-1e-27fb8269.us-east-1.amazon.com (Postfix) with ESMTPS id A43E5A21EF;
        Sat,  7 Mar 2020 17:21:34 +0000 (UTC)
Received: from EX13D04EUA004.ant.amazon.com (10.43.165.150) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1236.3; Sat, 7 Mar 2020 17:21:13 +0000
Received: from EX13MTAUEE002.ant.amazon.com (10.43.62.24) by
 EX13D04EUA004.ant.amazon.com (10.43.165.150) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Sat, 7 Mar 2020 17:21:12 +0000
Received: from u961addbe640f56.ant.amazon.com (10.28.84.111) by
 mail-relay.amazon.com (10.43.62.224) with Microsoft SMTP Server id
 15.0.1367.3 via Frontend Transport; Sat, 7 Mar 2020 17:21:10 +0000
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
Subject: [PATCH v4 2/3] PCI: Cache CRS Software Visibiliy in struct pci_dev
Date:   Sat, 7 Mar 2020 18:20:43 +0100
Message-ID: <20200307172044.29645-3-stanspas@amazon.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200307172044.29645-1-stanspas@amazon.com>
References: <20200307172044.29645-1-stanspas@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Stanislav Spassov <stanspas@amazon.de>

Arguably, since CRS SV is a capability of Root Ports and determines
how Root Ports will handle incoming CRS Completions, it makes more
sense to store this flag in the struct pci_bus that represents the
port's secondary bus, and to cache it in any buses further down the
hierarchy.

However, storing the flag in struct pci_dev allows individual devices
to be marked as not supporting CRS properly even when CRS SV is enabled
on their parent Root Port. This way, future code that relies on the new
flag will not be misled that it is safe to probe a device by relying on
CRS SV to not cause platform timeouts (See the note on CRS SV on p. 553
of PCI Express Base Specification r5.0 from May 22, 2019).

Note: Endpoints integrated into the Root Complex (RCiEP) may also be
capable of using CRS. In that case, the software visibility is
controlled using a Root Complex Register Block (RCRB). This is currently
not supported by the kernel. The code introduced here would simply not
set the newly introduced flag for RCiEP as for those bus->self is NULL.

Signed-off-by: Stanislav Spassov <stanspas@amazon.de>
---
 drivers/pci/probe.c | 8 +++++++-
 include/linux/pci.h | 3 +++
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 512cb4312ddd..eeff8a07f330 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1080,9 +1080,11 @@ static void pci_enable_crs(struct pci_dev *pdev)
 
 	/* Enable CRS Software Visibility if supported */
 	pcie_capability_read_word(pdev, PCI_EXP_RTCAP, &root_cap);
-	if (root_cap & PCI_EXP_RTCAP_CRSVIS)
+	if (root_cap & PCI_EXP_RTCAP_CRSVIS) {
 		pcie_capability_set_word(pdev, PCI_EXP_RTCTL,
 					 PCI_EXP_RTCTL_CRSSVE);
+		pdev->crssv_enabled = true;
+	}
 }
 
 static unsigned int pci_scan_child_bus_extend(struct pci_bus *bus,
@@ -2414,6 +2416,10 @@ void pci_device_add(struct pci_dev *dev, struct pci_bus *bus)
 	list_add_tail(&dev->bus_list, &bus->devices);
 	up_write(&pci_bus_sem);
 
+	/* Propagate CRS Software Visibility bit from the parent bridge */
+	if (bus->self)
+		dev->crssv_enabled = bus->self->crssv_enabled;
+
 	ret = pcibios_add_device(dev);
 	WARN_ON(ret < 0);
 
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 3840a541a9de..1c222c7c2572 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -354,6 +354,9 @@ struct pci_dev {
 						      user sysfs */
 	unsigned int	clear_retrain_link:1;	/* Need to clear Retrain Link
 						   bit manually */
+	unsigned int	crssv_enabled:1;	/* Configuration Request Retry
+						   Status Software Visibility
+						   enabled on (parent) bridge */
 	unsigned int	d3_delay;	/* D3->D0 transition time in ms */
 	unsigned int	d3cold_delay;	/* D3cold->D0 transition time in ms */
 
-- 
2.25.1




Amazon Development Center Germany GmbH
Krausenstr. 38
10117 Berlin
Geschaeftsfuehrung: Christian Schlaeger, Jonathan Weiss
Eingetragen am Amtsgericht Charlottenburg unter HRB 149173 B
Sitz: Berlin
Ust-ID: DE 289 237 879



