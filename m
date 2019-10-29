Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5CA48E8BCD
	for <lists+linux-pci@lfdr.de>; Tue, 29 Oct 2019 16:29:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390091AbfJ2P32 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Tue, 29 Oct 2019 11:29:28 -0400
Received: from mail-oln040092254072.outbound.protection.outlook.com ([40.92.254.72]:25713
        "EHLO APC01-PU1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2389663AbfJ2P32 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 29 Oct 2019 11:29:28 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JUl6SJbTnZnOWhL/xN0I1P8CtC6Wj66HY2b9Q1b3hGEF1HtCpZe70COib5Eube1p4972wQRLcA9Js537bWCoQVdQAIN41RWAo+RLkTjAUu5Wxp8pGLkTocBKz7gB3go0+eUBKeHwEaNhqhUtE3emQD8YTGTOGY+3A48pyzQrwKhoKeC2Tdr8daGHfx48LdJ7ugh5TyOM+WACDpD1zhFe6NzBGnrK5dxXrL9J8J/CmD7VQlpUbPTVLD8MOWsuGy2aO/W/GpD320dfqpJ9s6expOsbAGLAExcQ1yUVl10DIRvEZTXum9VOdCYzvBbSFQXkI5O9LUAqwL65//rR2V6oDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O3AaL0KkuoiKt3XJ7H2UWQw11cz/34REwFpljoWpT24=;
 b=n9nZdyaGoJARKsJsTyla1+R3ukEecKRd6XK/uUZ2iR/knne1BZW6fx/uDUb2paRP4EHhwWxTuBzaeqL0hb3V2OZM9WdvYogjSySm4aDmYVCL72o/QoOOwOhFzV/Ja7bWFL4PydhREpH/pyUuG/x3qp+ZmeuGDzgb1d/Q9wOoW2a91G5MSd4EIPwiIIog3ns/hFCMWa9Oz09k6QPYMrv3VjyC9b7yEYSkbwnc4Kby2vwPu1frZN2b1e5d+bcKPkqeld02Iz8jD0eE0b8hFwwPvsIyLoXNDzCVdUlm29G66GCtuqM5rFhJXpJfO9xcxij+cYSSVYrwZrv9jXUnZiPhuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from PU1APC01FT018.eop-APC01.prod.protection.outlook.com
 (10.152.252.53) by PU1APC01HT089.eop-APC01.prod.protection.outlook.com
 (10.152.253.102) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2387.20; Tue, 29 Oct
 2019 15:29:22 +0000
Received: from SL2P216MB0187.KORP216.PROD.OUTLOOK.COM (10.152.252.53) by
 PU1APC01FT018.mail.protection.outlook.com (10.152.253.189) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.20 via Frontend Transport; Tue, 29 Oct 2019 15:29:22 +0000
Received: from SL2P216MB0187.KORP216.PROD.OUTLOOK.COM
 ([fe80::ec26:6771:625e:71d]) by SL2P216MB0187.KORP216.PROD.OUTLOOK.COM
 ([fe80::ec26:6771:625e:71d%8]) with mapi id 15.20.2387.028; Tue, 29 Oct 2019
 15:29:21 +0000
From:   Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "mika.westerberg@linux.intel.com" <mika.westerberg@linux.intel.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "benh@kernel.crashing.org" <benh@kernel.crashing.org>,
        "logang@deltatee.com" <logang@deltatee.com>
Subject: [PATCH v9 4/4] PCI: Allow extend_bridge_window() to shrink resource
 if necessary
Thread-Topic: [PATCH v9 4/4] PCI: Allow extend_bridge_window() to shrink
 resource if necessary
Thread-Index: AQHVjm2j6KwuziponkGop9V32ZF1Jw==
Date:   Tue, 29 Oct 2019 15:29:21 +0000
Message-ID: <SL2P216MB018739B339B453DE872DB71E80610@SL2P216MB0187.KORP216.PROD.OUTLOOK.COM>
Accept-Language: en-AU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SYXPR01CA0109.ausprd01.prod.outlook.com
 (2603:10c6:0:2d::18) To SL2P216MB0187.KORP216.PROD.OUTLOOK.COM
 (2603:1096:100:22::19)
x-incomingtopheadermarker: OriginalChecksum:680B16EC5A89E42EA5B8FC9AAF9CDDCE9F9F746DDB00B4538319C8B6514C4106;UpperCasedChecksum:E0B4CF29FCF481C1BB134B79A0494155F70CBC4751C4C8169DCC84DDE4E442D1;SizeAsReceived:7519;Count:46
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [UdqF048vL+lXdtlUKD+PNpTGaTGklpDYjM4nEMVaDZuXAJk8QmPmqHnnO3r+f7OeQxPTn9AlpWA=]
x-microsoft-original-message-id: <20191029152914.GA1920@nicholas-dell-linux>
x-ms-publictraffictype: Email
x-incomingheadercount: 46
x-eopattributedmessage: 0
x-ms-traffictypediagnostic: PU1APC01HT089:
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SEJlXf20pqSuQ2xA3fZwj58hduW706oa4wy0RTAlu2wvO0j8nryn+ijKVUOlfFEqc6btPEHI+2MWSljlJIxXpkBAyU8CW8RTRaBqeSJtwtw06eybHzhy7ASMwBT06bdnVdprgAcK8adqXtWSXL/mRJT/tp85PQLjBCmEjDkOpklHw/djDkqCCMHD2AOM8yiP
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1347E0D099E28F44AFCABF12729230CD@KORP216.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: d642e975-124f-4432-65cb-08d75c84c570
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Oct 2019 15:29:21.7938
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PU1APC01HT089
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
 drivers/pci/setup-bus.c | 23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index fe8b2c715..f8cd54584 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -1814,7 +1814,7 @@ void __init pci_assign_unassigned_resources(void)
 	}
 }
 
-static void extend_bridge_window(struct pci_dev *bridge, struct resource *res,
+static void adjust_bridge_window(struct pci_dev *bridge, struct resource *res,
 				 struct list_head *add_list,
 				 resource_size_t new_size)
 {
@@ -1823,13 +1823,20 @@ static void extend_bridge_window(struct pci_dev *bridge, struct resource *res,
 	if (res->parent)
 		return;
 
-	if (resource_size(res) >= new_size)
-		return;
+	if (new_size > resource_size(res)) {
+		add_size = new_size - resource_size(res);
+		pci_dbg(bridge, "bridge window %pR extended by %pa\n", res,
+			&add_size);
+	} else if (new_size < resource_size(res)) {
+		add_size = resource_size(res) - new_size;
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

