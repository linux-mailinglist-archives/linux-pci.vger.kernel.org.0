Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2667D17770C
	for <lists+linux-pci@lfdr.de>; Tue,  3 Mar 2020 14:30:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728972AbgCCNa1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 3 Mar 2020 08:30:27 -0500
Received: from smtp-fw-6001.amazon.com ([52.95.48.154]:35759 "EHLO
        smtp-fw-6001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727894AbgCCNa1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 3 Mar 2020 08:30:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1583242227; x=1614778227;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=cBJBPVv+W+4p/cV1qgaUlMz0GLi1QkM2dp9VSDEJ5WE=;
  b=i63vrdySja3C21tsj0n2XdUT8yr1dDXn0t2QN6GL6Y4o6wq9gYtSq4Wi
   dmVMLmNyBHigGiaTW9EXeFBI8zDvEd2Pw5Tkv0tX73WiKyTmjEDRdCkWU
   tNmkHC8pUmd7GFvjxADFlVg9XI1eh7+z7Lwk+24Pumtiwa/7WuAyhPWZV
   8=;
IronPort-SDR: OrsuFgpYPMr5SbJBD+toVXzyOEkDAGU89gWRolDuCVaKx8Hh4OMKekdIfl6SXN4p7Nhzko2dFD
 9Ntw2kvZbytg==
X-IronPort-AV: E=Sophos;i="5.70,511,1574121600"; 
   d="scan'208";a="20717872"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-2c-4e7c8266.us-west-2.amazon.com) ([10.43.8.6])
  by smtp-border-fw-out-6001.iad6.amazon.com with ESMTP; 03 Mar 2020 13:30:13 +0000
Received: from EX13MTAUEA002.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan2.pdx.amazon.com [10.170.41.162])
        by email-inbound-relay-2c-4e7c8266.us-west-2.amazon.com (Postfix) with ESMTPS id 79C41A2E44;
        Tue,  3 Mar 2020 13:30:11 +0000 (UTC)
Received: from EX13D12EUC001.ant.amazon.com (10.43.164.45) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1236.3; Tue, 3 Mar 2020 13:30:00 +0000
Received: from EX13MTAUEE002.ant.amazon.com (10.43.62.24) by
 EX13D12EUC001.ant.amazon.com (10.43.164.45) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 3 Mar 2020 13:29:58 +0000
Received: from u961addbe640f56.ant.amazon.com (10.28.84.111) by
 mail-relay.amazon.com (10.43.62.224) with Microsoft SMTP Server id
 15.0.1367.3 via Frontend Transport; Tue, 3 Mar 2020 13:29:56 +0000
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
Subject: [PATCH v3 06/17] PCI: Fix us->ms conversion in pci_acpi_optimize_delay
Date:   Tue, 3 Mar 2020 14:28:41 +0100
Message-ID: <20200303132852.13184-7-stanspas@amazon.com>
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

_DSM Function 9 returns device readiness durations in microseconds.

Without this fix, integer truncation could cause msleep()-ing for up to
999us less than actually requested by the firmware.

Specifically, if the firmware specifies a 500us delay, msleep(0) would
be invoked by the users of the delay values optimized here.

Signed-off-by: Stanislav Spassov <stanspas@amazon.de>
---
 drivers/pci/pci-acpi.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
index a8fa13d6089d..b147b61c6668 100644
--- a/drivers/pci/pci-acpi.c
+++ b/drivers/pci/pci-acpi.c
@@ -1219,6 +1219,11 @@ static void pci_acpi_optimize_delay(struct pci_dev *pdev,
 				    acpi_handle handle)
 {
 	struct pci_host_bridge *bridge = pci_find_host_bridge(pdev->bus);
+	/*
+	 * _DSM 9 provides values in microseconds, but the kernel uses msleep()
+	 * when waiting, so the code below rounds up when setting value in ms
+	 */
+	u64 value_us;
 	int value;
 	union acpi_object *obj, *elements;
 
@@ -1233,12 +1238,18 @@ static void pci_acpi_optimize_delay(struct pci_dev *pdev,
 	if (obj->type == ACPI_TYPE_PACKAGE && obj->package.count == 5) {
 		elements = obj->package.elements;
 		if (elements[0].type == ACPI_TYPE_INTEGER) {
-			value = (int)elements[0].integer.value / 1000;
+			value_us = elements[0].integer.value;
+			value = (int)value_us / 1000;
+			if ((int)value_us % 1000 > 0)
+				value++;
 			if (value < PCI_PM_D3COLD_WAIT)
 				pdev->d3cold_delay = value;
 		}
 		if (elements[3].type == ACPI_TYPE_INTEGER) {
-			value = (int)elements[3].integer.value / 1000;
+			value_us = elements[3].integer.value;
+			value = (int)value_us / 1000;
+			if ((int)value_us % 1000 > 0)
+				value++;
 			if (value < PCI_PM_D3_WAIT)
 				pdev->d3_delay = value;
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



