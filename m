Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4E223176309
	for <lists+linux-pci@lfdr.de>; Mon,  2 Mar 2020 19:46:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727450AbgCBSqQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 2 Mar 2020 13:46:16 -0500
Received: from smtp-fw-9102.amazon.com ([207.171.184.29]:52790 "EHLO
        smtp-fw-9102.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727126AbgCBSqQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 2 Mar 2020 13:46:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1583174776; x=1614710776;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9xqMD1N8mF24q9FbAWh4uDveX6H7dYjjMS/baY775kQ=;
  b=PqqlUm9DcbDVe2Q1ybxrTGCRrfxUJ+JfF/JeWV9X4xnP8EK3A1/6M+6B
   DO4gXf+lGlptRUkfURV6JKHD2N4yHVofEUVsRQYIo05OeSeEVVFwMO1pY
   hxcpyqNbx7RFtjlJ38oD47DqRdKsuiVR3leSWXDACH7yCJ8ZpAwc3ARq/
   s=;
IronPort-SDR: kO8HjqOLM8oqROWJwjcu+g6YR1IS+rg38zj8EgQHECQo0zDNMYwRDEeOe6+ymECVf12FftcEMI
 39xDTktKKExA==
X-IronPort-AV: E=Sophos;i="5.70,507,1574121600"; 
   d="scan'208";a="28691717"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-2b-a7fdc47a.us-west-2.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-9102.sea19.amazon.com with ESMTP; 02 Mar 2020 18:46:14 +0000
Received: from EX13MTAUEA002.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan2.pdx.amazon.com [10.170.41.162])
        by email-inbound-relay-2b-a7fdc47a.us-west-2.amazon.com (Postfix) with ESMTPS id 15E97C5D53;
        Mon,  2 Mar 2020 18:46:13 +0000 (UTC)
Received: from EX13D04EUB002.ant.amazon.com (10.43.166.51) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1236.3; Mon, 2 Mar 2020 18:45:57 +0000
Received: from EX13MTAUWB001.ant.amazon.com (10.43.161.207) by
 EX13D04EUB002.ant.amazon.com (10.43.166.51) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Mon, 2 Mar 2020 18:45:55 +0000
Received: from u961addbe640f56.ant.amazon.com (10.28.84.111) by
 mail-relay.amazon.com (10.43.161.249) with Microsoft SMTP Server id
 15.0.1367.3 via Frontend Transport; Mon, 2 Mar 2020 18:45:52 +0000
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
Subject: [PATCH v2 10/17] PCI: Use correct delay in pci_bridge_wait_for_secondary_bus
Date:   Mon, 2 Mar 2020 19:44:22 +0100
Message-ID: <20200302184429.12880-11-stanspas@amazon.com>
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



