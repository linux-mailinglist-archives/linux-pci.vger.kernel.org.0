Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6D975B0F6A
	for <lists+linux-pci@lfdr.de>; Thu, 12 Sep 2019 15:02:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731938AbfILNCC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 12 Sep 2019 09:02:02 -0400
Received: from smtp-fw-2101.amazon.com ([72.21.196.25]:41191 "EHLO
        smtp-fw-2101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730454AbfILNCC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 12 Sep 2019 09:02:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1568293321; x=1599829321;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=0wVQUJEX0IIEn7zwGQ77yG4BMVdun+xmbgM7B9MW4g0=;
  b=oUiN9hY41h/QdQv47e8Z8oXQ20/Jml34uk7FEkPlu7/9E0lKXc1SX5zp
   I/hvQS9rWpfFfUWqi1P19UGyq6l00fZvrP5Hljz3jwgui30hY7dfOX1Ej
   I+rhSBC0hUyHh1q04bB7JvZKGcJDsv6dwm1A1zJ/rjdgcaDwZGV7sx5HW
   k=;
X-IronPort-AV: E=Sophos;i="5.64,497,1559520000"; 
   d="scan'208";a="750389519"
Received: from iad6-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-1d-5dd976cd.us-east-1.amazon.com) ([10.124.125.2])
  by smtp-border-fw-out-2101.iad2.amazon.com with ESMTP; 12 Sep 2019 13:02:00 +0000
Received: from EX13MTAUWA001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan3.iad.amazon.com [10.40.159.166])
        by email-inbound-relay-1d-5dd976cd.us-east-1.amazon.com (Postfix) with ESMTPS id DE5C3A1CDE;
        Thu, 12 Sep 2019 13:01:56 +0000 (UTC)
Received: from EX13D13UWA001.ant.amazon.com (10.43.160.136) by
 EX13MTAUWA001.ant.amazon.com (10.43.160.58) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 12 Sep 2019 13:01:56 +0000
Received: from u9ff250417f405e.ant.amazon.com (10.43.161.82) by
 EX13D13UWA001.ant.amazon.com (10.43.160.136) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 12 Sep 2019 13:01:50 +0000
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
Subject: [PATCH v6 4/7] PCI: Add quirk to disable MSI-X support for Amazon's Annapurna Labs Root Port
Date:   Thu, 12 Sep 2019 16:00:42 +0300
Message-ID: <20190912130042.14597-5-jonnyc@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190912130042.14597-1-jonnyc@amazon.com>
References: <20190912130042.14597-1-jonnyc@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.161.82]
X-ClientProxiedBy: EX13D02UWC003.ant.amazon.com (10.43.162.199) To
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

  SError Interrupt on CPU2, code 0xbf000000 -- SError
  CPU: 2 PID: 1 Comm: swapper/0 Not tainted 5.2.0-rc1-Jonny-14847-ge76f1d4a1828-dirty #33
  Hardware name: Annapurna Labs Alpine V3 EVP (DT)
  pstate: 80000005 (Nzcv daif -PAN -UAO)
  pc : __pci_enable_msix_range+0x4e4/0x608
  lr : __pci_enable_msix_range+0x498/0x608
  sp : ffffff80117db700
  x29: ffffff80117db700 x28: 0000000000000001
  x27: 0000000000000001 x26: 0000000000000000
  x25: ffffffd3e9d8c0b0 x24: 0000000000000000
  x23: 0000000000000000 x22: 0000000000000000
  x21: 0000000000000001 x20: 0000000000000000
  x19: ffffffd3e9d8c000 x18: ffffffffffffffff
  x17: 0000000000000000 x16: 0000000000000000
  x15: ffffff80116496c8 x14: ffffffd3e9844503
  x13: ffffffd3e9844502 x12: 0000000000000038
  x11: ffffffffffffff00 x10: 0000000000000040
  x9 : ffffff801165e270 x8 : ffffff801165e268
  x7 : 0000000000000002 x6 : 00000000000000b2
  x5 : ffffffd3e9d8c2c0 x4 : 0000000000000000
  x3 : 0000000000000000 x2 : 0000000000000000
  x1 : 0000000000000000 x0 : ffffffd3e9844680
  Kernel panic - not syncing: Asynchronous SError Interrupt
  CPU: 2 PID: 1 Comm: swapper/0 Not tainted 5.2.0-rc1-Jonny-14847-ge76f1d4a1828-dirty #33
  Hardware name: Annapurna Labs Alpine V3 EVP (DT)
  Call trace:
   dump_backtrace+0x0/0x140
   show_stack+0x14/0x20
   dump_stack+0xa8/0xcc
   panic+0x140/0x334
   nmi_panic+0x6c/0x70
   arm64_serror_panic+0x74/0x88
   __pte_error+0x0/0x28
   el1_error+0x84/0xf8
   __pci_enable_msix_range+0x4e4/0x608
   pci_alloc_irq_vectors_affinity+0xdc/0x150
   pcie_port_device_register+0x2b8/0x4e0
   pcie_portdrv_probe+0x34/0xf0

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
index 2e983f2a0ee9..c1077e806291 100644
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

