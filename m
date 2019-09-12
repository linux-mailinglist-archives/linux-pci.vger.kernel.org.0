Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B83E2B0F6D
	for <lists+linux-pci@lfdr.de>; Thu, 12 Sep 2019 15:02:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731953AbfILNCD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 12 Sep 2019 09:02:03 -0400
Received: from smtp-fw-33001.amazon.com ([207.171.190.10]:32525 "EHLO
        smtp-fw-33001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731915AbfILNCC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 12 Sep 2019 09:02:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1568293322; x=1599829322;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=p10e5DCgVjw+kle1XJQu91IESvd80sBGwG6u5Jh5HO4=;
  b=JVqg7BDRZevaft2BrS+Y81LQDw3O3ch5FYu+r9hDKcSKISAMBqs2ztqd
   meNQX/wmesOWv0PHaZ8xiiBkIvhLhyfLG+Df+N8Ns+QT6b7sDzCFa5Uwr
   0PwVxcShdh0iEW+0vE5SPK+knD1UhK/3iIozSiWC7VBMHbNiXux0nxjiV
   0=;
X-IronPort-AV: E=Sophos;i="5.64,497,1559520000"; 
   d="scan'208";a="831007834"
Received: from sea3-co-svc-lb6-vlan2.sea.amazon.com (HELO email-inbound-relay-1e-62350142.us-east-1.amazon.com) ([10.47.22.34])
  by smtp-border-fw-out-33001.sea14.amazon.com with ESMTP; 12 Sep 2019 13:01:48 +0000
Received: from EX13MTAUWA001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan3.iad.amazon.com [10.40.159.166])
        by email-inbound-relay-1e-62350142.us-east-1.amazon.com (Postfix) with ESMTPS id 7B95CA2A24;
        Thu, 12 Sep 2019 13:01:45 +0000 (UTC)
Received: from EX13D13UWA001.ant.amazon.com (10.43.160.136) by
 EX13MTAUWA001.ant.amazon.com (10.43.160.58) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 12 Sep 2019 13:01:44 +0000
Received: from u9ff250417f405e.ant.amazon.com (10.43.161.82) by
 EX13D13UWA001.ant.amazon.com (10.43.160.136) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 12 Sep 2019 13:01:38 +0000
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
Subject: [PATCH v6 2/7] PCI: Add ACS quirk for Amazon Annapurna Labs root ports
Date:   Thu, 12 Sep 2019 16:00:40 +0300
Message-ID: <20190912130042.14597-3-jonnyc@amazon.com>
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

From: Ali Saidi <alisaidi@amazon.com>

The Amazon's Annapurna Labs root ports don't advertise an ACS
capability, but they don't allow peer-to-peer transactions and do
validate bus numbers through the SMMU. Additionally, it's not possible
for one RP to pass traffic to another RP.

Signed-off-by: Ali Saidi <alisaidi@amazon.com>
Signed-off-by: Jonathan Chocron <jonnyc@amazon.com>
Reviewed-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Reviewed-by: Andrew Murray <andrew.murray@arm.com>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/quirks.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index ded60757a573..2e983f2a0ee9 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -4418,6 +4418,24 @@ static int pci_quirk_qcom_rp_acs(struct pci_dev *dev, u16 acs_flags)
 	return ret;
 }
 
+static int pci_quirk_al_acs(struct pci_dev *dev, u16 acs_flags)
+{
+	if (pci_pcie_type(dev) != PCI_EXP_TYPE_ROOT_PORT)
+		return -ENOTTY;
+
+	/*
+	 * Amazon's Annapurna Labs root ports don't include an ACS capability,
+	 * but do include ACS-like functionality. The hardware doesn't support
+	 * peer-to-peer transactions via the root port and each has a unique
+	 * segment number.
+	 *
+	 * Additionally, the root ports cannot send traffic to each other.
+	 */
+	acs_flags &= ~(PCI_ACS_SV | PCI_ACS_RR | PCI_ACS_CR | PCI_ACS_UF);
+
+	return acs_flags ? 0 : 1;
+}
+
 /*
  * Sunrise Point PCH root ports implement ACS, but unfortunately as shown in
  * the datasheet (Intel 100 Series Chipset Family PCH Datasheet, Vol. 2,
@@ -4611,6 +4629,8 @@ static const struct pci_dev_acs_enabled {
 	{ PCI_VENDOR_ID_AMPERE, 0xE00A, pci_quirk_xgene_acs },
 	{ PCI_VENDOR_ID_AMPERE, 0xE00B, pci_quirk_xgene_acs },
 	{ PCI_VENDOR_ID_AMPERE, 0xE00C, pci_quirk_xgene_acs },
+	/* Amazon Annapurna Labs */
+	{ PCI_VENDOR_ID_AMAZON_ANNAPURNA_LABS, 0x0031, pci_quirk_al_acs },
 	{ 0 }
 };
 
-- 
2.17.1

