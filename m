Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9AC06FB1E4
	for <lists+linux-pci@lfdr.de>; Wed, 13 Nov 2019 14:57:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727504AbfKMN5X convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Wed, 13 Nov 2019 08:57:23 -0500
Received: from mail-oln040092254097.outbound.protection.outlook.com ([40.92.254.97]:60976
        "EHLO APC01-PU1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726190AbfKMN5X (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 13 Nov 2019 08:57:23 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TiCL7JRsur7zoTMTRS/BL2Fg6ysmTn2F2mJxUiQK1RyAEYgBP7fGcs8RYfff6aYMiWSmQNRCWhx6XyTWh8G9ks1PkYTLjVGswL3hTRiSlSlnHDuMniv6+y4bby+yzO2dTXywP6vGkqMlTE43IUPNoi1TBKMghPQXPT9iDKyehnj1334MarTFPNhQZMRnKUJGDIHZXbPorfglwJPcC8JGbmEdoAEUXki4QX26UV/EKjabyGLpUB5lRuu5HSj90wF1uang5bxSsOw1oXcphFIaYn0O1xG9LZYDYz/eDCtL66dke6zHDh3v0NJ8hHFGw95p6kHxltVEmFUG83BdYqkngw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HYK4AJq2wVyOdrQ6YBlPBFYX/XCDfpNvP+ELcOZprcU=;
 b=b1yUZPSQk/b6PHFqQtcuUl/v8n5bbU4oOm+k+2zQsgVB8bxpyRUeBsg5sn6PSvEnPZqgY7e24tbz4zjxPVxxXcb1xUIYHD8ftFD7uKI4mSHQtgMgR2YgKTVcMPvnotayPM60oiyteVr8402kVyNXnqCKIisUo/ZhrfFdF07ozzqtNRFLp5XUTgGwDkGtzHQAJy7OCYipEfn2K9UxT5dGQv4NrMBzJpzjHZ/sNYoq2F4Ts2dNY/+wdd36wLWwu7VeZmZE1Fa8IJW3wMGaAraqtQlywx95CNSDOFgTvcme6vrUndRcj4z7TZ0Vd5JPkbFiRPtUyp3MnIGLabR9zBTB8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from PU1APC01FT035.eop-APC01.prod.protection.outlook.com
 (10.152.252.54) by PU1APC01HT222.eop-APC01.prod.protection.outlook.com
 (10.152.252.163) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2430.22; Wed, 13 Nov
 2019 13:57:18 +0000
Received: from PS2P216MB0755.KORP216.PROD.OUTLOOK.COM (10.152.252.57) by
 PU1APC01FT035.mail.protection.outlook.com (10.152.252.214) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2451.23 via Frontend Transport; Wed, 13 Nov 2019 13:57:18 +0000
Received: from PS2P216MB0755.KORP216.PROD.OUTLOOK.COM
 ([fe80::44f5:f4bb:1601:2602]) by PS2P216MB0755.KORP216.PROD.OUTLOOK.COM
 ([fe80::44f5:f4bb:1601:2602%9]) with mapi id 15.20.2451.023; Wed, 13 Nov 2019
 13:57:18 +0000
From:   Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "mika.westerberg@linux.intel.com" <mika.westerberg@linux.intel.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "benh@kernel.crashing.org" <benh@kernel.crashing.org>,
        "logang@deltatee.com" <logang@deltatee.com>,
        Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
Subject: [PATCH v9 3/4] PCI: Change extend_bridge_window() to set resource
 size directly
Thread-Topic: [PATCH v9 3/4] PCI: Change extend_bridge_window() to set
 resource size directly
Thread-Index: AQHVmipDV6eC7pwnA0uzrURncVQLew==
Date:   Wed, 13 Nov 2019 13:57:18 +0000
Message-ID: <PS2P216MB07557D53F7621520BDFA582F80760@PS2P216MB0755.KORP216.PROD.OUTLOOK.COM>
Accept-Language: en-AU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SYBPR01CA0198.ausprd01.prod.outlook.com
 (2603:10c6:10:16::18) To PS2P216MB0755.KORP216.PROD.OUTLOOK.COM
 (2603:1096:300:1c::13)
x-incomingtopheadermarker: OriginalChecksum:418D55EF9DA2B97880F9FD6EF04FA1104D40CFE7061EC3F8BE00EC5B240CAB75;UpperCasedChecksum:0DB9C8F9DD6CFCB9133B6CED923B620A936ACCF4BA8BE2854E2B18E235801871;SizeAsReceived:7679;Count:47
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [NlEcxp3pOd9B9pAVgewh+JpuDmWmXugCbhvRkVF0pPRnLH9LUMuW9n9zGAWDlkF+lIQwdyWG0wk=]
x-microsoft-original-message-id: <20191113135710.GA3224@nicholas-dell-linux>
x-ms-publictraffictype: Email
x-incomingheadercount: 47
x-eopattributedmessage: 0
x-ms-office365-filtering-correlation-id: 724d73c3-f127-449a-b1c8-08d768416585
x-ms-exchange-slblob-mailprops: dEG5jEBie8mlFL0Oe7sWpdK/rFF0vM+sWL1qRZrZy26tb4PZdKegNw3NbXdJZ2dVjtIDyV3R1DNVPVDikMwFk/AMW1AsVzYEK/kugPDzdBtEKHCQ0vraFuc6Ppo6MWt58XiygU5cV3OGnNFx9XGNc2AXqgeRikjG9WqBndni2PCVQLbLHzzeg0pgixRaB7O+D2Sx12e8hYsxoR2zJbwvRojA0W44TRfXMXRIVDfj6aoZ5zNY7MfEmSt/mZADXYZ4NP+60GeU8COZoQ9PfwHC7QnPR2uCMVDb+N3E6ykhBipl5viiavzcN7g3032gh7bp0MTNUNwgL8CktbojfBXioFWTcySI4E5zekrWIIsxhPH+bh1XgAvDgJrzHSpEVBEoz0x8yniT6IT3EsGyhL9q76mtK0BfqdmhpE4vSFx3OPlQhc1FlPAdSC1PQJaUqo8bvzjNZbtli6jGamwWBplluPDJCadHv16Z5/TGjojk4Gr9plrCxCGS1JOH0ggAk+VoC+z7Jwvsgtpz7f1MU5jhi+QlRcnKNymuiy+JOU2eZoERyX/bS4SbRv09l3UXqr253fLyCONLgChQqD5Me6pEpcDFvKpFhdqmKTN4CqsROGvpSlVAF9F4TjTk8Hovx3YmirbPtghLBcvrsWKTjamOTVUyKydKxcxbCRyNPTPdH8k0u1r2mnHk5Q==
x-ms-traffictypediagnostic: PU1APC01HT222:
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: I/RgUYNfOJnVA98S8qgaT5v7R/WNtEiJRAotre8adDG/LgA6paGBrl6O2Z9Mt44HqbKn+h4P2xdbrn4mrY03bgm4pOpoGW3En5BRmSe1LrHBtPqofZKQxVOBWTEzP4SKK50YV40mIpD8mEZC0sMbVo1lHEP4yBbRgmls/0gPcmf7halFfVFYKnABx9ALHqzp
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <AA404F1EE0CC284B998AF3418BE845A6@KORP216.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 724d73c3-f127-449a-b1c8-08d768416585
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Nov 2019 13:57:18.4396
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PU1APC01HT222
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

