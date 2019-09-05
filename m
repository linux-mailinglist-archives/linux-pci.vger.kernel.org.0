Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D728CAA54B
	for <lists+linux-pci@lfdr.de>; Thu,  5 Sep 2019 16:01:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387634AbfIEOBK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 5 Sep 2019 10:01:10 -0400
Received: from smtp-fw-33001.amazon.com ([207.171.190.10]:39331 "EHLO
        smtp-fw-33001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726968AbfIEOBJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 5 Sep 2019 10:01:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1567692069; x=1599228069;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=HTTCbiycHpLnbjua3L1q3ej13API+hOei9U1sFU1o6E=;
  b=TCXzn6Q/UhqjXR+RdwTSiTqAkCWyUICreD5B36u5S9IbLJPA5/WcgeIQ
   ml+M3A5oBc4XbEBrBdzxsDvN3Qx0DWvsGkrIiNPfrSxMnPR7X8DMkzADC
   boihNQKgHmND7j61AeYvtCRkWGWpElRY7rCqZoFxMAuVe8Tckbu4nvO4d
   8=;
X-IronPort-AV: E=Sophos;i="5.64,470,1559520000"; 
   d="scan'208";a="827733331"
Received: from sea3-co-svc-lb6-vlan2.sea.amazon.com (HELO email-inbound-relay-1a-af6a10df.us-east-1.amazon.com) ([10.47.22.34])
  by smtp-border-fw-out-33001.sea14.amazon.com with ESMTP; 05 Sep 2019 14:01:07 +0000
Received: from EX13MTAUWA001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan3.iad.amazon.com [10.40.159.166])
        by email-inbound-relay-1a-af6a10df.us-east-1.amazon.com (Postfix) with ESMTPS id 3EB5AA0724;
        Thu,  5 Sep 2019 14:01:03 +0000 (UTC)
Received: from EX13D13UWA001.ant.amazon.com (10.43.160.136) by
 EX13MTAUWA001.ant.amazon.com (10.43.160.58) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 5 Sep 2019 14:01:03 +0000
Received: from u9ff250417f405e.ant.amazon.com (10.43.160.20) by
 EX13D13UWA001.ant.amazon.com (10.43.160.136) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 5 Sep 2019 14:00:56 +0000
From:   Jonathan Chocron <jonnyc@amazon.com>
To:     <lorenzo.pieralisi@arm.com>, <bhelgaas@google.com>,
        <jingoohan1@gmail.com>, <gustavo.pimentel@synopsys.com>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>
CC:     <andrew.murray@arm.com>, <dwmw@amazon.co.uk>,
        <benh@kernel.crashing.org>, <alisaidi@amazon.com>,
        <ronenk@amazon.com>, <barakw@amazon.com>, <talel@amazon.com>,
        <hanochu@amazon.com>, <hhhawa@amazon.com>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <jonnyc@amazon.com>
Subject: [PATCH v5 4/7] PCI: Add quirk to disable MSI-X support for Amazon's Annapurna Labs Root Port
Date:   Thu, 5 Sep 2019 17:00:18 +0300
Message-ID: <20190905140018.5139-5-jonnyc@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190905140018.5139-1-jonnyc@amazon.com>
References: <20190905140018.5139-1-jonnyc@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.160.20]
X-ClientProxiedBy: EX13D06UWA002.ant.amazon.com (10.43.160.143) To
 EX13D13UWA001.ant.amazon.com (10.43.160.136)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The Root Port (identified by [1c36:0031]) doesn't support MSI-X. On some
platforms it is configured to not advertise the capability at all, while
on others it (mistakenly) does. This causes a panic during
initialization by the pcieport driver, since it tries to configure the
MSI-X capability. Specifically, when trying to access the MSI-X table
a "non-existing addr" exception occurs.

Example stacktrace snippet:

