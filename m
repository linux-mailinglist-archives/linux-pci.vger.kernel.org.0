Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7CB3E7150D
	for <lists+linux-pci@lfdr.de>; Tue, 23 Jul 2019 11:26:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387921AbfGWJ0J (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 23 Jul 2019 05:26:09 -0400
Received: from smtp-fw-6001.amazon.com ([52.95.48.154]:40507 "EHLO
        smtp-fw-6001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387874AbfGWJ0I (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 23 Jul 2019 05:26:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1563873967; x=1595409967;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=2GJlucczclkdq9MNyN1luyz8JSNTe9FaZ7yShbzyobA=;
  b=kXkFul/CZfT056i6s1XzC6GPmnTFgUg6uflrFkeNGMI4ClYCxiYp+Kwv
   5MPEeENYNhhHFlJzjwblMsqhhuTOwK3R8tfQJWW679eWUQcCx1D5P7N+C
   +KqoEN89exVDLOl4/XlQj1xn/W9UAjxIYcYLPNKUo5kHJC0N8Hpz4MhEm
   0=;
X-IronPort-AV: E=Sophos;i="5.64,298,1559520000"; 
   d="scan'208";a="406177514"
Received: from iad6-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-2a-f14f4a47.us-west-2.amazon.com) ([10.124.125.6])
  by smtp-border-fw-out-6001.iad6.amazon.com with ESMTP; 23 Jul 2019 09:26:06 +0000
Received: from EX13MTAUWA001.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan2.pdx.amazon.com [10.170.41.162])
        by email-inbound-relay-2a-f14f4a47.us-west-2.amazon.com (Postfix) with ESMTPS id 7748BA20A4;
        Tue, 23 Jul 2019 09:26:05 +0000 (UTC)
Received: from EX13D13UWA001.ant.amazon.com (10.43.160.136) by
 EX13MTAUWA001.ant.amazon.com (10.43.160.58) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Tue, 23 Jul 2019 09:26:05 +0000
Received: from u9ff250417f405e.ant.amazon.com (10.43.160.245) by
 EX13D13UWA001.ant.amazon.com (10.43.160.136) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Tue, 23 Jul 2019 09:25:59 +0000
From:   Jonathan Chocron <jonnyc@amazon.com>
To:     <lorenzo.pieralisi@arm.com>, <bhelgaas@google.com>,
        <jingoohan1@gmail.com>, <gustavo.pimentel@synopsys.com>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>
CC:     <dwmw@amazon.co.uk>, <benh@kernel.crashing.org>,
        <alisaidi@amazon.com>, <ronenk@amazon.com>, <barakw@amazon.com>,
        <talel@amazon.com>, <hanochu@amazon.com>, <hhhawa@amazon.com>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <jonnyc@amazon.com>
Subject: [PATCH v3 4/8] PCI: Add quirk to disable MSI-X support for Amazon's Annapurna Labs Root Port
Date:   Tue, 23 Jul 2019 12:25:29 +0300
Message-ID: <20190723092529.11310-5-jonnyc@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190723092529.11310-1-jonnyc@amazon.com>
References: <20190723092529.11310-1-jonnyc@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.160.245]
X-ClientProxiedBy: EX13D24UWB004.ant.amazon.com (10.43.161.4) To
 EX13D13UWA001.ant.amazon.com (10.43.160.136)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The Root Port (identified by [1c36:0032]) doesn't support MSI-X. On some
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

Signed-off-by: Jonathan Chocron <jonnyc@amazon.com>
Reviewed-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
---
 drivers/pci/quirks.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 23672680dba7..11f843aa96b3 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -2925,6 +2925,21 @@ DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATTANSIC, 0x10a1,
 			quirk_msi_intx_disable_qca_bug);
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATTANSIC, 0xe091,
 			quirk_msi_intx_disable_qca_bug);
+
+/*
+ * Amazon's Annapurna Labs 1c36:0031 Root Ports don't support MSI-X, so it
+ * should be disabled on platforms where the device (mistakenly) advertises it.
+ *
+ * The 0031 device id is reused for other non Root Port device types,
+ * therefore the quirk is registered for the PCI_CLASS_BRIDGE_PCI class.
+ */
+static void quirk_al_msi_disable(struct pci_dev *dev)
+{
+	dev->no_msi = 1;
+	pci_warn(dev, "Disabling MSI-X\n");
+}
+DECLARE_PCI_FIXUP_CLASS_FINAL(PCI_VENDOR_ID_AMAZON_ANNAPURNA_LABS, 0x0031,
+			      PCI_CLASS_BRIDGE_PCI, 8, quirk_al_msi_disable);
 #endif /* CONFIG_PCI_MSI */
 
 /*
-- 
2.17.1

