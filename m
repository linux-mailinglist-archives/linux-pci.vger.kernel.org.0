Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 247227669B
	for <lists+linux-pci@lfdr.de>; Fri, 26 Jul 2019 14:54:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726265AbfGZMyG convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Fri, 26 Jul 2019 08:54:06 -0400
Received: from mail-oln040092255037.outbound.protection.outlook.com ([40.92.255.37]:30828
        "EHLO APC01-HK2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726099AbfGZMyF (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 26 Jul 2019 08:54:05 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HzR5b5TyJDDkSlJrZ2sDfS1Gpnb7rczZq+VYBymmjqMKhZWceWlW2dKe6zrGctmqOHK3+pSzResxCQdW1LMRQbNbj2A6mTkH0+JVcr6qjw7zsg3dCODXzkYJvrV7Iwhtks2UDOwVD2gFNchN6s5mzu52wxd7Xp4n2uMru1CRuLcD6GqqFc1j5HbLU7t7k+bVVOMOVdn5f/9vZwuwsfPTAtAk3HDiKNM3sPa10KBtFf+TCQ1CWpRhMh0L03rBusBltDY0udczST3+ugp0IgAFHrqlzHdYX9qApk69kyseymCUQkhxRc85nRIYa7mCeRd0yE1nGnJGOkQx8hLw4BkqQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h95AShb0IzNRXB2Y+PVKPBL6mIzyZW8Bgm+PslKgUwk=;
 b=dqHmTw2q8uJPoIvPTCXX8Ed83szhXBHo3rL5mzMoYfQDScjlIeZq9VxDJSJjz2o/3fV/9/mszr4vK7jNfdZ+ynFl18/HjYsMFhEBnE2Ieuq6HjSKBuJDtRxbzGKvyBl0mxaZr4vANwAgtbpuT2I2bXq2MKs3KYdn/PLM7lVD0kO8655dvfU5Jk1uCe7G5frmp9Q0ixEk3qdXMVHnA68XhQAfI/k+prpylPnXv2sQUzSGA5L2JDMW/2+Y3pen9FDd8CROEBI3rmF0SccfpuptlG9iIYfr3mv/1C6d3Ax0gPeR1yKw4HTXU/Sk31q7d5DLLiBYEP9aSAoTDhp4TE0Akw==
ARC-Authentication-Results: i=1; mx.microsoft.com
 1;spf=none;dmarc=none;dkim=none;arc=none
Received: from PU1APC01FT060.eop-APC01.prod.protection.outlook.com
 (10.152.252.51) by PU1APC01HT026.eop-APC01.prod.protection.outlook.com
 (10.152.253.50) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2115.10; Fri, 26 Jul
 2019 12:54:01 +0000
Received: from SL2P216MB0187.KORP216.PROD.OUTLOOK.COM (10.152.252.59) by
 PU1APC01FT060.mail.protection.outlook.com (10.152.253.44) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2115.10 via Frontend Transport; Fri, 26 Jul 2019 12:54:01 +0000
Received: from SL2P216MB0187.KORP216.PROD.OUTLOOK.COM
 ([fe80::1cba:d572:7a30:ff0d]) by SL2P216MB0187.KORP216.PROD.OUTLOOK.COM
 ([fe80::1cba:d572:7a30:ff0d%3]) with mapi id 15.20.2094.013; Fri, 26 Jul 2019
 12:54:01 +0000
From:   Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "mika.westerberg@linux.intel.com" <mika.westerberg@linux.intel.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "benh@kernel.crashing.org" <benh@kernel.crashing.org>,
        "logang@deltatee.com" <logang@deltatee.com>
Subject: [PATCH v8 3/6] PCI: Change extend_bridge_window() to set resource
 size directly
Thread-Topic: [PATCH v8 3/6] PCI: Change extend_bridge_window() to set
 resource size directly
Thread-Index: AQHVQ7Ey0201Fxl9REW2IdRoQKj8pw==
Date:   Fri, 26 Jul 2019 12:54:01 +0000
Message-ID: <SL2P216MB018777F9E124D364769E5D4680C00@SL2P216MB0187.KORP216.PROD.OUTLOOK.COM>
Accept-Language: en-AU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SYBPR01CA0051.ausprd01.prod.outlook.com
 (2603:10c6:10:2::15) To SL2P216MB0187.KORP216.PROD.OUTLOOK.COM
 (2603:1096:100:22::19)
x-incomingtopheadermarker: OriginalChecksum:154BFDD2D37B044337751C8DCCB5E70F7B1A8D941F5415933C992A7EBE8164B6;UpperCasedChecksum:AAD482AD1817F7218B36E01865ED4E911D35A93553C3BCECF5D64705425438CB;SizeAsReceived:7711;Count:47
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [NVOOK9tH2swPS60slPaB/iYu6BX0OcZOp0L2NQCU80uoTdeCQVLjRP6++EDADvM75Ps1aAJgSYM=]
x-microsoft-original-message-id: <20190726125345.GA2692@nicholas-usb>
x-ms-publictraffictype: Email
x-incomingheadercount: 47
x-eopattributedmessage: 0
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(5050001)(7020095)(20181119110)(201702061078)(5061506573)(5061507331)(1603103135)(2017031320274)(2017031323274)(2017031324274)(2017031322404)(1601125500)(1603101475)(1701031045);SRVR:PU1APC01HT026;
x-ms-traffictypediagnostic: PU1APC01HT026:
x-microsoft-antispam-message-info: EcLc2TPa307/jmqiJAMEnkwRR2S7B/3xoz+YVoIImwhwt12OOyKatRTrXkEqlUBkH5j0YzlwyitXmeefA5BmzneYfRNWUKgx2+JcLE1CNCSL166WNOoEEgS1CS5zcBJFxnQiCqHr7ed8D7rOm6OWY+2JYo17+Eji9IIrMnYkwnso/p3x3/8UHV2PVu5njudU
Content-Type: text/plain; charset="us-ascii"
Content-ID: <7149B4BCC9BD9D4C8ECF79A528E731D0@KORP216.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d10ad79-8409-4a63-a47e-08d711c8551c
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jul 2019 12:54:01.7735
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PU1APC01HT026
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
index 3b3055e0e..a072781ab 100644
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
2.22.0

