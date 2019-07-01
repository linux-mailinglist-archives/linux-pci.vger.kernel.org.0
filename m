Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6964F5BE23
	for <lists+linux-pci@lfdr.de>; Mon,  1 Jul 2019 16:24:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727904AbfGAOYb convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Mon, 1 Jul 2019 10:24:31 -0400
Received: from mail-oln040092253055.outbound.protection.outlook.com ([40.92.253.55]:18752
        "EHLO APC01-SG2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727687AbfGAOYb (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 1 Jul 2019 10:24:31 -0400
Received: from PU1APC01FT027.eop-APC01.prod.protection.outlook.com
 (10.152.252.59) by PU1APC01HT128.eop-APC01.prod.protection.outlook.com
 (10.152.253.57) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2032.15; Mon, 1 Jul
 2019 14:24:25 +0000
Received: from SL2P216MB0187.KORP216.PROD.OUTLOOK.COM (10.152.252.60) by
 PU1APC01FT027.mail.protection.outlook.com (10.152.252.232) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2032.15 via Frontend Transport; Mon, 1 Jul 2019 14:24:25 +0000
Received: from SL2P216MB0187.KORP216.PROD.OUTLOOK.COM
 ([fe80::9d2d:391f:5f49:c806]) by SL2P216MB0187.KORP216.PROD.OUTLOOK.COM
 ([fe80::9d2d:391f:5f49:c806%6]) with mapi id 15.20.2032.019; Mon, 1 Jul 2019
 14:24:25 +0000
From:   Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "mika.westerberg@linux.intel.com" <mika.westerberg@linux.intel.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "benh@kernel.crashing.org" <benh@kernel.crashing.org>,
        "logang@deltatee.com" <logang@deltatee.com>
Subject: [PATCH v7 4/8] PCI: In extend_bridge_window() change available to
 new_size
Thread-Topic: [PATCH v7 4/8] PCI: In extend_bridge_window() change available
 to new_size
Thread-Index: AQHVMBivrx8FzDF0kkyzpGLK7TEXIw==
Date:   Mon, 1 Jul 2019 14:24:25 +0000
Message-ID: <SL2P216MB0187C8DFBDC3F6CE54A691B980F90@SL2P216MB0187.KORP216.PROD.OUTLOOK.COM>
Accept-Language: en-AU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SY3PR01CA0113.ausprd01.prod.outlook.com
 (2603:10c6:0:1a::22) To SL2P216MB0187.KORP216.PROD.OUTLOOK.COM
 (2603:1096:100:22::19)
x-incomingtopheadermarker: OriginalChecksum:BBB382CFBDC955B73815AA804033FB78135BFBAC0FBB8FE7057E5462180B3774;UpperCasedChecksum:9F13726519B9E7DC163DC282B90BE7D48B32CF243C0D8BD86E2230F76B2D69ED;SizeAsReceived:7700;Count:47
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [gsg8Q7+rdyw3T6QQk+Jh1jsTc3tOjxDhvUmT0zgkslQEPWQbS1qlYB4gYM8uWCWoi7W8qzeJYxY=]
x-microsoft-original-message-id: <20190701142410.GA5251@nicholas-usb>
x-ms-publictraffictype: Email
x-incomingheadercount: 47
x-eopattributedmessage: 0
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(5050001)(7020095)(20181119110)(201702061078)(5061506573)(5061507331)(1603103135)(2017031320274)(2017031322404)(2017031323274)(2017031324274)(1601125500)(1603101475)(1701031045);SRVR:PU1APC01HT128;
x-ms-traffictypediagnostic: PU1APC01HT128:
x-microsoft-antispam-message-info: lmaoXnGwhPQEOtDUxTuXwyHALOAgDFLWgTt2N7XTa4/tRdkuP1/2X4ypn1xCXur6eWxd2Bd3ZxyqFSrgczcAaZ2v2fP2KywcbzrR0EsX3wOY4GQiK8KRzOuqh2d5lAX8KJCoMayllBMXwn9zSkRPG3i/eVpl1UwR+YvDQRaXhkXD+cZc3ScwH18maT8eCY2c
Content-Type: text/plain; charset="us-ascii"
Content-ID: <F2A4FD636A7D0742A5EC6B6D7364E457@KORP216.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: cf89e8fd-4aef-4196-5756-08d6fe2fd184
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jul 2019 14:24:25.4445
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PU1APC01HT128
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

In extend_bridge_window() change "available" parameter name to new_size.
This makes more sense as this parameter represents the new size for the
window.

Signed-off-by: Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
---
 drivers/pci/setup-bus.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index 898fea00c..add1dc373 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -1811,14 +1811,14 @@ void __init pci_assign_unassigned_resources(void)
 
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
@@ -1826,10 +1826,10 @@ static void extend_bridge_window(struct pci_dev *bridge, struct resource *res,
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
2.20.1

