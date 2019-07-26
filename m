Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6B50C766A0
	for <lists+linux-pci@lfdr.de>; Fri, 26 Jul 2019 14:54:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726087AbfGZMy2 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Fri, 26 Jul 2019 08:54:28 -0400
Received: from mail-oln040092254100.outbound.protection.outlook.com ([40.92.254.100]:59136
        "EHLO APC01-PU1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726804AbfGZMy1 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 26 Jul 2019 08:54:27 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k7rpyAvbUY6HZ/ble0l0sDWGOh+XbTGPxfaF31szbEMUWyTlPZcUd6NXqUvpJ+7fkVaX+TDOzv33TtMvRCK2sG4AOTggvGr0K2rmmvBg+53rbu4mKCeFjOvfDvkbNfjPPeuagJ94adbzo375NIv50uFopVl6H3Nk4rqSKpyOgRCK1FaR/0Cf87LG3dCjvakEGQDWwk3gNvIim3CcHkCGa/5BGYRfCa+4KHl/xTP6Z8aZXzH7E7YhnEMdTVO1t4PbDtQ7CpYVi1bTqGzQI/KcxulMVa0qWAWCnzXUlx9GWQzaqFNzjVhGXVhdVuojG6dVbaBTCkHnZM2GuJV/JRWBGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nb8NHon9nvDd2puV86OMdckpekc7biBEMMzhLK9uAAI=;
 b=AJzkH0KcgUxp5Lzg8oapTHKotLlW96qHhEa08MiuUzAXlXxsRzDg9rMgUxME6QbhguT3MXHpjRiCFO8AxBsZ3bWkOmBT61I/wPqbgbWH04pTre5Z6IBxIL85cZwYIImjtBfAUGmG63yQ1MWsE0QVeXXa7P4srEwtVlpmFkzDQJk4prMbTmSsK0SNAttuW5bFmOeCf1dlGwBRIaafZn4HiNk32Md3B4wFEj1sdNMR9Sbc+efhykryQb2MZIReae3sr+16w1Njgd+kHSHmlXEX31uRx97W3I6d08O3vu4/1c8Ck4ISvrbhgkQvNzo4F9Kg+1odSV7ub5Ib1IAyMR9kOw==
ARC-Authentication-Results: i=1; mx.microsoft.com
 1;spf=none;dmarc=none;dkim=none;arc=none
Received: from PU1APC01FT060.eop-APC01.prod.protection.outlook.com
 (10.152.252.58) by PU1APC01HT018.eop-APC01.prod.protection.outlook.com
 (10.152.253.116) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2115.10; Fri, 26 Jul
 2019 12:54:22 +0000
Received: from SL2P216MB0187.KORP216.PROD.OUTLOOK.COM (10.152.252.59) by
 PU1APC01FT060.mail.protection.outlook.com (10.152.253.44) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2115.10 via Frontend Transport; Fri, 26 Jul 2019 12:54:22 +0000
Received: from SL2P216MB0187.KORP216.PROD.OUTLOOK.COM
 ([fe80::1cba:d572:7a30:ff0d]) by SL2P216MB0187.KORP216.PROD.OUTLOOK.COM
 ([fe80::1cba:d572:7a30:ff0d%3]) with mapi id 15.20.2094.013; Fri, 26 Jul 2019
 12:54:22 +0000
From:   Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "mika.westerberg@linux.intel.com" <mika.westerberg@linux.intel.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "benh@kernel.crashing.org" <benh@kernel.crashing.org>,
        "logang@deltatee.com" <logang@deltatee.com>
Subject: [PATCH v8 4/6] PCI: Allow extend_bridge_window() to shrink resource
 if necessary
Thread-Topic: [PATCH v8 4/6] PCI: Allow extend_bridge_window() to shrink
 resource if necessary
Thread-Index: AQHVQ7E/8A75PE+Y1kKWz/bvvpr38w==
Date:   Fri, 26 Jul 2019 12:54:22 +0000
Message-ID: <SL2P216MB01879766498AA7746C2E5FB780C00@SL2P216MB0187.KORP216.PROD.OUTLOOK.COM>
Accept-Language: en-AU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SYBPR01CA0050.ausprd01.prod.outlook.com
 (2603:10c6:10:2::14) To SL2P216MB0187.KORP216.PROD.OUTLOOK.COM
 (2603:1096:100:22::19)
x-incomingtopheadermarker: OriginalChecksum:0BF98D2F95199AD5492D3530791F1F12C8D7A5C8CD5528E1E14ADDBAF722F4BA;UpperCasedChecksum:5CA961ECC6B4819F0035BA4E8A4A569D3347730C49A3CDEDD5D74ECAB91A8D3A;SizeAsReceived:7714;Count:47
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [8Gi7AKNiet3h60lg1J+Zfiqxtk73OmA1CTctgZ3oaltEHytb2z2gbvxKyiqRUBrB7nPWUloD9CM=]
x-microsoft-original-message-id: <20190726125406.GA2708@nicholas-usb>
x-ms-publictraffictype: Email
x-incomingheadercount: 47
x-eopattributedmessage: 0
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(5050001)(7020095)(20181119110)(201702061078)(5061506573)(5061507331)(1603103135)(2017031320274)(2017031323274)(2017031324274)(2017031322404)(1601125500)(1603101475)(1701031045);SRVR:PU1APC01HT018;
x-ms-traffictypediagnostic: PU1APC01HT018:
x-microsoft-antispam-message-info: Oydt2lQ/E9Zs08wiZMGk1+1WzarW8KmozjEwvt16JM7Zrl2n5K4adFRcjjE+FED6m7kTR28pjyzjsEknts3N4/mfz0HYi1rAfFX0qjuOUacQ1/5DZ7px+hshs/sjCxDhBahex/4Cl6Yk4PWE9ZzcBm6jYel8A4l8V+wAK4ADPTdwaFFVAjRbPnsBqqaIYuD+
Content-Type: text/plain; charset="us-ascii"
Content-ID: <7CF825148A086C4A9ABF3A4DBE9745AC@KORP216.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c71fd0a-2d7f-4eee-71b4-08d711c86170
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jul 2019 12:54:22.4573
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PU1APC01HT018
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
index a072781ab..7e1dc892a 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -1823,13 +1823,19 @@ static void extend_bridge_window(struct pci_dev *bridge, struct resource *res,
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
2.22.0

