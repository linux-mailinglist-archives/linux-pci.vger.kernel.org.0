Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0B5405BE2B
	for <lists+linux-pci@lfdr.de>; Mon,  1 Jul 2019 16:25:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728159AbfGAOZ3 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Mon, 1 Jul 2019 10:25:29 -0400
Received: from mail-oln040092254061.outbound.protection.outlook.com ([40.92.254.61]:22656
        "EHLO APC01-PU1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727687AbfGAOZ2 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 1 Jul 2019 10:25:28 -0400
Received: from PU1APC01FT027.eop-APC01.prod.protection.outlook.com
 (10.152.252.60) by PU1APC01HT051.eop-APC01.prod.protection.outlook.com
 (10.152.253.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2032.15; Mon, 1 Jul
 2019 14:25:24 +0000
Received: from SL2P216MB0187.KORP216.PROD.OUTLOOK.COM (10.152.252.60) by
 PU1APC01FT027.mail.protection.outlook.com (10.152.252.232) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2032.15 via Frontend Transport; Mon, 1 Jul 2019 14:25:24 +0000
Received: from SL2P216MB0187.KORP216.PROD.OUTLOOK.COM
 ([fe80::9d2d:391f:5f49:c806]) by SL2P216MB0187.KORP216.PROD.OUTLOOK.COM
 ([fe80::9d2d:391f:5f49:c806%6]) with mapi id 15.20.2032.019; Mon, 1 Jul 2019
 14:25:24 +0000
From:   Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "mika.westerberg@linux.intel.com" <mika.westerberg@linux.intel.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "benh@kernel.crashing.org" <benh@kernel.crashing.org>,
        "logang@deltatee.com" <logang@deltatee.com>
Subject: [PATCH v7 6/8] PCI: Allow extend_bridge_window() to shrink resource
 if necessary
Thread-Topic: [PATCH v7 6/8] PCI: Allow extend_bridge_window() to shrink
 resource if necessary
Thread-Index: AQHVMBjSFu30TOdswEyjNEb8yk6Glw==
Date:   Mon, 1 Jul 2019 14:25:24 +0000
Message-ID: <SL2P216MB01871D142278DE5C7FA610B480F90@SL2P216MB0187.KORP216.PROD.OUTLOOK.COM>
Accept-Language: en-AU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SY3PR01CA0097.ausprd01.prod.outlook.com
 (2603:10c6:0:19::30) To SL2P216MB0187.KORP216.PROD.OUTLOOK.COM
 (2603:1096:100:22::19)
x-incomingtopheadermarker: OriginalChecksum:78B69A352EE2D48EE966902C7BE31E9D2695E685278EE4228767415B952D10DA;UpperCasedChecksum:3709DA5CBC05F479832E249D673D1A94F83452C4D7CEB6C0132E9E56FCDF4C3E;SizeAsReceived:7703;Count:47
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [Jy811Bkp+qp8vQM4tGhjmijTLwXczcgQn0IWdPFEsgjVuqDkfxyuAuYakF6urMCJ1fHws5/17hs=]
x-microsoft-original-message-id: <20190701142508.GA5301@nicholas-usb>
x-ms-publictraffictype: Email
x-incomingheadercount: 47
x-eopattributedmessage: 0
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(5050001)(7020095)(20181119110)(201702061078)(5061506573)(5061507331)(1603103135)(2017031320274)(2017031323274)(2017031324274)(2017031322404)(1601125500)(1603101475)(1701031045);SRVR:PU1APC01HT051;
x-ms-traffictypediagnostic: PU1APC01HT051:
x-microsoft-antispam-message-info: VOTRK/O2oW/4VL9oE/Y7hOE0wOJMIn2ZCZMNMLDndu8SjKE/0amgHTJscJ2FVb+K3N87cdCf6/Iyh9uH6lssC3uEgophYqN+PJqvaPs2F8yS+OftuZsfMy5lf7AUN1K8IYVV92mXnPD/7Cwz+jwpanm3k8l7Q1B9GCtQ2bpzu2Un/eLL0PIL7vepc39mCFQi
Content-Type: text/plain; charset="us-ascii"
Content-ID: <B6F253F81B5C904CBC5A649532F2BA3E@KORP216.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: eed832f3-fab8-4ef1-4d1c-08d6fe2ff46e
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jul 2019 14:25:24.0313
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PU1APC01HT051
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
and normal bridges with size Y into parent hotplug bridge with size X is
impossible, and hence the downstream hotplug bridge needs to shrink to
fit into its parent.

Add check for if bridge is extended or shrunken and adjust pci_dbg to
reflect this.

Reset the resource if its new size is zero (if we have run out of a
bridge window resource). If it is set to zero size and left, it can
cause significant problems when it comes to enabling devices.

Signed-off-by: Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
---
 drivers/pci/setup-bus.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index d65982438..9064fd964 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -1818,13 +1818,19 @@ static void extend_bridge_window(struct pci_dev *bridge, struct resource *res,
 	if (res->parent)
 		return;
 
-	if (resource_size(res) >= new_size)
-		return;
-
-	add_size = new_size - resource_size(res);
-	pci_dbg(bridge, "bridge window %pR extended by %pa\n", res, &add_size);
+	if (new_size > resource_size(res)) {
+		add_size = new_size - resource_size(res);
+		pci_dbg(bridge, "bridge window %pR extended by %pa\n", res,
+			&add_size);
+	} else if (new_size < resource_size(res)) {
+		add_size = resource_size(res) - new_size;
+		pci_dbg(bridge, "bridge window %pR shrunken by %pa\n", res,
+			&add_size);
+	}
 	res->end = res->start + new_size - 1;
 	remove_from_list(add_list, res);
+	if (!new_size)
+		reset_resource(res);
 }
 
 static void pci_bus_distribute_available_resources(struct pci_bus *bus,
-- 
2.20.1

