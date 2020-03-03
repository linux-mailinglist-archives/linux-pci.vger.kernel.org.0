Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1EA1D177717
	for <lists+linux-pci@lfdr.de>; Tue,  3 Mar 2020 14:31:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728311AbgCCNa4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 3 Mar 2020 08:30:56 -0500
Received: from smtp-fw-4101.amazon.com ([72.21.198.25]:16894 "EHLO
        smtp-fw-4101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727862AbgCCNaz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 3 Mar 2020 08:30:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1583242255; x=1614778255;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9xqMD1N8mF24q9FbAWh4uDveX6H7dYjjMS/baY775kQ=;
  b=XRE/d/lsA6moDiV/m/euLztL02OMMVvGfZc2Hb0neyX4JmJkc37G8kfY
   lQaYc+4+3FWkYY917sznS2UCb5Afm02tqwzOuvsO16iv++w1KN3dRF/nT
   TIGK8KMKMFOEz28yzdjB6m5Au3t7HxGn48oLPZLZLwb423iG8UpSFyktu
   A=;
IronPort-SDR: QXgtJ4opWTT+69jwBRvSBdm/7QPp6001D3PSirDHQy1f7YmKzHwZO/d4FuxLVC6B0ggAAf9Y6V
 yxKBhzp8ipAw==
X-IronPort-AV: E=Sophos;i="5.70,511,1574121600"; 
   d="scan'208";a="19549048"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-2a-f14f4a47.us-west-2.amazon.com) ([10.43.8.6])
  by smtp-border-fw-out-4101.iad4.amazon.com with ESMTP; 03 Mar 2020 13:30:53 +0000
Received: from EX13MTAUEA002.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan2.pdx.amazon.com [10.170.41.162])
        by email-inbound-relay-2a-f14f4a47.us-west-2.amazon.com (Postfix) with ESMTPS id C1C4DA2FF8;
        Tue,  3 Mar 2020 13:30:51 +0000 (UTC)
Received: from EX13D04EUA002.ant.amazon.com (10.43.165.75) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1236.3; Tue, 3 Mar 2020 13:30:23 +0000
Received: from EX13MTAUEE002.ant.amazon.com (10.43.62.24) by
 EX13D04EUA002.ant.amazon.com (10.43.165.75) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 3 Mar 2020 13:30:23 +0000
Received: from u961addbe640f56.ant.amazon.com (10.28.84.111) by
 mail-relay.amazon.com (10.43.62.224) with Microsoft SMTP Server id
 15.0.1367.3 via Frontend Transport; Tue, 3 Mar 2020 13:30:20 +0000
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
Subject: [PATCH v3 10/17] PCI: Use correct delay in pci_bridge_wait_for_secondary_bus
Date:   Tue, 3 Mar 2020 14:28:45 +0100
Message-ID: <20200303132852.13184-11-stanspas@amazon.com>
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

PCI Express Base Specification r5.0 (May 22, 2019) details the rules
for device reset in Section 6.6.

For a Downstream Port that does not support Link speeds greater than
5.0 GT/s, the minimum waiting period before software is permitted to
send a Configuration Request after a Conventional Reset is 100ms
(PCI_RESET_DELAY).

For a Downstream Port that supports Link speeds greater than 5.0 GT/s
(such ports are required to be Data Link Layer Link Active Reporting
capable), the period is again 100ms but measured after the link has
become active (PCI_DL_UP_DELAY).

The delays for both cases above can be overridden independently, and
pci_bridge_wait_for_secondary_bus should use the appropriate one.

Signed-off-by: Stanislav Spassov <stanspas@amazon.de>
---
 drivers/pci/pci.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index e4840dbf2d1c..7e08c5f38190 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -4736,6 +4736,12 @@ void pci_bridge_wait_for_secondary_bus(struct pci_dev *dev, bool sx_resume)
 	/* Take delay requirements into account */
 	if (sx_resume && dev->ignore_reset_delay_on_sx_resume)
 		delay = 0;
+	else if (pcie_downstream_port(dev) &&
+		 pcie_get_speed_cap(dev) > PCIE_SPEED_5_0GT &&
+		 dev->link_active_reporting)
+		delay = pci_bus_max_delay(dev->subordinate,
+					  PCI_INIT_EVENT_DL_UP,
+					  PCI_DL_UP_DELAY);
 	else
 		delay = pci_bus_max_delay(dev->subordinate,
 					  PCI_INIT_EVENT_RESET,
-- 
2.25.1




Amazon Development Center Germany GmbH
Krausenstr. 38
10117 Berlin
Geschaeftsfuehrung: Christian Schlaeger, Jonathan Weiss
Eingetragen am Amtsgericht Charlottenburg unter HRB 149173 B
Sitz: Berlin
Ust-ID: DE 289 237 879



