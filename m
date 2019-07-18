Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C90C76CC34
	for <lists+linux-pci@lfdr.de>; Thu, 18 Jul 2019 11:48:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726383AbfGRJqN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 18 Jul 2019 05:46:13 -0400
Received: from smtp-fw-9101.amazon.com ([207.171.184.25]:1649 "EHLO
        smtp-fw-9101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389916AbfGRJqN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 18 Jul 2019 05:46:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1563443172; x=1594979172;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=d26x2/Gpk0dyNI/8oMVneagfnoX5uzMFBx8ab6+69ZU=;
  b=Qr3hyzxAnagxc7neYtTAfsyvlt/o6abSnZGF6G5gb4a3nUYdttlxBUjc
   udLUExuM/0VuRL6EDY/9zqrsCqi2prd5l0j4nCL8FYWLsBqiC1mXidUcx
   LX+Iqe4qXR8g9RygtoB9N7E9Vdlo5TUkubxQR7VlVSfuAPU2+By/pOIoG
   0=;
X-IronPort-AV: E=Sophos;i="5.64,276,1559520000"; 
   d="scan'208";a="816920590"
Received: from sea3-co-svc-lb6-vlan2.sea.amazon.com (HELO email-inbound-relay-1a-821c648d.us-east-1.amazon.com) ([10.47.22.34])
  by smtp-border-fw-out-9101.sea19.amazon.com with ESMTP; 18 Jul 2019 09:46:11 +0000
Received: from EX13MTAUWA001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan3.iad.amazon.com [10.40.159.166])
        by email-inbound-relay-1a-821c648d.us-east-1.amazon.com (Postfix) with ESMTPS id 2E6F2A1DEB;
        Thu, 18 Jul 2019 09:46:07 +0000 (UTC)
Received: from EX13D13UWA001.ant.amazon.com (10.43.160.136) by
 EX13MTAUWA001.ant.amazon.com (10.43.160.118) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 18 Jul 2019 09:46:07 +0000
Received: from u9ff250417f405e.ant.amazon.com (10.43.162.67) by
 EX13D13UWA001.ant.amazon.com (10.43.160.136) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 18 Jul 2019 09:46:01 +0000
From:   Jonathan Chocron <jonnyc@amazon.com>
To:     <lorenzo.pieralisi@arm.com>, <bhelgaas@google.com>,
        <jingoohan1@gmail.com>, <gustavo.pimentel@synopsys.com>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>
CC:     <dwmw@amazon.co.uk>, <benh@kernel.crashing.org>,
        <alisaidi@amazon.com>, <ronenk@amazon.com>, <barakw@amazon.com>,
        <talel@amazon.com>, <hanochu@amazon.com>, <hhhawa@amazon.com>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <jonnyc@amazon.com>
Subject: [PATCH v2 3/8] PCI/VPD: Add VPD release quirk for Amazon's Annapurna Labs Root Port
Date:   Thu, 18 Jul 2019 12:45:26 +0300
Message-ID: <20190718094531.21423-4-jonnyc@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190718094531.21423-1-jonnyc@amazon.com>
References: <20190718094531.21423-1-jonnyc@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.162.67]
X-ClientProxiedBy: EX13P01UWA004.ant.amazon.com (10.43.160.127) To
 EX13D13UWA001.ant.amazon.com (10.43.160.136)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The Amazon Annapurna Labs PCIe Root Port exposes the VPD capability,
but there is no actual support for it.

The reason for not using the already existing quirk_blacklist_vpd()
is that, although this fails pci_vpd_read/write, the 'vpd' sysfs
entry still exists. When running lspci -vv, for example, this
results in the following error:

pcilib: sysfs_read_vpd: read failed: Input/output error

This quirk removes the sysfs entry, which avoids the error print.

Signed-off-by: Jonathan Chocron <jonnyc@amazon.com>
---
 drivers/pci/vpd.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/pci/vpd.c b/drivers/pci/vpd.c
index 4963c2e2bd4c..c23a8ec08db9 100644
--- a/drivers/pci/vpd.c
+++ b/drivers/pci/vpd.c
@@ -644,4 +644,20 @@ static void quirk_chelsio_extend_vpd(struct pci_dev *dev)
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_CHELSIO, PCI_ANY_ID,
 			quirk_chelsio_extend_vpd);
 
+static void quirk_al_vpd_release(struct pci_dev *dev)
+{
+	if (dev->vpd) {
+		pci_vpd_release(dev);
+		dev->vpd = NULL;
+		pci_warn(dev, FW_BUG "Releasing VPD capability (No support for VPD read/write transactions)\n");
+	}
+}
+
+/*
+ * The 0031 device id is reused for other non Root Port device types,
+ * therefore the quirk is registered for the PCI_CLASS_BRIDGE_PCI class.
+ */
+DECLARE_PCI_FIXUP_CLASS_FINAL(PCI_VENDOR_ID_AMAZON_ANNAPURNA_LABS, 0x0031,
+			      PCI_CLASS_BRIDGE_PCI, 8, quirk_al_vpd_release);
+
 #endif
-- 
2.17.1

