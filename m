Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0848313CB80
	for <lists+linux-pci@lfdr.de>; Wed, 15 Jan 2020 18:58:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729074AbgAOR6L convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Wed, 15 Jan 2020 12:58:11 -0500
Received: from mail-oln040092255042.outbound.protection.outlook.com ([40.92.255.42]:42240
        "EHLO APC01-HK2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726574AbgAOR6K (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 15 Jan 2020 12:58:10 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B9T+DB4Ni3F5mrwJp9i4VKTEe81i5pHMMML3TwAooJOQIanBmSeGg77hG9NBnH9Ai5kFpTkERFme/P/8PPmHeTyjSj0yw5m+eZv1NrIbJbrooQqoADhfqB8xxdM1PY+gaqEUwsewiIfsXW2sDe5trlX71jpZJ80r7f5QtyeWt1ekYJgXBLa5iCbn4SoBa9qyf2boYZMFSncBzzENo+hwll8HBhgRxeVf7Ybu3MKj+lNwjifBT6iOvltwPnjENQovmA+cB4w8E906V6BVy23QJogIH1qpH3Upl/nJg9ehfN/H5b2QxQgegAPXgQFUfVBO8IE6YsTIauUHsW7hnj9Ycw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jTZHIDttUSLS5LHeRxgppXH/XS/ZolcfcQDNSghrvKM=;
 b=gZ2bmNfh4grBQ5F+xpPoSMN31TuFgz01+f036ueiCu5pE4BNC7Fl2x1EljSbKz9qiCgNOpRrRT+xLJRZy+UmN4MuNhYyuiTtJ3UtEWACGeOK2TYAcRadEXeEvBXsCQQqa+OSK5Y3uNJYy8ssjOMh75eKiiont6o/g2bjllxc7TU2TI85cAjcYMhNu6qSqLbI8U00YyYWy6fcObSpvdoFR5zCYJggjG4GnQWvnaryPz0Vy+9SN9BjJayTfF3R7fBqW9Zpj7hV7Yd115BJ4jLUlJnAd4/tqHHlx1X5t0KmUV+dGfCENpwXTlefV4fqEqeEmo1eiuqz77qth0YEOYc7Pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from PU1APC01FT115.eop-APC01.prod.protection.outlook.com
 (10.152.252.53) by PU1APC01HT223.eop-APC01.prod.protection.outlook.com
 (10.152.252.192) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2602.11; Wed, 15 Jan
 2020 17:58:05 +0000
Received: from PSXP216MB0438.KORP216.PROD.OUTLOOK.COM (10.152.252.57) by
 PU1APC01FT115.mail.protection.outlook.com (10.152.252.208) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2602.11 via Frontend Transport; Wed, 15 Jan 2020 17:58:05 +0000
Received: from PSXP216MB0438.KORP216.PROD.OUTLOOK.COM
 ([fe80::20ad:6646:5bcd:63c9]) by PSXP216MB0438.KORP216.PROD.OUTLOOK.COM
 ([fe80::20ad:6646:5bcd:63c9%11]) with mapi id 15.20.2623.018; Wed, 15 Jan
 2020 17:58:05 +0000
Received: from nicholas-dell-linux (61.69.138.108) by MEXPR01CA0139.ausprd01.prod.outlook.com (2603:10c6:200:2e::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2644.19 via Frontend Transport; Wed, 15 Jan 2020 17:58:03 +0000
From:   Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Logan Gunthorpe <logang@deltatee.com>,
        Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
Subject: [PATCH v2 4/4] PCI: Allow extend_bridge_window() to shrink resource
 if necessary
Thread-Topic: [PATCH v2 4/4] PCI: Allow extend_bridge_window() to shrink
 resource if necessary
Thread-Index: AQHVy81WZ0aY/Rpcq0KYMVH4glqmEQ==
Date:   Wed, 15 Jan 2020 17:58:05 +0000
Message-ID: <PSXP216MB0438DE9E25E07F3915B8E99880370@PSXP216MB0438.KORP216.PROD.OUTLOOK.COM>
Accept-Language: en-AU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MEXPR01CA0139.ausprd01.prod.outlook.com
 (2603:10c6:200:2e::24) To PSXP216MB0438.KORP216.PROD.OUTLOOK.COM
 (2603:1096:300:d::20)
x-incomingtopheadermarker: OriginalChecksum:756F20CC4212D69BCB7AD88E73210CA08FC6953FE0F7CBC6D12E48230490FBCF;UpperCasedChecksum:9DBBA6096AE45A3C91CADFCAF97D76357282033536A95D1D4FC692A21538CDD2;SizeAsReceived:7794;Count:48
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [isfTshrZaUMoGiqt2tK+qf8qWlR7JcNC]
x-microsoft-original-message-id: <20200115175758.GA4526@nicholas-dell-linux>
x-ms-publictraffictype: Email
x-incomingheadercount: 48
x-eopattributedmessage: 0
x-ms-office365-filtering-correlation-id: 9c1637dd-0271-414f-f24a-08d799e478d9
x-ms-exchange-slblob-mailprops: mBy7Mai7yE5NBIk4d/kkaYf19Kf5IaBBWDTNUgNopOAkOjQJjzlAjhv6afDIGsMI3TDXoosU/8nWIBIPe1ZYGNAM7EcMeQCVqcmqMloMKCdjHs9VrT0Ktz4vw13u2mB685eDdd2Y2tNvjnuaKUuRHqPwDNV5mvWELo2qBgUHMZNcV7QYRXoA/fRRx38e7+fiCzncrre5jjGOmF1cUBfxtmVHr2q16TKzVV0T1yUhgdFQxsstmYi6/oLu+DprnIRW2Q5HBUmcJHBjjhqOw6q1HdxNe6gO3jheS2HxtSH7AtVehNpEX96cQcDGZVmOfLDVtUZqnQDfGH38ZYKFWbLe8tC3mjNtKL0U/DXqUdDxJ5dtOd05BBapRspXADbFnu1bqvhr61Uznv38HvWNOQxM74KMC3S9HcEPAhHr/jcE564T0ZijzQhWiLsu/RfdVkmS6L+hpWWITVsHPqd//dFQwJe/7dKY14JWbNt7fERqcP+2Vuy0xo+bPlceqYFht6pPdzrZflv2sox52a3mvEbV8LxKrMbb6Bd65Uh0q7l4tPMytJVBIs07JSK6wukcCMhUBjR2nvR8GiPs6E1QoUm6orKjxJzEtGxZgWT7NVLzRsS/zPr3sLiZwqRusl7vata/dZV1ZeScO18PpH4JVPHdco5+Rwa4raP+A6tDdQWpxjV5/vMf2eD54DS6lNK2M3oYm15a9QoRLu8jMvzgOtk0aA1ddl5JfC6g
x-ms-traffictypediagnostic: PU1APC01HT223:
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zSVERXP9nG5xbFo4f7IvalaEt5KZ/NelxKhFjoI4VwYu6OInlJChAuraikNUUHGvYlA4OHPL7VlRgze9m2vfzntFrOOchK1fRTQYbYKQUfFOu/OPA5ljnS8iCUNA0IARVnm4ojEC6rQAoBqvgCg15G9Xyk/QxeG5PRFKkFXgwO0rPA3Lj+kjHDHm4x+arcFC
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <E58127C42896484F834B46D4DE8BCD89@KORP216.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c1637dd-0271-414f-f24a-08d799e478d9
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jan 2020 17:58:05.8345
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PU1APC01HT223
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

Add check for if bridge is extended or shrunken and reflect that in the
call to pci_dbg().

Do not change resource size if new size is zero (if we have run out of a
bridge window resource) to prevent the PCI resource assignment code from
attempting to assign a zero-sized resource. If this happens, we are
running out of resource space, anyway, so not shrinking the resource
will not deny space for other resources. This prevents the following
from happening:

pcieport 0000:07:04.0: can't enable device: BAR 13 [io  0x1000-0x0fff] not claimed

Signed-off-by: Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
---
 drivers/pci/setup-bus.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index 50d14921a..074501a75 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -1836,16 +1836,24 @@ static void adjust_bridge_window(struct pci_dev *bridge, struct resource *res,
 				 struct list_head *add_list,
 				 resource_size_t new_size)
 {
-	resource_size_t add_size;
+	resource_size_t add_size, size = resource_size(res);
 
 	if (res->parent)
 		return;
 
-	if (resource_size(res) >= new_size)
+	if (!new_size)
 		return;
 
-	add_size = new_size - resource_size(res);
-	pci_dbg(bridge, "bridge window %pR extended by %pa\n", res, &add_size);
+	if (new_size > size) {
+		add_size = new_size - size;
+		pci_dbg(bridge, "bridge window %pR extended by %pa\n", res,
+			&add_size);
+	} else if (new_size < size) {
+		add_size = size - new_size;
+		pci_dbg(bridge, "bridge window %pR shrunken by %pa\n", res,
+			&add_size);
+	}
+
 	res->end = res->start + new_size - 1;
 	remove_from_list(add_list, res);
 }
-- 
2.25.0

