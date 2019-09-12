Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 77C96B0F66
	for <lists+linux-pci@lfdr.de>; Thu, 12 Sep 2019 15:01:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731816AbfILNB4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 12 Sep 2019 09:01:56 -0400
Received: from smtp-fw-6002.amazon.com ([52.95.49.90]:28313 "EHLO
        smtp-fw-6002.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730454AbfILNBz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 12 Sep 2019 09:01:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1568293315; x=1599829315;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=jct20q5lVCpJ9JMjhtyUVKj8GV6yFUouYDE9nzby1vo=;
  b=RE3m/EJvQTzrG6937LGLAqE+skCRJxW/f8RgfYGAWL3XBK3Zx37mgmhQ
   3PPbTaCtCM/66/zr9RLNX2CphvVhwAILlpo1JlzXOPEZCQfmhp0V0JZe3
   Bmmhc9nSAyPUSNSjmJzoGyo9W2TVt3gUdqw67xHflJBfRwPvmQVg8LE5a
   Q=;
X-IronPort-AV: E=Sophos;i="5.64,497,1559520000"; 
   d="scan'208";a="420818798"
Received: from iad6-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-1d-2c665b5d.us-east-1.amazon.com) ([10.124.125.6])
  by smtp-border-fw-out-6002.iad6.amazon.com with ESMTP; 12 Sep 2019 13:01:54 +0000
Received: from EX13MTAUWA001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan3.iad.amazon.com [10.40.159.166])
        by email-inbound-relay-1d-2c665b5d.us-east-1.amazon.com (Postfix) with ESMTPS id F035BA2240;
        Thu, 12 Sep 2019 13:01:50 +0000 (UTC)
Received: from EX13D13UWA001.ant.amazon.com (10.43.160.136) by
 EX13MTAUWA001.ant.amazon.com (10.43.160.58) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 12 Sep 2019 13:01:50 +0000
Received: from u9ff250417f405e.ant.amazon.com (10.43.161.82) by
 EX13D13UWA001.ant.amazon.com (10.43.160.136) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 12 Sep 2019 13:01:44 +0000
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
Subject: [PATCH v6 3/7] PCI/VPD: Prevent VPD access for Amazon's Annapurna Labs Root Port
Date:   Thu, 12 Sep 2019 16:00:41 +0300
Message-ID: <20190912130042.14597-4-jonnyc@amazon.com>
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

The Amazon Annapurna Labs PCIe Root Port exposes the VPD capability,
but there is no actual support for it.

Trying to access the VPD (for example, as part of lspci -vv or when
reading the vpd sysfs file), results in the following warning print:

  pcieport 0001:00:00.0: VPD access failed.  This is likely a firmware bug on this device.  Contact the card vendor for a firmware update

Signed-off-by: Jonathan Chocron <jonnyc@amazon.com>
Reviewed-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Reviewed-by: Andrew Murray <andrew.murray@arm.com>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/vpd.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/pci/vpd.c b/drivers/pci/vpd.c
index 4963c2e2bd4c..7915d10f9aa1 100644
--- a/drivers/pci/vpd.c
+++ b/drivers/pci/vpd.c
@@ -571,6 +571,12 @@ DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_LSI_LOGIC, 0x005f, quirk_blacklist_vpd);
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATTANSIC, PCI_ANY_ID,
 		quirk_blacklist_vpd);
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_QLOGIC, 0x2261, quirk_blacklist_vpd);
+/*
+ * The Amazon Annapurna Labs 0x0031 device id is reused for other non Root Port
+ * device types, so the quirk is registered for the PCI_CLASS_BRIDGE_PCI class.
+ */
+DECLARE_PCI_FIXUP_CLASS_FINAL(PCI_VENDOR_ID_AMAZON_ANNAPURNA_LABS, 0x0031,
+			      PCI_CLASS_BRIDGE_PCI, 8, quirk_blacklist_vpd);
 
 /*
  * For Broadcom 5706, 5708, 5709 rev. A nics, any read beyond the
-- 
2.17.1

