Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 15307FB231
	for <lists+linux-pci@lfdr.de>; Wed, 13 Nov 2019 15:08:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727386AbfKMOIa convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Wed, 13 Nov 2019 09:08:30 -0500
Received: from mail-oln040092253083.outbound.protection.outlook.com ([40.92.253.83]:36672
        "EHLO APC01-SG2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727442AbfKMOI3 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 13 Nov 2019 09:08:29 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GizK5QadgCSGa2Tdi9zODWCgs2D8JwvOBPzYYJJNbAdzD40OuPdp/ocuuGOnSx6b2f9VQjUicloMAdgl7z5C1pyL2DUZ0msXavr4D01N1lzZNk8TCWYYNnhJmnbBh/Lct3R1eR11Hdbtxu8AlKW/kqH5B3CKaLbHlWZ5uua/qxh+6P+B+JhOsUmjtnWrqpl56JVb9QMVelk8zJ8j4e4nMBVvmFDt1YQp61KHJdXM6BVnG1ff8ijzaKIOW2kxVEMK6Gu5mjC7FO+vf8C/4TnDu2apxsHUYVl1h8SONodcHWET7jBmQfymJYMCiF+k7TiGexEKjAhgsFULNm7DPa8mjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=581ZR/gUczRXx47GZHadEmMQl+GyaR1Q7Eagms+qo5s=;
 b=FYX2wM+GtlIxpZbi5r6eVsOyr+2xb3Adbg2E/drxbVfHajXhaho8u9AYc/D6fbSU7jnOTbgW23ifkcPxX+4gNXjHf8Q7EtEw2PFTNMEvWfAkavY6Xhbq0uY+pNnC+d5DDNIKGcy4HpunF/w94dq515YDNdfe+Oof7GHi+DNBKId2O+uRF1CwkZYjTVcEryXkH6gAHoEw2veUGBI6SXVFOYdAZfmf3X432sIWgYHhc3Ka8ATmFJS+bmnStQCB4CKaUoZTvkD4w4JndG88nGlTFCJYqNO5XdlipCAyO/WsYlSZxBb239HzJ/GZK+fQ5b5At96PIXzyI8W0nS3nvS3gQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from SG2APC01FT025.eop-APC01.prod.protection.outlook.com
 (10.152.250.59) by SG2APC01HT137.eop-APC01.prod.protection.outlook.com
 (10.152.251.125) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2430.22; Wed, 13 Nov
 2019 14:08:23 +0000
Received: from PS2P216MB0755.KORP216.PROD.OUTLOOK.COM (10.152.250.51) by
 SG2APC01FT025.mail.protection.outlook.com (10.152.250.187) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.22 via Frontend Transport; Wed, 13 Nov 2019 14:08:23 +0000
Received: from PS2P216MB0755.KORP216.PROD.OUTLOOK.COM
 ([fe80::44f5:f4bb:1601:2602]) by PS2P216MB0755.KORP216.PROD.OUTLOOK.COM
 ([fe80::44f5:f4bb:1601:2602%9]) with mapi id 15.20.2451.023; Wed, 13 Nov 2019
 14:08:23 +0000
From:   Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "mika.westerberg@linux.intel.com" <mika.westerberg@linux.intel.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "benh@kernel.crashing.org" <benh@kernel.crashing.org>,
        "logang@deltatee.com" <logang@deltatee.com>,
        Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
Subject: [PATCH v11 3/4] PCI: Change extend_bridge_window() to set resource
 size directly
Thread-Topic: [PATCH v11 3/4] PCI: Change extend_bridge_window() to set
 resource size directly
Thread-Index: AQHVmivPNCxNZhdzqEmSlCezLTSMmA==
Date:   Wed, 13 Nov 2019 14:08:23 +0000
Message-ID: <PS2P216MB0755180A3C81A51322F6597180760@PS2P216MB0755.KORP216.PROD.OUTLOOK.COM>
Accept-Language: en-AU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SYAPR01CA0033.ausprd01.prod.outlook.com (2603:10c6:1:1::21)
 To PS2P216MB0755.KORP216.PROD.OUTLOOK.COM (2603:1096:300:1c::13)
x-incomingtopheadermarker: OriginalChecksum:C1C5CA3FA17520761497B5B98963D446A905487B2417488C6E3393F1A12D0221;UpperCasedChecksum:673FF22E00789FA487B390623740803CBE215B176D9437C5850D224BD0CE24D1;SizeAsReceived:7672;Count:47
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [PSCYgzLE06U77IVDBCL9JMR6kEDOMmX3WP3pHhVKcUmuLcOIYqBdnuf07weIgynEuTTNVHtT6d8=]
x-microsoft-original-message-id: <20191113140814.GA3837@nicholas-dell-linux>
x-ms-publictraffictype: Email
x-incomingheadercount: 47
x-eopattributedmessage: 0
x-ms-office365-filtering-correlation-id: 230cbc23-2dd1-4ecf-4a76-08d76842f1c5
x-ms-exchange-slblob-mailprops: dEG5jEBie8mlFL0Oe7sWpdK/rFF0vM+sWL1qRZrZy241AD5Ig2bURN2uyIBSztpQysq+FzFoRebSSHNY8IWmsqRv6xB7HaBxVN5B+DIdg/aJFlYX/uVRHyZ7PDoCftEShY5+JmNTm3eTOLR4VgR7jn//wXX4vH0rw1oyFVdRWfyrURSjn/9LVMREKWktku/TsovRavMFrmEcidvjyfLZLPG10ZIayo0uKtfZNIIY6wZYEu7bDIruDbYcSj5V+eJD4GAs4VX7fibywsAK03QpPZLBZuSajC8amzD8pzfnEKx9hm0JS/HG+nlh+qnuu3I+HSMDbPy/INuxVkAn89wlWwr8khfa48up0JpU/FmdgKvY06NWUSAdUf0NuPzAWRN4txyG11hqPlhHEv7oo3BUUpd2P1rukRk9/D/SQhDZVY3eMwxr9G9t1stbZOp8oxtlFtuGSiDoarettnh6MDzkcBfArzFN+24gcKbjByQIVnoPWL8Vza6KSUolHnVEhSv60+v6+3cx69YrM42MQyt1/I2GN/qnt2a2TsvrVnkBZsWdB2yMP6VrFR//XrF2gmIwfQ+Hqo959tsRBEsVQccDfxHetzkr2migZahI0pFP2mLj3g4lARtn2oQbQKmN/6BtlxlQ5eRe2b4A95wGQl27H7DOqyaf02qOpFcGuSC5BOwU5gKuwuikhw==
x-ms-traffictypediagnostic: SG2APC01HT137:
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XkQm43++lx80niKAloJ27EoGpLjnXkoL4AJ5dL4PlfYKQf6qnxgix9FVBbSgyLt4POWuHU0ICPjPA50LgBBR/HwBpJHsY3oiWgNz33FBI/I9yW6/cln789Nv1lEbm9tD955nzMJeKQWkEYlW9ZwsdeW3aA1BMn1lxby+QeW2hQ1zujwvJ7Zx+rXM5DvMVht4
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1E4FDC9A2842C2468D24313E8C943E4E@KORP216.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 230cbc23-2dd1-4ecf-4a76-08d76842f1c5
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Nov 2019 14:08:23.2422
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2APC01HT137
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Change extend_bridge_window() to set resource size directly instead of
using additional resource lists.

Because additional resource lists are optional resources, any algorithm
that requires guaranteed allocation that uses them cannot be guaranteed
to work.

Remove the resource from add_list, as a zero-sized additional resource
is redundant.

Signed-off-by: Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/pci/setup-bus.c | 17 +++++------------
 1 file changed, 5 insertions(+), 12 deletions(-)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index 3f5021f75..d83c55169 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -1818,7 +1818,7 @@ static void extend_bridge_window(struct pci_dev *bridge, struct resource *res,
 				 struct list_head *add_list,
 				 resource_size_t new_size)
 {
-	struct pci_dev_resource *dev_res;
+	resource_size_t add_size;
 
 	if (res->parent)
 		return;
@@ -1826,17 +1826,10 @@ static void extend_bridge_window(struct pci_dev *bridge, struct resource *res,
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
-- 
2.24.0

