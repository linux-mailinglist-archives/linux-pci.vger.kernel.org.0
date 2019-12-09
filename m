Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8511B116D6C
	for <lists+linux-pci@lfdr.de>; Mon,  9 Dec 2019 14:00:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727307AbfLINA5 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Mon, 9 Dec 2019 08:00:57 -0500
Received: from mail-oln040092254048.outbound.protection.outlook.com ([40.92.254.48]:44146
        "EHLO APC01-PU1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727038AbfLINA5 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 9 Dec 2019 08:00:57 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ghPnSiS2bR3slrAQz625jnpVwX7oyzb4sIMrn2qCcIrFF58h/ZjUAwgdostbOzQ8Wd2sPVipDrRGh/J9qkUwp+Xdfp5c5jCdFB3+Y+9eBq15ZOlzERuj4qoxV5RgjfBnWVKD0Pg5Kcgf17hBDf9xTPTUpSyoyQgvGaXrp1oWsEXvlAA3tgmzZFrzl4d5tus85jRU/YIS+45hf0tBWCipyXBW39DJV7KpXn6EaNnXxD+sKE6NLP5Yilu7BADMNakWVMqKHeZDmVaRmaGz/LJLqccISQzLnVTri4HvMHbTPy5bG/Gnau5x5UFcgPi+ogHHSHCYY1l0biP788FzHpForw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yfiqzN34SYKlgEbvFx+4dvp3h00h3Xf+NeQ/xHHE9uM=;
 b=SFGm/scm/vV+dpopVyd+0P0cLXmROs10hYcqDaSJONPFLZv/z2fm/cbjy3PGtQHxeFUC4O8zN8j51NKb9hnWubpfsVWDHKOZKENGNdtSFiknaPRbcN66o8Z50iOUbPqbKO6NMI2XQN8JJ0eLJxGPmo/fc5Y2if4ifBpCNSKHPXCxbvojXt43xG1lEN1xUMrVZyh7XKJY5NF75bVLNGmq3jAD8eRpKq3YQYS+0ADZjukHJ34vC/fSCl4I6JRmhPnjPw9/q1r7AdvLHKD/1OZZzoHsbhss07lVkemptt45YeWhzTEsrTM03cqGLJQ98ZYGsmr5aWXmWjmWYzmFVspWpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from HK2APC01FT003.eop-APC01.prod.protection.outlook.com
 (10.152.248.55) by HK2APC01HT194.eop-APC01.prod.protection.outlook.com
 (10.152.249.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2495.25; Mon, 9 Dec
 2019 13:00:51 +0000
Received: from PSXP216MB0438.KORP216.PROD.OUTLOOK.COM (10.152.248.51) by
 HK2APC01FT003.mail.protection.outlook.com (10.152.248.173) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.25 via Frontend Transport; Mon, 9 Dec 2019 13:00:51 +0000
Received: from PSXP216MB0438.KORP216.PROD.OUTLOOK.COM
 ([fe80::20ad:6646:5bcd:63c9]) by PSXP216MB0438.KORP216.PROD.OUTLOOK.COM
 ([fe80::20ad:6646:5bcd:63c9%11]) with mapi id 15.20.2516.018; Mon, 9 Dec 2019
 13:00:51 +0000
From:   Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Logan Gunthorpe <logang@deltatee.com>,
        Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
Subject: [PATCH v12 4/4] PCI: Allow extend_bridge_window() to shrink resource
 if necessary
Thread-Topic: [PATCH v12 4/4] PCI: Allow extend_bridge_window() to shrink
 resource if necessary
Thread-Index: AQHVrpCvPIyPLGgIT0aVKrLx85Jowg==
Date:   Mon, 9 Dec 2019 13:00:51 +0000
Message-ID: <PSXP216MB04384D7A7F321A0BED323CB180580@PSXP216MB0438.KORP216.PROD.OUTLOOK.COM>
Accept-Language: en-AU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SYYP282CA0016.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:b4::26) To PSXP216MB0438.KORP216.PROD.OUTLOOK.COM
 (2603:1096:300:d::20)
x-incomingtopheadermarker: OriginalChecksum:80C3EB2F81A8A468B085D06868FAF549D412D6C83B2D184D939604642F70FED3;UpperCasedChecksum:B054872A94759315DC83A89DBF2A2B9094D459A0DE929939226AAA364F3471BD;SizeAsReceived:7612;Count:47
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [dZOOw6rEfqlkSrUq9vgwc/up2qRoE85kXEKEMPfX2be8l5KRbuIu2JBqqxWmaaOJel9LMrlLFD4=]
x-microsoft-original-message-id: <20191209130042.GA3017@nicholas-dell-linux>
x-ms-publictraffictype: Email
x-incomingheadercount: 47
x-eopattributedmessage: 0
x-ms-office365-filtering-correlation-id: dffdd2b2-3743-4042-8d71-08d77ca7d162
x-ms-exchange-slblob-mailprops: Zv/SX2iM+5WBO+Hzd/SDavkKHBOvnksd01hJFr3iXCJtXVv218tmSHREHPLp5PjzMFrUVa9edh5xVOtuh1IlKnrhyx/eqMfwjLS45pH+hQA/H+lSCBDm67k1PVziUdpQat3HZ+VKpUgdLP32raZf6L9cYpfy52l4Lw7oie0Garzi5vuSPyj3/2JicpUM8lg2kk/UpY4q8p6py2MGjNT67Ydt/JhjqYcHA92bDSpwPFjC69Qvclf0AYzMz8xTDadV/7i7RhPOa2BzGayTr0gA9YDL18S3pIYwwIC5hReEMO1bQdzmYV4jfnN+6icvmglqlOotTtJkPpmGOgrK/qNuLqTrWTmRnfJPMF+3HrhVT3BGPRV8fT2L2LJZSwgkXvLIPXcBUQvUb64JsNiWtIVsXfS/0+vgNzx6yMLZl0ysaq8HrtZNKhx9iULSposG9PDZrxrn7OP57Kj3PqdaLBn+kVnPA9ExlHM2Jd1j5mj8Dd67xOXY4swkV2yyZmD113Yck7yHFQGGhAIKf4voiHILDFLyik9yaTmKetIYaX1gbjEJ7EgGt7Tx1pwkoDAqg3zpphFrMrMkIgBKLbvOxaJj1BIycQGdGZ+d9vIbQO4lDJM2gx9qV6HqSEabEef9wE7T+3SZQhCf3rT4Vg9yBAQEIzdWA2xoxN+4kkLzWBXdLQUIFmYgi2Ut/udTgXuBwftauC6a8Onr9Yc=
x-ms-traffictypediagnostic: HK2APC01HT194:
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GElS8eutZGp8lfwKE1ZwpGLLCi+dKHJhFycZD6CAm0QImSIANV87AbtVWRaK5llTTxngFB2wQmrRfMZWMlUOv3If4fG0sF8eeErugvdKfqgcHgs9Gmp0tptDEmTVHYq5t491UjUCWKYI0+zszDS491Q08ohIvsfmPPADTzsOMi32RB5cME/Wn3Grio4OOCHS
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <DDC4DA17C837A94799C56ED7E180746A@KORP216.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: dffdd2b2-3743-4042-8d71-08d77ca7d162
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Dec 2019 13:00:51.5042
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK2APC01HT194
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Remove checks for resource size in extend_bridge_window(). This is
necessary to allow the pci_bus_distribute_available_resources() to
function when the kernel parameter pci=hpmemsize=nn[KMG] is used to
allocate resources. Because the kernel parameter sets the size of all
hotplug bridges to be the same, there are problems when nested hotplug
bridges are encountered. Fitting a downstream hotplug bridge with size X
and normal bridges with non-zero size Y into parent hotplug bridge with
size X is impossible, and hence the downstream hotplug bridge needs to
shrink to fit into its parent.

Add check for if bridge is extended or shrunken and adjust pci_dbg to
reflect this.

Reset the resource if its new size is zero (if we have run out of a
bridge window resource) to prevent the PCI resource assignment code from
attempting to assign a zero-sized resource.

Rename extend_bridge_window() to adjust_bridge_window() to reflect the
fact that the window can now shrink.

Signed-off-by: Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/pci/setup-bus.c | 25 ++++++++++++++++---------
 1 file changed, 16 insertions(+), 9 deletions(-)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index 0e0c8b677..22aed6cdb 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -1832,22 +1832,29 @@ void __init pci_assign_unassigned_resources(void)
 	}
 }
 
