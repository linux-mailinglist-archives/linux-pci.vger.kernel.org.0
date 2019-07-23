Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 56DC071509
	for <lists+linux-pci@lfdr.de>; Tue, 23 Jul 2019 11:26:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387895AbfGWJ0H (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 23 Jul 2019 05:26:07 -0400
Received: from smtp-fw-9101.amazon.com ([207.171.184.25]:35518 "EHLO
        smtp-fw-9101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726397AbfGWJ0H (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 23 Jul 2019 05:26:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1563873967; x=1595409967;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=yPw/cZErk19SmOK/njpJRQGVQoT+U5XdF/Qgj3DD9Ng=;
  b=IQaFz+RariQRRupHd74Covvcfp0e9lMtaq41vJAsn05u8xq254kGNnuO
   45qYW/+PE/sJlilgCc1729fUilToWGiDWeEDdaUVOHmDZYC1n1/0uBbpU
   81ywdl5kP8jc3m5A8L0feuM7V72/I0qn138jVv1ACjOk1ZuzsVoXrlEOT
   Y=;
X-IronPort-AV: E=Sophos;i="5.64,298,1559520000"; 
   d="scan'208";a="817888383"
Received: from sea3-co-svc-lb6-vlan2.sea.amazon.com (HELO email-inbound-relay-2c-397e131e.us-west-2.amazon.com) ([10.47.22.34])
  by smtp-border-fw-out-9101.sea19.amazon.com with ESMTP; 23 Jul 2019 09:26:01 +0000
Received: from EX13MTAUWA001.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan3.pdx.amazon.com [10.170.41.166])
        by email-inbound-relay-2c-397e131e.us-west-2.amazon.com (Postfix) with ESMTPS id CE906A28CD;
        Tue, 23 Jul 2019 09:26:00 +0000 (UTC)
Received: from EX13D13UWA001.ant.amazon.com (10.43.160.136) by
 EX13MTAUWA001.ant.amazon.com (10.43.160.58) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Tue, 23 Jul 2019 09:26:00 +0000
Received: from u9ff250417f405e.ant.amazon.com (10.43.160.245) by
 EX13D13UWA001.ant.amazon.com (10.43.160.136) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Tue, 23 Jul 2019 09:25:55 +0000
From:   Jonathan Chocron <jonnyc@amazon.com>
To:     <lorenzo.pieralisi@arm.com>, <bhelgaas@google.com>,
        <jingoohan1@gmail.com>, <gustavo.pimentel@synopsys.com>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>
CC:     <dwmw@amazon.co.uk>, <benh@kernel.crashing.org>,
        <alisaidi@amazon.com>, <ronenk@amazon.com>, <barakw@amazon.com>,
        <talel@amazon.com>, <hanochu@amazon.com>, <hhhawa@amazon.com>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <jonnyc@amazon.com>
Subject: [PATCH v3 3/8] PCI/VPD: Add VPD release quirk for Amazon's Annapurna Labs Root Port
Date:   Tue, 23 Jul 2019 12:25:28 +0300
Message-ID: <20190723092529.11310-4-jonnyc@amazon.com>
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

The Amazon Annapurna Labs PCIe Root Port exposes the VPD capability,
but there is no actual support for it.

The reason for not using the already existing quirk_blacklist_vpd()
is that, although this fails pci_vpd_read/write, the 'vpd' sysfs
entry still exists. When running lspci -vv, for example, this
results in the following error:

pcilib: sysfs_read_vpd: read failed: Input/output error

This quirk removes the sysfs entry, which avoids the error print.

Signed-off-by: Jonathan Chocron <jonnyc@amazon.com>
Reviewed-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
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

