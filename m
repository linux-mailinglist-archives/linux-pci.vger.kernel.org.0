Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 54E1617630E
	for <lists+linux-pci@lfdr.de>; Mon,  2 Mar 2020 19:46:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727509AbgCBSqb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 2 Mar 2020 13:46:31 -0500
Received: from smtp-fw-6001.amazon.com ([52.95.48.154]:47672 "EHLO
        smtp-fw-6001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727439AbgCBSqb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 2 Mar 2020 13:46:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1583174790; x=1614710790;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xEtEknNf0OvkG/Jr4HiAOZ9QFQWLGLKe0eJdRuCqzpA=;
  b=X0X/Z6W1V5SYR2gzWAwTyv+yowNNAea7giG3mC7fIzWngj9hLgenkF3I
   8/p4lhz8TDNY+pIXCgnlPH/MPxDe7UXshA/Gxi/veiXLlQKJCmpQfE6Gb
   UO5sxp/LhZZGd6UO6BltPton0CzKxG30GH2UlwOyynKCmfeRh1YWaM7WL
   M=;
IronPort-SDR: m9r/eMg8Nk5FAUcH142fnKXd5lkAs8VzuDiP8d6YM4XJtBbqxjVo3rWMjXMKrBsEKfx9Fu2f+0
 5em+LSvR7URQ==
X-IronPort-AV: E=Sophos;i="5.70,507,1574121600"; 
   d="scan'208";a="20582197"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-2a-22cc717f.us-west-2.amazon.com) ([10.43.8.6])
  by smtp-border-fw-out-6001.iad6.amazon.com with ESMTP; 02 Mar 2020 18:46:05 +0000
Received: from EX13MTAUEA002.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan3.pdx.amazon.com [10.170.41.166])
        by email-inbound-relay-2a-22cc717f.us-west-2.amazon.com (Postfix) with ESMTPS id 5A5C9A2687;
        Mon,  2 Mar 2020 18:46:04 +0000 (UTC)
Received: from EX13D04EUA003.ant.amazon.com (10.43.165.148) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1236.3; Mon, 2 Mar 2020 18:45:40 +0000
Received: from EX13MTAUWB001.ant.amazon.com (10.43.161.207) by
 EX13D04EUA003.ant.amazon.com (10.43.165.148) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Mon, 2 Mar 2020 18:45:38 +0000
Received: from u961addbe640f56.ant.amazon.com (10.28.84.111) by
 mail-relay.amazon.com (10.43.161.249) with Microsoft SMTP Server id
 15.0.1367.3 via Frontend Transport; Mon, 2 Mar 2020 18:45:35 +0000
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
Subject: [PATCH v2 06/17] PCI: Fix us->ms conversion in pci_acpi_optimize_delay
Date:   Mon, 2 Mar 2020 19:44:18 +0100
Message-ID: <20200302184429.12880-7-stanspas@amazon.com>
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
index a8fa13d6089d..508924377bff 100644
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
+			value = (int)(value_us / 1000);
+			if (value_us % 1000 > 0)
+				value++;
 			if (value < PCI_PM_D3COLD_WAIT)
 				pdev->d3cold_delay = value;
 		}
 		if (elements[3].type == ACPI_TYPE_INTEGER) {
-			value = (int)elements[3].integer.value / 1000;
+			value_us = elements[3].integer.value;
+			value = (int)(value_us / 1000);
+			if (value_us % 1000 > 0)
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