-static void extend_bridge_window(struct pci_dev *bridge, struct resource *res,
+static void adjust_bridge_window(struct pci_dev *bridge, struct resource *res,
 				 struct list_head *add_list,
 				 resource_size_t new_size)
 {
-	resource_size_t add_size;
+	resource_size_t add_size, size = resource_size(res);
 
 	if (res->parent)
 		return;
 
-	if (resource_size(res) >= new_size)
-		return;
+	if (new_size > size) {
+		add_size = new_size - size;
+		pci_dbg(bridge, "bridge window %pR extended by %pa\n", res,
+			&add_size);
+	} else if (new_size < size) {
+		add_size = size - new_size;
+		pci_dbg(bridge, "bridge window %pR shrunken by %pa\n", res,
+			&add_size);
+	}
 
-	add_size = new_size - resource_size(res);
-	pci_dbg(bridge, "bridge window %pR extended by %pa\n", res, &add_size);
 	res->end = res->start + new_size - 1;
 	remove_from_list(add_list, res);
+	if (!new_size)
+		reset_resource(res);
 }
 
 static void pci_bus_distribute_available_resources(struct pci_bus *bus,
@@ -1883,9 +1890,9 @@ static void pci_bus_distribute_available_resources(struct pci_bus *bus,
 	 * Update the resources to fill as much remaining resource space in the
 	 * parent bridge as possible, whilst considering alignment.
 	 */
-	extend_bridge_window(bridge, io_res, add_list, resource_size(&io));
-	extend_bridge_window(bridge, mmio_res, add_list, resource_size(&mmio));
-	extend_bridge_window(bridge, mmio_pref_res, add_list,
+	adjust_bridge_window(bridge, io_res, add_list, resource_size(&io));
+	adjust_bridge_window(bridge, mmio_res, add_list, resource_size(&mmio));
+	adjust_bridge_window(bridge, mmio_pref_res, add_list,
 			     resource_size(&mmio_pref));
 
 	/*
-- 
2.24.0

