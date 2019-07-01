Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F15E45BE28
	for <lists+linux-pci@lfdr.de>; Mon,  1 Jul 2019 16:25:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727817AbfGAOZF convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Mon, 1 Jul 2019 10:25:05 -0400
Received: from mail-oln040092255094.outbound.protection.outlook.com ([40.92.255.94]:36304
        "EHLO APC01-HK2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727687AbfGAOZE (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 1 Jul 2019 10:25:04 -0400
Received: from PU1APC01FT027.eop-APC01.prod.protection.outlook.com
 (10.152.252.54) by PU1APC01HT090.eop-APC01.prod.protection.outlook.com
 (10.152.253.94) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2032.15; Mon, 1 Jul
 2019 14:24:59 +0000
Received: from SL2P216MB0187.KORP216.PROD.OUTLOOK.COM (10.152.252.60) by
 PU1APC01FT027.mail.protection.outlook.com (10.152.252.232) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2032.15 via Frontend Transport; Mon, 1 Jul 2019 14:24:59 +0000
Received: from SL2P216MB0187.KORP216.PROD.OUTLOOK.COM
 ([fe80::9d2d:391f:5f49:c806]) by SL2P216MB0187.KORP216.PROD.OUTLOOK.COM
 ([fe80::9d2d:391f:5f49:c806%6]) with mapi id 15.20.2032.019; Mon, 1 Jul 2019
 14:24:59 +0000
From:   Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "mika.westerberg@linux.intel.com" <mika.westerberg@linux.intel.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "benh@kernel.crashing.org" <benh@kernel.crashing.org>,
        "logang@deltatee.com" <logang@deltatee.com>
Subject: [PATCH v7 5/8] PCI: Change extend_bridge_window() to set resource
 size directly
Thread-Topic: [PATCH v7 5/8] PCI: Change extend_bridge_window() to set
 resource size directly
Thread-Index: AQHVMBjDD8e6mskNZEOJPe9aWx8fNg==
Date:   Mon, 1 Jul 2019 14:24:59 +0000
Message-ID: <SL2P216MB0187686184BC852E8FDFF67C80F90@SL2P216MB0187.KORP216.PROD.OUTLOOK.COM>
Accept-Language: en-AU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SYAPR01CA0024.ausprd01.prod.outlook.com (2603:10c6:1::36)
 To SL2P216MB0187.KORP216.PROD.OUTLOOK.COM (2603:1096:100:22::19)
x-incomingtopheadermarker: OriginalChecksum:18A4005DFC9385174F9490232FD98C2678707A963C301EE78DC9D480C69DD8DF;UpperCasedChecksum:33AF3B687EA8AB3E677547488FD863CF843B0464329DFDB84C0DDA3D538367FF;SizeAsReceived:7689;Count:47
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [/YKWdA81hOgnLIDQ02OMCJ9w1V4wthNHC+EK10wypdF1DPTM89EcXueFCi/U0FIwOpTkwQ4Xnhc=]
x-microsoft-original-message-id: <20190701142438.GA5276@nicholas-usb>
x-ms-publictraffictype: Email
x-incomingheadercount: 47
x-eopattributedmessage: 0
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(5050001)(7020095)(20181119110)(201702061078)(5061506573)(5061507331)(1603103135)(2017031320274)(2017031322404)(2017031323274)(2017031324274)(1601125500)(1603101475)(1701031045);SRVR:PU1APC01HT090;
x-ms-traffictypediagnostic: PU1APC01HT090:
x-microsoft-antispam-message-info: d3KkN/qNby0171dtNwXNg7l2+2VDA9j3t0RHZE6oQ+fGusZMmAPLSbKNlRGBngssB5WMr9LCo6P6DgM/W3zkSNmM/nhNKV1p4KMD+aeA7A0PLbYfPfmC2MVtg5ejzhn+FsqFYlSPPplsSd5uBRLGkqn50W/j7q/1PWlZYtM++6nuXzP8a5pT3+BJqti1BmA6
Content-Type: text/plain; charset="us-ascii"
Content-ID: <5F9F280FE5E5CF4DBE24FDB409D18676@KORP216.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: c6dbf5e8-43b0-4338-c513-08d6fe2fe5c7
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jul 2019 14:24:59.4468
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PU1APC01HT090
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Change extend_bridge_window() to set resource size directly instead of
using additional resource lists.

Because additional resource lists are optional resources, any algorithm
that requires guaranteed allocation that uses them cannot be guaranteed
to work.

Remove the resource from add_list. If it is set to zero size and left,
it can cause significant problems when it comes to assigning resources.

Signed-off-by: Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
---
 drivers/pci/setup-bus.c | 17 +++++------------
 1 file changed, 5 insertions(+), 12 deletions(-)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index add1dc373..d65982438 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -1813,7 +1813,7 @@ static void extend_bridge_window(struct pci_dev *bridge, struct resource *res,
 				 struct list_head *add_list,
 				 resource_size_t new_size)
 {
-	struct pci_dev_resource *dev_res;
+	resource_size_t add_size;
 
 	if (res->parent)
 		return;
@@ -1821,17 +1821,10 @@ static void extend_bridge_window(struct pci_dev *bridge, struct resource *res,
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
2.20.1

