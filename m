Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B9C491953F4
	for <lists+linux-pci@lfdr.de>; Fri, 27 Mar 2020 10:27:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726920AbgC0J1j (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 27 Mar 2020 05:27:39 -0400
Received: from ZXSHCAS2.zhaoxin.com ([203.148.12.82]:20800 "EHLO
        ZXSHCAS2.zhaoxin.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726698AbgC0J1j (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 27 Mar 2020 05:27:39 -0400
Received: from zxbjmbx1.zhaoxin.com (10.29.252.163) by ZXSHCAS2.zhaoxin.com
 (10.28.252.162) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1261.35; Fri, 27 Mar
 2020 17:11:57 +0800
Received: from raymond-pc.zhaoxin.com (10.29.28.62) by zxbjmbx1.zhaoxin.com
 (10.29.252.163) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1261.35; Fri, 27 Mar
 2020 17:11:57 +0800
From:   Raymond Pang <RaymondPang-oc@zhaoxin.com>
To:     <bhelgaas@google.com>, <linux-pci@vger.kernel.org>
CC:     <TonyWWang-oc@zhaoxin.com>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 3/3] PCI: Add ACS quirk for Root/Downstream Ports
Date:   Fri, 27 Mar 2020 17:11:48 +0800
Message-ID: <20200327091148.5190-4-RaymondPang-oc@zhaoxin.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200327091148.5190-1-RaymondPang-oc@zhaoxin.com>
References: <20200327091148.5190-1-RaymondPang-oc@zhaoxin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.29.28.62]
X-ClientProxiedBy: ZXSHCAS2.zhaoxin.com (10.28.252.162) To
 zxbjmbx1.zhaoxin.com (10.29.252.163)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Many Zhaoxin Root Ports and Switch Downstream Ports do provide ACS-like
capability but have no ACS Capability Structure. Peer-to-Peer
transactions could be blocked between these ports, so add quirk
to make devices behind them could be assigned to different IOMMU group.

Signed-off-by: Raymond Pang <RaymondPang-oc@zhaoxin.com>
---
 drivers/pci/quirks.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 3f06496a3d4c..49cf6e943f16 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -4464,6 +4464,30 @@ static int pci_quirk_xgene_acs(struct pci_dev *dev, u16 acs_flags)
 	return pci_acs_ctrl_enabled(acs_flags,
 		PCI_ACS_SV | PCI_ACS_RR | PCI_ACS_CR | PCI_ACS_UF);
 }
+
+/*
+ * Many Zhaoxin Root Ports and Switch Downstream Ports have no ACS capability.
+ * But the implementation could block peer-to-peer transactions between them
+ * and provide ACS-like functionality.
+ */
+static int  pci_quirk_zhaoxin_pcie_ports_acs(struct pci_dev *dev, u16 acs_flags)
+{
+
+	if (!pci_is_pcie(dev) ||
+	    ((pci_pcie_type(dev) != PCI_EXP_TYPE_ROOT_PORT) &&
+	     (pci_pcie_type(dev) != PCI_EXP_TYPE_DOWNSTREAM)))
+		return -ENOTTY;
+
+	switch (dev->device) {
+	case 0x0710 ... 0x071e:
+	case 0x0721:
+	case 0x0723 ... 0x0732:
+		return pci_acs_ctrl_enabled(acs_flags,
+			PCI_ACS_SV | PCI_ACS_RR | PCI_ACS_CR | PCI_ACS_UF);
+	}
+
+	return false;
+}
 
 /*
  * Many Intel PCH Root Ports do provide ACS-like features to disable peer
@@ -4771,6 +4795,8 @@ static const struct pci_dev_acs_enabled {
 	{ PCI_VENDOR_ID_ZHAOXIN, 0x3038, pci_quirk_mf_endpoint_acs },
 	{ PCI_VENDOR_ID_ZHAOXIN, 0x3104, pci_quirk_mf_endpoint_acs },
 	{ PCI_VENDOR_ID_ZHAOXIN, 0x9083, pci_quirk_mf_endpoint_acs },
+	/* Zhaoxin Root/Downstream Ports */
+	{ PCI_VENDOR_ID_ZHAOXIN, PCI_ANY_ID, pci_quirk_zhaoxin_pcie_ports_acs },
 	{ 0 }
 };
 
-- 
2.26.0

