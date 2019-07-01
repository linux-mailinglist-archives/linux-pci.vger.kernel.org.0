Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 62EF15BE1A
	for <lists+linux-pci@lfdr.de>; Mon,  1 Jul 2019 16:23:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729535AbfGAOXg convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Mon, 1 Jul 2019 10:23:36 -0400
Received: from mail-oln040092254109.outbound.protection.outlook.com ([40.92.254.109]:14571
        "EHLO APC01-PU1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728129AbfGAOXg (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 1 Jul 2019 10:23:36 -0400
Received: from PU1APC01FT027.eop-APC01.prod.protection.outlook.com
 (10.152.252.57) by PU1APC01HT089.eop-APC01.prod.protection.outlook.com
 (10.152.253.102) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2032.15; Mon, 1 Jul
 2019 14:23:32 +0000
Received: from SL2P216MB0187.KORP216.PROD.OUTLOOK.COM (10.152.252.60) by
 PU1APC01FT027.mail.protection.outlook.com (10.152.252.232) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2032.15 via Frontend Transport; Mon, 1 Jul 2019 14:23:32 +0000
Received: from SL2P216MB0187.KORP216.PROD.OUTLOOK.COM
 ([fe80::9d2d:391f:5f49:c806]) by SL2P216MB0187.KORP216.PROD.OUTLOOK.COM
 ([fe80::9d2d:391f:5f49:c806%6]) with mapi id 15.20.2032.019; Mon, 1 Jul 2019
 14:23:32 +0000
From:   Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "mika.westerberg@linux.intel.com" <mika.westerberg@linux.intel.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "benh@kernel.crashing.org" <benh@kernel.crashing.org>,
        "logang@deltatee.com" <logang@deltatee.com>
Subject: [PATCH v7 2/8] PCI: Skip resource distribution when no hotplug
 bridges
Thread-Topic: [PATCH v7 2/8] PCI: Skip resource distribution when no hotplug
 bridges
Thread-Index: AQHVMBiP5bDg6T7Bu0SPG+HDJyh4Cw==
Date:   Mon, 1 Jul 2019 14:23:32 +0000
Message-ID: <SL2P216MB0187E00E76AA8F503DE5045C80F90@SL2P216MB0187.KORP216.PROD.OUTLOOK.COM>
Accept-Language: en-AU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SYBPR01CA0182.ausprd01.prod.outlook.com
 (2603:10c6:10:52::26) To SL2P216MB0187.KORP216.PROD.OUTLOOK.COM
 (2603:1096:100:22::19)
x-incomingtopheadermarker: OriginalChecksum:7E4747C3D9BF8D3B8D4313F0B691BF67281AFE05A8C03827655A689AE334C134;UpperCasedChecksum:9E143170F26BA325A71C9F50700EB9153257DCE0AAF7BA0944A9B49B30E053F5;SizeAsReceived:7696;Count:47
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [QNw58P8eezGIQg1bREdWRCZcMV+0/IjsjvUvREBKuWdRTNv/ODR0hNWoMttjATb64hXHXluKyfg=]
x-microsoft-original-message-id: <20190701142316.GA5201@nicholas-usb>
x-ms-publictraffictype: Email
x-incomingheadercount: 47
x-eopattributedmessage: 0
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(5050001)(7020095)(20181119110)(201702061078)(5061506573)(5061507331)(1603103135)(2017031320274)(2017031322404)(2017031323274)(2017031324274)(1601125500)(1603101475)(1701031045);SRVR:PU1APC01HT089;
x-ms-traffictypediagnostic: PU1APC01HT089:
x-microsoft-antispam-message-info: YuQZyMB/0v1jQQihjQLw6sHpnD8+3F50hZtAfGQendM2yXCxgnjRXH8GL+29tzKhgxQEC20Q/EnEG8gT8F755DWeJVHklqFH8GbA9IyhVBnai+gSZ3vtF+iNkFKhgHYURVoH3Lfnj0ssdBZNaMXLbkyynElUn8zjRmgFhtwtvmCJTbDMIdYKDXup/iwjS+We
Content-Type: text/plain; charset="us-ascii"
Content-ID: <7E2897BBBFD585449B559074D51FAD9A@KORP216.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: a3b34ab7-6744-4208-039f-08d6fe2fb1d7
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jul 2019 14:23:32.3292
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PU1APC01HT089
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

If "hotplug_bridges == 0", "!dev->is_hotplug_bridge" is always true, so the
loop that divides the remaining resources among hotplug-capable bridges
does nothing.

Check for "hotplug_bridges == 0" earlier, so we don't even have to compute
the amount of remaining resources.  No functional change intended.

Signed-off-by: Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
---
 drivers/pci/setup-bus.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index af28af898..04adeebe8 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -1887,6 +1887,9 @@ static void pci_bus_distribute_available_resources(struct pci_bus *bus,
 		return;
 	}
 
+	if (hotplug_bridges == 0)
+		return;
+
 	/*
 	 * Calculate the total amount of extra resource space we can
 	 * pass to bridges below this one.  This is basically the
@@ -1936,8 +1939,6 @@ static void pci_bus_distribute_available_resources(struct pci_bus *bus,
 		 * Distribute available extra resources equally between
 		 * hotplug-capable downstream ports taking alignment into
 		 * account.
-		 *
-		 * Here hotplug_bridges is always != 0.
 		 */
 		align = pci_resource_alignment(bridge, io_res);
 		io = div64_ul(available_io, hotplug_bridges);
-- 
2.20.1

