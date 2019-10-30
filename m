Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4A251E9BC3
	for <lists+linux-pci@lfdr.de>; Wed, 30 Oct 2019 13:47:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726656AbfJ3Mrt convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Wed, 30 Oct 2019 08:47:49 -0400
Received: from mail-oln040092254042.outbound.protection.outlook.com ([40.92.254.42]:59232
        "EHLO APC01-PU1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726088AbfJ3Mrt (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 30 Oct 2019 08:47:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jlyI+j9Fj2XiaOLnfNynqgZnho12Tlh5nk7P7laDZs9eKx9V40+8Z1cQnFAhOgEEuu3qZUfO/envjqkCcWw5N4YhGVuJ8I/o0Z03/f2YbMyzUC745KKjUO5HyG5iskCNSC5SMRxi4bWs4PrQ16psbPjc2aUFNEfQbgATNLU5Ade+u8s4ED7VWVNB5tO/WhIv8qCQMSX/2OCrCiUqxn28sMep0X1hu9KM1bCBIwRUvcSmgy6gheLZdOtXIH1Sv6yd1Mvu7DANRbn+3GBT4WJMo2sDfHAV9ZN95Int5ivq4vFxWZgTuOhTmai9HL203jjj66UQan+1fMqBBOiQ0/60gQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zST80BDhYstqD3q+LnsS86RfBnpU0s3duNukixoi9OU=;
 b=SOLyO9h5azIB2Fv+9ZQrNJo1Kyqvf7JVXpIlFuieZ9hetIlkJWTBUQlroVRJGZ1ORu9sByeIOzsWAJ+Q7WNnsYNyJnsDZC9JqbckODOlkAIceUOYlP9axBUE4oMhl0u0zQxJIGV7UqSPO0Mxrj1twvevYDwlD919/YeehANwgFqb6bb57qsw1bZlYflJHpHcHRGUgJIUacQPMConpttdT6I+sj9Z6XYfEW4fHV1ay9PnCFfOCe95RNfTXrpo4MOhCBSeFJuLk5DpJ+cEfDcJ1bIYm8Ze4/LapBqQcRHitoRywZsf1MFoDu4sDChaTU71ClYB4e2smS0oKy0s5gByeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from HK2APC01FT052.eop-APC01.prod.protection.outlook.com
 (10.152.248.54) by HK2APC01HT051.eop-APC01.prod.protection.outlook.com
 (10.152.249.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2387.20; Wed, 30 Oct
 2019 12:47:44 +0000
Received: from SL2P216MB0187.KORP216.PROD.OUTLOOK.COM (10.152.248.51) by
 HK2APC01FT052.mail.protection.outlook.com (10.152.248.244) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2387.20 via Frontend Transport; Wed, 30 Oct 2019 12:47:44 +0000
Received: from SL2P216MB0187.KORP216.PROD.OUTLOOK.COM
 ([fe80::ec26:6771:625e:71d]) by SL2P216MB0187.KORP216.PROD.OUTLOOK.COM
 ([fe80::ec26:6771:625e:71d%8]) with mapi id 15.20.2387.028; Wed, 30 Oct 2019
 12:47:44 +0000
From:   Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "mika.westerberg@linux.intel.com" <mika.westerberg@linux.intel.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "benh@kernel.crashing.org" <benh@kernel.crashing.org>,
        "logang@deltatee.com" <logang@deltatee.com>
Subject: [PATCH v10 4/4] PCI: Allow extend_bridge_window() to shrink resource
 if necessary
Thread-Topic: [PATCH v10 4/4] PCI: Allow extend_bridge_window() to shrink
 resource if necessary
Thread-Index: AQHVjyA5XlOSuojfyUiAJcF9cam8nw==
Date:   Wed, 30 Oct 2019 12:47:44 +0000
Message-ID: <SL2P216MB0187C1ACBE716693FD5622BD80600@SL2P216MB0187.KORP216.PROD.OUTLOOK.COM>
Accept-Language: en-AU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SYYP282CA0003.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:b4::13) To SL2P216MB0187.KORP216.PROD.OUTLOOK.COM
 (2603:1096:100:22::19)
x-incomingtopheadermarker: OriginalChecksum:1135D175687A42FE736E044F0F95638F783C070B54F8571FF85EED94880FCFC2;UpperCasedChecksum:D37DEF15B4DE2D519BA3FCD290DEEB78C9C8BB8E7170C12D76B31284A4B9D883;SizeAsReceived:7539;Count:46
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [OgSBJgXNYEEeDTlNL+U1mETCvYUXN/RteYeNuJtyI1pVsFlJzTJ5wFNPjamswi1Q7y6yDbZzvq4=]
x-microsoft-original-message-id: <20191030124736.GA2170@nicholas-dell-linux>
x-ms-publictraffictype: Email
x-incomingheadercount: 46
x-eopattributedmessage: 0
x-ms-traffictypediagnostic: HK2APC01HT051:
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3uqJSqCaMTk8AQk6Hu809SPqCd4UvsJsyvQamXAeT6SnRpTv/KV7KJOv91B2baMlzZJpKfd7riAUZDlXQp4jk5LqqbO8/vPYyn6BljBXrOJ3Z1SOtqWvl8HulsDVT9zfhdGZKB+TZNKXEV9WKxEK/uHAOJMdG6dHlyOcJubCzfy2Dpu/TLHMrVMMzONW5Dp7
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <8D90C9A2356D994E90CD6AC975F46678@KORP216.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 8492b2df-4628-45a6-7d26-08d75d375b92
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Oct 2019 12:47:44.1683
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK2APC01HT051
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
2.23.0

