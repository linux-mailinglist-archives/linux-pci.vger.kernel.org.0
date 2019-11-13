Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4D762FB234
	for <lists+linux-pci@lfdr.de>; Wed, 13 Nov 2019 15:08:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727472AbfKMOIu convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Wed, 13 Nov 2019 09:08:50 -0500
Received: from mail-oln040092255028.outbound.protection.outlook.com ([40.92.255.28]:20457
        "EHLO APC01-HK2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727442AbfKMOIu (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 13 Nov 2019 09:08:50 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W6sJIi21/M5OWKigPbNQbtf5SDl+tNTFeHr2gfJvnnbTeOeV98n3hlZSzTyExhto4rnorBN4Gd4w3zgXft+uEIlrxhCI4N/6SdtP51DxJJhVaxSW8owVHT5AyiLiLAH3AQGIb9WoylanlAklpYEGTYL5ZoHXf9XYSAOepin34OFQjl3RR8ekEwk7YvGc9xoGN4Glb42AnPmOf6mmd2QEOxZubj5e8O1xWaq5RjGNgZXK+dUE2FD7L1JeW5mdN/TBi8iVGStq3MF+C1RRWmpAB3n8WYXmXNrAlZ6sCipVibm8O/PNjC6ub54uVHfQ70C+q3L3KHzezlWtufcTcumnBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tX8MrlsAW211GJ4ivkEQ9JbDwZyKaG4Plp2HCKvsMkk=;
 b=W2mMbCRm9lgJfZK6cToY5GZgQ0eqrcILmWBWtQ6hQwNXEfMwkvhFOhIKi/SY14mt8hl3PFSAiELsnFrH7PC6NOKMnT0+/nCJ5Jzme8UEkk+He72nqbuQ5OAWEFyjc//aORMZkSo+JBzRvffhoJvnytJN+rlOIi21aOiL1UfMqVScHNW1Cmp4Jfzdl/xgHo4BkNhzKY1rIQ+jyudkWk9rEOoMctuVcEqRmstmYSaxtjwUs0ho4BDoybm1ZzvCYRSm3oN8KLS42lGsSTMzFe9CmfRRvYaIGgwdZCukA5rx2OV93gFGFb6NoP/V+wyjRw213cRxuQVhP/HZXtVLQMLQeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from SG2APC01FT025.eop-APC01.prod.protection.outlook.com
 (10.152.250.51) by SG2APC01HT113.eop-APC01.prod.protection.outlook.com
 (10.152.251.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2430.22; Wed, 13 Nov
 2019 14:08:43 +0000
Received: from PS2P216MB0755.KORP216.PROD.OUTLOOK.COM (10.152.250.51) by
 SG2APC01FT025.mail.protection.outlook.com (10.152.250.187) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.22 via Frontend Transport; Wed, 13 Nov 2019 14:08:42 +0000
Received: from PS2P216MB0755.KORP216.PROD.OUTLOOK.COM
 ([fe80::44f5:f4bb:1601:2602]) by PS2P216MB0755.KORP216.PROD.OUTLOOK.COM
 ([fe80::44f5:f4bb:1601:2602%9]) with mapi id 15.20.2451.023; Wed, 13 Nov 2019
 14:08:42 +0000
From:   Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "mika.westerberg@linux.intel.com" <mika.westerberg@linux.intel.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "benh@kernel.crashing.org" <benh@kernel.crashing.org>,
        "logang@deltatee.com" <logang@deltatee.com>,
        Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
Subject: [PATCH v11 4/4] PCI: Allow extend_bridge_window() to shrink resource
 if necessary
Thread-Topic: [PATCH v11 4/4] PCI: Allow extend_bridge_window() to shrink
 resource if necessary
Thread-Index: AQHVmivb8eHIBfYgFkKFMiybT5ykOw==
Date:   Wed, 13 Nov 2019 14:08:42 +0000
Message-ID: <PS2P216MB0755F565E175D978A5B927E180760@PS2P216MB0755.KORP216.PROD.OUTLOOK.COM>
Accept-Language: en-AU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SY3PR01CA0127.ausprd01.prod.outlook.com
 (2603:10c6:0:1b::12) To PS2P216MB0755.KORP216.PROD.OUTLOOK.COM
 (2603:1096:300:1c::13)
x-incomingtopheadermarker: OriginalChecksum:2E3B80BABE0A296F66C43DD06051DBB4EA614DFCB400E69D8FF9531BFAC7BE52;UpperCasedChecksum:A71F6DEA6144EFE3CD520F431EDC9DA5D4188E28148EFC91004CB2C01E06A169;SizeAsReceived:7666;Count:47
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [0MkXgU1rqzU+5cxo0tZN0533TrLEGtIY8UrLf00/ZoIHMV2ndCKnaNKS2/Gv9Ckw]
x-microsoft-original-message-id: <20191113140834.GA3839@nicholas-dell-linux>
x-ms-publictraffictype: Email
x-incomingheadercount: 47
x-eopattributedmessage: 0
x-ms-office365-filtering-correlation-id: 7674df3f-79d0-4992-138a-08d76842fd7d
x-ms-exchange-slblob-mailprops: gjx25WM8ZNUUcF99Xf9jcIZVmoSE4UEuKZKzQN6lc/wY3oOtgrBiHfY4H1N9QwewqAbH4TH6l7xhSa2uQHfyiIbeEj4hFdPDZNiRZri9MLvzeFDsu/lEfGb3jUd4Miid99VVxAqm8p8UhB+XvNw/0stZzi2WyLEYcPXpWwIeAep9O27r3efTSlwXJTgyyiPhxFz/RLIU1C3O9+rTwTaDuGm6KgJPftXn0SK/bSd5h7iPONaSHKGC82uPBHd4qRVCzl7V+7LQbyrmfVV5ZrF4QKFXwrW231+xTZROMJnYAF2guJaw167sxkRWiGDOmKEpUIQuhxfo1je5ChtOBMx6ATRocuO12XC7QY7wYrLvthvp6mJQq1SVOX4H2w0A1eUYhz7TH3yCpTbj2iudSBbUjmNn11WzeCCOK/I2wwZ6kIGurglKAGMqgwwlUOUY0eEjFeZfU6ewcxsH5ih7pkkKSP7ldL4g5Af8Xpyc+NZ62l68BGFQyb4+zEmmUJE2HbRM6c4cXczhLeJgre7vo2c9o0EcktdGE8F8ssBat35G2bvkJKHWPLpevt/8xMbJjpKN9LyrPUKi7Yd0tCYW0EjQ3vr58HPBO/EkVB+XiwAWhFRHPopOX4IN036NjGF9C1m1BJGpGltsdmVPV8INmys/7Z0UqWGVspGYPW6ajZR2erkztDcpaWmixx/+ylBCRto7bREEyXXhYEg1X3R36jGhl0R3WKKWP02oYMrQr7/3x0U=
x-ms-traffictypediagnostic: SG2APC01HT113:
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tlrGXHvttR3aauJAVXDavpAsxmzaVhIrgWmHzmX9BOLWQr/kWgl5vm4QrLhPO1GtkJatz/4BLvnZlH2HT2dCTn4kbS40NygrNSmyro4C9bYBTKL51fE28xghjZBxNT/3dPKr2xrtmX/8+VxSjD7Yk/LfRBVjJFCqW4Lrt3RAJ18wgnyOwF/qnlM5o4I7BRDR
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <169E2867B99A974AA67E4A50C2E112D9@KORP216.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 7674df3f-79d0-4992-138a-08d76842fd7d
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Nov 2019 14:08:42.9296
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2APC01HT113
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
---
 drivers/pci/setup-bus.c | 25 ++++++++++++++++---------
 1 file changed, 16 insertions(+), 9 deletions(-)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index d83c55169..6b64bf909 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -1814,22 +1814,29 @@ void __init pci_assign_unassigned_resources(void)
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
@@ -1865,9 +1872,9 @@ static void pci_bus_distribute_available_resources(struct pci_bus *bus,
 	 * Update the resources to fill as much remaining resource space in the
 	 * parent bridge as possible, while considering alignment.
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

