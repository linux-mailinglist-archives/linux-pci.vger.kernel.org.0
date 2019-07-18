Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8257F6CC2F
	for <lists+linux-pci@lfdr.de>; Thu, 18 Jul 2019 11:48:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389761AbfGRJqI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 18 Jul 2019 05:46:08 -0400
Received: from smtp-fw-2101.amazon.com ([72.21.196.25]:21585 "EHLO
        smtp-fw-2101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726383AbfGRJqI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 18 Jul 2019 05:46:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1563443167; x=1594979167;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=5licKhyrtTT9Nqk0kB5a0SgjPD7e3ijAeDp3JKdy7ys=;
  b=hzEH1RqpupB/n9biZpIrXzvDuZbBJU/Ar2QWhJxb7+tvXFIiWE2ZPaPm
   9wEp3bH+8UeozpHhElAlGAJBjiwwTUcmFy0gXvzJcNCt7+SVKZTpi483p
   R8MkFQgkrswa13B+mA5ZAhhN1XNVUiZYPbIDRMl7LpXEhE+56y5HrTVzA
   E=;
X-IronPort-AV: E=Sophos;i="5.64,276,1559520000"; 
   d="scan'208";a="742323362"
Received: from iad6-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-1d-f273de60.us-east-1.amazon.com) ([10.124.125.2])
  by smtp-border-fw-out-2101.iad2.amazon.com with ESMTP; 18 Jul 2019 09:46:04 +0000
Received: from EX13MTAUWA001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan2.iad.amazon.com [10.40.159.162])
        by email-inbound-relay-1d-f273de60.us-east-1.amazon.com (Postfix) with ESMTPS id DC97EA27F3;
        Thu, 18 Jul 2019 09:46:01 +0000 (UTC)
Received: from EX13D13UWA001.ant.amazon.com (10.43.160.136) by
 EX13MTAUWA001.ant.amazon.com (10.43.160.118) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 18 Jul 2019 09:46:01 +0000
Received: from u9ff250417f405e.ant.amazon.com (10.43.162.67) by
 EX13D13UWA001.ant.amazon.com (10.43.160.136) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 18 Jul 2019 09:45:55 +0000
From:   Jonathan Chocron <jonnyc@amazon.com>
To:     <lorenzo.pieralisi@arm.com>, <bhelgaas@google.com>,
        <jingoohan1@gmail.com>, <gustavo.pimentel@synopsys.com>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>
CC:     <dwmw@amazon.co.uk>, <benh@kernel.crashing.org>,
        <alisaidi@amazon.com>, <ronenk@amazon.com>, <barakw@amazon.com>,
        <talel@amazon.com>, <hanochu@amazon.com>, <hhhawa@amazon.com>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <jonnyc@amazon.com>
Subject: [PATCH v2 2/8] PCI: Add ACS quirk for Amazon Annapurna Labs root ports
Date:   Thu, 18 Jul 2019 12:45:25 +0300
Message-ID: <20190718094531.21423-3-jonnyc@amazon.com>
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

From: Ali Saidi <alisaidi@amazon.com>

The Amazon's Annapurna Labs root ports don't advertise an ACS
capability, but they don't allow peer-to-peer transactions and do
validate bus numbers through the SMMU. Additionally, it's not possible
for one RP to pass traffic to another RP.

Signed-off-by: Ali Saidi <alisaidi@amazon.com>
Signed-off-by: Jonathan Chocron <jonnyc@amazon.com>
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

