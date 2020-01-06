Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3CEFD13151D
	for <lists+linux-pci@lfdr.de>; Mon,  6 Jan 2020 16:48:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726478AbgAFPsK convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Mon, 6 Jan 2020 10:48:10 -0500
Received: from mail-oln040092254014.outbound.protection.outlook.com ([40.92.254.14]:15344
        "EHLO APC01-PU1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726636AbgAFPsK (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 6 Jan 2020 10:48:10 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mppfyAuh0QtDTh+HMIGJYQ6R9Fp6mrv7iWjFaxvkoogtW+oRX+zgH3LYCKh6QKuXhmCo2TWLdQw1z4YuqzlNvd0Ap81GzV7UgHnESE4I/YVzaDRrtRIEIc5A1Pp5vDhOPpcHK9xQCBW0T3pJq6zhbYl8GBQ6uSU3BoQyl6ZaGByaPj9c/JzfR371RFf9VlRfUld2pQGYUjew0D7Hxzw1+uo3xyzb8gAqT6Rc7KH7EJ2fBxlSP6rOJXZBcjhdmMC312ku+5r8UQ8TdLcNcunWtec5ymL932JJ5WDvQshdw1F8sTqNBBsIHnaPhQoUiq/Pyik6FYcXvWqw5vRbbPP20w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oU0QJ+nQVpoWeffN3MeVHtTHRAdUp3onbfgKuUchiYA=;
 b=jtv4BoC/p+mw9YBrbmlbxFMSxbSWHiGEcM5QVr5NG5eyBVgG8SgBEM7SU+xibgZrMg5e4YnB5d0K9vKuInJuj3unYVUJOk2amPRr7ApRsvsI8JUeetmzHHYKEryuTEgGHFyz7tGKJHT064cms1SABgxJGsEERt+a+NELjD0rXJ24UY2UbWN9zOQJ7L+90AgZ2mhtHIjk5zP9DQot7rPPRBklQBLvEyTUETgtSNgnYaKjSyQObPltbjFTPhSz/gXjZezZmq4bDDP93SGEoPp0IkzSrfBPcdLl2xDDZAk61Llek2R3+LSO4KPx8IznhOuoGZwOEIfKM1KjZ4eDRQRqig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from PU1APC01FT027.eop-APC01.prod.protection.outlook.com
 (10.152.252.53) by PU1APC01HT146.eop-APC01.prod.protection.outlook.com
 (10.152.253.169) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2602.11; Mon, 6 Jan
 2020 15:48:06 +0000
Received: from PSXP216MB0438.KORP216.PROD.OUTLOOK.COM (10.152.252.59) by
 PU1APC01FT027.mail.protection.outlook.com (10.152.252.232) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2602.11 via Frontend Transport; Mon, 6 Jan 2020 15:48:06 +0000
Received: from PSXP216MB0438.KORP216.PROD.OUTLOOK.COM
 ([fe80::20ad:6646:5bcd:63c9]) by PSXP216MB0438.KORP216.PROD.OUTLOOK.COM
 ([fe80::20ad:6646:5bcd:63c9%11]) with mapi id 15.20.2602.016; Mon, 6 Jan 2020
 15:48:06 +0000
Received: from nicholas-dell-linux (49.196.2.242) by MEXPR01CA0135.ausprd01.prod.outlook.com (2603:10c6:200:2e::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2602.10 via Frontend Transport; Mon, 6 Jan 2020 15:48:03 +0000
From:   Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Logan Gunthorpe <logang@deltatee.com>,
        Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
Subject: [PATCH v1 4/4] PCI: Allow extend_bridge_window() to shrink resource
 if necessary
Thread-Topic: [PATCH v1 4/4] PCI: Allow extend_bridge_window() to shrink
 resource if necessary
Thread-Index: AQHVxKivCsNYvp642Ua95PoPKOxpRw==
Date:   Mon, 6 Jan 2020 15:48:06 +0000
Message-ID: <PSXP216MB0438D3E2CFE64EBAA32AF691803C0@PSXP216MB0438.KORP216.PROD.OUTLOOK.COM>
Accept-Language: en-AU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MEXPR01CA0135.ausprd01.prod.outlook.com
 (2603:10c6:200:2e::20) To PSXP216MB0438.KORP216.PROD.OUTLOOK.COM
 (2603:1096:300:d::20)
x-incomingtopheadermarker: OriginalChecksum:E117D3158B37EB762019E2F9F3BC2778D0A69B659A9CFF349BBD4C2781FE19C0;UpperCasedChecksum:76DF33309F7046977D84305125BDD685200E8294B1145247B3098C0E942C4811;SizeAsReceived:7789;Count:48
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [YumsE+2F3fePCaKAI0HGtJwIKlCshVHJ]
x-microsoft-original-message-id: <20200106154758.GA2561@nicholas-dell-linux>
x-ms-publictraffictype: Email
x-incomingheadercount: 48
x-eopattributedmessage: 0
x-ms-office365-filtering-correlation-id: f95d2363-9788-46d3-d17b-08d792bfd222
x-ms-exchange-slblob-mailprops: mBy7Mai7yE6pvqwJQ6Mx8ls6+U3+cSxqRl4Pv7axpQA1J9/IVsYCYZkN2PCFNMW5ukL0hJQ2gikaHRQ7T/cDFTX7DjS4gvof4bH/2EghGGk3T0SwyLokeTFZc41yB4ImgR1yjQ7+CUy3y9JeMrn/9MQCEhJb5n6swPieqBWJVn6xbWxCsyq8ZKqT88lAP+zN4Wmk2JyfYmj66QWQKASYWGuoMcp/zBAO55O15cYlGyLj+iPoMKKCME1NncgR0hE2Um9Fr3OLR+DhQ4T1M7mx5+OuWmuKaqwJ0bpGjnN+PYXwvUJ8S05UYpEMYFCy4p9fXPREYweLUJwUyB8wmokd+Co8cEciyPbBRCOH8bsXmgvh0j4VHfry/AsZEhe6/5T3WTuHho4YSkfYjxN8dtKv5ZGoWiWINNF7p93MCbzrji4Lz+2znMoShlI9SvMoe/R62xE6Jwcs2Cf/teQU/yXFwtyNOg9hU04PqAJT1mhAU1xXr6kNri0WK6MOx17Jv7H92eGzGyxVeCOdl8QpOU9E6P8cJ1pC3lqRa1uscNDgAL38dyOXykpNd88m9Zi6DBWXoOSUazATjsCT+dHgAYdqZmVfV4b72cZ2eGCDLb8WSqpTyXvp9708Z6MgxLcAVmxRgxxCtyuNTdHRMFouuK4AlAHzwAVBuy4YsF002UZKO2TMQ/q05DqHh8pwjz1KYvwPdKF51OhtyD7Nc8ZqhvQ7VnqTM/q18Axa
x-ms-traffictypediagnostic: PU1APC01HT146:
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: f0tKylp45PIrtMC77O3fvLZf5LJsdw5hyucdMBS+/uSRVMdAOSdaIoWdYPDhL9flerAWTwBkpgHO0zpVEQEHbMKkpeKebx929Gu/02W3PK4BScMiLCgjCseyuNkV0/rRQog4Dy8o5dgASxKbvkZfpHMUL+btBPbis0k3Br6dASu6dduaxZq4NCGv33sr6psI
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <D95F467736CEAB4E8530183F940E9AA8@KORP216.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: f95d2363-9788-46d3-d17b-08d792bfd222
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jan 2020 15:48:06.1429
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PU1APC01HT146
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

Reset the resource if its new size is zero (if we have run out of a
bridge window resource) to prevent the PCI resource assignment code from
attempting to assign a zero-sized resource.

Signed-off-by: Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
---
 drivers/pci/setup-bus.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index 0c51f4937..e7e57bf72 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -1836,18 +1836,25 @@ static void adjust_bridge_window(struct pci_dev *bridge, struct resource *res,
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
-- 
2.24.1

