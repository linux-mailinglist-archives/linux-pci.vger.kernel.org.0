Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0E52D65971
	for <lists+linux-pci@lfdr.de>; Thu, 11 Jul 2019 16:55:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728792AbfGKOzS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 11 Jul 2019 10:55:18 -0400
Received: from smtp-fw-2101.amazon.com ([72.21.196.25]:64396 "EHLO
        smtp-fw-2101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727612AbfGKOzS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 11 Jul 2019 10:55:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1562856916; x=1594392916;
  h=from:to:cc:message-id:in-reply-to:references:
   mime-version:subject:resent-from:resent-cc:date:
   content-transfer-encoding;
  bh=2uWtMbSEWSR31BNfuisTHPZlDNIB9iB1H2qKNaw569g=;
  b=coaZ6wBN6nHeLhkHm6p9kpGDbUIoDx1ujhslPD9u1XozENEFZhblqX+C
   Tor66DRYvD18VYmeSMJMmzeQYzenU+dgopbHKxQUnlNWnOmATjXgx8j3e
   xOJ7DgZrWINycGcGWh3Tud/sSWSSNW8RwJBAxcZZGc4OFAi6oq3/VthHc
   4=;
X-IronPort-AV: E=Sophos;i="5.62,478,1554768000"; 
   d="scan'208";a="741352753"
Received: from iad6-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-2c-4e7c8266.us-west-2.amazon.com) ([10.124.125.2])
  by smtp-border-fw-out-2101.iad2.amazon.com with ESMTP; 11 Jul 2019 14:55:15 +0000
Received: from EX13MTAUWB001.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan2.pdx.amazon.com [10.170.41.162])
        by email-inbound-relay-2c-4e7c8266.us-west-2.amazon.com (Postfix) with ESMTPS id 56061A1C73;
        Thu, 11 Jul 2019 14:55:15 +0000 (UTC)
Received: from EX13D24UWB001.ant.amazon.com (10.43.161.93) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.207) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 11 Jul 2019 14:55:14 +0000
Received: from EX13MTAUWB001.ant.amazon.com (10.43.161.207) by
 EX13D24UWB001.ant.amazon.com (10.43.161.93) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 11 Jul 2019 14:55:14 +0000
Received: from u9ff250417f405e.ant.amazon.com (10.107.0.52) by
 mail-relay.amazon.com (10.43.161.249) with Microsoft SMTP Server id
 15.0.1367.3 via Frontend Transport; Thu, 11 Jul 2019 14:55:13 +0000
Received: from EX13D13UWB002.ant.amazon.com (10.43.161.21) by
 EX13D13UWA001.ant.amazon.com (10.43.160.136) with Microsoft SMTP Server
 (TLS) id 15.0.1367.3 via Mailbox Transport; Wed, 10 Jul 2019 16:45:35 +0000
Received: from EX13MTAUWB001.ant.amazon.com (10.43.161.207) by
 EX13D13UWB002.ant.amazon.com (10.43.161.21) with Microsoft SMTP Server
 (TLS) id 15.0.1367.3; Wed, 10 Jul 2019 16:45:35 +0000
Received: from email-inbound-relay-2b-859fe132.us-west-2.amazon.com
 (10.25.10.214) by mail-relay.amazon.com (10.43.161.249) with Microsoft SMTP
 Server id 15.0.1367.3 via Frontend Transport; Wed, 10 Jul 2019 16:45:35
 +0000
Received: by email-inbound-relay-2b-859fe132.us-west-2.amazon.com (Postfix)
        id EEDAC221DD6; Wed, 10 Jul 2019 16:45:33 +0000 (UTC)
Received: from u9ff250417f405e.ant.amazon.com
 (pdx2-ws-svc-lb17-vlan3.amazon.com [10.247.140.70]) by
 email-inbound-relay-2b-859fe132.us-west-2.amazon.com (Postfix) with ESMTPS
 id 63DF3221DC4; Wed, 10 Jul 2019 16:45:33 +0000 (UTC)
Received: from u9ff250417f405e.ant.amazon.com (localhost [127.0.0.1]) by
 u9ff250417f405e.ant.amazon.com (8.15.2/8.15.2/Debian-10) with ESMTP id
 x6AGjT1b021486; Wed, 10 Jul 2019 19:45:29 +0300
Received: (from jonnyc@localhost)
        by u9ff250417f405e.ant.amazon.com (8.15.2/8.15.2/Submit) id x6AGjRdN021449;
        Wed, 10 Jul 2019 19:45:27 +0300
From:   Jonathan Chocron <jonnyc@amazon.com>
To:     <lorenzo.pieralisi@arm.com>, <bhelgaas@google.com>,
        <jingoohan1@gmail.com>, <gustavo.pimentel@synopsys.com>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>
CC:     <dwmw@amazon.co.uk>, <benh@kernel.crashing.org>,
        <alisaidi@amazon.com>, <ronenk@amazon.com>, <barakw@amazon.com>,
        <talel@amazon.com>, <hanochu@amazon.com>, <hhhawa@amazon.com>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <jonnyc@amazon.com>
Message-ID: <20190710164519.17883-3-jonnyc@amazon.com>
In-Reply-To: <20190710164519.17883-1-jonnyc@amazon.com>
References: <20190710164519.17883-1-jonnyc@amazon.com>
Content-Type: text/plain
MIME-Version: 1.0
Subject: [PATCH 2/8] PCI: Add ACS quirk for Amazon Annapurna Labs root ports
Date:   Thu, 11 Jul 2019 17:55:12 +0300
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Content-Transfer-Encoding: quoted-printable
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
index c66c0ca446c4..11850b030637 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -4366,6 +4366,23 @@ static int pci_quirk_qcom_rp_acs(struct pci_dev *dev=
, u16 acs_flags)
 	return ret;
 }
=20
+static int pci_quirk_al_acs(struct pci_dev *dev, u16 acs_flags)
+{
+	/*
+	 * Amazon's Annapurna Labs root ports don't include an ACS capability,
+	 * but do include ACS-like functionality. The hardware doesn't support
+	 * peer-to-peer transactions via the root port and each has a unique
+	 * segment number.
+	 * Additionally, the root ports cannot send traffic to each other.
+	 */
+	acs_flags &=3D ~(PCI_ACS_RR | PCI_ACS_CR | PCI_ACS_SV | PCI_ACS_UF);
+
+	if (pci_pcie_type(dev) !=3D PCI_EXP_TYPE_ROOT_PORT)
+		return -ENOTTY;
+
+	return acs_flags ? 0 : 1;
+}
+
 /*
  * Sunrise Point PCH root ports implement ACS, but unfortunately as shown =
in
  * the datasheet (Intel 100 Series Chipset Family PCH Datasheet, Vol. 2,
@@ -4559,6 +4576,8 @@ static const struct pci_dev_acs_enabled {
 	{ PCI_VENDOR_ID_AMPERE, 0xE00A, pci_quirk_xgene_acs },
 	{ PCI_VENDOR_ID_AMPERE, 0xE00B, pci_quirk_xgene_acs },
 	{ PCI_VENDOR_ID_AMPERE, 0xE00C, pci_quirk_xgene_acs },
+	/* Amazon Annapurna Labs */
+	{ PCI_VENDOR_ID_AMAZON_ANNAPURNA_LABS, 0x0031, pci_quirk_al_acs },
 	{ 0 }
 };
=20
--=20
2.17.1


