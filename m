Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 805B713CB79
	for <lists+linux-pci@lfdr.de>; Wed, 15 Jan 2020 18:57:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726587AbgAOR5N convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Wed, 15 Jan 2020 12:57:13 -0500
Received: from mail-oln040092255074.outbound.protection.outlook.com ([40.92.255.74]:7290
        "EHLO APC01-HK2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726574AbgAOR5N (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 15 Jan 2020 12:57:13 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YdHKp7XMaxB0PNvw+F063xvDM2suQAgT0GxS0r2X/yufASQN0L74HWx6fJ57qxZJizXSer5y0j5poUldRreV/FyU9W2Urq6EreUj/FnABGFwaIQ6sjBqUrgz1CbjKsV0sfAqBBHPqyVJp+MwvtRahthp9xbX43wS8p4Txz1Q/wyt8iuR52xU7Cj94lFYRtBjYrHy6Z8iG/KLEKsevTyfTDqagxc1RH0NfzWusGsXHyDJYcXJqj4ED9tlMzmzpWuTd2PaYK7b8UTtXwUY1o4eHZUknkib9k1zIOAthgSKTprlydjxIRDERUx0p3JdW9EeY3SC7ZUqTkiSaR4QBkGCQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NnxnZTseYNRSorcEdPv6JpSUmglTmlSUs21F/UpBx10=;
 b=hPpTFjF2y2nK0LtmoMKpWp5DjNCZFwPVvySSanOF4EnqPcSkbPAXWHYuj4MufgUIjAik0q1/2dr7SA3Sb0e0Fj5iHJD4Q1P/fC1KAkYVtb3J7WwG6D2Ua7rTNG6CJPnjgBzhc7NA7OkWNqROO9kxQ4QahBgWqlYFptBkV8k7JTsJg/iYLqlP07NV3DTTA3CUeFLphhOPsvoBuh4BNnNEuljZzoqOtaCbCpe3GiuotPmA3lFRi0LHiCOFf7LBsT4qTSHfsis/97kugt5OxkPxvxDQ3uJC7kReNWvRhORThEWQx18OL6H99Pc81riWJ4d2qTXBgsHhsFO49Ot/pH+BuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from PU1APC01FT115.eop-APC01.prod.protection.outlook.com
 (10.152.252.51) by PU1APC01HT173.eop-APC01.prod.protection.outlook.com
 (10.152.253.186) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2602.11; Wed, 15 Jan
 2020 17:57:08 +0000
Received: from PSXP216MB0438.KORP216.PROD.OUTLOOK.COM (10.152.252.57) by
 PU1APC01FT115.mail.protection.outlook.com (10.152.252.208) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2602.11 via Frontend Transport; Wed, 15 Jan 2020 17:57:08 +0000
Received: from PSXP216MB0438.KORP216.PROD.OUTLOOK.COM
 ([fe80::20ad:6646:5bcd:63c9]) by PSXP216MB0438.KORP216.PROD.OUTLOOK.COM
 ([fe80::20ad:6646:5bcd:63c9%11]) with mapi id 15.20.2623.018; Wed, 15 Jan
 2020 17:57:08 +0000
Received: from nicholas-dell-linux (61.69.138.108) by ME2PR01CA0092.ausprd01.prod.outlook.com (2603:10c6:201:2d::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2644.20 via Frontend Transport; Wed, 15 Jan 2020 17:57:06 +0000
From:   Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Logan Gunthorpe <logang@deltatee.com>,
        Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
Subject: [PATCH v2 1/4] PCI: In extend_bridge_window() change available to
 new_size
Thread-Topic: [PATCH v2 1/4] PCI: In extend_bridge_window() change available
 to new_size
Thread-Index: AQHVy800b6sbH4fyHEqte7GWmI1Irg==
Date:   Wed, 15 Jan 2020 17:57:08 +0000
Message-ID: <PSXP216MB0438A47D6153AD2CFAA64D9780370@PSXP216MB0438.KORP216.PROD.OUTLOOK.COM>
Accept-Language: en-AU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: ME2PR01CA0092.ausprd01.prod.outlook.com
 (2603:10c6:201:2d::32) To PSXP216MB0438.KORP216.PROD.OUTLOOK.COM
 (2603:1096:300:d::20)
x-incomingtopheadermarker: OriginalChecksum:19D8AE965C6259C3EF6F392DA44C51ED1D0226EDEAB295E60CF79DF5285D27BA;UpperCasedChecksum:C8529EBF9C6159CA1CB35642E0E155950603E3CF8D6F05EA69383FB954D46DA4;SizeAsReceived:7773;Count:48
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [xaRsmw/bvQv/n80rB9Ht9vX7d1RWx2NG]
x-microsoft-original-message-id: <20200115175701.GA4514@nicholas-dell-linux>
x-ms-publictraffictype: Email
x-incomingheadercount: 48
x-eopattributedmessage: 0
x-ms-office365-filtering-correlation-id: 00efbd71-66ba-4d77-3955-08d799e456e2
x-ms-exchange-slblob-mailprops: mBy7Mai7yE5NBIk4d/kkaYf19Kf5IaBBc+KQ89c3PucBbkKhGIRbQguA6DdcNNtz5kBi/j0D0n/FMQHJCfq+NL7l8PsXM0UmScmkRUOSmWP26ey1ciNn6fImSVG1YTeCmDgFEFlT6P3LzzG4/j1w8EiY+oYAjye2mCYnbm4mARZR1N/tY01vt3+OkI6I93aYv5RUN8huvJP1aIb+WC6z84b+GtDf8gvFsAMf3dtsgnywnoQUD1W2HogwL2VLzj7nHnBs3rE6Gkr00QERjeFStF7Pdx7xdds6Dy9AxBAhgWT+fmqNdFCynM6AH/P0SOQw8zxDJO09V/0b0T3JJqtZfs05OACG3NCerpTzAx36GN6Z+cLCsLAMtpn2C5TJl4yn0z7InsCyEaCMOkj60SgWXk9vSpsWIknFbOz3najA5i3cJ8fhQSzyP3gNOIKxBQ8Iz29mq1HAS0DewJW/bPqsqG8PfihcY9nSnlt9rLV3Aaux6+oQrZeZDbaGBXuWf6oJKHJouOga4/o5Aa+HOxD9n+i4HrSFcB4+em522wnUSTffQx9256DGDvp9kHc8KD/Hvd3GOORF1LT6fMMVe17jc43dLCnIefqDg5JXKd/Ps+qjU00YW+GNcC1yzI3/2A+aQ/6lZup7uquf8zHU7uIezdZk8jHz2kUJtRH8CBYerbk3XMQLiTQ7SYQl/X8pwahiAYovSQYhHYaCZMklRHdINukBwppJTzbL
x-ms-traffictypediagnostic: PU1APC01HT173:
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: oHkLjS2vSBdOaV5EAWQol0De2Cgmo0CHW1mBfdesy3PKKC8FE0jp7ayfb++NYsbV/Pqc1hQNv1kh4mDn+YnH7e/dymdADiiL1l6t4cW7mJAgVM5yw4l37+lXvIEX7Z1iSPW4Rkr7guoxPditAmz5AkGwqHmqMJ7jwbsMXkbX1BAREpl/vk+gDAza4Juk4khk
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <6682A45BBFE5BC41960215529C46F0C7@KORP216.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 00efbd71-66ba-4d77-3955-08d799e456e2
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jan 2020 17:57:08.8632
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PU1APC01HT173
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

In extend_bridge_window() change "available" parameter name to
"new_size". This makes more sense as this parameter represents the new
size for the window.

Signed-off-by: Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/pci/setup-bus.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index 8b39b9ebb..ed5055ef7 100644
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
2.25.0

