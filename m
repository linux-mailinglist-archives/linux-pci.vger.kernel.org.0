Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D588613CB7B
	for <lists+linux-pci@lfdr.de>; Wed, 15 Jan 2020 18:57:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728928AbgAOR5c convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Wed, 15 Jan 2020 12:57:32 -0500
Received: from mail-oln040092254067.outbound.protection.outlook.com ([40.92.254.67]:19728
        "EHLO APC01-PU1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726574AbgAOR5c (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 15 Jan 2020 12:57:32 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oezkU968Xj9Z4i+cy6tWEMWFtD295kb4fK6QRSEfgzyHvpe8p4lr+Tnoyj6mP5+r4C1neXUo04YQCaLE9e3w1uUQUR+wRG6+6STxvR7cqxn3YrWIBWZK6iEkSWkfZz4VbicRyyXCAusd/oJHenfW+5ikjbnLjf1IiUKI7H0fA/5ZyF78lGpIqniZIh9HTzlJ+1xr6oZLLe27ljjQtjmLtAkMnvr6Tzus6eNXs52Y04YoPZxUP+9Q+bdnc+RS5ZmFrFErgLkORTL6zHNE9jRPAeTMdsRB/50bKR9atZ9fMvt3HLn8Mkw09SWdlAvrQ9TzvBEqK/dPQBjBaLmh5OUJWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jk8iequVcjwgf3IHaHX3qvYpYUKdqFIydC16GtDRZ/8=;
 b=U2OG1OH9gIUIXGfZqmoRO/NWRV/Lfx3wEtTJQDrlj26UCAzQc1+tpLuyoA0Mn/v9N1gATmuTlOeJ26C/SBIl6W08BDmbHWRyD5n46An2s55BY/DdOrS7QYZDdTg50aGgqZu4cqRGwXlkUYhMTJfS35lgJQHeJ7hiTcp7a1m7wVcBGMiJss66XDX2uQ9NUhID9cMNhBXp3J0SwQA529iZgfmMZIPOe+PBnaw/vrubvtUxHuCUDIySMUJwH+wmjuqlnYkZFW3wM6fFhmbPmkwrlhvZKxZ4lw5s9Q8qNcwKVoghoqCnYmpr1qasNrxSjOcnvKvuRESCA5d4OjHfdUj2zQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from PU1APC01FT115.eop-APC01.prod.protection.outlook.com
 (10.152.252.58) by PU1APC01HT147.eop-APC01.prod.protection.outlook.com
 (10.152.252.200) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2602.11; Wed, 15 Jan
 2020 17:57:28 +0000
Received: from PSXP216MB0438.KORP216.PROD.OUTLOOK.COM (10.152.252.57) by
 PU1APC01FT115.mail.protection.outlook.com (10.152.252.208) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2602.11 via Frontend Transport; Wed, 15 Jan 2020 17:57:28 +0000
Received: from PSXP216MB0438.KORP216.PROD.OUTLOOK.COM
 ([fe80::20ad:6646:5bcd:63c9]) by PSXP216MB0438.KORP216.PROD.OUTLOOK.COM
 ([fe80::20ad:6646:5bcd:63c9%11]) with mapi id 15.20.2623.018; Wed, 15 Jan
 2020 17:57:28 +0000
Received: from nicholas-dell-linux (61.69.138.108) by ME2PR01CA0078.ausprd01.prod.outlook.com (2603:10c6:201:2d::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2644.18 via Frontend Transport; Wed, 15 Jan 2020 17:57:26 +0000
From:   Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Logan Gunthorpe <logang@deltatee.com>,
        Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
Subject: [PATCH v2 2/4] PCI: Rename extend_bridge_window() to
 adjust_bridge_window()
Thread-Topic: [PATCH v2 2/4] PCI: Rename extend_bridge_window() to
 adjust_bridge_window()
Thread-Index: AQHVy81AmdiPe5xhakqgfeJglwMu5A==
Date:   Wed, 15 Jan 2020 17:57:28 +0000
Message-ID: <PSXP216MB043888DE03EEF8342941B76A80370@PSXP216MB0438.KORP216.PROD.OUTLOOK.COM>
Accept-Language: en-AU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: ME2PR01CA0078.ausprd01.prod.outlook.com
 (2603:10c6:201:2d::18) To PSXP216MB0438.KORP216.PROD.OUTLOOK.COM
 (2603:1096:300:d::20)
x-incomingtopheadermarker: OriginalChecksum:DB4AA6AA804CD425C6F9B34934239CA01C47A7474E9627C457D9A799850E8E56;UpperCasedChecksum:048863291DD1A2EE09D935D23EE459C756E6157EB1AA943B3394C6EC696225F9;SizeAsReceived:7785;Count:48
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [lTpnRkEmm9kjBDzZdJqQo3MGMwOKkt+r]
x-microsoft-original-message-id: <20200115175721.GA4519@nicholas-dell-linux>
x-ms-publictraffictype: Email
x-incomingheadercount: 48
x-eopattributedmessage: 0
x-ms-office365-filtering-correlation-id: f516d5c0-338c-497f-8f28-08d799e462a5
x-ms-exchange-slblob-mailprops: mBy7Mai7yE5NBIk4d/kkaYf19Kf5IaBBdgtO/F9AM/6n7rQwsnH13OQa3Beer+3kRezTDPhhxyCjb2vg3hpZJErDV2eFFg/Tn6eXsP5JQ79rep0aLb6wC8b7jLpmvxbcabg05crLEJCBLvJfWyIoVIoX0BDYXUbx0GHSW+n8+LEDUUOdM2EHVcwKUDsG9B1QzcKsmItpaKDiwXoE7rkC3aJJ+VKumjIemZKtRyEXHR1QVmBp7RQIlPlhKVVPQY17EvIuKT8xtSGjyQUrBD2VzDoUpmvlxqhaI2rzIqkbG1lQfUCXahL9lChFr911yC3VtYRtV+hPQkRxRorYXYwoRHMHEoS2Eg2ub252ZEOanXrycLcNsND5NJp7ggB8jxUL2q2GAfbs3L6YSfUHP63xbiFuLdjy8yNmAF0OcC1fUtU5LcmrmbyUQy1VVOHYIRf7h6QoKnmeQxUd0X/+JBvHUwo/fFOqI2vSZWzmJKH/M2/GoKDGIOKRwmLTI4aXNJgikWqKDPiObBSEs5LuuU4hjFpbz63qLxSOIVzOnSn8pUAueqMh3qS+ClkMy0XeYPieda/8cA+emP5w0nqrPs/04UKRVwl77J12ak02/F5UQgyZnUwgajh0A99S9qnSPwzvC/3DAN4/jR8era52+xpIYutxqxge7cchfmKcn5lhLYlZ09Z8a7GBb2N67JvfOK5w3/b2RrpmrZm94lCJRR16SANOXgHAlLdU
x-ms-traffictypediagnostic: PU1APC01HT147:
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cuyQpbgFSvS+Tmh0XTByn9zTyaqvWbr4T9C9uZO/DdpbGW6+7TkPvnf9WObnA/u+9PUsEysvGdz6IPoQmUkhKjLh01g5nQqX4VCG6gS06DMlHUy9XesPRoEHLaaVV6MRR1R6uv8ggbfmbcV1tx2KgjbAidAX3SrUppk1KNn4DF5/DOm3fb7uOHgm8TSVObJg
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <53B6607E615FEA49B08376CD06612EEC@KORP216.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: f516d5c0-338c-497f-8f28-08d799e462a5
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jan 2020 17:57:28.5693
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PU1APC01HT147
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Rename extend_bridge_window() to adjust_bridge_window() to prepare for
the fact that the window will be able to shrink.

No functional changes.

Signed-off-by: Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/pci/setup-bus.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index ed5055ef7..de43815be 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -1832,7 +1832,7 @@ void __init pci_assign_unassigned_resources(void)
 	}
 }
 
-static void extend_bridge_window(struct pci_dev *bridge, struct resource *res,
+static void adjust_bridge_window(struct pci_dev *bridge, struct resource *res,
 				 struct list_head *add_list,
 				 resource_size_t new_size)
 {
@@ -1895,9 +1895,9 @@ static void pci_bus_distribute_available_resources(struct pci_bus *bus,
 	 * calculated in __pci_bus_size_bridges() which covers all the
 	 * devices currently connected to the port and below.
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
2.25.0