[    1.632363] SError Interrupt on CPU2, code 0xbf000000 -- SError
[    1.632364] CPU: 2 PID: 1 Comm: swapper/0 Not tainted 5.2.0-rc1-Jonny-14847-ge76f1d4a1828-dirty #33
[    1.632365] Hardware name: Annapurna Labs Alpine V3 EVP (DT)
[    1.632365] pstate: 80000005 (Nzcv daif -PAN -UAO)
[    1.632366] pc : __pci_enable_msix_range+0x4e4/0x608
[    1.632367] lr : __pci_enable_msix_range+0x498/0x608
[    1.632367] sp : ffffff80117db700
[    1.632368] x29: ffffff80117db700 x28: 0000000000000001
[    1.632370] x27: 0000000000000001 x26: 0000000000000000
[    1.632372] x25: ffffffd3e9d8c0b0 x24: 0000000000000000
[    1.632373] x23: 0000000000000000 x22: 0000000000000000
[    1.632375] x21: 0000000000000001 x20: 0000000000000000
[    1.632376] x19: ffffffd3e9d8c000 x18: ffffffffffffffff
[    1.632378] x17: 0000000000000000 x16: 0000000000000000
[    1.632379] x15: ffffff80116496c8 x14: ffffffd3e9844503
[    1.632380] x13: ffffffd3e9844502 x12: 0000000000000038
[    1.632382] x11: ffffffffffffff00 x10: 0000000000000040
[    1.632384] x9 : ffffff801165e270 x8 : ffffff801165e268
[    1.632385] x7 : 0000000000000002 x6 : 00000000000000b2
[    1.632387] x5 : ffffffd3e9d8c2c0 x4 : 0000000000000000
[    1.632388] x3 : 0000000000000000 x2 : 0000000000000000
[    1.632390] x1 : 0000000000000000 x0 : ffffffd3e9844680
[    1.632392] Kernel panic - not syncing: Asynchronous SError Interrupt
[    1.632393] CPU: 2 PID: 1 Comm: swapper/0 Not tainted 5.2.0-rc1-Jonny-14847-ge76f1d4a1828-dirty #33
[    1.632394] Hardware name: Annapurna Labs Alpine V3 EVP (DT)
[    1.632394] Call trace:
[    1.632395]  dump_backtrace+0x0/0x140
[    1.632395]  show_stack+0x14/0x20
[    1.632396]  dump_stack+0xa8/0xcc
[    1.632396]  panic+0x140/0x334
[    1.632397]  nmi_panic+0x6c/0x70
[    1.632398]  arm64_serror_panic+0x74/0x88
[    1.632398]  __pte_error+0x0/0x28
[    1.632399]  el1_error+0x84/0xf8
[    1.632400]  __pci_enable_msix_range+0x4e4/0x608
[    1.632400]  pci_alloc_irq_vectors_affinity+0xdc/0x150
[    1.632401]  pcie_port_device_register+0x2b8/0x4e0
[    1.632402]  pcie_portdrv_probe+0x34/0xf0

Notice that this quirk also disables MSI (which may work, but hasn't
been tested nor has a current use case), since currently there is no
standard way to disable only MSI-X.

Signed-off-by: Jonathan Chocron <jonnyc@amazon.com>
Reviewed-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Reviewed-by: Andrew Murray <andrew.murray@arm.com>
---
 drivers/pci/quirks.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 8fe765592943..5a8ea5fdeae7 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -2977,6 +2977,24 @@ DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATTANSIC, 0x10a1,
 			quirk_msi_intx_disable_qca_bug);
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATTANSIC, 0xe091,
 			quirk_msi_intx_disable_qca_bug);
+
+/*
+ * Amazon's Annapurna Labs 1c36:0031 Root Ports don't support MSI-X, so it
+ * should be disabled on platforms where the device (mistakenly) advertises it.
+ *
+ * Notice that this quirk also disables MSI (which may work, but hasn't been
+ * tested), since currently there is no standard way to disable only MSI-X.
+ *
+ * The 0031 device id is reused for other non Root Port device types,
+ * therefore the quirk is registered for the PCI_CLASS_BRIDGE_PCI class.
+ */
+static void quirk_al_msi_disable(struct pci_dev *dev)
+{
+	dev->no_msi = 1;
+	pci_warn(dev, "Disabling MSI/MSI-X\n");
+}
+DECLARE_PCI_FIXUP_CLASS_FINAL(PCI_VENDOR_ID_AMAZON_ANNAPURNA_LABS, 0x0031,
+			      PCI_CLASS_BRIDGE_PCI, 8, quirk_al_msi_disable);
 #endif /* CONFIG_PCI_MSI */
 
 /*
-- 
2.17.1

