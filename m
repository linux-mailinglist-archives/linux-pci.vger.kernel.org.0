Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0674213CB7E
	for <lists+linux-pci@lfdr.de>; Wed, 15 Jan 2020 18:57:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729163AbgAOR5w convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Wed, 15 Jan 2020 12:57:52 -0500
Received: from mail-oln040092254070.outbound.protection.outlook.com ([40.92.254.70]:6186
        "EHLO APC01-PU1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726574AbgAOR5v (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 15 Jan 2020 12:57:51 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NOHZBmw5KcLQRbBe3gy7iGjNgEhd9QJjJGh57ibBjgUqNFWPckhha0wWmhF3Ovt8XU9lwkHvKyYFSFJKENhscjbga92QB9exf1/ej53gJcbKTsuKtgZzUFh1cHOuYzGaj5tAzFgDqBhMJUoZMQtb63nTlo0k0LF+/0n614vn6OWWvVpvcEWgcLrkCi50HZqn1Uinzi6c+xTIHfPRiABTgOlvFwIgOdd92a8XY/E7LXYdkhI46jQKYdc2YzuWdz8e614x5tAhhfQ17W3OqaWiBbbHMIkcETeP15lgYEQ/O+1v9vEsq2nYtMzCpFpZJ8ruUgmXUgNUNXsybA4BgVS46w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SjJMCK5zDEwZvpHPtIKuV2lBmosv6lmDGSUAJ7ANHMQ=;
 b=gVRj3Q1eoFo0ncvQx22NYQw1WKOVeIAuUf+l8zQqZVFQgFmGaDbFE5Vq+3WsC/l5RG2vDV9TQ2wOhpQAaHcHgudq9DIeAXTt1qsp3JeaV45mV0epWNATLWLXMu+mAQyIquxE92VOEPDGRR3ei/dCgx146yAsmQKPDlmvLNrHAldjhiZ8DAipzJR5Oxf/5GrPn6KOsLHeUYBcRfapGaTH93cm0dIQyuxHzrVLpkOHQVcAjXnA7vsqQOL9A4jviVvLW0FtPkdo5Gt5uiEIIO8nP7PTZh3VtWuV9pSWzoV8VwLB/NWPGIuVpelDH1DJpZCWSXT6+HNUP8O2AiX/eNgjrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from PU1APC01FT115.eop-APC01.prod.protection.outlook.com
 (10.152.252.59) by PU1APC01HT237.eop-APC01.prod.protection.outlook.com
 (10.152.253.155) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2602.11; Wed, 15 Jan
 2020 17:57:47 +0000
Received: from PSXP216MB0438.KORP216.PROD.OUTLOOK.COM (10.152.252.57) by
 PU1APC01FT115.mail.protection.outlook.com (10.152.252.208) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2602.11 via Frontend Transport; Wed, 15 Jan 2020 17:57:47 +0000
Received: from PSXP216MB0438.KORP216.PROD.OUTLOOK.COM
 ([fe80::20ad:6646:5bcd:63c9]) by PSXP216MB0438.KORP216.PROD.OUTLOOK.COM
 ([fe80::20ad:6646:5bcd:63c9%11]) with mapi id 15.20.2623.018; Wed, 15 Jan
 2020 17:57:47 +0000
Received: from nicholas-dell-linux (61.69.138.108) by ME2PR01CA0010.ausprd01.prod.outlook.com (2603:10c6:201:15::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2644.19 via Frontend Transport; Wed, 15 Jan 2020 17:57:45 +0000
From:   Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Logan Gunthorpe <logang@deltatee.com>,
        Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
Subject: [PATCH v2 3/4] PCI: Change extend_bridge_window() to set resource
 size directly
Thread-Topic: [PATCH v2 3/4] PCI: Change extend_bridge_window() to set
 resource size directly
Thread-Index: AQHVy81LGw6FLCbpeUmB0IsDxRkf/Q==
Date:   Wed, 15 Jan 2020 17:57:47 +0000
Message-ID: <PSXP216MB0438679CD51C0B198CDA231480370@PSXP216MB0438.KORP216.PROD.OUTLOOK.COM>
Accept-Language: en-AU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: ME2PR01CA0010.ausprd01.prod.outlook.com
 (2603:10c6:201:15::22) To PSXP216MB0438.KORP216.PROD.OUTLOOK.COM
 (2603:1096:300:d::20)
x-incomingtopheadermarker: OriginalChecksum:108CAED3704C9038B08BF6ADA1E99581A814D7149148976F0B4C02554A5593A4;UpperCasedChecksum:E280B6263045668F4894F8623CAC32A48C65CDCA29F317399441FB05CBBB6CDC;SizeAsReceived:7808;Count:48
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [5ziGKHdJgjerydAC4PVE9gud1jqcSCvu]
x-microsoft-original-message-id: <20200115175739.GA4523@nicholas-dell-linux>
x-ms-publictraffictype: Email
x-incomingheadercount: 48
x-eopattributedmessage: 0
x-ms-office365-filtering-correlation-id: 9e9c392e-8ba4-447a-22a3-08d799e46dec
x-ms-exchange-slblob-mailprops: mBy7Mai7yE5NBIk4d/kkaYf19Kf5IaBBWDTNUgNopOB7xn1ElHWtuVPWnZEztijD/yOPxzm9qLEqMfoL51u+V0pB76zx0oc0wAfxKbI0eMq91g5RhSvL5r6RfHacK+EsTNF3k/5vvjcGgxkGU1LgIv5gIB8Gs5V4JGI2K18oDxVmh9ZYPAZ6+chS7kyku6Ul1pa0XLLM9j7UmbTXhWRyWHh7amncHb+jvjJ159j+CG7QIAemtZFZm+XQRronXpGk2Up7gZwlNsPjM6jqK2JUlzZLzrAVk6w8+SVBcyCLTwrPY/FmfD9k04Li+15syAcKa/x//dyxM3x05rn5PI736eHy3Wna+1XrwMT4jhIkN4awzsUZGpYf6GNoI8Saa0P1dBkj7NZf7s1+HVjedcbh6Y/fm6QkhzFDqfMmcKDhrADPImen6T9yMrzsytSsuzeFDDHZj/nq2w4d7IMeLDo5uFNQmkFUfvzKjqZRDHHFSZTwvPtX1OEhZEEvq09VlKmunCTGutecCBQsK4adRzio1rrzEHwvTUdEG6XRphGMbMH45YrNVJS9JYcJZZcJ+6Q0D2n4kpv6CFuTIf7/3XRVxxRw3ih1DHIEecVsRQr+eLwUjtuIpXfvVhpest7qUhxFEerdQFv4eNYg/Jl9PNrEPg8V3UqJXcwGEX4ZvB9ZavtFCIoZmnbjH7aL/H2axTKV4N8EGADgMlE5RTAOeBATEl6a9abZMw88
x-ms-traffictypediagnostic: PU1APC01HT237:
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NBuyq9gDb7YB8Dg34p6fT3YdrxLuvpfGaxXo40tFLS4fYz9o6Sg09xx4gBeTmNyqptygbqUSIwTBXoF5MJnY8wy3Bk3n/svjYuJ3qPQ5Wkc3tAoEShu9q1EgFpc74O0R6svJuQdoYI06Zf61PEMGD2cK0HH/vLjqTbnQKsMPQxAFsv2QBE4z8maT6NsKmyYh
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <EFCDFEA867145B4691D91A34E1105D49@KORP216.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e9c392e-8ba4-447a-22a3-08d799e46dec
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jan 2020 17:57:47.5438
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PU1APC01HT237
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Change extend_bridge_window() to set resource size directly instead of
using additional resource lists.

This is required in preparation for the next patch [0] which will allow
the resource to shrink. If we do not make this change, the next patch
will need to have complicated logic to handle shrinking the overall size
using size and add_size.

Remove the resource from add_list, as a zero-sized additional resource
is redundant.

Update comment in pci_bus_distribute_available_resources() to reflect
the above changes.

[0]
PCI: Allow extend_bridge_window() to shrink resource if necessary

Signed-off-by: Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
---
 drivers/pci/setup-bus.c | 23 +++++++----------------
 1 file changed, 7 insertions(+), 16 deletions(-)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index de43815be..50d14921a 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -1836,7 +1836,7 @@ static void adjust_bridge_window(struct pci_dev *bridge, struct resource *res,
 				 struct list_head *add_list,
 				 resource_size_t new_size)
 {
-	struct pci_dev_resource *dev_res;
+	resource_size_t add_size;
 
 	if (res->parent)
 		return;
@@ -1844,17 +1844,10 @@ static void adjust_bridge_window(struct pci_dev *bridge, struct resource *res,
 	if (resource_size(res) >= new_size)
 		return;
 
-	dev_res = res_to_dev_res(add_list, res);
-	if (!dev_res)
-		return;
-
-	/* Is there room to extend the window? */
-	if (new_size - resource_size(res) <= dev_res->add_size)
-		return;
-
-	dev_res->add_size = new_size - resource_size(res);
-	pci_dbg(bridge, "bridge window %pR extended by %pa\n", res,
-		&dev_res->add_size);
+	add_size = new_size - resource_size(res);
+	pci_dbg(bridge, "bridge window %pR extended by %pa\n", res, &add_size);
+	res->end = res->start + new_size - 1;
+	remove_from_list(add_list, res);
 }
 
 static void pci_bus_distribute_available_resources(struct pci_bus *bus,
@@ -1890,10 +1883,8 @@ static void pci_bus_distribute_available_resources(struct pci_bus *bus,
 			mmio_pref.end + 1);
 
 	/*
-	 * Update additional resource list (add_list) to fill all the
-	 * extra resource space available for this port except the space
-	 * calculated in __pci_bus_size_bridges() which covers all the
-	 * devices currently connected to the port and below.
+	 * Now that we have adjusted for alignment, update the bridge window
+	 * resources to fill as much remaining resource space as possible.
 	 */
 	adjust_bridge_window(bridge, io_res, add_list, resource_size(&io));
 	adjust_bridge_window(bridge, mmio_res, add_list, resource_size(&mmio));
-- 
2.25.0

