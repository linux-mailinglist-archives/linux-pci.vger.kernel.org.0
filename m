Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E300BE8BCB
	for <lists+linux-pci@lfdr.de>; Tue, 29 Oct 2019 16:29:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390034AbfJ2P3H convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Tue, 29 Oct 2019 11:29:07 -0400
Received: from mail-oln040092253033.outbound.protection.outlook.com ([40.92.253.33]:34112
        "EHLO APC01-SG2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2389809AbfJ2P3G (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 29 Oct 2019 11:29:06 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c7XwUagxm2IFi8AE0zGcAaZar8ILvxrr6k2T64XHqS792oEcSpFexo5wOdky7D02af71nFB4qek+8AvBVu/nOV5UoCPT6oK2+poYIJ0QxzlABHa85Q0voo29cI9uzU4/4t28GbLveWcoWuqzhi9eKlXfnsB9lN3lmxBHV0W/IPjIil/YHQ3etYVsI2hUYZJeds/9MD1IHwrAIySGSswpt9mAEUYo5Vg5HpBeiOegxmQMVKgmSNTe96lPNsifCL1iG6IO4x3FVodSVm/nc2Sx2R75KQcG9lx9nSBr1cF+3rzranawUZmSuMF68cAaI+uF/yV2El37ArG0JGBm5k5C6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HYK4AJq2wVyOdrQ6YBlPBFYX/XCDfpNvP+ELcOZprcU=;
 b=nw2DA8wxmKB+M1+MhhYn4Qa3S5sRswkMZTeiYDfUKNeluJeKsy4JFr4zcNuBA0OYF489wyNXrYa9SZwV3TnPMxbL1WsuWpEREu4OjGum76HELRV32ui1fV2SinHZNEozQa6iO5g/KHiRrHPjcYbxWNAK7p/JjzM3m421QlPG44FnTGrhMm4kllHqBoxNeasNLGZRumPQBcNuBd0XwrJdI0pMO8GdntgI8ZAD5SIb03BzVXuQQ8HAMik58GtvG1jPVIvtKBQ9OKHF/vRqqKQW6nnVSd1hjbq7rDkcBZoIXWzUIntysybYM8f/FnWK0hQ6HuC1GhwSoxCAwmuEZQjUcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from PU1APC01FT018.eop-APC01.prod.protection.outlook.com
 (10.152.252.56) by PU1APC01HT163.eop-APC01.prod.protection.outlook.com
 (10.152.252.180) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2387.20; Tue, 29 Oct
 2019 15:29:01 +0000
Received: from SL2P216MB0187.KORP216.PROD.OUTLOOK.COM (10.152.252.53) by
 PU1APC01FT018.mail.protection.outlook.com (10.152.253.189) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.20 via Frontend Transport; Tue, 29 Oct 2019 15:29:01 +0000
Received: from SL2P216MB0187.KORP216.PROD.OUTLOOK.COM
 ([fe80::ec26:6771:625e:71d]) by SL2P216MB0187.KORP216.PROD.OUTLOOK.COM
 ([fe80::ec26:6771:625e:71d%8]) with mapi id 15.20.2387.028; Tue, 29 Oct 2019
 15:29:01 +0000
From:   Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "mika.westerberg@linux.intel.com" <mika.westerberg@linux.intel.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "benh@kernel.crashing.org" <benh@kernel.crashing.org>,
        "logang@deltatee.com" <logang@deltatee.com>
Subject: [PATCH v9 3/4] PCI: Change extend_bridge_window() to set resource
 size directly
Thread-Topic: [PATCH v9 3/4] PCI: Change extend_bridge_window() to set
 resource size directly
Thread-Index: AQHVjm2XQMTh9lRh7kOUfj+t3LIGAQ==
Date:   Tue, 29 Oct 2019 15:29:01 +0000
Message-ID: <SL2P216MB0187D45A7E932CA66FE9491A80610@SL2P216MB0187.KORP216.PROD.OUTLOOK.COM>
Accept-Language: en-AU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SY4P282CA0012.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:a0::22) To SL2P216MB0187.KORP216.PROD.OUTLOOK.COM
 (2603:1096:100:22::19)
x-incomingtopheadermarker: OriginalChecksum:168D4ED821E4AFD6019CA119A412C19D0DF9A3D1BD3925465726D1F6110DDA19;UpperCasedChecksum:CAC918EDFE39E8DFFD298EB4FFD790C08656C21B6C041503731BD0E2AA186CB2;SizeAsReceived:7524;Count:46
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [jbXEeCwWIASggUrjbpQS6lY/YwzSNnIk6OcMWIwZWnBfBDQ9sS/54vb7cmoynhq285C92fEd2H4=]
x-microsoft-original-message-id: <20191029152853.GA1918@nicholas-dell-linux>
x-ms-publictraffictype: Email
x-incomingheadercount: 46
x-eopattributedmessage: 0
x-ms-traffictypediagnostic: PU1APC01HT163:
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vSqDlUzpev1ui0gJR9EHsTOvV3Lt5HQ01jAnnCnRMW07yf3x8cxZvBkBpzAm4Bo60NvbkD2hDaQBCF6f/8XaLWoioUIjkTXENaJYSdtOZ/7iKO4uY9J7TFFv0WcvGUs4+D6wQUbbDUSAZhxd8cdY1sFxADE0bGxS1XnyQWUuhdQL0wGBH3yc37r6586VhhQZ
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <8698D41A617D1E468FBA8DC65A28BCB4@KORP216.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 29a54a10-1f72-411b-803e-08d75c84b982
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Oct 2019 15:29:01.8128
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PU1APC01HT163
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
index 728bcea26..fe8b2c715 100644
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
2.23.0

