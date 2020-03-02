Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2689E17630B
	for <lists+linux-pci@lfdr.de>; Mon,  2 Mar 2020 19:46:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727479AbgCBSq3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 2 Mar 2020 13:46:29 -0500
Received: from smtp-fw-6002.amazon.com ([52.95.49.90]:56252 "EHLO
        smtp-fw-6002.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727126AbgCBSq3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 2 Mar 2020 13:46:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1583174788; x=1614710788;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=zo+xgKja6kmPxHfkNHFXpC45vKnXxIgJgU/su5JdReI=;
  b=f6y485F3J3AonfQxysgWrgIhGTyTFE13yarn7e9QVJerGwcK/cXBOhgE
   SIMKFRV9nqid8Wh3GP7XEd484iYaPQkHul+ChwdyZOxa0LGT/DG4+Rnuv
   nI9/HQB0bLQpXdQlwDz6hUr2XKleSo4LEKIlm5DBYhNyjXlq/4LEcJX3T
   I=;
IronPort-SDR: 7NsYMCMRNrT/UHe7DWpaREhel35xf/uLqGgyEbI40WuPU2ES+S0dS0606b9McECDA/HIeXIlum
 ovC5OrGm0ZDA==
X-IronPort-AV: E=Sophos;i="5.70,507,1574121600"; 
   d="scan'208";a="19142125"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-2b-5bdc5131.us-west-2.amazon.com) ([10.43.8.6])
  by smtp-border-fw-out-6002.iad6.amazon.com with ESMTP; 02 Mar 2020 18:46:26 +0000
Received: from EX13MTAUEA002.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan3.pdx.amazon.com [10.170.41.166])
        by email-inbound-relay-2b-5bdc5131.us-west-2.amazon.com (Postfix) with ESMTPS id BB6F7A16C0;
        Mon,  2 Mar 2020 18:46:24 +0000 (UTC)
Received: from EX13D12EUC004.ant.amazon.com (10.43.164.129) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1236.3; Mon, 2 Mar 2020 18:46:10 +0000
Received: from EX13MTAUWB001.ant.amazon.com (10.43.161.207) by
 EX13D12EUC004.ant.amazon.com (10.43.164.129) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Mon, 2 Mar 2020 18:46:08 +0000
Received: from u961addbe640f56.ant.amazon.com (10.28.84.111) by
 mail-relay.amazon.com (10.43.161.249) with Microsoft SMTP Server id
 15.0.1367.3 via Frontend Transport; Mon, 2 Mar 2020 18:46:05 +0000
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
Subject: [PATCH v2 13/17] PCI: Cache CRS Software Visibiliy in struct pci_dev
Date:   Mon, 2 Mar 2020 19:44:25 +0100
Message-ID: <20200302184429.12880-14-stanspas@amazon.com>
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

Arguably, since CRS SV is a capability of Root Ports and determines
how Root Ports will handle incoming CRS Completions, it makes more
sense to store this flag in the struct pci bus that represents the
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
index 16dbfff2092e..1763e98625b9 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -386,6 +386,9 @@ struct pci_dev {
 						   bit manually */
 	unsigned int    ignore_reset_delay_on_sx_resume:1; /* Cached value from
 							      pci_host_bridge */
+	unsigned int	crssv_enabled:1;	/* Configuration Request Retry
+						   Status Software Visibility
+						   enabled on (parent) bridge */
 	unsigned int    delay[PCI_INIT_EVENT_COUNT]; /* minimum waiting time
 							after various events
 							in ms */
-- 
2.25.1




Amazon Development Center Germany GmbH
Krausenstr. 38
10117 Berlin
Geschaeftsfuehrung: Christian Schlaeger, Jonathan Weiss
Eingetragen am Amtsgericht Charlottenburg unter HRB 149173 B
Sitz: Berlin
Ust-ID: DE 289 237 879



