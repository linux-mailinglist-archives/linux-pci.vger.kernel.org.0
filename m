Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0AB6C13150A
	for <lists+linux-pci@lfdr.de>; Mon,  6 Jan 2020 16:45:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726591AbgAFPpi convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Mon, 6 Jan 2020 10:45:38 -0500
Received: from mail-oln040092254109.outbound.protection.outlook.com ([40.92.254.109]:2638
        "EHLO APC01-PU1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726296AbgAFPph (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 6 Jan 2020 10:45:37 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nrsCgU35frpIA+lszIlqtUko7hSmrpQ+MokRN7QNj1kdZx/c2SVWx2N30hH/T4XfE3rLE5+H48WkgjY9Zr1xEsaPReYR1S2e5vcGb4+Fu0dNRvmAqGF5Hd05z7RrVfPjIQwavMtPBorEnWTbCifxHZ4WM832gXwDdE5fLbc6nlQREZJFH5IfgldTj7h1648wCKLuQQZ9hO09xC3gVr1Eu+s4fSUKBOpVFgoAUkycBBnM/qt1S3hoSTNqpcOx7JfJ0Ewt2TJssUDgw9Hcaz/1b5ih/pSNqjw1y+pyTSPk0aOQHSjORy3e/QIgIeT01ixwBi9ufdz7xrKV1vBf1TmwWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qll2JzBTnXF0EZolmMK56HPm9NgBVWCoCbr6KnMdJ+M=;
 b=algNlPn0CmBVq2iTOfLrqM5njNWKPaZJWTj+D4kdlMK+ScRuIZHyTPJjvhskqCGnq2YfZKh8pX4PgYwjSmtF4oirBpGHS77q19pD9Us/xp8K2PGx+55XylaoGOh7h5Q0Pkyoxiw8xqUHX1zwc3USpiqJyGeBRCq+6GYczowFqQHeF8w9lnMu5idPegdiIUHfYty1O9Uhgl+BPAXPnvCUkcFQcpGasAUH6G7RDKb9icoUhUmRd6mF1H2cWGbONZUsXxcqgBxHlf6gZoNq1gOzAJScS+iRUR3taXFTBoBNRsR9sm9I72Ii3FgJxQnxvNhNWAFz/Wd0EPpdvXfsSRwTvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from PU1APC01FT027.eop-APC01.prod.protection.outlook.com
 (10.152.252.51) by PU1APC01HT009.eop-APC01.prod.protection.outlook.com
 (10.152.252.112) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2602.11; Mon, 6 Jan
 2020 15:45:32 +0000
Received: from PSXP216MB0438.KORP216.PROD.OUTLOOK.COM (10.152.252.59) by
 PU1APC01FT027.mail.protection.outlook.com (10.152.252.232) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2602.11 via Frontend Transport; Mon, 6 Jan 2020 15:45:32 +0000
Received: from PSXP216MB0438.KORP216.PROD.OUTLOOK.COM
 ([fe80::20ad:6646:5bcd:63c9]) by PSXP216MB0438.KORP216.PROD.OUTLOOK.COM
 ([fe80::20ad:6646:5bcd:63c9%11]) with mapi id 15.20.2602.016; Mon, 6 Jan 2020
 15:45:32 +0000
Received: from nicholas-dell-linux (49.196.2.242) by MEAPR01CA0092.ausprd01.prod.outlook.com (2603:10c6:220:35::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2602.12 via Frontend Transport; Mon, 6 Jan 2020 15:45:30 +0000
From:   Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Logan Gunthorpe <logang@deltatee.com>,
        Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
Subject: [PATCH v1 1/3] PCI: Remove redundant brackets in
 pci_bus_distribute_available_resources()
Thread-Topic: [PATCH v1 1/3] PCI: Remove redundant brackets in
 pci_bus_distribute_available_resources()
Thread-Index: AQHVxKhUT8/0iYCqxkuDyLHim6kzqQ==
Date:   Mon, 6 Jan 2020 15:45:32 +0000
Message-ID: <PSXP216MB0438061CB4442460BB92A75F803C0@PSXP216MB0438.KORP216.PROD.OUTLOOK.COM>
Accept-Language: en-AU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MEAPR01CA0092.ausprd01.prod.outlook.com
 (2603:10c6:220:35::32) To PSXP216MB0438.KORP216.PROD.OUTLOOK.COM
 (2603:1096:300:d::20)
x-incomingtopheadermarker: OriginalChecksum:2E185999288EE336AB765BBE589BB2B2C481D1F25E8B64E1922BBD5E173C0219;UpperCasedChecksum:F30152746974F19AFFEE9F1CE03A725CFBD1FF3F3889E4F4D813ED4DE4AA129D;SizeAsReceived:7822;Count:48
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [bemAALPW+lEirn/fq9w5JnrnBt3UgSoY]
x-microsoft-original-message-id: <20200106154524.GA2540@nicholas-dell-linux>
x-ms-publictraffictype: Email
x-incomingheadercount: 48
x-eopattributedmessage: 0
x-ms-office365-filtering-correlation-id: 9336f560-85eb-4650-a534-08d792bf7686
x-ms-exchange-slblob-mailprops: kw4jv30d2yRiAyZ79I75z3iAEkaGCr1oZQjjzDwqzrb4BvoUZKlKYWMlOoMfSOC38m5myFnXUAc8yyRlgkFzuzMgMvtv3i8daQrnTNv/Mg7lo4iMdmSmj8D2TXjDNjLgTpV5AAf8Jbqpi+YtVlPC9lvHQVbSv+4Zuplbzjv5Ru5Ngk/VjRba+x0RdpTzCHW+DSfICUHUsfDu2XqeNfwqn+OS6gMaVZllZFDsTGxY/JWhPJXh9j1i8IvVnUUaW5vCRISGUSztumjx+KA4DhKkO+wiHRxvEQeG4m0hkfr3O395BfMHNi9ClM0kvKICSayJz5zK+iDdh66u/kKqk6MaC47+iNwC2wMRPXSmi6Pv7jeQd23ufSwziNPCnCPRXucUQf1Z3ZjdbmSwrOzA/hWI/h7GP3WD9pVKjn7uDdiomWXYs3r1eOiIxhX7dJH2HTDM8Nky+pi6riYKI92hxTSMqkwqkXQvKDsFlHuFxrMGLj8sUs5aZ3EPMqhrNGzWggI6J3xM9SzFykx+d8BtcUiMYc7jRCV5AXcIMWzNEKeFuzRWgNZzFJZrFUt45ZG0JtXLKcrR8RcI7AZxoim5IjeKg/dt6IjA4p1eJdd9iXgWscZzccjIcOTEnIRClTAqi9pRLNwErMhD0BDdFr/lEKtaDigulIGmixYuUZg7o6Bw2lo=
x-ms-traffictypediagnostic: PU1APC01HT009:
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xFRcxGINObKsy5D5ZB3ssLfsl9JMj8pu1J+vX4sGHEU6mGBfmOaEuNlm3SQSmlz+usXPhda0l0/WYLXMG+tpkrSZQEvGGQ+NMj3dVgrm+9OX3hzhRP4PXYDai+Jv+PfNrcl7dKcAFQDwVJII6hig40ETA7zCvrWC46jr65YnpyJ4C4xwKTIjb7f4tLV7Riqz
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <E2BD7E832C612F43B855E70689D225BA@KORP216.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 9336f560-85eb-4650-a534-08d792bf7686
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jan 2020 15:45:32.4407
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PU1APC01HT009
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Remove redundant brackets in pci_bus_distribute_available_resources().

No functional changes.

Signed-off-by: Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
---
 drivers/pci/setup-bus.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index f27982620..465a8b565 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -1902,11 +1902,10 @@ static void pci_bus_distribute_available_resources(struct pci_bus *bus,
 	 */
 	if (hotplug_bridges + normal_bridges == 1) {
 		dev = list_first_entry(&bus->devices, struct pci_dev, bus_list);
-		if (dev->subordinate) {
+		if (dev->subordinate)
 			pci_bus_distribute_available_resources(dev->subordinate,
 				add_list, available_io, available_mmio,
 				available_mmio_pref);
-		}
 		return;
 	}
 
-- 
2.24.1

