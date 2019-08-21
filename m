Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0E4C097EDF
	for <lists+linux-pci@lfdr.de>; Wed, 21 Aug 2019 17:38:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729987AbfHUPgX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 21 Aug 2019 11:36:23 -0400
Received: from smtp-fw-33001.amazon.com ([207.171.190.10]:6724 "EHLO
        smtp-fw-33001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728454AbfHUPgX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 21 Aug 2019 11:36:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1566401782; x=1597937782;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=1lQKq3hxKQkr7WB4YDlui/W/5OP1jSDsOKg2GvSonVs=;
  b=RMP6xjhCkoAbQk1iS8UXgfW9YBV1N2nP4FYxdgLrNmrVDMhx21+VwqPQ
   n7PfUJw2ihFLT0ajcKX9dJsS4aP32I8T1J3NSplrxjR0rXKcV6hKrbKX2
   bWG4gRzHW9TcTZ0OWYCw2q00nTQsGhl/7tkUYp7WGDIWlrKngD2VaTWbQ
   8=;
X-IronPort-AV: E=Sophos;i="5.64,412,1559520000"; 
   d="scan'208";a="822276216"
Received: from sea3-co-svc-lb6-vlan2.sea.amazon.com (HELO email-inbound-relay-2b-a7fdc47a.us-west-2.amazon.com) ([10.47.22.34])
  by smtp-border-fw-out-33001.sea14.amazon.com with ESMTP; 21 Aug 2019 15:36:20 +0000
Received: from EX13MTAUWA001.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan2.pdx.amazon.com [10.170.41.162])
        by email-inbound-relay-2b-a7fdc47a.us-west-2.amazon.com (Postfix) with ESMTPS id 9527DC5D92;
        Wed, 21 Aug 2019 15:36:19 +0000 (UTC)
Received: from EX13D13UWA001.ant.amazon.com (10.43.160.136) by
 EX13MTAUWA001.ant.amazon.com (10.43.160.118) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Wed, 21 Aug 2019 15:36:19 +0000
Received: from u9ff250417f405e.ant.amazon.com (10.43.160.100) by
 EX13D13UWA001.ant.amazon.com (10.43.160.136) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Wed, 21 Aug 2019 15:36:13 +0000
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
Subject: [PATCH v4 2/7] PCI: Add ACS quirk for Amazon Annapurna Labs root ports
Date:   Wed, 21 Aug 2019 18:35:42 +0300
Message-ID: <20190821153545.17635-3-jonnyc@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190821153545.17635-1-jonnyc@amazon.com>
References: <20190821153545.17635-1-jonnyc@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.160.100]
X-ClientProxiedBy: EX13D18UWC004.ant.amazon.com (10.43.162.77) To
 EX13D13UWA001.ant.amazon.com (10.43.160.136)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Ali Saidi <alisaidi@amazon.com>

The Amazon's Annapurna Labs root ports don't advertise an ACS
capability, but they don't allow peer-to-peer transactions and do
validate bus numbers through the SMMU. Additionally, it's not possible
for one RP to pass traffic to another RP.

Signed-off-by: Ali Saidi <alisaidi@amazon.com>
Signed-off-by: Jonathan Chocron <jonnyc@amazon.com>
Reviewed-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
---
 drivers/pci/quirks.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 208aacf39329..23672680dba7 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -4366,6 +4366,23 @@ static int pci_quirk_qcom_rp_acs(struct pci_dev *dev, u16 acs_flags)
 	return ret;
 }
 
+static int pci_quirk_al_acs(struct pci_dev *dev, u16 acs_flags)
+{
+	/*
+	 * Amazon's Annapurna Labs root ports don't include an ACS capability,
+	 * but do include ACS-like functionality. The hardware doesn't support
+	 * peer-to-peer transactions via the root port and each has a unique
+	 * segment number.
+	 * Additionally, the root ports cannot send traffic to each other.
+	 */
+	acs_flags &= ~(PCI_ACS_RR | PCI_ACS_CR | PCI_ACS_SV | PCI_ACS_UF);
+
+	if (pci_pcie_type(dev) != PCI_EXP_TYPE_ROOT_PORT)
+		return -ENOTTY;
+
+	return acs_flags ? 0 : 1;
+}
+
 /*
  * Sunrise Point PCH root ports implement ACS, but unfortunately as shown in
  * the datasheet (Intel 100 Series Chipset Family PCH Datasheet, Vol. 2,
@@ -4559,6 +4576,8 @@ static const struct pci_dev_acs_enabled {
 	{ PCI_VENDOR_ID_AMPERE, 0xE00A, pci_quirk_xgene_acs },
 	{ PCI_VENDOR_ID_AMPERE, 0xE00B, pci_quirk_xgene_acs },
 	{ PCI_VENDOR_ID_AMPERE, 0xE00C, pci_quirk_xgene_acs },
+	/* Amazon Annapurna Labs */
+	{ PCI_VENDOR_ID_AMAZON_ANNAPURNA_LABS, 0x0031, pci_quirk_al_acs },
 	{ 0 }
 };
 
-- 
2.17.1

