Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E2D13116D69
	for <lists+linux-pci@lfdr.de>; Mon,  9 Dec 2019 14:00:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727527AbfLINAR convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Mon, 9 Dec 2019 08:00:17 -0500
Received: from mail-oln040092253049.outbound.protection.outlook.com ([40.92.253.49]:30694
        "EHLO APC01-SG2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727268AbfLINAR (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 9 Dec 2019 08:00:17 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Up+ht78xis5Co+579LnR55e+j3LvjM1bP1AkUK8hs+4ziUf0+raS/Cu1mAyBjPXxM8fHn50MOKTie8TvZ8347OrBXmeoBI8bE8cqzkKM4gx9bTN+UK7oV4ThbgYyBxZLDo9JEqg7Y8fyzlTHL/KwNs8VPngwveHFLi0uaM28iDzQg8xGmX6SslTDHC9zGWBoO7tu4zEKSVTTMLDY+WcLz4rRuMoMWfs9vyCLlDzXOuJK03kykK71uqe79Ha+ZXBMI3Ka/5VhL01vGT3cEyCzQFXmV0jlyiWRIINyR65Hhlp4m1+qMKphKcvAg3LpcP75BDBaFfPjssrXONEN+gtYSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D/OELDpQxPcZGJ+sYL7LWncgmwYxkHmP76LLvMuNy0E=;
 b=UoCQlt43hFrGavEjVO4ek35j+BLI2mo1iqmQM0dA4O3izfy/BjGnhriPm32ByXL8o5HH8v9TXB8jXrJMRTkUuqTpB5fuESh0d+EoLTjHvw9Mk2ggwQB8T24JV6goU7XjV2O8NEHnsi0GhzFG3aRIp/Y7rzp13SPMbYo419Fe47xgsFGdgmeRB1XRCkifYc2n+DKwSJxOIOtLnfZTAB7HKxbnW3xikDL1nXH4UjbD+MqwWFB2v2LY7EpGEFrEBmwZgETDIe2z75NFd4F+GbTBSVeTOvB592Ly9+NBDvn4vhuO7zODjlw/O603+MmHQIsTDUm6p6PpPOCr0SCm7401sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from HK2APC01FT003.eop-APC01.prod.protection.outlook.com
 (10.152.248.60) by HK2APC01HT090.eop-APC01.prod.protection.outlook.com
 (10.152.249.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2495.25; Mon, 9 Dec
 2019 13:00:11 +0000
Received: from PSXP216MB0438.KORP216.PROD.OUTLOOK.COM (10.152.248.51) by
 HK2APC01FT003.mail.protection.outlook.com (10.152.248.173) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.25 via Frontend Transport; Mon, 9 Dec 2019 13:00:11 +0000
Received: from PSXP216MB0438.KORP216.PROD.OUTLOOK.COM
 ([fe80::20ad:6646:5bcd:63c9]) by PSXP216MB0438.KORP216.PROD.OUTLOOK.COM
 ([fe80::20ad:6646:5bcd:63c9%11]) with mapi id 15.20.2516.018; Mon, 9 Dec 2019
 13:00:10 +0000
From:   Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Logan Gunthorpe <logang@deltatee.com>,
        Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
Subject: [PATCH v12 2/4] PCI: In extend_bridge_window() change available to
 new_size
Thread-Topic: [PATCH v12 2/4] PCI: In extend_bridge_window() change available
 to new_size
Thread-Index: AQHVrpCWg3aFUt9ZDEGlAJkcxWcZHQ==
Date:   Mon, 9 Dec 2019 13:00:10 +0000
Message-ID: <PSXP216MB043896A9321EDC0EC5C6874F80580@PSXP216MB0438.KORP216.PROD.OUTLOOK.COM>
Accept-Language: en-AU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SYCPR01CA0030.ausprd01.prod.outlook.com
 (2603:10c6:10:e::18) To PSXP216MB0438.KORP216.PROD.OUTLOOK.COM
 (2603:1096:300:d::20)
x-incomingtopheadermarker: OriginalChecksum:B8E8E4D305F5CA5F9FBFADDB8085BC9A52C3273AC35A60005421D1D3BF7F7E24;UpperCasedChecksum:63C8097933FAA77927E3901A5A37076C332924CB1592398B963EF552A1195128;SizeAsReceived:7614;Count:47
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [85xwPnOG6tmid0HD9eiGeyjyPwoSAti/w1kfwH9WuYL0cE8u4qm2Pkwtw4f2VZcC6vgYUI6wuXo=]
x-microsoft-original-message-id: <20191209130002.GA3011@nicholas-dell-linux>
x-ms-publictraffictype: Email
x-incomingheadercount: 47
x-eopattributedmessage: 0
x-ms-office365-filtering-correlation-id: 387a718d-39bf-47df-2060-08d77ca7b940
x-ms-exchange-slblob-mailprops: kw4jv30d2yRo2VVZljeoS8aHjULAHTRDe5X9jSqjsfHoA0Kj3RdYWEHFOtFIgunR3BPRk9g8fRZF/PjhFn9NY7ropYRD2qAWustIQffx1gvUVh97/PkCUFul/IW3LrJUXtewsw1treiG3E74kW7MdqeFMGuwDszC/HqeQ4hKe/MbTVtxZAvtPQ5qXgpmDPwZGdYELqqCN7t1i2wCQwWjAcbgG3gT3MoiEaOLRrBUNKudNC6qE2spi4+urOub5g5asVbnArmhO8x5YQljSX+gnokLbnEn+y/U2euO76kjqM8xXi7oSYnu+qTscTzNlFw1fCjeba90vAtmkhYKLv5r6KGCF5a/HsqzG2aLDIn/ui4vZoQbXtFmdXtyS2qp6HpCsY4smMQc8p1lNJN71vVlohfT2H/aUb0SFraIb7ZnIFVligKA7WIxwavKWT1D01fPumB6lFgNf8RKkO+Wmp07ZoaJFQFGrkn1ezRB41nFv8u+pznrdnle8wpgXVRNtyiHXGSKeRymRrW0/TjYaBIHWtceRZDlwafXPaHXi7+VJSoO/pHuknVZhGrcuurdfggfZCZ0KwYuGNUtwTTYzsBQ5WtldyrVhASgP56vNDfjXlAwAJTQeqSk6Vz5wrQs0TYnRscSYbqiYoTfrM3IrzmLizzIdXHsKY+94LSVvDw2AQ8=
x-ms-traffictypediagnostic: HK2APC01HT090:
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tn/XwKzuzr8/8OzC9Uvo1Na4KyStxY21itj7N9gLiJiEQuIDh7ruC9k9Yt3qTeQDlmyYHp12ITsHsiH9hYsjadEdYKKw/7IDBT07HfcCQPQZv0BuG4EQRdyhOSg2rTWYaj7ph8nJij+IY+a7NB7dgKnzysOOy+jVcZrywfzPAuJfnp/PkRJSWbX0Ijh+ChwE
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <7063E438C3EC3340A0466CC948A02314@KORP216.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 387a718d-39bf-47df-2060-08d77ca7b940
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Dec 2019 13:00:10.8443
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK2APC01HT090
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

In extend_bridge_window() change "available" parameter name to new_size.
This makes more sense as this parameter represents the new size for the
window.

Signed-off-by: Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/pci/setup-bus.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index 8c990f981..165a62a79 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -1834,14 +1834,14 @@ void __init pci_assign_unassigned_resources(void)
 
 static void extend_bridge_window(struct pci_dev *bridge, struct resource *res,
 				 struct list_head *add_list,
-				 resource_size_t available)
+				 resource_size_t new_size)
 {
 	struct pci_dev_resource *dev_res;
 
 	if (res->parent)
 		return;
 
-	if (resource_size(res) >= available)
+	if (resource_size(res) >= new_size)
 		return;
 
 	dev_res = res_to_dev_res(add_list, res);
@@ -1849,10 +1849,10 @@ static void extend_bridge_window(struct pci_dev *bridge, struct resource *res,
 		return;
 
 	/* Is there room to extend the window? */
-	if (available - resource_size(res) <= dev_res->add_size)
+	if (new_size - resource_size(res) <= dev_res->add_size)
 		return;
 
-	dev_res->add_size = available - resource_size(res);
+	dev_res->add_size = new_size - resource_size(res);
 	pci_dbg(bridge, "bridge window %pR extended by %pa\n", res,
 		&dev_res->add_size);
 }
-- 
2.24.0

